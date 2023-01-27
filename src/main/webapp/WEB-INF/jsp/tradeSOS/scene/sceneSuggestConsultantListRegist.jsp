<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval var="serverName" expression="@variables.getProperty('variables.serverName')" />
<c:set var="profile"><spring:eval expression="@environment.getProperty('spring.profiles.active')" /></c:set>

<!-- 페이지 위치 -->
<div class="location">
	<!-- 네비게이션 -->
	<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
	<!-- 네비게이션 -->
	<div class="ml-auto">
		<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="fnSubmit('tmp');">임시저장</button>
		<button type="button" class="btn_sm btn_primary btn_modify_auth" onclick="fnSubmit('save');">저장</button>
	</div>
	<div class="ml-15">
	   <button type="button" class="btn_sm btn_secondary" onclick="fn_list();">목록</button>
	</div>
</div>

<div class="page_tradesos">
	<form name="submitForm" id="submitForm" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="applyEmail" value=""/>
		<input type="hidden" name="tempSaveYn" id="tempSaveYn" value="N"/>
		<input type="hidden" name="eventSdcit" value=""/>

		<div class="cont_block">
		<!-- 타이틀 영역 -->
		<div class="tit_bar">
			<h3 class="tit_block">회사정보</h3>
		</div>
		<table class="boardwrite formTable">
			<colgroup>
				<col style="width:12%">
				<col>
				<col style="width:12%">
				<col>
				<col style="width:12%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">사업자구분 <strong class="point">*</strong></th>
					<td colspan="5">
						<label class="label_form">
							<input type="radio" name="licenseYn" id="radio1_1" class="form_radio" value="Y" <c:if test="${ not empty resultData.companyNo}">checked</c:if> checked> <span for="radio1_1" class="label">기업</span>
						</label>
						<label class="label_form">
							<input type="radio" name="licenseYn" id="radio1_2" class="form_radio" value="N"> <span for="radio1_2" class="label" <c:if test="${ empty resultData.companyNo}">checked</c:if>>예비창업자</span>
						</label>
					</td>
				</tr>
				<tr>
					<th scope="row">회사명 <strong class="point">*</strong></th>
					<td>
						<div class="field_set flex align_center">
							<span class="form_search w100p">
								<input class="input form_text w100p" type="text" name="company" id="company" onkeydown="onEnter(fnCompanySearch, 1);" value="<c:out value="${resultData.company}"/>">
								<button type="button" class="btnSchOpt find btn_icon btn_search" onclick="fnCompanySearch('1');" title="검색"></button>
							</span>
						</div>
					</td>
					<th scope="row"> 무역업고유번호 <strong class="point" id="licenseChk">*</strong></th>
					<td>
						<div class="flex align_center">
							<span class="form_search w100p">
								<input type="text" name="tradeNo" id="tradeNo" class="form_text w100p" onkeypress="fnNumber(this)" onkeydown="onEnter(fnCompanySearch, 2);" value="<c:out value="${resultData.tradeNo}"/>">
								<button type="button" class="btnSchOpt find btn_icon btn_search" onclick="fnCompanySearch('2');" title="검색"></button>
							</span>
						</div>
					</td>
					<th scope="row"> 대표자 <strong class="point">*</strong></th>
					<td>
						<input type="text"  name="companyPresident" class="form_text w100p" value="<c:out value="${resultData.companyPresident}"/>">
					</td>
				</tr>
				<tr>
					<th scope="row"> 사업자등록번호 <strong class="point" id="licenseChk2">*</strong></th>
					<td>
						<div class="flex align_center">
							<span class="form_search w100p">
								<input type="text" id="companyNo" name="companyNo" class="form_text w100p" onkeypress="fnNumber(this)" onkeydown="onEnter(fnCompanySearch, 3);" value="<c:out value="${resultData.companyNo}"/>">
								<button type="button" class="btnSchOpt find btn_icon btn_search" onclick="fnCompanySearch('3');" title="검색"></button>
							</span>
						</div>
					</td>
							<th scope="row">대표전화</th>
					<td>
						<input type="text"  name="companyTel" class="form_text w100p" value="<c:out value="${resultData.companyTel}"/>">
					</td>
					<th scope="row">FAX</th>
					<td>
						<input type="text"  name="companyFax" class="form_text w100p" value="<c:out value="${resultData.companyFax}"/>">
					</td>
				</tr>
				<tr>
					<th scope="row">회사주소 <strong class="point">*</strong></th>
					<td colspan="5">
						<input type="text"  name="companyAddr" class="form_text w100p" value="<c:out value="${resultData.companyAddr}"/>">
					</td>
				</tr>
			</tbody>
		</table><!-- // 회사정보 등록 테이블-->
	</div>

	<div class="cont_block">
		<!-- 타이틀 영역 -->
		<div class="tit_bar">
			<h3 class="tit_block">신청내역</h3>
		</div>
		<table class="boardwrite formTable">
			<colgroup>
				<col style="width:12%">
				<col>
				<col style="width:12%">
				<col>
				<col style="width:12%">
				<col>
			</colgroup>
				<tbody>
					<tr>
						<th scope="row">접수경로 <strong class="point">*</strong></th>
						<td colspan="5">
							<select name="routeCd" class="form_select">
								<c:forEach var="data" items="${code037}" varStatus="status">
									<option value="<c:out value="${data.cdId}"/>" <c:out value="${resultData.routeCd eq data.cdId ? 'selected' : ''}"/>><c:out value="${data.cdNm}"/></option>
								</c:forEach>
								<option value="999" <c:out value="${resultData.routeCd eq '999' ? 'selected' : ''}"/>>직접입력</option>
							</select>
							<input type="text"  name="routeNm" class="form_text w50p" style="display: none;" value="<c:out value="${resultData.routeNm}"/>">
						</td>
					</tr>
					<tr>
						<th scope="row">이름 <strong class="point">*</strong></th>
						<td>
							<input type="text"  name="applyName" class="form_text w100p" value="<c:out value="${resultData.applyName}"/>">
						</td>
						<th scope="row">직책</th>
						<td>
							<div class="flex align_center form_row">
								<select name="applyGradeCd" class="form_select w40p">
									<option value="999">직접입력</option>
									<c:forEach var="data" items="${code099}" varStatus="status">
										<option value="<c:out value="${data.cdNm}"/>" <c:out value="${resultData.applyGrade eq data.cdNm ? 'selected' : ''}"/>><c:out value="${data.cdNm}"/></option>
									</c:forEach>
								</select>
								<input type="text" name="applyGrade" class="form_text" value="<c:out value="${resultData.applyGrade}"/>">
							</div>
						</td>
						<th scope="row">부서</th>
						<td>
							<input type="text"  name="applyDepart" class="form_text w100p" value="<c:out value="${resultData.applyDepart}"/>">
						</td>
					</tr>
					<tr>
						<th scope="row">휴대폰 <strong class="point">*</strong></th>
						<td>
			<%--			<div class="flex align_center">
							<select name="applyCell1"  class="form_select">
								<c:forEach var="data" items="${code132}" varStatus="status">
									<option value="${data.cdId}" <c:out value="${fn:split(resultData.applyCell,'-')[0] eq data.cdId ? 'selected' : ''}"/>>${data.cdNm}</option>
								</c:forEach>
							</select>
							<input type="text"  name="applyCell2" class="form_text w100p ml-8" onkeypress="fnNumber(this)" maxlength="4" value="<c:out value="${fn:split(resultData.applyCell,'-')[1]}"/>">
							<input type="text"  name="applyCell3" class="form_text w100p ml-8" onkeypress="fnNumber(this)" maxlength="4" value="<c:out value="${fn:split(resultData.applyCell,'-')[2]}"/>">
						</div>--%>
							<input type="text"  name="applyCell" class="form_text w100p" value="<c:out value="${resultData.applyCell}"/>">
						</td>
						<th scope="row">전화번호 <strong class="point">*</strong></th>
						<td>
							<input type="text"  name="applyTel" class="form_text w100p" value="<c:out value="${resultData.applyTel}"/>">
						</td>
						<th scope="row">상담(방문)지역 <strong class="point">*</strong></th>
						<td>
							<select name="hopeCityCd"  class="form_select w100p">
								<option value="" selected="">선택</option>
								<c:forEach var="data" items="${code012}" varStatus="status">
									<option value="<c:out value="${data.cdId}"/>" <c:out value="${resultData.hopeCityCd eq data.cdId ? 'selected' : ''}"/>><c:out value="${data.cdNm}"/></option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">자문분야 <strong class="point">*</strong></th>
						<td>
							<select name="sect"  class="form_select w100p">
								<option value="" selected="">선택</option>
								<c:forEach var="data" items="${code029}" varStatus="status">
									<option value="<c:out value="${data.cdId}"/>" <c:out value="${resultData.sect eq data.cdId ? 'selected' : ''}"/>><c:out value="${data.cdNm}"/></option>
								</c:forEach>
							</select>

						</td>
						<th scope="row">이메일 <strong class="point">*</strong></th>
						<td colspan="3">
							<input type="text"  name="applyEmail1" class="form_text" value="<c:out value="${fn:split(resultData.applyEmail,'@')[0]}"/>">
							@
							<input type="text"  name="applyEmail2" class="form_text" value="<c:out value="${fn:split(resultData.applyEmail,'@')[1]}"/>">
							<select id="selectEmail" class="form_select">
								<option value="">직접입력</option>
								<c:forEach var="data" items="${code070}" varStatus="status">
									<option value="${data.cdNm}" <c:out value="${fn:split(resultData.applyEmail,'@')[1] eq data.cdNm ? 'selected' : ''}"/>>${data.cdNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">해외진출시장 <strong class="point">*</strong></th>
						<td colspan="5">
							<c:forEach var="data" items="${relCode}" varStatus="status">
								<label class="label_form">
									<input type="checkbox" name="relCd" class="form_checkbox" value="<c:out value="${data.relCode}"/>" <c:out value="${fn:contains(resultData.relCd, data.relCode) ? 'checked' : ''}"/>>
									<span class="label"><c:out value="${data.relName}"/></span>
								</label>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<tr>
						<th scope="row">취급품목 <strong class="point">*</strong></th>
						<td colspan="5">
							<div class="form_row">
								<select name="mti_1_code" id="mti_1_code" class="form_select" onchange="setMitCode(this.value, '')">
									<option value="">선택</option>
									<c:forEach var="data" items="${mtiCode}" varStatus="status">
										<option value="${data.mtiCode}" <c:out value="${fn:substring(resultData.item, 0, 1) eq data.mtiCode ? 'selected' : ''}"/>>${data.mtiNameKor}</option>
									</c:forEach>
								</select>
								<select  name="item" id="item" class="form_select ml-8">
									<option value="">선택</option>
								</select>
								<span class="form_search ml-8">
									<input type="text" id="itemEtc" name="itemEtc" class="form_text ml-8" value="<c:out value="${resultData.itemEtc}"/>">
									<button type="button" class="btn_icon btn_search" onclick="openLayerItemPop();"></button>
								</span>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">컨설팅 신청 제목 <strong class="point">*</strong></th>
						<td colspan="5">
							<input type="text" name="title" class="form_text w100p" value="<c:out value="${resultData.title}" escapeXml="false"/>">
						</td>
					</tr>
					<tr>
						<th scope="row">신청내용 <strong class="point">*</strong></th>
						<td colspan="5">
							<textarea  name="regContent" rows="3" class="form_textarea"><c:out value="${resultData.regContent}" escapeXml="false"/></textarea>
						</td>
					</tr>
					<c:if test="${not empty fileList}">
					<tr>
						<th>첨부파일 목록</th>
						<td colspan="5">
							<div id="attachFieldList">
							<c:forEach var="fileResult" items="${fileList}" varStatus="status">
								<div class="addedFile" id="${fileResult.attachSeqNo}">
									<a href="javascript:doDownloadFile('${fileResult.attachDocumId}', '${fileResult.attachSeqNo}');" class="filename">
										${fileResult.attachDocumNm}
									</a>
									<a href="javascript:doDeleteFile('${fileResult.attachDocumId}', '${fileResult.attachSeqNo}', '006');" class="btn_del">
										<img src="<c:url value="/images/admin/ico_btn_delete.png" />" alt="삭제" />
									</a>
								</div>
								<button type="button" onclick="viewer.showFileContents('${serverName}/tradeSOS/scene/tradeSOSFileDownload.do?attachDocumId=${fileResult.attachDocumId}&attachSeqNo=${fileResult.attachSeqNo}', '${fileResult.attachDocumNm}', 'membershipexpert_${profile}_${fileResult.attachDocumId}_${fileResult.attachSeqNo}');" class="file_preview btn_tbl_border">
									<img src="<c:url value="/images/admin/ico_search_gray.png" />" alt="미리보기" /> 미리보기
								</button>
							</c:forEach>
							</div>
						</td>
					</tr>
					</c:if>
					<tr>
						<th scope="row">첨부파일</th>
						<td colspan="5">
							<div class="mb5px flex">
								<div class="form_file">
									<p class="file_name">첨부파일을 선택하세요</p>
									<label class="file_btn">
										<input type="file" id="attachFile" name="attachFile" class="txt attachment" title="첨부파일" />
										<input type="hidden" name="attachFileSeq" value="1" />
										<span class="btn_tbl">찾아보기</span>
									</label>
								</div>
								<button type="button" onclick="doAddAttachField();" class="btn_tbl_border">추가</button>
							</div>
							<div id="attachFieldEdit"></div>
						</td>
					</tr>
				</tbody>
		</table><!-- // 신청내역 등록 테이블-->
	</div>

	<div class="cont_block">
		<!-- 타이틀 영역 -->
		<div class="tit_bar">
			<h3 class="tit_block">컨설팅 내역</h3>
		</div>
		<table class="formTable">
			<colgroup>
				<col style="width:12%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">상담방법 <strong class="point">*</strong></th>
					<td>
						<label class="label_form">
							<input type="radio" name="gubun" id="radio2_1" class="form_radio" value="010" <c:out value="${resultData.gubun eq '010' ? 'checked' : ''}"/> checked> <span for="radio2_1" class="label">현장방문</span>
						</label>
						<label class="label_form">
							<input type="radio" name="gubun" id="radio2_2" class="form_radio" value="020" <c:out value="${resultData.gubun eq '020' ? 'checked' : ''}"/>> <span for="radio2_2" class="label">전화 및 온라인</span>
						</label>
					</td>
					<th scope="row">담당위원</th>
					<td><c:out value="${resultData.expertNm}"/></td>
				</tr>
				<tr>
					<th scope="row">상담내용 <strong class="point">*</strong></th>
					<td colspan=3">
						<textarea  name="content" rows="20" class="form_textarea"><c:out value="${resultData.content}" escapeXml="false"/></textarea>
					</td>
				</tr>
				<tr>
					<th scope="row">규제 접수 내용</th>
					<td colspan=3">
						<textarea  name="content2" rows="2" class="form_textarea"><c:out value="${resultData.content2}" escapeXml="false"/></textarea>
					</td>
				</tr>
			</tbody>
		</table><!-- // 컨설팅 내역 등록 테이블-->
	</div>
	</form>

	<!-- //등록 테이블-->
	<!--<div class="btn_group mt-20 _center">
		<button type="button" class="btn btn_primary" onclick="fnSubmit('tmp');">임시저장</button>
		<button type="button" class="btn btn_primary" onclick="fnSubmit('save');">등록</button>
		<button type="button" class="btn btn_secondary" onclick="fn_list();">취소</button>
	</div>-->

	<form id="searchForm">
		<input type="hidden" name="pageIndex" value="<c:out value="${searchVO.pageIndex}"/>"/>
		<input type="hidden" name="no" value=""/>
		<input type="hidden" name="frDt" value="<c:out value="${searchVO.frDt}"/>"/>
		<input type="hidden" name="toDt" value="<c:out value="${searchVO.toDt}"/>"/>
		<input type="hidden" name="title" value="<c:out value="${searchVO.title}"/>"/>
		<input type="hidden" name="content" value="<c:out value="${searchVO.content}"/>"/>
		<input type="hidden" name="searchCondition" value="<c:out value="${searchVO.searchCondition}"/>"/>
		<input type="hidden" name="searchKeyword" value="<c:out value="${searchVO.searchKeyword}"/>"/>
		<input type="hidden" name="searchKeyword2" value="<c:out value="${searchVO.searchKeyword2}"/>"/>
		<input type="hidden" name="applyName" value="<c:out value="${searchVO.applyName}"/>"/>
		<input type="hidden" name="expertNm" value="<c:out value="${searchVO.expertNm}"/>"/>
		<input type="hidden" name="sect" value="<c:out value="${searchVO.sect}"/>"/>
		<input type="hidden" name="item" value="<c:out value="${searchVO.item}"/>"/>
		<input type="hidden" name="mtiCode" value="<c:out value="${searchVO.mtiCode}"/>">
		<input type="hidden" name="mtiUnit" value="<c:out value="${searchVO.mtiUnit}"/>">
		<input type="hidden" name="status" value="<c:out value="${searchVO.status}"/>"/>
	</form>

</div> <!-- // .page_tradesos -->



<script type="text/javascript">
	$(document).ready(function(){
		$("#selectEmail").on("change",function(){
			$("input[name=applyEmail2]").val($(this).val());
		})

		//사업자구분에 따른 변경
		$("input[name=licenseYn]").on("change",function() {

			if ($("input[name=licenseYn]:checked").val() == "N") {
				$("#licenseChk").hide();
				$("#licenseChk2").hide();
			} else {
				$("#licenseChk").show();
				$("#licenseChk2").show();
			}
		});

		$("select[name=routeCd]").on("change",function(){
			if ($(this).val() == '999'){
				$("input[name=routeNm]").show();
			}else{
				$("input[name=routeNm]").val("");
				$("input[name=routeNm]").hide();
			}
		});

		$("#selectEmail").on("change",function(){
			$("input[name=applyEmail2]").val($(this).val());
		});

		$("select[name=applyGradeCd]").on("change",function(){
			if ($(this).val() == '999'){
				$("input[name=applyGrade]").attr('readonly', false);
			} else {
				$("input[name=applyGrade]").val("");
				$("input[name=applyGrade]").attr('readonly', true);
				$("input[name=applyGrade]").val($(this).val());
			}
		});

		setMitCode('<c:out value="${fn:substring(resultData.item, 0, 1)}"/>','<c:out value="${fn:substring(resultData.item, 0, 2)}"/>'); //취급품목 2레벨 세팅
	});

	function fn_list() {
		$("#searchForm").attr("action", "/tradeSOS/scene/sceneSuggestConsultantList.do");
		$("#searchForm").submit();
	}

	// 회사명&무역업고유번호&사업자등록번호 검색 Popup
	function fnCompanySearch(searchKeyword) {
		global.openLayerPopup({
			popupUrl : '<c:url value="/tradeSOS/popup/coSearchPopup.do" />'
		  , params : {
				       'searchKeyword' : searchKeyword
				      ,
				     }
			, callbackFunction : function(resultObj){

				$("input[name=company]").val(resultObj.companyKor);
				$("input[name=tradeNo]").val(resultObj.memberId);
				$("input[name=companyPresident]").val(resultObj.presidentKor);
				$("input[name=companyNo]").val(resultObj.enterRegNo);
				$("input[name=companyTel]").val(resultObj.telEtc);
				$("input[name=companyFax]").val(resultObj.faxEtc);
				$("input[name=companyAddr]").val(resultObj.korAddr1 + " " + resultObj.korAddr2);


				getLastDataInfo(resultObj.enterRegNo);

			}
		});
	}


	function getLastDataInfo (enterRegNo){

		global.ajaxSubmit($('#submitForm'), {
			  type : 'POST'
			, url : '<c:url value="/tradeSOS/scene/companyHistory.do" />'
			, data :  {companyNo: enterRegNo}
			, dataType : 'json'
			, async : false
			, spinner : true
			, success : function(data) {
				console.log(data.resultData);
				if(data.resultData != null) {
					console.log(data.resultData.no);

					if (confirm("최근 신청내역을 불러오시겠습니까?")) {
						$("input[name=no]").val(data.resultData.no);

						$("#searchForm").attr("action", "/tradeSOS/scene/sceneSuggestConsultantListRegist.do");
						$("#searchForm").submit();
					}
				}
			}
		});
	}

	// 취급품목(팝업)
	function openLayerItemPop(){
		//기본값 초기화
		$('#searchUnit').val('6');
		$('#mtiCode').val('');
		$('#item').data('unit','0');

		//품목별 초기화 추가
		$('#searchMtiNmPop').val('');

		global.openLayerPopup({
				popupUrl : '/tradeSOS/popup/itemSearchPopup.do'
			, callbackFunction : function(resultObj) {

			}
		});

	}

	// 취급품목 SELECT BOX
	function setMitCode(val, val2){
		if (val ==""){
			$("select[name=item]").empty();
			$("select[name=item]").append("<option value=''>선택</option>");
			return;
		}

		$.ajax({
			type:"post",
			url:"/tradeSOS/scene/sceneSuggestStatAdviceMtiCodeListAjax.do",
			data: { mtiCode : val},
			success:function(data){
				$("select[name=item]").empty();
				var optionList = data.resultList;
				var option = "";

				$("select[name=item]").append("<option value=''>선택</option>");
				for (var i = 0 ; i < optionList.length ; i++){
					var selectedText = "";

					if (optionList[i].mtiCode == val2){
						selectedText = "selected";
					}

					option = $("<option value='"+optionList[i].mtiCode+"' "+selectedText+">"+optionList[i].mtiNameKor+"</option>");
					$("select[name=item]").append(option);
				}
			}
		});
	}

	// 계층형
	function selectArr() {

		var chkRow = tblSheet.FindCheckedRow('sCheckBox',{ReturnArray:1});
		var mtiCode;
		var mtiName;
		if(1 > chkRow.length) {
			alert("품목을 선택해주세요.");
			return;
		}

		if (tblSheet.GetCellValue(chkRow, 'mtiUnit') < 2) {
			alert("2레벨 이상 선택 가능 합니다.");
			return;
		}

		for(var i=0; i < chkRow.length; i++){
			if (i == 0){
				mtiCode = tblSheet.GetCellValue( chkRow, 'mtiCode');
				mtiName = tblSheet.GetCellValue( chkRow, 'mtiNameKor');
			}else{
				mtiCode += ","+tblSheet.GetCellValue( chkRow, 'mtiCode');
				mtiName += ","+tblSheet.GetCellValue( chkRow, 'mtiNameKor');
			}
		}

		$("input[name=itemEtc]").val(mtiName);

		closeLayerPopup();
	}

	//키워드형
	function selectAllArrX(){

		var chkRow2 = tblSheet2.FindCheckedRow('sCheckBox',{ReturnArray:1});			//체크된 행 배열
		var mtiCode;
		var mtiName;

		if(1 > chkRow2.length) {
			alert("품목을 선택해주세요.");
			return;
		}
		if (tblSheet2.GetCellValue(chkRow2, 'mtiUnit') < 2) {
			alert("2레벨 이상 선택 가능 합니다.");
			return;
		}

		for(var i=0; i < chkRow2.length; i++){
			if (i == 0){
				mtiCode = tblSheet2.GetCellValue( chkRow2, 'mtiCode');
				mtiName = tblSheet2.GetCellValue( chkRow2, 'mtiNameKor');
			}else{
				mtiCode += ","+tblSheet2.GetCellValue( chkRow2, 'mtiCode');
				mtiName += ","+tblSheet2.GetCellValue( chkRow2, 'mtiNameKor');
			}
		}
		$("input[name=itemEtc]").val(mtiName);

		closeLayerPopup();
	}

	var submitFlag = true;
	function fnSubmit(op){
		var msg = '';

		if (op == 'tmp'){
			$("#tempSaveYn").val('Y');
			msg = "임시저장 하시겠습니까?";
		}else{
			$("#tempSaveYn").val('N');
			msg = "등록 하시겠습니까?";
		}
		var form = document.submitForm;

		var applyCell;
		var applyEmail;

		if ($("input[name=company]").val().trim() == ""){
			alert("회사명을 입력해주세요.");
			$("input[name=company]").focus();
			return;
		}
		if (fc_chk_byte2(form.company, 120, "회사명은") == false){
			return;
		}
		if ($("input[name=licenseYn]:checked").val() == "Y") {
			if ($("input[name=tradeNo]").val().trim() == "") {
				alert("무역업고유번호를 입력해주세요.");
				$("input[name=tradeNo]").focus();
				return;
			} else if (fc_chk_byte2(form.tradeNo, 20, "무역업번호는") == false) {
				return;
			} else if ($("input[name=companyNo]").val().trim() == "") {
				alert("사업자등록번호를 입력해주세요.");
				$("input[name=companyNo]").focus();
				return;
			} else if (fc_chk_byte2(form.companyNo, 20, "사업자등록번호는") == false) {
				return;
			}
		}
		if ($("input[name=companyPresident]").val().trim() == ""){
			alert("대표자를 입력해주세요.");
			$("input[name=companyPresident]").focus();
			return;
		}
		if (fc_chk_byte2(form.companyPresident, 100, "대표자는") == false) {
			return;
		}
		if ($("input[name=companyAddr]").val().trim() == ""){
			alert("회사주소를 입력해주세요.");
			$("input[name=companyAddr]").focus();
			return;
		}
		if (fc_chk_byte2(form.companyAddr, 200, "회사주소는") == false) {
			return;
		}
		if (op == 'save'){
			if ($("select[name=routeCd]").val() == ""){
				alert("접수경로를 입력해주세요.");
				$("select[name=routeCd]").focus();
				return;
			}
			if ($("input[name=applyName]").eq(0).val().trim() == ""){
				alert("이름을 입력해주세요.");
				$("input[name=applyName]").eq(0).focus();
				return;
			}
			if (fc_chk_byte2(form.applyName, 20, "이름은") == false) {
				return;
			}
			if ($("select[name=applyCell]").val() == ""){
				alert("휴대폰번호를 입력해주세요.");
				$("select[name=applyCell]").focus();
				return;
			}
			/*if ($("input[name=applyCell2]").val().trim() == ""){
				alert("휴대폰번호를 입력해주세요.");
				$("input[name=applyCell2]").focus();
				return;
			}
			if ($("input[name=applyCell3]").val().trim() == ""){
				alert("휴대폰번호를 입력해주세요.");
				$("input[name=applyCell3]").focus();
				return;
			}
			if ($("select[name=applyCell1]").val() != "" && $("input[name=applyCell2]").val().trim() != "" && $("input[name=applyCell3]").val().trim() != ""){
				applyCell = $("select[name=applyCell1]").val()+"-"+$("input[name=applyCell2]").val()+"-"+$("input[name=applyCell3]").val();
				if (!fnPhoneValidation(applyCell)){
					alert("휴대폰을 형식에 맞게 입력해 주세요.");
					$("select[name=applyCell1]").focus();
					return;
				}else{
					$("input[name=applyCell]").val(applyCell);
				}
			}*/
			if ($("input[name=applyTel]").val().trim() == ""){
				alert("전화번호를 입력해주세요.");
				$("input[name=applyTel]").focus();
				return;
			}
			if ($("input[name=applyEmail1]").val().trim() == ""){
				alert("이메일을 입력해주세요.");
				$("input[name=applyEmail1]").focus();
				return;
			}
			if ($("input[name=applyEmail2]").val().trim() == ""){
				alert("이메일을 입력해주세요.");
				$("input[name=applyEmail2]").focus();
				return;
			}
			if ($("input[name=applyEmail1]").val().trim() != "" && $("input[name=applyEmail2]").val().trim() != ""){
				applyEmail = $("input[name=applyEmail1]").val()+"@"+$("input[name=applyEmail2]").val();
				if(!checkEmail(applyEmail)){
					alert("이메일을 형식에 맞게 입력해 주세요.");
					$("input[name=applyEmail1]").focus();
					return;
				}else{
					$("input[name=applyEmail]").val(applyEmail);
				}
			}
			if ($("select[name=hopeCityCd]").val() == ""){
				alert("상담(방문)지역을 선택해주세요.");
				$("select[name=hopeCityCd]").focus();
				return;
			}
			if ($("select[name=sect]").val() == ""){
				alert("자문분야를 선택해주세요.");
				$("select[name=sect]").focus();
				return;
			}
			if ($("input[name=relCd]:checked").length == 0){
				alert("해외진출시장을 선택해주세요.");
				$("input[name=relCd]").focus();
				return;
			}
			if ($("select[name=item] :selected").val() == ""){
				alert("취급품목을 선택해주세요.");
				$("input[name=item]").focus();
				return;
			}
			if ($("input[name=title]").val().trim() == ""){
				alert("컨설팅신청제목을 입력해주세요.");
				$("input[name=title]").focus();
				return;
			}
			if (fc_chk_byte2(form.title, 200, "컨설팅신청제목은") == false) {
				return;
			}
			if ($("textarea[name=regContent]").val().trim() == ""){
				alert("신청내용을 입력해주세요.");
				$("textarea[name=regContent]").focus();
				return;
			}
			if ($("textarea[name=content]").val().trim() == ""){
				alert("상담내용을 입력해주세요.");
				$("textarea[name=content]").focus();
				return;
			}
			if(fc_chk_byte3(form.content, 500, '상담내용은') == false){
				$("textarea[name=content]").focus();
				return;
			}
			if (fc_chk_byte2(form.content, 4000, "상담내용은") == false) {
				return;
			}
		}else{
			if ($("select[name=applyCell1]").val() != "" && $("input[name=applyCell2]").val().trim() != "" && $("input[name=applyCell3]").val().trim() != ""){
				applyCell = $("select[name=applyCell1]").val()+"-"+$("input[name=applyCell2]").val()+"-"+$("input[name=applyCell3]").val();
				if (!fnPhoneValidation(applyCell)){
					alert("휴대폰을 형식에 맞게 입력해 주세요.");
					$("select[name=applyCell1]").focus();
					return;
				}else{
					$("input[name=applyCell]").val(applyCell);
				}
			}
			if ($("input[name=applyEmail1]").val().trim() != "" && $("input[name=applyEmail2]").val().trim() != ""){
				applyEmail = $("input[name=applyEmail1]").val()+"@"+$("input[name=applyEmail2]").val();
				if(!checkEmail(applyEmail)){
					alert("이메일을 형식에 맞게 입력해 주세요.");
					$("input[name=applyEmail1]").focus();
					return;
				}else{
					$("input[name=applyEmail]").val(applyEmail);
				}
			}
		}

		if (confirm(msg)) {
			if (submitFlag){
				submitFlag = false;
				$('input[name=eventSdcit]').val("Save"); // 분기
				global.ajaxSubmit($('#submitForm'), {
					type: 'POST'
					, url: '<c:url value="/tradeSOS/scene/sceneSuggestProc.do" />'
					, enctype: 'multipart/form-data'
					, dataType: 'json'
					, async: false
					, spinner: true
					, success: function (data) {
						if( data.MESSAGE != "" ) {
							alert(data.MESSAGE)
							window.location.reload(true);
						} else {
							fn_list();
						}
					}
				});
			}
		}

	}

	function fnPhoneValidation(value) {
		if (/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/.test(value)) {
			return true;
		}
		return false;
	}

	/**
	 * 첨부파일 필드 추가
	 */
	function doAddAttachField() {
		var attachCnt = 0;
		$('input[name="attachFileSeq"]').each(function(){
			attachCnt = $(this).val();
		});

		var attachFileSeq = parseInt(attachCnt) + 1;

		var html = '';
		html += '<div id="field' + attachFileSeq + '" class="mb5px flex mt-5">';
		html += '	<div class="form_file">';
		html += '		<p class="file_name">첨부파일을 선택하세요</p>';
		html += '		<label class="file_btn">';
		html += '			<input type="file" name="attachFile" class="txt" title="첨부파일" />';
		html += '			<input type="hidden" name="attachFileSeq" value="' + attachFileSeq + '" />';
		html += '			<span class="btn_tbl">찾아보기</span>';
		html += '		</label>';
		html += '	</div>';
		html += '	<button type="button" onclick="doDeleteAttachField(\'' + attachFileSeq + '\');" class="btn_tbl_border">삭제</button>';
		html += '</div>';

		$('#attachFieldEdit').append(html);
	}

	/**
	 * ㅊ머부파일 필드 삭제
	 * @param attachFileSeq
	 */
	function doDeleteAttachField(attachFileSeq) {
		$('#field' + attachFileSeq).remove();
	}

	/**
	 *  첨부파일 삭제
	 * @param fileSeq
	 * @param fileSn
	 * @param fileFg
	 */
	function doDeleteFile(fileSeq, fileSn, fileFg) {
		if (confirm('삭제 하시겠습니까?')) {
			global.ajax({
				type : 'POST'
				, url : '<c:url value="/tradeSOS/scene/tradeSOSFileDelete.do" />'
				, data : {
					  attachDocumId :fileSeq
					, attachSeqNo : fileSn
					, attachDocumFg : fileFg
				}
				, dataType : 'json'
				, async : true
				, spinner : true
				, success : function(data){
					$('#' + fileSn).hide();
				}
			});
		}

	}

	function fnNumber(){
		if((event.keyCode<45)||(event.keyCode>57 || event.keyCide > 45 || event.keyCode <48) || (event.keyCode == 47))
			event.returnValue=false;
	}

</script>