<%@ page language="java" pageEncoding="utf-8"%>
<%@ include file="../../template/common/import.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>缴费管理</title>
		<!--  jquery库 -->
		<jc:plugin name="jquery" />
		<!-- jquery-UI -->
		<jc:plugin name="jquery_ui" />
		<!-- 整体样式 -->
		<jc:plugin name="default" />
		<!-- 时间控件 -->
		<jc:plugin name="calendar" />
		<!-- 操作等待插件 -->
		<jc:plugin name="loading" />
		<!--缴费方式-->
		<script type="text/javascript">
			//加载事件
			jQuery(function(){
								
				//选择打印事件
				jQuery('#isPrint').change(function(){
					if(!this.checked)
					{
						jQuery('#receipdiv').hide();
					}
					else
					{
						jQuery('#receipdiv').show();
					}
				});
				
				//初始化弹出框
				//所有优惠券
				jQuery('#show_for_prompt').dialog({
					autoOpen:false,
					modal:true,
					draggable:false,
					resizable:false,
					title:'可使用优惠卷',
					width: 650,
					buttons: {
						'确定': function() { 
							//优惠金额
							jQuery('#discountfee'+pendFeePaymentId).html(jQuery('#reducemoney').html());
							jQuery('#discountAmount'+pendFeePaymentId).val(jQuery('#reducemoney').html());
							//优惠后金额
							if((jQuery('#reduceaftermoney').html()-0)-(jQuery('#rechargeAmount'+pendFeePaymentId).html()-0)<0)
							{
								//充值金额
								jQuery('#rechargeAmount'+pendFeePaymentId).html(jQuery('#reduceaftermoney').html());
								jQuery('#rechargeAmounts'+pendFeePaymentId).val(jQuery('#reduceaftermoney').html());
								//实缴金额
								jQuery('#paymentfee'+pendFeePaymentId).val(0);
								jQuery('#amountPaied'+pendFeePaymentId).val(0);	
								//需缴金额
								jQuery('#needpay'+pendFeePaymentId).html(0);
							}
							else
							{	
								//实缴金额
								jQuery('#paymentfee'+pendFeePaymentId).val((jQuery('#reduceaftermoney').html()-0)-(jQuery('#rechargeAmount'+pendFeePaymentId).html()-0));
								jQuery('#amountPaied'+pendFeePaymentId).val((jQuery('#reduceaftermoney').html()-0)-(jQuery('#rechargeAmount'+pendFeePaymentId).html()-0));	
								
								//需缴金额
								jQuery('#needpay'+pendFeePaymentId).html((jQuery('#reduceaftermoney').html()-0)-(jQuery('#rechargeAmount'+pendFeePaymentId).html()-0));
							}
							//优惠券Ids集合
							$("#discountIds"+pendFeePaymentId).val(disids);
							jQuery(this).dialog("close"); 
						}, 
						'清空': function() { 
							jQuery('#reduceaftermoney').html(jQuery('#allmoney'+pendFeePaymentId).html());
							jQuery('#reducemoney').html('0');
							//checkbox复原
							var nobranch=$("input[name='discountbox']")
							nobranch.each(function(i){
								$(this).attr("disabled",false);
								$(this).attr("checked",false);				
							}); 
							disids="";
							//$("#discountIds").val("");//清空使用优惠券的隐藏域ids集合
						}, 
						'关闭': function() { 
							//$("#discountIds").val("");//清空使用优惠券的隐藏域ids集合
							jQuery(this).dialog("close"); 
						} 
					}
				});	
				
				//使用充值账户金额
				jQuery('#show_for_account').dialog({
					autoOpen:false,
					modal:true,
					draggable:false,
					resizable:false,
					title:'学生账户',
					width: 500,
					buttons: {
						'确定': function() { 
							var allmoneys=jQuery('#allmoney'+pendFeePaymentId).html()-0;//应缴金额
							var discountmoneys=jQuery('#discountfee'+pendFeePaymentId).html()-0;//优惠金额
							var stuaccountmoney=jQuery("#stuaccountmoney").html()-0;//账户剩余金额
							if(!((/^\d{1,10}(\.\d{1,2})?$/).test(jQuery("#useaccount").val())))
							{
								//((/^\d{1,10}(\.\d{1,2})?$/)
								//(/^\-?[0-9]+(.[0-9]+)?$/)
								jQuery("#showDialog").html('<b>充值金额填写不正确，只能填写小数或整数！</b>');
								$('#message_returns_tips').dialog("open");
							}
							else if((allmoneys-discountmoneys)<(jQuery("#useaccount").val()-0))
							{
								jQuery("#showDialog").html('<b>使用的充值金额和优惠金额超过应缴金额！</b>');
								jQuery('#message_returns_tips').dialog("open");	
								//accountallmoney=jQuery('#allmoney'+pendFeePaymentId).html();
								//accountmoney=jQuery('#discountfee'+pendFeePaymentId).html();
								//jQuery('#allmoneyacc').html();
								//ajax_150_1();//使用充值金额								
							}
							else if(stuaccountmoney<(jQuery("#useaccount").val()-0))
							{
								$('#message_confirm').dialog({
									title:'确认操作',
									buttons: {
										'确认': function() { 
											//充值金额
											jQuery('#rechargeAmount'+pendFeePaymentId).html(jQuery("#useaccount").val());
											jQuery('#rechargeAmounts'+pendFeePaymentId).val(jQuery("#useaccount").val());
											//实缴金额（优惠后金额）
											jQuery('#paymentfee'+pendFeePaymentId).val((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
											jQuery('#amountPaied'+pendFeePaymentId).val((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
											//需缴金额
											jQuery('#needpay'+pendFeePaymentId).html((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
											$(this).dialog("close"); 
											jQuery("#show_for_account").dialog("close"); 
											}, 
										'取消': function() { 
												$(this).dialog("close"); 
											} 
									}
								});
								$('#message_confirm').dialog("open"); 
							}
							else
							{
								//充值金额
								jQuery('#rechargeAmount'+pendFeePaymentId).html(jQuery("#useaccount").val());
								jQuery('#rechargeAmounts'+pendFeePaymentId).val(jQuery("#useaccount").val());
								//实缴金额（优惠后金额）
								jQuery('#paymentfee'+pendFeePaymentId).val((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
								jQuery('#amountPaied'+pendFeePaymentId).val((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
								//需缴金额
								jQuery('#needpay'+pendFeePaymentId).html((allmoneys-discountmoneys)-(jQuery("#useaccount").val()-0));
								$(this).dialog("close");  
							}
							
						}, 
						'关闭': function() { 
							
							jQuery(this).dialog("close"); 
						} 
					}
				});	
				
				//信息提示
				jQuery('#message_returns_tips').dialog({
					autoOpen:false,
					modal:true,
					draggable:false,
					resizable:false,
					title:'信息提示',
					buttons: {
						'关闭': function() { 
							jQuery(this).dialog("close"); 
						} 
					}
				});	
				
			});
			//提交前的验证
			function showsubmit()
			{
				var pendingIds= $('#pendingIds').val();//为了验证金额输入是否正确
				if(pendingIds!="" && pendingIds.length>0)
				{
					var ids=pendingIds.split(",");
					for(var i=0;i<ids.length;i++)
					{
						if(!((/^\d{1,10}(\.\d{1,2})?$/).test(jQuery("#paymentfee"+ids[i]).val())))
						{
							jQuery("#showDialog").html('<b>'+jQuery("#feesubjectname"+ids[i]).html()+'实缴金额填写不正确，只能填写小数或整数！</b>');
							$('#message_returns_tips').dialog("open");
							return false;
						}
						else if(((jQuery("#paymentfee"+ids[i]).val()-0)+(jQuery("#discountfee"+ids[i]).html()-0)+(jQuery("#rechargeAmount"+ids[i]).html()-0))>(jQuery("#allmoney"+ids[i]).html()-0) && (jQuery("#rechargeAmount"+ids[i]).html()-0)!=0)
						{
							jQuery("#showDialog").html('<b>'+jQuery("#feesubjectname"+ids[i]).html()+'所有缴纳的费用总和不能超过应缴金额（若要多缴则使用充值金额应该为0）！</b>');
							$('#message_returns_tips').dialog("open");
							return false;
						}
					}
				}
				if(jQuery('#createdTime').val()=="")
				{
					jQuery("#showDialog").html('<b>请选择缴费时间！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(jQuery('#paymentway').val()==0)
				{
					jQuery("#showDialog").html('<b>请选择缴费方式！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(jQuery('#paymentway').val()==PAYMENT_METHOD_WANG_YIN_ZONG_BU || jQuery('#paymentway').val()==PAYMENT_METHOD_WANG_YIN_YUAN_XIAO)
				{
					jQuery("#showDialog").html('<b>暂时不提供网银院校和网银总部这两种缴费方式！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(jQuery("input[name='feePayment.isPrint']:checked").length>0 && jQuery('#barCode').val()=="" && $.trim($('#barCode').val())=="")
				{
					jQuery("#showDialog").html('<b>请输入收据号！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else
				{
					ajax_130_1();//添加除报名费和测试费之外的其他所有费用
				}
			}
			
			//显示优惠券
			function usingdiscount(id)
			{
				pendFeePaymentId=id;
				ajax_110_1();//显示优惠券
			}
			
			//显示充值金额
			function usingaccount(id)
			{
				//判断实缴金额大于应缴金额时   充值金额自动置为0
				if(((jQuery("#paymentfee"+id).val()-0)+((jQuery("#discountfee"+id).val()-0)))>(jQuery("#allmoney"+id).html()-0))
				{
					jQuery('#rechargeAmount'+pendFeePaymentId).html(0);
					jQuery('#rechargeAmounts'+pendFeePaymentId).val(0);
					jQuery("#showDialog").html('<b>实缴金额和优惠金额大于应缴金额，不需要用充值账户的金额！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else
				{
					pendFeePaymentId=id;
					jQuery("#feeSubjectName").html(jQuery("#feesubjectname"+id).html());
					jQuery('#allmoneyacc').html(jQuery('#allmoney'+pendFeePaymentId).html());
					jQuery('#reducemoneyacc').html(jQuery('#discountfee'+pendFeePaymentId).html());
					jQuery('#useaccount').val(jQuery('#rechargeAmount'+pendFeePaymentId).html());
					//alert(jQuery('#rechargeAmount'+pendFeePaymentId).html());
					ajax_140_1();//显示充值账户
				}
			}
			//验证输入的实缴金额是否是整数
			function checkpaymentfee(id)
			{
				if(!((/^\d{1,10}(\.\d{1,2})?$/).test(jQuery("#paymentfee"+id).val())))
				{
					jQuery("#showDialog").html('<b>实收金额填写不正确，只能填写小数或整数！</b>');
					jQuery("#paymentfee"+id).val(0);
					$('#message_returns_tips').dialog("open");
				}
			}
			
			//缴费方式列表
			function paymentWayCallback(data){
				jQuery("#paymentway").empty();
			    jQuery("#paymentway").append('<option value="0">--请选择--</option>');
			    if(data.academyBranchFeeWays!=null && data.academyBranchFeeWays.length>0)
			    {
			    	$.each(data.academyBranchFeeWays,function(){	
			    		jQuery("#paymentway").append('<option value="'+this.feeWayId+'">'+this.feeWayId.getPaymentWay()+'</option>'); 
			    	});
			   	}
			}
			//加载缴费单
			function yiyuanCallback(data){
				$('#payment_items > tbody').empty();
		    	var list="";
		    	var pendingIds="";
			    if(data.pendinglist!=null && data.pendinglist.length>0)
			    {
					$("#subtable").show();
				    $.each(data.pendinglist,function(){	
				    	list+='<tr>';								
						list+='<td>'+this.modeName+'</td>';
						list+='<td><span style="color:black !important" id="feesubjectname'+this.id+'">'+this.feeSubjectName+'</span></td>';
						list+='<td><span style="color:black !important" id="allmoney'+this.id+'">'+this.amountSurplus+'</span></td>';
						list+='<td><span style="color:black !important" id="discountfee'+this.id+'">0</span></td>';
						list+='<td><span style="color:black !important" id="needpay'+this.id+'" name="needpay'+this.id+'">'+this.amountSurplus+'</span></td>';
						if(data.academy!=null && data.academy.isForceFeePolicy==ISNEED_REBATES_TRUE)
						{
							list+='<td><input class="txt_box_100" id="paymentfee'+this.id+'" name="paymentfee'+this.id+'" value="'+this.amountSurplus+'" readonly="readonly"/></td>';
						}
						else
						{
							list+='<td><input onblur="checkpaymentfee('+this.id+')" class="txt_box_100" id="paymentfee'+this.id+'" value="'+this.amountSurplus+'" name="paymentfee'+this.id+'"/></td>';
						}
						list+='<td><span id="rechargeAmount'+this.id+'" style="color:black !important">0</span></td>';	
						list+='<td width="20%">';
						list+='<a href="javascript:usingdiscount('+this.id+');" title="使用优惠卷"><img src="<ui:img url="/images/icon_discount.gif" />" /><font size="-2">(使用优惠卷)</font></a>';
						list+='  <a href="javascript:usingaccount('+this.id+');" title="使用充值金额 "><img src="<ui:img url="/images/icon_discount.gif" />" /><font size="-2">(使用充值金额)</font></a>';
						list+='<input type="hidden" name="discountIds'+this.id+'" id="discountIds'+this.id+'" value=""/>';
						list+='<input type="hidden" id="discountAmount'+this.id+'" name="discountAmount'+this.id+'" value="0"/>';
						list+='<input type="hidden" id="amountPaied'+this.id+'" name="amountPaied'+this.id+'" value="0"/>';
						list+='<input type="hidden" id="rechargeAmounts'+this.id+'" name="rechargeAmount'+this.id+'" value="0"/>';
						list+='</td>';							
						list+='</tr>';	
						pendingIds+=this.id+",";	
				    });
					if(pendingIds!="" && pendingIds.length>0)
					{
						 $('#pendingIds').val(pendingIds.substring(0,(pendingIds.length-1)));	
					}
			    }
			    else
			   	{
			   		$("#nonetable").show();
			    	//list+='<tr><td align="center"><span>没有缴纳的费用!</span></td></tr>';
			    }	
			    $('#payment_items > tbody').html(list);	
				
			}
			
			//ajax回调函数   显示可以使用的学生优惠
			var pendFeePaymentId=0;//待缴费单Id
			var disids="";//要使用的优惠id集合  点确认才给隐藏域赋值
			function ajax_showdiscount(data)
			{				
				$('#showdiscount > tbody').empty();
			   	var list='';
			    if(data.applist!=null && data.applist.length>0)
			    {
			    	$.each(data.applist,function(){	
			    		list+='<tr>';
			    		list+='<td align="center"><input type="checkbox" name="discountbox" value="'+this.id+'"></td>';
			    		list+='<td align="center">'+this.code+'</td>';
			    		list+='<td align="center">'+this.feeSubjectName+'</td>';
			    		list+='<td align="center">'+this.startTime.substring(0,10)+"~"+this.endTime.substring(0,10)+'</td>';
			    		if(this.discountWay==MONEY_FORM_AMOUNT)
			    		{
			    			list+='<td align="center">'+this.money+'元</td>';
			    		}
			    		else
			    		{
			    			list+='<td align="center">'+this.money+'%</td>';
			    		}
			    		list+='</tr>';
			    	});
			    }
			    else
			    {
			    	list+='<tr><td colspan="6" align="center">没有已申请的优惠政策！</td></tr>';
			    }
			    $('#showdiscount > tbody').html(list);
			    	//初始化优惠卷的金额
			    	//jQuery('#reduceaftermoney').html(jQuery('#allmoney').html());
					//jQuery('#reducemoney').html('0');	
					//jQuery("#discountIds").val("");//清空使用优惠券的隐藏域ids集合
					////由于开始使用了再点的时候给它复原回去
					jQuery('#allmoney').html(jQuery('#allmoney'+pendFeePaymentId).html());
					jQuery('#reduceaftermoney').html((jQuery('#allmoney'+pendFeePaymentId).html()-0)-(jQuery('#discountfee'+pendFeePaymentId).html()-0));
					jQuery('#reducemoney').html(jQuery('#discountfee'+pendFeePaymentId).html());	
					if(jQuery("#discountIds"+pendFeePaymentId).val()!="")
					{
						var discountIds=(jQuery("#discountIds"+pendFeePaymentId).val()).split(",");
						//alert(jQuery("#discountIds").val());
						//复原选择的值
						var nobranch=$("input[name='discountbox']")
						nobranch.each(function(i){
							for(var i=0;i<discountIds.length;i++)
							{
								if(discountIds[i]==this.value)
								{
									$(this).attr("disabled",true);
									$(this).attr("checked",true);
								}	
							}			
						}); 
					}
			    $('#show_for_prompt').dialog('open');
			    disids="";
			    disids=$("#discountIds"+pendFeePaymentId).val();
			    //加载checkbox点击事件
			    $('[name=discountbox]').change(function(){
					if(this.checked)
					{
						discountpolicyId=this.value;
						$(this).attr("disabled",true);
						//隐藏域存放使用的优惠券Ids
						//if($("#discountIds").val()=="")
						if(disids=="")
						{
							//$("#discountIds").val(this.value+"");
							disids=this.value+"";
						}
						else
						{
							//$("#discountIds").val($("#discountIds").val()+","+this.value);
							disids=disids+","+this.value;
						}
						ajax_120_1();//使用优惠券
					}
				});
			}
			
			//ajax回调函数   使用优惠券
			var discountpolicyId=0;//
			function ajax_usingdiscount(data)
			{
				if(data.reduceaftermoney.length>0 && data.reducemoney.length>0)
				{
					jQuery('#reduceaftermoney').html(data.reduceaftermoney);
					jQuery('#reducemoney').html(data.reducemoney);
				}
				else
				{
					jQuery('#show_for_prompt').dialog("close");
					jQuery("#showDialog").html('<b>使用优惠券失败！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
			}
			
			//ajax回调函数   添加除报名费和测试费之外的其他所有费用
			function ajax_addtestpayment(data)
			{
				
				if(data.replayadd)
				{
					jQuery("#showDialog").html('<b>已添加过，不要重复添加！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(data.count==1)
				{
					jQuery("#showDialog").html('<b>收据号已使用过或不存在！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(data.count==0)
				{
					jQuery("#indexcount").val(1);
					jQuery("#showDialog").html('<b>缴费成功！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else
				{
					jQuery("#showDialog").html('<b>缴费失败！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
			}
			
			//ajax回调函数   显示该学生相关的充值金额
			function ajax_showaccount(data)
			{			
				if(data.studentAccount=="" || data.studentAccount==null)
				{
					jQuery("#stuaccountmoney").html(0);		
				}
				else
				{
					jQuery("#stuaccountmoney").html(data.studentAccount);		
				}
				if(data.studentAllAccount=="" || data.studentAllAccount==null)
				{
					jQuery("#stuallaccount").html(0);
				}
				else
				{
					jQuery("#stuallaccount").html(data.studentAllAccount);
				}
				
				$('#show_for_account').dialog('open');
			}
			
			//ajax回调函数   使用该学生相关的充值金额(暂时不用这个ajax)
			var accountallmoney='';
			var accountmoney='';
			function ajax_useaccount(data)
			{
				if(data.isfail)
				{
					jQuery("#showDialog").html('<b>使用充值金额失败！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else if(data.replayadd)
				{
					jQuery("#showDialog").html('<b>使用充值金额超过应缴金额！</b>');
					jQuery('#message_returns_tips').dialog("open");
				}
				else
				{
					//充值金额
					jQuery('#rechargeAmount'+pendFeePaymentId).html(jQuery("#useaccount").val());
					jQuery('#rechargeAmounts'+pendFeePaymentId).val(jQuery("#useaccount").val());
					
					//实缴金额（优惠后金额）
					jQuery('#paymentfee'+pendFeePaymentId).val(data.studentAccount);
					jQuery('#amountPaied'+pendFeePaymentId).val(data.studentAccount);
					//需缴金额
					jQuery('#needpay'+pendFeePaymentId).html(data.studentAccount);
					
					jQuery("#show_for_account").dialog("close"); 
				}
			}
			
	</script>
	
		<!--缴费方式下拉框-->
		<a:ajax 
			pluginCode="100"
			isOnload="all"
			parameters="jQuery('#myform').serializeObject()" 
			successCallbackFunctions="paymentWayCallback"
			urls="finance/payment/finance_payment_way_list"
		/>
		<!--加载缴费单列表-->
		<a:ajax 
			pluginCode="119"
			isOnload="all"
			parameters="{studentId:jQuery('#studentId').val(),academyId:jQuery('#academyId').val()}" 
			successCallbackFunctions="yiyuanCallback"
			urls="finance/payment/list_student_all_need_feepayment_ajax"
		/>
		
		<!--显示可以使用优惠券-->
		<a:ajax 
			pluginCode="110"
			successCallbackFunctions="ajax_showdiscount" 
			parameters="{studentId:jQuery('#studentId').val(),pendingFeePaymentId:pendFeePaymentId}" 
			urls="/finance/payment/list_student_can_using_application_ajax" 
		/>
		
		<!--使用优惠券-->
		<a:ajax 
			pluginCode="120"
			successCallbackFunctions="ajax_usingdiscount" 
			parameters="{discountpolicyId:discountpolicyId,allmoney:jQuery('#allmoney').html(),reducemoney:jQuery('#reducemoney').html()}" 
			urls="/finance/payment/using_student_feesubject_discount_application_ajax" 
		/>
		
		<!--添加除报名费和测试费之外的其他所有费用-->
		<a:ajax 
			pluginCode="130"
			successCallbackFunctions="ajax_addtestpayment" 
			parameters="jQuery('#feemyform').serializeObject()" 
			urls="/finance/payment/add_other_fee_payment_ajax" 			
		/>
		
		<!--显示该学生相关的充值金额-->
		<a:ajax 
			pluginCode="140"
			successCallbackFunctions="ajax_showaccount" 
			parameters="{pendingFeePaymentId:pendFeePaymentId}" 
			urls="/finance/payment/show_student_using_account_ajax" 
		/>
		
		<!--使用该学生相关的充值金额(暂时不用这个ajax)-->
		<a:ajax 
			pluginCode="150"
			successCallbackFunctions="ajax_useaccount" 
			parameters="{useaccount:jQuery(\"#useaccount\").val(),studentAccount:accountmoney,studentAllAccount:accountallmoney}" 
			urls="/finance/payment/show_student_used_account_ajax" 
		/>
		
	</head>
  
  <body>
  		
		<!-- 头开始 -->
		<head:head title="缴费管理">
			<html:a text="学生充值" icon="add" href="/finance/studentaccountmanagement/list_student_account_management" target="_blank"/>
		</head:head>
		<!--主体层开始 -->
		<body:body>
				<form id="myform" name="myform">
					<input type="hidden" id="branchId" name="student.branchId" value="${student.branchId}"/>
					<input type="hidden" id="batchId" name="student.enrollmentBatchId" value="${student.enrollmentBatchId}"/>
				</form>
				<form id="feemyform" name="feemyform">
					<input type="hidden" id="studentId" name="feePayment.studentId" value="${student.id}"/>	
					<input type="hidden" id="indexcount" name="indexcount" value="0"/>
					<input type="hidden" id="academyId" name="academyId" value="${student.academyId}"/>
					<input type="hidden" id="pendingIds" name="pendingIds" value=""/>
					<table class="gv_table_2">
			  		<tr>
					 	<th style="width:20px;"><img src="<ui:img url="/images/title_menu/title_left.gif" />" /></th>
					 	<th style="text-align:left; font-weight:bold;" class="feehtml">缴费管理 >> 缴费单</th>
					</tr>
					</table>
					
					 <table class="add_table" border="0" cellpadding="2" cellspacing="2">
					  	<tr>
					  		<td style="width:15%" align="right">缴费单号：</td>
							<td style="width:18%">${code}
							<input type="hidden" id="code" name="feePayment.code" value="${code}"/></td>
							<td style="width:15%" align="right"><span>*</span>缴费时间：</td>
							<td style="width:18%">
								<input type="text" name="feePayment.createdTime" value="${feedate}" id="createdTime" class="Wdate" onfocus="WdatePicker({skin:'whyGreen'})" readonly="readonly"/>
							</td>
			
							<td style="width:15%" align="right"></td>
							<td style="width:19%"></td>
					  	</tr>
						<tr>
					  		<td  align="right">院校：</td>
							<td >${student.schoolName}</td>
							<td  align="right">姓名：</td>
							<td >${student.name}</td>
							<td  align="right">性别：</td>
							<td >${student.gender==0?'女':'男'}</td>
					  	</tr>
						<tr>
					  		<td  align="right">批次：</td>
							<td >${student.academyenrollbatchName}</td>
			
							<td  align="right">层次：</td>
							<td >${student.levelName}</td>
					  		<td  align="right">专业：</td>
							<td >${student.majorName}</td>
			
					  	</tr>
					  </table>		
						  <table class="add_table" id="payment_items">
							<thead>
								<tr>
									<th>学制</th>
									<th>费用项目</th>
									<th>应收金额</th>
									<th>优惠金额  </th>
									<th>需缴金额  </th>
									<th>实收金额</th>
									<th>使用充值金额</th>
									<th>操作</th>
								</tr>
							</thead>
							
							<tbody>	
								
							</tbody>
							
						  </table>
		
				  
						  <table class="add_table" id="subtable" style="display:none">
						  	<tr>
								<td align="right" width="60%">
									缴费方式(仅显示该院校该中心的缴费方式)：<select id="paymentway" name="feePayment.feeWayId" class="txt_box_150"></select>
								</td>
								<td align="center" width="10%">
									<input type="checkbox" value="1" name="isFee" id="isFee"/><label>是否收款</label>
								</td>
								<td align="left" width="30%">
									<input type="checkbox" value="1" name="feePayment.isPrint" id="isPrint"/><label>是否打印</label>
									<span id="receipdiv" style="display:none"><span>*</span>收据号：<input type="text" name="feePayment.barCode" id="barCode" class="txt_box_150" /></span>
								</td>
				
							</tr>
						  	<tr>
								<td align="center" colspan="3">
									<input class="btn_black_130" type="button" value="保存" onclick="showsubmit();" id="submit"/>
									<input class="btn_black_61" type="button" value="取消" onclick="javascript:history.go(-1);"/>
								</td>
							</tr>
						</table>
						<table class="add_table" id="nonetable" style="display:none">
							<tr>
								<td align="center"><span><h2>无需要交的费用！</h2>(请生成待缴费单)</span></td>
							</tr>
							<tr>
								<td align="center" >
									<input class="btn_black_61" type="button" value="返回" id="" onclick="javascript:history.go(-1);"/>									
								</td>
							</tr>
						</table>					
				</form>
			</body:body>
			
		<!--弹出层-->
		<div id="message_returns_tips" style="display:none">
			<div align="center" id="showDialog">
			
			</div>
		</div>
		<div id="message_confirm" style="display:none">
			<div align="center" id="showconfirm">
				该费用科目账户余额不足，确认继续使用么？
			</div>
		</div>
		<div id="show_for_prompt" style="display:none">
			<table class="gv_table_2" id="showdiscount">
				<thead>
					<tr>
						<th></th>
						<th>优惠编号</th>
						<th>费用科目</th>
						<th>有效期</th>
						<th>优惠标准</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
			<table class="add_table">
				<tfoot>
					<tr>
						<td align="center" colspan="4">
							缴费金额：<span style="" id="allmoney"></span>
							优惠金额：<span style="" id="reducemoney">0</span>
							优惠后金额：<span style="" id="reduceaftermoney"></span>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
		
		<div id="show_for_account" style="display:none">
			<table class="gv_table_2" id="showaccount">
				<thead>
					<tr>
						<th>学生</th>
						<th>费用科目</th>
						<th>该科目剩余金额</th>
						<th>账户总金额</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td align="center">${student.name}</td>
						<td align="center"><span style="color:black !important" id="feeSubjectName"></span></td>
						<td align="center"><span style="color:black !important" id="stuaccountmoney"></span></td>
						<td align="center"><span style="color:black !important" id="stuallaccount"></span></td>
					</tr>
				</tbody>
			</table>
			<table class="add_table" id="">
				<tfoot>
					<tr>
						<td align="center" colspan="4">
							应缴金额：<span style="" id="allmoneyacc"></span>
							优惠金额：<span style="" id="reducemoneyacc">0</span>
							使用充值金额：<input class="txt_box_100" id="useaccount" value="0" />
						</td>
					</tr>
				</tfoot>
			</table>
		</div>		
  </body>
</html>
