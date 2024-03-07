import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect(){
    }

    show(event){
        //exibe as imagens em tela cheia
        this.viewer = new Viewer(event.currentTarget,{
            url: 'src',
            title: ''
        })
        this.viewer.show()
    }

    nega(event){
        if(window.confirm('Confirma a rejeição?')){
            let input_obs = document.getElementById('input'+event.currentTarget.attributes.target.value)
            if(input_obs.value == ''){
                alert('Descreva o motivo antes negar.')
                input_obs.focus()
                return
            }
            //desabilita os botões
            let buttons = document.querySelectorAll('[target="'+event.currentTarget.attributes.target.value+'"]')
            buttons.forEach(function (b) {
                let label = document.getElementById(event.currentTarget.attributes.label.value)
                label.classList.remove('visually-hidden')
                b.disabled = true
            });
            this.atualiza_checagem_profile(event.currentTarget.attributes.target.value,false,input_obs.value)
        }
    }

    aprova(event){        
        if(window.confirm('Confirma a aprovação?')){
            //desabilita os botões 
            let buttons = document.querySelectorAll('[target="'+event.currentTarget.attributes.target.value+'"]')
            buttons.forEach(function (b) {
                let label = document.getElementById(event.currentTarget.attributes.label.value)
                label.classList.remove('visually-hidden')
                b.disabled = true
              });
            this.atualiza_checagem_profile(event.currentTarget.attributes.target.value,true)
        }
    }

    atualiza_checagem_profile(id,aprovado,observacao=''){
        let formData = new FormData()
        formData.append("id", id);
        formData.append("checagem_profile[aprovado]", aprovado);
        if(!aprovado){
            formData.append("checagem_profile[observacao]", observacao);
        }
        fetch("/adm/update_checagem_profiles", {
            method: "POST",
            body: formData,
            headers: {
            "X-CSRF-Token": document
                .querySelector('meta[name="csrf-token"]')
                ?.getAttribute("content"),
            },
        })
        .then((response) => response.text())
        .then((text) => {
            console.log(text)      
            if(text == 'OK'){
                document.getElementById('card'+id).remove()
            }
        });
    }

}