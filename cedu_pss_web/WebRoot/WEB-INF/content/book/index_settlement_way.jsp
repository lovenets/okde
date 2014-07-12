<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../template/common/import.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>结算方式</title>
		<!--  jquery库 -->
		<jc:plugin name="jquery" />
		<!-- jquery-UI -->
		<jc:plugin name="jquery_ui" />
		<!-- 整体样式 -->
		<jc:plugin name="default" />
		
		<jc:plugin name="tab" />
		<!-- 基础JS -->
		<jc:plugin name="base_js" />
		<!--  分页 -->
		<jc:plugin name="page" />
		<!-- 操作等待插件 -->
		<jc:plugin name="loading" />
		<script type="text/javascript">
			//删除用户
			function delbc(id)
			{
				jQuery.post('<s:url value="delete_settlementway"/>',{"id":id},
			      	  function(data)
			    		{
			    			if(data.results)
			    			{
			    				show('showDialog','删除成功!',150,100);
			    				window.location.reload();
			    			}
			    			else show('showDialog','删除失败!',150,100);	
			    		},
				 "json");	
			}
			
			
					//修改验证
			function xiuyanzheng()
			{
				var code=$('#code').val();
				var name=$('#name').val();
				if(code.trim()=="")
				{
				 alert("请输入编号");
				}else if(name.trim()=="")
				{
				 alert("请输入名称");
				}else
				{
				updsw();
				}
				
			}
			
		
			//修改用户状态
			function updsw()
			{
				var id=$('#id').val();
				var code=$('#code').val();
				var name=$('#name').val();
				jQuery.post('<s:url value="update_settlementway"/>',{"settlementway.id":id,"settlementway.name":name,"settlementway.code":code},
			      	  function(data)
			    		{
			    			if(data.results)
			    			{
			    				show('showDialog','修改成功!',150,100);
			    				window.location.reload();
			    			}
			    			else show('showDialog','修改失败!',150,100);	
			    		},
				 "json");	
			}
		</script>
		<a:ajax successCallbackFunctions="del_callback" parameters="{'id':module_id}" urls="/admin/user/delete_user" pluginCode="001"/>
		<a:ajax successCallbackFunctions="modifystatus_callback" parameters="{'id':user_id,'status':user_status};" urls="/admin/user/update_user_status" pluginCode="002"/>
		<script type="text/javascript">
		//模块ID
		var module_id=0;
		
		function showphoto(id,code,name)
		{
			
			var image='<a href="javascript:delbc('+id+')">删除</a>  <a href="javascript:updatesw('+id+','+code+',\''+name+'\')">修改</a>';
			return image;
		}	
		
		function addsw()
		{
			show('addDiv','提示',250,300);
		}
		
		function updatesw(id,code,name)
		{
			$('#id').val(id);
			$('#code').val(code);
			$('#name').val(name);
			show('updateDiv','提示',250,300);
		}
		
		//增加验证
			function yanzheng()
			{
			 var code=$("#setcode").val();
			 var name=$("#setname").val();
				if(code.trim()=="")
				{
				 alert("请输入编号");
				}else if(name.trim()=="")
				{
				 alert("请输入名称");
				}else
				{
				jQuery("#submits").submit();
				}
			}
		
		</script>
		
	</head>
  
  <body>

	
		<!--头部层开始 -->
		<head:head title="结算方式">
			<html:a text="新增" onclick="addsw()" icon="add" />
		</head:head>
		<!--主体层开始 -->
		<body:body>
				<!--Search Begin-->
				<div>
					<%@include file="list.jsp" %>
				</div>
				<!--Search End-->
				<div id="dataDiv1" style="display:block;">
				
					<table class="gv_table_2">
						<tr>
							<th style="width:20px;"><img src="<ui:img url="/plugin/base_css/images/operating/title_left.gif" />" /></th>
							<th style="text-align:left; font-weight:bold;">结算方式：</th>					
						</tr>
					</table>
				
					<page:plugin 
						pluginCode="123"
						il8nName="settlementway"
						searchListActionpath="page_list_settlementway"
						searchCountActionpath="page_count_settlementway"
						columnsStr="code;name;handle"
						customColumnValue="2,showphoto(id,code,name)"
						pageSize="10"
					/>
				</div>			
			</body:body>
	
	<div id="addDiv" style="display:none;">
		<form action="add_settlementway" method="post" id="submits">
			<table class="add_table">  
				<tr>
					<td class="lable_100">编码：</td>
					<td>
						<input type="text" class="txt_box_130" name="settlementway.code" id="setcode"/>
					</td>
				</tr>
				<tr>
					<td class="lable_100">结算方式</td>
					<td>
					<input type="text" class="txt_box_130" name="settlementway.name" id="setname"/><br/>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input class="btn_black_61" type="button" onclick="yanzheng()"  value="保存"/></td>
				</tr>
			</table>
		</form>
		</div>
	
	<!-- 添加结果 -->
	<div id="showDialog" style="display:none"><table class="add_table"><tr><td colspan="2" align="center"><input type="button" class="btn_black_61" value="关闭" onclick="closes('showDialog');" /></td></tr></table></div>
	<div id="updateDiv" style="display:none;">
		<form>
			<table class="add_table">  
				<tr>
					<td class="lable_100">编码：</td>
					<td>
						<input type="hidden" name="settlementway.id" id="id" />
						<input type="text" class="txt_box_130" name="settlementway.code" id="code"/>
					</td>
				</tr>
				<tr>
					<td class="lable_100">结算方式</td>
					<td>
					<input type="text" class="txt_box_130" name="settlementway.name" id="name"/><br/>
					<span id="valquota"></span>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input class="btn_black_61" type="button" onclick="xiuyanzheng()" value="保存"/></td>
				</tr>
			</table>
		</form>
		</div>
  </body>
</html>
