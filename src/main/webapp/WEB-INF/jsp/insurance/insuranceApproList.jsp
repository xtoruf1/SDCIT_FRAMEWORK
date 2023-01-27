<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:url value="/insurance/insuranceApproList.do" var="returnUrl" />

<div class="location compact">
	<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />

	<div class="ml-auto">
		<button type="button" id="btnAprv" class="btn_sm btn_primary btn_modify_auth" onclick="callApplyPop();">승인</button>
		<button type="button" id="btnAprvCancel" class="btn_sm btn_secondary btn_modify_auth" onclick="chgStatus('10');">승인취소</button>
		<button type="button" id="btnReturnAmt" class="btn_sm btn_secondary btn_modify_auth" onclick="callReturnRsnPop();">환불</button>
		<button type="button" id="btnReturn" class="btn_sm btn_secondary btn_modify_auth" onclick="callReturnHoldPop();">가입보류</button>
	</div>

	<div class="ml-15">
		<button type="button" id="btnExcel" class="btn_sm btn_primary" onclick="doExcelDownload();">엑셀 다운</button>
		<button type="button" id="btnSearchReset" class="btn_sm btn_secondary" onclick="doClear();">초기화</button>
		<button type="button" id="btnSearch" class="btn_sm btn_primary" onclick="doSearch();">검색</button>
	</div>
</div>


