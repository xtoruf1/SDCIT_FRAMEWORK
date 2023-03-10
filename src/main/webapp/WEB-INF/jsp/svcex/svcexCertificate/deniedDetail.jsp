<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<spring:eval var="serverName" expression="@variables.getProperty('variables.serverName')" />

<form id="viewForm" name="viewForm" method="post" enctype="multipart/form-data" onsubmit="return false;">
	<input type="hidden" name="event" id="event" />
	<input type="hidden" name="searchCompanyKor" value="<c:out value="${svcexVO.searchCompanyKor }"/>"/>
	<input type="hidden" name="searchEnterRegNo" value="<c:out value="${svcexVO.searchEnterRegNo }"/>"/>
	<input type="hidden" name="searchBsNo" value="<c:out value="${svcexVO.searchBsNo }"/>"/>
	<input type="hidden" name="searchReqno" value="<c:out value="${svcexVO.searchReqno }"/>"/>
	<input type="hidden" name="searchIssueCd" value="<c:out value="${svcexVO.searchIssueCd }"/>"/>
	<input type="hidden" name="searchExpImpCd" value="<c:out value="${svcexVO.searchExpImpCd }"/>"/>
	<input type="hidden" name="searchStateCd" value="<c:out value="${svcexVO.searchStateCd }"/>"/>
	<input type="hidden" name="searchOrgCd" value="<c:out value="${svcexVO.searchOrgCd }"/>"/>
	<input type="hidden" name="issueStartDt" value="<c:out value="${svcexVO.issueStartDt }"/>"/>
	<input type="hidden" name="issueEndDt" value="<c:out value="${svcexVO.issueEndDt }"/>"/>

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
	<input type="hidden" name="returnNo" value="<c:out value="${resultView.returnNo }"/>"/>
	<input type="hidden" name="amountSdate" value="<c:out value="${resultView.amountSdate }"/>"/>
	<input type="hidden" name="amountEdate" value="<c:out value="${resultView.amountEdate }"/>"/>
	<input type="hidden" name="issueNo" value="<c:out value="${resultView.issueNo }"/>"/>

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
				<button type="button" class="btn_sm btn_secondary btn_modify_auth" onclick="doDel();">??????</button>
				<button type="button" class="btn_sm btn_secondary" onclick="doList();">??????</button>
			</div>
		</div>

		<table class="formTable">
			<colgroup>
				<col style="width:15%" />
				<col />
				<col style="width:15%" />
				<col />
			</colgroup>
			<tbody>
				<!-- ??????????????? ????????? ?????? ?????? -->
				<tr>
					<th><strong class="point">????????????<br>[<c:out value="${resultView.returnDate }"/>]</strong></th>
					<td colspan="3"><c:out value="${resultView.returnReason }"/></td>
				</tr>
				<!-- // ??????????????? ????????? ?????? ?????? -->
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
					<td colspan="3">
						<c:choose>
							<c:when test="${not empty resultView.coEmail1}">
								<c:out value="${resultView.coEmail1}"/>@<c:out value="${resultView.coEmail3}"/>
							</c:when>
							<c:otherwise>
								<c:out value="${resultView.coEmailOld }"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>???????????????????????????</th>
					<td colspan="3"><date><c:out value="${resultView.amountSdate }"/></date> ~ <date><c:out value="${resultView.amountEdate }"/></date></td>
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
	</div><!-- cont_block-->

	<div class="cont_block">
		<div class="tbl_opt">
			<!-- ?????? ????????? -->
			<div id="totalCnt" class="total_count"></div>

			<fieldset class="ml-auto">
				<!-- <button type="button" class="btn_sm btn_primary" onclick="openItemListPup();">???????????????</button> -->
				<button type="button" class="btn_sm btn_primary" onclick="downloadIbSheetExcel(apllyListSheet,'?????????????????? ?????????????????????','');">?????? ??????</button>

				<select id="pageUnit" name="pageUnit" onchange="doSearch();" title="?????????" class="form_select ml-8">
					<c:forEach var="item" items="${pageUnitList}" varStatus="status">
						<option value="${item.code}" <c:if test="${param.pageUnit eq item.code}">selected="selected"</c:if>>${item.codeNm}</option>
					</c:forEach>
				</select>

			</fieldset>
		</div>

		<div id="deniedDetailViewList1" class="sheet"></div>
		<div id="paging" class="paging ibs"></div>
	</div>

	<div class="cont_block">
		<div class="tbl_opt">
			<!-- ?????? ????????? -->
			<div id="totalCnt1" class="total_count"></div>

			<fieldset class="ml-auto">
				<button type="button" class="btn_sm btn_primary" onclick="downloadIbSheetExcel(apllyListSheet,'?????????????????? ?????????????????????','');">?????? ??????</button>

				<select id="pageUnit1" name="pageUnit1" onchange="doSearch1();" title="?????????" class="form_select ml-8">
					<c:forEach var="item" items="${pageUnitList}" varStatus="status">
						<option value="${item.code}" <c:if test="${param.pageUnit1 eq item.code}">selected="selected"</c:if>>${item.codeNm}</option>
					</c:forEach>
				</select>

			</fieldset>
		</div>

		<div id="deniedDetailViewList2" class="sheet"></div>
		<div id="paging1" class="paging ibs"></div>
	</div>

