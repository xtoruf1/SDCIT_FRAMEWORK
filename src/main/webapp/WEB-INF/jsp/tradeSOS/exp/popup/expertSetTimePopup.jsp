<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style type="text/css">
	#popupSchedule .btn_group_top {position: absolute;top: 0;right: 0;}
	#popupSchedule .dateSelector {text-align: center;margin: 3px 0 15px;}
	#popupSchedule .dateSelector span.date,
	#popupSchedule .dateSelector input.dates {font-size: 20px;color: #666;font-weight: 700;vertical-align: middle;border: 0;letter-spacing: -0.5px;padding: 0;}
	#popupSchedule .dateSelector input[type="text"][readonly] {background: #fff;}
	#popupSchedule .dateSelector input[type="text"]:focus {outline: none;}
	#popupSchedule .dateSelector .btn_standard {margin: 0 30px;min-width: 40px;height: 38px;background-color: #2c3e50;}
	#popupSchedule .dateSelector .btn_standard > span {display: block;width: 100%; height: 100%;}
	#popupSchedule .dateSelector .btn_standard .prev {background: url(../../images/icon/icon_progress_left.png) no-repeat center center;}
	#popupSchedule .dateSelector .btn_standard .next {background: url(../../images/icon/icon_progress_right.png) no-repeat center center;}
	#popupSchedule .timeSelector {display: flex;}
	#popupSchedule .timeSelector > div {position: relative;width: 50px;height: 50px;padding: 10px;border: 1px solid #ddd;-ms-user-select: none;-moz-user-select: -moz-none;-khtml-user-select: none;-webkit-user-select: none;user-select: none;}
	#popupSchedule .timeSelector > div + div {border-left: 0;} 
	#popupSchedule .timeSelector + .timeSelector > div {border-top: 0;}
	#popupSchedule .timeSelector > div span {position: absolute;top: 0;left: 0;width: 100%;height: 100%;font-size: 15px;line-height: 50px;text-align: center;}
	#popupSchedule .timeSelector > div span {background-color: #e4e4e4;opacity: 0.4;}
	#popupSchedule .timeSelector > div input[type="checkbox"] + span {background-color: #fff;opacity: 1;}
	#popupSchedule .timeSelector > div input[type="checkbox"] + span:hover {background: rgba(255, 220, 40, 0.15);}
	#popupSchedule .timeSelector > div input[type="checkbox"] {display: none;}
	#popupSchedule .timeSelector > div input[type="checkbox"]:checked + span{background: #606080;color: #fff;}
