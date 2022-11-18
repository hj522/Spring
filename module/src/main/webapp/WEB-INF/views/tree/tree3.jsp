<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>조직도</title>
<script src="//code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="//cdn.jsdelivr.net/npm/jquery.fancytree@2.27/dist/skin-win8/ui.fancytree.min.css" rel="stylesheet">
<script src="//cdn.jsdelivr.net/npm/jquery.fancytree@2.27/dist/jquery.fancytree-all-deps.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/all.js"></script>
<script src="/resources/src/jquery.fancytree.glyph.js"></script>
<link href="/resources/src/skin-win8/ui.fancytree.css" rel="stylesheet" type="text/css">

<style type="text/css">
.fancytree-custom-icon svg {
  width: 1em;
  height: 1em;
  vertical-align: -.125em;
}
</style>


<script type="text/javascript">

	$(function() {
		$("#tree").fancytree({
			extensions : [ "filter" ],
			checkbox : true,
			selectMode : 3,
			quicksearch : true,
			filter : {
				autoApply : true, // Re-apply last filter if lazy data is loaded
				counter : true, // Show a badge with number of matching child nodes near parent icons
				fuzzy : false, // Match single characters in order, e.g. 'fb' will match 'FooBar'
				hideExpandedCounter : false, // Hide counter badge, when parent is expanded
				highlight : true, // Highlight matches by wrapping inside <mark> tags
				mode : "dimm" // Grayout unmatched nodes (pass "hide" to remove unmatched node instead)
			},
			activate : function(event, data) {
			},

		});
		var tree = $("#tree").fancytree("getTree");

		$("input[name=search]").keyup(function(e) {
			var n, opts = {
				autoExpand : true,
				leavesOnly : true
			}, match = $(this).val();
			// Pass a string to perform case insensitive matching
			n = tree.filterNodes(match, opts);

			if (e && e.which === $.ui.keyCode.ESCAPE || $.trim(match) === "") {
				tree.clearFilter();
				return;
			}
			node.setExpanded(true);
		}).focus();
	});
</script>
</head>

<body class="example">
<div class="description">
Fancytree를 이용한 조직도입니다.
<br>
</div>
	<p>
	
	<H1>조직도</H1>
	<p>
		<input name="search" placeholder="검색어를 입력하세요" autocomplete="off">
	
	<div id="tree">
		<ul>
			<li class="expanded folder">부장
				<ul>
					<li title="Hong Gil Dong">김효정</li>
				</ul>
			</li>
			<li class="expanded folder">과장
				<ul>
					<li>개똥이</li>
					<li>소똥이</li>
					<li>말똥이</li>
					<li>닭똥이</li>
				</ul>
			</li>
			<li class="expanded folder">대리
				<ul>
					<li>고길동</li>
				</ul>
			</li>
			<li class="expanded folder">사원
				<ul>
					<li>우영우</li>
					<li>기러기</li>
					<li>토마토</li>
					<li>별똥별</li>
				</ul>
			</li>
		</ul>
	</div>
</body>
</html>
