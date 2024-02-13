//= require jquery
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect(){
        this.element.addEventListener("turbo:submit-start", (event) => {
            let form = $(event.currentTarget)
            let text = 'Cadastrando'
            if(event.currentTarget.attributes[0].value == 'login'){
                text = 'Entrando'
            }

            //define o texto no botão
            form.find('span[role=status]').html(text)

            //habilita o spinner
            form.find('.spinner-border').toggleClass('visually-hidden')
        })    
        
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