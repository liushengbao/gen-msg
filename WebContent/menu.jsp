<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
    <style type="text/css">
        /* common */
        *{ word-wrap:break-word; outline:none; }
        body{ width:159px; background:#E5E5E5 url(style/images/bg_repx_h_2.gif) right top no-repeat; color:#666; font:12px "Lucida Grande", Verdana, Lucida, Helvetica, Arial, "宋体" ,sans-serif; }
        body, ul{ margin:0; padding:0; }
        a{ color:#222222; text-decoration:none; }
        a:hover { text-decoration:underline; }
        .menu{ position:relative; z-index:20; }
        .menu ul{ position:absolute; top:10px; left:-1px !important; right:-2px; list-style:none; width:100px;  }
        .menu li{width:101px; margin:3px 0; *margin:1px 0; height:auto; height:24px; overflow:hidden; font-size:14px; }
        .menu li a{ display:block; margin-right:2px; padding:3px 0 2px 30px; *padding:4px 0 2px 10px; border:1px solid #ffffff; background:url(style/images/bg_repno.gif) no-repeat 10px -40px; color:#777777; }
        .menu li a:hover{ text-decoration:none; margin-right:0; border:1px solid #E5E5E5; border-right:1px solid #FFF; background:#FFF;color:#222222; }
        .menu li a.tabon{ text-decoration:none; margin-right:0; border:1px solid #E5E5E5; border-right:1px solid #FFF; background:#FFF url(style/images/bg_repy.gif) repeat-y; color:#DD4B39;font-weight:700; }
        .footer{ position:absolute; z-index:10; right:13px; bottom:0; padding:5px 0; line-height:150%; background:url(style/images/bg_repx.gif) 0 -199px repeat-x; font-family:Arial, sans-serif; font-size:10px; -webkit-text-size-adjust: none; }
    </style>
<body>
	<div class="menu">
		<ul id="leftmenu">
			<li><a href="home.jsp" target="main">首页</a></li>
			<li><a href="message.jsp" target="main">消息号</a></li>
			<li><a href="errorId.jsp" target="main">错误号</a></li>
			<li><a href="todo.jsp" target="main">待开发1</a></li>
			<li><a href="todo.jsp" target="main">待开发2</a></li>
		</ul>
	</div>
</body>
</html>