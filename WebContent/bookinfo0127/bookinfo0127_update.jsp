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
			location.href = "/HRD_0127/bookinfo0127/bookinfo0127_select.jsp";
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String send_bookno = request.getParameter("send_bookno");
	
		String bookno = "";
		String author = "";
		String bookname = "";
		try{
			String sql = "select bookno,author,bookname from bookinfo0127 where bookno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_bookno);
			rs=pstmt.executeQuery();
			if(rs.next()){
				bookno = rs.getString(1);
				author = rs.getString(2);
				bookname = rs.getString(3);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<section>
		<h2>도서회원 수정 프로그램</h2>
		<form name="iu_form" method="post" action="bookinfo0127_update_process.jsp">
			<table id="iu_table">
				<tr>
					<th>도서코드</th>
					<td><input type="text" name="bookno" value="<%=bookno %>" readonly></td>
				</tr>
				<tr>
					<th>저자</th>
					<td><input type="text" name="author" value="<%=author %>"></td>
				</tr>
				<tr>
					<th>도서이름</th>
					<td><input type="text" name="bookname" value="<%=bookname %>"></td>
				</tr>
				<tr>
					<td id="btntd" colspan="2">
						<button type="button" onclick="check()">변경</button>
						<button type="button" onclick="retry()">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>