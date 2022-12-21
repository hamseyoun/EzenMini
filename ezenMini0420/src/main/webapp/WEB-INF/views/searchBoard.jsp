<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>   
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix ="sec" uri = "http://www.springframework.org/security/tags" %>
<%@ page session="false" %>              
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<!--RWD first-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>index</title>
</head>
<body>

<h3 class="text-center text-danger multiEffect">검색용게시판</h3>
<a href="eBoard" id="searchBoard" class="btn btn-primary">목록보기</a> <br/>;
<form id = "searchForm" class="form-inline"  action="#">		
  		<button class="btn btn-success ml-auto" type="button" disabled><i class="fa fa-search"></i></button>
    	<input id="searchInput" class="form-control mr-sm-2" type="text" placeholder="Search">    	
</form> 	
<table id="searchTable" class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>번호</th>
			<th>작성자</th>
			<th>제목</th>
			<th>작성일</th>
			<th>히트수</th>	
		</tr>
	</thead>	
	<tbody>	
		<c:forEach items="${listContent}" var="dto">
			<tr>
				<td class="bid">${dto.bId}</td>
				<td>${dto.bName}</td> <!-- bName은 user id -->
				<td>
					<c:forEach begin="1" end="${dto.bIndent}">-</c:forEach>
					<a class="contentView" href="contentView?bId=${dto.bId}">${dto.bTitle}</a>
				</td>
				<td>${dto.bDate}</td> <!-- Timestamp형의 문자열로 출력 -->
				<td>${dto.bHit}</td>
		    </tr>
		</c:forEach>
	</tbody>	
</table>

<!--  
<script>
//페이지 구현
//$(function(){}); 는 $(document).ready(function(){});과 동일

$(function(){	
	window.pagObj = $("#pagination").twbsPagination({
		totalPages: 1, //총 페이지 수
		visiblePages: 1000, //가시 페이지 수
		onPageClick : function(event,page) {
			console.info(page + ' (from options)');
			$(".page-link").on("click",function(event){ //클래스page-link는 BS4의 pagination의 링크 a
				event.preventDefault(); 				
				let peo = $(event.target); 			
				let pageNo = peo.text();				
				let purl;
				let pageA;
				let pageNo1;
				let pageNo2;
				
				if(pageNo != "First" && pageNo != "Previous" && pageNo != "Next" && pageNo != "Last") {
					purl = "plist?pageNo=" + pageNo;
				}
				else if(pageNo == "Next") {
					pageA = $("li.active > a"); //li에 actvive클래스가 있고 a에 페이지 번호가 있음
					pageNo = pageA.text(); //페이지 번호
					pageNo1 = parseInt(pageNo); //페이지번호를 1더해야 하므로 정수로 변환
					pageNo2 = pageNo1 + 1;
					purl = "plist?pageNo=" + pageNo2;
				}
				else if(pageNo == "Previous") {
					pageA = $("li.active > a"); //li에 actvive클래스가 있고 a에 페이지 번호가 있음
					pageNo = pageA.text(); //페이지 번호
					pageNo1 = parseInt(pageNo); //페이지번호를 1더해야 하므로 정수로 변환
					pageNo2 = pageNo1 - 1;
					purl = "plist?pageNo=" + pageNo2;
				}
				else if(pageNo == "First") {					
					purl = "plist?pageNo=" + 1;
				}
				else if(pageNo == "Last") {					
					purl = "plist?pageNo=" + 35;
				}
				else {					
					return;					
				}	
				
				$.ajax({
					url : purl,
					type : "get",
					data : "",
					success : function(data) {
						$("#hjumbo").text("게시판 " + pageNo + "페이지입니다");						
						$("#submain").html(data);						
					},
					error : function() {
						$("#mbody").text("서버접속 실패!.");
						$("#modal").trigger("click");	
					}					
				}); //ajax
			}); //on-click
		} //onPageClick 
	})//window.pagObj
	.on('page', function(event, page){  //chaining
		console.info(page + ' (from event listening)');	    
	});	
});
</script>
-->

<script>
$(document).ready(function(){
	$("#searchBoard").click(function(event){
		event.preventDefault();
		$.ajax({
			url : $("#searchBoard").attr("href"),
			type : "GET",
			data : "",
			success : function(data) {
				$("#hjumbo").text("게시판입니다.");
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

<script>
$("#searchInput").on("keyup",function(){
	var value = $(this).val().toLowerCase();
	$("#searchTable tr").filter(function(){
		$(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
	});
});
</script>

</body>
</html>