//= require jquery

import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage"


  

export default class extends Controller {
    static targets = ["input","midias"]

    connect(){      
        this.inputTarget.disabled = false  
        const input = document.querySelector('input[type=file]')
       
        // Vincular à seleção de arquivo normal
        input.addEventListener('change', (event) => {
            //Array.from(input.files).forEach(file => uploadFile(file))
            Array.from(input.files).forEach(file => {
                createDirectUploadController(this, file).start();
            })
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

        this.element.addEventListener("turbo:submit-start", (event) => {
            let form = $(event.currentTarget)           

            //define o texto no botão
            form.find('span[role=status]').html(text)

            //habilita o spinner
            form.find('.spinner-border').toggleClass('visually-hidden')
        })    
        
        this.element.addEventListener("turbo:submit-end", (event) => {
            alert('turbo:submit-end')
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

    removeFile(event){
        let input = document.getElementById(event.target.dataset.input)
        input.disabled = true
        event.target.parentNode.classList.add('d-none')
    }
    
}

class DirectUploadController {
    constructor(source, file) {        
        this.directUpload = createDirectUpload(file, source.inputTarget.dataset.directUploadUrl, this);
        this.source = source;
        this.file = file;
        this.id = (new Date).getTime();
        this.url_file = URL.createObjectURL(file)
    }

    start() {
        this.file.controller = this;
        this.hiddenInput = this.createHiddenInput();
        this.preview = this.createPreview();
        this.directUpload.create((error, attributes) => {
            if (error) {
                remove(this.hiddenInput);
            } else {
                this.hiddenInput.value = attributes.signed_id;
                setTimeout(() => {                    
                    document.getElementById(`progress-${this.id}`).parentNode.classList.add('d-none')
                    document.getElementById(`btn-close-${this.id}`).classList.remove('d-none')
                }, "2000");
            }
        });
    }

    createPreview(){
        // imagens
        var fileExtension_img = ['jpeg', 'jpg', 'png', 'gif', 'bmp'];
        //videos         
        var fileExtension_vid = ['mp4', 'mpeg', 'wmv', 'mov', 'avi'];
        console.log(this.file.type)
        if(this.file.type.split('/')[0].toLowerCase() == 'image'){                
            this.source.midiasTarget.insertAdjacentHTML("beforeend", `
                <div id="preview-${this.id}" class="d-flex flex-column-reverse justify-content-center position-relative preview rounded-3" style="background: url(${this.url_file});width: 100px;height: 100px;background-size: cover;">
                    <label id="btn-close-${this.id}" data-action="click->posts#removeFile" data-input="input-${this.id}" class="btn-close cursor-pointer d-none position-absolute z-3" style="top: 0;right: 0;"></label>
                    <div id="" class="bg-preview bg-black opacity-50 position-absolute rounded-2 w-100"></div>
                    <div class="m-2 progress" style="height: 12px;opacity: 85%;">
                        <div id="progress-${this.id}" class="progress-bar" style="width: 0%;"></div>
                    </div>
                </div>`
            )
        }
        if(this.file.type.split('/')[0].toLowerCase() == 'video'){                
            this.source.midiasTarget.insertAdjacentHTML("beforeend", `
                <div id="preview-${this.id}" class="d-flex flex-column-reverse justify-content-center position-relative preview rounded-3" style="width: 100px;height: 100px;background-size: cover;">
                    <video controls class="h-100 rounded-3"><source src="${this.url_file}" type="${this.file.type}"></video>
                    <label id="btn-close-${this.id}" data-action="click->posts#removeFile" data-input="input-${this.id}" class="btn-close cursor-pointer d-none position-absolute z-3" style="top: 0;right: 0;"></label>
                    <div id="" class="bg-black opacity-50 position-absolute rounded-2 w-100"></div>
                    <div class="m-2 progress" style="height: 12px;opacity: 85%;">
                        <div id="progress-${this.id}" class="progress-bar" style="width: 0%;"></div>
                    </div>
                </div>`
            )
        }
    }

    createHiddenInput() {
        const input = document.createElement("input");
        input.type = "hidden";
        input.name = this.source.inputTarget.name;
        input.id = `input-${this.id}`
        document.querySelector('form').appendChild(input)
        return input;
    }

    directUploadWillStoreFileWithXHR(xhr) {
        this.bindProgressEvent(xhr);
    }

    bindProgressEvent(xhr) {
        this.xhr = xhr;
        this.xhr.upload.addEventListener("progress", event =>
        this.uploadRequestDidProgress(event)
        );
    }

    uploadRequestDidProgress(event) {
        const element = document.getElementById(`progress-${this.id}`);
        const progress = (event.loaded / event.total) * 100;
        element.style.width = `${progress}%`
    }
}
  
function createDirectUploadController(source, file) {
    return new DirectUploadController(source, file);
}
  
function createDirectUpload(file, url, controller) {
    return new DirectUpload(file, url, controller);
}