<form id="searchForm" method="post">
<div class="cont_block">
	<div class="foldingTable fold">
		<div class="foldingTable_inner">
		<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value="${ searchParam.pageIndex }" />"/>
		<input type="hidden" id="insId" name="insId" value=""/>
		<input type="hidden" id="tradeNo" name="tradeNo" value=""/>
		<input type="hidden" id="preUrl" name="preUrl" value="<c:out value="${returnUrl}" />" />
		<input type="hidden" id="firstYear" value="${first}"/>
			<table class="formTable">
				<colgroup>
					<col style="width:15%;" />
					<col/>
					<col style="width:15%;" />
					<col/>
					<col style="width:15%;" />
					<col/>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">대상년도</th>
						<td>
							<select name="searchBaseYear" id="searchBaseYear" class="form_select w100p">
								<option value="ALL" <c:if test="${ searchParam.searchBaseYear eq 'ALL'}">selected</c:if> >전체</option>
								<c:forEach items="${yearList}" var="vo" varStatus="status">
									<option value="<c:out value="${ vo.baseYear}" />" label="<c:out value="${ vo.baseYear}" />" <c:out value="${ searchParam.searchBaseYear eq vo.baseYear ? 'selected' : '' }" /> />
								</c:forEach>
							</select>
						</td>
						<th scope="row">보험종류</th>
						<td>
							<select name="searchInsCode" id="searchInsCode" class="form_select w100p">
								<option value="" label="전체" />
								<c:forEach items="${INS001}" var="vo" varStatus="status">
									<option value="<c:out value="${ vo.code}" />" label="<c:out value="${ vo.codeNm}" />" <c:out value="${ searchParam.searchInsCode eq vo.code ? 'selected' : '' }" /> />
								</c:forEach>
							</select>
						</td>
						<th scope="row">회원등급</th>
						<td>
							<select name="searchMemberLev" id="searchMemberLev" class="form_select w100p">
								<option value="" label="전체" />
								<option value="silver" label="실버" <c:out value="${ param.searchMemberLev eq 'silver' ? 'selected' : '' }" /> />
								<option value="gold" label="골드" <c:out value="${ param.searchMemberLev eq 'gold' ? 'selected' : '' }" /> />
								<option value="royal" label="로얄" <c:out value="${ param.searchMemberLev eq 'royal' ? 'selected' : '' }" /> />
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">업체명</th>
						<td class="bRight">
							<input type="text" class="form_text w100p" name="searchCorpName" id="searchCorpName"  onkeydown="onEnter(doSearch);" value="<c:out value="${ searchParam.searchCorpName }" />" />
						</td>
						<th scope="row">사업자번호</th>
						<td>
							<input type="text" class="form_text w100p" name="searchCorpRegNo" id="searchCorpRegNo" onkeydown="onEnter(doSearch);" value="<c:out value="${ searchParam.searchCorpRegNo }" />"  />
						</td>
						<th scope="row">무역업번호</th>
						<td>
							<input type="text" class="form_text w100p" name="searchTradeNo" id="searchTradeNo" onkeydown="onEnter(doSearch);" value="<c:out value="${ searchParam.searchTradeNo }" />"  />
						</td>
					</tr>
					<tr>
						<th scope="row">상태</th>
						<td colspan="5">
							<label for="searchAll" class="label_form">
								<input type="checkbox" id="searchAll" name="searchAll" class="form_checkbox" value="ALL" onclick="statusCheckAll();" <c:if test="${searchParam.searchAll == 'ALL'}">checked</c:if> />
								<span class="label">전체</span>
							</label>
							<c:forEach items="${INS002}" var="vo" varStatus="status">
							<label for="searchStatusCd_<c:out value="${vo.code}"/>" class="label_form">
								<c:set var="checked"></c:set>
								<c:forEach items="${searchParam.searchStatusCd}" var="statusCd">
									<c:if test="${ statusCd == vo.code }">
										<c:set var="checked">checked</c:set>
									</c:if>
								</c:forEach>
								<c:if test="${ searchParam.searchAll == 'ALL' }">
									<c:set var="checked">checked</c:set>
								</c:if>
								<input type="checkbox" class="form_checkbox" id="searchStatusCd_<c:out value="${vo.code}"/>" name="searchStatusCd" value="<c:out value="${vo.code}"/>" <c:out value="${checked}"/> onclick="statusCheck();"/>
								<span class="label"><c:out value="${vo.codeNm}"/></span>
							</label>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">기간검색</th>
						<td colspan="5">
							<fieldset class="form_group">
								<select name="searchDateType" id="searchDateType" class="form_select group_item">
									<option value="REQ_DATE" label="신청일자" <c:out value="${ searchParam.searchDateType eq 'REQ_DATE' ? 'selected' : '' }" /> />
									<option value="RETURN_DATE" label="환불일자" <c:out value="${ searchParam.searchDateType eq 'RETURN_DATE' ? 'selected' : '' }" /> />
									<option value="APPLY_DATE" label="승인일자" <c:out value="${ searchParam.searchDateType eq 'APPLY_DATE' ? 'selected' : '' }" /> />
									<option value="LAST_INS_END_DATE" label="이전보험만료일자" <c:out value="${ searchParam.searchDateType eq 'LAST_INS_END_DATE' ? 'selected' : '' }" /> />
								</select>

								<div class="group_datepicker group_item">
									<div class="datepicker_box">
										<span class="form_datepicker">
											<input type="text" id="searchStartDate" name="searchStartDate" value="${searchParam.searchStartDate}" class="txt datepicker" title="시작일" readonly="readonly" />
											<img src="<c:url value='/images/icon_calender.png' />" class="ui-datepicker-trigger" alt="캘린더" title="캘린더" />
										</span>

										<button type="button" class="dateClear" onclick="clearPickerValue('searchStartDate')"><img src="<c:url value='/images/admin/btn_clear.png' />" alt="초기화" /></button>
									</div>
									<div class="spacing">~</div>
									<div class="datepicker_box">
										<span class="form_datepicker">
											<input type="text" id="searchEndDate" name="searchEndDate" value="${searchParam.searchEndDate}" class="txt datepicker" title="종료일" readonly="readonly" />
											<img src="<c:url value='/images/icon_calender.png' />" class="ui-datepicker-trigger" alt="캘린더" title="캘린더" />
										</span>

										<button type="button" class="dateClear" onclick="clearPickerValue('searchEndDate')"><img src="<c:url value='/images/admin/btn_clear.png' />" alt="초기화" /></button>
									</div>
								</div>
							</fieldset>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<button type="button" class="btn_folding" title="테이블접기"></button>
	</div>
</div>

<div class="cont_block">
	<div class="tbl_opt">
		<div id="totalCnt" class="total_count"></div>

		<select id="pageUnit" name="pageUnit" title="목록수" class="form_select ml-auto" onchange="chgPageCnt();">
			<c:forEach var="item" items="${pageUnitList}" varStatus="status">
				<option value="${item.code}" <c:if test="${searchParam.pageUnit eq item.code}">selected="selected"</c:if>>${item.codeNm}</option>
			</c:forEach>
		</select>
	</div>

	<div>
		<div id="companyListSheet" class="sheet"></div>
	</div>
	<div id="paging" class="paging ibs"></div>
</div>
</form>


