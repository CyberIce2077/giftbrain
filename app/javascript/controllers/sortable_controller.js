import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: ".gift-card",
      ghostClass: "sortable-ghost",

      onEnd: event => {
        const fromEl = this.element.children[event.oldIndex]
        const toEl = this.element.children[event.newIndex]

        const movedId = fromEl.dataset.id
        const targetId = toEl.dataset.id
        const giftTargetId = fromEl.dataset.giftTargetId

        if (movedId === targetId) return // prevent unnecessary request

        this.sendSwapRequest(giftTargetId, movedId, targetId)
      }
    })
  }

  sendSwapRequest(giftTargetId, movedId, targetId) {
    fetch("/gift_targets/" + giftTargetId + "/gift_ideas/" + movedId + "/gift_target_gift_ideas/reorder", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
      },
      body: JSON.stringify({
        target_id: targetId
      })
    })
  }
}


// import { Controller } from "@hotwired/stimulus"
// import Sortable from "sortablejs"

// export default class extends Controller {
//   connect() {
//     this.sortable = Sortable.create(this.element, {
//       animation: 150,
//       handle: ".gift-card",
//       ghostClass: "sortable-ghost",

//       onEnd: event => {
//         const priorities = Array.from(this.element.children).map(el => el.dataset.priority)
//         console.log(priorities)

//         const giftTargetId = this.element.dataset.giftTargetId
//         console.log("Gift Target ID:", giftTargetId)

//         this.sendOrderToServer(giftTargetId, priorities)
//       }
//     })
//   }

//   sendOrderToServer(giftTargetId, priorities) {
//     fetch("/gift_targets/" + giftTargetId + "/gift_ideas/reorder", {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content
//       },
//       body: JSON.stringify({ ordered_priorities: priorities })
//     })
//   }
// }
