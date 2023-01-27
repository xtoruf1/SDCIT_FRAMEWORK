<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<form id="popupProgramForm" name="popupProgramForm" method="get" onsubmit="return false;">
<input type="hidden" name="pgmId" value="0" />
<div style="width: 850px;height: 530px;">
	<!-- 팝업 타이틀 -->
	<div class="flex">
		<h2 class="popup_title">프로그램 선택</h2>
		<div class="ml-auto">
			<button type="button" onclick="doProgramSearch();" class="btn_sm btn_primary">검색</button>
			<button type="button" onclick="closeLayerPopup();" class="btn_sm btn_secondary">닫기</button>
		</div>
	</div>
	<!-- 팝업 내용 -->
	<div class="popup_body">
		<!--검색 시작 -->
		<div class="search">
			<table class="formTable">
				<colgroup>
					<col style="width:15%;" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">검색</th>
						<td>
							<select id="searchPopupCondition" name="searchPopupCondition" class="form_select">
								<option value="">::: 전체 :::</option>
								<option value="pgmName">프로그램명</option>
								<option value="url">URL</option>
							</select>
							<input type="text" id="searchPopupKeyword" name="searchPopupKeyword" value="" onkeydown="onEnter(doProgramSearch);" class="textType form_text"  title="검색어" />
						</td>
		            </tr>
				</tbody>
			</table>
		</div>
		<!--검색 끝 -->
		<div class="cont_block mt-20">
			<div id="programList" class="sheet"></div>
		</div>
	</div>
</div>
</form>
<script type="text/javascript">
	var	ibProgramHeader = new IBHeader();
	ibProgramHeader.addHeader({Header: '프로그램명', Type: 'Text', SaveName: 'pgmName', Width: 90, Align: 'Left' <c:if test="${pageModifyYn eq 'Y'}">, Cursor: 'Pointer'</c:if>, Edit: 0});
	ibProgramHeader.addHeader({Header: 'URL', Type: 'Text', SaveName: 'url', Width: 170, Align: 'Left', Edit: 0});
	ibProgramHeader.addHeader({Header: '등록일시', Type: 'Text', SaveName: 'creDate', Width: 60, Align: 'Center', Edit: 0});
	
	ibProgramHeader.addHeader({Header: '프로그램아이디', Type: 'Text', SaveName: 'pgmId', Hidden: true});
	
	ibProgramHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, UseHeaderActionMenu: false, MouseHoverMode: 2, SelectionRowsMode: false, FrozenCol: 0, DeferredVScroll: true, ToolTip: true, Ellipsis: true, SizeMode: 4, NoFocusMode: 0, Alternate: 0, HeaderCheckSync: 1, DragMode: -1, MergeSheet: 5, MaxSort: 1});
	ibProgramHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	var ppf;
	$(document).ready(function(){
		ppf = document.popupProgramForm;
		
		// 셀렉트 박스 값을 갱신
		$('.jquerySelectbox').selectmenu().selectmenu('refresh');
		
		var programContainer = $('#programList')[0];
		if (typeof programListSheet !== 'undefined' && typeof programListSheet.Index !== 'undefined') {
			programListSheet.DisposeSheet();
		}
		createIBSheet2(programContainer, 'programListSheet', '', '400px');
		ibProgramHeader.initSheet('programListSheet');
		programListSheet.SetSelectionMode(4);
		
		// 편집모드 OFF
		programListSheet.SetEditable(0);
				
		getProgramList();
	});
	
	function programListSheet_OnSearchEnd(code, msg) {
		if (code != 0) {
    		console.log('programListSheet_OnSearchEnd : ', msg);
    	} else {
    		// 프로그램명에 볼드 처리
			programListSheet.SetColFontBold('pgmName', 1);
    	}
    }
	
	function programListSheet_OnClick(row, col, value, cellX, cellY, cellW, cellH) {
		<c:if test="${pageModifyYn eq 'Y'}">
			if (row > 0) {
				if (programListSheet.ColSaveName(col) == 'pgmName') {
					var pgmId = programListSheet.GetCellValue(row, 'pgmId');
					
					doProgramAdd(pgmId);
			    }	
			}
		</c:if>
	}
	
	function doProgramSearch() {
		getProgramList();
	}
	
	// 목록 가져오기
	function getProgramList() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/menu/user/popup/program/selectList.do" />'
			, data : $('#popupProgramForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
				programListSheet.LoadSearchData({Data: data.resultList});
			}
		});
	}
	
	function programListSheet_OnRowSearchEnd(row) {
		// 편집할 수 없는 컬럼 색 변경(시트에 편집 여부가 동일하지 않고 혼재 되어 있을시)
		notEditableCellColor('programListSheet', row);
	}
	
	function doProgramAdd(pgmId) {
		// 콜백
		layerPopupCallback(pgmId);
	}
</script>