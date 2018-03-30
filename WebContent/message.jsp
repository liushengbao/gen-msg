<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<div id="cpcontainer" class="container" style="float: left;width: 1200px; height:auto;">
		<div class="marginbot">
			<span class="txt">消息号管理</span> <a class="sgbtn" onclick="" href="javascript:;">添加消息号</a> <a class="sgbtn" onclick="" href="javascript:;">版本管理</a> <a class="sgbtn" href="" target="_blank">版本对比</a> <a class="sgbtn" onclick="" href="javascript:;">提交到服务端&amp;客户端</a> <a class="sgbtn" onclick="" href="javascript:;">最近修改</a> <a class="sgbtn" onclick="" href="javascript:;">修改日志</a> <a class="sgbtn" onclick="" href="javascript:;">备份</a> <a class="sgbtn" onclick="" href="javascript:;">Test</a>
		</div>

		<div style="float: left;width: 352px;">

			<div >
				<div style="line-height: 30px; width: 352px;"></div>

				<div style="line-height: 30px; width: 352px;">
					消息号版本: <select id="server_id" name="server_id" style="color: #000000; width: 210px;">
						<option value="test"></option>
					</select> <input type="submit" onclick="" value="确定" class="btns" id="cbtn">
				</div>


				<div style="line-height: 30px; width: 352px;">
					<a onclick="" href="">全部展开</a> | <a onclick="" href="">全部折叠</a> <input type="hidden" id="mrepo" value="1"> <input type="text" class="txt ac_input" id="msearch"> <input type="submit" onclick="" value="搜索" class="btns" id="sbtn">
				</div>
			</div>

			<div id="msgcatdiv" style="width: 352px; float: left;">
				<div id="msgcat_list_div">
					<jsp:include page="message_left.jsp" flush="true" />
				</div>
			</div>
			<div id="messagediv" style="width: 69%; float: left; margin-left: 10px; display: block;"></div>
		</div>

		<div class="note fixwidthdec">
			<p class="i">消息说明</p>
			<table>
				<tbody>
					<tr>
						<td style="width: 600px;"><br /> <b> 客户端-逻辑：101**** 返回：501**** <br /> 客户端-活动：103**** 返回：503**** <br /> 客户端-场景：181**** 返回：581**** <br /> 客户端-跨服：182**** 返回：582**** <br />
						</b> 不要直接修改SVN上传的配制文件，否则会更新失败．</td>
					</tr>
				</tbody>
			</table>
		</div>


	</div>


</body>
</html>