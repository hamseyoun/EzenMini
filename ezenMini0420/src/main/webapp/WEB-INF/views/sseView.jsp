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
<title>JSP</title>
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
</head>
<body>

<button type="button" id="sebtn" class="btn btn-primary">싱글이벤트</button>&nbsp;&nbsp;
<button type="button" id="mebtn" class="btn btn-success">멀티이벤트</button>&nbsp;&nbsp;
<button type="button" id="sseStop" class="btn btn-danger" >싱글이벤트 종료</button>&nbsp;&nbsp;
<button type="button" id="mseStop" class="btn btn-info" >멀티이벤트 종료</button>

<h3 class="text-center wordArtEffect mb-3 mt-3">서버 센트 이벤트</h3>
<br/><br/>
<!-- 이벤트 출력 창 -->
<div id="subMain">
	<h4 class="text-center wordArtEffect mb-3">싱글이벤트 내용</h4>	
</div>
<h4 class="text-center wordArtEffect mb-3">멀티이벤트 내용1</h4>
<div id="sseDisp2" class="text-center mb-3"></div> <!-- 멀티1 -->
<h4 class="text-center wordArtEffect mb-3">멀티이벤트 내용2</h4>
<div id="sseDisp3" class="text-center mb-3"></div> <!-- 멀티2 -->
<script>

$(document).ready(function(){
	let eventSource1;
	let eventSource2;
	$("#sebtn").click(function(){
		//이벤트를 받기 위한 이벤트소스 객체 생성
		//실제로 주기적으로 서버로 요청
		eventSource1 = new EventSource("seventEx");  //seventEx는 콘트롤라의 경로
		eventSource1.onmessage = function(event) {  //이벤트 업데이트시마다 message이벤트 발생,event객체는 서버의 이벤트 내용 객체
			//$("#sseDisp1").text(event.data); //'event객체에 발생한 업데이트된 데이터 data가 실려옴
			pageEvent(event);
		}
	});
	
	$("#mebtn").click(function(){
		//이벤트를 받기 위한 이벤트소스 객체 생성
		eventSource2 = new EventSource("meventEx");  //seventEx는 콘트롤라의 경로
		eventSource2.addEventListener("upVote",function(event){
			$("#sseDisp2").text(event.data);
		},false);
		//upVote는 서버에서 정한 이벤트 종류,이벤트 처리 함수, false는 캡쳐링으로 버블링 방식
		eventSource2.addEventListener("downVote",function(event){
			$("#sseDisp3").text(event.data);
		},false);
	});	
	
	$("#sseStop").click(function(){
		eventSource1.close();
	});
	
	$("#mseStop").click(function(){
		eventSource2.close();
	});
});

function pageEvent() {
	$.ajax({
		url : "dash",
		type : "get",
		//dataType : "html",
		success : function(data) {
			$("#hjumbo").text("이벤트에서 호출한 main");
			$("#subMain").html(data);
		},
		error : function() {
			$("#mbody").text("서버접속 실패!.");
			$("#modal").trigger("click");	
		}
	});
}
</script>
</body>
</html>