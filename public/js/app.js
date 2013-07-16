$(document).ajaxSend(function(){$.blockUI();});
$(document).ajaxStop(function(){$.unblockUI()});
$(document).ajaxError(function(){alert("error occurred")});
