package egovframework.sample.web;

import com.fasterxml.jackson.databind.ObjectMapper;
import egovframework.common.Constants;
import egovframework.common.service.CommonService;
import egovframework.common.util.ExcelUtil;
import egovframework.common.vo.CommonHashMap;
import egovframework.sample.service.SampleService;
import egovframework.sample.vo.ImageVO;
import egovframework.sample.vo.OcrRequestVO;
import egovframework.sample.vo.SampleVO;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.hsqldb.lib.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class SampleController {
	private static final Logger LOGGER = LoggerFactory.getLogger(SampleController.class);

	/** SampleService */
	@Autowired
	private SampleService sampleService;

	/** CommonService */
	@Autowired
	private CommonService commonService;

	@Autowired
	private JavaMailSender mailSender;

	/**
	 * ??????????????????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleList.do")
	public ModelAndView sampleList(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		// ????????? ?????????
		//mav.addObject("pageUnitList", commonService.getPageUnitList());

		mav.setViewName("sample/board/sampleList");

		return mav;
	}

	/**
	 * ????????? ??????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/selectList.do")
	public ModelAndView selectList(HttpServletRequest request, @ModelAttribute("sampleVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");

		searchVO.setPageIndex(searchVO.getPageIndex());
		searchVO.setPageUnit(searchVO.getBasicPageUnit());
		searchVO.setPagingInfo();

		int totalCnt = sampleService.selectBoardTotalCnt(searchVO);
		mav.addObject("resultCnt", totalCnt);

		List<CommonHashMap<String, Object>> sampleList = new ArrayList<CommonHashMap<String,Object>>();
		if (totalCnt > 0) {
			sampleList = sampleService.selectBoardList(searchVO);
		}
		mav.addObject("resultList", sampleList);

		searchVO.setPagingCount(totalCnt);
		mav.addObject("paginationInfo", searchVO.getPaginationInfo());

		return mav;
	}

	/**
	 * ??????/?????? ??????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleWrite.do")
	public ModelAndView sampleWrite(HttpServletRequest request, @ModelAttribute("sampleVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		try {
			if (searchVO.getArticleSeq() != 0) {
				CommonHashMap<String, Object> sampleView = sampleService.selectBoardView(request, searchVO);
				mav.addObject("resultView", sampleView);
			}

			mav.setViewName("sample/board/sampleWrite");
		} catch (Exception e) {
			LOGGER.debug(e.getMessage());

			mav.setViewName("redirect:" + request.getContextPath() + "/error.do");
		}

		return mav;
	}

	/**
	 * ????????? ??????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleView.do")
	public ModelAndView sampleView(HttpServletRequest request, @ModelAttribute("sampleVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		try {
			CommonHashMap<String, Object> sampleView = sampleService.selectBoardView(request, searchVO);
			mav.addObject("resultView", sampleView);

			mav.setViewName("sample/board/sampleView");
		} catch (Exception e) {
			LOGGER.debug(e.getMessage());

			mav.setViewName("redirect:" + request.getContextPath() + "/error.do");
		}

		return mav;
	}

	/**
	 * ????????? ??????
	 *
	 * @param request
	 * @param sampleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleInsert.do")
	public ModelAndView sampleInsert(MultipartHttpServletRequest request, @ModelAttribute("sampleVO")SampleVO sampleVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		sampleService.insertBoardArticle(request, sampleVO);

		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * ????????? ??????
	 *
	 * @param request
	 * @param sampleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleUpdate.do")
	public ModelAndView update(MultipartHttpServletRequest request, @ModelAttribute("sampleVO")SampleVO sampleVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		sampleService.updateBoardArticle(request, sampleVO);

		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * ????????? ??????
	 *
	 * @param request
	 * @param sampleVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleDelete.do")
	public ModelAndView delete(HttpServletRequest request, @ModelAttribute("sampleVO")SampleVO sampleVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		sampleService.deleteBoardArticle(request, sampleVO);

		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * CHUNKED ????????? ??????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/chunked/view.do")
	public ModelAndView chunked(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/chunked/view");

		return mav;
	}

	@RequestMapping(value = "/sample/board/headerList/excelDownload.do")
	public ModelAndView headerListExcelDownload(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		// ?????? ????????? ??????
		List<CommonHashMap<String, String>> headerList = new ArrayList<CommonHashMap<String, String>>();

		// name, key
		headerList.add(ExcelUtil.setHeaderList("NO.", "RNUM"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "CORP_NAME_KR"));
		headerList.add(ExcelUtil.setHeaderList("*?????????????????????", "TRADE_NO"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "CORP_REG_NO"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "CORP_NO"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "REPRE_NAME_KR"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "CORP_ADDR"));
		headerList.add(ExcelUtil.setHeaderList("??????", "MAN_NAME"));
		headerList.add(ExcelUtil.setHeaderList("??????", "MAN_POS"));
		headerList.add(ExcelUtil.setHeaderList("??????", "MAN_DEPT"));
		headerList.add(ExcelUtil.setHeaderList("????????????(?????????)", "MAN_TELNO"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "MAN_FAXNO"));
		headerList.add(ExcelUtil.setHeaderList("??????????????????", "MAN_HPNO"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "MAN_EMAIL"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "MEMBER_LEV"));
		headerList.add(ExcelUtil.setHeaderList("??????????????????", "DUES_YEAR"));
		headerList.add(ExcelUtil.setHeaderList("????????? ????????????", "EXP_AMT"));
		headerList.add(ExcelUtil.setHeaderList("*??????ID", "INS_ID"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "INS_NAME"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "SELF_COST"));
		headerList.add(ExcelUtil.setHeaderList("??????????????? ????????????", "PAY_DATE"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "REQ_DATE"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "APPLY_DATE"));
		headerList.add(ExcelUtil.setHeaderList("*??????(????????????/????????????/????????????)", "STATUS_NM"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "RETURN_RSN"));
		headerList.add(ExcelUtil.setHeaderList("????????????_???????????????", "LAST_INS_START_DATE"));
		headerList.add(ExcelUtil.setHeaderList("????????????_???????????????", "LAST_INS_END_DATE"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "INS_START_DATE"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "INS_END_DATE"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "INS_AMT"));

		//?????? ???????????? ??????
		// insuranceRegistService.selectInsuranceReqListForExcel(searchVO);
		List<CommonHashMap<String, String>> contentList = sampleService.selectExcelForHeaderList(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mode", Constants.EXCEL_HEADER_LIST);
		map.put("header", headerList);
		map.put("list", contentList);

		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());

		map.put("fileName", "??????????????????_????????????_" + today);

		return new ModelAndView("commonPOIExcel", "infomationMap", map);
	}

	@RequestMapping(value = "/sample/board/doubleList/excelDownload.do")
	public ModelAndView doubleListExcelDownload(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		// ?????? ????????? ??????
		List<CommonHashMap<String, String>> headerList = new ArrayList<CommonHashMap<String, String>>();

		// headerType, startIdx, endIdx, group, name, key
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "0", "0", "NO.", "NO.", "RNUM"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "1", "4", "????????????", "???????????????", "TRADE_NO"));
		// name, key
		headerList.add(ExcelUtil.setHeaderList("???????????????", "CORP_REG_NO"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "CORP_NAME_KR"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "REPRE_NAME_KR"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "5", "10", "???????????????", "??????", "MAN_NAME"));
		headerList.add(ExcelUtil.setHeaderList("??????", "MAN_POS"));
		headerList.add(ExcelUtil.setHeaderList("??????", "MAN_DEPT"));
		headerList.add(ExcelUtil.setHeaderList("????????????(?????????)", "MAN_TELNO"));
		headerList.add(ExcelUtil.setHeaderList("??????????????????", "MAN_HPNO"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "MAN_EMAIL"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "11", "23", "?????? ?????????(???????????? ???????????? Y??????)", "??????????????????", "BIZ001_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("V-commerce ?????????????????? ??????", "BIZ002_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "BIZ003_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("????????? ???????????? ??????", "BIZ004_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("?????????????????? ?????? ??????", "BIZ005_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("????????????????????????(ABTC) ??????", "BIZ006_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("?????????????????? ????????? ??????", "BIZ101_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("??????????????? ?????? ??????", "BIZ102_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("????????? e?????????????????? ??????", "BIZ103_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("???????????? ????????????", "BIZ104_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("?????????", "BIZ105_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("COEX ?????????", "BIZ106_REQ_YN"));
		headerList.add(ExcelUtil.setHeaderList("??????", "BIZ107_REQ_YN"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "24", "31", "?????????", "????????????", "VOUCHER_LEV_NM"));
		headerList.add(ExcelUtil.setHeaderList("???????????? ??????", "DUES_YEAR"));
		headerList.add(ExcelUtil.setHeaderList("KITA????????? ?????? ??????", "KITA_CARD_CD"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "SUM_SUPP_AMT"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "ALREADY_ACC_AMT"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "BALANCE_AMT"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "REQ_AMT"));
		headerList.add(ExcelUtil.setHeaderList("???????????????", "FIX_AMT"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "32", "34", "????????????", "?????????", "BANK_CD"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "ACCOUNT_NUM"));
		headerList.add(ExcelUtil.setHeaderList("????????????", "ACCOUNT_HOLDER"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "35", "35", "???????????????", "???????????????", "REG_DT"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "36", "36", "????????????", "????????????", "ACC_STATUS_CD_NM"));
		headerList.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "37", "37", "????????????", "????????????", "REG_DATE"));

		// ?????? ???????????? ??????
		// voucherAccMngService.selectVoucherAccListForExcel(vo);
		List<CommonHashMap<String, String>> contentList = sampleService.selectExcelForDoubleList(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mode", Constants.EXCEL_DOUBLE_HEADER_LIST);
		map.put("header", headerList);
		map.put("list", contentList);

		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());

		map.put("fileName", "?????????_??????_??????_??????_" + today);

		return new ModelAndView("commonPOIExcel", "infomationMap", map);
	}

	@RequestMapping(value = "/sample/board/multiList/excelDownload.do")
	public ModelAndView multiListExcelDownload(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		// ?????? ????????? ??????
		List<CommonHashMap<String, String>> headerList1 = new ArrayList<CommonHashMap<String, String>>();

		// headerType, startIdx, endIdx, group, name, key
		headerList1.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "0", "0", "??????", "??????", "VOUCHER_LEV_NM"));
		headerList1.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "1", "3", "????????????", "?????????", "REQ_CORP_CNT"));
		// name, key
		headerList1.add(ExcelUtil.setHeaderList("??????", "REQ_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("???????????????", "REQ_AMT"));
		headerList1.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "4", "6", "????????????", "?????????", "APRV_CORP_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("??????", "APRV_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("???????????????", "APRV_AMT"));
		headerList1.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "7", "9", "??????", "?????????", "PAY_CORP_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("??????", "PAY_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("?????????", "PAY_AMT"));

		// ?????? ???????????? ??????
		// HashMap<String, String> vo = ParamUtil.getParams(request);
		// voucherAccConditionService.selectVoucherAccCondition(vo);
		List<CommonHashMap<String, String>> contentList1 = sampleService.selectExcelForMultiList1(searchVO);

		CommonHashMap<String, String> etcInfo1 = new CommonHashMap<String, String>();
		etcInfo1.put("title", "?????????(??????) : ");

		// ????????? ??????
		// voucherUseConditionService.selectVoucherBudgetAmt(vo);
		String budgetAmt = "20000000000";

		if (StringUtil.isEmpty(budgetAmt)) {
			budgetAmt = "0";
		}

		etcInfo1.put("info", budgetAmt);

		// ?????? ????????? ??????
		List<CommonHashMap<String, String>> headerList2 = new ArrayList<CommonHashMap<String, String>>();

		// headerType, startIdx, endIdx, group, name, key
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_ROW_MERGE, "0", "0", "?????????", "?????????", "VOUCHER_NAME"));
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "1", "3", "??????", "?????????", "SILVER_CORP_CNT"));
		// name, key
		headerList2.add(ExcelUtil.setHeaderList("??????", "SILVER_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "SILVER_AMT"));
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "4", "6", "??????", "?????????", "GOLD_CORP_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "GOLD_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "GOLD_AMT"));
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "7", "9", "??????", "?????????", "ROYAL_CORP_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "ROYAL_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "ROYAL_AMT"));
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "10", "12", "?????????", "?????????", "JUMPUP_CORP_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "JUMPUP_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "JUMPUP_AMT"));
		headerList2.add(ExcelUtil.setHeader(Constants.EXCEL_GROUP_MERGE, "13", "15", "???", "?????????", "SUM_CORP_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "SUM_CNT"));
		headerList2.add(ExcelUtil.setHeaderList("??????", "SUM_AMT"));

		// voucherAccConditionService.selectVoucherAccConditionByService(vo);
		List<CommonHashMap<String, String>> contentList2 = sampleService.selectExcelForMultiList2(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("mode", Constants.EXCEL_DOUBLE_HEADER_MULTI_LIST);

		map.put("header1", headerList1);
		map.put("list1", contentList1);
		map.put("etcInfo1", etcInfo1);
		map.put("title1", "????????? ?????? / ?????? ??????");

		map.put("header2", headerList2);
		map.put("list2", contentList2);
		map.put("title2", "???????????? ?????? ??????");

		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());

		map.put("fileName", "?????????_??????_??????_" + today);

		return new ModelAndView("commonPOIExcel", "infomationMap", map);
	}

	@RequestMapping(value = "/sample/board/multiSheet/excelDownload.do")
	public ModelAndView doubleMultiSheetExcelDownload(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		List<CommonHashMap<String, String>> headerList1 = new ArrayList<CommonHashMap<String, String>>();
		List<CommonHashMap<String, String>> headerList2 = new ArrayList<CommonHashMap<String, String>>();

		// name, key
		headerList1.add(ExcelUtil.setHeaderList("?????????", "EXPERT_NM"));
		headerList1.add(ExcelUtil.setHeaderList("????????????", "TOT_CNT"));
		headerList1.add(ExcelUtil.setHeaderList("???????????????", "SURVEYTOTALCOUNT"));
		headerList1.add(ExcelUtil.setHeaderList("??????????????????", "MATCHPER"));
		headerList1.add(ExcelUtil.setHeaderList("????????? ?????????", "SURVEY02"));
		headerList1.add(ExcelUtil.setHeaderList("?????? ?????????", "SURVEY03"));
		headerList1.add(ExcelUtil.setHeaderList("?????? ?????????", "SURVEY04"));
		headerList1.add(ExcelUtil.setHeaderList("????????? ??????", "SURVEY05"));
		headerList1.add(ExcelUtil.setHeaderList("?????? ??????", "SURVEY06"));
		headerList1.add(ExcelUtil.setHeaderList("??????", "TOTALAVG"));

		headerList2.add(ExcelUtil.setHeaderList("?????????", "EXPERT_NM"));
		headerList2.add(ExcelUtil.setHeaderList("????????? ??????", "REG_DATE"));
		headerList2.add(ExcelUtil.setHeaderList("?????????", "COMPANY"));
		headerList2.add(ExcelUtil.setHeaderList("???????????????", "TRADE_NO"));
		headerList2.add(ExcelUtil.setHeaderList("???????????????", "COMPANY_NO"));
		headerList2.add(ExcelUtil.setHeaderList("????????????", "SECT_NM"));
		headerList2.add(ExcelUtil.setHeaderList("??????????????????", "MATCHCHANNEL"));
		headerList2.add(ExcelUtil.setHeaderList("????????? ?????????", "SURVEY02"));
		headerList2.add(ExcelUtil.setHeaderList("?????? ?????????", "SURVEY03"));
		headerList2.add(ExcelUtil.setHeaderList("?????? ?????????", "SURVEY04"));
		headerList2.add(ExcelUtil.setHeaderList("????????? ??????", "SURVEY05"));
		headerList2.add(ExcelUtil.setHeaderList("?????? ??????", "SURVEY06"));
		headerList2.add(ExcelUtil.setHeaderList("????????????", "DSCR"));

		// tradeSOSSceneService.sceneSuggestStatSurveyList(vo);
		List<CommonHashMap<String, String>> surveyList = sampleService.selectExcelForMultiSheet1(searchVO);

		// tradeSOSSceneService.sceneSuggestStatSurveyListDetail(vo);
		List<CommonHashMap<String, String>> surveyListDetail = sampleService.selectExcelForMultiSheet2(searchVO);

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("mode", Constants.EXCEL_MULTI_SHEET);

		map.put("header1", headerList1);
		map.put("header2", headerList2);
		map.put("list1", surveyList);
		map.put("list2", surveyListDetail);

		SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddhhmmss");
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());

		map.put("fileName", "?????????????????????_???????????????_" + today);

		return new ModelAndView("commonPOIExcel", "infomationMap", map);
	}

	@RequestMapping(value = "/test/system/level2-1.do")
	public ModelAndView systemLevel21(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("empty/sample/test/system/level21");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-1/sub1.do")
	public ModelAndView systemLevel21Sub1(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level21sub1");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-1/sub2.do")
	public ModelAndView systemLevel21Sub2(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level21sub2");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-1/sub3.do")
	public ModelAndView systemLevel21Sub3(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level21sub3");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-2.do")
	public ModelAndView systemLevel22(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("empty/sample/test/system/level22");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-2/sub1.do")
	public ModelAndView systemLevel22Sub1(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level22sub1");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-2/sub2.do")
	public ModelAndView systemLevel22Sub2(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level22sub2");

		return mav;
	}

	@RequestMapping(value = "/test/system/level2-3.do")
	public ModelAndView systemLevel23(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/system/level23");

		return mav;
	}

	@RequestMapping(value = "/test/system/level1-2.do")
	public ModelAndView systemLevel12(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("empty/sample/test/system/level12");

		return mav;
	}

	@RequestMapping(value = "/test/voucher/level2-1.do")
	public ModelAndView voucherLevel21(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/voucher/level21");

		return mav;
	}

	@RequestMapping(value = "/test/voucher/level2-2.do")
	public ModelAndView voucherLevel22(HttpServletRequest request, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/test/voucher/level22");

		return mav;
	}

	@RequestMapping(value = "/ocr/paramtest.do", method = RequestMethod.POST)
	public void ocrparamtest(@RequestBody Map<String, Object> param) {
		System.out.println("param = " + param.toString());
	}

	@RequestMapping(value = "/ocr/apitest.do", method = RequestMethod.GET)
	public void apitest() {
		try {
			HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
			factory.setConnectTimeout(10000);
			factory.setReadTimeout(3000);

			HttpClient httpClient = HttpClientBuilder.create()
					.setMaxConnTotal(100)
					.setMaxConnPerRoute(5)
					.build();
			factory.setHttpClient(httpClient);

			RestTemplate restTemplate = new RestTemplate(factory);

			HttpHeaders headers = new HttpHeaders();
			Charset utf8 = Charset.forName("UTF-8");
			MediaType mediaType = new MediaType("application", "json", utf8);

			headers.setContentType(mediaType);
			headers.set("X-OCR-SECRET", "Sm5YVlFOcnVSZXlhQlFuSVdYY0R1elNNSEtUdlVRQk4=");
			headers.set("HOST", "yerilqze1i.apigw.ntruss.com");

			OcrRequestVO ocrVO = new OcrRequestVO();

			ocrVO.setVersion("V2");
			ocrVO.setRequestId(UUID.randomUUID().toString().replaceAll("-", ""));
			ocrVO.setTimestamp(System.currentTimeMillis());

			List<ImageVO> images = new ArrayList<ImageVO>();

			String longValue = "";

			String filePath = "";

			String profile = System.getProperty("spring.profiles.active");

			if ("local".equals(profile)) {
				filePath = "C:\\Project\\workspace\\KITA_FRAMEWORK\\src\\main\\resources\\egovframework\\properties\\config.properties";
			} else if ("dev".equals(profile)) {
				filePath = "/SERV/BEA92/app_root/maApp/WEB-INF/classes/egovframework/properties/config.properties";
			}

			try (InputStream input = new FileInputStream(filePath)) {
				Properties prop = new Properties();
				prop.load(input);
				longValue = prop.getProperty("stringtoolong");
			}

			ImageVO image = new ImageVO();
			image.setFormat("jpg");
			image.setName("KakaoTalk_20221123_151352718");
			image.setData(longValue);

			images.add(image);

			ocrVO.setImages(images);

			ObjectMapper mapper = new ObjectMapper();
			String json = mapper.writeValueAsString(ocrVO);

			HttpEntity requestEntity = new HttpEntity(json, headers);

			ResponseEntity<HashMap> resultEntity = restTemplate.exchange("https://yerilqze1i.apigw.ntruss.com/custom/v1/18997/d9b65705809548b270615fcfb3e14ebd74e3c5f2fa1e470eaa311c33e1501dec/document/name-card", HttpMethod.POST, requestEntity, HashMap.class);

			if (resultEntity.getStatusCode() == HttpStatus.OK) {
				System.out.println("Success!!!");

				System.out.println(resultEntity.getHeaders().toString());
				HashMap<String, Object> responseBody = (HashMap<String, Object>)resultEntity.getBody();
				System.out.println(responseBody.toString());
			}  else {
				System.out.println("Fail!!!");
			}
		} catch(HttpClientErrorException e) {
			e.printStackTrace();
			System.out.println("111 = " + e.getResponseHeaders().toString());
		} catch(HttpServerErrorException e) {
			e.printStackTrace();
			System.out.println("222 = " + e.getResponseHeaders().toString());
		}  catch (Exception e) {
			e.printStackTrace();
			System.out.println("333");
		}
	}

	/**
	 * ?????? ?????????
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/multiconnection/list.do")
	public ModelAndView multiconnection(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("sample/multiconnection/list");

		return mav;
	}

	/**
	 * ?????? ?????????(KMEMBER ??????)
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/multiconnection/selectKmemberList.do")
	public ModelAndView selectKmemberList(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<CommonHashMap<String, Object>> resultList = sampleService.selectKmemberList(searchVO);

		mav.addObject("data", resultList);

		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * ?????? ?????????(TRADE ??????)
	 *
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/multiconnection/selectTradeList.do")
	public ModelAndView selectTradeList(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView();

		List<CommonHashMap<String, Object>> resultList = sampleService.selectTradeList(searchVO);

		mav.addObject("data", resultList);

		mav.setViewName("jsonView");

		return mav;
	}

	/**
	 * SMTP ?????? ??????
	 * @param request
	 * @param searchVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/sample/board/sampleMailSend.do")
	public ModelAndView sampleMailSend(HttpServletRequest request, @ModelAttribute("searchVO")SampleVO searchVO, ModelMap model) throws Exception {
		ModelAndView mav = new ModelAndView("jsonView");

		String subject = "test??????";
		String content = "?????? ???????????????";
		String from = "destiny891116@naver.com";
		String to = "yongsei@sdcit.co.kr";

		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail, true, "UTF-8");

		    // true??? ???????????? ???????????? ?????????????????? ??????

            /*
             * ????????? ????????? ???????????? ???????????? ????????? ????????? ?????? ??????
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
			// true??? html??? ?????????????????? ???????????????.

			 /*
             * ????????? ???????????? ?????????????????? ????????? ????????? ??????????????? ?????????. mailHelper.setText(content);
             */

			mailSender.send(mail);

		} catch (Exception e) {
			e.printStackTrace();
		}


		return mav;
	}

}