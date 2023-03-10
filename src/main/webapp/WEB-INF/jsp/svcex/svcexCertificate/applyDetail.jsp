<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<spring:eval var="serverName" expression="@variables.getProperty('variables.serverName')" />

<form id="viewForm" name="viewForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
	<input type="hidden" name="event" />
	<input type="hidden" name="bsNo" value="<c:out value="${resultView.bsNo }"/>"/>
	<input type="hidden" name="memberId" value="<c:out value="${resultView.bsNo }"/>"/>
	<input type="hidden" name="transportServiceCd" value="<c:out value="${resultView.transportServiceCd }"/>"/>
	<input type="hidden" name="resultChk" value="<c:out value="${resultView.resultChk }"/>"/>
	<input type="hidden" name="expImpCd" value="<c:out value="${resultView.expImpCd }"/>"/>
	<input type="hidden" name="stateCd" value="<c:out value="${resultView.stateCd }"/>"/>
	<input type="hidden" name="reqno" value="<c:out value="${resultView.reqno }"/>"/>
	<input type="hidden" name="returnReason" value=""/>
	<input type="hidden" name="coHp" value="<c:out value="${resultView.coHp1}"/>-<c:out value="${resultView.coHp2}"/>-<c:out value="${resultView.coHp3}"/>"/>
	<input type="hidden" name="coEmail" value="<c:out value="${resultView.coEmail1}"/>@<c:out value="${resultView.coEmail3}"/>"/>
	<input type="hidden" name="coUserNm" value="<c:out value="${resultView.wrkMembNm }"/>"/>
	<input type="hidden" name="creBy" value="<c:out value="${resultView.coEmail1 }"/>"/>

	<input type="hidden" name="searchCompanyKor" value="<c:out value="${svcexVO.searchCompanyKor }"/>"/>
	<input type="hidden" name="searchEnterRegNo" value="<c:out value="${svcexVO.searchEnterRegNo }"/>"/>
	<input type="hidden" name="searchBsNo" value="<c:out value="${svcexVO.searchBsNo }"/>"/>
	<input type="hidden" name="searchReqno" value="<c:out value="${svcexVO.searchReqno }"/>"/>
	<input type="hidden" name="issueStartDt" value="<c:out value="${svcexVO.issueStartDt }"/>"/>
	<input type="hidden" name="issueEndDt" value="<c:out value="${svcexVO.issueEndDt }"/>"/>
	<input type="hidden" name="searchIssueCd" value="<c:out value="${svcexVO.searchIssueCd }"/>"/>
	<input type="hidden" name="searchExpImpCd" value="<c:out value="${svcexVO.searchExpImpCd }"/>"/>
	<input type="hidden" name="searchStateCd" value="<c:out value="${svcexVO.searchStateCd }"/>"/>
	<input type="hidden" name="searchOrgCd" value="<c:out value="${svcexVO.searchOrgCd }"/>"/>
	<input type="hidden" name="returnNo" value="<c:out value="${resultView.returnNo }"/>"/>
	<input type="hidden" name="amountSdate" value="<c:out value="${resultView.amountSdate }"/>"/>
	<input type="hidden" name="amountEdate" value="<c:out value="${resultView.amountEdate }"/>"/>
	<input type="hidden" name="issueNo" value="<c:out value="${resultView.issueNo }"/>"/>
	<input type="hidden" name="oriData" value="<c:out value="${sOriData }"/>"/>

	<input type="hidden" name="reqStartDt" value="<c:out value="${svcexVO.reqStartDt }"/>"/>
	<input type="hidden" name="reqEndDt" value="<c:out value="${svcexVO.reqEndDt }"/>"/>
	<input type="hidden" name="creStartDt" value="<c:out value="${svcexVO.creStartDt }"/>"/>
	<input type="hidden" name="creEndDt" value="<c:out value="${svcexVO.creEndDt }"/>"/>
	<input type="hidden" name="startDt" value="<c:out value="${svcexVO.startDt }"/>"/>
	<input type="hidden" name="endDt" value="<c:out value="${svcexVO.endDt }"/>"/>
	<input type="hidden" name="searchDateGubun" value="<c:out value="${svcexVO.searchDateGubun }"/>"/>

	<input type="hidden" name="listPagePre" id="listPagePre" value="<c:out value="${svcexVO.listPage }"/>"/>
	<input type="hidden" name="pageIndex"	id="pageIndex"	value="<c:out value='${param.pageIndex}' default='1' />" />
	<input type="hidden" name="pageIndex1"	id="pageIndex1"	value="<c:out value='${param.pageIndex1}' default='1' />" />
	<input type="hidden" name="sumCheckAmount"	id="sumCheckAmount"		value="" />
	<input type="hidden" name="sumCheckAmount1"	id="sumCheckAmount1"	value="" />

	<!-- ????????? ?????? -->
	<div class="location">
		<!-- ??????????????? -->
		<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
		<!-- ??????????????? -->
	</div>

	<div class="cont_block">
		<div class="tit_bar">

			<h3 class="tit_block">???????????? ??????</h3>

			<div class="ml-auto">
				<c:if test="${(resultView.stateCd eq 'B' || resultView.stateCd eq 'C') && viewYn}">
					<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doApprove();">??????</button>
					<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doUpdate();">??????</button>
					<button type="button" class="btn_sm btn_secondary btn_modify_auth" onclick="doReturn();">??????</button>
					<button type="button" class="btn_sm btn_secondary btn_modify_auth" onclick="doDel();">??????</button>
				</c:if>
				<c:if test="${(svcexVO.manCreYn eq 'Y' && resultView.stateCd eq 'A') && viewYn}">
					<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doUpdate();">??????</button>
					<button type="button" class="btn_sm btn_secondary btn_modify_auth" onclick="doDel();">??????</button>
				</c:if>
				<c:if test="${(resultView.stateCd eq 'E' || resultView.stateCd eq 'F')}">
					<c:if test="${resultView.issueNo ne '' && viewYn}">
						<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doPrint();">??????</button>
						<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doReEdit();">??????</button>
					</c:if>
				</c:if>
			</div>
				<div class="ml-15">
					<button type="button" class="btn_sm btn_secondary" onclick="doList();">??????</button>
				</div>
		</div>

		<table class="formTable">
			<colgroup>
				<col style="width:15%" />
				<col style="width:35%" />
				<col style="width:15%" />
				<col />
			</colgroup>
			<tbody>
				<c:if test="${not empty returnResultView }">
					<c:forEach items="${returnResultView }" var="list" varStatus="status">
						<tr>
							<th>
								<c:choose>
									<c:when test="${resultView.stateCd eq 'D' && (fn:length(returnResultView) == (status.index+1)) }">
										<strong>
											<c:out value="${(status.index+1) }"/> ????????????<br/>[<c:out value="${list.returnDate }"/>]
										</strong>
									</c:when>
									<c:otherwise>
										<c:out value="${(status.index+1) }"/> ????????????<br/>[<c:out value="${list.returnDate }"/>]
									</c:otherwise>
								</c:choose>
							</th>
							<td colspan="3">
								<c:choose>
									<c:when test="${not empty list.returnNo }">
										<a href="goReturnView('<c:out value="${list.returnNo}"/>')" class="link">
											<c:out value="${list.returnReason }"/>
										</a>
									</c:when>
									<c:otherwise>
										<c:out value="${list.returnReason }"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
					<!-- <tr><td colspan="4"></td></tr> -->
				</c:if>
				<tr>
					<th>?????????</th>
					<td><c:out value="${resultView.companyKor }"/></td>
					<th>????????????</th>

					<td><c:out value="${resultView.presidentKor }"/></td>

				</tr>
				<tr>
					<th>?????????????????????</th>
					<td><c:out value="${resultView.bsNo1 }"/>-<c:out value="${resultView.bsNo2 }"/>-<c:out value="${resultView.bsNo3 }"/></td>
					<th>?????????????????????</th>
					<td><c:out value="${resultView.bsNo }"/></td>
				</tr>
				<tr>
					<th>?????????????????????</th>
					<td colspan="3"><c:out value="${resultView.telEtc }"/></td>
				</tr>
				<tr>
					<th>??????</th>
					<td colspan="3"><c:out value="${resultView.korAddr1 }"/> <c:out value="${resultView.korAddr2 }"/></td>
				</tr>
				<tr>
					<th>??????????????????</th>
					<td colspan="3">
						<input type="hidden" name="attFileId" id="attFileId" value="<c:out value="${resultView.attFileId }"/>">
						<c:forEach var="fileList" items="${fileList}" varStatus="status">
							<c:out value="${(status.index+1) }"/> :  <a class="view_data attach_file" href="javascript:doDownloadFile('<c:out value="${fileList.fileId}"/>', '<c:out value="${fileList.fileNo}"/>');"><c:out value="${fileList.fileName}"/> ( <c:out value="${fileList.fileSize}"/> )</a>
							<button class="file_preview btn_tbl_border" type="button" onclick="viewer.showFileContents('${serverName}/supves/supvesFileDownload.do?fileId=${fileList.fileId}&fileNo=${fileList.fileNo}','<c:out value="${fileList.fileName}"/>', '<c:out value="svcex_${fileList.fileId}_${fileList.fileNo}"/>')" >
								<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
							</button>
						</c:forEach>
					</td>
				</tr>
				<!-- <tr><td colspan="4"></td></tr> -->
				<tr>
					<th>????????????</th>
					<td><c:out value="${resultView.wrkMembNm }"/></td>
					<th>?????????</th>
					<td>
						<c:choose>
							<c:when test="${not empty resultView.coHp1}">
								<c:out value="${resultView.coHp1}"/>-<c:out value="${resultView.coHp2}"/>-<c:out value="${resultView.coHp3}"/>
							</c:when>
							<c:otherwise>
								<c:out value="${resultView.coHpOld }"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>E-Mail</th>
					<td>
						<c:choose>
							<c:when test="${not empty resultView.coEmail1}">
								<c:out value="${resultView.coEmail1}"/>@<c:out value="${resultView.coEmail3}"/>
							</c:when>
							<c:otherwise>
								<c:out value="${resultView.coEmailOld }"/>
							</c:otherwise>
						</c:choose>
					</td>
					<th>????????????</th>
					<td><c:out value="${resultView.issueCd }"/></td>
				</tr>
				<!-- <tr><td colspan="4"></td></tr> -->
				<tr>
					<th>???????????????????????????</th>
					<td><date><c:out value="${resultView.amountSdate }"/></date> ~ <date><c:out value="${resultView.amountEdate }"/></date></td>
					<th>??????????????????????????????</th>
					<td><c:out value="${resultView.oriDataYn }"/></td>
				</tr>
				<tr>
					<th>??????????????????</th>
					<td colspan="3">
						<input name="contractAttFileId" id="contractAttFileId" type="hidden" value="<c:out value="${resultView.contractAttFileId }"/>">
						<c:forEach var="fileList" items="${contractFileList}" varStatus="status">
							<p>
								<span class="attr_list"><c:out value="${(status.index+1) }"/> : <a class="view_data attach_file" href="javascript:doDownloadFile('<c:out value="${fileList.fileId}"/>', '<c:out value="${fileList.fileNo}"/>');"><c:out value="${fileList.fileName}"/> ( <c:out value="${fileList.fileSize}"/> )</a></span>
								<button class="file_preview btn_tbl_border" type="button" onclick="viewer.showFileContents('${serverName}/supves/supvesFileDownload.do?fileId=${fileList.fileId}&fileNo=${fileList.fileNo}','<c:out value="${fileList.fileName}"/>', '<c:out value="svcex_${fileList.fileId}_${fileList.fileNo}"/>')" >
									<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
								</button>
							</p>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<th>??????????????????<br>????????????????????????</th>
					<td colspan="3">
						<input name="currencyAttFileId" id="currencyAttFileId" type="hidden" value="<c:out value="${resultView.currencyAttFileId }"/>">
						<c:forEach var="fileList" items="${currencyFileList}" varStatus="status">
							<p>
								<span class="attr_list"><c:out value="${(status.index+1) }"/> : <a class="view_data attach_file" href="javascript:doDownloadFile('<c:out value="${fileList.fileId}"/>', '<c:out value="${fileList.fileNo}"/>');"><c:out value="${fileList.fileName}"/> ( <c:out value="${fileList.fileSize}"/> )</a></span>
								<button class="file_preview btn_tbl_border" type="button" onclick="viewer.showFileContents('${serverName}/supves/supvesFileDownload.do?fileId=${fileList.fileId}&fileNo=${fileList.fileNo}','<c:out value="${fileList.fileName}"/>', '<c:out value="svcex_${fileList.fileId}_${fileList.fileNo}"/>')" >
									<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
								</button>
							</p>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table><!-- //formTable -->
	</div>

	<div class="cont_block">
		<div class="tbl_opt">
			<!-- ?????? ????????? -->
			<div id="totalCnt" class="total_count"></div>

			<fieldset class="ml-auto">
				<!-- <button type="button" class="btn_sm btn_primary" onclick="openItemListPup();">???????????????</button> -->
				<button type="button" class="btn_sm btn_primary" onclick="downloadIbSheetExcel(apllyDetailViewList1Sheet,'?????????????????? ?????????????????????','');">?????? ??????</button>

				<select id="pageUnit" name="pageUnit" onchange="doSearch();" title="?????????" class="form_select ml-8">
					<c:forEach var="item" items="${pageUnitList}" varStatus="status">
						<option value="${item.code}" <c:if test="${param.pageUnit eq item.code}">selected="selected"</c:if>>${item.codeNm}</option>
					</c:forEach>
				</select>

			</fieldset>
		</div>

		<div id="apllyDetailViewList1" class="sheet"></div>
		<div id="paging" class="paging ibs"></div>
	</div>

	<div class="cont_block">
		<div class="tbl_opt">
			<!-- ?????? ????????? -->
			<div id="totalCnt1" class="total_count"></div>

			<fieldset class="ml-auto">
				<button type="button" class="btn_sm btn_primary" onclick="downloadIbSheetExcel(apllyDetailViewList2Sheet,'?????????????????? ?????????????????????','');">?????? ??????</button>

				<select id="pageUnit1" name="pageUnit1" onchange="doSearch1();" title="?????????" class="form_select ml-8">
					<c:forEach var="item" items="${pageUnitList}" varStatus="status">
						<option value="${item.code}" <c:if test="${param.pageUnit1 eq item.code}">selected="selected"</c:if>>${item.codeNm}</option>
					</c:forEach>
				</select>

			</fieldset>
		</div>

		<div id="apllyDetailViewList2" class="sheet"></div>
		<div id="paging1" class="paging ibs"></div>
	</div>

