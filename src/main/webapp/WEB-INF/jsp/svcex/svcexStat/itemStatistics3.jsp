<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<form name="viewForm" id="viewForm" method="post" onsubmit="return false;">
	<input type="hidden" name="event"		id="event"			value="">
	<input type="hidden" name="listPage"	id="listPage"		value="<c:out value="/svcex/svcexStat/itemStatistics3List.do"/>"/>
	<input type="hidden" name="itemCd"		id="itemCd"			value=""/>
	<input type="hidden" name="lvl"			id="lvl"			value=""/>
	<input type="hidden" name="countryCd"	id="countryCd"		value=""/>
	<input type="hidden" name="countryNm"	id="countryNm"		value=""/>
	<input type="hidden" name="searchGroupCd"	id="searchGroupCd"	value="<c:out value="${svcexVO.searchGroupCd }"/>"/>

	<!-- 페이지 위치 -->
	<div class="location compact">
		<!-- 네비게이션 -->
		<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
		<!-- 네비게이션 -->
		<div class="ml-auto">
			<button type="button" class="btn_sm btn_primary" onclick="downloadIbSheetExcel(selectListSheet,'한국무역협회 무역지원서비스 품목별수출입(품목의국가별)','');">엑셀 다운</button>
			<button type="button" class="btn_sm btn_primary" onclick="doSearch();">검색</button>
		</div>
	</div>
	<div class="tab_header">
		<button class="tab" onclick="location.href='/svcex/svcexStat/itemStatistics1List.do'">품목</button>
		<button class="tab" onclick="location.href='/svcex/svcexStat/itemStatistics2List.do'">품목(월)</button>
		<button class="tab on" onclick="location.href='/svcex/svcexStat/itemStatistics3List.do'">품목의국가</button>
		<button class="tab" onclick="location.href='/svcex/svcexStat/itemStatistics4List.do'">품목의국가(월)</button>
	</div>
	<div class="cont_block">
		<table class="formTable">
			<colgroup>
				<col style="width:10%;">
				<col />
				<col style="width:10%;">
				<col />
				<col style="width:10%;">
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>대분류</th>
					<td>
						<select name="searchItemLv1" id="searchItemLv1Id" onchange="javascript:doItemCodeChange('ITEM_LV2')" class="form_select"></select>
					</td>
					<th>중분류</th>
					<td>
						<select name="searchItemLv2" id="searchItemLv2Id" onchange="javascript:doItemCodeChange('ITEM_LV3')" class="form_select"></select>
					</td>
					<th>세분류</th>
					<td>
						<select name="searchItemLv3" id="searchItemLv3Id" onchange="javascript:doItemCodeChange('ITEM_LV4')" class="form_select"></select>
					</td>
				</tr>
				<tr>
					<th>세세분류</th>
					<td>
						<select name="searchItemLv4" id="searchItemLv4Id" onchange="javascript:doItemCodeChange('')" class="form_select"></select>
					</td>
					<th>년도</th>
					<td>
						<select name="searchYear" id="searchYearId" class="form_select">
							<c:forEach var="list" items="${yearList}" varStatus="status">
								<option value="${list.searchYear}"<c:if test="${svcexVO.searchYear == list.searchYear}"> selected</c:if>>${list.searchYear}</option>
							</c:forEach>
						</select>
					</td>
					<th>수출입</th>
					<td>
						<select name="searchExpImpCd" id="searchExpImpCdId" class="form_select">
							<c:forEach var="list" items="${com002}" varStatus="status">
								<option value="${list.detailcd}"<c:if test="${svcexVO.searchExpImpCd == list.detailcd}"> selected</c:if>>${list.detailnm}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="cont_block">
		<div class="tbl_opt">
			<div><c:out value="${nowDate }"/> 현재</div>
		</div>
		<div id="selectList" class="sheet"></div>
		<!-- <div id="paging" class="paging ibs"></div> -->
	</div>

</form>

