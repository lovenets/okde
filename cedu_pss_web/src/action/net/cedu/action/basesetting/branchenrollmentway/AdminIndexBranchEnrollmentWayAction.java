package net.cedu.action.basesetting.branchenrollmentway;

import net.cedu.action.BaseAction;
import net.cedu.biz.admin.BranchBiz;

import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 市场途径授权范围首页
 * @author Jack
 *
 */
@Results( {
	@Result(name = "success", location = "/WEB-INF/content/basesetting/branchenrollmentway/index_branch_enrollment_way.jsp") 
})
public class AdminIndexBranchEnrollmentWayAction extends BaseAction 
{
	private static final long serialVersionUID = 4384055175835481869L;

	@Autowired
	private BranchBiz BranchBiz;
	
	//private List<Branch> blist=new ArrayList<Branch>();
	
	public String execute()
	{
		try
		{
			//blist=BranchBiz.findListById(getUser().getOrgId());
			//2012-1-11 周三 上午10：17修改为当前学习中心
			request.setAttribute("branchObject", BranchBiz.findBranchById(super.getUser().getOrgId()));
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return SUCCESS;
	}

//	public List<Branch> getBlist() {
//		return blist;
//	}
}
