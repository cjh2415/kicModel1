package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcConnection {

	// Connection : oracle server 연결 sql 전달 하기 위한 객체
	// jdbc:oracle:thin:@localhost:1521:xe 연결 url
	public static Connection getConnection() {
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "kic", "1111");
			System.out.println("ok db");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println("error db");
			e.printStackTrace();
		}
		return con;

	}

	public static void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (con != null) {
				con.commit();
				con.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
