<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!DOCTYPE html>
<html>
<head>
<title>제이쿼리로 동적으로 생성된 버튼에 이벤트를 달아보자</title>
<script type="text/javascript">
	
	// Q.쉼표 문자열에서 최대값 구해보자
	let c_values = "500,200,600,700,100,300";
	
	// 배열로 만들어짐
	console.log(c_values.split(","));
	
	// map: 반복문을 돌며 배열 안의 요소들을 1대1로 짝지어 줌
	let values = c_values.split(",").map(str => Number(str));
	
	console.log("values: " + values);
	console.log("values.length: " + values.length);
	
	// reduce: 배열.reduce((누적값, 현재값, 인덱스, 요소))
	// -Infinity: 초기값을 제공하지 않을 경우 배열의 첫 번째 요소를 사용함
	let max = values.reduce(function(a,b) {
		return Math.max(a,b);
	},-Infinity);
	
	console.log("max : " + max);
	
// 	$(function(){
// 		// 첫 번째 버튼 이벤트 
// 		$("#firstBtn").on("click",function(e){
// 			let bodyHtml = "<button type='button' id='secondBtn'>2222222(동적생성)</button>";
			
// 			$("#mainDiv").append(bodyHtml);		// mainDiv 마지막 요소로 추가
// 		});
		
// 		// 두 번째 버튼 이벤트 - 클릭하면 alert("개똥이")
// 		$(document).on("click","#secondBtn", function(){
// 			alert("개똥이");
			
// 		});
// 	});

</script>
</head>
<body>
	<div id="mainDiv">
		<button type='button' id="firstBtn">111111111</button>
	</div>
	
<script type="text/javascript">
	let key2 = sessionStorage.getItem("key2");
	
	console.log("key2: " + key2);
</script>
</body>
</html>