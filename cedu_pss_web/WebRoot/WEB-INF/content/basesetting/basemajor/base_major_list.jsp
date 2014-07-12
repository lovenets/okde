<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../template/common/import.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
		<!--  jquery库 -->
		<jc:plugin name="jquery" />
		
    	<!-- 整体样式 -->
		<jc:plugin name="default" />
		
		<jc:plugin name="tab" />
		
		<!-- jquery-UI -->
		<jc:plugin name="jquery_ui" />
		
		<!-- ajax 载入页面特效 -->
		<jc:plugin name="loading"/> 
		
    <title>基础设置</title>
    <script type="text/javascript">
    	//加载全部专业列表
    	function ajax_load_base_major(data){
    		var list='';
			if(data.lstrltbool){
				if(data.basemajorlist.length>0){
					$.each(data.basemajorlist, function(){
						list+='<tr>';
						list+='<td align="center" width="35%">';
						list+='<div id="now'+this.id+'">';
						list+=this.name;
						list+='</div>';
						list+='<div id="click'+this.id+'" style="display:none;">';
						list+='<input id="name'+this.id+'" value="" maxlength="64"/>';
						list+='</div>';
						list+='</td>';
					    list+='<td align="center" width="35%">';
						list+='<div id="now'+this.id+'">';
						list+=this.code;
						list+='</div>';
						list+='<div id="click'+this.id+'" style="display:none;">';
						list+='<input id="code'+this.id+'" value="" maxlength="16"/>';
						list+='</div>';
						list+='</td>';
					    list+='<td align="center" width="30%">';
					    list+='<a href="#" id="updatebasemajor'+this.id+'" onclick="changeBtnValue('+this.id+')">修改</a>';
					    list+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" id="deletebasemajor'+this.id+'" onclick="deleteOrCancelBaseMajor('+this.id+')">删除</a>';
					    list+='</td>';
					    list+='</tr>';
			 });
				}else{
						list+='<tr class=error>';
						list+='<td colspan="3" align="center">';
						list+='<div>暂时没有相关信息</div>';
						list+='</td>';
						list+='</tr>';
				}
				$('#basemajortable > tbody').html(list);
				$('#add_base_major').show();
			}else{
				show('error_Msg','信息提示:',400,130);
			}				
    	}
    	//接收添加方法回调函数，进行相关操作
    	function ajax_save_base_major(data){
    		if(!data.addrltbool){
				show('error_Msg','信息提示:',300,100);
    		}else if(data.errormsg){
    			cancelBaseMajor();
	  			show('success_Msg','信息提示:',250,100); 
	  		}else{
	  			show('add_error_Msg','信息提示:',300,100);
	  		}
	  		ajax_001_1();
    	}
		//接收更新方法回调函数，进行相关操作
		function ajax_update_base_major(data){
    		if(!data.updaterltbool){
				show('error_Msg','信息提示:',300,100);
			}else if(data.sameinfobool){
				show('success_Msg','信息提示:',250,100);
	  		}else{
	  			show('add_error_Msg','信息提示:',300,100);
	  		}
	  		ajax_001_1();
    	}
		//接收删除方法回调函数，进行相关操作
		function ajax_delete_base_major(data){
    		if(data.delrltbool){
	  			show('success_Msg','信息提示:',400,130);
	  		}else{
	  			show('error_Msg','信息提示:',400,130);
	  		}
	  		ajax_001_1();
    	}
    </script>
    <a:ajax parameters="null" successCallbackFunctions="ajax_load_base_major" pluginCode="001" urls="/basesetting/basemajor/list_base_major_by_flag"/>
    <a:ajax parameters="{'baseMajor.name':$('#basemajorname').val(),'baseMajor.code':$('#basemajorcode').val()}" successCallbackFunctions="ajax_save_base_major" pluginCode="002" urls="/basesetting/basemajor/add_base_major"/>
    <a:ajax parameters="{baseMajorId:baseMajorId,'baseMajor.name':$('#name'+baseMajorId).val(),'baseMajor.code':$('#code'+baseMajorId).val()}" successCallbackFunctions="ajax_update_base_major" pluginCode="003" urls="/basesetting/basemajor/update_base_major"/>
    <a:ajax parameters="{baseMajorId:baseMajorId}" successCallbackFunctions="ajax_delete_base_major" pluginCode="004" urls="/basesetting/basemajor/delete_base_major"/>
   
    <script type="text/javascript">
    	//全局变量
    	var baseMajorId=0;	
    	$(function(){
    		ajax_001_1();
    	});
	
    	//增加一行输入框，用于填写专业信息
    	function addBaseMajor(){
    		$('#basemajortable > tbody tr.error').remove();
    		$('#add_base_major').hide();
    		var list='';
    		list+= $('#basemajortable > tbody').html();
			list+='<tr id="basemajortr">';
		    list+='<td align="center">'; 
		    list+='<input id="basemajorname" class="txt_box_150" maxlength="64"/>';
		    list+='</td>'; 
		    list+='<td align="center">'; 
		    list+='<input id="basemajorcode" class="txt_box_150" maxlength="16"/>';
		    list+='</td>'; 
		    list+='<td align="center">';  
		    list+='<a href="#" onclick="saveBaseMajor()">保存</a>';	 
		    list+='&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="cancelBaseMajor()">取消</a>'; 
		    list+='</td>';
		    list+='</tr>';
		    $('#basemajortable > tbody').html(list);
			  
    	}
    	//取消一行尚未保存的输入框
    	function cancelBaseMajor(){
    		$('#add_base_major').show();
    		$("#basemajortr").remove();
    	}
    	//保存当前一行输入的专业信息
    	function saveBaseMajor(){
    		if($("#basemajorname").val()==null||$("#basemajorname").val()==""||$.trim($("#basemajorname").val())==""){
    			show('fill_in_info_error','信息提示:',250,100);
    		}else if($("#basemajorcode").val()==null||$("#basemajorcode").val()==""||$.trim($("#basemajorcode").val())==""){
    			show('fill_in_info_error','信息提示:',250,100);
    		}else{
    			ajax_002_1();
    		}
    	}
    	
	
	//切换是否可以修改信息,保存修改信息
	function changeBtnValue(id){
		var updatebtn=$('#updatebasemajor'+id).html();//获取保存/修改对象
		var deletebtn=$('#deletebasemajor'+id).html();//获取取消/删除对象
		
		if(updatebtn=="修改"){  	
			//nth(0)取id为"now"+id的第一个div的值，1为第二个div的值
			$('#name'+id).val($("div[id='now"+id+"']:nth(0)").html());
			$('#code'+id).val($("div[id='now"+id+"']:nth(1)").html());
			$('#updatebasemajor'+id).html("保存");
			$('#deletebasemajor'+id).html("取消");
			$("div[id='now"+id+"']").hide();
			$("div[id='click"+id+"']").show();
		}else{
			if($("#name"+id).val()==null||$("#name"+id).val()==""||$.trim($("#name"+id).val())==""){
    			show('fill_in_info_error','信息提示:',250,100);
    		}else if($("#code"+id).val()==null||$("#code"+id).val()==""||$.trim($("#code"+id).val())==""){
    			show('fill_in_info_error','信息提示:',250,100);
    		}else{
    			baseMajorId=id;
			  	ajax_003_1();
				$('#updatebasemajor'+id).html("修改");
				$('#deletebasemajor'+id).html("删除");
				$("div[id='now"+id+"']").show();
				$("div[id='click"+id+"']").hide();
    		}
		}
	}
	
	//删除当前选定的一条专业或是取消当前选定专业的可编辑状态
	function deleteOrCancelBaseMajor(id){
		var deletebtn=$('#deletebasemajor'+id).html();//获取取消/删除对象
		var updatebtn=$('#updatebasemajor'+id).html();//获取保存/修改对象
		
		if(deletebtn=="取消"){
			$('#updatebasemajor'+id).html("修改");
			$('#deletebasemajor'+id).html("删除");
			$("div[id='now"+id+"']").show();
			$("div[id='click"+id+"']").hide();
		}else{
			var isdel=confirm("您确定要删除吗？");
			if(isdel){
				baseMajorId=id;
				ajax_004_1();
			}
		}
	}

    </script>

  </head>
  
  <body>
