//= require jquery
//= require activestorage
//import { DirectUpload } from "@rails/activestorage"
import { Controller } from "@hotwired/stimulus"


const input = document.querySelector('input')

// Vincular ao arquivo solto - use o onDrop em um elemento pai ou use uma
//  biblioteca com o Dropzone
const onDrop = (event) => {
    event.preventDefault()
    const files = event.dataTransfer.files;
    Array.from(files).forEach(file => uploadFile(file))
}

// Vincular à seleção de arquivo normal
input.addEventListener('change', (event) => {
    Array.from(input.files).forEach(file => uploadFile(file))
    // você pode limpar os arquivos selecionados da entrada
    input.value = null
})

const uploadFile = (file) => {
    // seu formulário precisa do file_field direct_upload: true, que
    //  fornece o data-direct-upload-url, data-direct-upload-token
    // e data-direct-upload-attachment-name
    const url = input.dataset.directUploadUrl
    const token = input.dataset.directUploadToken
    const attachmentName = input.dataset.directUploadAttachmentName
    const upload = new DirectUpload(file, url, token, attachmentName)

    upload.create((error, blob) => {
        if (error) {
        // Trata o erro
        } else {
        // Adiciona uma entrada oculta apropriadamente nomeada ao formulário com o
        //  valor blob.signed_id, assim os blob ids podem ser
        //  transmitidos no fluxo normal de upload
        const hiddenField = document.createElement('input')
        hiddenField.setAttribute("type", "hidden");
        hiddenField.setAttribute("value", blob.signed_id);
        hiddenField.name = input.name
        document.querySelector('form').appendChild(hiddenField)
        }
    })
}
  

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

        //habilita os tooltips
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
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
        let dtAgendamento = new Date(agendamento)
        let minutos = Math.round(agendamento - now.getTime()) / 60000

        if(minutos < 30){
            alert("A programação deve ter no mínimo 30 minutos.")
            return
        }

        //passou nas validações 
        //seta o input e mostra a informação sobre a programação
        if(now.getDate() == dtAgendamento.getDate()){//
            label.children[0].innerHTML = 'Agendado para hoje ás ' + hora.value
        }else if((now.getDate() + 1) == dtAgendamento.getDate()){
            label.children[0].innerHTML = 'Agendado para amanhã ás ' + hora.value
        }else{
            label.children[0].innerHTML = 'Agendado para ' + dtAgendamento.toLocaleDateString()+' ás '+dtAgendamento.toLocaleTimeString().substr(0,5)
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

    preco(){
        let modal = document.getElementById('modal-valor')
        $(modal).modal('show')
    }

    setPrice(){
        let edtValor = document.getElementById('edtpreco')
        let inputValor = document.getElementById('preco')
        let error = document.getElementById('error-price')
        let modal = document.getElementById('modal-valor')
        let btn = document.getElementById('btn-price')
        let btn_c = document.getElementById('btn-clean-price')
        
        if(edtValor.value < 10){
            edtValor.focus()
            error.classList.remove('d-none')
            error.classList.add('show')
            edtValor.value = ''
        }else{
            error.classList.remove('show')
            btn.classList.add('active')      
            let tooltip = bootstrap.Tooltip.getInstance(btn)
            tooltip.setContent({'.tooltip-inner':'R$ '+edtValor.value+',00'})
            inputValor.value = edtValor.value
            btn_c.classList.remove('d-none')
            $(modal).modal('hide')            
        }
    }

    clearPrice(){
        let edtValor = document.getElementById('edtpreco')
        let inputValor = document.getElementById('preco')
        let modal = document.getElementById('modal-valor')
        let btn = document.getElementById('btn-price')
        let tooltip = bootstrap.Tooltip.getInstance(btn)
        let btn_c = document.getElementById('btn-clean-price')

        edtValor.value = ''
        inputValor.value = ''
        btn.classList.remove('active')
        tooltip.setContent({'.tooltip-inner':'Preço R$ '})
        btn_c.classList.add('d-none')
        $(modal).modal('hide')
    }

    addFile(){
        document.getElementById('anexos').click()
    }
}