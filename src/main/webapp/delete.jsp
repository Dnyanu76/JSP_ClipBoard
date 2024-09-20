<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Note</title>
    <link rel="stylesheet" type="text/css" href="<%= application.getContextPath() %>/css/delete.css">
</head>
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #8000ff;
    margin: 0;
    padding: 0;
}
</style>
<body>
    <div class="container">
        
        <%
            String id = request.getParameter("id");
            Connection conn = null;
            PreparedStatement pstmt = null;

            if (id != null && !id.isEmpty()) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/notes";
                    String user = "root";
                    String password = "";

                    // Establish the connection
                    conn = DriverManager.getConnection(url, user, password);

                    // Delete the note based on the given ID
                    String sql = "DELETE FROM note WHERE `SrNo.` = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(id));
                    
                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<p>Note deleted successfully!</p>");
                    } else {
                        out.println("<p>Error: Note not found or failed to delete.</p>");
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            } else {
                out.println("<p>Error: No ID provided for deletion.</p>");
            }
        %>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>
