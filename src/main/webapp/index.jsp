<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.jsp.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crud</title>
    <link rel="stylesheet" type="text/css" href="<%= application.getContextPath() %>/css/index.css">
</head>

<body>
	    	
    
    <div class="container">
    <ul>
        <li><a href="<%= application.getContextPath() %>/create.jsp">Add Note</a></li>
    </ul>


        <table border="1" cellpadding="10" cellspacing="0">
            <thead>
                <tr>
                    
                    <th>Note Title</th>
                    <th>Description</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/notes";
                        String user = "root";
                        String password = "";
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM note";
                        rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int id = rs.getInt("SrNo.");  // Assuming 'SrNo' is the unique ID for each row
                            String title = rs.getString("Note Title");
                            String description = rs.getString("Descri");
                            String date = rs.getString("date");

                            // Output each row of data into the table
                            out.println("<tr>");
                            
                            out.println("<td>" + title + "</td>");
                            out.println("<td>" + description + "</td>");
                            out.println("<td>" + date + "</td>");
                            out.println("<td>");
                            out.println("<a href='update.jsp?id=" + id + "'>Update</a> | ");
                            out.println("<a href='delete.jsp?id=" + id + "' onclick='return confirm(\"Are you sure?\");'>Delete</a>");
                            out.println("</td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5'>Error: Could not retrieve data from database.</td></tr>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { }
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
