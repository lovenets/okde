/**
 * 文件名：ExcelExportStudentEnrollmentSourceAction.java
 * 包名：net.cedu.action.report
 * 工程：cedu_pss_web
 * 功能： TODO /请自行添加
 *
 * 作者：yangdongdong    
 * 日期：2011-12-28 下午08:27:31
 *
*/
package net.cedu.action.report;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.cedu.action.BaseAction;
import net.cedu.dao.admin.UGroupUserDao;
import net.cedu.student.report.dao.EnrollmentSourceReport;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.beans.factory.annotation.Autowired;

public class ExcelExportBranchStudentEnrollmentSourceGeneralAction extends BaseAction {

	@Autowired
	private EnrollmentSourceReport enrollmentSourceReport;

	private Map<String, Integer> mapParams = new HashMap<String, Integer>();

	private Map<String, Date> dateParams = new HashMap<String, Date>();
	
	@Override
	public String execute() throws Exception {

		Map map=enrollmentSourceReport.statistics(mapParams,dateParams);
		List reportList = (List)map.get("quyuList");
		if (reportList != null && reportList.size() != 0) {
			downLoadFile(createExcel(reportList, "周例会招生途经统计",map), "周例会招生途经统计"+ ".xls");
			
			return null;
		}
		return SUCCESS;

	}
	/**
	 * 
	 * @功能：创建excel标题
	 * 
	 * @作者： 杨栋栋
	 * @作成时间：2011-12-27 下午11:58:50
	 * 
	 * @修改者：
	 * @修改内容：
	 * @修改时间：
	 * 
	 * @param title
	 * @return
	 * @throws Exception
	 */
	public HSSFWorkbook createExcel(List reportList, String title,Map result)
			throws Exception {
		try {

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet();
			wb.setSheetName(0, title);
			HSSFRow titleRow = sheet.createRow(0);
			HSSFRow head = sheet.createRow(1);
			HSSFRow head2 = sheet.createRow(2);

			// 创建标题
			createTitle(wb, titleRow, title);
			createCell(wb, head, 0, "区域经理",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 1, "学习中心",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 2, "中心主任",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 3, "招生指标",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 4, "社招",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 5, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 6, "渠道",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 7, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 8, "大客户",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 9, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 10, "老带新",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 11, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 12, "老生续读",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 13, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 14, "加盟",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 15, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 16, "共建",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 17, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 18, "合计",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head, 19, "",HSSFColor.GREY_25_PERCENT.index);
			
			

			sheet.addMergedRegion(getCellRangeAddress(1, 1, 1, 20));

			sheet.addMergedRegion(getCellRangeAddress(2, 3, 1, 1));
			sheet.addMergedRegion(getCellRangeAddress(2, 3, 2, 2));
			sheet.addMergedRegion(getCellRangeAddress(2, 3, 3, 3));
			sheet.addMergedRegion(getCellRangeAddress(2, 3, 4, 4));

			sheet.addMergedRegion(getCellRangeAddress(2, 2, 5, 6));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 7, 8));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 9, 10));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 11, 12));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 13, 14));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 15, 16));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 17, 18));
			sheet.addMergedRegion(getCellRangeAddress(2, 2, 19, 20));

			// 表头第二行

			createCell(wb, head2, 0, "",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 1, "",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 2, "",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 3, "",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 4, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 5, "比例",HSSFColor.GREY_25_PERCENT.index);

			createCell(wb, head2, 6, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 7, "比例",HSSFColor.GREY_25_PERCENT.index);

			createCell(wb, head2, 8, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 9, "比例",HSSFColor.GREY_25_PERCENT.index);

			createCell(wb, head2, 10, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 11, "比例",HSSFColor.GREY_25_PERCENT.index);

			createCell(wb, head2, 12, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 13, "比例",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 14, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 15, "比例",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 16, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 17, "比例",HSSFColor.GREY_25_PERCENT.index);
			
			createCell(wb, head2, 18, "人数",HSSFColor.GREY_25_PERCENT.index);
			createCell(wb, head2, 19, "比例",HSSFColor.GREY_25_PERCENT.index);
			
			//动态数据
			
			int row=3;//行的记录数
			int q=4;
			int x=4;
			int f=4;
			
			
			for (int i = 0; i < reportList.size(); i++) {
				//区域经理对象
				Map quyuObject=getMap(reportList.get(i));
				
				//学习中心List
				List xuexizhongxinList=getList(quyuObject.get("xuexiList"));
				for (int j = 0; j < xuexizhongxinList.size(); j++) {
					//学习中心对象
					Map xuexizhongxinObject=getMap(xuexizhongxinList.get(j));
					
					HSSFRow bodyRow = sheet.createRow(row++);
					Map fuwuzhanHeJiMap=getMap(xuexizhongxinObject.get("x_fuwuzhanHeJiMap"));
					createCell(wb, bodyRow, 0, quyuObject.get("quyuName").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 1, xuexizhongxinObject.get("xuexiName").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 2, xuexizhongxinObject.get("zhurenName").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 3, fuwuzhanHeJiMap.get("x_userZhaoShengZhiBiaoSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 4, fuwuzhanHeJiMap.get("x_shezhaoCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 5, fuwuzhanHeJiMap.get("x_shezhaoCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 6, fuwuzhanHeJiMap.get("x_qudaoCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 7, fuwuzhanHeJiMap.get("x_qudaoCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 8, fuwuzhanHeJiMap.get("x_dakehuCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 9, fuwuzhanHeJiMap.get("x_dakehuCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 10, fuwuzhanHeJiMap.get("x_laodaixinCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 11, fuwuzhanHeJiMap.get("x_laodaixinCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 12, fuwuzhanHeJiMap.get("x_laoshengxuduCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 13, fuwuzhanHeJiMap.get("x_laoshengxuduCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 14, fuwuzhanHeJiMap.get("x_jiamengCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 15, fuwuzhanHeJiMap.get("x_jiamengCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 16, fuwuzhanHeJiMap.get("x_gongjianCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 17, fuwuzhanHeJiMap.get("x_gongjianCountPSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 18, fuwuzhanHeJiMap.get("x_hejiCountSum").toString(),HSSFColor.WHITE.index);
					createCell(wb, bodyRow, 19, fuwuzhanHeJiMap.get("z_x_hejiCountSum").toString(),HSSFColor.WHITE.index);
					
				}
				
				HSSFRow bodyRow = sheet.createRow(row++);
				Map fuwuzhanHeJiMap=getMap(quyuObject.get("z_x_fuwuzhanHeJiMap"));
				createCell(wb, bodyRow, 0, "合计",HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 1, "",HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 2, "",HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 3, fuwuzhanHeJiMap.get("z_x_userZhaoShengZhiBiaoSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 4, fuwuzhanHeJiMap.get("z_x_shezhaoCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 5, fuwuzhanHeJiMap.get("z_x_shezhaoCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 6, fuwuzhanHeJiMap.get("z_x_qudaoCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 7, fuwuzhanHeJiMap.get("z_x_qudaoCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 8, fuwuzhanHeJiMap.get("z_x_dakehuCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 9, fuwuzhanHeJiMap.get("z_x_dakehuCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 10, fuwuzhanHeJiMap.get("z_x_laodaixinCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 11, fuwuzhanHeJiMap.get("z_x_laodaixinCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 12, fuwuzhanHeJiMap.get("z_x_laoshengxuduCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 13, fuwuzhanHeJiMap.get("z_x_laoshengxuduCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 14, fuwuzhanHeJiMap.get("z_x_jiamengCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 15, fuwuzhanHeJiMap.get("z_x_jiamengCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 16, fuwuzhanHeJiMap.get("z_x_gongjianCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 17, fuwuzhanHeJiMap.get("z_x_gongjianCountPSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 18, fuwuzhanHeJiMap.get("z_x_hejiCountSum").toString(),HSSFColor.CORAL.index);
				createCell(wb, bodyRow, 19, fuwuzhanHeJiMap.get("z_x_hejiCountSumP").toString(),HSSFColor.CORAL.index);
				
				//合并单元格
				sheet.addMergedRegion(getCellRangeAddress(row, row, 1, 3));
				
				if(i==0){
					sheet.addMergedRegion(getCellRangeAddress(q, row-1, 1, 1));
					q=row;
				}else{
					sheet.addMergedRegion(getCellRangeAddress(q+1, row-1, 1, 1));
					q=row;
				}
				x++;
				x++;
				f++;
				
			}
			
			HSSFRow bodyRow = sheet.createRow(row++);
			createCell(wb, bodyRow, 0, "总合计",HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 1, "",HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 2, "",HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 3, result.get("zhubiaoSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 4, result.get("shezhaoSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 5, result.get("shezhaoSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 6, result.get("qudaoSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 7, result.get("qudaoSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 8, result.get("dakehuSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 9, result.get("dakehuSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 10, result.get("laodaixinSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 11, result.get("laodaixinSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 12, result.get("laoshengxuduSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 13, result.get("laoshengxuduSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 14, result.get("jiamengSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 15, result.get("jiamengSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 16, result.get("gongjianSum").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 17, result.get("gongjianSumP").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 18, result.get("heji").toString(),HSSFColor.YELLOW.index);
			createCell(wb, bodyRow, 19, "",HSSFColor.YELLOW.index);
			
			//合并单元格
			sheet.addMergedRegion(getCellRangeAddress(row, row, 1, 3));
			
			
			
			// 设置列宽
			sheet.setColumnWidth(1, 5000);// 单位
			sheet.setColumnWidth(2, 5000);// 单位
			sheet.setColumnWidth(3, 2000);// 单位
			
			return wb;
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}

	}

	/**
	 * 
	 * @功能：创建标题
	 * 
	 * @作者： 杨栋栋
	 * @作成时间：2011-12-27 下午11:43:06
	 * 
	 * @修改者：
	 * @修改内容：
	 * @修改时间：
	 * 
	 * @param wb
	 * @param titleRow
	 * @param title
	 */
	private void createTitle(HSSFWorkbook wb, HSSFRow titleRow, String title) {
		titleRow.setHeight((short) 600);
		HSSFCell cell = titleRow.createCell(0);
		HSSFRichTextString h = new HSSFRichTextString(title);
		// 字体样式
		HSSFFont font = wb.createFont();
		font.setColor(HSSFColor.BLACK.index);
		font.setFontHeightInPoints((short) 18);
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		h.applyFont(font);
		cell.setCellValue(h);
		cell.setCellStyle(getCellDefaultStyle(wb,HSSFColor.WHITE.index));
	}

	/**
	 * 
	 * @功能：获取单元格默认样式
	 * 
	 * @作者： 杨栋栋
	 * @作成时间：2011-12-27 下午11:42:39
	 * 
	 * @修改者：
	 * @修改内容：
	 * @修改时间：
	 * 
	 * @param wb
	 * @return
	 */
	private HSSFCellStyle getCellDefaultStyle(HSSFWorkbook wb,short color) {
		// 设置单元格样式
		HSSFCellStyle cellstyle = wb.createCellStyle();
		cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER_SELECTION);// 设置水平对齐方式
		cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 设置垂直对齐方式
		cellstyle.setFillForegroundColor(color);

		cellstyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);

		cellstyle.setWrapText(true);
		return cellstyle;
	}

	/**
	 * 
	 * @功能：创建cell
	 * 
	 * @作者： 杨栋栋
	 * @作成时间：2011-12-27 下午11:46:12
	 * 
	 * @修改者：
	 * @修改内容：
	 * @修改时间：
	 * 
	 * @param wb
	 * @param row
	 * @param col
	 * @param val
	 */
	private void createCell(HSSFWorkbook wb, HSSFRow row, int col, String val,short color) {

		HSSFCell cell = row.createCell(col);
		cell.setCellValue(val);
		cell.setCellStyle(getCellDefaultStyle(wb,color));

	}

	private Map getMap(Object o) {
		return (Map) o;
	}

	private List getList(Object o) {
		return (List) o;
	}

	private CellRangeAddress getCellRangeAddress(int startRow, int endRow,
			int startColumn, int endColumn) {
		return new CellRangeAddress(startRow - 1, endRow - 1, startColumn - 1,
				endColumn - 1);
	}

	public void setMapParams(Map<String, Integer> mapParams) {
		this.mapParams = mapParams;
	}

	public Map<String, Integer> getMapParams() {
		return mapParams;
	}
	public Map<String, Date> getDateParams() {
		return dateParams;
	}
	public void setDateParams(Map<String, Date> dateParams) {
		this.dateParams = dateParams;
	}
}
