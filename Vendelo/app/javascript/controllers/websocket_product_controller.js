import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable"; // importamos la libreria
export default class extends Controller {
  connect() {
    //alert("ok");
    createConsumer().subscriptions.create({ channel: "ProductChannel" });
  }
}
