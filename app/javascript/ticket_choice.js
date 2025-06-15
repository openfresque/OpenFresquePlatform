document.addEventListener("turbo:load", () => {
  if (document.querySelector("#ticket_choice")) {
    const radio_buttons = document.querySelectorAll(".radio_button");
    const custom_price_input = document.querySelector("#custom_price")
    const product_configurations = document.querySelectorAll(".product_configuration")

    product_configurations.forEach(element => {
      element.addEventListener("click", function () {
        product_configurations.forEach(element => {
          element.classList.remove("border")
          element.classList.remove("border-light2")
        });
        if (document.getElementById(`product_configuration_id_${element.id}`)) {
          document.getElementById(`product_configuration_id_${element.id}`).click();
        } else {
          document.querySelector("#product_configuration_id_coupon").click();
        }
        element.classList.add("border")
        element.classList.add("border-light2")
      });
    });

    radio_buttons.forEach(element => {
      element.addEventListener("click", function () {
        if (element.getAttribute("price_modifiable") == "true") {
          custom_price_input.required = true;
        } else {
          custom_price_input.required = false;
          custom_price_input.value = "";
        }
      });
    });

    custom_price_input.addEventListener("keyup", function () {
      if (custom_price_input.value.length > 0) {
        radio_buttons.forEach(element => {
          if (element.getAttribute("price_modifiable") == "true") {
            custom_price_input.required = true;
            element.checked = true;
          }
        });
      }
    });

    const coupon_code = document.querySelector("#coupon_code");
    coupon_code.addEventListener("keyup", function () {
      if (coupon_code.value.length > 0) {
        radio_buttons.forEach(function (radio_button) {
          document.querySelector("#product_configuration_id_coupon").checked = true;
          custom_price_input.required = false;
          custom_price_input.value = "";
        });
      } else {
        radio_buttons.forEach(function (radio_button) {
          custom_price_input.required = true;
        });
      }

    });
  };
}
);
