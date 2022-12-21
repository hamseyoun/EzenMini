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
<title>레시피 상세창</title>
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
#mapContain {
	height : 100%;
}
#googleMap {
	width : 100%;
	height : 400px;	
	margin: 0;
	padding : 0;
}
</style>

</head>
<body>

<div class="row mt-5 ml-0 mr-0 border">
	<div class="col-md-4">
		<img src="upimage/${rDetails.rPhoto}" alt="사진"  class="mx-auto img-responsive mt-4" 
			style="max-width:100%;height:400px;"/>
	</div>
	<div class="col-md-4">
		<h3 class="text-center threeDEffect">${rDetails.rClass}</h3>
		<h3 class="text-center threeDEffect">${rDetails.rtrName}</h3> 
		<h3 class="text-center threeDEffect">${rDetails.rTitle}</h3>
		<h3 class="text-center threeDEffect">${rDetails.rPrice}원</h3> <!-- 나중 DB에 rPrice추가 -->
		<h3 class="text-center threeDEffect">${rDetails.rContent}</h3>		
		<br/>
		<form action="recipeorder" method="post" id="rOrder">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<input type="hidden" name="rPid" value="${rDetails.rId}">
			<input type="hidden" name="rOuser" value="${user_id}">
			<input type="hidden" name="rOtitle" value="${rDetails.rTitle}">
			<input type="hidden" name="rOprice" value="${rDetails.rPrice}">
			<div class="form-group text-center">
				<h3 class="text-center threeDEffect">
					<label for="uOrder">주문수량</label>
					<input type="number" class="form-control w-50 mx-auto" id="uOrder" size="10"
						name="quanty" value="1" required/>
				</h3>
			</div>
			<div class="text-center">
				<button type="submit" id="preOrder" class="btn btn-success">주문</button>&nbsp;&nbsp;	
				<button type="button" id="cartbtn" class="btn btn-light" onclick="stored()">
					<i class="fa fa-shopping-cart fa-2x" aria-hidden="true"></i>
				</button>			
			</div>
			
			<div class="text-center d-none" id="orderAdd">
				<div class="form-group text-center">
					<lable for="phoneNo">전화번호</lable>
					<input type="text" name="rOphoneNo" id="phoneNo" class="form-control mx-auto w-50" placeholder="전화번호 010-xxxx-yyyy" required />
				</div>
				<div class="form-group text-center">
					<lable for="phoneNo">배달처</lable>
					<input type="text" name="rOuserAddr" id="userAddr" class="form-control mx-auto w-50" placeholder="배달처 주소" required />
				</div>
				<button type="submit" class="btn btn-primary">확인</button>
			</div>
		</form>
		<p class="text-center mt-5">
			<a href="main" class="btn btn-danger">목록으로</a>			
		</p>   
	</div>
	<div id="mapContain" class="col-md-4">
		<h3 class="text-center threeDEffect">오시는 길</h3>		
		<div id="googleMap" class="mb-2"></div>				
		<button id="mapBtn" type="button" class="btn btn-primary d-none " value="Geocode">위치</button>							
	</div>
</div>

<script >
//Google Map API 주소의 callback 파라미터와 동일한 이름의 함수이다
//Google Map API에서 콜백으로 실행시킨다.

function initMap() {	
	console.log('Map is initialized.');
	let map; //지도를 표시할 영역
	let address = '<c:out value="${rDetails.rAddress}"></c:out>'
	getLocation();
	function getLocation() {
		if(navigator.geolocation) {	
			navigator.geolocation.getCurrentPosition(showPosition);
			//navigator.geolocation.watchPosition(showPosition); 
			//watchPosition(showPosition)은 이동시 사용자의 위치를 계속하여 업데이트 하며 반환
			//getCurrentPosition(showPosition)는 이용자의 위치반환
			//리턴값은 파라메터인 showPosition()함수에 좌표를 반환해 준다
			//clearWatch()는 중단
		}
		else {
			map = $("#googleMap");
			map.text("Geolocation is not supported by this browser.");
		}
	}
	
	function showPosition(position) {
		//watchPosition(showPosition)의 콜백함수
		lati = position.coords.latitude; //위도
		longi = position.coords.longitude;	//경도
		//지도를 표시해줄 객체는 지도를 표시할 객체와 배율,중앙에 보여줄 위치를 파라메터로 하여 생성
		map = new google.maps.Map(document.getElementById('googleMap'),{
			zoom: 16, //배율
			center: new google.maps.LatLng(lati,longi) //중앙위치 LatLng(위도,경도)는 위치를 표시
		});
		//위치를 표시해 주눈 아이콘
		let marker = new google.maps.Marker({
			position: new google.maps.LatLng(lati,longi),
			map: map,			
			title: 'Hello World!' //마커에 붙는 글자
		});
		
		$("#mapBtn").trigger("click"); //여기서 trigger 해야만 주소 변환 위치 자동 처리
	}	
	
	
	//Google Geocoding을 사용하며 Google Map API에 포함되어 있으며 번지를 지도위 위치로 변경	 	 
	 
	 $("#mapBtn").click(function(){
		 console.log("mapBtn클릭");
		 let geocoder = new google.maps.Geocoder();	
		 geocodeAddress(geocoder, map);
	 });	 
	
	 function geocodeAddress(geocoder, resultMap) {
		console.log('geocodeAddress 함수 실행');		
		//geocoder.geocode()메서드는 입력받은 주소로 좌표에 맵 마커를 찍는다.
		//파라메터는 입력받은 주소값과 콜백함수,주소는 JSON 객체 형식		
		geocoder.geocode({'address': address},function(result,status){
			 console.log(result);
			 console.log(status);
			  if (status === 'OK')  {
				  resultMap.setCenter(result[0].geometry.location);  //주소에 의해 변경된 위치값을 중앙으로 설정
				  resultMap.setZoom(18); // 맵의 확대 정도를 설정한다.
				  //마커 설정
				  let marker = new  google.maps.Marker({
					  map: resultMap,
					  position: result[0].geometry.location,
					  title: 'Hello World!'
				  });
				  console.log('위도(latitude) : ' + marker.position.lat());
                  console.log('경도(longitude) : ' + marker.position.lng());
			  }
			  else {
				  alert('지오코드가 다음의 이유로 성공하지 못했습니다 : ' + status);  
			  }
		 });		
	 }	
}