<script type="text/javascript">
	var f = document.viewForm;

	$(document).ready(function(){
		doItemCodeChange("ITEM_LV1");
		selectList();
	});

	function doSearch() {
		if ($("#searchItemLv4Id option:selected").val() != ""){
			f.itemCd.value = $("#searchItemLv4Id option:selected").val();
			f.searchGroupCd.value = "4";
		}else if ($("#searchItemLv3Id option:selected").val() != ""){
			f.itemCd.value = $("#searchItemLv3Id option:selected").val();
			f.searchGroupCd.value = "3";
		}else if ($("#searchItemLv2Id option:selected").val() != ""){
			f.itemCd.value = $("#searchItemLv2Id option:selected").val();
			f.searchGroupCd.value = "2";
		}else if ($("#searchItemLv1Id option:selected").val() != ""){
			f.itemCd.value = $("#searchItemLv1Id option:selected").val();
			f.searchGroupCd.value = "1";
		}
		selectList();
	}

	function selectList() {
		global.ajax({
			type : 'POST'
			, url : '<c:url value="/svcex/svcexStat/itemStatistics3DataList.do" />'
			, data : $('#viewForm').serialize()
			, dataType : 'json'
			, async : true
			, spinner : true
			, success : function(data){
// 				selectListSheet.LoadSearchData({Data: data.resultList}, {Wait: 0});
				setGrid(data);
			}
		});
	}

	function setGrid(data){

		if (typeof selectListSheet !== "undefined" && typeof selectListSheet.Index !== "undefined") {
			selectListSheet.DisposeSheet();
		}

		var	ibHeader = new IBHeader();
		var svcexVO = data.svcexVO;
		ibHeader.addHeader({Header: '국가코드', Type: 'Text', SaveName: 'detailcd', Width: 5, Align: 'Center', ColMerge: 0, Hidden: false, Edit:false});
		ibHeader.addHeader({Header: '국가', Type: 'Text', SaveName: 'detailnm', Width: 20, Align: 'Left', ColMerge: 0, Cursor:"Pointer", Edit:false});
		ibHeader.addHeader({Header: svcexVO.lastYear + '년 금액($)', Type: 'AutoSum', SaveName: 'checkAmount1', Width: 30, Align: 'Right', Edit:false});
		ibHeader.addHeader({Header: svcexVO.searchYear + '년 금액($)', Type: 'AutoSum', SaveName: 'checkAmount2', Width: 30, Align: 'Right', Edit:false});
		ibHeader.addHeader({Header: '증감율(%)', Type: 'Text', SaveName: 'per', Width: 10, Align: 'Right', Edit:false});

		ibHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, DeferredVScroll: 1, SizeMode: 4, MouseHoverMode: 2, editable: false, MergeSheet :5, VScrollMode: 0, NoFocusMode : 0 });
		ibHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

		var container = $('#selectList')[0];
		createIBSheet2(container, 'selectListSheet', '100%', '560px');
		ibHeader.initSheet('selectListSheet');
		selectListSheet.SetCellAlign(selectListSheet.LastRow(), 'detailcd', "Center");
		selectListSheet.SetSumText('detailcd', "합계");
		selectListSheet.SetMergeCell(selectListSheet.LastRow(), 0, 1, 2 );
		selectListSheet.SetSelectionMode(4);
		selectListSheet.LoadSearchData({Data: data.resultList}, {Wait: 0});
	}

	function selectListSheet_OnSearchEnd(code, msg) {
		if (code != 0) {

		}else{
			// 볼드 처리
			selectListSheet.SetColFontBold('detailnm', 1);
		}
	}

	function selectListSheet_OnClick(row, col, value, cellX, cellY, cellW, cellH) {
		if (row > 0) {
			if( selectListSheet.ColSaveName(col) == "detailnm" ) {
				var url = "/svcex/svcexStat/itemStatistics4List.do";
				var detailcd = selectListSheet.GetCellValue(row, "detailcd");
				var detailnm = selectListSheet.GetCellValue(row, "detailnm");

				f.countryCd.value = detailcd;
				f.countryNm.value = detailnm;
				f.action = url;
				f.target = '_self';
				f.submit();
			}
		}
	}

	function doItemCodeChange(lv) {

		if(lv != ""){
			f.event.value = lv;
			global.ajax({
				type : 'POST'
				, url : '<c:url value="/svcex/svcexStat/searchArticleListData.do" />'
				, data : $('#viewForm').serialize()
				, dataType : 'json'
				, async : true
				, spinner : true
				, success : function(data){
					var rowSet = data.rowSet;
					if (lv == "ITEM_LV1"){
						selectboxRemove("lv1");
						selectboxAdd(rowSet, "lv1");
					}else if (lv == "ITEM_LV2"){
						selectboxRemove("lv2");
						selectboxAdd(rowSet, "lv2");
					}else if (lv == "ITEM_LV3"){
						selectboxRemove("lv3");
						selectboxAdd(rowSet, "lv3");
					}else if (lv == "ITEM_LV4"){
						selectboxRemove("lv4");
						selectboxAdd(rowSet, "lv4");
					}
				}
			});
		}
	}
	function selectboxRemove(lv){
		if (lv == "lv1"){
			$("#searchItemLv1Id option").remove();
			$("#searchItemLv1Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv2Id option").remove();
			$("#searchItemLv2Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv3Id option").remove();
			$("#searchItemLv3Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv4Id option").remove();
			$("#searchItemLv4Id").append("<option value=''>-- 전체 --</option>");
		}else if (lv == "lv2"){
			$("#searchItemLv2Id option").remove();
			$("#searchItemLv2Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv3Id option").remove();
			$("#searchItemLv3Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv4Id option").remove();
			$("#searchItemLv4Id").append("<option value=''>-- 전체 --</option>");
		}else if (lv == "lv3"){
			$("#searchItemLv3Id option").remove();
			$("#searchItemLv3Id").append("<option value=''>-- 전체 --</option>");
			$("#searchItemLv4Id option").remove();
			$("#searchItemLv4Id").append("<option value=''>-- 전체 --</option>");
		}else if (lv == "lv4"){
			$("#searchItemLv4Id option").remove();
			$("#searchItemLv4Id").append("<option value=''>-- 전체 --</option>");
		}
	}
	function selectboxAdd(rowSet, lv){
		if (lv == "lv1"){
			for( var i = 0; rowSet.length > i; i++ ) {
				$("#searchItemLv1Id").append("<option value="+rowSet[i].detailcd+">"+rowSet[i].detailnm+"</option>");
			}
		}else if (lv == "lv2"){
			for( var i = 0; rowSet.length > i; i++ ) {
				$("#searchItemLv2Id").append("<option value="+rowSet[i].detailcd+">"+rowSet[i].detailnm+"</option>");
			}
		}else if (lv == "lv3"){
			for( var i = 0; rowSet.length > i; i++ ) {
				$("#searchItemLv3Id").append("<option value="+rowSet[i].detailcd+">"+rowSet[i].detailnm+"</option>");
			}
		}else if (lv == "lv4"){
			for( var i = 0; rowSet.length > i; i++ ) {
				$("#searchItemLv4Id").append("<option value="+rowSet[i].detailcd+">"+rowSet[i].detailnm+"</option>");
			}
		}
	}
 	function selectListSheet_OnRowSearchEnd(row) {
		notEditableCellColor('selectListSheet', row);

		if (row > 0){
		}
	}
</script>
