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

<h3 class="text-center threeDEffect mb-2">나의 장바구니</h3>
<a href='main' class="btn btn-danger mb-3">목록으로</a>
<table id="cartTable" class="table table-bordered table-hover">
	<thead>
		<tr>
			<th>번호</th>
			<th>식당명</th>
			<th>요리명</th>
			<th>가격</th>
			<th>수량</th>	
			<th>주문</th>
		</tr>
	</thead>
	<tbody id="cartBody">
		
	</tbody>	
</table>

<script>
$(document).ready(function(){
	if (typeof(Storage) == "undefined")  {
		return;
	}
	 
	 let i;
	 let keyName;
	 let cartItem; //key값에 따른 값
	 let cartTemObj;
	 let rId;
	 let rClass;
	 let rTitle;
	 let rtrName;
	 let rPrice;
	 let rContent;
	 let rPhoto;
	 let rQty;
	 
	 let list = "";
	 for(i = 0 ; i < localStorage.length ; i++) {
		 keyName = localStorage.key(i);
		 cartItem =  localStorage.getItem(keyName); //JSOn문자열임
		 cartTemObj = JSON.parse(cartItem); //JS의 Objec형으로 변환
		 rId = cartTemObj.rId;
		 rClass = cartTemObj.rClass;
		 rtrName = cartTemObj.rtrName;
		 rTitle = cartTemObj.rTitle;
		 rPrice = cartTemObj.rPrice;
		 rContent = cartTemObj.rContent;
		 rPhoto = cartTemObj.rPhoto;
		 rQty = cartTemObj.rQty;
		 
		 list += 
			 "<tr><td>"+rId+"</td><td>"+rtrName+"</td><td>"+rTitle+"</td><td>"+rPrice+"</td><td>"+rQty+
			 "</td><td><button type='button' class='btn btn-success'>주문</button></td></tr>";		 	  
	 }
	 
	 $("#cartBody").html(list); //list가 태그를 사용하므로 html사용
});
</script>
</body>
</html>