<!--头部层开始 -->
		<head:head title="基础设置">
		</head:head>
		<!--主体层开始 -->
		<body:body>
			<!--Menu Begin-->
			<div>
				<s:include value="../common/menu.jsp" />
			</div>
			<!--Menu End-->
			
			<!--Left Begin-->
			
			<table class="gv_table_2">
		  		<tr>
				 	<th style="width:20px;"><img src="<ui:img url="images/title_menu/title_left.gif" />" /></th>
				 	<th style="text-align:left; font-weight:bold;">专业设置</th>
					<th style="text-align:right; font-weight:bold;"><div id="conmenu"><a href="javascript:void(0)" onclick="addBaseMajor()" id="add_base_major"><img src="<ui:img url="images/title_menu/icon_add.gif" />" />增加</a></div></th>
				</tr>
			</table>
				
			<table class="gv_table_2" id="basemajortable" border="0" cellpadding="0" cellspacing="0">
				<thead>
					<tr>
						<th >专业名称</th>
						<th >编号</th>
						<th >操作</th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
			<!--Left End-->	
  		</body:body>
   <div id="fill_in_info_error" style="display:none;font-weight:bold" align="center"><br/>请填写完整数据！<br/></div>
   <div id="success_Msg" style="display:none;font-weight:bold" align="center"><br/>操作成功！<br/></div>
   <div id="add_error_Msg" style="display:none;font-weight:bold" align="center"><br/>数据库存在重复数据，请重新添加<br/></div>
   <div id="error_Msg" style="display:none;font-weight:bold" align="center"><br/>服务器繁忙，请您稍后尝试操作！<br/></div>
  </body>
</html>
