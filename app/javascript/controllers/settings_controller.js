import { Controller } from "@hotwired/stimulus"

//função para espera de finalização de digitação para executar algo
const debounce = (callback, wait) => {
  let timeoutId = null;
  return (...args) => {
    window.clearTimeout(timeoutId);
    timeoutId = window.setTimeout(() => {
      callback.apply(null, args);
    }, wait);
  };
};

// Connects to data-controller="settings"
export default class extends Controller {

  initialize() {
    var options = {
      data: [
        "Abecásia",
        "Afeganistão",
        "África do Sul",
        "Albânia",
        "Alemanha",
        "Andorra",
        "Angola",
        "Antígua e Barbuda",
        "Arábia Saudita",
        "Argélia",
        "Argentina",
        "Armênia",
        "Austrália",
        "Áustria",
        "Azerbaijão",
        "Bahamas",
        "Bahrein (ou Barein, ou Barém)",
        "Bangladesh",
        "Barbados",
        "Bélgica",
        "Belize",
        "Benim",
        "Bielorrússia",
        "Bolívia",
        "Bósnia e Herzegovina",
        "Botswana (ou Botsuana)",
        "Brasil",
        "Brunei",
        "Bulgária",
        "Burkina Faso (ou Burquina Faso)",
        "Burundi",
        "Butão",
        "Cabo Verde",
        "Camarões",
        "Camboja",
        "Canadá",
        "Catar (ou Qatar)",
        "Cazaquistão",
        "Chade",
        "Chile",
        "China",
        "Chipre",
        "Cingapura (ou Singapura)",
        "Colômbia",
        "Comores",
        "Congo",
        "Coreia do Norte",
        "Coreia do Sul",
        "Costa do Marfim",
        "Costa Rica",
        "Croácia",
        "Cuba",
        "Dinamarca",
        "Djibouti (ou Djibuti)",
        "Dominica",
        "Egito",
        "El Salvador",
        "Emirados Árabes Unidos",
        "Equador",
        "Eritreia",
        "Escócia",
        "Eslováquia",
        "Eslovênia",
        "Espanha",
        "Estados Federados da Micronésia",
        "Estados Unidos da América",
        "Estônia",
        "Eswatini (ou Essuatíni, ou Suazilândia)",
        "Etiópia",
        "Fiji",
        "Filipinas",
        "Finlândia",
        "França",
        "Gabão",
        "Gâmbia",
        "Gana",
        "Geórgia",
        "Granada",
        "Grécia",
        "Guatemala",
        "Guiana",
        "Guiné",
        "Guiné-Bissau",
        "Guiné Equatorial",
        "Haiti",
        "Holanda",
        "Honduras",
        "Hungria",
        "Iêmen",
        "Índia",
        "Indonésia",
        "Inglaterra",
        "Irã (ou Irão)",
        "Iraque",
        "Irlanda do Norte",
        "Irlanda",
        "Islândia",
        "Israel",
        "Itália",
        "Jamaica",
        "Japão",
        "Jordânia",
        "Países com K",
        "Kiribati (ou Quiribati)",
        "Kosovo",
        "Kuwait",
        "Laos",
        "Lesoto",
        "Letônia",
        "Líbano",
        "Libéria",
        "Líbia",
        "Liechtenstein (ou Listenstaine)",
        "Lituânia",
        "Luxemburgo",
        "Macedônia do Norte",
        "Madagascar (ou Madagáscar)",
        "Malásia",
        "Malawi (ou Malauí)",
        "Maldivas",
        "Mali",
        "Malta",
        "Marrocos",
        "Marshall",
        "Maurícia",
        "Mauritânia",
        "México",
        "Mianmar",
        "Micronésia",
        "Moçambique",
        "Moldávia",
        "Mônaco",
        "Mongólia",
        "Montenegro",
        "Namíbia",
        "Nauru",
        "Nepal",
        "Nicarágua",
        "Níger",
        "Nigéria",
        "Noruega",
        "Nova Zelândia",
        "Omã",
        "Ossétia do Sul",
        "País de Gales",
        "Países Baixos",
        "Palau",
        "Palestina",
        "Panamá",
        "Papua-Nova Guiné",
        "Paquistão",
        "Paraguai",
        "Peru",
        "Polônia",
        "Portugal",
        "Qatar (ou Catar)",
        "Quênia",
        "Quirguistão",
        "Quiribati (ou Kiribati)",
        "Reino Unido",
        "República Árabe Saaraui Democrática",
        "República Centro-Africana",
        "República Democrática do Congo",
        "República do Congo",
        "República Dominicana",
        "República Tcheca (ou Tchéquia)",
        "República Turca de Chipre do Norte",
        "Romênia",
        "Ruanda",
        "Rússia",
        "Salomão",
        "Samoa",
        "San Marino (ou São Marinho)",
        "Santa Lúcia",
        "São Cristóvão e Névis (ou São Cristóvão e Neves)",
        "São Tomé e Príncipe",
        "São Vicente e Granadinas",
        "Senegal",
        "Serra Leoa",
        "Sérvia",
        "Seychelles (ou Seicheles)",
        "Singapura (ou Cingapura)",
        "Síria",
        "Somália",
        "Sri Lanka",
        "Suazilândia (ou Eswatini, ou Essuatíni)",
        "Sudão do Sul",
        "Sudão",
        "Suécia",
        "Suíça",
        "Suriname",
        "Tailândia",
        "Taiwan",
        "Tajiquistão (ou Tadjiquistão)",
        "Tanzânia",
        "Tchéquia (ou República Tcheca)",
        "Timor-Leste",
        "Togo",
        "Tonga",
        "Trinidad e Tobago",
        "Tunísia",
        "Turcomenistão (ou Turquemenistão)",
        "Turquia",
        "Tuvalu",
        "Ucrânia",
        "Uganda",
        "Uruguai",
        "Uzbequistão",
        "Vanuatu",
        "Vaticano",
        "Venezuela",
        "Vietnã (ou Vietname)",
        "Zâmbia",
        "Zimbábue"
      ],
      list: {
        match: {
          enabled: true
        }
      }

    }
    $("#user_pais").easyAutocomplete(options)

    // this will ensure that the API does not get called too much
    // the wait time (300) is in milliseconds so adjust as needed
    this.checaUsername = debounce(this.checaUsername.bind(this), 1000);
  }

