<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="serverName" expression="@variables.getProperty('variables.serverName')" />
<c:set var="profile"><spring:eval expression="@environment.getProperty('spring.profiles.active')" /></c:set>
<script type="text/javascript" src="/js/tradeSosComm.js"></script>

<form name="listForm" id="listForm" method="post">
	<c:forEach var="params" items="${param}"  varStatus="status">
		<input type="hidden" id="<c:out value="${params.key}"/>" name="<c:out value="${params.key}"/>" value="<c:out value="${params.value}"/>" />
	</c:forEach>
	<input type="hidden" id="TempFrDt" name="TempFrDt" value="<c:out value="${searchVO.tempFrDt}"/>"/>
	<input type="hidden" id="tempToDt" name="tempToDt" value="<c:out value="${searchVO.tempToDt}"/>"/>
</form>

<form id="loadAjaxForm" name="loadAjaxForm" method="post">
	<input type="hidden" name="tableGubun" value="<c:out value="${searchVO.tableGubun}"/>"/>
	<input type="hidden" name="orderSeq"  value="<c:out value="${searchVO.orderSeq}"/>"/>
	<input type="hidden" name="companyId" value="<c:out value="${searchVO.companyId}"/>"/>
	<input type="hidden" name="gubun" value="<c:out value="${searchVO.gubun}"/>"/>
</form>

<form id="layerPopForm" name="layerPopForm" method="post">
	<input type="hidden" name="orderSeq"  value=""/>
	<input type="hidden" name="gubun" value=""/>
	<input type="hidden" name="companyId" value="<c:out value="${searchVO.companyId}"/>"/>
	<input type="hidden" name="state" value=""/>
	<input type="hidden" name="tableGubun" value="<c:out value="${searchVO.tableGubun}"/>"/>
	<input type="hidden" name="procType" />
</form>

<form name="detailForm" id="detailForm" method="post">
	<input type="hidden" name="topMenuId" value="" />
	<input type="hidden" name="tableGubun" value="<c:out value="${searchVO.tableGubun}"/>"/>
	<input type="hidden" name="orderSeq" value="<c:out value="${searchVO.orderSeq}"/>"/>
	<input type="hidden" name="companyId" value="<c:out value="${searchVO.companyId}"/>"/>
	<input type="hidden" name="gubun" value="<c:out value="${searchVO.gubun}"/>"/>
	<input type="hidden" name="selfSupport" value="<c:out value="${applyMemberVO.selfSupport}"/>"/>
	<input type="hidden" name="lockYn" value="<c:out value="${applyMemberVO.lockYn}"/>">

	<%-- ???????????? --%>
	<input type="hidden" name="attachDocumId" value=""/>
	<input type="hidden" name="attachSeqNo" value=""/>
	<input type="hidden" name="attachDocumFg" value=""/>

<!-- ????????? ?????? -->
<div class="location">
	<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
	<div class="ml-auto">
		<%--	<c:if test="${searchVO.gubun ne 'C'}">
		<c:if test="${searchVO.state eq 'A' or searchVO.state eq 'B'}">
			<button type="button" class="btn_standard" onclick="fn_submit();">??????</button>
		</c:if>
		</c:if>--%>
		<button type="button" class="btn_sm btn_secondary" onclick="fn_list();">??????</button>
	</div>
</div>

