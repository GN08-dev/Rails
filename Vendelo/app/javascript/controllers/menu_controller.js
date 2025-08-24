import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /* captura de los targets que deseamos camputar de nuestro dom */
  static targets = ["items"];
  /* esto es para realizar prueba */
  /* connect() {
    alert("prueba");
  } */
  open() {
    //alert("ok"); prueba de accion de metodo llamado
    /* 
        obtenemos lo que es el items definidos con el target y  
        listamos las clases que nos devuelve el target y removemos el translate-x-full
        nota siempre que usamos un target definido estaticamente se coloca el nombre y a un lado
        el Target ejemplo items es el target que definimos y para usarlo es itemsTarget
    */
    this.itemsTarget.classList.remove("translate-x-full");
  }
  /* botton dentro de el menu */
  close() {
    this.itemsTarget.classList.add("translate-x-full");
  }
  /* una formas mas limpia de realizarlo */
  toggle() {
    this.itemsTarget.classList.toggle("translate-x-full");
  }
}
