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
	<input type="hidden" name="searchReturnReason" value="<c:out value="${svcexVO.searchReturnReason }"/>"/>
	<input type="hidden" name="creStartDt" value="<c:out value="${svcexVO.creStartDt }"/>"/>
	<input type="hidden" name="creEndDt" value="<c:out value="${svcexVO.creEndDt }"/>"/>
	<input type="hidden" name="reqStartDt" value="<c:out value="${svcexVO.reqStartDt }"/>"/>
	<input type="hidden" name="reqEndDt" value="<c:out value="${svcexVO.reqEndDt }"/>"/>
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
	<input type="hidden" name="listPagePre" id="listPagePre" value="<c:out value="${svcexVO.listPage }"/>"/>

	<div class="location">
		<!-- ??????????????? -->
		<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
		<!-- ??????????????? -->
	</div>

	<div class="cont_block">
		<div class="tit_bar">
			<h3 class="tit_block">???????????? ??????</h3>

			<div class="ml-auto">
				<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="doDel();">??????</button>
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
					<th><strong>????????????<br>[<c:out value="${resultView.returnDate }"/>]</strong></th>
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
						<c:forEach var="fileList" items="${fileListRow}" varStatus="status">
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
					<td><c:out value="${resultData.issueCd }"/></td>
				</tr>
				<tr>
					<th>???????????????????????????</th>
					<td colspan="3"><date><c:out value="${resultView.amountSdate }"/></date> ~ <date><c:out value="${resultView.amountEdate }"/></date></td>
				</tr>
				<tr>
					<th>?????????????????????</th>
					<td colspan="3">
						<input name="currencyTotalAttFileId" id="currencyTotalAttFileId" type="hidden" value="<c:out value="${resultView.currencyTotalAttFileId }"/>">
						<c:forEach var="fileList" items="${currencyFileListRow}" varStatus="status">
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
		<table class="formTable dataTable">
			<colgroup>
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:25%" />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" colspan="2">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????(US $)</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th rowspan="2">????????????</th>
					<th scope="col">?????????????????????????????????</th>
					<td class="align_ctr">
						<c:if test="${not empty resultViewSub.domesticEiFrightSdate }">
							<c:out value="${resultViewSub.domesticEiFrightSdate }"/> ~ <c:out value="${resultViewSub.domesticEiFrightEdate }"/>
						</c:if>
					</td>
					<td class="align_r"><fmt:formatNumber value="${resultViewSub.domesticEiFrightReceipts }" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>???????????????????????????</th>
					<td class="align_ctr">
						<c:if test="${not empty resultViewSub.tripleFrightSdate }">
							<c:out value="${resultViewSub.tripleFrightSdate }"/> ~ <c:out value="${resultViewSub.tripleFrightEdate }"/>
						</c:if>
					</td>
					<td class="align_r"><fmt:formatNumber value="${resultViewSub.tripleFrightReceipts }" pattern="#,###" /></td>
				</tr>
				<tr>
					<th colspan="2" class="align_ctr">??????????????????????????????</th>
					<td class="align_ctr">
						<c:if test="${not empty resultViewSub.domesticTermOperRevSdate }">
							<c:out value="${resultViewSub.domesticTermOperRevSdate }"/> ~ <c:out value="${resultViewSub.domesticTermOperRevEdate }"/>
						</c:if>
					</td>
					<td class="align_r"><fmt:formatNumber value="${resultViewSub.domesticTermOperRevenue }" pattern="#,###" /></td>
				</tr>
				<tr>
					<th rowspan="2">?????????????????????</th>
					<th>??????????????? ????????????</th>
					<td class="align_ctr">
						<c:if test="${not empty resultViewSub.foreignTermOperSdate }">
							<c:out value="${resultViewSub.foreignTermOperSdate }"/> ~ <c:out value="${resultViewSub.foreignTermOperEdate }"/>
						</c:if>
					</td>
					<td class="align_r"><fmt:formatNumber value="${resultViewSub.foreignTermOperRevenue }" pattern="#,###" /></td>
				</tr>
				<tr>
					<th>???????????????????????????</th>
					<td class="align_ctr">
						<c:if test="${not empty resultViewSub.foriengnSdate }">
							<c:out value="${resultViewSub.foriengnSdate }"/> ~ <c:out value="${resultViewSub.foriengnEdate }"/>
						</c:if>
					</td>
					<td class="align_r"><fmt:formatNumber value="${resultViewSub.foriengnRevenue }" pattern="#,###" /></td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<th colspan="2" class="align_ctr">???  ???</th>
					<!-- <td>&nbsp;</td> -->
					<td colspan="2" class="align_r"><fmt:formatNumber value="${resultViewSub.amountSum }" pattern="#,###" /></td>
				</tr>
			</tfoot>
		</table><!-- //formTable -->
	</div><!-- //cont_block-->

</form>
<script type="text/javascript">
	var f = document.viewForm;

	$(document).ready(function(){
	});

	function doList(){
		var url = f.listPagePre.value;
		f.action = url;
		f.target = "_self";
		f.submit();
	}

	function doDel(){
		if(!confirm("?????????????????????????")){
			return;
		}
// 	    f.event.value= "DELETE";
// 		submitXmlRequest("/system/svcexCertificate/deniedDelete.do", "DELETE", f, "VALUEOBJECT");
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
