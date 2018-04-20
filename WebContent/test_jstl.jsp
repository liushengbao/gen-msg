<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.msg.mgr.CacheMgr"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta>
</head>
<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#edit_f_ok').click(function() {
		var xx = $('#f_name').val();
		alert(xx);
	});
});
</script>
<body>

<div class="bd-example" >	
  <input type="text" data-toggle="modal" data-target="#exampleModal"/>
  <div class="modal fade bd-example-modal-lg" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLabel">编辑</h4>
        </div>
        <div class="modal-body">
          <form>
          	<div class="form-group">
              <label for="recipient-name" class="control-label" style="display: block;">类型:</label>
              <select name="msg_cat" class="custom-select" id="inputGroupSelect03" style="width: 100px;">
			  	<option>base</option>
			  	<option>array</option>
			  	<option>map</option>
			  </select>
			  <select name="msg_cat" class="custom-select" id="inputGroupSelect03" style="width: 100px;">
			  	<option>int8</option>
			  	<option>int16</option>
			  	<option>int32</option>
			  </select>
			  <select name="msg_cat" class="custom-select" id="inputGroupSelect03" style="width: 100px;">
			  	<option>int8</option>
			  	<option>int16</option>
			  	<option>int32</option>
			  </select>
            </div>
            <div class="form-group">
              <label for="recipient-name" class="control-label">变量名:</label>
              <input type="text" class="form-control" id="f_name" >
            </div>
            <div class="form-group">
              <label for="message-text" class="control-label">说明:</label>
              <input type="text" class="form-control" id="f_desc">
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
          <button type="button" class="btn btn-primary" data-dismiss="modal" id="edit_f_ok">修改并关闭</button>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
