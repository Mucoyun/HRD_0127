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
			width: 1150px;
		}
	</style>
	<script>
		function retry() {
			location.href = "/HRD_0127/reservation0127/reservation0127_insert.jsp"
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
			
			String sql = "select count(*) from reservation0127";
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
		<h2>도서 예약정보 조회</h2>
		<p id="count">총 <%=no %>권의 도서 예약 정보가 있습니다.</p><hr>
		<table id="s_table">
			<tr>
				<th width="50">no</th>
				<th width="100">대출번호</th>
				<th width="100">고객성명</th>
				<th width="100">도서코드</th>
				<th width="200">도서명</th>
				<th width="200">대출일자</th>
				<th width="200">반납일자</th>
				<th width="100">대출상태</th>
				<th width="100">등급</th>
				<th width="100">관리</th>
			</tr>
			<%
			try{
				no = 0;
				String sql = "select a.lentno,a.custname,a.bookno,b.bookname,to_char(a.outdate,'yyyy-mm-dd'),to_char(a.indate,'yyyy-mm-dd'),a.status,a.class from reservation0127 a,bookinfo0127 b where a.bookno=b.bookno  order by bookno asc";
				pstmt = conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				while(rs.next()){
					no++;
					String lentno = rs.getString(1);
					String custname = rs.getString(2);
					String bookno = rs.getString(3);
					String bookname = rs.getString(4);
					String outdate = rs.getString(5);
					String indate = rs.getString(6);
					String status = rs.getString(7);
					String class1 = rs.getString(8);
					
					if(custname == null){custname="";}
					if(outdate == null){outdate="";}
					if(indate == null){indate="";}
					if(status.equals("1")){status="대출";}
					else if(status.equals("2")){status="반납";}
					if(class1 == null){class1="";}
					
					%>
					<tr>
						<td><%=no %></td>
						<td><a href="/HRD_0127/reservation0127/reservation0127_update.jsp?send_lentno=<%=lentno%>"><%=lentno %></a></td>
						<td><%=custname %></td>
						<td><%=bookno %></td>
						<td><%=bookname %></td>
						<td><%=outdate %></td>
						<td><%=indate %></td>
						<td><%=status %></td>
						<td><%=class1 %></td>
						<td>
							<a href="/HRD_0127/reservation0127/reservation0127_delete.jsp?send_lentno=<%=lentno%>"
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