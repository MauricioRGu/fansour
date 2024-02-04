import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {    
    
  }

  assina(event){
    let plan = event.currentTarget.attributes.plan.value
    let value = event.currentTarget.attributes.planValue.value

    const formData = new FormData();
    formData.append('assinatura[plan]',plan)
    formData.append('assinatura[valor]',value)
    formData.append('assinatura[criador_id]',document.getElementById("criador_id").value)

    fetch('/assinaturas/create', {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": this.token()
      }
      }).then(function(data){
        console.log(data)
        //if(data.statusText == 'OK'){
          //location.reload()
        //}
      })
  }

  setRenovacao(event){
    const formData = new FormData();
    formData.append('value',event.currentTarget.checked)
    formData.append('identity',event.currentTarget.attributes.identity.value)

    fetch('/assinaturas/update', {
      method: "POST",
      body: formData,
      headers: {
        "X-CSRF-Token": this.token()
      }
    }).then(function(data){
      if(data.statusText != 'OK'){
        console.log('erro')
      }
    })
  }

  token(){
    return document.querySelector('meta[name="csrf-token"]')?.getAttribute("content")
  }

}