</style>
<form id="popupScheduleForm" name="popupScheduleForm" method="post" onsubmit="return false;">
<div id="popupSchedule">
	<!-- ?????? ????????? -->
	<div class="flex">
		<h2 class="popup_title">????????? ??????</h2>
		<div class="ml-auto">
			<button type="button" onclick="deleteSchedule();" class="btn_sm btn_secondary btn_modify_auth">??????</button>
		</div>
		<div class="ml-15">
			<button type="button" class="btn_sm btn_secondary btn_reset">?????????</button>
			<button type="button" onclick="closeLayerPopup();" class="btn_sm btn_secondary">??????</button>
		</div>
	</div>
	<!-- ?????? ?????? -->
	<div class="popup_body">
		<div class="dateSelector">
			<button type="button" onclick="setPrevDate();" class="btn_standard" style="border-radius: 3px;"><span class="prev"></span></button>
			<span id="selectDate" class="date"></span>
			<button type="button" onclick="setNextDate();" class="btn_standard" style="border-radius: 3px;"><span class="next"></span></button>
		</div>
		<div id="divScheduleFirstQuarterList" class="timeSelector">
			<c:forEach var="item" items="${scheduleFirstQuarterList}" varStatus="status">
				<div>
					<c:if test="${item.useYn eq 'Y'}">
						<input type="checkbox" />
					</c:if>
					<span id="hh${fn:replace(item.time, ':', '')}" name="hh${fn:replace(item.time, ':', '')}">${item.time}</span>
				</div>
			</c:forEach>
		</div>
		<div id="divScheduleSecondQuarterList" class="timeSelector">
			<c:forEach var="item" items="${scheduleSecondQuarterList}" varStatus="status">
				<div>
					<c:if test="${item.useYn eq 'Y'}">
						<input type="checkbox" />
					</c:if>
					<span id="hh${fn:replace(item.time, ':', '')}" name="hh${fn:replace(item.time, ':', '')}">${item.time}</span>
				</div>
			</c:forEach>
		</div>
		<div id="divScheduleThirdQuarterList" class="timeSelector">
			<c:forEach var="item" items="${scheduleThirdQuarterList}" varStatus="status">
				<div>
					<c:if test="${item.useYn eq 'Y'}">
						<input type="checkbox" />
					</c:if>
					<span id="hh${fn:replace(item.time, ':', '')}" name="hh${fn:replace(item.time, ':', '')}">${item.time}</span>
				</div>
			</c:forEach>
		</div>
		<h4 class="para_sub_title mt-20">????????????</h4>
		<div class="flex align_center mt-10">
			<select id="weeks" name="weeks" class="form_select" style="width: 150px;">
				<option value="4">4??????</option>
				<option value="3">3??????</option>
				<option value="2">2??????</option>
				<option value="1">1??????</option>
			</select>
			<div id="itemDays" class="ml-15">
				<label for="item_day0" class="label_form"><input type="checkbox" id="item_day0" value="0" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day1" class="label_form"><input type="checkbox" id="item_day1" value="1" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day2" class="label_form"><input type="checkbox" id="item_day2" value="2" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day3" class="label_form"><input type="checkbox" id="item_day3" value="3" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day4" class="label_form"><input type="checkbox" id="item_day4" value="4" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day5" class="label_form"><input type="checkbox" id="item_day5" value="5" class="form_checkbox" /> <span class="label">?????????</span></label>
				<label for="item_day6" class="label_form"><input type="checkbox" id="item_day6" value="6" class="form_checkbox" /> <span class="label">?????????</span></label>
			</div>
		</div>
		<p class="tbl_cmt mt-20"> ??????????????? ???????????? ?????? ?????? ??? ????????? ???????????? ????????? ?????????.</p>
		<p id="pMsg" class="tbl_cmt mt-10"> ?????? ??? ????????? ??? ???????????? ??????/????????? ???????????????.</p>
	</div>
	<!-- ?????? ?????? -->
	<div class="btn_group mt-20 _center">
		<button type="button" id="btnScheduleSave" onclick="addSchedule();" class="btn btn_primary btn_modify_auth">??????</button>
	</div>
