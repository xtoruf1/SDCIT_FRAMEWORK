<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<form name="listForm" method="get" onsubmit="return false;">
<input type="hidden" name="searchPgmName" value="${param.searchPgmName}" />
<input type="hidden" name="searchDetailYn" value="${param.searchDetailYn}" />
<input type="hidden" name="searchUrl" value="${param.searchUrl}" />
<input type="hidden" name="pageIndex" value="<c:out value='${param.pageIndex}' default='1'/>" />
<input type="hidden" name="pageUnit" value="<c:out value='${param.pageUnit}' default='10'/>" />
</form>
<form id="programForm" name="programForm" method="post" onsubmit="return false;">
<input type="hidden" id="pgmId" name="pgmId" value="<c:out value='${resultView.pgmId}' default='0' />" />
<!-- 페이지 위치 -->
<div class="location compact">
	<!-- 네비게이션 -->
	<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
	<!-- 네비게이션 -->
	<div class="ml-auto">
		<c:choose>
			<c:when test="${empty resultView.pgmId}">
				<button type="button" onclick="doInsert();" class="btn_sm btn_primary btn_modify_auth">저장</button>
			</c:when>
			<c:otherwise>
				<button type="button" onclick="doUpdate();" class="btn_sm btn_primary btn_modify_auth">저장</button>
				<button type="button" onclick="doDelete();" class="btn_sm btn_secondary btn_modify_auth">삭제</button>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="ml-15">
		<button type="button" onclick="goList();" class="btn_sm btn_secondary">목록</button>
	</div>
</div>
<div class="contents cont_block">
	<div class="tbl_opt">
		<span><strong class="point">*</strong> 는 필수 입력입니다.</span>
	</div>
	<table class="boardwrite formTable">
		<caption>등록/수정화면</caption>
		<colgroup>
			<col width="15%" />
			<col />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">프로그램명 <strong class="point">*</strong></th>
				<td>
					<input type="text" name="pgmName" value="${resultView.pgmName}" maxlength="30" class="form_text w100p" />
				</td>
			</tr>
			<tr>
				<th scope="row">URL</th>
				<td>
					<input type="text" name="url" value="${resultView.url}" maxlength="60" class="form_text w100p" />
				</td>
			</tr>
			<tr>
				<th scope="row">새창여부</th>
				<td>
					<select name="linkTarget" class="form_select">
						<option value="_self" <c:if test="${empty resultView.linkTarget or resultView.linkTarget eq '' or resultView.linkTarget eq '_self'}">selected="selected"</c:if>>현재창</option>
						<option value="_blank" <c:if test="${resultView.linkTarget eq '_blank'}">selected="selected"</c:if>>새창</option>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="row">비고</th>
				<td>
					<input type="text" name="dscr" value="${resultView.dscr}" maxlength="300" class="form_text w100p" />
				</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="cont_block">
	<div class="tbl_opt">
		<div class="ml-auto">
			<button type="button" onclick="doRowAdd();" class="btn_sm btn_primary btn_modify_auth">추가</button>
		</div>
	</div>
	<div class="contents">
		<div id="subList" class="sheet"></div>
	</div>
