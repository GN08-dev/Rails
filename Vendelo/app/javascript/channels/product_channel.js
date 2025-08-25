/* import consumer from "channels/consumer";

consumer.subscriptions.create("ProductChannel", {
  /* connected() {
    console.log("Conectado a ProductChannel ✅");
  },

  disconnected() {
    console.log("Desconectado de ProductChannel ❌");
  },

  received(data) {
    console.log("Mensaje recibido:", data);
    // Aquí decides qué hacer, ejemplo:
    /* if (data.action === "update") {
      window.location.reload(); // o un Turbo.renderStreamMessage si usas Turbo Streams
    } */
//},
