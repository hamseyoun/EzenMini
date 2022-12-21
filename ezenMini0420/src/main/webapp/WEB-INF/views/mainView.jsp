<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %> 
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!-- RWD -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- MS -->
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8,IE=EmulateIE9"/> 
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/> <!-- 페이지위조요청을 방지를 위한 태그 -->

<title>Main 레시피</title>
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- 그래픽표처리용 Chart.js API 라이브러리 추가 --> 
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--fontawesome icon-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" 
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<!--google icon -->
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

<style>
/*브라우져별 상이함을 통일 */
html,body {
	height : 100%;
	margin : 0px;
	padding : 0px;
}
.navbar {
	border-radius: 0px;
	margin-bottom : 0px;  
}

/*캐러셀 박스를 FULL로 채우기 */
.carousel-inner img {
	/*RWD를 위해 처리 */
	width: 100%;
	height : 100%;
}

.wordArtEffect { /*워드아트 형태글자로 줌 */
	color :white;
	text-shadow : 0px 0px 3px darkBlue;
}
.threeDEffect { /*3d효과 */
	color : white;
	text-shadow : 2px 2px 4px black;
}
.multiEffect {  /* 3개의 효과 동시 적용 */
	color : yellow;
	text-shadow : 2px 2px 2px black,0 0 25px blue,0 0 5px darkblue;
}

.fakeimg {
	height: 200px;
	background: #aaaaaa;
}

#mainRegion {
	height : auto;
}
</style>
</head>
<body  onload="noBack();"  onpageshow="if(event.persisted) noBack();" onunload="">

<!-- 로그인 id반환 var값 user_id를 EL 로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />		
</sec:authorize>

<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h4 id="hjumbo" class="text-center multiEffect">
		Home페이지로 BS4, jQuery, Ajax, RWD를 이용하고 있으며 서버는 스프링,시큐리티,마이바티스,오라클을 사용합니다
		</h4>
	</div>
</div>

