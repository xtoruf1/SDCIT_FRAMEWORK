<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!-- 페이지 위치 -->
<div class="location compact">
	<!-- 네비게이션 -->
	<jsp:include page="/WEB-INF/jsp/layouts/navigation.jsp" flush="true" />
	<!-- 네비게이션 -->
</div>

<div class="cont_block">
	<!-- 타이틀 영역 -->
	<div class="tit_bar">
		<!-- 섹션 타이틀 -->
	</div>
	<div class="tabGroup">
		<div class="tab_header">
			<button class="tab" onclick="fn_list();">현재배너</button>
			<button class="tab on" onclick="fn_Closelist();">지난배너</button>
		</div>
		<form id="bannerRegForm" name="bannerRegForm" action="" method="post">
			<input type="hidden" name="mainBannerId" value='<c:out value="${resultData.mainBannerId}"/>'/>
			<input type="hidden" nmae="listUrl" id="listUrl" value="<c:out value="${listUrl}"/>">
			<input id="atchFileId" name="atchFileId" type="hidden" value=""/>
			<input id="fileSn" name="fileSn" type="hidden" value=""/>
			<div class="tab_body">
				<div class="tab_cont on">
					<table class="formTable">
						<colgroup>
							<col style="width:120px;" />
							<col/>
						</colgroup>
						<tbody>
						<tr>
							<th>제목</th>
							<td>
								<input type="text" class="form_text w100p" name="title" id="title" maxlength="100" value='<c:out value="${resultData.title}"/>'/>
							</td>
						</tr>
						<tr>
							<th>게재기간</th>
							<td class="pick_area">
								<div class="group_datepicker">
									<!-- datepicker -->
									<div class="datepicker_box">
										<span class="form_datepicker">
											<input type="text" id="fromDate" name="fromDate" value='<c:out value="${resultData.fromDate}"/>' class="txt datepicker" placeholder="시작일" title="게재기간 시작일" readonly="readonly" />
											<img src="<c:url value='/images/icon_calender.png' />" class="ui-datepicker-trigger" alt="캘린더" title="캘린더" />
											<input type="hidden" id="dummyStartDate" value="" />
										</span>
									</div>
									<div class="spacing">~</div>
									<div class="datepicker_box">
										<span class="form_datepicker">
											<input type="text" id="endDate" name="endDate" value='<c:out value="${resultData.endDate}"/>' class="txt datepicker" placeholder="종료일" title="게재기간 종료일" readonly="readonly" />
											<img src="<c:url value='/images/icon_calender.png' />" class="ui-datepicker-trigger" alt="캘린더" title="캘린더" />
											<input type="hidden" id="dummyEndDate" value="" />
										</span>
									</div>
								</div>
							</td>
						</tr>
						<tr>
							<th>PC 이미지</th>
							<td>
								<div id="last_fileName_PC">
									<div class="addedFile" id="${fileResult.attachSeq}">
										<a href="javascript:doDownloadFile('${resultData.pcAtchFileId}', '${resultData.mobileFileSn}');" class="filename">
											${resultData.pcOrignlFileNm}
										</a>
										<a href="javascript:deleteFile('PC');" class="btn_del">
											<img src="<c:url value="/images/admin/ico_btn_delete.png" />" alt="삭제" />
										</a>
									</div>
								</div>
								<div class="form_file">
									<p class="file_name">첨부파일을 선택하세요</p>
									<label class="file_btn">
										<input type="file" id="filePC" name="filePC" />
										<span class="btn_tbl">찾아보기</span>
									</label>
								</div>
								<div class="file_size">
									<p>이미지규격 : 820 x 305</p>
								</div>
							</td>
						</tr>
						<tr>
							<th>MOBILE 이미지</th>
							<td>
								<div id="last_fileName_MOBILE">
									<div class="addedFile" id="${resultData.attachSeq}" class="filename">
										<a href="javascript:doDownloadFile('${resultData.mobileAtchFileId}', '${resultData.mobileFileSn}');" >
											${resultData.mobileOrignlFileNm}
										</a>
										<a href="javascript:deleteFile('MOBILE');" class="btn_del">
											<img src="<c:url value="/images/admin/ico_btn_delete.png" />" alt="삭제" />
										</a>
									</div>
								</div>
								<div class="form_file">
									<p class="file_name">첨부파일을 선택하세요</p>
									<label class="file_btn">
										<input type="file" id="fileMOBILE" name="fileMOBILE" />
										<span class="btn_tbl">찾아보기</span>
									</label>
								</div>
								<div class="file_size">
									<p>이미지규격 : 360 x 214</p>
								</div>
							</td>
						</tr>
						<tr>
							<th>이미지 태그</th>
							<td>
								<input type="text" class="form_text w100p" name="imgTag" id="imgTag" maxlength="200" value='<c:out value="${resultData.imgTag}"/>'/>
							</td>
						</tr>
						<tr>
							<th>링크</th>
							<td>
								<input type="text" class="form_text w80p" name="linkUrl" id="linkUrl" maxlength="500" value='<c:out value="${resultData.linkUrl}"/>'/>
								<label class="label_form">
									<input type="radio" name="linkType" class="form_radio" id="link_type_blank" value="blank" <c:out value="${resultData.linkType eq 'blank' ? 'checked' : ''}"/>>
									<span class="label">새창</span>
								</label>
								<label class="label_form">
									<input type="radio" name="linkType" class="form_radio" id="link_type_self" value="self" <c:out value="${resultData.linkType eq 'self' ? 'checked' : ''}"/>>
									<span class="label">현재창</span>
								</label>
							</td>
						</tr>
						<tr>
							<th>공개여부</th>
							<td>
								<label class="label_form">
									<input type="radio" name="viewYn" class="form_radio" id="view_yn_y" value="Y" <c:out value="${resultData.viewYn eq 'Y' ? 'checked' : ''}"/>>
									<span class="label">새창</span>
								</label>
								<label class="label_form">
									<input type="radio" name="viewYn" class="form_radio" id="view_yn_n" value="N" <c:out value="${resultData.viewYn eq 'N' ? 'checked' : ''}"/>>
									<span class="label">현재창</span>
								</label>
							</td>
						</tr>
						</tbody>
					</table>
					<div class="btn_group mt-20 _center">
						<button type="button" id="btnSave" class="btn btn_primary" onclick="modifyBanner();">수정</button>
						<button type="button" id="btnDelete" class="btn btn_secondary" onclick="deleteBanner();">삭제</button>
						<button type="button" id="btnList" class="btn btn_secondary" onclick="goList();">목록</button>
					</div>
				</div>
			</div>
			<%-- 끝--%>

		</form>
	</div>