<div class="cont_block">
	<!-- ????????? ?????? -->
	<div class="tit_bar">
		<h3 class="tit_block">????????? ??????</h3>
	</div>

	<div class="tbl_btn">
		<div class="list_kit">
	<%--		<div class="btn_group align_r">
				<c:if test="${searchVO.state eq 'E'}">
					<button type="button" class="btn_standard st2" onclick="appraisalPop();">????????????</button>
				</c:if>
			</div>--%>
		</div>

		<table class="formTable">
			<colgroup>
				<col style="width:15%">
				<col>
				<col style="width:15%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">?????????</th>
					<td><c:out value="${applyMemberVO.companyKor}"/></td>
					<th scope="row">?????????????????????</th>
					<td><c:out value="${applyMemberVO.companyId}"/></td>
				</tr>
				<tr>
					<th scope="row">?????????</th>
					<td><c:out value="${applyMemberVO.presidentKor}"/></td>
					<th scope="row">?????????????????????</th>
					<td><c:out value="${applyMemberVO.enterRegNo}"/></td>
				</tr>
				<tr>
					<th scope="row">????????? ??????</th>
					<td><c:out value="${applyMemberVO.voucherLevNm}"/></td>
					<th scope="row">??????????????????</th>
					<td>
						<c:if test="${!empty(applyMemberVO.engUrl)}">
							<a href="http://<c:out value="${applyMemberVO.engUrl}"/>" class="link" target="_blank">http://<c:out value="${applyMemberVO.engUrl}"/></a>
						</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">????????????</th>
					<td colspan="3"><c:out value="${applyMemberVO.korAddr1}"/></td>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<div class="cont_block">
	<!-- ????????? ?????? -->
	<div class="tit_bar">
		<h3 class="tit_block">?????? ??????</h3>
	</div>

	<table class="formTable">
		<colgroup>
			<col style="width:15%">
			<col>
			<col style="width:15%">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">??????</th>
				<td>
					<input type="hidden" name="memberId" id="memberId" value="<c:out value="${applyDetailVO.memberId}"/>"/>
					<c:out value="${applyDetailVO.memberNm}"/>
				</td>
				<th scope="row">??????</th>
				<td><c:out value="${applyDetailVO.position}"/></td>
			</tr>
			<tr>
				<th scope="row">??????</th>
				<td><c:out value="${applyDetailVO.depart}"/></td>
				<th scope="row">????????????</th>
				<td><c:out value="${applyDetailVO.tel}"/></td>
			</tr>
			<tr>
				<th scope="row">?????????</th>
				<td><c:out value="${applyDetailVO.mobile}"/></td>
				<th scope="row">?????????</th>
				<td><c:out value="${applyDetailVO.email}"/></td>
			</tr>
			<c:choose>
				<c:when test="${searchVO.gubun eq 'I'}">
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.languageNm}"/></td>
						<th scope="row">??????</th>
						<td><c:out value="${applyDetailVO.interPrePlace}"/></td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyDetailVO.interPreTypeNm}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">??????????????????</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${applyDetailVO.interPreType eq 'B'}">
									<c:out value="${applyDetailVO.orderInterPreTime}"/> ???
								</c:when>
								<c:otherwise>
									<c:out value="${applyDetailVO.orderInterPreTime}"/> ??????
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">?????????</th>
						<td><c:out value="${applyDetailVO.interPreStartDate}"/></td>
						<th scope="row">?????????</th>
						<td><c:out value="${applyDetailVO.interPreEndDate}"/></td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:set var="startTime" value=""/>
							<c:set var="endTime" value=""/>
							<c:set var="startTimeLength" value="${fn:length(applyDetailVO.interPreStartTime)}"/>
							<c:set var="endTimeLength" value="${fn:length(applyDetailVO.interPreEndTime)}"/>
							<c:set var="startTimeLength2" value="${fn:length(applyDetailVO.interPreStartTime2)}"/>
							<c:set var="endTimeLength2" value="${fn:length(applyDetailVO.interPreEndTime2)}"/>

							<c:choose>
								<c:when test="${applyDetailVO.interPreType eq 'A'}">
									<c:out value="${applyDetailVO.interPreStartTime}"/> ??? ?????? ~ <c:out value="${applyDetailVO.interPreEndTime}"/> ??????
									<c:if test="${applyDetailVO.interPreStartTime2 ne '' and applyDetailVO.interPreEndTime2}">
										<c:out value="${applyDetailVO.interPreStartTime2}"/> ??? ?????? ~ <c:out value="${applyDetailVO.interPreEndTime2}"/> ??????
									</c:if>
								</c:when>
								<c:when test="${applyDetailVO.interPreType eq 'B'}">
									<c:choose>
										<c:when test="${applyDetailVO.interPreStartTime2 ne '' and applyDetailVO.interPreEndTime2}">
											<c:choose>
												<c:when test="${startTimeLength2 eq '1'}">
													<c:out value="${applyDetailVO.interPreStartTime2}"/> ??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength2 eq '2'}">
													<c:out value="${applyDetailVO.interPreStartTime2}"/> ??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength2 eq '3'}">
													<c:out value="${fn:substring(applyDetailVO.interPreStartTime2,0,1)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreStartTime2,1,3)}"/>??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength2 eq '4'}">
													<c:out value="${fn:substring(applyDetailVO.interPreStartTime2,0,2)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreStartTime2,2,4)}"/>??? ?????? ~
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${endTimeLength2 eq '1'}">
													<c:out value="${applyDetailVO.interPreEndTime2}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength2 eq '2'}">
													<c:out value="${applyDetailVO.interPreEndTime2}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength2 eq '3'}">
													<c:out value="${fn:substring(applyDetailVO.interPreEndTime2,0,1)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreEndTime2,1,3)}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength2 eq '4'}">
													<c:out value="${fn:substring(applyDetailVO.interPreEndTime2,0,2)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreEndTime2,2,4)}"/> ??? ??????
												</c:when>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${startTimeLength eq '1'}">
													<c:out value="${applyDetailVO.interPreStartTime}"/> ??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength eq '2'}">
													<c:out value="${applyDetailVO.interPreStartTime}"/> ??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength eq '3'}">
													<c:out value="${fn:substring(applyDetailVO.interPreStartTime,0,1)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreStartTime,1,3)}"/>??? ?????? ~
												</c:when>
												<c:when test="${startTimeLength eq '4'}">
													<c:out value="${fn:substring(applyDetailVO.interPreStartTime,0,2)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreStartTime,2,4)}"/>??? ?????? ~
												</c:when>
											</c:choose>
											<c:choose>
												<c:when test="${endTimeLength eq '1'}">
													<c:out value="${applyDetailVO.interPreEndTime}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength eq '2'}">
													<c:out value="${applyDetailVO.interPreEndTime}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength eq '3'}">
													<c:out value="${fn:substring(applyDetailVO.interPreEndTime,0,1)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreEndTime,1,3)}"/> ??? ??????
												</c:when>
												<c:when test="${endTimeLength eq '4'}">
													<c:out value="${fn:substring(applyDetailVO.interPreEndTime,0,2)}"/> ??? <c:out value="${fn:substring(applyDetailVO.interPreEndTime,2,4)}"/> ??? ??????
												</c:when>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:when>
							</c:choose>
									&lt;%&ndash;<c:out value="${applyDetailVO.interPreStartTime}"/> ??? ?????? ~ <c:out value="${applyDetailVO.interPreEndTime}"/> ??????
									<c:if test="${applyDetailVO.interPreStartTime2 ne '' and applyDetailVO.interPreEndTime2}">
										<c:out value="${applyDetailVO.interPreStartTime2}"/> ??? ?????? ~ <c:out value="${applyDetailVO.interPreEndTime2}"/> ??????
									</c:if>
									&ndash;%&gt;
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.interPrePlaceNm}"/></td>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.interPreItemNm}"/></td>
					</tr>
				</c:when>
				<c:when test="${searchVO.gubun eq 'C'}">
					<tr>
						<th scope="row">?????? ?????????</th>
						<td><c:out value="${applyDetailVO.foreignCompanyNm}"/></td>
						<th scope="row">?????? ??????</th>
						<td><c:out value="${applyDetailVO.foreignUserNm}"/></td>
					</tr>
					<tr>
						<th scope="row">?????? ??????</th>
						<td><c:out value="${applyDetailVO.foreignNation}"/></td>
						<th scope="row">?????? ??????</th>
						<td><c:out value="${applyDetailVO.languageNm}"/>??? (12Point,A4??????)</td>
					</tr>
					<tr>
						<th scope="row">?????????</th>
						<td><c:out value="${applyDetailVO.foreignDate}"/></td>
						<th scope="row">????????????</th>
						<td>
							<c:out value="${applyDetailVO.foreignTimeGbNm}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							(??????????????????)<c:out value="${applyDetailVO.foreignFTelNo}"/> - <c:out value="${applyDetailVO.foreignTelNo}"/>
						</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.languageNm}"/></td>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.transGubunNm}"/></td>
					</tr>
					<tr>
						<th scope="row">???????????????</th>
						<td><c:out value="${applyDetailVO.transTypeNm}"/></td>
						<th scope="row">????????????</th>
						<td><c:out value="${applyDetailVO.transDocNum}"/>??? (12Point,A4??????)</td>
					</tr>
					<tr>
						<th scope="row">?????????</th>
						<td><c:out value="${applyDetailVO.itemTypeNm}"/></td>
						<th scope="row">???????????????</th>
						<td>
							<c:choose>
								<c:when test="${applyDetailVO.imgYn eq 'N'}">
									???????????????
								</c:when>
								<c:otherwise>
									????????? + ??????????????? ??????
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">?????? ????????????</th>
						<td colspan="3">
							<c:out value="${applyDetailVO.wishExpertId}"/>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>

			<tr>
				<th scope="row">????????????</th>
				<td colspan="3">
					<c:out value="${applyDetailVO.etcRequest}" escapeXml="false"/>
				</td>
			</tr>
			<c:if test="${!empty applyDetailVO.reason}">
				<tr>
					<th scope="row">??????????????????</th>
					<td colspan="3">
						<c:out value="${applyDetailVO.reason}" escapeXml="false"/>
					</td>
				</tr>
			</c:if>
			<c:if test="${!empty applyDetailVO.returnCause}">
				<tr>
					<th scope="row">????????????????????????</th>
					<td colspan="3">
						<c:out value="${applyDetailVO.returnCause}" escapeXml="false"/>
					</td>
				</tr>
			</c:if>
			<tr>
				<th scope="row">????????????</th>
				<td colspan="3">
					<c:if test="${not empty applyDetailVO.file}">
						<div id="attachFieldList">
						<c:forEach var="result" items="${applyDetailVO.file}" varStatus="status">
							<div class="addedFile" id="${fileResult.attachSeqNo}">
								<a href="javascript:directFileDown('<c:out value="${result.attachDocumPath}" />', '<c:out value="${result.attachDocumNm}" />', '<c:out value="${result.attachDocumNm}" />')" class="filename">
									<c:out value="${result.attachDocumNm}"/>
								</a>
						    	<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/com/directFileDownload.do?filePath=${result.attachDocumPath}&encSaveName=${result.attachDocumNm}&encOrgName=${result.attachDocumNm}', '${result.attachDocumNm}', 'membership_${profile}_${result.attachDocumId}_000${result.attachSeqNo}');" class="file_preview btn_tbl_border">
									<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
								</button>
							</div>
						</c:forEach>
						</div>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
