<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 22</title>
	<script>
		function check() {
			if(document.iu_form.bookno.value==""){
				alert("도서코드가 입력되지 않았습니다.");
				document.iu_form.bookno.focus();
			}else if(document.iu_form.author.value==""){
				alert("저자가 입력되지 않았습니다.");
				document.iu_form.author.focus();
			}else if(document.iu_form.bookname.value==""){
				alert("도서이름이 입력되지 않았습니다.");
				document.iu_form.bookname.focus();
			}else{
				document.iu_form.submit();
			}
			
		}
		function retry() {
			document.iu_form.reset();
		}
	</script>
</head>
<body>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<h2>도서회원 관리 프로그램</h2>
		<form name="iu_form" method="post" action="bookinfo0127_insert_process.jsp">
			<table id="iu_table">
				<tr>
					<th>도서코드</th>
					<td><input type="text" name="bookno"></td>
				</tr>
				<tr>
					<th>저자</th>
					<td><input type="text" name="author"></td>
				</tr>
				<tr>
					<th>도서이름</th>
					<td><input type="text" name="bookname"></td>
				</tr>
				<tr>
					<td id="btntd" colspan="2">
						<button type="button" onclick="check()">등록</button>
						<button type="button" onclick="retry()">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>