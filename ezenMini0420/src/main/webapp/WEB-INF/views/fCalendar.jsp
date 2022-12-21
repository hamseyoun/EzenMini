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
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/> 
<title>Full Calendar</title>
<!--bootstrap-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<!--jquery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!--propper jquery -->
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<!--latest javascript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<!-- full calendar용 api라이브러리 -->	
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.2/main.min.css' rel='stylesheet'/>

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

 
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">  
 
<!-- 로그인 id반환 var값 user_id를 EL 로 사용 -->
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="userId" />		
</sec:authorize>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /><!-- security csrf -->

<div class="container mt-1 p-0">
	<div class="jumbotron text-center mb-0 p-4">
		<h4 id="hjumbo" class="text-center multiEffect">
			FullCalendar를 활용한 스케쥴러로 spring security서버와 연동되어 활용합니다
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
			 	<a id="mHome" class="nav-link"> <!-- ajax안하고 전체창 -->
			 		<i class="fas fa-home" style="font-size:30px;color:white;"></i>
			 	</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link">핫 플레이스</a>
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link" href="main">핫 레시피</a> <!-- 로그인후 첫번째창 -->
			 </li>
			 <li class="nav-item">
			 	<a class="nav-link">핫 애완동물</a>
			 </li>
			 <li class="nav-item dropdown">
			 	<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			 		알림판
			 	</a>
			 	<div class="dropdown-menu">
			 		 <a class="dropdown-item" >공지사항</a>
			 		 <a id="eBoard" class="dropdown-item" >게시판</a>
			 		 <a class="dropdown-item" >Q &amp;A</a>
			 	</div>
			 </li>
			 <li class="nav-item ">
	 			<a class="nav-link" >DashBoard</a>
	 		 </li>	 		 
	 		 <li class="nav-item ">
	 			<a id="fcUtil" class="nav-link d-none">Utils</a>
	 		 </li>	 		 
			 <li class="nav-item">
	 			<a class="nav-link" >About...</a>
	 		 </li>
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
		 		 	<a id="fadminView" class="nav-link" >Admin</a> 
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

