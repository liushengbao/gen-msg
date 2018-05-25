<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<meta charset="utf-8">
<script type="text/javascript" src="style/js/jquery-3.0.0.min.js"></script>
<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
}

.tab {
	width: 270px;
	padding: 5px;
	height: 150px;
	margin: 20px;
}

.tab-menu ul {
	list-style: none;
	height: 30px;
	line-height: 30px;
}

.tab-menu li {
	background: #FFF;
	cursor: pointer;
	float: left;
	list-style: none height:29px;
	line-height: 29px;
	padding: 0px 10px;
	border: 1px solid #BBB;
}

.tab-box div {
	width: 400px;
	height: 300px;
	border: 1px solid #BBB;
	display: none;
}
/* 让第一个框显示出来 */
.tab-box div:first-Child {
	display: block;
}
/* 改变选项卡选中时候的样式 */
.change {
	background: red;
}
</style>
<script>
	$().ready(function() {
		$(".tab-menu li").click(function() {
			//通过 .index()方法获取元素下标，从0开始，赋值给某个变量
			var _index = $(this).index();
			//让内容框的第 _index 个显示出来，其他的被隐藏
			$(".tab-box>div").eq(_index).show().siblings().hide();
			//改变选中时候的选项框的样式，移除其他几个选项的样式
			$(this).addClass("change").siblings().removeClass("change");
		});
	});
</script>
<body>
	<div class="tab">
		<div class="tab-menu">
			<ul>
				<li>消息号</li>
				<li>错误号</li>
			</ul>
		</div>
		<div class="tab-box">
			<div>123</div>
			<div>456</div>
		</div>
	</div>
</body>
</html>