</div>
</form>
<script type="text/javascript">
	// ?????? ????????? ?????? ?????? ?????????
	var setTimeEndDate = '${result.endDate}';
	var setTime = '${result.setTime}';	
	var nPopDate = new Date();
	
	if ('${nDate}' != null) {
		// ?????? ??????
		nPopDate = new Date('${nDate}');
	}
	
	$(document).ready(function(){
		var dateStr = '${param.dateStr}';
		$('#selectDate').text(dateStr + '(' + getDayOfWeek(dateStr) + ')');
		var now = new Date(nPopDate);
		now.setHours(0);
		
		if (now > new Date(dateStr)) {
			$('#btnScheduleSave').hide();
			$('#pMsg').show();
		} else {
			$('#btnScheduleSave').show();
			$('#pMsg').hide();
		}
		
		<c:if test="${param.viewGb eq 'proConsultant'}">
			if ($('#divScheduleThirdQuarterList input[type="checkbox"]').length > 23) {
				$('#divScheduleThirdQuarterList input[type="checkbox"]').last().remove();
			}
		</c:if>
		
		setTimeSelector();
		
		getSchedule(dateStr.replace(/-/gi, ''));
	});
	
	function setTimeSelector() {
    	// ?????? ????????? ???
		var start_idx = 0;
		// ??? ????????? ???
		var end_idx = 0;
		// ????????? ??????
		var selectGroup;

		$('.timeSelector>div')
			// ????????? ??????
			.on('mousedown', function(){
				selectGroup = $(this).parent();
				start_idx = $(this).index();
			})
			// ????????? ???
			.on('mouseup', function(){
				end_idx = $(this).index();
				// ????????? ???????????? ?????? (????????? ??????)
				if (start_idx == end_idx) {
					$(this).find('input').prop('checked', function(){
						return !$(this).prop('checked');
					});

				// ????????? ???????????? ?????? (????????? ??????)
				} else {
					var start = start_idx;
					var end = end_idx;

					// ????????? ???????????? ??????
					if (start_idx > end_idx) {
						start = end_idx;
						end = start_idx;
					}

					// ??????????????? ????????? ???????????? ???????????? ??????
					for (var i = start; i <= end; i++) {
						selectGroup.find('div').eq(i).find('input').prop('checked', true);
					}
				}
			});
			
		// RESET
		$('.btn_reset').on('click', function(){
			$('.timeSelector input').prop('checked', false);
		});
	}
	
	function setPrevDate() {
		var dateStr = $('#selectDate').text().substring(0, 10);
		var selectDate = new Date(dateStr);
		selectDate.setDate(selectDate.getDate() - 1);
		selectDate = getFormatFromDate(new Date(selectDate), '-');
		$('#selectDate').text(selectDate + '(' + getDayOfWeek(selectDate) + ')');
		getSchedule(getFormatFromDate(selectDate, ''));
	}
	
	function setNextDate() {
		var dateStr = $('#selectDate').text().substring(0, 10);
		var selectDate = new Date(dateStr);
		selectDate.setDate(selectDate.getDate() + 1);
		selectDate = getFormatFromDate(new Date(selectDate), '-')
		$('#selectDate').text(selectDate + '(' + getDayOfWeek(selectDate) + ')');
		getSchedule(getFormatFromDate(selectDate, ''));
	}
	
	function getSchedule(scheduleDate) {
		global.ajax({
			url : '<c:url value="/tradeSOS/exp/selectExpertScheduleForDay.do" />'
			, dataType : 'json'
			, type : 'POST'
			, data : {
				scheduleDate : scheduleDate
				, expertId : '${param.expertId}'
			}
			, async : true
			, spinner : true
			, success : function(data){
				$('#popupSchedule input[type="checkbox"]').each(function(index, item){
					$(item).prop('checked', false);
				});
				
				if (data != null && Array.isArray(data['result']) && data['result'].length > 0) {
					data['result'].forEach(function(item) {
						var fromTime = new Date();
						fromTime.setHours(item['fromHhmm'].substring(0, 2));
						fromTime.setMinutes(item['fromHhmm'].substring(2, 4));
						fromTime.setSeconds(0);
						
						var endTime = new Date();
						endTime.setHours(item['endHhmm'].substring(0, 2));
						endTime.setMinutes(item['endHhmm'].substring(2, 4));
						endTime.setSeconds(0);
						
						while (fromTime < endTime) {
							var setHour = fromTime.getHours() < 10 ? '0' + String(fromTime.getHours()) : String(fromTime.getHours());
							var setMin = fromTime.getMinutes() < 10 ? '0' + String(fromTime.getMinutes()) : String(fromTime.getMinutes());
							$('#hh' + setHour + setMin).parent().find('input[type="checkbox"]').prop('checked', true);
							fromTime.setMinutes(fromTime.getMinutes() + Number(item['setTime']));
						}
					});
				}
			}
		});
	}
	
	function containsArray(pValue, pArray) {
		var result = false;
		pArray.forEach(function(item){
			if (item == pValue) {
				result = true;
				
				return;
			}
		});
		
		return result;
	}

	function deleteSchedule() {
		if (confirm('?????? ?????? ?????? ????????? ???????????????. ?????? ???????????????????')) {
			$('.btn_reset').trigger('click');
			
			addSchedule();
		}
	}

	// ????????? ??????
    function addSchedule() {
    	// ?????? ?????? ?????? ????????? ???????????? ??????
		var bSetTime = false;
		// ?????? ?????? ?????? ?????? ?????????
		var setTimeEndDateLast = new Date(setTimeEndDate.substring(0, 4), setTimeEndDate.substring(4, 6) - 1, setTimeEndDate.substring(6, 8), 23, 59);
        var selectDate = new Date($('#selectDate').text().substring(0, 10));
		var arrScheduleDate = [];
		var targetDays = [];
		
		$('#itemDays input[type="checkbox"]').each(function(index, item){
			if ($(item).is(':checked')) {
				targetDays.push($(item).val());
			}
		});
		
		// ????????? ?????? ???
		if (targetDays.length > 0) {
			var fromDate = new Date(selectDate);
			var toDate = new Date(selectDate);
			fromDate.setDate(fromDate.getDate() - fromDate.getDay());

			<c:choose>
				<c:when test="${param.viewGb eq 'proConsultant'}">
					// ?????? ??????
					var weeks = ($('#weeks').val() - 1) * 7;
					toDate.setDate(toDate.getDate() + weeks);
				</c:when>
				<c:when test="${param.viewGb eq 'proAdmin'}">
					toDate.setDate(toDate.getDate() + 21);
				</c:when>
			</c:choose>
			toDate.setDate(toDate.getDate() + (6 - toDate.getDay()));
			
			while (fromDate <= toDate && setTimeEndDateLast >= fromDate) {
				if (new Date() < fromDate && containsArray(fromDate.getDay(), targetDays)) {
					arrScheduleDate.push(getFormatFromDate(fromDate, ''));
				}
				
				fromDate.setDate(fromDate.getDate() + 1);
			}
			
			if (setTimeEndDateLast < toDate) {
				bSetTime = true;
			}
		} else {
			arrScheduleDate.push(getFormatFromDate(selectDate, ''));
		}
		
		var bSchedule = false;
		var fromHhmm = '';
		var endHhmm = '';
		var scheduleList = [];
		
		$('#popupSchedule .timeSelector span').each(function(index, item) {
			if (!bSchedule && $(item).parent().find('input[type="checkbox"]').is(':checked')) {
				fromHhmm = $(item).attr('id').substring(2);
				
				bSchedule = true;
			} else if (bSchedule && !$(item).parent().find('input[type="checkbox"]').is(':checked') || $('#popupSchedule .timeSelector span').length == (index - 1)) {
				endHhmm = $(item).attr('id').substring(2);
				
				var fromDate = new Date();
				fromDate.setHours(fromHhmm.substring(0, 2));
				fromDate.setMinutes(fromHhmm.substring(2, 4));
				fromDate.setSeconds(0);
				
				var endDate = new Date();
				endDate.setHours(endHhmm.substring(0, 2));
				endDate.setMinutes(endHhmm.substring(2, 4));
				endDate.setSeconds(0);
				
				var btwTime = endDate.getTime() - fromDate.getTime();
				var btwMinutes = Math.ceil(btwTime / (1000 * 60));
				
				scheduleList.push({
					fromHhmm : fromHhmm
					, endHhmm : endHhmm
					, minutes : btwMinutes
					, setTime : setTime
				});
				
				bSchedule = false;
			}
		});
		
		global.ajax({
			url : '<c:url value="/tradeSOS/exp/selectExpertPrvtConsultTimeForTermList.do" />'
			, dataType : 'json'
			, type : 'POST'
			, data : {
				rsrvDateList : arrScheduleDate
				, expertId : '${param.expertId}'
			}
			, async : true
			, spinner : true
			, success : function(data){
				// ????????? ????????? ?????? ?????? ??????
				var bCheckTime = true;
				
				if (data != null && Array.isArray(data['result'])) {
					data['result'].forEach(function(rsrvDateTime){
						$('#popupSchedule .timeSelector span').each(function(index, item){
							if ($(item).attr('id').indexOf('hh') > -1) {
								if (!$(item).parent().find('input[type="checkbox"]').is(':checked') && rsrvDateTime['rsrvTime'] == $(item).attr('id').substring(2)) {
									var msg = rsrvDateTime['rsrvDate'].substring(4, 6) + '??? ' + rsrvDateTime['rsrvDate'].substring(6, 8) + '??? ';
									msg += rsrvDateTime['rsrvTime'].substring(0, 2) + '??? ' + rsrvDateTime['rsrvTime'].substring(2, 4) + '???';
									msg += '??? ????????? ????????? ????????????.';
									bCheckTime = false;
									
									alert(msg);
									
									return false;
								}
							}
						});
					});
					
					if (bCheckTime) {
						global.ajax({
							url : '<c:url value="/tradeSOS/exp/insertExpertSchedule.do" />'
							, dataType : 'json'
							, type : 'POST'
							, data : {
								scheduleDateList : arrScheduleDate
								, scheduleList : scheduleList
								, expertId : '${param.expertId}'
							}
							, async : true
							, spinner : true
							, success : function(data){
								if (data != null && data['result'] == -1) {
									alert(data['errorMsg']);
									
									return;
								}
								
								if (bSetTime) {
									alert('????????? ????????? ?????? ?????? ????????? ????????? ????????? ???????????????. ' + getFormatFromDate(setTimeEndDateLast, '-') + '?????? ???????????? ??????????????????.');
								}
								
								getList();
								
								// ????????? ??????
								closeLayerPopup();
							}
						});
					}
				}
			}
		});
	}
</script>