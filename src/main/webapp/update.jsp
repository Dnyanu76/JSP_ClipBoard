<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.jsp.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Note</title>
    <link rel="stylesheet" type="text/css" href="css/update.css">
</head>

<body>
    <div class="container">
        <h1>Update Note</h1>

        <%
            String id = request.getParameter("id"); // Get the ID from the URL
            String title = "";
            String desc = "";
            

            if (id != null && !id.isEmpty()) {
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                

                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/notes";
                    String user = "root";
                    String password = "";
                    conn = DriverManager.getConnection(url, user, password);
                    

                    // Retrieve existing data for the given ID
                    String sql = "SELECT `Note Title`, `Descri` FROM note WHERE  `SrNo.` = ?";
                    
                    pstmt = conn.prepareStatement(sql);
                 
                    pstmt.setInt(1, Integer.parseInt(id));
                    rs = pstmt.executeQuery();
                   
                        

                    if (rs.next()) {
                        title = rs.getString("Note Title");
                        desc = rs.getString("Descri");
                    }

                } catch (Exception e) {
                    out.println("Error: Could not retrieve data.<br>"+e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }
        %>

        <form method="post" action="update.jsp">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="title">Note Title:</label>
            <input type="text" id="title" name="title" value="<%= title %>" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="5" cols="50" required><%= desc %></textarea>

            <input type="submit" value="Update Note">
        </form>

        <%
            String newTitle = request.getParameter("title");
            String newDesc = request.getParameter("description");

            if (newTitle != null && newDesc != null && id != null) {
                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/notes";
                    String user = "root";
                    String password = "";
                    conn = DriverManager.getConnection(url, user, password);

                    // Update note in the database
                    String sql = "UPDATE note SET `Note Title` = ?, `Descri` = ? WHERE `SrNo.` = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, newTitle);
                    pstmt.setString(2, newDesc);
                    pstmt.setInt(3, Integer.parseInt(id));

                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<div class='success'>Note updated successfully!</div>");
                    } else {
                        out.println("<div class='error'>Failed to update note.</div>");
                    }

                } catch (Exception e) {
                    out.println("<div class='error'>Error: Could not update the note."+e.getMessage()+"</div>");
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }
        %>

        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>
