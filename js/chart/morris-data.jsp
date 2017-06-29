<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.sql.*, java.util.*" %> 

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
// Morris.js Charts for 고운 서점 Admin Data
<%

Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

String url = "jdbc:sqlserver://127.0.0.1:1433;databasename=dbBookStore;";
Connection conn = DriverManager.getConnection(url,"Member","1234");

Statement stmt = conn.createStatement();

String strSQL = "";
int count = 0;
ResultSet rs = null;
String recentBuy ="";
	strSQL = "SELECT Top 1 tblBuy.orderDate From tblBuy order By tblBuy.orderDate desc";
	rs = stmt.executeQuery(strSQL);
	if(rs.next()){
		recentBuy = rs.getString("orderDate");
	}
	
	strSQL = "SELECT tblBuy.orderDate, Sum(tblBuy.volume*tblBook.cost) AS salesVolume"
			+" FROM tblBuy INNER JOIN tblBook ON tblBuy.bookCode = tblBook.bookCode"
			+" GROUP BY tblBuy.orderDate";

rs = stmt.executeQuery(strSQL);

%>
$(function() {

     // Area Chart
    Morris.Area({
        element: 'morris-area-chart',
        data: [
        <%
        	while(rs.next()){
        	String orderDate = (rs.getString("orderDate"));	
        	int sales = rs.getInt("salesVolume");
        	int i = 0;
        	if(recentBuy.equals(orderDate)){
 		%>
        {
            period: "<%=orderDate%>",
            sales: <%=sales%>
        }
 		<%       		
        	}else{
        %>
            {
            period: "<%=orderDate%>",
            sales: <%=sales%>
        }, 
        
        <% }
        	i++;
        	} //end while%>
        ],
        xkey: 'period',
        ykeys: ['sales'],
        labels: ['일별 판매량'],
        xLabels: "day",
        pointSize: 2,
        hideHover: 'auto',
        resize: true
    });
<%
	strSQL = "SELECT TOP 3 tblBook.genre, Sum(tblBook.cost*tblBuy.volume) AS sumOfVolume"
			+" FROM tblBook INNER JOIN tblBuy ON tblBook.bookCode = tblBuy.bookCode"
			+" GROUP BY tblBook.genre order By sumOfVolume desc";

rs = stmt.executeQuery(strSQL);
String genre ="";
int sales = 0;
%>
    // Donut Chart
    Morris.Donut({
        element: 'morris-donut-chart',
        data: [
<%
		int i = 0;
		while(rs.next()){
			i++;
			genre = rs.getString("genre");
			sales = rs.getInt("sumOfVolume");
		if(i < 3){
%>
		{
		    label: "<%=genre%>",
		    value: <%=sales%>
		},
<%
		}else{	
%>
		{
		    label: "<%=genre%>",
		    value: <%=sales%>
		}
<%
	}

		
		} //end while
%>

        ],
        resize: true
    });

    // Line Chart
    Morris.Line({
        // ID of the element in which to draw the chart.
        element: 'morris-line-chart',
        // Chart data records -- each entry in this array corresponds to a point on
        // the chart.
        data: [{
            d: '2012-10-01',
            visits: 802
        }, {
            d: '2012-10-02',
            visits: 783
        }, {
            d: '2012-10-03',
            visits: 820
        }, {
            d: '2012-10-04',
            visits: 839
        }, {
            d: '2012-10-05',
            visits: 792
        }, {
            d: '2012-10-06',
            visits: 859
        }, {
            d: '2012-10-07',
            visits: 790
        }, {
            d: '2012-10-08',
            visits: 1680
        }, {
            d: '2012-10-09',
            visits: 1592
        }, {
            d: '2012-10-10',
            visits: 1420
        }, {
            d: '2012-10-11',
            visits: 882
        }, {
            d: '2012-10-12',
            visits: 889
        }, {
            d: '2012-10-13',
            visits: 819
        }, {
            d: '2012-10-14',
            visits: 849
        }, {
            d: '2012-10-15',
            visits: 870
        }, {
            d: '2012-10-16',
            visits: 1063
        }, {
            d: '2012-10-17',
            visits: 1192
        }, {
            d: '2012-10-18',
            visits: 1224
        }, {
            d: '2012-10-19',
            visits: 1329
        }, {
            d: '2012-10-20',
            visits: 1329
        }, {
            d: '2012-10-21',
            visits: 1239
        }, {
            d: '2012-10-22',
            visits: 1190
        }, {
            d: '2012-10-23',
            visits: 1312
        }, {
            d: '2012-10-24',
            visits: 1293
        }, {
            d: '2012-10-25',
            visits: 1283
        }, {
            d: '2012-10-26',
            visits: 1248
        }, {
            d: '2012-10-27',
            visits: 1323
        }, {
            d: '2012-10-28',
            visits: 1390
        }, {
            d: '2012-10-29',
            visits: 1420
        }, {
            d: '2012-10-30',
            visits: 1529
        }, {
            d: '2012-10-31',
            visits: 1892
        }, ],
        // The name of the data record attribute that contains x-visitss.
        xkey: 'd',
        // A list of names of data record attributes that contain y-visitss.
        ykeys: ['visits'],
        // Labels for the ykeys -- will be displayed when you hover over the
        // chart.
        labels: ['Visits'],
        // Disables line smoothing
        smooth: false,
        resize: true
    });

    // Bar Chart
    Morris.Bar({
        element: 'morris-bar-chart',
        data: [{
            device: 'iPhone',
            geekbench: 136
        }, {
            device: 'iPhone 3G',
            geekbench: 137
        }, {
            device: 'iPhone 3GS',
            geekbench: 275
        }, {
            device: 'iPhone 4',
            geekbench: 380
        }, {
            device: 'iPhone 4S',
            geekbench: 655
        }, {
            device: 'iPhone 5',
            geekbench: 1571
        }],
        xkey: 'device',
        ykeys: ['geekbench'],
        labels: ['Geekbench'],
        barRatio: 0.4,
        xLabelAngle: 35,
        hideHover: 'auto',
        resize: true
    });


});
</script>
<title>Insert title here</title>
</head>
<body>

</body>
</html>