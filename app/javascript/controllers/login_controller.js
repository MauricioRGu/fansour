//= require jquery
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect(){
        this.element.addEventListener("turbo:submit-end", (event) => {
            console.log(event)
            this.checaLogin(event)
        })    
    }

    checaLogin(event){
        if (event.detail.success) {
            console.log(event)
            Turbo.visit(event.detail.fetchResponse.response.url)
        }
    }

}