</form>

<script type="text/javascript">

	var	ibHeader1 = new IBHeader();
	var	ibHeader2 = new IBHeader();
	ibHeader1.addHeader({Header: '???????????????',		Type: 'Text', SaveName: 'expImpNm',			Width: 6,  Align: 'Center'});
	ibHeader1.addHeader({Header: '?????????(?????????)',	Type: 'Text', SaveName: 'itemNm',			Width: 13, Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'tradePatternNm',	Width: 13,  Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????($)',		Type: 'Int',  SaveName: 'checkAmount',		Width: 8,  Align: 'Right'});
	ibHeader1.addHeader({Header: '?????????????????????',	Type: 'Text', SaveName: 'foreignBank',		Width: 8,  Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'businessNo',		Width: 8,  Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'targetCountryNm',	Width: 6,  Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'settleDate',		Width: 6,  Align: 'Center'});
	ibHeader1.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'contractDate',		Width: 6, Align: 'Center'});
	ibHeader1.addHeader({Header: '???????????????',		Type: 'Text', SaveName: 'coNm',				Width: 13,  Align: 'Left'});

	ibHeader2.addHeader({Header: 'bsNo',		Type: 'Text', SaveName: 'bsNo',				Hidden: true	});
	ibHeader2.addHeader({Header: 'reqno',		Type: 'Text', SaveName: 'reqno',			Hidden: true	});
	ibHeader2.addHeader({Header: '???????????????',		Type: 'Text', SaveName: 'expImpNm',			Width: 6,  Align: 'Center'});
	ibHeader2.addHeader({Header: '?????????(?????????)',	Type: 'Text', SaveName: 'itemNm',			Width: 13, Align: 'Center', Cursor:"Pointer"});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'tradePatternNm', 	Width: 13,  Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????($)',		Type: 'Int',  SaveName: 'checkAmount',		Width: 8,  Align: 'Right'});
	ibHeader2.addHeader({Header: '?????????????????????',	Type: 'Text', SaveName: 'foreignBank',		Width: 8,  Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'businessNo',		Width: 8,  Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'targetCountryNm',	Width: 6,  Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'settleDate',		Width: 6,  Align: 'Center'});
	ibHeader2.addHeader({Header: '????????????',		Type: 'Text', SaveName: 'contractDate',		Width: 6, Align: 'Center'});
	ibHeader2.addHeader({Header: '???????????????',		Type: 'Text', SaveName: 'coNm',				Width: 13,  Align: 'Left'});
