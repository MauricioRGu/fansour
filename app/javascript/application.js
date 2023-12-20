// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require popper
//= require bootstrap
//= require jquery.mask.min.js
//= require jquery.easy-autocomplete

import "@hotwired/turbo-rails"
import "controllers"

var fEscondeMsg = function(){
    //esconde as mensagens da tela após 2s
    setTimeout(function(){
        $(".div-info").css('left',window.innerWidth + 100)
        $(".div-info").css('right',0 - (window.innerWidth * 2))
        $(".div-info").remove();
    },6000)
}

var binding = function(){
    var url_atual = window.location.href;

    //habilita a botão do menu na imagem do avatar
    $('#img-avatar').on('click',function(e){
        $("#menu").toggleClass('menu-hide')
    })  

    fEscondeMsg

    //se é a pagina de login inclui o js da pagina
    if(url_atual.includes('sign_in')){
        //quando o elemento do id form finalizar as transições, executa a intrução  
        $('#form').one('webkitTransitionEnd otransitionend oTransitionEnd msTransitionEnd transitionend',function(e){
            $("#row-form").removeClass("row-form-hide")
        });                
        //após o svg ser carregado na tela
        function callBack(){
            let svg = $('#svg');
            let form = $("#form");
            svg.css("fill","rgb(78, 195, 224)")
            svg.css("fillOpacity","1")
            svg.css("strokeOpacity","0")
            setTimeout(function(){
                form.removeClass("form-hide")            
            }, 2000);
        }
        
        //função para carregar o svg
        function mostraLogo(tempo){
            new Vivus('logo', { type: 'sync', duration: tempo , file: 'http://localhost:3000/assets/logo-index-a4f7f9b0592c1da89067a1139dd5ebba2e383a7b3a069ee4625e045cb8b99455.svg'}, callBack);
        }
        
        //chamada da função para carregar svg de acordo com o tipo de dispositivo
        if(navigator.userAgentData.mobile){
            mostraLogo(800);
        }else{
            mostraLogo(1);
        }

        $("#cadastro").on("click",function(e){
            $("#modal-cadastro").modal('show');
        })

        
    }

    $('.moeda').mask('000,00', {reverse: true, placeholder: "R$"})
    $('.desconto').mask('00', {reverse: true, placeholder: "%"})
    $('#user_cpf').mask('999.999.999-99',{placeholder: "000.000.000-00"})
    $('#user_dt_nascimento').mask('99/99/9999', {placeholder: "00/00/0000"})
    var SPMaskBehavior = function (val) {
        return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
      },
      spOptions = {
        onKeyPress: function(val, e, field, options) {
            field.mask(SPMaskBehavior.apply({}, arguments), options);
          }
      };      
      $('#user_telefone').mask(SPMaskBehavior, spOptions);

    $('#user_cep').mask('00000-000', {placeholder: ""});
}

//sempre que o turbo carregar, readiciona o evento de escuta.
document.addEventListener("turbo:load",binding);
document.addEventListener("turbo:submit-end",fEscondeMsg);