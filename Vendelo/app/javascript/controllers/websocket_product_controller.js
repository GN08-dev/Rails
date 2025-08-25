/* import { Controller } from "@hotwired/stimulus";
import consumer from "channels/consumer";

export default class extends Controller {
  connect() {
    const productId = this.data.get("productid"); // <-- obtiene el valor de data-websocket-product-product-id
    consumer.subscriptions.create(
      {
        channel: "ProductChannel",
        // capturamos la data del div 
        room: productId,
        //room: "1068639269",
      },
      {
        received(data) {
          if (
            data.action === "update" &&
            window.location.pathname === `/${productId}`
          ) {
            location.reload();
          }
        },
      }
    );
  }
}
 */
