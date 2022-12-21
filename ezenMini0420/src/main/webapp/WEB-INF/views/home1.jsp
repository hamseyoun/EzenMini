<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>    
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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<title>Home</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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

/*캐러셀 박스를 풀로 채우기 */
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
</style>
</head>
<body>
<!-- 로그인 id반환 var값 user_id를 EL 로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="user_id" />		
</sec:authorize>

<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h3 class="text-center multiEffect">Home페이지로 BS4, jQuery, Ajax, RWD를 이용하고 있습니다</h3>
	</div>
</div>

<nav class="navbar navbar-expand-md bg-dark navbar-dark container font-weight-bold sticky-top">
	<button class="navbar-brand btn" >
		<img src="images/bird.jpg" alt="Logo" style="width:40px;">
	</button>
	<!-- 컬랩스용 버튼(화면 축소시 생기는 상병 계급장 표시 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			 <li class="nav-item">
			 	<button class="nav-link btn" >
			 		<i class="fas fa-home" style="font-size:30px;color:white;"></i>
			 	</button>
			 </li>
			 <li class="nav-item">
			 	<button class="nav-link btn" >핫 플레이스</button>
			 </li>
			 <li class="nav-item">
			 	<button class="nav-link btn" >핫 레시피</button>
			 </li>
			 <li class="nav-item">
			 	<button class="nav-link btn" >핫 애완동물</button>
			 </li>
			 <li class="nav-item dropdown">
			 	<button class="nav-link dropdown-toggle btn"  id="navbardrop" data-toggle="dropdown">
			 		알림판
			 	</button>
			 	<div class="dropdown-menu">
			 		 <button class="dropdown-item btn" >공지사항</button>
			 		 <button class="dropdown-item btn" >게시판</button>
			 		 <button class="dropdown-item btn" >Q&amp;A</button>
			 	</div>
			 </li>
			 <li class="nav-item">
	 			<button class="nav-link btn" >DashBoard</button>
	 		 </li>
	 		 <li class="nav-item">
	 			<button class="nav-link btn" >Utils</button>
	 		 </li>
			 <li class="nav-item">
	 			<button class="nav-link btn" >About...</button>
	 		 </li>
	 		 <li class="nav-item">
	 		 	<button class="nav-link btn" >회원가입</button> 
	 		 </li>	 		
		</ul>
		<ul class="navbar-nav ml-auto">
			<sec:authorize access="isAnonymous()">  <!-- 로그인 안한 상태면 로그인 버튼 보임  -->
				<li class="nav-item">
					<button class="nav-link btn" >로그인</button>
				</li>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()"> <!-- 로그인 한 상태면 로그아웃버튼을 보여줌 -->
				<li class="nav-item">
					<button class="nav-link btn" >로그아웃</button>	
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
		<button class="carousel-control-prev btn"  data-slide="prev"> <!-- 앞전 -->
			<span class="carousel-control-prev-icon"></span> <!-- 아이콘처리 -->
		</button>
		<button class="carousel-control-next btn"  data-slide="next"> <!-- 뒤 -->
			<span class="carousel-control-next-icon"></span> <!-- 아이콘처리 -->
		</button>
	</div>
</div>

</body>
</html>

