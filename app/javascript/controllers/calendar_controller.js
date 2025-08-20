import { Controller } from "@hotwired/stimulus"
import { Calendar } from "fullcalendar";

// Connects to data-controller="calendar"
export default class extends Controller {
  connect() {
    const dataset = this.element.dataset;
    let initialDate;

    if (dataset.startYear && dataset.startMonth) {
      const year = parseInt(dataset.startYear);
      const month = parseInt(dataset.startMonth) - 1;
      initialDate = new Date(year, month, 1);
    } else {
      initialDate = new Date();
    }

    const calendarEl = this.element;
    let selectedBackgroundEventId = "selected-date-highlight";

    const calendar = new Calendar(calendarEl, {
      initialView: "dayGridMonth",
      initialDate: initialDate,
      firstDay: 1,
      height: "auto",
      events: (fetchInfo, success) => {
        const params = `start=${fetchInfo.startStr}&end=${fetchInfo.endStr}`;

        fetch(`/calendar.json?${params}`)
          .then(response => response.json())
          .then(json => success(this.parseJson(json)));

        if (this.element.dataset.turboStream === "") {
          fetch(`/calendar?${params}`, { headers: { "Accept": "text/vnd.turbo-stream.html" } })
            .then(response => response.text())
            .then(html => Turbo.renderStreamMessage(html));
        }
      },
      eventDisplay: "list-item",
      dayMaxEvents: 1,
      dateClick: (info) => {
        const selectedDate = info.dateStr;
        document.getElementById("event-date-input").value = selectedDate;

        const existing = calendar.getEventById(selectedBackgroundEventId);
        if (existing) existing.remove();

        calendar.addEvent({
          id: selectedBackgroundEventId,
          start: selectedDate,
          allDay: true,
          display: 'background',
          backgroundColor: '#2ecc71'
        });
      },
      eventClick: function (info) {
        if (info.event.url === "") return;
      },
      eventDidMount: function (info) {
        if (info.el.tagName === "A") {
          info.el.setAttribute("data-turbo", "false");
        }

        const now = new Date();
        const eventStart = new Date(info.event.start);

        if (eventStart < now) {
          info.el.style.backgroundColor = "#d3d3d3";
          info.el.style.color = "#666";
        }
      }
    });

    calendar.render();
  }

  parseJson(json) {
    return json.data.map(({ id, attributes }) => ({
      id: id,
      title: attributes.title,
      start: attributes.start,
      url: attributes.url
    }))
  }
}
