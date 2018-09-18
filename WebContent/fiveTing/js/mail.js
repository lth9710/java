function isValidEmail(email) {
	var format = /^((\w|[\-\.])+)@((\w|[\-\.])+)\.([A-Za-z]+)$/;
	if (email.search(format) != -1)
		return true; // 올바른 포맷 형식
	return false;
}

// 내용의 값의 빈공백을 trim(앞/뒤)
String.prototype.trim = function() {
	var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
	return this.replace(TRIM_PATTERN, "");
};

function mailSend() {
	f = document.EmailForm;

	f.action="qnaEmail_ok.do";
	f.submit();
}