  connect() {
    $(".form-control").on("blur",(event) =>{
      this.habilitaForm()
    })
  }

  //funções do perfil 

  preencheValor1() {
    let valor = $('#user_valor1').val().replace(',','.')
    let valid = true

    if (valor > 200){
      $("#user_valor1").removeClass("is-valid")
      $("#user_valor1").addClass("is-invalid")

      if($("#v1-feedback").length == 0){
        $("#user_valor1").closest('div').append("<div id='v1-feedback' class='invalid-feedback max'>O valor máximo é R$ 200,00</div>")
      }else{
        if(!$("#v1-feedback").hasClass('max')){
          $("#v1-feedback").remove()
          $("#user_valor1").closest('div').append("<div id='v1-feedback' class='invalid-feedback max'>O valor máximo é R$ 200,00</div>")
        }
      }
      valid = false
    } 

    if(valor < 10){
      $("#user_valor1").removeClass("is-valid");
      $("#user_valor1").addClass("is-invalid");

      if($("#v1-feedback").length == 0){
        $("#user_valor1").closest('div').append("<div id='v1-feedback' class='invalid-feedback min'>O valor mínimo é R$ 10,00</div>")
      }else{
        if(!$("#v1-feedback").hasClass('min')){
          $("#v1-feedback").remove()
          $("#user_valor1").closest('div').append("<div id='v1-feedback' class='invalid-feedback min'>O valor mínimo é R$ 10,00</div>")
        }
      }
      valid = false
    }

    if(valid){
      $("#user_valor1").removeClass("is-invalid");
      $("#user_valor1").addClass("is-valid");
      
      let v3, v6
      v3 = new Intl.NumberFormat("pt-BR").format(valor * 3)
      v6 = new Intl.NumberFormat("pt-BR").format(valor * 6)
      $('#user_valor3').val(v3)
      $('#user_valor6').val(v6)
    }
  }