</div>

	<!-- // ?????? ?????? -->
	<!-- ???????????? ????????? ?????? -->
	<c:if test="${searchVO.state ne 'E'}">
	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">?????? ??????</h3>
		</div>

		<%--<div class="tbl_btn">
			<div class="list_kit">
				<div class="btn_group align_r">
				<c:choose>
					<c:when test="${searchVO.state eq 'C'}">
						<button type="button" class="btn_standard st2" onclick="goCancel();">??????</button>
						<c:if test="${applyMemberVO.selfSupport eq 'Y' and applyMemberVO.selfSupportMoney ne '0' and searchVO.gubun eq 'I'}">
							<button type="button" class="btn_standard st2" onclick="goNoticeView();">???????????????</button>
							<c:if test="${searchVO.state eq 'C' and applyMemberVO.lockYn eq 'Y' and searchVO.gubun eq 'I'}">
								<button type="button" class="btn_standard st2" onclick="finish();">???????????????</button>
							</c:if>
						</c:if>
					</c:when>
					<c:when test="${searchVO.state eq 'D' or searchVO.state eq 'X'}">
						<c:if test="${searchVO.state eq 'D' and applyMemberVO.lockYn eq 'Y' and searchVO.gubun eq 'T'}">
							<button type="button" class="btn_standard st2" onclick="finish();">???????????????</button>
						</c:if>
					</c:when>
				</c:choose>
				</div>
			</div>--%>
			<table class="formTable">
				<colgroup>
					<col style="width:15%">
					<col>
					<col style="width:15%">
					<col>
				</colgroup>
				<tbody>
					<c:choose>
						<c:when test="${searchVO.gubun ne 'C'}">
							<c:choose>
								<c:when test="${searchVO.state eq 'A' or searchVO.state eq 'B'}">
									<%--??????????????? ?????????????????? ????????????--%>
									<tr>
										<th scope="row">????????????</th>
										<td colspan="3">
											<div class="field_set">
												<input type="hidden" name="expertId" id="expertId" value="<c:out value="${applyMemberVO.expertId}"/>">
												<input class="form_text input w40p" id="expertNm" name="expertNm" type="text" value="<c:out value="${applyMemberVO.expertNm}"/>" readonly>
												<%--<button type="button" class="btnSchOpt find" onclick="openExpert();">??????</button>--%>
											</div>
										</td>
									</tr>
									<tr>
										<th scope="row">????????????</th>
										<td>
											<label class="label_form">
												<input type="radio" name="payCheck" id="radio1" class="form_radio" value="Y" <c:if test="${empty applyMemberVO.payCheck or applyMemberVO.payCheck eq 'Y'}">checked="checked"</c:if>>
												<span class="label">??????</span>
											</label>
											<label class="label_form">
												<input type="radio" name="payCheck" id="radio2" class="form_radio" value="N" <c:if test="${applyMemberVO.payCheck eq 'N'}">checked="checked"</c:if>>
												<span class="label">????????????</span>
											</label>
										</td>
										<th scope="row"><c:out value="${empty(applyMemberVO.selfSupportPercentNm) ? '???????????????100%' : applyMemberVO.selfSupportPercentNm}"/></th> <%--???????????????--%>

										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.selfSupportMoney}" var="commaSelfSupportMoney"  groupingUsed="true"/>
											<input type="text" id="selfSupportMoneyTemp" class="form_text w40p" value="<c:out value="${commaSelfSupportMoney}"/>">
											<input type="hidden" name="selfSupportMoney" id="selfSupportMoney" value="${applyMemberVO.selfSupportMoney}"/>
										</td>
									</tr>
									<tr>
										<th scope="row"><c:out value="${empty(applyMemberVO.tradeSupportPercentNm) ? '??????????????????' : applyMemberVO.tradeSupportPercentNm}"/></th> <%--??????????????????--%>
										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" var="commaTradeSupportMoney" groupingUsed="true" />
											<input type="text" id="tradeSupportMoneyTemp" class="form_text w40p" value="<c:out value="${commaTradeSupportMoney}"/>">
											<input type="hidden" id="tradeSupportMoney" name="tradeSupportMoney" value="${applyMemberVO.tradeSupportMoney}" />
										</td>
										<th scope="row">????????????</th>
										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
										</td>
									</tr>
									<tr>
										<th scope="row">???????????????</th>
										<td>
											<c:choose>
												<c:when test="${applyMemberVO.mailCnt == '0'}">
													?????????
												</c:when>
												<c:otherwise>
													??????(<c:out value="${applyMemberVO.mailCnt}"/>???)
												</c:otherwise>
											</c:choose>
										</td>
										<th scope="row">????????????</th>
										<td>
											<c:out value="${applyMemberVO.lockYn eq 'Y' ? '?????????' : '?????? ?????????'}"/>
										</td>
									</tr>
								</c:when>
								<%--<c:when test="${searchVO.state eq 'C' or searchVO.state eq 'D' or searchVO.state eq 'X'}">--%>
								<c:otherwise>
									<%--????????? or ????????????--%>
									<tr>
										<th scope="row">????????????</th>
										<td colspan="3">
											<c:out value="${applyMemberVO.expertNm}"/>
										</td>
									</tr>
									<tr>
										<th scope="row">????????????</th>
										<td>
											<c:if test="${applyMemberVO.payCheck eq 'Y'}">
												??????
											</c:if>
											<c:if test="${applyMemberVO.payCheck eq 'N'}">
												????????????
											</c:if>
										</td>
										<th scope="row">${applyMemberVO.selfSupportPercentNm eq '' ? '???????????????' : applyMemberVO.selfSupportPercentNm}</th> <%--???????????????--%>
										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.selfSupportMoney}"  groupingUsed="true"/>
										</td>
									</tr>
									<tr>
										<th scope="row">${applyMemberVO.tradeSupportPercentNm eq '' ? '??????????????????' : applyMemberVO.tradeSupportPercentNm}</th> <%--??????????????????--%>
										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" groupingUsed="true" />
										</td>
										<th scope="row">????????????</th>
										<td>
											<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
										</td>
									</tr>
									<tr>
										<th scope="row">???????????????</th>
										<td>
											<c:choose>
												<c:when test="${applyMemberVO.mailCnt == '0'}">
													?????????
												</c:when>
												<c:otherwise>
													??????(<c:out value="${applyMemberVO.mailCnt}"/>???)
												</c:otherwise>
											</c:choose>
										</td>
										<th scope="row">????????????</th>
										<td>
											<c:out value="${applyMemberVO.lockYn eq 'Y' ? '?????????' : '?????? ?????????'}"/>
										</td>
									</tr>
									<%--</c:when>--%>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<tr>
								<th scope="row">????????????</th>
								<td colspan="3">
									????????????
								</td>
							</tr>
							<tr>
								<th scope="row">${applyMemberVO.tradeSupportPercentNm eq '' ? '??????????????????' : applyMemberVO.tradeSupportPercentNm}</th> <%--??????????????????--%>
								<td>
									<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" groupingUsed="true" />
								</td>
								<th scope="row">????????????</th>
								<td>
									<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
			<p class="mt-10">??? ???????????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.support_limit_amt}" groupingUsed="true" /></span>??? / ???????????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.supportedAmt}" groupingUsed="true" /></span>??? / ???????????? ?????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.supportAvaAmt}" groupingUsed="true" /></span>???</p>
		<%--</div>--%>
	</div>
	</c:if>

	<c:if test="${searchVO.state eq 'D' or searchVO.state eq 'X'}">
	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">?????? ??????</h3>
		</div>
			<table class="formTable">
				<colgroup>
					<col style="width:15%">
					<col>
					<col style="width:15%">
					<col>
				</colgroup>
				<tbody>
					<c:choose>
						<c:when test="${searchVO.gubun eq 'T'}">
							<tr>
								<th scope="row">?????? ????????????</th>
								<td colspan="3">
									<div class="field_set">
										<input type="text" class="form_text w40p" name="transResultNum" id="transResultNum" value="<c:out value="${applyMemberVO.transResultNum}"/>"/>??? (12Point,A4??????)
										<input type="hidden" name="supportMoney" id="supportMoney" value="<c:out value="${applyMemberVO.supportMoney}"/>">
										<input type="hidden" name="selfSupportMoney" value="<c:out value="${applyMemberVO.selfSupportMoney}"/>">
										<input type="hidden" name="transGubun" id="transGubun" value="<c:out value="${applyMemberVO.transGubun}"/>">
										<c:forEach items="${applyMemberVO.lanList}" var="item" varStatus="status">
											<c:if test="${applyMemberVO.language eq item.cd_id}">
												<input type="hidden" name="languageTemp" value="${item.cd_id}&${item.etc1}&${item.etc2}"/>
											</c:if>
										</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">???????????????</th>
								<td colspan="3">
									<c:out value="${applyMemberVO.reviewDate}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">????????? ????????????</th>
								<td colspan="3">
									<div class="attachFieldList">
									<c:forEach var="result" items="${applyMemberVO.ansFile}" varStatus="status">
										<div class="addedFile">
											<a href="javascript:directFileDown('<c:out value="${result.attachDocumPath}" />', '<c:out value="${result.attachDocumNm}" />', '<c:out value="${result.attachDocumNm}" />')" class="filename">
												<c:out value="${result.attachDocumNm}"/>
											</a>
											<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/com/directFileDownload.do?filePath=${result.attachDocumPath}&encSaveName=${result.attachDocumNm}&encOrgName=${result.attachDocumNm}', '${result.attachDocumNm}', 'membership_${profile}_${result.attachDocumId}_${result.attachSeqNo}');" class="file_preview btn_tbl_border">
												<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
											</button>
										</div>
									</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row">????????? ????????? ??????????????????</th>
								<td colspan="3">
									<textarea id="resultEtc" name="resultEtc" rows="2" class="form_textarea w100p"><c:out value="${applyMemberVO.resultEtc}"/></textarea>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<th scope="row">???????????????</th>
								<td colspan="3">
									<c:out value="${applyMemberVO.reviewDate}"/>
								</td>
							</tr>
							<tr>
								<th scope="row">??????????????????</th>
								<td colspan="3">
									<c:choose>
										<c:when test="${applyMemberVO.resultInterPreTime2 eq '0'}">
											<c:out value="${applyMemberVO.resultInterPreTime eq '' ? '0' : applyMemberVO.resultInterPreTime }"/> ??????
										</c:when>
										<c:otherwise>
											1??? <c:out value="${applyMemberVO.resultInterPreTime eq '' ? '0' : applyMemberVO.resultInterPreTime}"/> ??????
											2??? <c:out value="${applyMemberVO.resultInterPreTime2 eq '' ? '0' : applyMemberVO.resultInterPreTime2}"/> ??????
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		<%--</div>--%>
	</div>
	</c:if>

	<%--??????????????????--%>
	<c:if test="${searchVO.state eq 'E'}">
	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">?????? ??????</h3>
		</div>

		<table class="formTable">
			<colgroup>
				<col style="width:15%">
				<col>
				<col style="width:15%">
				<col>
			</colgroup>
			<tbody>
			<c:choose>
				<c:when test="${searchVO.gubun eq 'I'}">
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.expertNm}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:choose>
								<c:when test="${applyMemberVO.resultInterPreTime2 eq '0'}">
									<c:out value="${applyMemberVO.resultInterPreTime eq '' ? '0' : applyMemberVO.resultInterPreTime }"/> ??????
								</c:when>
								<c:otherwise>
									1??? <c:out value="${applyMemberVO.resultInterPreTime eq '' ? '0' : applyMemberVO.resultInterPreTime}"/> ??????
									2??? <c:out value="${applyMemberVO.resultInterPreTime2 eq '' ? '0' : applyMemberVO.resultInterPreTime2}"/> ??????
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">???????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.selfSupportMoney}" groupingUsed="true"  />
						</td>
						<th scope="row">??????????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" groupingUsed="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
						</td>
					</tr>
				</c:when>
				<c:when test="${searchVO.gubun eq 'T'}">
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.expertNm}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">?????? ????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.transResultNum}"/> ??? (12Point,A4??????)
						</td>
					</tr>
					<tr>
						<th scope="row">???????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.selfSupportMoney}" groupingUsed="true" />
						</td>
						<th scope="row">??????????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" groupingUsed="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">?????????</th>
						<td colspan="3">
							<c:forEach var="result" items="${applyMemberVO.ansFile}" varStatus="status">
								<div class="addedFile">
									<a href="javascript:directFileDown('<c:out value="${result.attachDocumPath}" />', '<c:out value="${result.attachDocumNm}" />', '<c:out value="${result.attachDocumNm}" />')" class="filename">
										<c:out value="${result.attachDocumNm}"/>
									</a>
									<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/com/directFileDownload.do?filePath=${result.attachDocumPath}&encSaveName=${result.attachDocumNm}&encOrgName=${result.attachDocumNm}', '${result.attachDocumNm}', 'membership_${profile}_${result.attachDocumId}_${result.attachSeqNo}');" class="file_preview btn_tbl_border">
										<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
									</button>
								</div>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.resultEtc}" escapeXml="false"/>
						</td>
					</tr>
				</c:when>
				<c:when test="${searchVO.gubun eq 'C'}">
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.expertNm}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:forEach var="result" items="${applyMemberVO.ansFile}" varStatus="status">
								<div class="addedFile">
									<a href="javascript:directFileDown('<c:out value="${result.attachDocumPath}" />', '<c:out value="${result.attachDocumNm}" />', '<c:out value="${result.attachDocumNm}" />')" class="filename">
										<c:out value="${result.attachDocumNm}"/>
									</a>
									<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/com/directFileDownload.do?filePath=${result.attachDocumPath}&encSaveName=${result.attachDocumNm}&encOrgName=${result.attachDocumNm}', '${result.attachDocumNm}', 'membership_${profile}_${result.attachDocumId}_${result.attachSeqNo}');" class="file_preview btn_tbl_border">
										<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
									</button>
								</div>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="row">???????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.selfSupportMoney}" groupingUsed="true" />
						</td>
						<th scope="row">??????????????????</th>
						<td>
							<fmt:formatNumber type="number" value="${applyMemberVO.tradeSupportMoney}" groupingUsed="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<fmt:formatNumber type="number" value="${applyMemberVO.total}" groupingUsed="true" />
						</td>
					</tr>
					<tr>
						<th scope="row">?????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.callDate}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">????????????(???)</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.callTime}"/>
						</td>
					</tr>
				</c:when>
			</c:choose>
			</tbody>
		</table>
	</div>

	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">????????? ??????</h3>
		</div>

		<table class="formTable">
			<colgroup>
				<col style="width:15%">
				<col>
				<col style="width:15%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">????????? ??????</th>
					<td colspan="3" class="rating">
						<div class="form_row">
							<c:if test="${!empty applyMemberVO.question1}">
								<span class="mr-5">?????????</span>
								<c:choose>
									<c:when test="${applyMemberVO.question1 eq '5'}"><img src="/images/admin/bl_star5.png" alt="5"></c:when>
									<c:when test="${applyMemberVO.question1 eq '4'}"><img src="/images/admin/bl_star4.png" alt="4"></c:when>
									<c:when test="${applyMemberVO.question1 eq '3'}"><img src="/images/admin/bl_star3.png" alt="3"></c:when>
									<c:when test="${applyMemberVO.question1 eq '2'}"><img src="/images/admin/bl_star2.png" alt="2"></c:when>
									<c:when test="${applyMemberVO.question1 eq '1'}"><img src="/images/admin/bl_star1.png" alt="1"></c:when>
								</c:choose>
							</c:if>
							<c:if test="${searchVO.gubun ne 'C'}">
								<c:if test="${!empty applyMemberVO.question2}">
									<span class="mr-5 ml-15">?????????</span>
									<c:choose>
										<c:when test="${applyMemberVO.question1 eq '5'}"><img src="/images/admin/bl_star5.png" alt="5"></c:when>
										<c:when test="${applyMemberVO.question1 eq '4'}"><img src="/images/admin/bl_star4.png" alt="4"></c:when>
										<c:when test="${applyMemberVO.question1 eq '3'}"><img src="/images/admin/bl_star3.png" alt="3"></c:when>
										<c:when test="${applyMemberVO.question1 eq '2'}"><img src="/images/admin/bl_star2.png" alt="2"></c:when>
										<c:when test="${applyMemberVO.question1 eq '1'}"><img src="/images/admin/bl_star1.png" alt="1"></c:when>
									</c:choose>
								</c:if>
							</c:if>
							<c:if test="${!empty applyMemberVO.question3}">
								<span class="mr-5 ml-15">?????????</span>
								<c:choose>
									<c:when test="${applyMemberVO.question3 eq '5'}"><img src="/images/admin/bl_star5.png" alt="5"></c:when>
									<c:when test="${applyMemberVO.question3 eq '4'}"><img src="/images/admin/bl_star4.png" alt="4"></c:when>
									<c:when test="${applyMemberVO.question3 eq '3'}"><img src="/images/admin/bl_star3.png" alt="3"></c:when>
									<c:when test="${applyMemberVO.question3 eq '2'}"><img src="/images/admin/bl_star2.png" alt="2"></c:when>
									<c:when test="${applyMemberVO.question3 eq '1'}"><img src="/images/admin/bl_star1.png" alt="1"></c:when>
								</c:choose>
							</c:if>
						</div>
					</td>
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:out value="${applyMemberVO.etcView}"/>
						</td>
					</tr>
					<c:if test="${applyMemberVO.ssFileList != ''}">
					<tr>
						<th scope="row">????????????</th>
						<td colspan="3">
							<c:forEach var="result" items="${applyMemberVO.ssFileList}" varStatus="status">
								<div class="addedFile">

									<a href="javascript:directFileDown('<c:out value="${result.attachDocumPath}" />', '<c:out value="${result.attachDocumNm}" />', '<c:out value="${result.attachDocumNm}" />')" class="filename">
										<c:out value="${result.attachDocumNm}"/>
									</a>
									<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/com/directFileDownload.do?filePath=${result.attachDocumPath}&encSaveName=${result.attachDocumNm}&encOrgName=${result.attachDocumNm}', '${result.attachDocumNm}', 'membership_${profile}_${result.attachDocumId}_${result.attachSeqNo}');" class="file_preview btn_tbl_border">
										<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="????????????" /> ????????????
									</button>

								</div>
							</c:forEach>
						</td>
					</tr>
					</c:if>
				</tr>
			</tbody>
		</table>
		<c:if test="${searchVO.tableGubun eq 'A'}">
			<p class="tbl_cmt mgb20">??? ???????????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.support_limit_amt}" groupingUsed="true" /></span>??? / ???????????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.supportedAmt}" groupingUsed="true" /></span>??? / ???????????? ?????? : <span class="color_r"><fmt:formatNumber type="number" value="${applyMemberVO.supportAvaAmt}" groupingUsed="true" /></span>???</p>
		</c:if>
	</div>
	</c:if>

	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">?????? ??????</h3>
		</div>

		<!-- ?????? ?????? ????????? ????????? -->
		<div id='applyHistorySheet' class="colPosi"></div>
	</div>

	<div class="cont_block">
		<!-- ????????? ?????? -->
		<div class="tit_bar">
			<h3 class="tit_block">?????? ??????</h3>
		</div>

		<div id='applyMemberHistorySheet' class="colPosi"></div>
	</div>

	<!-- // ???????????? ????????? ?????? -->
