<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<jsp:include page="Banner.jsp"></jsp:include>
	<div id="join" class="container">
		<form class="form-horizontal" role="form" method="post"
			action="javascript:alert( 'success!' );">
			<div class="form-group">
				<label for="provision" class="col-lg-2 control-label">회원가입약관</label>
				<div class="col-lg-10" id="provision">
					<textarea class="form-control" rows="8" style="resize: none" readonly>
						약관동의
                    </textarea>
					<div class="radio">
						<label>
							<input type="radio" id="provisionYn" name="provisionYn" value="Y" autofocus="autofocus">동의합니다.
						</label>
					</div>
					<div class="radio">
						<label>
							<input type="radio" id="provisionYn" name="provisionYn" value="N" checked> 동의하지 않습니다.
						</label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label for="memberInfo" class="col-lg-2 control-label">개인정보취급방침</label>
				<div class="col-lg-10" id="memberInfo">
					<textarea class="form-control" rows="8" style="resize: none" readonly>
						개인정보의 항목 및 수집방법
                    </textarea>
					<div class="radio">
						<label> <input type="radio" id="memberInfoYn"
							name="memberInfoYn" value="Y"><span>동의합니다.</span>
						</label>
					</div>
					<div class="radio">
						<label> <input type="radio" id="memberInfoYn"
							name="memberInfoYn" value="N" checked> 동의하지 않습니다.
						</label>
					</div>
				</div>
			</div>
			<div class="form-group" id="divId">
				<label for="inputId" class="col-lg-2 control-label">아이디</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyAlphabetAndNumber"
						id="id" data-rule-required="true"
						placeholder="30자이내의 알파벳, 숫자만 입력 가능합니다" maxlength="30">
					<input type="text" class="check_btn" id="id_check" readonly disabled>
				</div>
			</div>
			<div class="form-group" id="divPassword">
				<label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="password"
						name="excludeHangul" data-rule-required="true" placeholder="패스워드"
						maxlength="30">
				</div>
			</div>
			<div class="form-group" id="divPasswordCheck">
				<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드
					확인</label>
				<div class="col-lg-10">
					<input type="password" class="form-control" id="passwordCheck"
						data-rule-required="true" placeholder="패스워드 확인" maxlength="30">
					<input type="text" class="check_btn" id="pw_check" readonly disabled>
				</div>
			</div>
			<div class="form-group" id="divName">
				<label for="inputName" class="col-lg-2 control-label">이름</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyHangul" id="name"
						data-rule-required="true" placeholder="한글만 입력 가능합니다."
						maxlength="15">
				</div>
			</div>

			<div class="form-group" id="divEmail">
				<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
				<div class="col-lg-10">
					<input type="text" class="form-control" id="email"
						data-rule-required="true" placeholder="이메일" maxlength="40">
					<input type="text" class="check_btn" id="email_check" readonly disabled>
				</div>
			</div>
			<div class="form-group" id="divPhoneNumber">
				<label for="inputPhoneNumber" class="col-lg-2 control-label">휴대폰
					번호</label>
				<div class="col-lg-10">
					<input type="text" class="form-control onlyNumber" id="phoneNumber"
						data-rule-required="true" placeholder="-를 제외하고 숫자만 입력하세요"
						maxlength="11">
					<input type="text" class="check_btn" id="phone_check" readonly disabled>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPhoneNumber" class="col-lg-2 control-label">성별</label>
				<div class="col-lg-10">
					<select id="gender">
						<option value="M">남자</option>
						<option value="F">여자</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="inputEmailReceiveYn" class="col-lg-2 control-label">이메일
					수신여부</label>
				<div class="col-lg-10">
					<label class="radio-inline"> <input type="radio"
						id="emailReceiveYn" name="emailReceiveYn" value="Y" checked>
						동의합니다.
					</label> <label class="radio-inline"> <input type="radio"
						id="emailReceiveYn" name="emailReceiveYn" value="N"> 동의하지
						않습니다.
					</label>
				</div>
			</div>
			<div class="form-group">
				<label for="inputPhoneNumber" class="col-lg-2 control-label">SMS
					수신여부</label>
				<div class="col-lg-10">
					<label class="radio-inline"> <input type="radio"
						id="smsReceiveYn" name="smsReceiveYn" value="Y" checked>
						동의합니다.
					</label> <label class="radio-inline"> <input type="radio"
						id="smsReceiveYn" name="smsReceiveYn" value="N"> 동의하지
						않습니다.
					</label>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button type="submit" class="btn btn-default">회원가입</button>
				</div>
			</div>
		</form>


		<script>
			var id_check = false;
			var pw_check = false;
			var name_check = false;
			var email_check = false;
			var phone_check = false;
			
			$(function() {
				
				$('.onlyAlphabetAndNumber').keyup(function(event) {
					if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
						var inputVal = $(this).val();
						$(this).val($(this).val().replace(/[^a-z0-9]/gi, '')); //_(underscore), 영어, 숫자만 가능
					}
				});

				$(".onlyHangul").keyup(function(event) {
					if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
						var inputVal = $(this).val();
						$(this).val(inputVal.replace(/[a-z0-9]/gi, ''));
					}
				});

				$(".onlyNumber").keyup(function(event) {
					if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
						var inputVal = $(this).val();
						$(this).val(inputVal.replace(/[^0-9]/gi, ''));
					}
				});
				
				$(".form-control").keyup(function(event) {
					var inputVal = $(this).val();
					
					if($.trim($(this).val()) != $(this).val()) {
						$(this).val($.trim($(this).val()));						
					}
				});

				$('#id').change(function(event) {

					var divId = $('#divId');
					id_check = false;

					if ($('#id').val() == "") {
						divId.removeClass("has-success");
						divId.addClass("has-error");
						$('#id_check').val(" ");
					} else {
						$.ajax({
							type: 'POST',
							url: 'Join_Check',
							data: {
								userID: $('#id').val()
								},
							success: function(result){
								if(result == '1') {
									$('#id_check').css("color", "green");
									$('#id_check').val("사용 할 수있는 아이디입니다");
									divId.removeClass("has-error");
									divId.addClass("has-success");
									id_check = true;
								} else if(result == '0') {
									$('#id_check').css("color", "red");
									$('#id_check').val("중복된 아이디가 존재합니다");
									divId.removeClass("has-success");
									divId.addClass("has-error");
								}
							} 
						})
					}
				});

				$('#password').change(function(event) {

					var divPassword = $('#divPassword');
					var divPasswordCheck = $('#divPasswordCheck');
					var passwordCheck = $('#passwordCheck').val();
					var password = $('#password').val();

					if ($('#password').val() == "") {
						divPassword.removeClass("has-success");
						divPassword.addClass("has-error");
					} else if(password != passwordCheck) {
						divPassword.removeClass("has-success");
						divPassword.addClass("has-error");
						divPasswordCheck.removeClass("has-success");
						divPasswordCheck.addClass("has-error");
						$('#pw_check').val("비밀번호가 일치하지 않습니다");
					} else {
						divPassword.removeClass("has-error");
						divPassword.addClass("has-success");
						divPasswordCheck.removeClass("has-error");
						divPasswordCheck.addClass("has-success");
						$('#pw_check').val(" ");
						pw_check = true;
					}
				});

				$('#passwordCheck').change(function(event) {

					var passwordCheck = $('#passwordCheck').val();
					var password = $('#password').val();
					var divPassword = $('#divPassword');
					var divPasswordCheck = $('#divPasswordCheck');
					pw_check = false;

					if (passwordCheck == "") {
						divPasswordCheck.removeClass("has-success");
						divPasswordCheck.addClass("has-error");
						$('#pw_check').val(" ");
					} else if(password != passwordCheck) {
						divPassword.removeClass("has-success");
						divPassword.addClass("has-error");
						divPasswordCheck.removeClass("has-success");
						divPasswordCheck.addClass("has-error");
						$('#pw_check').val("비밀번호가 일치하지 않습니다");
					} else {
						divPassword.removeClass("has-error");
						divPassword.addClass("has-success");
						divPasswordCheck.removeClass("has-error");
						divPasswordCheck.addClass("has-success");
						$('#pw_check').val(" ");
						pw_check = true;
					}
				});

				$('#name').change(function(event) {

					var divName = $('#divName');
					name_check = false;

					if ($.trim($('#name').val()) == "") {
						divName.removeClass("has-success");
						divName.addClass("has-error");
					} else {
						divName.removeClass("has-error");
						divName.addClass("has-success");
						name_check = true;
					}
				});

				$('#email').change(function(event) {

					var divEmail = $('#divEmail');
					email_check = false;

					if ($.trim($('#email').val()) == "") {
						divEmail.removeClass("has-success");
						divEmail.addClass("has-error");
					} else if(!$.trim($('#email').val()).match("@")) {
						divEmail.removeClass("has-success");
						divEmail.addClass("has-error");
						$('#email_check').css("color", "red");
						$('#email_check').val("올바른 이메일 형식이 아닙니다");
					} else {
						$.ajax({
							type: 'POST',
							url: 'Join_Check',
							data: {
								userEmail: $('#email').val()
								},
							success: function(result){
								if(result == '1') {
									$('#email_check').css("color", "green");
									$('#email_check').val("사용 할 수있는 이메일입니다");
									divEmail.removeClass("has-error");
									divEmail.addClass("has-success");
									email_check = true;
								} else if(result == '0') {
									$('#email_check').css("color", "red");
									$('#email_check').val("중복된 이메일이 존재합니다");
									divEmail.removeClass("has-success");
									divEmail.addClass("has-error");
								}
							} 
						})
					}
				});

				$('#phoneNumber').change(function(event) {

					var divPhoneNumber = $('#divPhoneNumber');
					phone_check = false;

					if ($.trim($('#phoneNumber').val()) == "") {
						divPhoneNumber.removeClass("has-success");
						divPhoneNumber.addClass("has-error");
					} else {
						$.ajax({
							type: 'POST',
							url: 'Join_Check',
							data: {
								userPhone: $('#phoneNumber').val()
								},
							success: function(result){
								if(result == '1') {
									$('#phone_check').css("color", "green");
									$('#phone_check').val("사용 할 수있는 휴대폰 번호 입니다");
									divPhoneNumber.removeClass("has-error");
									divPhoneNumber.addClass("has-success");
									phone_check = true;
								} else if(result == '0') {
									$('#phone_check').css("color", "red");
									$('#phone_check').val("중복된 휴대폰 번호가 존재합니다");
									divPhoneNumber.removeClass("has-success");
									divPhoneNumber.addClass("has-error");
								}
							} 
						})
					}
				});

				//------- validation 검사
				$("form").submit(
						function(event) {

							var provision = $('#provision');
							var memberInfo = $('#memberInfo');
							var divId = $('#divId');
							var divPassword = $('#divPassword');
							var divPasswordCheck = $('#divPasswordCheck');
							var divName = $('#divName');
							var divNickname = $('#divNickname');
							var divEmail = $('#divEmail');
							var divPhoneNumber = $('#divPhoneNumber');

							//회원가입약관
							if ($('#provisionYn:checked').val() == "N") {
								var offset = provision.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);

								provision.removeClass("has-success");
								provision.addClass("has-error");
								$('#provisionYn').focus();
								
								return false;
							} else {
								provision.removeClass("has-error");
								provision.addClass("has-success");
							}

							//개인정보취급방침
							if ($('#memberInfoYn:checked').val() == "N") {
								var offset = memberInfo.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								memberInfo.removeClass("has-success");
								memberInfo.addClass("has-error");
								$('#memberInfoYn').focus();
								
								return false;
							} else {
								memberInfo.removeClass("has-error");
								memberInfo.addClass("has-success");
							}

							//아이디 검사
							if (id_check == false) {
								var offset = divId.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								divId.removeClass("has-success");
								divId.addClass("has-error");
								$('#id').focus();
								
								return false;
							} else {
								divId.removeClass("has-error");
								divId.addClass("has-success");
							}

							//패스워드 검사
							if (pw_check == false) {
								var offset = divPasswordCheck.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								divPassword.removeClass("has-success");
								divPassword.addClass("has-error");
								divPasswordCheck.removeClass("has-success");
								divPasswordCheck.addClass("has-error");
								$('#passwordCheck').focus();
								
								return false;
							} else {
								divPassword.removeClass("has-error");
								divPassword.addClass("has-success");
								divPasswordCheck.removeClass("has-error");
								divPasswordCheck.addClass("has-success");
							}

							//이름
							if (name_check == false) {
								var offset = divName.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								divName.removeClass("has-success");
								divName.addClass("has-error");
								$('#name').focus();
								
								return false;
							} else {
								divName.removeClass("has-error");
								divName.addClass("has-success");
							}

							//이메일
							if (email_check == false) {
								var offset = divEmail.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								divEmail.removeClass("has-success");
								divEmail.addClass("has-error");
								$('#email').focus();
								
								return false;
							} else {
								divEmail.removeClass("has-error");
								divEmail.addClass("has-success");
							}

							//휴대폰 번호
							if (phone_check == false) {
								var offset = divPhoneNumber.offset();
								$('html').animate({scrollTop : offset.top + offset.height/2}, 400);
								
								divPhoneNumber.removeClass("has-success");
								divPhoneNumber.addClass("has-error");
								$('#phoneNumber').focus();
								
								return false;
							} else {
								divPhoneNumber.removeClass("has-error");
								divPhoneNumber.addClass("has-success");
							}
							
							alert(
								"회원 아이디 : " + 	$('#id').val() +
								"회원 이름 : " + $('#name').val() +
								"회원 이메일주소 : " + $('#email').val() +
								"회원 휴대폰번호 : " + $('#phoneNumber').val() +
								"회원 성별 : " + $('#gender').val() +
								"이메일 수신동의 : " + $('#emailReceiveYn:checked').val()
							);
						});

			});
		</script>
	</div>
	<jsp:include page="Copyright.jsp"></jsp:include>
</body>
</html>