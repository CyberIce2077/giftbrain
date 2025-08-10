import { Controller } from "@hotwired/stimulus"
import { Sortable } from "sortablejs"

export default class extends Controller {
  connect() {
    this.previousIds = this.getCurrentIds()

    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".idea-box",
      ghostClass: "ghost",
      scroll: true,
      scrollSpeed: 15,
      forceFallback: true,
      bubbleScroll: true,
      scrollContainer: this.element,
      onEnd: () => {
        const currentIds = this.getCurrentIds()

        if (this.arraysEqual(currentIds, this.previousIds)) return

        this.previousIds = currentIds
        const recipientId = this.element.dataset.recipientId
        this.sendOrderToServer(recipientId, currentIds)
      }
    })
  }

  getCurrentIds() {
    return Array.from(this.element.children).map(el => el.dataset.ideaId)
  }

  arraysEqual(a, b) {
    if (a.length !== b.length) return false
    return a.every((val, index) => val === b[index])
  }

  sendOrderToServer(recipientId, currentIds) {
    fetch(`/recipient_ideas/reorder`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
      },
      body: JSON.stringify({ reorder: { recipient_id: recipientId, idea_ids: currentIds } })
    })
  }
}
