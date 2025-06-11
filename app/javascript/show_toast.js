function show_toast_ready() {
  if (document.querySelector(".toast_btn")) {
    document.querySelectorAll(".toast_btn").forEach((btn) => {
      btn.addEventListener("click", () => {
        $("#toast").toast("show");
      });
    });
  }
}

document.addEventListener("DOMContentLoaded", show_toast_ready);
document.addEventListener("turbo:load", show_toast_ready);