</div>
</form>
<script type="text/javascript">
	var	ibSubHeader = new IBHeader();
	ibSubHeader.addHeader({Header: '상태', Type: 'Status', SaveName: 'status', Width: 20, Align: 'Center', Hidden: true});
	ibSubHeader.addHeader({Header: '삭제', Type: 'DelCheck', SaveName: 'delFlag', Width: 20, Align: 'Center', HeaderCheck: 0});
	ibSubHeader.addHeader({Header: '하위 프로그램명', Type: 'Text', SaveName: 'pgmName', Width: 70, Align: 'Left', EditLen: 30});
	ibSubHeader.addHeader({Header: 'URL', Type: 'Text', SaveName: 'url', Width: 110, Align: 'Left', EditLen: 60});

	ibSubHeader.addHeader({Header: '프로그램 아이디', Type: 'Text', SaveName: 'pgmId', Align: 'Center', Hidden: true});
	ibSubHeader.addHeader({Header: '순번', Type: 'Text', SaveName: 'seq', Align: 'Center', Hidden: true});

	ibSubHeader.setConfig({AutoFitColWidth: 'search|resize|init|colhidden|rowtransaction|colresize', Page: 10, SearchMode: 2, UseHeaderActionMenu: false, MouseHoverMode: 2, SelectionRowsMode: false, FrozenCol: 0, DeferredVScroll: true, ToolTip: true, Ellipsis: true, SizeMode: 1, NoFocusMode: 0, Alternate: 0, HeaderCheckSync: 1, DragMode: -1, MergeSheet: 5, ChildPage: 10, MaxSort: 1});
	ibSubHeader.setHeaderMode({Sort: 0, ColResize: true, ColMove: true});

	var f;
	var lf;
	$(document).ready(function(){
		f = document.programForm;
		lf = document.listForm;
		<c:if test="${empty resultView.pgmId}">
			f.pgmName.focus();
		</c:if>

		var container = $('#subList')[0];
		createIBSheet2(container, 'subListSheet', '100%', '100%');
		ibSubHeader.initSheet('subListSheet');
		subListSheet.SetWaitImageVisible(0);

		// 하위 프로그램 목록 가져오기
		getSubProgramList();
	});

	// 하위 프로그램 목록 가져오기
	function getSubProgramList() {
		subListSheet.DoSearch('<c:url value="/menu/admin/program/selectSubList.do" />', {
			pgmId : f.pgmId.value
		},
		{'ReqHeader':{'Content-Type' : 'application/json'}});
	}

	function subListSheet_OnRowSearchEnd(row) {
		// 편집할 수 없는 컬럼 색 변경(시트에 편집 여부가 동일하지 않고 혼재 되어 있을시)
		notEditableCellColor('subListSheet', row);
	}

	function isValid() {
		if (isStringEmpty(f.pgmName.value)) {
			alert('프로그램명을 입력해 주세요.');
			f.pgmName.focus();

			return false;
		}

		var saveJson = subListSheet.GetSaveJson();

		// 대상목록의 정보
		if (saveJson.Message == 'KeyFieldError') {
			return false;
		}

		if (saveJson.Message == 'InvalidInputError') {
			return false;
		}

		var isNmValid = true;
		var isUrlValid = true;

		if (saveJson.data.length) {
			var duplicate = new Array();

			$.each(saveJson, function(key1, value1) {
				$.each(value1, function(key2, value2) {
					// 삭제는 삭제 대상이기 때문에 유효성을 체크하지 않는다.
					if (value2.status == 'I' || value2.status == 'U') {
						if (isStringEmpty(value2.pgmName)) {
							isNmValid = false;
						}

						if (isStringEmpty(value2.url)) {
							isUrlValid = false;
						}
					}

					duplicate.push(value2.url);
				});
			});

			for (var i = 0; i < duplicate.length - 1; i++) {
				var dupCheck = jQuery.inArray(duplicate[i], duplicate, i + 1);

				if (dupCheck >= 0) {
					alert('중복된 URL이 존재합니다. 다시 입력해 주세요.');

					return false;
				}
			}
		}

		if (!isNmValid) {
			alert('하위 프로그램명을 입력해 주세요.');

			return false;
		}

		if (!isUrlValid) {
			alert('하위 URL을 입력해 주세요.');

			return false;
		}

		return true;
	}

	function doInsert() {
		if (isValid()) {
			if (confirm('저장 하시겠습니까?')) {
				var pf = $('#programForm').serializeObject();

				var saveJson = subListSheet.GetSaveJson();

				if (saveJson.data.length) {
					var map = {};
					var list = [];
					$.each(saveJson, function(key1, value1) {
						map = {};
						$.each(value1, function(key2, value2) {
							map = value2;
							list.push(map);
						});

						pf['subList'] = list;
					});
				}

				global.ajax({
					type : 'POST'
					, url : '<c:url value="/menu/admin/program/insert.do" />'
					, data : JSON.stringify(pf)
					, contentType : 'application/json'
					, dataType : 'json'
					, async: false
					, spinner : true
					, success : function(data){
						if (data.result) {
							goList();
						} else {
							alert(data.message);
						}
					}
				});
			}
		}
	}

	function doUpdate() {
		if (isValid()) {
			if (confirm('저장 하시겠습니까?')) {
				var pf = $('#programForm').serializeObject();

				var saveJson = subListSheet.GetSaveJson();

				if (saveJson.data.length) {
					var map = {};
					var list = [];
					$.each(saveJson, function(key1, value1) {
						map = {};
						$.each(value1, function(key2, value2) {
							map = value2;
							list.push(map);
						});

						pf['subList'] = list;
					});
				}

				global.ajax({
					type : 'POST'
					, url : '<c:url value="/menu/admin/program/update.do" />'
					, data : JSON.stringify(pf)
					, contentType : 'application/json'
					, dataType : 'json'
					, async: false
					, spinner : true
					, success : function(data){
						if (data.result) {
							goList();
						} else {
							alert(data.message);
						}
					}
				});
			}
		}
	}

	function doDelete() {
		if (confirm('메뉴에 등록된 프로그램을 삭제하면 해당 모든권한과 메뉴등이 삭제됩니다. 모두 삭제 하시겠습니까?')) {
			global.ajax({
				type : 'POST'
				, url : '<c:url value="/menu/admin/program/delete.do" />'
				, data : $('#programForm').serialize()
				, dataType : 'json'
				, async : true
				, spinner : true
				, success : function(data){
					goList();
				}
			});
		}
	}

	function goList() {
		lf.action = '<c:url value="/menu/admin/program/list.do" />';
		lf.target = '_self';
		lf.submit();
	}

	// 코드 목록에 행 추가
	function doRowAdd() {
		subListSheet.DataInsert(-1);
	}
</script>