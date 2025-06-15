function stripePageReady() {
  if (document.querySelector("#payment_form") != undefined) {
    const locale = document.querySelector("#payment_form").dataset.locale;

    // Add transaction_id to language urls
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const transaction_id = urlParams.get("transaction_id");
    document.querySelectorAll(".language_modal_url").forEach((element) => {
      element.href = element.href + "&transaction_id=" + transaction_id;
    });

    let payment_form = document.querySelector("#payment_form");
    const stripe_public_key =
      document.getElementById("stripe_public_key").dataset.stripe_public_key;
    var stripe;
    var elements;

    function initializeStripe() {
      return new Promise((resolve, reject) => {
        if (typeof Stripe === "function") {
          resolve(Stripe(stripe_public_key, { locale: locale }));
        } else {
          let attempts = 0;
          const maxAttempts = 50;

          const checkStripe = () => {
            attempts++;
            if (typeof Stripe === "function") {
              resolve(Stripe(stripe_public_key, { locale: locale }));
            } else if (attempts >= maxAttempts) {
              reject(new Error("Stripe failed to load"));
            } else {
              setTimeout(checkStripe, 100);
            }
          };

          checkStripe();
        }
      });
    }

    // Initialize Stripe and setup payment
    initializeStripe()
      .then((stripeInstance) => {
        stripe = stripeInstance;
        initialize();
        checkStatus();
      })
      .catch((error) => {
        console.error("Failed to initialize Stripe:", error);
        showMessage("Payment system failed to load. Please refresh the page.");
      });

    payment_form.addEventListener("submit", handleSubmit);

    // Fetches a payment intent and captures the client secret
    async function initialize() {
      let transaction_id = document.getElementById("transaction_id").value;
      let language = document.getElementById("language").value;
      const response = await fetch("./create_payment_intent", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          transaction_id: transaction_id,
          language: language,
        }),
      });
      const { clientSecret } = await response.json();

      const appearance = {
        theme: "flat",
      };
      elements = stripe.elements({
        appearance,
        clientSecret,
        loader: "always",
      });

      const paymentElement = elements.create("payment");
      paymentElement.mount("#payment-element");
      paymentElement.on("ready", function (event) {
        document.getElementById("loading_spinner").classList.add("d-none");
        document.querySelector("#submit").classList.remove("d-none");
        document.querySelector("#cancel_btn").classList.remove("d-none");
      });
    }

    async function handleSubmit(e) {
      e.preventDefault();
      setLoading(true);

      let language = document.getElementById("language").value;
      let return_url =
        window.location.protocol +
        "//" +
        window.location.host +
        "/payments/confirmation" +
        "?language=" +
        language;

      const { error } = await stripe.confirmPayment({
        elements,
        confirmParams: {
          return_url: return_url,
        },
      });

      // This point will only be reached if there is an immediate error when
      // confirming the payment. Otherwise, your customer will be redirected to
      // your `return_url`. For some payment methods like iDEAL, your customer will
      // be redirected to an intermediate site first to authorize the payment, then
      // redirected to the `return_url`.
      if (error.type === "card_error" || error.type === "validation_error") {
        showMessage(error.message);
      } else {
        showMessage("An unexpected error occurred.");
      }

      setLoading(false);
    }

    // Fetches the payment intent status after payment submission
    async function checkStatus() {
      const clientSecret = new URLSearchParams(window.location.search).get(
        "payment_intent_client_secret"
      );

      if (!clientSecret) {
        return;
      }

      const { paymentIntent } = await stripe.retrievePaymentIntent(
        clientSecret
      );

      switch (paymentIntent.status) {
        case "succeeded":
          showMessage("Payment succeeded!");
          break;
        case "processing":
          showMessage("Your payment is processing.");
          break;
        case "requires_payment_method":
          showMessage("Your payment was not successful, please try again.");
          break;
        default:
          showMessage("Something went wrong.");
          break;
      }
    }

    // ------- UI helpers -------

    function showMessage(messageText) {
      const messageContainer = document.querySelector("#payment-message");

      messageContainer.classList.remove("d-none");
      messageContainer.textContent = messageText;

      setTimeout(function () {
        messageContainer.classList.add("d-none");
        messageText.textContent = "";
      }, 10000);
    }

    // Show a spinner on payment submission
    function setLoading(isLoading) {
      if (isLoading) {
        // Disable the button and show a spinner
        document.querySelector("#submit").disabled = true;
        document.querySelector("#spinner").classList.remove("hidden");
        document.querySelector("#button-text").classList.add("hidden");
      } else {
        document.querySelector("#submit").disabled = false;
        document.querySelector("#spinner").classList.add("hidden");
        document.querySelector("#button-text").classList.remove("hidden");
      }
    }
  }
}

document.addEventListener("DOMContentLoaded", stripePageReady);
document.addEventListener("turbo:load", stripePageReady);
