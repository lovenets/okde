<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../../template/common/import.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <!--  jquery库 -->
		<jc:plugin name="jquery" />
		<!-- jquery-UI -->
		<jc:plugin name="jquery_ui" />
		<!-- 整体样式 -->
		<jc:plugin name="default" />
		<!--  分页 -->
		<jc:plugin name="page" />
		<!-- 选项卡 -->
		<jc:plugin name="tab" />
		<!-- 时间控件 -->
		<jc:plugin name="calendar" />
		<!-- 操作等待插件 -->
		<jc:plugin name="loading" />
		<a:ajax parameters="{'bid':bid,'zhi':zhi}"
		successCallbackFunctions="ajax_update" 
		urls="/examination/examroom/update_actualcost"
		pluginCode="123" 
		/>
		<script type="text/javascript">
	var bid=0;
	var zhi=0;
	function  showtime(startTime,endTime){
	var  a=startTime+"--"+endTime;
  return a.substring(0,10)+"--"+a.substring(21,31);}
	
	function changemoney(id,data){
	var lists='';
	lists+='<div id="div'+id+'"  class="bbborder">';
	lists+='<input type="text" style="display:none" id="txt'+id+'" value="'+data+'" name="actualCost" class="txt_box_100" >';
	lists+='<span id="sp'+id+'" >'+data+'</span>';
	lists+='<a id="update'+id+'" href="javascript:void(0)" onclick="btnclick('+id+')" >修改</a>';
	lists+='<a id="delete'+id+'" href="javascript:void(0)" onclick="btndelete('+id+')" ></a></div>';
	return  lists;				
 }
     function ajax_update(){
     alert('ok');
     }
	$(document).ready(function(){
 	search0909();
 	});
		
		function btnclick(id)
		{   
		    bid=id;
			var atext=$('#update'+id).html();
			if(atext=="修改")
			{
			$('#txt'+id).css({'display':'block'});
			$('#sp'+id).css({'display':'none'});
			$('#update'+id).html('保存');
			$('#delete'+id).html('取消');
			}
			
			if(atext=="保存"){
			$('#txt'+id).css({'display':'none'});
			$('#sp'+id).css({'display':'block'});
			$('#update'+id).html('修改');
			$('#delete'+id).html('');
			zhi=$('#txt'+id).val();
			ajax_123_1();
			search0909();
			}
			}
			function communication(id){
			return '<a href="exam_communication?id='+id+'">沟通记录</a>'
			}
			function shangchuan(){
			return "上传总结";
			}
		function showinspector(data){
	if(data==1){
	return "赵芬";
	}
	 if(data==2){
	return "安雅楠";
	}
	if(data==3){
	return "魏媛媛";
	}
	}
			
		</script>
  </head>
  
  <body>
  <head:head title="巡考总结">
		</head:head>
  <body:body>
       <table class="add_table" cellpadding="0" cellspacing="0" border="0" width="100%">
		   <tr>
		   <td class="lable_100">考试批次：</td>
		   <td><s:select list="%{exambatchlist}" listKey="id" headerKey="0" headerValue="--请选择--" theme="simple" listValue="code" name="examBatchId" id="examBatchIds" cssClass="txt_box_130"/></td>
		   <td class="lable_100">考点:</td>
		   <td><s:select list="%{examarealist}" listKey="id" headerKey="0" headerValue="--请选择--" theme="simple" listValue="name" name="examAreaId" id="examAreaIds" cssClass="txt_box_130"/></td>
		   <td><input type="button" name="" id="" value="查询" class="btn_black_61"  onclick="search0909()" />
		   </td>
		   </tr>
		</table>  		
		      <table class="gv_table_2" id="resTable" border="0" cellpadding="0" cellspacing="0">
	    	<tbody>
			 <page:plugin 
				pluginCode="0909"
				il8nName="examschedule"
				searchListActionpath="findByconditions_examschedule"
				searchCountActionpath="count_examschedule"
				columnsStr="examBatchname;examAreaname;inspector;Time;planedCost;actualCost;#communcation;#upload"
				customColumnValue="2,showinspector(inspector);3,showtime(startTime,endTime);5,changemoney(id,actualCost);6,communication(id);7,shangchuan()"
				view="http,examination/examroom/view_examschedule,id,id,_blank"
				pageSize="5"
				ontherOperatingWidth="80px"	
				params="'examBatchId':$('#examBatchIds').val(),'examAreaId':$('#examAreaIds').val()"
		     />  	 
	    	</tbody>
	    </table>			
  </body:body>
  </body>
</html>
