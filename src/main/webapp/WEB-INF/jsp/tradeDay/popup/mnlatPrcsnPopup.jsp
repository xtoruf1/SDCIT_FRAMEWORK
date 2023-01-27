<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<style>
.modal-outer{width:100%;}
.modal-content{padding:0;}
.popContinent{height:100%; max-height:100%;}
</style>

<!-- 팝업 타이틀 -->
<div class="flex m_hidden">
	<h2 class="popup_title">참석자 검색</h2>
	<div class="ml-auto">
		<button type="button" class="btn_sm btn_primary" onclick="doSearch();">조회</button>
		<button class="btn_sm btn_secondary" onclick="closePopup();">닫기</button>
	</div>
</div>

<div class="tradeDay_header pc_hidden">
	<div class="inner">
		<h1 class="logo">
			<a href="/main.do">
				<img src="/images/common/logo_tradeday.png" alt="무역지원서비스">
			</a>
		</h1>
		<span class="pc_hidden">무역의 날 기념식 참석자 확인</span>
	</div>
</div>

<div class="popup_body" >
	<!--검색 시작 -->
	<div class="tradeDay_tbl">
		<div class="search">
			<form id="prcsnSearchForm" name="prcsnSearchForm">
				<input type="hidden" id="pageIndex" name="pageIndex" value="<c:out value='${param.pageIndex}' default='1' />" />
				<input type="hidden" name="svrId" value="<c:out value='${svrId}'/>"/>
				<input type="hidden" id="totalCnt" name="totalCnt" value="0" default='0'>
				<input type="hidden" id="qrYn" name="qrYn" value="Y">

				<table class="formTable tradeDay_search">
					<colgroup>
						<col>
						<col>
					</colgroup>
					<tbody>
						<tr class="pc_hidden">
							<th scope="row">검색어</th>
							<td>
								<span class="form_row w100p">
									<input type="text" id="searchKeyword" name="searchKeyword" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${searchKeyword}' />" placeholder="참석자명 또는 전화번호를 입력해주세요."/>
									<button type="button" class="btn_sm btn_primary btn_search" onclick="doSearch();">조회</button>
								</span>
							</td>
						</tr>
						<tr class="m_hidden">
							<th scope="row">회사명</th>
							<td>
								<input type="text" id="companyName" name="companyName" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${companyName}' />"/>
							</td>
							<th scope="row">수상종류</th>
							<td>
								<select name="awardTypeCd" class="form_select w100p">
									<option value="">전체</option>
									<c:forEach var="item" items="${AWD045}" varStatus="status">
										<option value="<c:out value="${item.detailcd}"/>" <c:if test="${item.detailcd}">selected="selected"</c:if> ><c:out value="${item.detailnm}"/></option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr class="m_hidden">
							<th scope="row">수상자명</th>
							<td>
								<input type="text" id="laureateName" name="laureateName" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${laureateName}' />"/>
							</td>
							<th scope="row">수상자연락처</th>
							<td>
								<input type="text" id="laureatePhone" name="laureatePhone" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${laureatePhone}' />"/>
							</td>
						</tr>
						<tr class="m_hidden">
							<th scope="row">참석자명</th>
							<td>
								<input type="text" id="attendName" name="attendName" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${attendName}' />"/>
							</td>
							<th scope="row">참석자연락처</th>
							<td>
								<input type="text" id="attendPhone" name="attendPhone" class="form_text w100p" onkeydown="onEnter(doSearch);" value="<c:out value='${attendPhone}' />"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
		<!--검색 끝 -->
		<div class="m_hidden">
			<div class="w100p mt-20">
				<div id="mnlatPrcsnSearch" class="colPosi mt-20" style="height:420px"></div>
			</div>
		</div>

		<div class="pc_hidden attendee_list">
			<div id='boardList' class="">
			</div>
		</div>
	</div>
	<div class="qrCode_btn pc_hidden">
		<button type="button" class="btn" onclick="closeLayerPopup();">취소</button>
	</div>
</div>
<div class="overlay"></div>

