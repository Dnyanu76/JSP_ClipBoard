<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.jsp.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Insert Data</title>
    <link rel="stylesheet" href="<%= application.getContextPath() %>/css/create.css">
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
        <h1>Insert Data</h1>
        <form method="post" action="create.jsp">
            <label for="title">Note Title:</label>
            <input type="text" id="title" name="title" required>
            <label for="description">Description:</label>
            <textarea id="description" name="description" rows="5" cols="50" placeholder="Enter your note here..."></textarea>
            <input type="submit" value="Add Note">
            
        </form>
        <br>

        <%
            String title = request.getParameter("title");
            String desc = request.getParameter("description");
            
            if (title != null && !title.isEmpty() && desc != null && !desc.isEmpty()) {
                String url = "jdbc:mysql://localhost:3306/notes";
                String user = "root";
                String password = "";

                Connection conn = null;
                PreparedStatement pstmt = null;

                try {
                    // Load MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    //out.println("<div class='message success'>Driver loaded successfully!</div>");

                    // Establish the connection
                    conn = DriverManager.getConnection(url, user, password);
                    //out.println("<div class='message success'>Connected to the database successfully!</div>");
                    
                    // Correct SQL query with proper column names
                    String sql = "INSERT INTO note (`Note Title`, `Descri`) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, title);
                    pstmt.setString(2, desc);
                    int rows = pstmt.executeUpdate();
                    if (rows > 0) {
                        out.println("<div class='message success'>Note added successfully!</div>");
                    } else {
                        out.println("<div class='message error'>Failed to add note.</div>");
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<div class='message error'>Error: JDBC Driver not found.</div>");
                } catch (SQLException e) {
                    out.println("<div class='message error'>SQL Error: " + e.getMessage() + "</div>");
                } finally {
                    // Close resources
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { }
                }
            }
        %>
        <a href="index.jsp">Back to Home</a>
    </div>
</body>
</html>
