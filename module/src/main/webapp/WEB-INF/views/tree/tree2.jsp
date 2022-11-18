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
<link rel="stylesheet" href="//fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="//code.getmdl.io/1.3.0/material.indigo-pink.min.css">
<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/all.js"></script>
<script src="/resources/src/jquery.fancytree.glyph.js"></script>
<script src="/resources/src/jquery.fancytree.table.js"></script>
<script src="/resources/src/jquery.fancytree.wide.js"></script>
<link href="/resources/src/skin-win8/ui.fancytree.css" rel="stylesheet" type="text/css">

<!-- (Irrelevant source removed.) -->

<style type="text/css">
  body {
    font-size: 1em;
    padding: 10px;
  }
  div.demo-card-wide {
    width: 90%;
  }

  div#tree {
    width: 90%;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid 1px solid rgba(0,0,0,.12);
    box-shadow: 0 2px 2px 0 rgba(0,0,0,.14),0 3px 1px -2px rgba(0,0,0,.2),0 1px 5px 0 rgba(0,0,0,.12);
  }
  ul.fancytree-container {
    width: 90%;
    border: 0;
    outline: 0;  /* No focus frame */
  }
  table.fancytree-container {
    table-layout: fixed;
    outline: 0;  /* No focus frame */
  }
</style>

<script type="text/javascript">
  $(function(){

    // --- Initialize Fancytree Grid -------------------------------------------
    $("#tree").fancytree({
      extensions: ["glyph", "wide"],
      debugLevel: 4,
      checkbox: true,
      selectMode: 3,
      tooltip: function(event, data) {
        var node = data.node,
          data = node.data;

        if( data.author ) {
          return node.title + ", " + data.author + ", " + data.year;
        }
      },
      glyph: {
        preset: "material",
        map: {}
      },
      source: {url: "ajax-tree-products.json", debugDelay: 1000},
      lazyLoad: function(event, data) {
        data.result = {url: "ajax-sub2.json", debugDelay: 1000};
      }
    });
    $("#btnReloadTree").click(function(){
      $.ui.fancytree.getTree(0).reload();
    });

    // --- Initialize Fancytree Grid -------------------------------------------
    $("#treegrid").fancytree({
      extensions: ["glyph", "table", "wide"],
      checkbox: true,
      selectMode: 3,
      glyph: {
        preset: "material",
        map: {}
      },
      table: {
        checkboxColumnIdx: 0,
        nodeColumnIdx: 1
      },
      source: {url: "ajax-tree-products.json", debugDelay: 1000},
      lazyLoad: function(event, data) {
        data.result = {url: "ajax-sub2.json", debugDelay: 1000};
      },
      renderColumns: function(event, data) {
        var node = data.node,
          data = node.data,
          $tdList = $(node.tr).find(">td");

        $tdList.eq(2).text(data.author);
        $tdList.eq(3).text(data.year);
        $tdList.eq(4).text(data.price ? data.price.toFixed(2) : "");
      }
    });
    $("#btnGridExpandAll").click(function(){
      $.ui.fancytree.getTree(1).visit(function(node){
        node.setExpanded();
      });
    });
    $("#btnGridCollapseAll").click(function(){
      $.ui.fancytree.getTree(1).visit(function(node){
        node.setExpanded(false);
      });
    });
  });
</script>
</head>

<body class="example_NOT">

    <div class="mdl-card__menu">
    <button class="mdl-button mdl-button--icon mdl-js-button mdl-js-ripple-effect">
      <i class="material-icons">info</i>
    </button>
    </div>

  <!-- <div id="tree" class="demo-card-wide mdl-card mdl-shadow--2dp"> -->
  <div id="tree" class="">
  </div>

</body>
</html>