<script type="text/javascript">

	$(document).ready(function() {
		f_Init_tradeSearch();		// 헤더  Sheet 셋팅

	});

	function f_Init_tradeSearch() {

		// 세팅
		var	ibHeader = new IBHeader();

		/** 리스트,헤더 옵션 */
		ibHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize',Page: 300, SearchMode: 4, DeferredVScroll: 1, VScrollMode: 1, MouseHoverMode: 2});
		ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true, HeaderCheck: 0});

		ibHeader.addHeader({Type: 'Status', Header: '상태'           , SaveName: 'status'        , Hidden: true});
		ibHeader.addHeader({Type: "Text",   Header: "포상코드"	    , SaveName: "svrId"		    , Align: "Center"	, Width: 50	    , Edit : false, Hidden: true});
		ibHeader.addHeader({Type: "Text",   Header: "참석자아이디"	, SaveName: "attendId"	    , Align: "Center"	, Width: 50	    , Edit : false, Hidden: true});
		ibHeader.addHeader({Type: "Text",   Header: "회사명"		    , SaveName: "companyName"   , Align: "Left"		, Width: 150	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "사업자번호"      , SaveName: "businessNo"	, Align: "Center"	, Width: 100	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "수상종류"		, SaveName: "awardTypeNm"	, Align: "Center"	, Width: 150	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "수상자명"		, SaveName: "laureateName"	, Align: "Center"	, Width: 100	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "참석구분"		, SaveName: "attendTypeNm"	, Align: "Center"	, Width: 100	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "참석자"		    , SaveName: "attendName"	, Align: "Center"	, Width: 100	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Text",   Header: "연락처"		    , SaveName: "attendPhone"	, Align: "Center"	, Width: 120	, Edit : false	, Ellipsis:1, Cursor:"Pointer"});
		ibHeader.addHeader({Type: "Button", Header: "참석"		    , SaveName: "attendBtnYn"	, Align: "Center"	, Width: 100	, Edit : true	, Ellipsis:1, Cursor:"Pointer", HeaderHtml: "<input type='button' class='btn_tbl_primary' value='참석확인'/>"});
		ibHeader.addHeader({Type: "Button", Header: "참석"		    , SaveName: "attendYn"	    , Align: "Center"	, Width: 100	, Edit : true	, Ellipsis:1, Cursor:"Pointer", Hidden: true});

		if (typeof mnlatPrcsnSearch !== "undefined" && typeof mnlatPrcsnSearch.Index !== "undefined") {
			mnlatPrcsnSearch.DisposeSheet();
		}

		var sheetId = "mnlatPrcsnSearch";
		var container = $("#"+sheetId)[0];
		var div_heigth = $('#mnlatPrcsnSearch')[0].style.height;

		createIBSheet2(container,sheetId, "100%", div_heigth);
		ibHeader.initSheet(sheetId);

	}

	function doSearch() {
		goPage(1);
	}

	function goPage(pageIndex) {
		document.prcsnSearchForm.pageIndex.value = pageIndex;
		getList();
	}

	//참석자 검색
	function getList(){
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/tradeDay/clbrt/mnlatPrcsnPopupList.do" />'
			, data : $('#prcsnSearchForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){

				// IBSheet
				mnlatPrcsnSearch.LoadSearchData({Data: data.resultList});

				// 모바일
				var list = '';
				if(data.resultList.length == 0) {

					list += '<tr>';
					list += '	<td colspan="2" style="text-align: center; height: 100px">등록된 데이터가 없습니다.</td>';
					list += '</tr>';
				} else {
						list += '<table class="tradeDay_formTable">';
						list += '<colgroup>';
						list += '	<col style="width: 30%">';
						list += '	<col style="width: 30%">';
						list += '	<col style="width: 40%">';
						list += '</colgroup>';
						list += '<tboody>';
					for (var i = 0; i < data.resultList.length; i++) {
						list += ' <tr>';
						list += ' 	<td>';
						list +=     	data.resultList[i].companyName +'<br>' + data.resultList[i].businessNo;
						list += ' 	</td>';
						list += ' 	<td>';
						list +=  		data.resultList[i].awardTypeNm +'<br>' + data.resultList[i].laureateName;
						list += ' 	</td>';
						list += ' 	<td class="align_r">';
						if( data.resultList[i].attendBtnYn == "N") {
							list += ' 	    <button class="btn_tbl_primary" onclick="attendeeInfoPopup(' + (i+1) + ');">참석확인</button>';
						} else if( data.resultList[i].attendBtnYn == "D") {
							list += ' 	    <span class="attend">참석불가</span>';
						} else if( data.resultList[i].attendBtnYn == "Y") {
							list += ' 	    <span class="attend">참석</span>';
						}
						list += ' 	</td>';
						list += ' </tr>';
						list += ' <tr>';
						list += ' 	<td>';
						list +=     	data.resultList[i].attendTypeNm;
						list += ' 	</td>';
						list += ' 	<td>';
						list +=     	data.resultList[i].attendName +'<br>';
								        if( data.resultList[i].attendForeignCd == '01') {
						list +=				data.resultList[i].attendJuminNo +'<br>';
										} else {
						list +=				data.resultList[i].passportNo +'<br>';
										}
						list +=           " "+  data.resultList[i].attendPhone;
						list += ' 	</td>';
						list += ' </tr>';
						list += ' <tr class="border"><td>.</td></tr>';
					}
					list += '</tboody>';
					list += '</table>';

				}
				$('#boardList').html(list);

			}
		});

	}

	// 상세 페이지 & 팝업
	function mnlatPrcsnSearch_OnClick(Row, Col, Value) {
		if(mnlatPrcsnSearch.ColSaveName(Col) == "attendBtnYn" && Row > 0) {
			var rowData = mnlatPrcsnSearch.GetRowData(Row);

			attendeeInfoPopup(Row);

		}
	};

	//참석확인 레이어팝업
	function attendeeInfoPopup(row){

		if(mnlatPrcsnSearch.GetCellValue( row, "attendBtnYn") == '참석' || mnlatPrcsnSearch.GetCellValue( row, "attendBtnYn") == '참석불가') {
			//alert("이미 참석이 되었습니다.");
			return false;
		}

		global.openLayerPopup({
			popupUrl : '<c:url value="/tradeDay/clbrt/attendeeInfoPopup.do" />'
			, params : {
				 svrId : mnlatPrcsnSearch.GetCellValue(row, "svrId")
			   , attendId : mnlatPrcsnSearch.GetCellValue(row, "attendId")
			   , attendYn : mnlatPrcsnSearch.GetCellValue(row, "attendYn")
			   , qrCheckYn : 'N'
			}
			, callbackFunction : function(resultObj){

			}
		});
	}

	function mnlatPrcsnSearch_OnSearchEnd(row) {

		// 참석 변경
		for( var i = 1 ; i <= mnlatPrcsnSearch.RowCount(); i++){
			var button = mnlatPrcsnSearch.GetCellValue(i,'attendBtnYn');

			if( button == "Y") {
				button = "참석"
				mnlatPrcsnSearch.InitCellProperty(i, 'attendBtnYn', {Type: "Text"}); // 버튼 -> 텍스트로 변경
				mnlatPrcsnSearch.SetCellValue(i, 'attendBtnYn', button); // 값 변경
				mnlatPrcsnSearch.SetCellEditable(i, 'attendBtnYn', 0); // 편집 불가

			} else if( button == "D") {
				button = "참석불가"
				mnlatPrcsnSearch.InitCellProperty(i, 'attendBtnYn', {Type: "Text"}); // 버튼 -> 텍스트로 변경
				mnlatPrcsnSearch.SetCellValue(i, 'attendBtnYn', button); // 값 변경
				mnlatPrcsnSearch.SetCellEditable(i, 'attendBtnYn', 0); // 편집 불가
			} else if(button == "N") {
				button = "참석확인"
				mnlatPrcsnSearch.SetCellValue(i, 'attendBtnYn', button);
			}

		}
    }

	function closePopup() {
		$('body').removeClass('hiddenScroll');
		// timestamp로 내림차순 중 첫번째 요소를 가져온다.(shift는 원본 요소에서 사라지기 때문에 레이어 팝업 닫기에 사용했다.)
		var config = popupConfig.sort(function(a, b){
			return b['timestamp'] - a['timestamp'];
		}).shift();

		if (config) {
			// 레이어 정보를 삭제한다.
			$('#modalLayerPopup' + config.timestamp).remove();
		}

		window.location.reload(true);

		$('#scanner').val("");
		$('#scanner').focus();
	}
</script>