<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="common" uri="/WEB-INF/META-INF/common.tld"%>

<form id="fundInquirySpePrintPopupForm" name="fundInquirySpePrintPopupForm" method="get" onsubmit="return false;">
	<input type="hidden" name="svrId" value="<c:out value="${param.svrId}"/>" />
	<input type="hidden" name="applyId" value="<c:out value="${param.applyId}"/>" />

	<!-- 팝업 타이틀 -->
<div style="max-width: 1400px; max-height: 700px;" class="fixed_pop_tit">
	<div class="flex popup_top">
		<div class="ml-auto " id="btn_group">
			<button type="button" onclick="doFundInquiryPrintPopupPrint();" class="btn_sm btn_primary">출력</button>
		</div>
		<div class="ml-15">
			<button type="button" class="btn_sm btn_secondary" onclick="doClear();">닫기</button>
		</div>

	</div>

	<div class="popup_body" id="printTable">
		<h2 class="popup_title">무역기금 융자 신청서</h2>
		<div class="tit_bar">
			<div class="ml-auto">
				접수번호 : <c:out value="${returnMap.applyId}" />
			</div>
		</div>
		<table class="formTable print">
			<COLGROUP>
				<COL width="56px" style="height: 25px;">
				<COL width="94px">
				<COL width="120px">
				<COL width="100px">
				<COL width="170px">
				<COL width="150px">
				<COL width="120px">
			</COLGROUP>
			<tr>
				<th rowspan="2" colspan="2">(1)무역업고유번호<br />사업자등록번호</th>
				<td><c:out value="${returnMap.bsNo}" /></td>
				<th rowspan="2">(2)회사명</th>
				<td rowspan="2"><c:out value="${returnMap.coNmKor}" /></td>
				<th rowspan="2">(3)대표자</th>
				<td rowspan="2"><c:out value="${returnMap.ceoNmKor}" /></td>
			</tr>

			<tr>
				<td><c:out value="${returnMap.industryNo}" /></td>
			</tr>

			<tr>
				<th rowspan="2" colspan="2">(4)주소</th>
				<td colspan="3" rowspan="2"><c:out value="${returnMap.coZipCd}" />
					<c:out value="${returnMap.coAddr1}" /> <br /> <c:out value="${returnMap.coAddr2}" />
				</td>
				<th rowspan="2">(5)회사전화번호<br />회사팩스번호 </th>
				<td class="phoneNum"><c:out value="${returnMap.coTelNum}" /></td>
			</tr>

			<tr>
				<td class="phoneNum"><c:out value="${returnMap.coFaxNum}" /> </td>
			</tr>

			<tr>
				<th colspan="2">(6)홈페이지</th>
				<td align="left" colspan="3"><c:out value="${returnMap.homeAddr}" /></td>
				<th>(7)제조업여부</th>
				<td><c:out value="${returnMap.jejoupNm}" /></td>
			</tr>

			<tr>
				<th colspan="2" rowspan="2">(8)주요수출국가<br />주요수출품목
				</th>
				<td colspan="3"><c:out value="${returnMap.mainexpnation}" /></td>
				<th rowspan="2">(9)전년도매출액</th>
				<td rowspan="2" align="right"><c:out value="${returnMap.salAmount}" />(원)</td>
			</tr>

			<tr>
				<td colspan="3"><c:out value="${returnMap.productname}" /></td>
			</tr>

			<tr>
				<th colspan="2">(10)자본금</th>
				<td align="right"><c:out value="${returnMap.capital}" />(원)</td>
				<th>(11)종업원</th>
				<td align="right"><c:out value="${returnMap.workerCnt}" />(명)</td>
				<th>(12)설립년도</th>
				<td><c:out value="${returnMap.coCretYear}" />(년)</td>
			</tr>

			<tr>
				<th align="center" rowspan="2">(13)<br />담당자</tthd>
				<th>성명</th>
				<td><c:out value="${returnMap.membNm}" /></td>
				<th>부서/직위</th>
				<td>
					<table width="100%" height="100%">
						<tr>
							<td width="*" style="padding-right: 3px; border: 0;"><c:out value="${returnMap.membDeptnm}" /></td>
							<td width="10%" style="border: 0;">&nbsp;/</td>
							<td width="40%" style="border: 0; padding-left: 3px;">
								<c:out value="${returnMap.membPosition}" />
							</td>
						</tr>
					</table>
				<th>전화번호</th>
				<td class="phoneNum"><c:out value="${returnMap.membTel}" /></td>
			</tr>

			<tr>
				<th>이메일</th>
				<td colspan="3"><c:out value="${returnMap.membEmail}" /></td>
				<th>팩스번호</th>
				<td class="phoneNum"><c:out value="${returnMap.membFax}" /></td>
			</tr>
		</table>
		<!-- </div> -->

		<!-- <div class="cont_block"> -->

		<table class="formTable print">
			<COLGROUP>
				<COL width="60px">
				<COL width="160px">
				<COL width="120px">
				<COL width="180px">
				<COL width="180px">
				<COL width="140px">
			</COLGROUP>
			<tr>
				<th align="center" rowspan="4">(14)<br />수출<br />실적
				</th>
				<th align="center" colspan="2">구분</th>


				<c:choose>
					<c:when test='${returnMap.applyId eq "BS201711107"}'>
						<c:set var="moneyUseNm" value="수출이행자금" />
						<th align="center">2015년</th>
						<th align="center">2016년</th>
					</c:when>
					<c:when test='${returnMap.applyId eq "SU201803157"}'>
						<th align="center">2016년</th>
						<th align="center">2017년</th>
					</c:when>
					<c:otherwise>
						<th align="center"><c:out value="${returnMap.twoYear}" /> 년</th>
						<th align="center"><c:out value="${returnMap.oneYear}" /> 년</th>
					</c:otherwise>
				</c:choose>
				<th align="center">증가율(%)</th>
			</tr>

			<tr>
				<th colspan="2">직수출(A)</th>
				<td align="right" style="">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.expAmount2}" /></td>
						</tr>
					</table>
				</td>
				<td align="right" style="">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.expAmount1}" /></td>
						</tr>
					</table>
				</td>
				<td align="center" style="padding-right: 5px;"><c:out value="${returnMap.expIncrsRate}" />%</td>
			</tr>

			<tr>
				<th colspan="2">로컬등 기타수출(B)</th>
				<td align="right" style="">
					<table>
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.etcExpAmount2}" /> </td>
						</tr>
					</table>
				</td>
				<td align="right" style="">
					<table>
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.etcExpAmount1}" /> </td>
						</tr>
					</table>
				</td>
				<td align="center"><c:out value="${returnMap.etcExpRate}" />%</td>
			</tr>

			<tr>
				<th colspan="2">합계(A+B)</th>
				<td align="right">
					<table>
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.sumExpAmount2}" /></td>
						</tr>
					</table>
				</td>
				<td align="right">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.sumExpAmount1}" /></td>
						</tr>
					</table>
				</td>
				<td align="center"><c:out value="${returnMap.expIncrsRate}" />%</td>
			</tr>
		<tr >
			<th  rowspan="5" align="center">(15)<br/>해상/항공운임<br/>사용액</th>
			<th  colspan="2" align="center">구분</th>
			<th  align="center">2019년6월 ~ 2020년5월</th>
			<th  align="center">2020년6월 ~ 2021년5월</th>
			<th  align="center">증가율(%)</th>
		</tr>

		<tr >
			<th  colspan="2">해상운임(A)</th>
			<td align="center"><c:out value="${returnMap.speSeaAmount2}" /></td>
			<td align="center"><c:out value="${returnMap.speSeaAmount1}" /></td>
			<td align="center"><c:out value="${returnMap.speSeaRate}" />%</td>
		</tr>

		<tr >
			<th  colspan="2">항공운임(B)</th>
			<td align="center"><c:out value="${returnMap.speAirAmount2}" /></td>
			<td align="center"><c:out value="${returnMap.speAirAmount1}" /></td>
			<td align="center"><c:out value="${returnMap.speAirRate}" />%</td>
		</tr>

		<tr >
			<th colspan="2" >특송/내륙 등(C)</th>
			<td align="center"><c:out value="${returnMap.speEtcAmount2}" /></td>
			<td align="center"><c:out value="${returnMap.speEtcAmount1}" /></td>
			<td align="center"><c:out value="${returnMap.speEtcRate}" />%</td>
		</tr>

		<tr >
			<th colspan="2">합계(A+B+C)</th>
			<td align="center"><c:out value="${returnMap.speSumAmount2}" /></td>
			<td align="center"><c:out value="${returnMap.speSumAmount1}" /></td>
			<td align="center"><c:out value="${returnMap.speSumRate}"/>%</td>
		</tr>
			<tr>
				<th colspan="3" >(16)현재보유LC</th>
				<td align="center"><c:out value="${returnMap.lcAmount}" /></td>
				<th> (17)계약금액 </th>
				<td align="right">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td align="left" style="border: 0">US$</td>
							<td align="right" style="border: 0"><c:out value="${returnMap.extContrAmount}" /></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<th align="center" rowspan="4">(18)<br />융자
				</th>
				<th colspan="2">자금용도</th>
				<td colspan="3"><c:out value="${returnMap.moneyUse1Str}" />
				</td>
			</tr>

			<tr>
				<th colspan="2">자금신청액</th>
				<td colspan="3"><c:out value="${returnMap.necessAmount}" /> (원)</td>
			</tr>

			<tr>
				<th colspan="2">융자희망은행</th>
				<td colspan="3"><c:out value="${returnMap.mainBankNm}" />
					<c:out value="${returnMap.mainBankBranchNm}" />(지점)</td>
			</tr>

			<tr>
				<th colspan="2">담보종류</th>
				<c:if test="${not empty mortgageAmtList}" >
					<td colspan="3" data="list">
						<c:forEach var="mortgageAmt" items="${mortgageAmtList}" varStatus="mortgageAmtStatus">
								<c:out value="${mortgageAmt.mortgageNm}" />  : <c:out value="${mortgageAmt.mortgageAmount}" />
						</c:forEach>
					</td>
				</c:if>

				<c:if test="${empty mortgageAmtList}" >
				<td colspan="3" data="selectOne">
					<c:out value="${returnMap.mortgageNm}" />  : <c:out value="${returnMap.necessAmount}" />
				</td>
				</c:if>
			</tr>
		</table>
		<!-- </div> -->


		<table class="formTable print">
			<colgroup>
				<col width="75px">
				<col width="110px">
				<col width="110px">
				<col width="110px">
				<col width="110px">
				<col width="110px">
				<col width="*">
			</colgroup>
			<tr>
				<th rowspan="2" align="center">※참고<br>(기융자)
				</th>
				<th>회원가입일</th>
				<td><c:out value="${regDate}" /> </td>
				<th>개업년원일</th>
				<td><c:out value="${foundDate}" /> </td>
				<th>기융자횟수</th>
				<td><c:out value="${beforeCnt}" /> 회</td>
			</tr>

			<tr>
				<td colspan="6" style="padding: 0">
					<table style="width: 100%; height: 100%;">
						<colgroup>
							<col width="*">
							<col width="100px">
							<col width="100px">
							<col width="100px">
							<col width="100px">
							<col width="100px">
						</colgroup>

						<tr>
							<th style="text-align: center; border: 0">사업명</th>
							<th style="text-align: center; border-top: 0">추천금액</th>
							<th style="text-align: center; border-top: 0">1차융자일자</th>
							<th style="text-align: center; border-top: 0">1차융자금액</th>
							<th style="text-align: center; border-top: 0">2차융자일자</th>
							<th style="text-align: center; border-top: 0; border-right: 0">2차융자금액</th>
						</tr>
						<c:choose>
							<c:when test="${fn:length(beforeList) > 0}">
								<c:forEach var="before" items="${beforeList}" varStatus="status">
									<tr>
										<td><c:out value="${before.title}" /></td>
										<td style="text-align: right;">
											<c:out value="${before.recdAmount}" />
										</td>
										<td style="text-align: center;">
											<c:out value="${before.recdDt}" />
										</td>
										<td style="text-align: right;">
											<c:if test='${before.defntAmount ne "0"}'>
												<c:out value="${before.defntAmount}" />
											</c:if>
										</td>
										<td style="text-align: center;">
											<c:out value="${before.recdDt2}" />
										</td>
										<td style="text-align: right;"><c:if
												test='${before.defntAmount2 ne "0"}'>
												<c:out value="${before.defntAmount2}" />
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>

								<tr>
									<td style="border-left: 0; border-bottom: 0"></td>
									<td style="text-align: right; border-bottom: 0">&nbsp;</td>
									<td style="text-align: center; border-bottom: 0">&nbsp;</td>
									<td style="text-align: right; border-bottom: 0">&nbsp;</td>
									<td style="text-align: center; border-bottom: 0">&nbsp;</td>
									<td
										style="text-align: right; border-bottom: 0; border-right: 0">&nbsp;</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</table>
				</td>
			</tr>
		</table>



		<div class="cont_block">
			<TABLE cellspacing="0" cellpadding="0" width="750px" style=""
				class="mt-10">
				<tr>
					<td style="padding-left: 10px;">상기와 같이 무역기금을 신청 합니다.</td>
				</tr>
				<tr>
					<c:choose>
						<c:when test='${returnMap.applyId eq "BS201711107"}'>
							<td align="right" style="padding-right: 10px;">2017년 11월 10일</td>
						</c:when>
						<c:when test='${returnMap.applyId eq "SU201803157"}'>
							<td align="right" style="padding-right: 10px;">2018년 3월 10일</td>
						</c:when>
						<c:otherwise>
							<td align="right" style="padding-right: 10px;"><c:out
									value="${returnMap.year}" />년 <c:out value="${returnMap.mm}" />월
								<c:out value="${returnMap.dd}" />일</td>
						</c:otherwise>
					</c:choose>
				</tr>
			</TABLE>


			<TABLE cellspacing="0" cellpadding="0" width="750px" style=""
				class="">
				<tr>
					<td align="right" style="font-size: 15px; font: bold; padding-right: 10px;">신청인(대표자)
						<c:out value="${returnMap.ceoNmKor}" /> (인)
					</td>
				</tr>
			</TABLE>

			<TABLE cellspacing="0" cellpadding="0" width="750px" style="" class="">
				<tr>
					<td width="80px" rowspan="7" valign="top"
						style="padding-left: 10px;">제출서류:</td>
					<td width="*">1. 무역기금 융자신청서 1부 (필수)</td>
				</tr>
				<tr>
					<td width="*">2. 무역기금 수출마케팅자금 계획서 1부 (필수)</td>
				</tr>
				<tr>
					<td width="*">3. 사업계획서(자율양식) 1부 (필수)</td>
				</tr>
				<tr>
					<td width="*">4. 수출실적증명서(주거래은행 발급) 1부</td>
				</tr>
				<tr>
					<td width="*" style="padding-left: 15px;">-수출실적이 무역기금융자 신청서
						(14)수출실적의 직수출(A)란에 자동으로 뜨는 금액뿐인 업체는 제출 생략</td>
				</tr>
				<tr>
					<td width="*">5. 기타 해당항목의 증빙자료 각 1부</td>
				</tr>
				<tr height="10px">
					<td></td>
				</tr>
			</TABLE>

			<div id="printHidden">
				<TABLE cellspacing="0" cellpadding="0" width="750px" style=""
					class="">
					<tr height="30px">
						<td></td>
					</tr>
				</TABLE>
			</div>

			<p style="page-break-before: always;">
			<TABLE cellspacing="0" cellpadding="0" width="750px" style=""
				class="">
				<tr>
					<td style="font: bold;">(제출서류-필수)</td>
				</tr>
			</TABLE>


			<TABLE>
				<tr height="60px">
					<td style="font-size: 20px; font: bold;" align="center">해상/항공운임 계획서</td>
				</tr>
			</TABLE>
		</div>


		<table class="formTable">
			<colgroup>
				<COL width="59px">
				<COL width="180px">
				<COL width="220px">
				<COL width="180px">
				<COL width="220px">
			</colgroup>
			<tr>
				<th align="center" rowspan="9">□<br />회<br />사<br />개<br />요
				</th>
				<th>업 체 명</th>
				<td><c:out value="${returnMap.coNmKor}" /> </td>
				<th>대 표 자</th>
				<td><c:out value="${returnMap.ceoNmKor}" /></td>
			</tr>

			<tr>
				<th>주소</th>
				<td colspan="3"><c:out value="${returnMap.coZipCd}" />
					<c:out value="${returnMap.coAddr1}" />
					<c:out value="${returnMap.coAddr2}" />
				</td>
			</tr>

			<tr>
				<th>사업자등록번호</th>
				<td><c:out value="${returnMap.industryNo}" /> </td>
				<th>무역업등록번호</th>
				<td><c:out value="${returnMap.bsNo}" /> </td>
			</tr>

			<tr>
				<th>회사전화번호</th>
				<td class="phoneNum"><c:out value="${returnMap.coTelNum}" /></td>
				<th>회사팩스번호</th>
				<td class="phoneNum"><c:out value="${returnMap.coFaxNum}" /></td>
			</tr>

			<tr>
				<th>담 당 자</th>
				<td colspan="3">
					<table style="width: 100%; height: 100%;">
						<tr>
							<td width="150px" style="border: 0">□ 부서 :&nbsp;
								<c:out value="${returnMap.membDeptnm}" />
							</td>
							<td width="150px" style="border: 0">□ 직위 :&nbsp;
								<c:out value="${returnMap.membPosition}" /></td>
							<td width="150px" style="border: 0">□ 성명 :&nbsp;
								<c:out value="${returnMap.membNm}" /></td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<th>회사홈페이지</th>
				<td><c:out value="${returnMap.homeAddr}" /> </td>
				<th>담당자 E-Mail</th>
				<td><c:out value="${returnMap.membEmail}" /></td>
			</tr>

			<tr>
				<th>주요 수출국가</th>
				<td colspan="3"><c:out value="${returnMap.mainexpnation}" /></td>
			</tr>

			<tr>
				<th>주요 수출품목</th>
				<td colspan="3"><c:out value="${returnMap.productname}" /> </td>
			</tr>

			<tr>
				<th>융자금 신청금액</th>
				<td colspan="3"><c:out value="${returnMap.necessAmount}" /> (원)</td>
			</tr>

		</table>



			<%-- <c:when test='${yearChk eq "Y"}'> --%>

				<TABLE class="formTable">

					<COLGROUP>
						<COL width="53px">
						<COL width="220px">
						<COL width="170px">
						<COL width="329px">
					</COLGROUP>


					<tr>
						<th rowspan="14" align="center">□<br />신<br />청<br />내<br />역</th>
						<th align="center" colspan="2">해상/항공운임 특별융자 자금 사용계획</th>
						<th align="right">(단위 : 원)</th>
					</tr>
					<tr>
						<th align="center" >자금용도</th>
						<th align="center" >예상소요금액 (단위: 원)</th>
						<th align="center" >대상국가 및 품목</th>
					</tr>
					<tr>
						<th >수출해상운임</th>
						<td align="right" ><c:out value="${returnMap.spePlancd11amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd1Nationitem}"/></td>
					</tr>
					<tr>
						<th >수출항공운임</th>
						<td align="right" ><c:out value="${returnMap.spePlancd21amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd2Nationitem}"/></td>
					</tr>
					<tr>
						<th >수출용 원자재 수입 해상운임</th>
						<td align="right" ><c:out value="${returnMap.spePlancd31amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd2Nationitem}"/></td>
					</tr>
					<tr>
						<th >수출용 원자재 수입 항공운임</th>
						<td align="right" ><c:out value="${returnMap.spePlancd41amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd4Nationitem}"/></td>
					</tr>
					<tr>
						<th >수출용 내륙운송운임</th>
						<td align="right" ><c:out value="${returnMap.spePlancd51amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd5Nationitem}"/></td>
					</tr>
					<tr>
						<th >기타</th>
						<td align="right" ><c:out value="${returnMap.spePlancd61amt}"/></td>
						<td ><c:out value="${returnMap.spePlancd6Nationitem}"/></td>
					</tr>
					<tr>
						<th >합계</th>
						<td align="right" ><c:out value="${returnMap.speSumPlancd1amt}"/></td>
						<td ></td>
					</tr>
				</TABLE>

		<TABLE cellspacing="0" cellpadding="0" width="750px" style="" class="">
			<tr height="30px">
				<td></td>
			</tr>
		</TABLE>