<nav class="navbar navbar-expand-md bg-dark navbar-dark container font-weight-bold sticky-top">
	<a class="navbar-brand" href="#">
		<img src="images/bird.jpg" alt="Logo" style="width:40px;">
	</a>
	<!-- 컬랩스용 버튼(화면 축소시 생기는 상병 계급장 표시 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			 <li class="nav-item">
			 	<a id="mHome" class="nav-link" href="mHome"> <!-- ajax안하고 전체창 -->
			 		<i class="fas fa-home" style="font-size:30px;color:white;"></i>
			 	</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="#">핫 플레이스</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="main">핫 레시피</a> <!-- 로그인후 첫번째창 -->
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="#">핫 애완동물</a>
			 </li>
			 <li class="nav-item dropdown">
			 	<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			 		알림판
			 	</a>
			 	<div class="dropdown-menu">
			 		 <a class="dropdown-item" href="#">공지사항</a>
			 		 <a id="eBoard" class="dropdown-item" href="eBoard">게시판</a>
			 		 <a class="dropdown-item" href="#">Q &amp;A</a>
			 	</div>
			 </li>
			 <li class="nav-item">
	 			<a id="dashBoard" class="nav-link" href="dash">DashBoard</a>
	 		 </li>
	 		 <li class="nav-item">
	 			<a id="mUtil" class="nav-link" href="util">Utils</a>
	 		 </li>
	 		 <sec:authorize access="isAuthenticated()">
				 <li class="nav-item">
		 			<a id="mAbout" class="nav-link d-none" href="about">About...</a>
		 		 </li>
	 		 </sec:authorize>
	 		 <sec:authorize access="isAnonymous()">
		 		 <li class="nav-item">
		 		 	<a id="joinView" class="nav-link" href="joinView">회원가입</a> 
		 		 </li>
	 		 </sec:authorize>
	 		 <sec:authorize access="isAuthenticated()">
	 		 	 <li class="nav-item">
		 		 	<a class="nav-link" href="#">${user_id}</a>
		 		 </li>
	 		 </sec:authorize>
	 		 <!--auth가 ROLE_ADMIN이면 활성화  -->
	 		 <sec:authorize access="hasRole('ROLE_ADMIN')">
			  	 <li class="nav-item">
		 		 	<a id="adminView" class="nav-link" href="adminView">Admin</a> 
		 		 </li>
			 </sec:authorize>			
		</ul>
		<ul class="navbar-nav ml-auto"> <!-- login,logout창은 ajax안되니 별도 창 -->
			<sec:authorize access="isAnonymous()">  <!-- 로그인 안한 상태면 로그인 버튼 보임  -->
				<li class="nav-item">
					<a id="loginView" class="nav-link" href="loginView">로그인</a>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()"> <!-- 로그인 한 상태면 로그아웃버튼을 보여줌 -->
				<li class="nav-item">
					<a class="nav-link" href="logoutView">로그아웃</a>	
				</li>
			</sec:authorize>
		</ul> 
	</div>	
</nav>

<div class="container mt-1 border border-dark p-0">
	<!-- 캐러셀을 구현하는 콘테이너 클래스 carousel slide와 data-ride="carousel"속성이 필요 -->
	<div id="demo" class="carousel slide p-0" data-ride="carousel" data-interval="4000">
		<!-- 슬라이드의 위치를 표시하는 마커 엘리먼트는 ul을 이용,class="carousel-indicators"를 사용-->
		<!--data-target은 마커 위치,data-slide-to는 슬라이드 번호  -->
		<ul class="carousel-indicators">
			<li data-target="#demo" data-slide-to="0" class="active"></li>
			<li data-target="#demo" data-slide-to="1" ></li>
			<li data-target="#demo" data-slide-to="2" ></li>			
		</ul>
		<!--class="carousel-inner"는 스라이드 사진 포함하는 콘테이너  -->
		<!-- class="carousel-item"은 각각의 스라이드 사진을 나타내는 콘테이너로 이미지사진을 포함 -->
		<div class="carousel-inner">
			<div class="carousel-item active">
				 <img src="images/la.jpg" 
				 	alt="Los Angeles" />
				 <!-- img뒤에 carousel-caption클래스 콘테이너를 마들고 제목과 살명 추가 -->
				 <div class="carousel-caption">
			        <h3>Los Angeles</h3>
			        <p>We had such a great time in LA!</p>
			     </div>   	
			</div>
			<div class="carousel-item">
				 <img src="images/chicago.jpg" 
				 	alt="Chicago" />
				 <div class="carousel-caption">
			        <h3>Chicago</h3>
			        <p>We had such a great time in LA!</p>
			     </div>    	
			</div>
			<div class="carousel-item">
				 <img src="images/ny.jpg" 
				 	 alt="New York" />
				  <div class="carousel-caption">
			        <h3>New York</h3>
			        <p>We had such a great time in LA!</p>
			     </div>   	
			</div>
		</div>
		
		<!-- 좌,우 콘트롤은 a를 사용하고 앞전으로 뒤로 가기를 처리 -->
		<a class="carousel-control-prev" href="#demo" data-slide="prev"> <!-- 앞전 -->
			<span class="carousel-control-prev-icon"></span> <!-- 아이콘처리 -->
		</a>
		<a class="carousel-control-next" href="#demo" data-slide="next"> <!-- 뒤 -->
			<span class="carousel-control-next-icon"></span> <!-- 아이콘처리 -->
		</a>
	</div>
</div>

<!-- ajax로 처리시 나타내줄 메인 페이지 영역 -->
<!-- 메인 레시피화면 -->
<!-- 이페이지는 recipe의 첫페이지 이므로 요리 리스트를 보여줌  -->
<div id="mainRegion" class="container mt-5 p-0">
	<a id="rwriteView" class="btn btn-success" href="rwriteView">레시피등록</a>&nbsp;&nbsp;
	<a id="recipeCart" class="btn btn-info" href="recipeCart">장바구니 목록</a>&nbsp;&nbsp;
	<h3 class="text-center text-info multiEffect mt-2">레시피</h3>
	<div class="row mb-3" style="height:auto;">
		<c:forEach items="${recipeList}" var="dto">
			<div class="col-md-4 mb-5"  >
				<div class="card">
					<h5>${dto.rClass}</h5> <!-- 요리구분 -->
					<img class="card-img-top mx-auto" src="upimage/${dto.rPhoto}" alt="Card image" style="max-width:280px;height:280px">
					<div class="card-body">					    
						<h5 class="card-title">식당명 : ${dto.rtrName}</h5>
						<h5 class="card-text">요리명 : ${dto.rTitle}</h5>
						<h5 class="card-text">가격 : ${dto.rPrice}원</h5>
						<a href="recipeDetails?rId=${dto.rId}" class="pclick btn btn-primary stretched-link">
							자세히 보기
						</a>
					</div>
				</div>
			</div>
		</c:forEach>		
	</div>	
</div>

<!-- footer영역 -->
<footer class="container mt-5 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3 class="text-center threeDEffect">Online Store Copyright</h3>
		<form action="#" method="POST">
			<div class="form-group">
				<label for="email">&nbsp;&nbsp;주문 문의</label>
			    <input type="email" class="form-control" placeholder="Enter email" id="email"/>
			</div>
			<button type="submit" class="btn btn-danger">Sign Up</button>
		</form>
	</div>
</footer>

<!-- modal -->
<div class="container mt-2">
	<button id="modal" type="button" class="btn btn-primary d-none" data-toggle="modal" data-target="#myModal" >
		 Open modal
	</button>
</div>

<div class="modal fade" id="myModal">
	 <div class="modal-dialog">
	 	<div class="modal-content">
	 		<div class="modal-header bg-info">
	 			<h4 class="modal-title multiEffect"><i class="fa fa-info-circle" aria-hidden="true">Info</i></h4>
	 			<button class="mclose" type="button" class="close" data-dismiss="modal">&times;</button>
	 		</div>
	 		<div class="modal-body">	 			
	 			<h4><i class="fa fa-user-circle fa-3x multiEffect" aria-hidden="true"></i></h4><h4 id="mbody" class="text-center multiEffect"></h4>
	 		</div>
	 		<div class="modal-footer">
	 			<button class="mclose" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	 		</div>
	 	</div>
	 </div>	
</div>

<script>
$(document).ready(function(){
	$("#hjumbo").text("로그인 성공후 첫페이지 입니다.");
	//레시피 등록 창
	$("#rwriteView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : "rwriteView",
			type: "get",
			data : "",
			success : function(data){
				$("#hjumbo").text("레시피 등록창입니다.");
				$("#mainRegion").html(data);
			},
			error: function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	//상세정보 보기
	$(".pclick").click(function(event){
		event.preventDefault();
		let evo = $(event.target); //클릭이벤트가 일어난 엘리먼트 선택
		let url = evo.attr("href");		
		$.ajax({
			url : url,
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("레시피 상세정보창입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	$("#adminView").click(function(event){
		event.preventDefault();
		$.ajax({
			url : "adminView" ,
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("관리자 페이지입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	$("#mHome").click(function(event){
		event.preventDefault();
		$.ajax({
			url : "mHome" ,
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Main내부의 Home입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	$("#eBoard").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#eBoard").attr("href"),
			type : "GET",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Main내부의 게시판입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	$("#mUtil").click(function(event){
		event.preventDefault();		
		$.ajax({
			url : $("#mUtil").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("Utility모음 입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	/*
	$("#mAbout").click(function(event){
		event.preventDefault();		
		$.ajax({
			url : $("#mAbout").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("우리회사 정보창입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});	*/
	
	$("#dashBoard").click(function(event){
		event.preventDefault();		
		$.ajax({
			url : $("#dashBoard").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("DashBoard페이지 입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});
	
	$("#recipeCart").click(function(event){
		event.preventDefault();		
		$.ajax({
			url : $("#recipeCart").attr("href"),
			type : "get",
			data : "",
			success : function(data) {
				$("#hjumbo").text("나의 장바구니 페이지 입니다.");
				$("#mainRegion").html(data);
			},
			error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
			}
		});
	});	
	
});
</script>

<!-- back방지 -->
<!-- 
<script>
history.pushState(null, null, location.href); //브라우저의 세션 기록 스택에 상태를 추가합니다.
//location.href은 현재 페이지 등록
window.addEventListener('popstate', function(event) {
    history.pushState(null, null, location.href); 	
});
// history.pushState(state, title, url);state는 전달 데이터,title은 변경브라우져제목,url은 변경 주소
//popstate 이벤트는 사용자의 세션 기록 탐색으로 인해 현재 활성화된 기록 항목이 바뀔 때 발생합니다. 
//만약 활성화된 엔트리가 history.pushState() 메서드나 history.replaceState() 메서드에 의해 생성되면,
//popstate 이벤트의 state 속성은 히스토리 엔트리 state 객체의 복사본을 갖게 됩니다.
//page내부에서는 안되나 페이지 외부는 이동
</script>
 -->
 
 <script>
window.history.forward();
function noBack() {
	window.history.forward();
}
</script>
</body>

</html>

<!-- 
[Spring] 동시 접속자 수 계산해주는 Listener 객체
https://jeaha.dev/121
 -->