<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta>
<title>消息管理后台</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
</head>

<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<link href="style/css/bootstrap.min.css" rel="stylesheet">
<script src="style/js/bootstrap.min.js"></script>
<script type="text/javascript">

</script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	overflow: hidden;
	height: 100%;
}

html {
	height: 100%;
}

table {
	width:100%;
	height: 100%;
}


</style>

<body>
	<table>
		<tr>
			<td style="height: 100%;width: 150px;">
				<iframe src="menu.jsp" name="menu" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
			</td>
			<td style="height: 100%;">
 				<iframe src="home.jsp" name="main" width="100%" height="100%" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</body>

</html>
