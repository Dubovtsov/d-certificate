import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tasks"
export default class extends Controller {
  static targets = ["task", "column"];

  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  dragstart(event) {
    console.log("start")
    event.dataTransfer.setData(
      "application/json",
      JSON.stringify({
        id: event.target.dataset.id,
        status: event.target.dataset.status,
      })
    );
    event.currentTarget.style.opacity = 0.5;
  }

  dragend(event) {
    console.log("stop")
    event.currentTarget.style.opacity = "";
  }

  allowdrop(event) {
    event.preventDefault();
  }

  drop(event) {
    event.preventDefault();
    console.log("drop")
    const data = JSON.parse(event.dataTransfer.getData("application/json"));
    const targetStatus = event.currentTarget.dataset.status;

    if (data.status !== targetStatus) {
      console.log(data.id)
      fetch(`/tasks/${data.id}/update_status`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
            .content,
        },
        body: JSON.stringify({ task_id: data.id, status: targetStatus }),
      })
        .then((response) => response.json())
        .then((data) => location.reload());
    }
  }
}