<div id="mainRegion" class="container mt-5 p-0">
	<div id='calendar'></div> <!-- full calendar표시 영역 -->
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
<!--EL과 c:out은 화면에 보이는 그대로의 값이므로 JS에 문자열 변수를 나타낼시는 ""안에 사용 -->
<!--가능하면 EL만 사용하는 것보다는 c:out이 보안에 강하다 -->
let calendar = null;
//let user_id = "${userId}";
let user_id = '<c:out value="${userId}"></c:out>';
$(document).ready(function(){
	$(function(){ //jquery에서 자동 실행 함수
		 let request = $.ajax({ //calendar로 요청한 결과를 저장하는 변수 request(list기능)
			 url : "calendar?cId=${userId}",
			 type : "get",
			 dataType : "json"
		 });
	     request.done(function(data){ //request수행후 마지막 작업 처리, data는 반환된 값으로 js 객체 배열
	    	 console.log(data);
	    	 let calendarEl = document.getElementById('calendar');	    	 
	    	 calendar = new FullCalendar.Calendar(calendarEl,{
	    		 timeZone : "Asia/Seoul",
	    		 headerToolbar : {
	    			 left: 'prev,next today', 
	    			 center : 'title',
	    			 right : 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
	    		 },
	    		 navLinks: true,
	    		 editable: true,
	    		 selectable: true,
	    		 droppable: true, 
	    		 eventDrop : function(info) {
	    			 let obj = new Object();
	    			 if(confirm("'"+ info.event.title +"'의 일정을 수정하시겠습니까 ?")) { //confirm창의 확인 클릭시 true
	    				 obj.cTitle = info.event._def.title;
	    				 obj.cStart = info.event._instance.range.start;
                		 obj.cEnd = info.event._instance.range.end;
                		 obj.cAllDay = info.event._instance.range.allDay;
                		 obj.cNo = info.event.extendedProps.cNo; //추가된 속성,fullcalendar데이터베이스의 번호
                		 obj.cId = user_id; //사용자 아이디
                		 obj.oldTitle = info.oldEvent._def.title;
                		 obj.oldStart = info.oldEvent._instance.range.start;
                		 obj.oldEnd = info.oldEvent._instance.range.end;
                		 obj.oldAllDay = info.oldEvent._instance.range.allDay;
                		 console.log(obj);
                		 $(function modifyData(){
                			 $.ajax({
                				 url: "calendarUpdate", 
                				 method: "post",
                				 dataType: "json",
                				 data: JSON.stringify(obj),
                				 contentType: 'application/json',
                				 beforeSend : function(xhr) {
                					 xhr.setRequestHeader('X-CSRF-Token', $('input[name="${_csrf.parameterName}"]').val());
                				 }
                			 });
                		 });
	    			 }
	    			 else {
	    				 info.revert(); //원래창 유지
	    			 }
	    			 calendar.unselect();
	    			 location.reload();	    			 
	    		 },
	    		 
	    		 eventResize: function(info) { //drag기능(수정기능)
	    			 console.log(info);
	    			 var obj = new Object();
	    			 if(confirm("'"+ info.event.title +"' 의 일정을 수정하시겠습니까 ?")) {
	    				 obj.cTitle = info.event._def.title;
	    				 obj.cStart = info.event._instance.range.start;
	    				 obj.cEnd = info.event._instance.range.end; 
                         obj.cAllDay = info.event._instance.range.allDay;
                         obj.cNo = info.event.extendedProps.cNo; //추가된 속성
                         obj.cId = user_id;
                         obj.oldTitle = info.oldEvent._def.title;
                         obj.oldStart = info.oldEvent._instance.range.start;
                         obj.oldEnd = info.oldEvent._instance.range.end;
                         obj.oldAllDay = info.oldEvent._instance.range.allDay;
                         console.log(obj);
                         $(function modifyData(){
                        	 $.ajax({
                        		 url: "calendarUpdate",
                        		 type : "post",
                        		 dataType : "json",
                        		 data : JSON.stringify(obj),
                        		 contentType: 'application/json',
                        		 beforeSend : function(xhr) {
                        			 xhr.setRequestHeader('X-CSRF-Token', $('input[name="${_csrf.parameterName}"]').val());
                        		 }
                        	 });
                         });
	    			 }
	    			 else {
	    				 info.revert(); 
	    			 }
	    			 calendar.unselect();
	    			 location.reload(); //화면 갱신	    			 	    			 
	    		 },
	    		 select: function(arg) { //insert기능(작성 기능)
	    			 var title = prompt('일정명을 기록하고 일정을 선택하세요.');
	    		     if(title) {
	    		    	 calendar.addEvent({
	    		    		 title: title, //입력한 값 title을 title속성에
	    		    		 start: arg.start,
                             end: arg.end,
                             allDay: arg.allDay //boolean
	    		    	 });
	    		    	 console.log(arg);
	    		    	 var obj = new Object();
	    		    	 obj.cNo = 100;
	    		    	 obj.cId = user_id; 
	    		    	 obj.cTitle = title;
	    		    	 obj.cStart = arg.start; 
	    		    	 obj.cEnd = arg.end; 
	    		    	 if(arg.allDay == true ) { //여기서는 boolean이나 DB는 boolean이 없어 문자열로 변환하여 보냄
	    		    		 obj.cAllDay = "true";	    		    		 
	    		    	 }
	    		    	 else {
	    		    		 obj.cAllDay = "false"; 
	    		    	 }
	    		    	 console.log(obj);
	    		    	 $(function saveData(){
	    		    		 $.ajax({
	    		    			 url: "calendarInsert", 
	    		    			 type : "post",
	    		    			 dataType: "json",
	    		    			 data: JSON.stringify(obj),
	    		    			 contentType: 'application/json',
	    		    			 beforeSend : function(xhr) { //obj형태로 보낼시 csrf보장
	                                	  xhr.setRequestHeader('X-CSRF-Token', $('input[name="${_csrf.parameterName}"]').val());
	                             }            
	    		    		 });
	    		    	 });	    		    	 
	    		     }
	    		     else {
	    		    	 
	    		     }
	    		     calendar.unselect();
	    		     location.reload(); //화면 갱신               	  	       
	    		 },
	    		 eventClick: function(info) { //작성된 일정을 클릭하는 기능으로 제거(delete)기능
	    			 if(confirm("'"+ info.event.title +"' 일정을 삭제하시겠습니까 ?")) {
	    				 info.event.remove();
	    				 console.log(info.event);  
	    				 var obj = new Object();
                         obj.cTitle = info.event._def.title;
                         obj.cStart = info.event._instance.range.start;
                         obj.cEnd = info.event._instance.range.end; 
                         obj.cId = user_id;
                         obj.cNo = info.event.extendedProps.cNo; //추가된 속성
                         console.log(obj);
                         $(function deleteData(){
                        	 $.ajax({
                        		 url:  "calendarDelete",
                        		 type : "post",
                        		 dataType: "json",
                                 data: JSON.stringify(obj),
                                 contentType: 'application/json',
                                 beforeSend : function(xhr) { //obj형태로 보낼시 csrf보장
                               	  	xhr.setRequestHeader('X-CSRF-Token', $('input[name="${_csrf.parameterName}"]').val());
                                 }  
                        	 });
                         });
	    			 } 
	    			 else {
	    				  
	    			 }
	    			 calendar.unselect();
	    			 location.reload(); //화면 갱신
               	  	
	    		 },
	    		 locale : 'ko',
	    		 events : data //받은 결곽값(js객체 배열 값)을 저장하는 객체
	    	 });
	    	 calendar.render();
	     });
	});
});

/*
$("#fcUtil").click(function(event){
	event.preventDefault();	
	$.ajax({
		url : $("#fcUtil").attr("href"),
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

$("#fadminView").click(function(event){
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
*/
</script>


<!-- back방지 -->
<!-- 
<script>
history.pushState(null, null, "");
window.addEventListener('popstate', function(event) {
    history.pushState(null, null, ""); 
});
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