<c:if test="${not empty  returnMap.planDesc }" >

		<p style="page-break-before: always;">
		<table>
			<tr>
				<td>□ 상기의 무역기금 수출마케팅자금 사용계획에 대해 구체적으로 기술하여 주시기 바랍니다.</td>
			</tr>
		</table>


		<TABLE
			style="border-left: #88a2c0 solid 1px; border-bottom: #88a2c0 solid 1px; border-right: #88a2c0 solid 1px; border-top: #88a2c0 solid 1px;">
			<tr height="900px">
				<td style="padding-top: 10px; padding-left: 10px;" valign="top">
					<c:out value="${common:reverseXss(returnMap.planDesc)}" escapeXml="false" />
				</td>
			</tr>
			<tr>
				<td style="padding-left: 10px; border-top: #88a2c0 solid 1px;">본사는 무역기금 수출마케팅자금을 융자받고자 사용계획서를 제출합니다.</td>
			</tr>
			<tr>
				<c:choose>
					<c:when test='${returnMap.applyId eq "BS201711107"}'>
						<td align="right" style="padding-right: 30px;">2017년 11월 10일</td>
					</c:when>
					<c:when test='${returnMap.applyId eq "SU201803157"}'>
						<td align="right" style="padding-right: 30px;">2018년 3월 10일</td>
					</c:when>
					<c:otherwise>
						<td align="right" style="padding-right: 30px;">
							<c:out value="${returnMap.year}" />년
							<c:out value="${returnMap.mm}" />월
							<c:out value="${returnMap.dd}" />일</td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<td align="right" style="font-size: 15px; font: bold; padding-right: 30px;">신청인(대표자)
					<c:out value="${returnMap.ceoNmKor}" /> (인)
				</td>
			</tr>
			<tr>
				<td style="padding-left: 10px; font-size: 20px; font: bold;">한국무역협회 회장 귀중</td>
			</tr>
		</TABLE>

		<table class="mt-10">
			<tr height="25px">
				<td style="padding-left: 10px;">(註) 기재사항이 부족할 경우에는 별지를 사용하여 작성하시기 바랍니다.</td>
			</tr>
		</table>