</script>

<script>
function stored(){	
	if (typeof(Storage) == "undefined")  {
		return;
	}
	 //localStorage.clear(); //임시로 시험시 마다 지움
	 //중간에 삭제되는 키값을 대비한 max키값을 구한뒤 1을 더해 키값으로 사용
	 let maxKeyValue = 0;
	 let keyValue;
	 for(let i = 0 ; i < localStorage.length ; i++) {
		 keyName = localStorage.key(i);
		 if(parseInt(keyName) > maxKeyValue) {
			 maxKeyValue = parseInt(keyName);
			 keyValue = maxKeyValue;
		 }
	 }
	 
	 keyValue = maxKeyValue + 1;
	 
	 let orderQty = $("#uOrder").val();
	 
	 if(parseInt(orderQty) < 1) {
		 alert("주문 수량을 입력하세요");
		 return;
	 }
	 
	 let recipeValue = {
			 rId : "${rDetails.rId}",
			 rClass : "${rDetails.rClass}",
			 rtrName :"${rDetails.rtrName}",
			 rTitle : "${rDetails.rTitle}",
			 rPrice : "${rDetails.rPrice}",
			 rContent :"${rDetails.rContent}" ,
			 rPhoto : "upimage/" + "${rDetails.rPhoto}",
			 rQty : orderQty
	 };
	 
	 //객체형 데이터는 JSON문자열로 저장(Storage는 문자열만 사용 가능)
	 localStorage.setItem(keyValue,JSON.stringify(recipeValue));
	 
	// let storedValue = localStorage.getItem(keyValue); //json문자열로 반환
	 
	// let storedObj = JSON.parse(storedValue); //객체형으로 반환
	 
	 //alert(storedObj.rClass+ " " + storedObj.rTitle + " " + storedObj.rQty);
	 
	 //localStorage에서 모든 값 오기
	 /*
	 let i;
	 let keyName;
	 let cartItem;
	 let cartTemObj;
	 for(i = 0 ; i < localStorage.length ; i++) {
		 keyName = localStorage.key(i);
		 cartItem =  localStorage.getItem(keyName);
		 cartTemObj = JSON.parse(cartItem);
		 console.log(cartTemObj.rTitle + "\n");
		 console.log(cartTemObj.rQty + "\n");
	 }
	 */
	 $.ajax({
		 url : "recipeCart",
		 type : "get",
		 data : "",
		 success : function(data) {
			 $("#hjumbo").text("나의 장바구니 입니다.");
			 $("#mainRegion").html(data);
		 },
		 error : function() {
				$("#mbody").text("서버접속 실패!.");
				$("#modal").trigger("click");	
		 }
	 });
}
</script>
<script>
	$("#preOrder").click(function(){
		let orderQty = $("#uOrder").val();//입력값은 HTML에서는 모두 문자열
		if(parseInt(orderQty) < 1){
			alert("주문 수량을 입력하세요");
			return;
		}
		$("#orderAdd").removeClass("d-none"); //숨겨진 창 보여주기
	});
	
	$("#rOrder").submit(function(){ //submit이벤트는 form에 소속
		event.preventDefault();
		$.ajax({
			url : $("#rOrder").attr("action"),
			type : "post",
			data : $("#rOrder").serialize(),
			success : function(data){
				$("#hjumbo").text("요리 주문 내역창 입니다.");
				$("#mainRegion").html(data);
			},
			error : function(){
				$("#mbody").text("서버 접속 실패!");
				$("#model").trigger("click");
			}
		});
	});
</script>

<!-- 한페이지에ㅔ 2개 이상 지도시는 안되므로 가능한 다른페이지에서 지도 사용 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCl3troictldoLX7-RsH7NiFiGVzUWGgv8&callback=initMap&v=weekly&channel=2">
</script>



</body>
</html>