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

    valida_post(){
        let desc = document.getElementById('descricao')
        let btn = document.getElementById('submit')
        btn.disabled = desc.value == ''
    }

    fixado(){
        let input = document.getElementById('fixado')
        let btn = document.getElementById('btn-fixa')     
        input.value = input.value == 'false' ? true : false
        btn.classList.toggle("active");
    }

    comentarios(){
        let input = document.getElementById('comentario')
        let btn = document.getElementById('btn-comentario')     
        input.value = input.value == 'false' ? true : false
        btn.classList.toggle("active");
    }

    agendamento(){
        let modal = document.getElementById('modal-agendamento')
        $(modal).modal('show');
    }

    setAgendamento(){
        let data = document.getElementById('data')
        let hora = document.getElementById('hora')
        let btn = document.getElementById('btn-agenda')
        let label = document.getElementById('label-agendamento')

        if(data.value == ''){
            alert("Selecione uma data!")
            data.focus()
            return
        }

        if(hora.value == ''){
            alert("Selecione a hora!")
            hora.focus()
            return
        }

        let now = new Date
        let agendamento = Date.parse(data.value+' '+hora.value)
        let minutos = Math.round(agendamento - now.getTime()) / 60000
        if(minutos < 30){
            alert("A programação deve ter no mínimo 30 minutos.")
            return
        }

        //passou nas validações 
        //seta o input e mostra a informação sobre a programação
        if(minutos < 1440){//
            label.children[0].innerHTML = 'Agendado para hoje ás ' + hora.value
        }

        if(minutos < 2880){
            label.children[0].innerHTML = 'Agendado para amanhã ás ' + hora.value
        }else{
            label.children[0].innerHTML = 'Agendado para ' + data.value + ' ás ' + hora.value
        }

        document.getElementById('dt_post').value = data.value+' '+hora.value
        btn.classList.add("active");
        label.classList.remove('d-none')
        
        //fecha a modal
        $('#modal-agendamento').modal('hide')
    }

    cancelaAgendamento(){
        document.getElementById('dt_post').value = ''
        document.getElementById('btn-agenda').classList.remove("active");
        document.getElementById('label-agendamento').classList.add('d-none')
    }

}