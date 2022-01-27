<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 22</title>
	<script>
		function check() {
			if(document.iu_form.lentno.value==""){
				alert("대출번호가 입력되지 않았습니다.");
				document.iu_form.lentno.focus();
			}else if(document.iu_form.custname.value==""){
				alert("고객성명이 입력되지 않았습니다.");
				document.iu_form.custname.focus();
			}else if(document.iu_form.bookname.value==""){
				alert("도서코드가 입력되지 않았습니다.");
				document.iu_form.bookname.focus();
			}else{
				document.iu_form.action = "reservation0127_insert_process.jsp";
				document.iu_form.submit();
			}
			
		}
		function retry() {
			document.iu_form.reset();
		}
		function booknoCheck() {
			document.iu_form.submit();
		}
		function statusClick(s) {
			if(s.value=="1"){
				document.iu_form.indate.value = "";
				document.iu_form.indate.readOnly = true;
				document.iu_form.indate.style.backgroundColor = "lightgray";
				
			}else{
				document.iu_form.indate.readOnly = false;
				document.iu_form.indate.style.backgroundColor = "white";
			}
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String bookno = request.getParameter("bookno");
		String bookname = "";	
		
		String lentno = request.getParameter("lentno");
		String custname = request.getParameter("custname");
		String outdate = request.getParameter("outdate");
		String indate = request.getParameter("indate");
		String status = request.getParameter("status");
		String class1 = request.getParameter("class1");
	
		if(bookno == null){bookno="";}
		
		if(lentno == null){lentno="";}
		if(custname == null){custname="";}
		if(outdate == null){outdate="";}
		if(indate == null){indate="";}
		if(status == null){status="1";}
		if(class1 == null){class1="S";}
		
		
		try{
			String sql = "select bookname from bookinfo0127 where bookno=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookno);
			rs = pstmt.executeQuery();
			if(rs.next()){
				bookname = rs.getString(1);
			}else if(bookno.equals("")){
				bookname = "";
			}else{
				bookno = "";
				%><script>
					alert("등록되어 있지 않은 도서코드 입니다.");
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<section>
		<h2>도서 대출 예약 정보 등록 화면</h2>
		<form name="iu_form" method="post" action="reservation0127_insert.jsp">
			<table id="iu_table">
				<tr>
					<th>대출번호</th>
					<td><input type="text" name="lentno" value="<%=lentno %>"></td>
					<th>고객성명</th>
					<td><input type="text" name="custname" value="<%=custname %>"></td>
				</tr>
				<tr>
					<th>도서코드</th>
					<td><input type="text" name="bookno" onchange="booknoCheck()" value="<%=bookno %>"></td>
					<th>도서이름</th>
					<td><input type="text" name="bookname" value="<%=bookname %>" readonly></td>
				</tr>
				<tr>
					<th>대출일자</th>
					<td><input type="text" name="outdate" value="<%=outdate %>" maxlength="10"></td>
					<th>반납일자</th>
					<td><input type="text" name="indate" value="<%=indate %>"  maxlength="10" readonly></td>
				</tr>
				<tr>
					<th>대출상태</th>
					<td>
						<input type="radio" name="status" value="1" <%if(status.equals("1")){%> checked <%} %> onclick="statusClick(this)"> 대출
						<input type="radio" name="status" value="2" <%if(status.equals("2")){%> checked <%} %> onclick="statusClick(this)"> 반납
					</td>
					<th>도서이름</th>
					<td>
						<select name="class1">
							<option value="S" <%if(class1.equals("S")){%> selected <%} %>>S</option>
							<option value="A" <%if(class1.equals("A")){%> selected <%} %>>A</option>
							<option value="B" <%if(class1.equals("B")){%> selected <%} %>>B</option>
							<option value="C" <%if(class1.equals("C")){%> selected <%} %>>C</option>
						</select>
					</td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="check()">저장</button>
						<button type="button" onclick="retry()">취소</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>