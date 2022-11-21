<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<!-- 구글 차트 호출을 위한 js 파일 라이브러리 임포트 -->
<script type="text/javascript" src="https://www.google.com/jsapi"></script>

<script type="text/javascript">
$(function(){
	// 구글 차트 라이브러리 로딩(메모리에 올림) - core chart 사용
	google.load("visualization","1",{
		"packages":["corechart"]
	});
	
	// 로딩이 완료되면 drawChart 함수를 호출
	google.setOnLoadCallback(drawChart);
	// responseText: json 데이터를 텍스트로 읽어들임. console.log로 볼 수 있음
	function drawChart() {
		let jsonData = $.ajax({
			url:"/resources/json/sampleData2.json",
			dataType:"json",
			async:false
		}).responseText;
		
		console.log("jsonData: " + jsonData);
		
		// 데이터 테이블 생성
		let data = new google.visualization.DataTable(jsonData);
		// 차트를 출력할 div 선택(PieChart, LineChart, ColumnChart....)
		let chart = new google.visualization.PieChart(document.getElementById("chart_div"));
		chart.draw(data,{
			title:"알럽핏짜",
			width:400,
			height:400
		});
	}
});
</script>

<div id="chart_div"></div>	<!-- 여기에 pie chart를 그리겠다 -->