<script type="text/javascript">
	$(document).ready(function(){
		setSheetHeader_companyList();				// 사업 리스트 헤더
		getCompanyList();							// 사업 리스트 조회

		// 시작일 선택 이벤트
		datepickerById('searchStartDate', fromDateSelectEvent);

		// 종료일 선택 이벤트
		datepickerById('searchEndDate', toDateSelectEvent);
	});

	function fromDateSelectEvent() {
		var startymd = Date.parse($('#searchStartDate').val());

		if ($('#searchEndDate').val() != '') {
			if (startymd > Date.parse($('#searchEndDate').val())) {
				alert('시작일은 종료일 이전이어야 합니다.');
				$('#searchStartDate').val('');

				return;
			}
		}
	}

	function toDateSelectEvent() {
		var endymd = Date.parse($('#searchEndDate').val());

		if ($('#searchStartDate').val() != '') {
			if (endymd < Date.parse($('#searchStartDate').val())) {
				alert('종료일은 시작일 이후여야 합니다.');
				$('#searchEndDate').val('');

				return;
			}
		}
	}

	function setSheetHeader_companyList() {	// 사업 리스트 헤더

		var	ibHeader = new IBHeader();
		ibHeader.addHeader({Header: '상태'			, Type: 'Status'		, SaveName: 'status'			, Hidden: true});
		ibHeader.addHeader({Header: '보험ID'			, Type: 'Text'			, SaveName: 'insId'				, Hidden: true , Width: 15});
		ibHeader.addHeader({Header: '무역고유번호'		, Type: 'Text'			, SaveName: 'tradeNo'			, Hidden: true , Width: 25});
		ibHeader.addHeader({Header: '보험상태코드'		, Type: 'Text'			, SaveName: 'statusCd'			, Hidden: true , Width: 15});
		ibHeader.addHeader({Header: '선택'			, Type: 'CheckBox'		, SaveName: 'check'				, Width: 20		, HeaderCheck: 0});
		ibHeader.addHeader({Header: 'No'			, Type: 'Text'			, SaveName: 'no'				, Edit: false	, Width: 20		, Align: 'Center'});
		ibHeader.addHeader({Header: '업체명'			, Type: 'Text'			, SaveName: 'corpNameKr'		, Edit: false	, Width: 80		, Align: 'Left'	, Cursor: 'Pointer'});
		ibHeader.addHeader({Header: '사업자번호'		, Type: 'Text'			, SaveName: 'corpRegNo'			, Edit: false	, Width: 30		, Align: 'Center'	, Cursor: 'Pointer'});
		ibHeader.addHeader({Header: '담당자'			, Type: 'Text'			, SaveName: 'manName'			, Edit: false	, Width: 30		, Align: 'Center'});
		ibHeader.addHeader({Header: '등급'			, Type: 'Text'			, SaveName: 'memberLev'			, Edit: false	, Width: 20		, Align: 'Center'});
		ibHeader.addHeader({Header: '연차'			, Type: 'Text'			, SaveName: 'duesYear'			, Edit: false	, Width: 20		, Align: 'Center'});
		ibHeader.addHeader({Header: '보험종류'			, Type: 'Text'			, SaveName: 'insName'			, Edit: false	, Width: 50		, Align: 'Center'});
		ibHeader.addHeader({Header: '업체부담금'		, Type: 'Int'			, SaveName: 'selfCost'			, Edit: false	, Width: 25		, Align: 'Right'	, Format: 'Integer'});
		ibHeader.addHeader({Header: '신청일'			, Type: 'Text'			, SaveName: 'reqDate'			, Edit: false	, Width: 25		, Align: 'Center'});
		ibHeader.addHeader({Header: '상태'			, Type: 'Text'			, SaveName: 'statusNm'			, Edit: false	, Width: 20		, Align: 'Center'});
		ibHeader.addHeader({Header: '업체부담금납부일'	, Type: 'Text'			, SaveName: 'payDate'			, Hidden: true});
		ibHeader.addHeader({Header: '영수증발급여부'		, Type: 'Text'			, SaveName: 'viewYn'			, Hidden: true});
		ibHeader.addHeader({Header: '환불일자'			, Type: 'Text'			, SaveName: 'returnDate'		, Hidden: true});
		ibHeader.addHeader({Header: '보류사유'			, Type: 'Text'			, SaveName: 'returnRsn'			, Hidden: true});

		ibHeader.setConfig({AutoFitColWidth: "search|resize|init|colhidden|rowtransaction|colresize",
            DeferredVScroll: 0,
            colresize: true,
            SelectionRowsMode: 1,
            SearchMode: 4,
            NoFocusMode : 0,
            Alternate : 0,
            Page: 10,
            SizeMode: 1});
		ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

		var container = $('#companyListSheet')[0];
		createIBSheet2(container, 'companyListSheet', '100%', '10%');
		ibHeader.initSheet('companyListSheet');

		companyListSheet.SetEllipsis(1); 		// 말줄임 표시여부
		companyListSheet.SetSelectionMode(4);

	}

	function doSearch() {	// 조회
		$('#pageIndex').val(1);
		getCompanyList();
	}

	function goPage(pageIndex) {	// 페이징 함수
		$('#pageIndex').val(pageIndex);
		getCompanyList();
	}

	function chgPageCnt() {	// 페이징 변경
		doSearch();
	}

	function companyListSheet_OnSearchEnd() {
		// 제목에 볼드 처리
		companyListSheet.SetColFontBold('corpNameKr', 1);
		companyListSheet.SetColFontBold('corpRegNo', 1);
	}

	function companyListSheet_OnRowSearchEnd(row) {	// 가입완료 항목은 선택할 수 없음

		var nowChkStatusCd = companyListSheet.GetCellValue(row, 'statusCd');

		if(nowChkStatusCd == '90'){
			companyListSheet.SetCellEditable(row,"check", false);
		}
	}

	function companyListSheet_OnChange(Row, col, value, oldValue, raiseFlag) {	// 체크박스 선택시

		var statusCd = companyListSheet.GetCellValue(Row, 'statusCd');

		var checkedCnt = companyListSheet.CheckedRows("check");      //체크 건수를 갖고 와서
		if(checkedCnt <= 1){ //체크된 건수가 1이나 0인경우

			var nowStatusCd = companyListSheet.GetCellValue(Row, 'statusCd');

			var size = companyListSheet.RowCount();
			var firstIdx = companyListSheet.GetDataFirstRow();
			if(size > 0){
				for(var i = firstIdx; i <= size; i++){

				var rowStatusCd = companyListSheet.GetCellValue(i, 'statusCd');

					if(checkedCnt == 0 && rowStatusCd != '90'){
						btnControl('');
						companyListSheet.SetCellEditable(i, "check", true);
					} else {
						if(rowStatusCd != nowStatusCd){
							companyListSheet.SetCellEditable(i,"check", false);
						} else {
							companyListSheet.SetCellEditable(i,"check", true);
						}
						btnControl(statusCd);
					}
				}
			}
		}
	}

	function companyListSheet_OnClick(Row, Col, Value, CellX, CellY, CellW, CellH, rowType) {	// 시트 내용 클릭시

		if(rowType == 'HeaderRow'){
			return;
		}

		var insId = companyListSheet.GetCellValue(Row, 'insId');
		var tradeNo = companyListSheet.GetCellValue(Row, 'tradeNo');
		var statusCd = companyListSheet.GetCellValue(Row, 'statusCd');

		if(companyListSheet.ColSaveName(Col) == 'check'){
			return;
		}

		if(companyListSheet.ColSaveName(Col) == 'corpNameKr' || companyListSheet.ColSaveName(Col) == 'corpRegNo'){
			goDetail(insId, tradeNo);
		}
	}

	function goDetail(insId, tradeNo){	//상세

		$('#tradeNo').val(tradeNo);
		$('#insId').val(insId);
		$('#searchForm').attr('action', '/insurance/insuranceApproDetail.do');
		$('#searchForm').submit();
	}

	function getCompanyList() {	// 회사 조회

		if($('#first').val() != '' ) {

			var ff = $('#searchBaseYear option').length;

			var nowYear = global.formatToday('yyyy');
			$('#searchBaseYear option').each(function(i) {
				if(this.text == nowYear) {
					this.attr('selected',true);
				}
			})
		}

		$('#first').val('');

		var searchParam = $('#searchForm').serializeObject();

		searchParam.searchStatusCd = null;
		var searchStatusCdArr = [];

		$("input[name='searchStatusCd']:checked").each(function(e){
			searchStatusCdArr.push($(this).val());
		})

		if(searchStatusCdArr.length > 0){
			searchParam.searchStatusCd = searchStatusCdArr;
		}

		global.ajax({
			type : 'POST'
			, url : "/insurance/selectInsuranceApproList.do"
			, contentType : 'application/json'
			, data : JSON.stringify(searchParam)
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				setPaging(	// 페이징
						'paging'
						, goPage
						, data.paginationInfo.currentPageNo
						, data.paginationInfo.totalRecordCount
						, data.paginationInfo.recordCountPerPage
						, data.paginationInfo.pageSize
					);

				$('#totalCnt').html('총 <span>' + global.formatCurrency(data.resultCnt) + '</span> 건');

				companyListSheet.LoadSearchData({Data: (data.resultList || []) });
			}
		});
	}

	function statusCheckAll(){	// 상태갑 전체 체크시
		if( $('#searchAll').prop("checked") ){
			$('input[name=searchStatusCd]').prop("checked",true);
		}else {
			$('input[name=searchStatusCd]').prop("checked",false);
		}
	}

	function statusCheck(){	// 상태값 체크시

		var allCnt = $("input[name=searchStatusCd]").length;
		var checkCnt = $("input[name=searchStatusCd]:checked").length;
		if( allCnt == checkCnt ){
			$('#searchAll').prop("checked",true);
		}else {
			$('#searchAll').prop("checked",false);

		}
	}

	function callApplyPop(){	// 승인팝업

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		if(chkRow == '') {
			alert('선택한 항목이 없습니다.');
			return false;
		}

		var selfCostCnt = 0;

		for(var i = 0; i < chkRow.length; i++) {
			var selfCost = companyListSheet.GetCellValue(chkRow[i], 'selfCost');
			if(selfCost > 0) {
				selfCostCnt++;
			}
		}

		if(selfCostCnt > 0) {

			global.openLayerPopup({
				// 레이어 팝업 URL
				popupUrl : '/insurance/popup/insuranceApproPop.do'
				, callbackFunction : function(resultObj){
					if(resultObj == '') {
						alert('문제가 발생했습니다.');
					} else {

						var payDate = resultObj[0];
						var receYn = resultObj[1];

						doApply(payDate, receYn);
					}
				}
			});

		} else {
			if(!confirm("승인 하시겠습니까?")){
				return;
			}
			doApply('', '');
		}
	}

	function doApply(payDate, receipt_view_yn){	// 승인처리

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		for(var i = 0; i < chkRow.length; i++) {

			companyListSheet.SetCellValue(chkRow[i], 'statusCd', '20', 0);

			if(companyListSheet.GetCellValue(chkRow[i], 'selfCost') > 0) {
				companyListSheet.SetCellValue(chkRow[i], 'payDate', payDate, 0);
				companyListSheet.SetCellValue(chkRow[i], 'viewYn', receipt_view_yn, 0);

			}
		}

		var saveData = companyListSheet.GetSaveJson();

		global.ajax({
			type : 'POST'
			, url : "/insurance/insuranceStatusChg.do"
			, contentType : 'application/json'
			, data : JSON.stringify(saveData.data)
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				getCompanyList();
				btnControl('');
			}
		});

	}

	function callReturnRsnPop() {	// 환불 팝업

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		if(chkRow == '') {
			alert('선택한 항목이 없습니다.');
			return false;
		}

		for(var i = 0; i < chkRow.length; i++) {

			var nowSelfCost = companyListSheet.GetCellValue(chkRow[i],'selfCost');

			if(nowSelfCost <= 0) {
				alert('업체부담금이 없는 신청건은 자동으로 선택 제외 됩니다.');
				companyListSheet.SetCellValue(chkRow[i], 'check', 0, 0);

			}
		}

		var afterChkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		if(afterChkRow != '') {

			global.openLayerPopup({
			// 레이어 팝업 URL
			popupUrl : '/insurance/popup/insuranceReturnRsnPop.do'
			, callbackFunction : function(resultObj){
				if(resultObj == '') {
					alert('문제가 발생했습니다.');
				} else {

					doReturnAmt(resultObj);
				}
			}
		});

		} else {
			alert('선택된 항목이 없습니다.');
			return;
		}


	}

	function doReturnAmt(returnDate) {	// 환불작업

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		for(var i = 0; i < chkRow.length; i++) {

			companyListSheet.SetCellValue(chkRow[i], 'returnDate', returnDate, 0);
			companyListSheet.SetCellValue(chkRow[i], 'statusCd', '01', 0);
		}

		var saveData = companyListSheet.GetSaveJson();

		global.ajax({
			type : 'POST'
			, url : "/insurance/insuranceStatusChg.do"
			, contentType : 'application/json'
			, data : JSON.stringify(saveData.data)
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				getCompanyList();
				btnControl('');
			}
		});
	}

	function callReturnHoldPop(){	//  가입보류 팝업

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		if(chkRow == '') {
			alert('선택한 항목이 없습니다.');
			return false;
		}

		for(var i = 0; i < chkRow.length; i++) {

			var nowSelfCost = companyListSheet.GetCellValue(chkRow[i],'selfCost');

			if(nowSelfCost <= 0) {
				alert('업체부담금이 없는 신청건은 자동으로 선택 제외 됩니다.');
				companyListSheet.SetCellValue(chkRow[i], 'check', 0, 0);

			}
		}

		var afterChkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		if(afterChkRow != '') {

			global.openLayerPopup({
				// 레이어 팝업 URL
				popupUrl : '/insurance/popup/insuranceReturnHoldPop.do'
				, callbackFunction : function(resultObj){
					if(resultObj == '') {
						alert('문제가 발생했습니다.');
					} else {

						doReturnHold(resultObj);
					}
				}
			});
		} else {
			alert('선택한 항목이 없습니다.');
			return false;
		}
	}

	function doReturnHold(returnRsn) {	// 환불작업

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		for(var i = 0; i < chkRow.length; i++) {

			companyListSheet.SetCellValue(chkRow[i], 'returnRsn', returnRsn, 0);
			companyListSheet.SetCellValue(chkRow[i], 'statusCd', '00', 0);
		}

		var saveData = companyListSheet.GetSaveJson();

		global.ajax({
			type : 'POST'
			, url : "/insurance/insuranceStatusChg.do"
			, contentType : 'application/json'
			, data : JSON.stringify(saveData.data)
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				getCompanyList();
				btnControl('');
			}
		});
	}

	function btnControl(statusCd){	// 버튼컨트롤

		switch (statusCd) {

		case "00":
			$("#btnAprv").show();
			$("#btnAprvCancel").hide();
			$("#btnReturnAmt").hide();
			$("#btnReturn").hide();
			break;

		case "01":
			$("#btnAprv").hide();
			$("#btnAprvCancel").hide();
			$("#btnReturnAmt").hide();
			$("#btnReturn").hide();
			break;

		case "10":
			$("#btnAprv").show();
			$("#btnAprvCancel").hide();
			$("#btnReturnAmt").show();
			$("#btnReturn").show();
			break;

		case "20":
			$("#btnAprv").hide();
			$("#btnAprvCancel").show();
			$("#btnReturnAmt").show();
			$("#btnReturn").hide();
			break;


		case "30":
			$("#btnAprv").hide();
			$("#btnAprvCancel").hide();
			$("#btnReturnAmt").show();
			$("#btnReturn").hide();
			break;

		case "40":
			$("#btnAprv").show();
			$("#btnAprvCancel").hide();
			$("#btnReturnAmt").show();
			$("#btnReturn").hide();
			break;

		default :
			$("#btnAprv").show();
			$("#btnAprvCancel").show();
			$("#btnReturnAmt").show();
			$("#btnReturn").show();
			break;

		}

	}

	function chgStatus(statusCd){	//	승인취소

		var statusNm = "";

		var chkRow = companyListSheet.FindCheckedRow('check');

		if(chkRow == '') {
			alert('선택한 항목이 없습니다.');
			return;
		}

		if(!confirm("승인취소 하시겠습니까?")){
			return false;
		}

		var chkRow = companyListSheet.FindCheckedRow('check', {ReturnArray:1});

		for(var i = 0; i < chkRow.length; i++) {

			companyListSheet.SetCellValue(chkRow[i], 'viewYn', 'Y', 0);
			companyListSheet.SetCellValue(chkRow[i], 'statusCd', statusCd, 0);
		}

		var saveData = companyListSheet.GetSaveJson();

		global.ajax({
			type : 'POST'
			, url : "/insurance/insuranceStatusChg.do"
			, contentType : 'application/json'
			, data : JSON.stringify(saveData.data)
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				getCompanyList();
				btnControl('');
			}
		});
	}

	function doExcelDownload() {	//엑셀다운로드
		$('#searchForm').attr('action','/insurance/insuranceApproListExcelDown.do');
		$('#searchForm').submit();
	}

	function doClear() {	// 초기화
		location.reload();
	}


</script>