import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let imgs = document.querySelectorAll(".img-get")
    for(let img of imgs){
      fetch('image'+img.attributes.datasrc.value, {
      method: "POST",
      body: "",
      headers: {
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          ?.getAttribute("content"),
      },
      }).then(function(data){
        return data.blob()
      }).then(function(result){
        const imgURL = URL.createObjectURL(result)
        img.src = imgURL 
      })
    }
  }
}
