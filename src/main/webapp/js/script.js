$(function(){
      $("#rid").change(function(){
        if($(this).is(":checked")){
            alert("게임방, 관공서등 공공기관에서는 사용하지 마세요.");
        }
      });

    const userIdFromCookie = getCookie('userid');
    if(userIdFromCookie) {
      $("#userid").val(userIdFromCookie);
    }


   /*** 회원가입 스크립트 **/
   $("#emailDomain2").hide();
   $("#emailDomain").change(function(){
      if($(this).val() === 'act'){
        $("#emailDomain2").show().val("");
        $("#emailDomain2").focus();
        $("#emailDomain").attr("readonly", true);
      }else{
        $("#emailDomain2").hide();
        $("#emailDomain").attr("readonly", false);
      }
   }); 
 
    $.validator.setDefaults({
       onkeyup: false,
       onclick: false,
       onfocusout: false,
       showErrors: function(errorMap, errorList){
          if(this.numberOfInvalids()){
             alert(errorList[0].message);
          }
       }
    });
    
    $.validator.addMethod('customPattern', function(value, element, param){
        return this.optional(element) || param.test(value);
    }, "아이디는 알파벳 대, 소문자와 숫자만 허용합니다.");
 
     $('#loginform').validate({
        debug: false, 
        rules: {
            userid: "required",
            userpass: "required"
        },
        messages: {
            userid: "아이디를 입력하세요.",
            userpass: "비밀번호를 입력하세요."
        }
    });
    
    
    $('#registerform').validate({
       rules:{
          userid: {
             required: true,
             minlength: 3,
             maxlength: 9,
             customPattern : /^[a-zA-Z0-9]{3,9}$/,
             remote: "findid"
          },
          usrpass: { required: true, minlength: 5},
          reusrpass: { required: true, equalTo: "#usrpass" },
          username: { required: true },
          emailid: { required: true },
          emailDomain : {
             require_from_group : [1, ".emailgroup"]
          },
          emailDomain2 : {
             require_from_group : [1, ".emailgroup"]
          }
       },
       messages: {
          userid: {
             required: '필수 입력 항목입니다.',
             minlength: '{0}글자 이상 입력하세요.',
             maxlength: '아이디가 너무 길어요. {0}자 이하로 입력하세요.',
             customPattern: '아이디는 알파벳 대,소문자와 숫자만 허용합니다.',
             remote:  $.validator.format("{0} 은(는) 사용중입니다.")
          },
         usrpass: {
             required: '비밀번호를 입력하세요.',
             minlength: '비밀번호는 최소 {0}자 이상이어야 합니다.'
         },
         reusrpass: {
             required: '비밀번호를 확인하세요.',
             equalTo: '비밀번호가 일치하지 않습니다.' // 두 비밀번호가 일치하지 않을 때의 메시지
         },
          username: '이름을 입력하세요.',
          emailid: '이메일을 입력하세요.',
          emailDomain: '이메일을 입력하세요.',
          emailDomain2: '이메일을 입력하세요.'
       },
       submitHandler: function(form){
          const email = $('#emailid').val() + "@" + ($("#emailDomain").val()==='act'? $('#emailDomain2').val():$('#emailDomain').val());
          $("#email").val(email);
          $.ajax({
             url:"findemail",
             data: {
                useremail: email
             },
             success: function(res){
               
                if(res > 0){
                   console.log(res);
                   alert("이미 존재하는 이메일입니다.");
                }else{
                   const tel = $("#tel1").val() + "-" + $("#tel2").val() + "-" + $("#tel3").val();
                   $("#tel").val(tel);   
                   form.submit();
                }
             }, 
             error: function(){
                alert("이메일 검증중 오류가 발생했습니다.");
             }
          });
                                   
       }
    });
    
});

function setCookie(name, value, exp){
    const date = new Date();
    date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000); // 쿠키 유효 기간 설정
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
}

function getCookie(name){
   const value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
   return value? value[2]:null;
}

function delCookie(name){
   document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
}