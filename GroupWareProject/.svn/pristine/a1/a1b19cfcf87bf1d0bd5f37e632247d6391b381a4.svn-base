/* 개행문자 DB에 저장시키기 위한 BR태그 변경 함수 */
function replaceNewLineToBrTag(taValue) {
	// html로 적용할 것!
	if(taValue)
		return taValue.replace(/\n/g, "<br>");
	
	return null;
}

/* BR태그로 변환된 데이터를 다시 개행문자로 돌려주기 위한 함수 */
function replaceBrTagToNewLine(text) {

	if(text)
		return text.replaceAll('<br>', "\r\n");
	
	return null;
}