  checaUsername(){    
    let username = $("#user_nome_arroba").val().trim()
    if(username == ''){
      $("#user_nome_arroba").removeClass("is-valid");
      $("#user_nome_arroba").addClass("is-invalid");
      return false
    }

    //retira os espaços em brancos e pontos
    username = username.replaceAll(' ','')
    username = username.replaceAll('.','')

    $("#user_nome_arroba").val(username)    

    $("#user_nome_arroba").closest("div").append(
      '<div class="feedback-input text-primary">'
      +'<span>Vericando disponibilidade </span>'
      +    '<div class="spinner-border spinner-border-sm text-primary" role="status">'
      +  '<span class="visually-hidden">Loading...</span>'
      +'</div>'
      +'</div>'
    )

    //valida se o username digitado já existe
    fetch('/username/'+username, {
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
      mode: 'cors', // no-cors, *cors, same-origin
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      credentials: 'same-origin', // include, *same-origin, omit
      headers: {
          'Content-Type': 'application/text',
          'X-CSRF-Token': this.getMetaValue("csrf-token")
      },
      body: JSON.stringify({ completed: 'e.target.checked' }) // body data type must match "Content-Type" header
    })
    .then((response) => response.text())
    .then((text) => {
      if(text == 'OK'){
        $("#user_nome_arroba").removeClass("is-invalid");
        $("#user_nome_arroba").addClass("is-valid");
      }else{
        $("#user_nome_arroba").removeClass("is-valid");
        $("#user_nome_arroba").addClass("is-invalid");
      }
      $(".feedback-input").remove();
    });
  }

  preencheDesc1(event){
    let valor = $("#user_valor1")
    let desc = $("#user_desc1")
  }

  preencheDesc3(event){
    let valor = $("#user_valor3")
    let desc = $("#user_desc3")
  }

  preencheDesc6(event){
    let valor = $("#user_valor6")
    let desc = $("#user_desc6")
  }

  naoVazio(event){
    let id = event.target.id
    if($("#"+id).val().trim() == ''){
      $("#"+id).removeClass("is-valid");
      $("#"+id).addClass("is-invalid");
    }else{
      $("#"+id).removeClass("is-invalid");
      $("#"+id).addClass("is-valid");
    }
  }

  habilitaForm(){
    if($(".is-invalid").length == 0){
      $("input[name=commit]").prop("disabled",false)
    }else{
      $("input[name=commit]").prop("disabled",true)
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

  //funções do dados pessoais
  preencheCEP(){
    let cep = $("#user_cep").cleanVal()
    console.log(cep)
    if(cep.length < 8){
      //se não completou retorna false
      if(!$("#user_cep").hasClass("is-invalid")){
        $("#user_cep").addClass("is-invalid")
      }
      if($("#user_cep").hasClass("is-valid")){
        $("#user_cep").removeClass("is-valid")
      }
      return false
    }

    function limpa_formulário_cep(){
      $("#user_endereco").val("");
      $("#user_bairro").val("");
      $("#user_cidade").val("");
      $("#user_estado").val("");
    }

    
    $.getJSON("https://viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {
      if (!("erro" in dados)) {
        //Atualiza os campos com os valores da consulta.
        $("#user_endereco").val(dados.logradouro);
        $("#user_bairro").val(dados.bairro);
        $("#user_cidade").val(dados.localidade);
        $("#user_estado").val(dados.uf);

        $("#user_cep").removeClass("is-invalid")
        $("#user_cep").addClass("is-valid")
    } //end if.
    else {
        //CEP pesquisado não foi encontrado.
        limpa_formulário_cep();
        alert("CEP não encontrado.");
    }
    });
  }
}
