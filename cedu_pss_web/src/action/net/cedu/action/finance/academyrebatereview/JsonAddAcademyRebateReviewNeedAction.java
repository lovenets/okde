package net.cedu.action.finance.academyrebatereview;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import net.cedu.action.BaseAction;
import net.cedu.biz.academy.AcademyBiz;
import net.cedu.biz.admin.BranchBiz;
import net.cedu.biz.basesetting.FeeSubjectBiz;
import net.cedu.biz.basesetting.LevelBiz;
import net.cedu.biz.crm.StudentBiz;
import net.cedu.biz.enrollment.AcademyEnrollBatchBiz;
import net.cedu.biz.enrollment.AcademyRebatePolicyDetailBiz;
import net.cedu.biz.enrollment.AcademyRebatePolicyDetailStandardBiz;
import net.cedu.biz.enrollment.MajorBiz;
import net.cedu.biz.finance.FeePaymentBiz;
import net.cedu.biz.finance.FeePaymentDetailBiz;
import net.cedu.biz.finance.StudentAcademyRebateBiz;
import net.cedu.entity.academy.Academy;
import net.cedu.entity.admin.Branch;
import net.cedu.entity.basesetting.FeeSubject;
import net.cedu.entity.basesetting.Level;
import net.cedu.entity.crm.Student;
import net.cedu.entity.enrollment.AcademyEnrollBatch;
import net.cedu.entity.enrollment.AcademyRebatePolicyDetail;
import net.cedu.entity.enrollment.AcademyRebatePolicyDetailStandard;
import net.cedu.entity.enrollment.ChannelPolicyDetail;
import net.cedu.entity.enrollment.Major;
import net.cedu.entity.finance.FeePayment;
import net.cedu.entity.finance.FeePaymentDetail;
import net.cedu.entity.finance.StudentAcademyRebate;
import net.cedu.model.page.PageResult;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 院校返款单新增(院校返款单新增(现需返款的缴费单明细ajax)__2012-05-07重构
 * 
 * @author xiao
 * 
 */
@ParentPackage("json-default")
public class JsonAddAcademyRebateReviewNeedAction extends BaseAction
{
	// 分页结果
	private PageResult<FeePaymentDetail> result = new PageResult<FeePaymentDetail>();
	
	@Autowired
	private FeePaymentDetailBiz feePaymentDetailBiz;//缴费单明细_业务层接口
	
	private String feepdIds;//缴费单明细Ids字符串集合
	
	//*******************判断缴费单明细是否符合院校返款条件************************//
	private String oldFeepdIds;//缴费单明细Ids字符串集合(已经有的)
	private String addFeepdIds;//缴费单明细Ids字符串集合(新添加的，要判断的)
	private String newFeepdIds="";//缴费单明细Ids字符串集合(组合后的)

	//*******************移除选中的缴费单明细************************//

	private String allFeepdIds;///缴费单明细Ids字符串集合(已经有的)
	private String delFeepdIds;//缴费单明细Ids字符串集合(移除的)
	private String newdelFeepdIds="";//缴费单明细Ids字符串集合(组合后的)
	
	private String allNeedFpdIds;//统计结算后的缴费单明细Ids字符串集合(已经有的)
	private String newDelNeedFeepdIds="";//统计结算后的缴费单明细Ids字符串集合(组合后的)
	
	private boolean isfail=true;//控制传人的参数是否正确
	
	//****************************统计现需返款的缴费单明细招生返款总金额**********************//
	private List<FeePaymentDetail> notPoliceFpdList=new ArrayList<FeePaymentDetail>();//匹配不到返款政策的列表
	private List<FeePaymentDetail> noPeoplePoliceFpdList=new ArrayList<FeePaymentDetail>();//人数达不到返款标准的列表
	private boolean isback=true;
	@Autowired
	private StudentBiz studentBiz;//学生_业务层接口
	@Autowired
	private AcademyBiz academyBiz;// 院校_业务接口
	@Autowired
	private AcademyEnrollBatchBiz academyenrollbatchBiz;// 院校招生批次 _业务接口
	@Autowired
	private LevelBiz levelbiz; // 层次_业务接口
	@Autowired
	private MajorBiz majorbiz; // 专业_业务接口
	@Autowired
	private BranchBiz branchBiz; // 学习中心_业务接口
	@Autowired
	private AcademyRebatePolicyDetailStandardBiz arpdsBiz;//院校返款标准明细_业务层接口
	
	@Autowired
	private AcademyRebatePolicyDetailBiz academyRebatePolicyDetailBiz;//院校返款政策_业务层接口
	@Autowired 
	private StudentAcademyRebateBiz studentAcademyRebateBiz;//学生绑定院校返款标准关系表
	
	private String newNeedFpdIds="";//能算出返款金额的缴费单明细Ids字符串
	private String allMoney;//统计现需返款的缴费单明细院校返款总金额
	private String addMoney;//统计根据现需返款的缴费单明细追加的院校返款金额
	
	/**
	 * 获取现需返款的缴费单明细数量
	 * @return
	 * @throws Exception
	 */
	@Action(value = "count_academy_rebate_review_fpd_need_ajax", results = { @Result(name = "success", type = "json", params = {
			"contentType", "text/json" }) })
	public String playmoneyCount() throws Exception 
	{
		if(feepdIds!=null && feepdIds.length()>0)
		{
			String[] ids=feepdIds.split(",");
			result.setRecordCount(ids.length);
		}
		else
		{
			result.setRecordCount(0);
		}
		return SUCCESS;
	}

	/**
	 * 获取现需返款的缴费单明细列表
	 * @return
	 * @throws Exception
	 */
	@Action(value = "list_academy_rebate_review_fpd_need_ajax", results = { @Result(name = "success", type = "json", params = {
			"contentType", "text/json" }) })
	public String playmoneyList() throws Exception 
	{	
		result.setList(this.feePaymentDetailBiz.findFeePaymentDetailListByPageForNowAddAcademyRebate(feepdIds,result));
		return SUCCESS;
	}
	
	/**
	 * 判断缴费单明细是否符合院校返款条件
	 * @return
	 * @throws Exception
	 */
	@Action(value = "test_fpd_academy_rebate_review_need_ajax", results = { @Result(name = "success", type = "json", params = {
			"contentType", "text/json" }) })
	public String fpdforacademyrebate() throws Exception 
	{	
		if(oldFeepdIds!=null && !oldFeepdIds.equals(""))
		{
			newFeepdIds=oldFeepdIds;//赋值
		}
		if(addFeepdIds!=null && addFeepdIds.length()>0)
		{
			String[] ids=addFeepdIds.split(",");			
			for (int i = 0; i < ids.length; i++)
			{				
				//判断是否存在
				if(oldFeepdIds!=null && !oldFeepdIds.equals(""))
				{
					String zuhefpd=","+oldFeepdIds+",";
					if(zuhefpd.indexOf(","+ids[i]+",")!=-1)
					{
						continue;
					}
					else
					{
						if(newFeepdIds!=null && !newFeepdIds.equals(""))
						{
							newFeepdIds+=","+ids[i];
						}
						else
						{
							newFeepdIds+=ids[i];
						}
						//更新院校返款金额为0，保证每次勾选的院校返款金额为0
						FeePaymentDetail fpd=this.feePaymentDetailBiz.findById(Integer.valueOf(ids[i]));
						if(fpd!=null && fpd.getPayAcademyCedu()>0)
						{
							fpd.setPayAcademyCedu(0);
							fpd.setUpdatedTime(new Date());
							fpd.setUpdaterId(super.getUser().getUserId());
							this.feePaymentDetailBiz.updateFeePaymentDetail(fpd);
						}
					}
				}
				else
				{
					if(newFeepdIds!=null && !newFeepdIds.equals(""))
					{
						newFeepdIds+=","+ids[i];
					}
					else
					{
						newFeepdIds+=ids[i];
					}
					//更新院校返款金额为0，保证每次勾选的院校返款金额为0
					FeePaymentDetail fpd=this.feePaymentDetailBiz.findById(Integer.valueOf(ids[i]));
					if(fpd!=null && fpd.getPayAcademyCedu()>0)
					{
						fpd.setPayAcademyCedu(0);
						fpd.setUpdatedTime(new Date());
						fpd.setUpdaterId(super.getUser().getUserId());
						this.feePaymentDetailBiz.updateFeePaymentDetail(fpd);
					}
				}
			}
		}
		else
		{
			isfail=false;
		}
		return SUCCESS;
	}
	
	/**
	 * 移除缴费单明细
	 * @return
	 * @throws Exception
	 */
	@Action(value = "del_fpd_academy_rebate_review_need_ajax", results = { @Result(name = "success", type = "json", params = {
			"contentType", "text/json" }) })
	public String delfpdforacademyrebate() throws Exception 
	{
		if(allFeepdIds!=null && !allFeepdIds.equals("") && delFeepdIds!=null && !delFeepdIds.equals(""))
		{
			String[] allIds=allFeepdIds.split(",");
			String[] delIds=delFeepdIds.split(",");
			boolean ishave=false;
			for(int i=0;i<allIds.length;i++)
			{
				ishave=false;
				for(int k=0;k<delIds.length;k++)
				{
					if(allIds[i].equals(delIds[k]))
					{
						ishave=true;
						break;
					}
				}
				if(!ishave)
				{
					if(newdelFeepdIds!=null && !newdelFeepdIds.equals(""))
					{
						newdelFeepdIds+=","+allIds[i];
					}
					else
					{
						newdelFeepdIds+=allIds[i];
					}
				}
			}
			if(allNeedFpdIds!=null && !allNeedFpdIds.equals(""))
			{
				String[] allNeIds=allNeedFpdIds.split(",");
				boolean ishane=false;
				for(int i=0;i<allNeIds.length;i++)
				{
					ishane=false;
					for(int k=0;k<delIds.length;k++)
					{
						if(allNeIds[i].equals(delIds[k]))
						{
							ishane=true;
							break;
						}
					}
					if(!ishane)
					{
						if(newDelNeedFeepdIds!=null && !newDelNeedFeepdIds.equals(""))
						{
							newDelNeedFeepdIds+=","+allNeIds[i];
						}
						else
						{
							newDelNeedFeepdIds+=allNeIds[i];
						}
					}
				}
			}
		}
		else
		{
			isfail=false;
		}
		return SUCCESS;
	}
	/**
	 * 统计现需返款的缴费单明细
	 * @return
	 * @throws Exception
	 */
	@Action(value = "count_academy_rebate_review_fpd_for_need_all_money_ajax", results = { @Result(name = "success", type = "json", params = {
			"contentType", "text/json" }) })
	public String channelForNowMoneyList() throws Exception 
	{	
		if(feepdIds!=null && !feepdIds.equals(""))
		{
			String[] fIds=feepdIds.split(",");
			boolean isbool=false;
			FeePaymentDetail fpd=null;
			for(int i=0;i<fIds.length;i++)
			{
				isbool=false;
				fpd=this.feePaymentDetailBiz.findById(Integer.valueOf(fIds[i]));
				if(fpd!=null)
				{
					Student student=this.studentBiz.findStudentById(fpd.getStudentId());
					if(student!=null)
					{
						isbool=arpdsBiz.updateFpdForAcademyRebateReviewByFpdIdAndFpdIds(Integer.valueOf(fIds[i]),feepdIds);
						//更新不成功的缴费单
						if(!isbool)
						{
							//学生姓名
							Student stude=this.studentBiz.findStudentById(fpd.getStudentId());
							if(stude!=null)
							{
								//学生姓名
								fpd.setStudentName(stude.getName());
								//院校
								Academy academy=academyBiz.findAcademyById(stude.getAcademyId());
								if(stude.getAcademyId()>0 && academy!=null)
								{
									fpd.setSchoolName(academy.getName());
								}
								//学习中心
								Branch branch=branchBiz.findBranchById(stude.getBranchId());
								if(stude.getBranchId()>0 && branch!=null)
								{
									fpd.setBranchName(branch.getName());
								}
								//批次
								AcademyEnrollBatch aeb=academyenrollbatchBiz.findAcademyEnrollBatchById(stude.getEnrollmentBatchId());
								if(stude.getEnrollmentBatchId()>0 && aeb!=null)
								{
									fpd.setAcademyenrollbatchName(aeb.getEnrollmentName());
								}
								//层次
								Level level=levelbiz.findLevelById(stude.getLevelId());
								if(stude.getLevelId()>0 && level!=null)
								{
									fpd.setLevelName(level.getName());
								}
								//专业
								Major major=majorbiz.findMajorById(stude.getMajorId());
								if(stude.getMajorId()>0 && major!=null)
								{
									fpd.setMajorName(major.getName());
								}
							}
							else
							{
								fpd.setStudentName("");
							}
							AcademyRebatePolicyDetail arpd=this.academyRebatePolicyDetailBiz.findForStudnet(student,fpd.getFeeSubjectId(),false);
							if(arpd==null)
							{
								notPoliceFpdList.add(fpd);//没有政策的缴费单
							}
							else
							{
								noPeoplePoliceFpdList.add(fpd);//有政策人数不够
							}
							
							//更新院校返款金额为0，保证每次统计结算的院校返款单不满足条件的院校返款金额都为0
							if(fpd!=null && fpd.getPayAcademyCedu()>0)
							{
								fpd.setPayAcademyCedu(0);
								fpd.setUpdatedTime(new Date());
								fpd.setUpdaterId(super.getUser().getUserId());
								this.feePaymentDetailBiz.updateFeePaymentDetail(fpd);
							}
							
							isback=false;//判断是否要弹出层显示不符合条件的返款单明细
						}
						else
						{
							if(newNeedFpdIds!=null && !newNeedFpdIds.equals(""))
							{
								newNeedFpdIds+=","+fIds[i];
							}
							else
							{
								newNeedFpdIds+=fIds[i];
							}
						}
					}
				}
			}		
		}		
		//统计符合招生返款条件的所有缴费单招生返款总金额
		if(newNeedFpdIds!=null && !newNeedFpdIds.equals(""))
		{
			allMoney=this.feePaymentDetailBiz.countFpdAllAcademyRebateMoneyByFpdIds(newNeedFpdIds);
		}
		else 
		{
			allMoney="0";
		}
		//统计追加金额
		if(newNeedFpdIds!=null && !newNeedFpdIds.equals(""))
		{
			addMoney=feePaymentDetailBiz.countFpdAddAcademyRebateMoneyByFpdIds(newNeedFpdIds);
		}
		else 
		{
			addMoney="0";
		}
		
		return SUCCESS;
	}

	public PageResult<FeePaymentDetail> getResult() {
		return result;
	}

	public void setResult(PageResult<FeePaymentDetail> result) {
		this.result = result;
	}

	public String getFeepdIds() {
		return feepdIds;
	}

	public void setFeepdIds(String feepdIds) {
		this.feepdIds = feepdIds;
	}

	public String getOldFeepdIds() {
		return oldFeepdIds;
	}

	public void setOldFeepdIds(String oldFeepdIds) {
		this.oldFeepdIds = oldFeepdIds;
	}

	public String getAddFeepdIds() {
		return addFeepdIds;
	}

	public void setAddFeepdIds(String addFeepdIds) {
		this.addFeepdIds = addFeepdIds;
	}

	public String getNewFeepdIds() {
		return newFeepdIds;
	}

	public void setNewFeepdIds(String newFeepdIds) {
		this.newFeepdIds = newFeepdIds;
	}

	public String getAllFeepdIds() {
		return allFeepdIds;
	}

	public void setAllFeepdIds(String allFeepdIds) {
		this.allFeepdIds = allFeepdIds;
	}

	public String getDelFeepdIds() {
		return delFeepdIds;
	}

	public void setDelFeepdIds(String delFeepdIds) {
		this.delFeepdIds = delFeepdIds;
	}

	public String getNewdelFeepdIds() {
		return newdelFeepdIds;
	}

	public void setNewdelFeepdIds(String newdelFeepdIds) {
		this.newdelFeepdIds = newdelFeepdIds;
	}

	public boolean isIsfail() {
		return isfail;
	}

	public void setIsfail(boolean isfail) {
		this.isfail = isfail;
	}

	public String getAllMoney() {
		return allMoney;
	}

	public void setAllMoney(String allMoney) {
		this.allMoney = allMoney;
	}

	public String getAllNeedFpdIds() {
		return allNeedFpdIds;
	}

	public void setAllNeedFpdIds(String allNeedFpdIds) {
		this.allNeedFpdIds = allNeedFpdIds;
	}

	public String getNewDelNeedFeepdIds() {
		return newDelNeedFeepdIds;
	}

	public void setNewDelNeedFeepdIds(String newDelNeedFeepdIds) {
		this.newDelNeedFeepdIds = newDelNeedFeepdIds;
	}

	public List<FeePaymentDetail> getNotPoliceFpdList() {
		return notPoliceFpdList;
	}

	public void setNotPoliceFpdList(List<FeePaymentDetail> notPoliceFpdList) {
		this.notPoliceFpdList = notPoliceFpdList;
	}

	public List<FeePaymentDetail> getNoPeoplePoliceFpdList() {
		return noPeoplePoliceFpdList;
	}

	public void setNoPeoplePoliceFpdList(
			List<FeePaymentDetail> noPeoplePoliceFpdList) {
		this.noPeoplePoliceFpdList = noPeoplePoliceFpdList;
	}

	public boolean isIsback() {
		return isback;
	}

	public void setIsback(boolean isback) {
		this.isback = isback;
	}

	public String getNewNeedFpdIds() {
		return newNeedFpdIds;
	}

	public void setNewNeedFpdIds(String newNeedFpdIds) {
		this.newNeedFpdIds = newNeedFpdIds;
	}

	public String getAddMoney() {
		return addMoney;
	}

	public void setAddMoney(String addMoney) {
		this.addMoney = addMoney;
	}
	
	
}
