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
    $(function(){
      // using default options
      $("#tree").fancytree();
    });
  </script>
</head>

<body class="example">
<h1>조직도 Tree</h1>
<div class="description">
Fancytree를 이용한 조직도입니다.
<br>
</div>

<div id="tree">
	<ul id="treeData" style="display: none;">
		<li id="id1" title="Look, a tool tip!">item1 with key and tooltip
		<li id="id2">item2
		<li id="id3" class="folder">Folder with some children
		<ul>
		<li id="id3.1">Sub-item 3.1
		<ul>
		<li id="id3.1.1">Sub-item 3.1.1
		<li id="id3.1.2">Sub-item 3.1.2
		</ul>
		<li id="id3.2">Sub-item 3.2
		<ul>
		<li id="id3.2.1">Sub-item 3.2.1
		<li id="id3.2.2">Sub-item 3.2.2
		</ul>
		</ul>
		<li id="id4" class="expanded">Document with some children (expanded on init)
		<ul>
		<li id="id4.1"  class="active focused">Sub-item 4.1 (active and focus on init)
		<ul>
		<li id="id4.1.1">Sub-item 4.1.1
		<li id="id4.1.2">Sub-item 4.1.2
		</ul>
		<li id="id4.2">Sub-item 4.2
		<ul>
		<li id="id4.2.1">Sub-item 4.2.1
		<li id="id4.2.2">Sub-item 4.2.2
		</ul>
		</ul>
	</ul>
</div>
</body>
</html>