</div>

<script type="text/javaScript" language="javascript">
	$(document).ready(function() {
		$("input:file[name^='param_file_']").change(function(){
			$(this).parents('div.inputFile').find("input:hidden[name^='FILE_SEQ']").val("");
			$(this).parents('div.inputFile').find("input:text[name^='fileName']").val($(this).val().substring($(this).val().lastIndexOf("\\")+1));
		});
	});

	function deleteFile(addStr){
		jQuery("input:hidden[name='FILE_SEQ_"+addStr+"']").val('');
		jQuery("input:text[name='fileName_"+addStr+"']").val("");
		jQuery("input:file[name='file"+addStr+"']").val("");
		jQuery("#last_fileName_"+addStr).remove();
	}

	function goList(){
		if( $('#listUrl').val() == "/mainContent/mainBannerCloseList.do") {
			location.href = '/mainContent/mainBannerOpen.do?typeFlag=close' ;
		} else {
			location.href = '/mainContent/mainBannerOpen.do' ;
		}

	}

	function modifyBanner(saveType) {
		if( jQuery('#title').val() == '' ){
			alert('제목은 필수입니다.');
			jQuery('#title').focus();
			return false;
		} else if( jQuery('#fromDate').val() == '' ){
			alert('게재 시작일자는 필수입니다.');
			jQuery('#fromDate').focus();
			return false;
		} else if( jQuery('#last_fileName_PC').text() == '' && jQuery('#filePC').val() == ''){
			alert('PC 이미지는 필수입니다.');
			return false;
		} else if( jQuery('#last_fileName_MOBILE').text() == '' && jQuery('#fileMOBILE').val() == ''){
			alert('MOBILE 이미지는 필수입니다.');
			return false;
		} else if( jQuery('#linkUrl').val() == '' ){
			alert('링크는 필수입니다.');
			jQuery('#linkUrl').focus();
			return false;
		}

		if(confirm('수정 하시겠습니까?')){
			global.ajaxSubmit($('#bannerRegForm'), {
				  type : 'POST'
				, url : '<c:url value="/mainContent/modifyMainBanner.do" />'
				, enctype : 'multipart/form-data'
				, dataType : 'json'
				, async : false
				, spinner : true
				, success : function(data){
					alert('해당 게시물을 수정하였습니다.');

					var url = data.redirectUrl;

					location.href = '<c:url value=""/>'+ url;

				}
			});
		}
	}

	function deleteBanner(saveType) {
		if(confirm('삭제 하시겠습니까?')){
			var f = document.bannerRegForm;
			f.method = "post";
			f.target = "_self";
			f.action = "/mainContent/deleteMainBanner.do";
			f.submit();
		}
	}

	//첨부파일 다운로드
	function doDownloadFile(fileSeq, fileSn) {
		var f = document.bannerRegForm;
		f.action = '<c:url value="/common/util/noticeFileDownload.do" />';
		f.atchFileId.value = fileSeq;
		f.fileSn.value = fileSn;
		f.target = '_self';
		f.submit();
	}

	function fn_list() {
		location.href = '<c:url value="/mainContent/mainBannerOpen.do" />';
	}

	function fn_Closelist() {
		location.href = '<c:url value="/mainContent/mainBannerOpen.do?typeFlag=close" />';
	}
</script>