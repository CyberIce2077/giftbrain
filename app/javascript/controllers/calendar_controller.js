import { Controller } from "@hotwired/stimulus"
import { Calendar } from "fullcalendar";

// Connects to data-controller="calendar"
export default class extends Controller {
  connect() {
    const calendarEl = this.element;
    let selectedBackgroundEventId = "selected-date-highlight";

    const calendar = new Calendar(calendarEl, {
      initialView: "dayGridMonth",
      firstDay: 1,
      height: "auto",
      events: "/calendar.json",
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
      eventClick: function(info) {
        if (info.event.url === "") return;
        window.open(info.event.url, "_blank");
        info.jsEvent.preventDefault();
      }
    });

    calendar.render();
  }
}