// 	ibHeader.addHeader({Header: '??????????????????', Type: 'Text', SaveName: 'stateCd', Width: 6, Align: 'Center', Hidden: true});

	ibHeader1.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2, NoFocusMode : 0 });
	ibHeader1.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	ibHeader2.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2, NoFocusMode : 0 });
	ibHeader2.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	var f = document.viewForm;

	$(document).ready(function(){
		var container1 = $('#deniedDetailViewList1')[0];
		createIBSheet2(container1, 'deniedDetailViewList1', '100%', '100%');
		ibHeader1.initSheet('deniedDetailViewList1');
		deniedDetailViewList1.SetSelectionMode(4);

		var container2 = $('#deniedDetailViewList2')[0];
		createIBSheet2(container2, 'deniedDetailViewList2', '100%', '100%');
		ibHeader2.initSheet('deniedDetailViewList2');
		deniedDetailViewList2.SetSelectionMode(4);

		getDeniedDetailViewList1();
		getDeniedDetailViewList2();
	});

	function doSearch() { goPage(1); }
	function doSearch1() { goPage1(1); }

	function goPage(pageIndex) {
		f.pageIndex.value = pageIndex;
		getDeniedDetailViewList1();
	}

	function goPage1(pageIndex) {
		f.pageIndex1.value = pageIndex;
		getDeniedDetailViewList2();
	}

	function getDeniedDetailViewList1() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/selelctDeniedDetailDataList.do" />'
			, data : $('#viewForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				$('#totalCnt').html('??? ' + global.formatCurrency(data.resultCnt) + ' ???');
				f.sumCheckAmount.value = data.sumCheckAmount;

				setPaging(
					'paging'
					, goPage
					, data.paginationInfo.currentPageNo
					, data.paginationInfo.totalRecordCount
					, data.paginationInfo.recordCountPerPage
					, data.paginationInfo.pageSize
				);

				deniedDetailViewList1.LoadSearchData({Data: data.resultList}, {Wait: 0});
			}
		});
	}

	function getDeniedDetailViewList2() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/selelctDeniedDetailTermDataList.do" />'
			, data : $('#viewForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				$('#totalCnt1').html('??? ' + global.formatCurrency(data.resultCnt) + ' ???');
				f.sumCheckAmount1.value = data.sumCheckAmount;

				setPaging(
					'paging1'
					, goPage1
					, data.paginationInfo.currentPageNo
					, data.paginationInfo.totalRecordCount
					, data.paginationInfo.recordCountPerPage
					, data.paginationInfo.pageSize
				);

				deniedDetailViewList2.LoadSearchData({Data: data.resultList}, {Wait: 0});
			}
		});
	}

	function doList(){
		var url = f.listPagePre.value;
		f.action = url;
		f.target = "_self";
		f.submit();
	}

	function doDel(){
		if(!confirm("?????????????????????????")){ return; }
	    f.event.value= "DELETE";

	    global.ajaxSubmit($('#viewForm'), {
			type : 'POST'
			, url : '<c:url value="/svcex/svcexCertificate/deleteDeniedData.do" />'
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

	function deniedDetailViewList2_OnSearchEnd(code, msg) {
		if (code != 0) {
		}else{
			// ?????? ??????
			deniedDetailViewList2.SetColFontBold('itemNm', 1);
		}
	}

	function deniedDetailViewList2_OnClick(row, col, value, cellX, cellY, cellW, cellH) {
		if( row > 0 ) {
			if( deniedDetailViewList2.ColSaveName(col) == "itemNm" ) {
				var popupUrl = "/svcex/svcexCertificate/popup/applyDetailPopupView.do";
				var bsNo = deniedDetailViewList2.GetCellValue(row, "bsNo");
				var reqno = deniedDetailViewList2.GetCellValue(row, "reqno");

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

	function deniedDetailViewList1_OnSearchEnd(code, msg, stCode, stMsg, responseText) {
		var lastLow = deniedDetailViewList1.GetDataLastRow();
		var transNumber = f.sumCheckAmount.value;

		if( lastLow > 0 ) {
			transNumber = transNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			deniedDetailViewList1.ShowFooterRow([ {} ]);
			deniedDetailViewList1.SetCellText(lastLow+1, 0, "??????");
			deniedDetailViewList1.SetCellText(lastLow+1, 3, transNumber);
		}
	}
	function deniedDetailViewList2_OnSearchEnd(code, msg, stCode, stMsg, responseText) {
		var lastLow = deniedDetailViewList2.GetDataLastRow();
		var transNumber = f.sumCheckAmount1.value;

		if( lastLow > 0 ) {
			transNumber = transNumber.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			deniedDetailViewList2.ShowFooterRow([ {} ]);
			deniedDetailViewList2.SetCellText(lastLow+1, 2, "??????");
			deniedDetailViewList2.SetCellText(lastLow+1, 5, transNumber);
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