</form>
<script type="text/javascript">

	var	ibHeader1 = new IBHeader();
	var	ibHeader2 = new IBHeader();
	ibHeader1.addHeader({Header: '???????????????',		Type: 'Text', 		SaveName: 'expImpNm',			Width: 6,	Align: 'Center'});
	ibHeader1.addHeader({Header: '?????????(?????????)',	Type: 'Text', 		SaveName: 'itemNm',				Width: 13,	Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', 		SaveName: 'tradePatternNm',		Width: 13,	Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????($)',		Type: 'Int',		SaveName: 'checkAmount',		Width: 8,	Align: 'Right'});
	ibHeader1.addHeader({Header: '?????????????????????',	Type: 'Text',		SaveName: 'foreignBank',		Width: 8,	Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'businessNo',			Width: 8,	Align: 'Center'	});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'targetCountryNm',	Width: 6,	Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'settleDate',			Width: 6,	Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'contractDate',		Width: 6,	Align: 'Center'});
	ibHeader1.addHeader({Header: '???????????????',		Type: 'Text',		SaveName: 'coNm',				Width: 13,	Align: 'Left'});

	ibHeader2.addHeader({Header: 'bsNo',		Type: 'Text',		SaveName: 'bsNo',				Hidden: true	});
	ibHeader2.addHeader({Header: 'reqno',		Type: 'Text',		SaveName: 'reqno',				Hidden: true	});
	ibHeader2.addHeader({Header: '???????????????',		Type: 'Text',		SaveName: 'expImpNm',			Width: 6,	Align: 'Center'});
	ibHeader2.addHeader({Header: '?????????(?????????)',	Type: 'Text',		SaveName: 'itemNm',				Width: 13,	Align: 'Center', Cursor:"Pointer"});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'tradePatternNm',		Width: 13,	Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????($)',		Type: 'Int',		SaveName: 'checkAmount',		Width: 8,	Align: 'Right'});
	ibHeader2.addHeader({Header: '?????????????????????',	Type: 'Text',		SaveName: 'foreignBank',		Width: 8,	Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'businessNo',			Width: 8,	Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'targetCountryNm',	Width: 6,	Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'settleDate',			Width: 6,	Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text',		SaveName: 'contractDate',		Width: 6,	Align: 'Center'});
	ibHeader2.addHeader({Header: '???????????????',		Type: 'Text',		SaveName: 'coNm',				Width: 13,	Align: 'Left'});

	ibHeader1.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2, NoFocusMode : 0 });
	ibHeader1.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	ibHeader2.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2, NoFocusMode : 0 });
	ibHeader2.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	var f = document.viewForm;

	$(document).ready(function(){
		var container1 = $('#apllyDetailViewList1')[0];
		createIBSheet2(container1, 'apllyDetailViewList1Sheet', '100%', '100%');
		ibHeader1.initSheet('apllyDetailViewList1Sheet');
		apllyDetailViewList1Sheet.SetSelectionMode(4);

		var container2 = $('#apllyDetailViewList2')[0];
		createIBSheet2(container2, 'apllyDetailViewList2Sheet', '100%', '100%');
		ibHeader2.initSheet('apllyDetailViewList2Sheet');
		apllyDetailViewList2Sheet.SetSelectionMode(4);

		getApplyDetailViewList1();
		getApplyDetailViewList2();
	});

	function doSearch() { goPage(1); }
	function doSearch1() { goPage1(1); }

	function goPage(pageIndex) {
		f.pageIndex.value = pageIndex;
		getApplyDetailViewList1();
	}
	function goPage1(pageIndex) {
		f.pageIndex1.value = pageIndex;
		getApplyDetailViewList2();
	}

	function getApplyDetailViewList1() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/selelctApplyDetailDataList.do" />'
			, data : $('#viewForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				$('#totalCnt').html('??? <span>' + global.formatCurrency(data.resultCnt) + '</span> ???');
				f.sumCheckAmount.value = data.sumCheckAmount;

				setPaging(
					'paging'
					, goPage
					, data.paginationInfo.currentPageNo
					, data.paginationInfo.totalRecordCount
					, data.paginationInfo.recordCountPerPage
					, data.paginationInfo.pageSize
				);

				apllyDetailViewList1Sheet.LoadSearchData({Data: data.resultList}, {Wait: 0});
			}
		});
	}

	function getApplyDetailViewList2() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/selelctApplyDetailTermDataList.do" />'
			, data : $('#viewForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				$('#totalCnt1').html('??? <span>' + global.formatCurrency(data.resultCnt) + '</span> ???');
				f.sumCheckAmount1.value = data.sumCheckAmount;

				setPaging(
					'paging1'
					, goPage1
					, data.paginationInfo.currentPageNo
					, data.paginationInfo.totalRecordCount
					, data.paginationInfo.recordCountPerPage
					, data.paginationInfo.pageSize
				);

				apllyDetailViewList2Sheet.LoadSearchData({Data: data.resultList}, {Wait: 0});
			}
		});
	}

	function doList(){
		var url = f.listPagePre.value;
		var pathname = window.location.pathname;

		if ( "" == f.listPagePre.value ){
			if ( pathname.includes('applyDetailView') ){
				url = "/svcex/svcexCertificate/applyList.do";
			}else if ( pathname.includes('applyDetailIssueCheckView')) {
				url = "/svcex/svcexCertificate/issueCheckList.do";
			}
		}else{
			f.action = url;
			f.target = "_self";
			f.submit();
		}


/* 		var url = f.listPagePre.value;
		if("" == f.listPagePre.value){
			f.action = '<c:url value="/svcex/svcexCertificate/applyList.do" />';
			f.target = '_self';
			f.submit();
		}else{
			f.action = url;
			f.target = "_self";
			f.submit();
		} */
	}

	// ??????
	function doApprove(){
		if(!confirm("?????? ?????? E-Mail??? ???????????? ?????? ?????????. \n?????? ???????????????????")) { return; }
		f.event.value = "APPROVE";

		global.ajaxSubmit($('#viewForm'), {
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/insertApplyDetailSave.do" />'
			, enctype : 'multipart/form-data'
			, dataType : 'json'
			, async : false
			, spinner : true
			, success : function(data){
				//alert("?????? ????????? ?????????????????????.");
				doList();
	        }
		});
	}

	// ??????
	function doReturn(){
		global.openLayerPopup({
			// ????????? ?????? URL
			popupUrl : '<c:url value="/svcex/svcexCertificate/popup/applyReturnView.do" />'
			// ????????? ???????????? ????????? parameter ??????
			, params : {
			}
			// ????????? ?????? Callback Function
			, callbackFunction : function(resultObj){

				if( resultObj ) {
					doReturnSave(resultObj);
				}
			}
		});
	}
	function doReturnSave(result) {
		f.returnReason.value = result;
		f.event.value = "RETURN";

		global.ajaxSubmit($('#viewForm'), {
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/insertReturnDetail.do" />'
			, enctype : 'multipart/form-data'
			, dataType : 'json'
			, async : false
			, spinner : true
			, success : function(data){
				//alert("?????? ????????? ?????????????????????.");
				doList();
	        }
		});
	}

	//??????
	function doUpdate(){
		f.action = "/svcex/svcexCertificate/offlineRegs2View.do";
		f.target = "_self";
		f.submit();
	}
	function doReEdit(){
		var pathname = window.location.pathname;
		var url ="";

		if ( pathname.includes('applyDetailView') ){
			url = "/svcex/svcexCertificate/selectUpdateDetail.do";
		}else if ( pathname.includes('applyDetailIssueCheckView')) {
			url = "/svcex/svcexCertificate/applyDetailIssueCheckUpdate.do";
		}

		f.action = url;
		f.target = "_self";
		f.submit();
	}

	function doDel(){
		if(!confirm("?????????????????????????")){
			return;
		}

		f.searchBsNo.value = '<c:out value="${resultView.bsNo}"/>';
	    f.searchReqno.value = '<c:out value="${resultView.reqno}"/>';
	    f.event.value= "DELETE";

	    global.ajaxSubmit($('#viewForm'), {
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/insertApplyDetailSave.do" />'
			, enctype : 'multipart/form-data'
			, dataType : 'json'
			, async : false
			, spinner : true
			, success : function(data){
				//alert("?????? ????????? ?????????????????????.");
				doList();
	        }
		});
	}

	// ?????? ??????
	function goReturnView(returnNo){
	    f.returnNo.value = returnNo;
	    var url = "/svcex/svcexCertificate/deniedDetailView.do";

// 		f.event.value= "";
		f.action = url;
		f.target = "_self";
// 		f.method = "post";
		f.submit();

	}

	//??????
	function doPrint(){
		if( !confirm( "?????? ???????????????????" ) ){
			return;
		}
		var ISSUE_NO = f.issueNo.value;
		var MEMBER_ID = f.memberId.value;
		var REQNO = f.reqno.value;
		var EXP_IMP_CD = f.expImpCd.value;
		var TRANSPORT_SERVICE_CD = f.transportServiceCd.value;
		var RESULT_CHK  = f.resultChk.value;

		var ori_data_yn ='<c:out value="${resultData.oriDataYn}"/>';

		if(ori_data_yn == '??????') {
			ori_data_yn = 'Y';
		}else{
			ori_data_yn = 'N';
		}

		ma_open_window( MEMBER_ID, REQNO, ISSUE_NO,EXP_IMP_CD, TRANSPORT_SERVICE_CD , RESULT_CHK, ori_data_yn );
	}

	function ma_open_window(memId, reqno, issueNo, expImpCd,transportServiceCd, resultChk, ori_data_yn  ){
		var resultYn = 'Y';
		if(ori_data_yn == null || ori_data_yn == ""){
	 		if( resultChk != 'Y' && transportServiceCd == '1' ){
	 			if( !confirm( "?????? ????????? ???????????? ???????????? ?????????????????????????" ) ){
	 				resultYn = 'N';
	 			}
	 		}
		}else{
			resultYn = 'N';
		}

		var left, top, nWidth, nHeight, url ,strUrl ;
		nWidth = 780;
		nHeight = 550;
		left = ((screen.width - nWidth) / 2);
		top = ((screen.height - nHeight) / 2);

		strUrl = "https://membership.kita.net/onlineTrade.do?ONLYVIEW=N";
		strUrl +=	 "&MEMBER_ID="+memId ;
		strUrl +=	 "&REQNO="+reqno ;
		strUrl +=	 "&CONTENT_NUM="+issueNo ;
		strUrl +=	 "&EXP_IMP_CD="+expImpCd ;
		strUrl +=	 "&TRANSPORT_SERVICE_CD="+transportServiceCd ;
		strUrl +=	 "&RESULT_YN="+resultYn ;
		strUrl +=	 "&USER=ADMIN" ;
		strUrl +=	 "&P_CNT=3";
		strUrl +=	 "&CERT_PERIOD=201301201312";
		strUrl +=	 "&CTR_CD=&HS_CD=&MT_CD=";
		strUrl +=	 "&IE_SUB_CODE=1000";

		window.open(strUrl, "ma_print_window", 'left='+left+',top='+top+',width='+nWidth+',height='+nHeight+',toolbar=no,menubar=no,status=no,scrollbars=no,resizable=no');

	}

	// ?????? ?????????
	function openItemListPup() {
		global.openLayerPopup({
			// ????????? ?????? URL
			popupUrl : '<c:url value="/svcex/svcexCertificate/popup/searchArticleView.do" />'
			// ????????? ???????????? ????????? parameter ??????
			, params : {
			}
			// ????????? ?????? Callback Function
			, callbackFunction : function(resultObj){

				if( resultObj ) {
// 					doReturnSave(resultObj);
				}
			}
		});
	}

	function apllyDetailViewList2Sheet_OnSearchEnd(code, msg) {
		if (code != 0) {
		}else{
			// ?????? ??????
			apllyDetailViewList2Sheet.SetColFontBold('itemNm', 1);
		}
	}


	function apllyDetailViewList2Sheet_OnClick(row, col, value, cellX, cellY, cellW, cellH) {
		if( row > 0 ) {
			if( apllyDetailViewList2Sheet.ColSaveName(col) == "itemNm" ) {
				var popupUrl = "/svcex/svcexCertificate/popup/applyDetailPopupView.do";
				var bsNo = apllyDetailViewList2Sheet.GetCellValue(row, "bsNo");
				var reqno = apllyDetailViewList2Sheet.GetCellValue(row, "reqno");

				global.openLayerPopup({
					// ????????? ?????? URL
					popupUrl : popupUrl
					// ????????? ???????????? ????????? parameter ??????
					, params : {
						popupBsNo: bsNo
						, popupReqno: reqno
					}
					// ????????? ?????? Callback Function
					, callbackFunction : function(resultObj){
					}
				});
			}
		}
	}

	function apllyDetailViewList1Sheet_OnSearchEnd(code, msg, stCode, stMsg, responseText) {
		var lastLow = apllyDetailViewList1Sheet.GetDataLastRow();
		var transNumber = f.sumCheckAmount.value;

		if( lastLow > 0 ) {
			transNumber = transNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			apllyDetailViewList1Sheet.ShowFooterRow([ {} ]);
			apllyDetailViewList1Sheet.SetCellText(lastLow+1, 0, "??????");
			apllyDetailViewList1Sheet.SetCellText(lastLow+1, 3, transNumber);
		}
	}
	function apllyDetailViewList2Sheet_OnSearchEnd(code, msg, stCode, stMsg, responseText) {
		var lastLow = apllyDetailViewList2Sheet.GetDataLastRow();
		var transNumber = f.sumCheckAmount1.value;

		if( lastLow > 0 ) {
			transNumber = transNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			apllyDetailViewList2Sheet.ShowFooterRow([ {} ]);
			apllyDetailViewList2Sheet.SetCellText(lastLow+1, 2, "??????");
			apllyDetailViewList2Sheet.SetCellText(lastLow+1, 5, transNumber);
		}
	}
	function doDownloadFile(fileId, fileNo) {
		var newForm = $('<form></form>');
		newForm.attr("name","newForm");
		newForm.attr("method","get");
		newForm.attr("action","/supves/supvesFileDownload.do");
		newForm.attr("target","_blank");
		newForm.append($('<input/>', {type: 'hidden', name: 'fileId', value: fileId }));
		newForm.append($('<input/>', {type: 'hidden', name: 'fileNo', value: fileNo }));
		newForm.appendTo('body');
		newForm.submit();
	}

</script>
