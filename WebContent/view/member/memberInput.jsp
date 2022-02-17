<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ajax.js"></script>
<script>
function win_upload() {
	const op = "width=500, height=150, left=150, top=150"
	open("<%=request.getContextPath()%>/single/pictureForm.jsp","", op);
}

function idChk() {
	const id = document.f.id.value
	let result = document.querySelector("#result")
	const param = "id="+id
	
	if(id.length<8){ //id 길이가 8보다 작은 경우
		result.style.color = "red"
		result.innerHTML = "id는 8자리 이상이어야 합니다."
		document.f.chk.value="no"
	}else{	//database 입력 id 확인
		ajax("<%=request.getContextPath()%>/single/readId.jsp",param,callback,"get")
	}
	
}

function callback() {
	if(this.readyState == 4 && this.status == 200){	//network ok
		let result = document.querySelector("#result")
		let chk = this.responseText.trim()
		if(chk=='false'){
			result.style.color="blue"
			result.innerHTML="사용 가능한 id 입니다."
			document.f.chk.value="ok"
		}else{
			result.style.color="red"
			result.innerHTML="이미 존재하는 id 입니다."
			document.f.chk.value="no"
		}
		
	}
}

function inputcheck(f) {
	let result = document.querySelector("#result")
	if(f.id.value==""){
		alert("아이디를 입력하세요")
		f.id.focus()
		return false
	}
	if(f.chk.value!="ok"){
		alert(result.innerHTML)
		f.id.focus()
		return false
	}
	if(f.pass.value==""){
		alert("비밀번호를 입력하세요")
		f.pass.focus()
		return false
	}
	if(f.name.value==""){
		alert("이름을 입력하세요")
		f.name.focus()
		return false
	}
	if(f.gender.value==""){
		alert("성별을 체크해주세요")
		return false
	}
	if(f.tel.value==""){
		alert("전화번호를 입력해주세요")
		f.tel.focus()
		return false
	}
	if(f.email.value==""){
		alert("이메일을 입력해주세요")
		f.email.focus()
		return false
	}
	return true;
}

</script>
</head>
<body>
<hr>


	<div class="container">
		<h2   id="center">회원가입</h2>
		<form action="<%=request.getContextPath()%>/view/member/memberPro.jsp" method="post" 
		name="f" onsubmit="return inputcheck(this)">
		<input type="hidden" name="picture">
		<input type="hidden" name="chk">
		<div class="row">
			<div class="col-3   bg-light">
				<img src="" width="100" height="120" id="pic"><br>
				<button type="button" class="btn btn-dark" onclick="win_upload()">사진등록</button>

			</div>
			<div class="col-9">
				<div class="form-group">

					<label for="id">아이디:&nbsp;&nbsp;<span id="result">8자리 이상 가능합니다</span></label>
					<input type="text" class="form-control" name="id" onkeyup="idChk()">
					<label for="pwd">비밀번호:</label>
					<input type="password" class="form-control" id="pwd" name="pass"> 
					<label for="name">이름:</label>
					<input type="text" class="form-control"	id="name" name="name">
					<label for="gender">성별:</label>
					<label class="radio-inline"> </label>
					<input type="radio" name="gender" value="1">남 
					<label class="radio-inline"> </label>
					<input type="radio" name="gender" value="2">여
				</div>

			</div>
		</div>
		<div class="form-group">

			<label for="tel">전화번호:</label> <input type="text"
				class="form-control" name="tel">
		</div>
		<div class="form-group">

			<label for="tel">이메일:</label> <input type="text" class="form-control"
				name="email">
		</div>

	




	<div id="center" style="padding: 3px;">
		<button type="submit" class="btn btn-dark">회원가입</button>
	</div>
	</form>
</div>
</body>
</html>