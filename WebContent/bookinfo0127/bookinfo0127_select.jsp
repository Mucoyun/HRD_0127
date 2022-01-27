<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 22</title>
	<style>
		#count{
			display: block;
			margin: 0 auto;
			width: 800px;
		}
	</style>
	<script>
		function retry() {
			location.href = "/HRD_0127/bookinfo0127/bookinfo0127_insert.jsp"
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		int no = 0;
		try{
			
			String sql = "select count(*) from bookinfo0127";
			pstmt = conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			if(rs.next()){
				no = rs.getInt(1);
			}else{
				no=0;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<section>
		<h2>도서 정보 조회</h2>
		<p id="count">총 <%=no %>권의 도서 정보가 있습니다.</p><hr>
		<table id="s_table">
			<tr>
				<th width="100">no</th>
				<th width="200">도서코드</th>
				<th width="100">저자</th>
				<th width="300">도서이름</th>
				<th width="100">관리</th>
			</tr>
			<%
			try{
				no = 0;
				String sql = "select bookno,author,bookname from bookinfo0127 order by bookno asc";
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					no++;
					String bookno = rs.getString(1);
					String author = rs.getString(2);
					String bookname = rs.getString(3);
					%>
					<tr>
						<td><%=no %></td>
						<td><a href="/HRD_0127/bookinfo0127/bookinfo0127_update.jsp?send_bookno=<%=bookno%>"><%=bookno %></a></td>
						<td><%=author %></td>
						<td><%=bookname %></td>
						<td>
						<a href="/HRD_0127/bookinfo0127/bookinfo0127_delete.jsp?send_bookno=<%=bookno%>"
						onclick="if(!confirm('정말로 삭제하시겠습니까?')){ return false; }">삭제</a>
						</td>
					</tr>
					<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			%>
		</table>
		<button id="btn" type="button" onclick="retry()">도서 정보 추가</button>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>