</div> <!-- // .page_tradesos -->
</form>

<!-- ?????? ????????? ?????? -->
<div id="tongPopup" class="modal modal-pop"></div>
<div id="bunPopup" class="modal modal-pop"></div>

<script type="text/javascript">

	$(document).ready(function(){

		//IBSheet ??????
		f_Init_applyHistorySheet();       // ????????????
		f_Init_applyMemberHistorySheet(); // ????????????
		//f_Init_expertSearchPop();       // ???????????? ?????? ??????

		getApplyHistoryList();			  // ???????????? ??????
		applyMemberHistoryList();         // ???????????? ??????
	});

	// ????????????
	function f_Init_applyHistorySheet() {
		var	ibHeader = new IBHeader();

		 /** ?????????,?????? ?????? */
    	ibHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 4, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2});
    	ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

		ibHeader.addHeader({Type: "Text", Header: "No", 		SaveName: "rnum",	Align: "Center",	Width: 50});
		ibHeader.addHeader({Type: "Text", Header: "????????????",	SaveName: "regstDt",	Align: "Center",	Width: 100});
		ibHeader.addHeader({Type: "Text", Header: "??????",		SaveName: "resnContents",	Align: "Left",		Width: 300});

        var sheetId = "applyHistorySheet";
		var container = $("#"+sheetId)[0];
        createIBSheet2(container,sheetId, "100%", "100%");
        ibHeader.initSheet(sheetId);

	};

	//????????????
	function f_Init_applyMemberHistorySheet() {
		var	ibHeader = new IBHeader();

		 /** ?????????,?????? ?????? */
    	ibHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 4, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2, NoFocusMode: 0, Ellipsis: 1});
    	ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

		ibHeader.addHeader({Type: "Text", Header: "No", 			SaveName: "rnum", Align: "Center", Width: 50});
		ibHeader.addHeader({Type: "Text", Header: "?????????", 		    SaveName: "regstDt", Align: "Center", Width: 100});
		ibHeader.addHeader({Type: "Text", Header: "?????????", 		    SaveName: "gubunNm", Align: "Center", Width: 70});
		ibHeader.addHeader({Type: "Text", Header: "????????????", 		SaveName: "languageNm", Align: "Center", Width: 50});
		ibHeader.addHeader({Type: "Text", Header: "????????????", 		SaveName: "stateNm", Align: "Center", Width: 50});
		ibHeader.addHeader({Type: "Text", Header: "?????? ????????????",	SaveName: "wishExpertId", Align: "Center", Width: 70});
		ibHeader.addHeader({Type: "Text", Header: "????????????", 		SaveName: "expertNm", Align: "Center", Width: 70});
		ibHeader.addHeader({Type: "Text", Header: "??????",            SaveName: "ibSheetOption1", Align: "Center", Width: 70, Cursor:"Pointer", FontBold: true});
		ibHeader.addHeader({Type: "Text", Header: "??????",            SaveName: "ibSheetOption2", Align: "Center", Width: 70, Cursor:"Pointer", FontBold: true});
		ibHeader.addHeader({Type: "Text", Header: "g",              SaveName: "gubun", Align: "Center", Width: 200, Hidden: true});
		ibHeader.addHeader({Type: "Text", Header: "o",              SaveName: "orderSeq", Align: "Center", Width: 200, Hidden: true});
		ibHeader.addHeader({Type: "Text", Header: "s",              SaveName: "state", Align: "Center", Width: 200, Hidden: true});

        var sheetId = "applyMemberHistorySheet";
		var container = $("#"+sheetId)[0];
        createIBSheet2(container,sheetId, "100%", "100%");
        ibHeader.initSheet(sheetId);

		// ???????????? OFF
		applyMemberHistorySheet.SetEditable(0);
	};

	function f_Init_expertSearchPop() {
		var	ibHeader = new IBHeader();

		 /** ?????????,?????? ?????? */
    	ibHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 4, DeferredVScroll: 1, SizeMode: 1, MouseHoverMode: 2});
    	ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

		ibHeader.addHeader({Type: "Radio", Header: "??????", 		SaveName: "col1", Align: "Center", Width: 50});
		ibHeader.addHeader({Type: "Text", Header: "????????????ID",  SaveName: "expertId", Align: "Center", Width: 50, Hidden:true, Edit:false});
		ibHeader.addHeader({Type: "Text", Header: "???????????????", 	SaveName: "name", Align: "Center", Width: 100, Edit: false });
		ibHeader.addHeader({Type: "Text", Header: "??????", 		SaveName: "languageNm", Align: "Center", Width: 100, Edit: false, Wrap:1 });
		ibHeader.addHeader({Type: "Text", Header: "?????????", 	SaveName: "regionNm", Align: "Left", Width: 100, Edit: false });
		ibHeader.addHeader({Type: "Text", Header: "???????????? \n ?????????", 	SaveName: "stateCnt1", Align: "Left", Width: 70, Edit: false });
		ibHeader.addHeader({Type: "Text", Header: "????????????", 	SaveName: "stateCnt2", Align: "Left", Width: 70, Edit: false });
		ibHeader.addHeader({Type: "Text", Header: "???????????? \n ??????", 	SaveName: "stateCnt3", Align: "Left", Width: 70, Edit: false });
		ibHeader.addHeader({Type: "Text", Header: "????????????", 	SaveName: "stateCnt4", Align: "Left", Width: 70, Edit: false });

        var sheetId = "expertSearchPop";
		var container = $("#"+sheetId)[0];
        createIBSheet2(container,sheetId, "100%", "100%");
        ibHeader.initSheet(sheetId);

	};

	// ???????????? ??????
	function fn_list() {
		document.listForm.action = "/tradeSOS/translation/translHistory.do";
		document.listForm.submit();
	}

	// ????????????
	function applyMemberHistorySheet_OnClick(Row, Col, Value) {
		var orderSeq = applyMemberHistorySheet.GetCellValue(Row,"orderSeq");
		var gubun = applyMemberHistorySheet.GetCellValue(Row, "gubun");
		var regstDt = applyMemberHistorySheet.GetCellValue(Row, "regstDt");
		var state = applyMemberHistorySheet.GetCellValue(Row, "state");

		if(applyMemberHistorySheet.ColSaveName(Col) == "ibSheetOption1") { // ????????????
			if(gubun == "I"){ //??????
				tongDetail(orderSeq, gubun, state);
			}else{ //????????????,??????
				bunDetail(orderSeq, gubun, regstDt, state);
			}
		}else if(applyMemberHistorySheet.ColSaveName(Col) == "ibSheetOption2"){ // ????????????

			document.layerPopForm.action = "/tradeSOS/translation/translHistoryDetail.do";
			document.layerPopForm.procType.value = "U";
			document.layerPopForm.orderSeq.value = orderSeq;
			document.layerPopForm.gubun.value = gubun;
			document.layerPopForm.companyId.value = $('#layerPopForm > input[name="companyId"]').val();
			document.layerPopForm.state.value = state;
			document.layerPopForm.tableGubun.value = $('#layerPopForm > input[name="tableGubun"]').val();

			document.layerPopForm.submit();
		}
	};

	// ???????????? ????????????
	function getApplyHistoryList() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/tradeSOS/translation/applyHistoryInfo.do" />'
			, data : $('#loadAjaxForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){

				applyHistorySheet.LoadSearchData({Data: data.applyHistoryList});
			},
			error:function(request, status, error) {
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	// ???????????? ????????????
	function applyMemberHistoryList() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/tradeSOS/translation/applyMemberHistoryInfo.do" />'
			, data : $('#loadAjaxForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){

				applyMemberHistorySheet.LoadSearchData({Data: data.applyMemberHistoryList});
			},
			error:function(request, status, error) {
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}

	// ?????? ??????(????????????)
	function tongDetail(orderSeq, gubun, state){
		$('#layerPopForm > input[name="orderSeq"]').val(orderSeq);
		$('#layerPopForm > input[name="gubun"]').val(gubun);
		$('#layerPopForm > input[name="state"]').val(state);
		var companyId = $('#layerPopForm > input[name="companyId"]').val();

		global.openLayerPopup({
			// ????????? ?????? URL
			popupUrl : '<c:url value="/tradeSOS/translation/tongPopup.do" />'
			// ????????? ???????????? ????????? parameter ??????
			, params : {
						targetPopup : 'tongPopup'
					  , orderSeq : orderSeq
					  , gubun : gubun
					  , state : state
				      , companyId : companyId
			}
			// ????????? ?????? Callback Function
			, callbackFunction : function(resultObj){
			}
		});

	}

	//????????????,?????? ??????(????????????)
	function bunDetail(orderSeq, gubun, regstDt, state){
		$('#layerPopForm > input[name="orderSeq"]').val(orderSeq);
		$('#layerPopForm > input[name="gubun"]').val(gubun);
		$('#layerPopForm > input[name="state"]').val(state);
		var companyId = $('#layerPopForm > input[name="companyId"]').val();

		global.openLayerPopup({
			// ????????? ?????? URL
			popupUrl : '<c:url value="/tradeSOS/translation/bunPopup.do" />'
			// ????????? ???????????? ????????? parameter ??????
			, params : {
						targetPopup : 'bunPopup'
					  , orderSeq : orderSeq
					  , gubun : gubun
					  , state : state
					  , regstDt : regstDt
				      , companyId : companyId
			}
			// ????????? ?????? Callback Function
			, callbackFunction : function(resultObj){
			}
		});
	}

	//???????????? ????????????
	function directFileDown(filePath, saveName, fileName) {
		var f2 = document.detailForm;

		f2.action = "/tradeSOS/com/directFileDownload.do?filePath="+filePath+"&encSaveName="+saveName+"&encOrgName="+fileName;
		f2.target = "_self";
		f2.submit();
	}

</script>
