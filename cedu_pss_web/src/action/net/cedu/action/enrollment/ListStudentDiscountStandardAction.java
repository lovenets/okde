package net.cedu.action.enrollment;

import java.text.Collator;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import net.cedu.action.BaseAction;
import net.cedu.biz.academy.AcademyBiz;
import net.cedu.biz.basesetting.EnrollmentSourceBiz;
import net.cedu.biz.basesetting.FeeSubjectBiz;
import net.cedu.entity.academy.Academy;
import net.cedu.entity.basesetting.EnrollmentSource;
import net.cedu.entity.basesetting.FeeSubject;

/**
 * 学生优惠政策标准
 * @author lixiaojun
 *
 */
public class ListStudentDiscountStandardAction extends BaseAction
{

	@Autowired 
	private AcademyBiz academyBiz;//院校biz
	private List<Academy> academylist=new ArrayList<Academy>();//院校集合	
	
	@Autowired
	private FeeSubjectBiz feeSubjectBiz;//费用科目biz
	private List<FeeSubject> feesubjectlist=new ArrayList<FeeSubject>();//费用科目集合
	
	@Autowired
	private EnrollmentSourceBiz enrollmentSourceBiz;//合作方类型业务接口
	private List<EnrollmentSource> channeltypelist=new ArrayList<EnrollmentSource>();//合作方类型集合
	
	
	public String execute() throws Exception 
	{
		if(super.isGetRequest())
		{	
			academylist=this.academyBiz.findAllAcademyByFlagFalse();
			Collections.sort(academylist, new Comparator() {
				public int compare(Object arg0, Object arg1) {
					Comparator cmp = Collator
							.getInstance(java.util.Locale.CHINA);
					String name1 = ((Academy) arg0).getName();
					String name2 = ((Academy) arg1).getName();
					return cmp.compare(name1, name2);
				}
			});
			feesubjectlist=this.feeSubjectBiz.findAllFeeSubjectByDeleteFlag();
			Collections.sort(feesubjectlist, new Comparator() {
				public int compare(Object arg0, Object arg1) {
					Comparator cmp = Collator
							.getInstance(java.util.Locale.CHINA);
					String name1 = ((FeeSubject) arg0).getName();
					String name2 = ((FeeSubject) arg1).getName();
					return cmp.compare(name1, name2);
				}
			});
			channeltypelist=this.enrollmentSourceBiz.findAllEnrollmentSourceByDeleteFlag();
		 
			return INPUT;
		}
		return SUCCESS;
	}


	public List<Academy> getAcademylist() {
		return academylist;
	}


	public void setAcademylist(List<Academy> academylist) {
		this.academylist = academylist;
	}


	public List<FeeSubject> getFeesubjectlist() {
		return feesubjectlist;
	}


	public void setFeesubjectlist(List<FeeSubject> feesubjectlist) {
		this.feesubjectlist = feesubjectlist;
	}


	public List<EnrollmentSource> getChanneltypelist() {
		return channeltypelist;
	}


	public void setChanneltypelist(List<EnrollmentSource> channeltypelist) {
		this.channeltypelist = channeltypelist;
	}
	
	
}