</c:if>

<c:if test="${not empty returnMap.businessPlan }" >
		<p style="page-break-before: always;">
		<TABLE style="width: 100%;">
			<tr height="60px">
				<td style="font-size: 20px; font: bold;" align="center">사업계획서</td>
			</tr>
		</TABLE>

		<TABLE style="width: 100%;">
			<tr>
				<td align="right">접수번호 : <c:out value="${returnMap.applyId}" /></td>
			</tr>
		</TABLE>

		<TABLE
			style="border-left: #88a2c0 solid 1px; border-bottom: #88a2c0 solid 1px; border-right: #88a2c0 solid 1px; border-top: #88a2c0 solid 1px;">
			<tr height="900px">
				<td style="padding-top: 10px; padding-left: 10px;" valign="top">
					<c:out value="${common:reverseXss(returnMap.businessPlan)}" escapeXml="false" />
				</td>
			</tr>
		</TABLE>
</c:if>
	</div>

</div>

</form>

<script type="text/javascript">
	$(document).ready(function() {

		setExpPhoneNumber(['.phoneNum'], 'R');

		  $(".modal").on("click", function(e){
			   if(!$(e.target).is($(".modal-content, .modal-content *"))){
			    closeLayerPopup();
			   }
		});
	});

	function doFundInquiryPrintPopupPrint() {

		// var initBody;
		var _nbody = null;
		var _body = document.body; //innerHtml 이 아닌 실제 HTML요소를 따로 보관.
		var printDiv = document.createElement("div"); //프린트 할 영역의 DIV 생성(DIV높이 너비 등 설정 편하게 하기 위한 방법)

		window.onbeforeprint = function() {
			// initBody = document.body.innerHTML;

			// 프린트하는 영역도 아닌데 이를 숨기는 의도를 잘 모르겠습니다.
			//              document.getElementsByClassName('btn_group')[0].style.display = "none";
			$('#btn_group').hide();
			document.getElementById("printTable").style.height = "60%";
			document.getElementById("printTable").style.maxWidth = "100%";

			// 굳이 클래스네임은 선언하지 않아도 됩니다.
			//             printDiv.className = "IBSheet_PrintDiv";
			var val = document.getElementById('printTable').innerHTML;
			document.body = _nbody = document.createElement("body");
			_nbody.appendChild(printDiv);
			printDiv.innerHTML = val; //프린트 할 DIV에 필요한 내용 삽입.
		};
		window.onafterprint = function() {
			// 프린트 후 printDiv 삭제.
			_nbody.removeChild(printDiv);
			// body영역 복원
			document.body = _body;
			//이젠 필요없으니 삭제.
			_nbody = null;
			// 아까 위에서 숨겼던 버튼들 복원.
			//              document.getElementsByClassName('btn_group')[1].style.display = "";
			$('#btn_group').show();
		};
		window.print();
	}

	//닫기
	function doClear() {
		closeLayerPopup();
	}
</script>