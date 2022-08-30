package manager.product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;

//싱글톤 패턴 이용
public class ProductDAO {
	private ProductDAO() {}
	private static ProductDAO instance = new ProductDAO();
	
	public static ProductDAO getInstance() {
		return instance; //클래스.인스턴스 사용할 수 있도록
	}
	
	//DB연결, 질의를 위한 객체변수
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//상품등록 메소드
	public void insertProduct(ProductDTO product) {
		String sql ="insert into product(product_kind, product_name, product_price, product_count, "
				+ "product_image, product_content, product_company, discount_rate)"
				+ "values(?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getProduct_image());
			pstmt.setString(6, product.getProduct_content());
			pstmt.setString(7, product.getProduct_company());
			pstmt.setInt(8, product.getDiscount_rate());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("insertProduct 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	//상품 조회 메소드 -> 전체 수량 (기본)
	public int getProductCount() {
		String sql="select count(*) from product";
		int cnt= 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("getProductCount 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//상품 조회 메소드 -> 분류별
		public int getProductCount(String product_kind) {
			String sql="select count(*) from product where product_kind=? ";
			int cnt = 0;
			
			try {
				conn = JDBCUtil.getConnection();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, product_kind);
				rs = pstmt.executeQuery();
				rs.next();
				cnt = rs.getInt(1);
				
			} catch(Exception e) {
				System.out.println("getProductCount 메소드 :" + e.getMessage());
				e.printStackTrace();
			} finally {
				JDBCUtil.close(conn, pstmt, rs);
			}
			return cnt;
		}
	
	//상품 조회 메소드 -> 전체 수량 (검색결과)
	public int getProductCount(String s_search, String i_search) {
		String sql="select count(*) from product where ";
		
		if(s_search.equals("제목")) {
			sql += "product_name";
		} else if(s_search.equals("제조사")) {
			sql += "product_company";
		} 
		sql+= " like ?";
		
		int cnt= 0;
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + i_search + "%");
			rs = pstmt.executeQuery();
			rs.next();
			cnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("getProductCount 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return cnt;
	}
	
	//상품 조회 메소드 -> 전체 수량 (기본) -> 페이징 처리
	public List<ProductDTO> getProductList(int startRow, int pageSize) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				//9개 정보
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_company(rs.getString("product_company"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			
		} catch(Exception e) {
			System.out.println("getProductList 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	//상품 조회 메소드 -> 전체 수량 (검색결과) -> 페이징 처리
	public List<ProductDTO> getProductList(int startRow, int pageSize, String s_search, String i_search) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where ";
		
		if(s_search.equals("제목")) {
			sql += "product_name";
		} else if(s_search.contentEquals("내용")) {
			sql += "product_content";
		} else if(s_search.equals("제조사")) {
			sql += "product_company";
		} 
		
		sql+= " like ? order by product_id desc limit ?, ?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + i_search + "%");
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO();
				//9개 정보
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_count(rs.getInt("product_count"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_company(rs.getString("product_company"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				product.setReg_date(rs.getTimestamp("reg_date"));
				productList.add(product);
			}
			
		} catch(Exception e) {
			System.out.println("getProductList 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	//상품 조회 메소드 -> 1건 상세보기
	public ProductDTO getProduct(int product_id) {
		ProductDTO product = new ProductDTO();
		String sql =  "select * from product where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			rs = pstmt.executeQuery();
			
			rs.next();
			//10개 정보
			product.setProduct_id(rs.getInt("product_id"));
			product.setProduct_kind(rs.getString("product_kind"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_price(rs.getInt("product_price"));
			product.setProduct_count(rs.getInt("product_count"));
			product.setProduct_image(rs.getString("product_image"));
			product.setProduct_content(rs.getString("product_content"));
			product.setProduct_company(rs.getString("product_company"));
			product.setDiscount_rate(rs.getInt("discount_rate"));
			product.setReg_date(rs.getTimestamp("reg_date"));
			
		} catch(Exception e) {
			System.out.println("getProduct 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return product;
	}
	
	//상품 수정 메소드
	public void updateProduct(ProductDTO product) {
		String sql = "update product set product_kind=?, product_name=?, product_price=?, product_count=?, "
				+ "product_image=?, product_content=?, product_company=?, discount_rate=? where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProduct_kind());
			pstmt.setString(2, product.getProduct_name());
			pstmt.setInt(3, product.getProduct_price());
			pstmt.setInt(4, product.getProduct_count());
			pstmt.setString(5, product.getProduct_image());
			pstmt.setString(6, product.getProduct_content());
			pstmt.setString(7, product.getProduct_company());
			pstmt.setInt(8, product.getDiscount_rate());
			pstmt.setInt(9, product.getProduct_id());
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("updateProduct 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	//상품 삭제 메소드
	public void deleteProduct(int product_id) {
		String sql = "delete from product where product_id=?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_id);
			pstmt.executeUpdate();
			
		} catch(Exception e) {
			System.out.println("deleteProduct 메소드: " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	//----------------------------------------------------------------------------------------mall
	
	//추천상품 메소드
	public List<ProductDTO> getProductList(String [] nProducts, int chk) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		
		String sql1 = "select * from product where product_kind =? order by reg_date limit 30";
		
		try {
			conn = JDBCUtil.getConnection();
			
			for(String s : nProducts) { 
				if(chk == 1) pstmt = conn.prepareStatement(sql1); 	
				
				pstmt.setString(1, s);
				rs = pstmt.executeQuery(); 
				while(rs.next() ) {
					product = new ProductDTO();
					product.setProduct_id(rs.getInt("product_id"));
					product.setProduct_image(rs.getString("product_image"));
					productList.add(product); 
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	
	//상품 종류별 보기 메소드 - shopMain.jsp
	public List<ProductDTO> getProductList(int startRow, int pageSize, String product_kind) {
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		ProductDTO product = null;
		String sql = "select * from product where product_kind =? order by product_id desc limit ?,?";
		
		try {
			conn = JDBCUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product_kind);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				product = new ProductDTO(); 
				product.setProduct_id(rs.getInt("product_id"));
				product.setProduct_kind(rs.getString("product_kind"));
				product.setProduct_name(rs.getString("product_name"));
				product.setProduct_price(rs.getInt("product_price"));
				product.setProduct_image(rs.getString("product_image"));
				product.setProduct_company(rs.getString("product_company"));
				product.setDiscount_rate(rs.getInt("discount_rate"));
				productList.add(product);
			}	
			
		} catch(Exception e) {
			System.out.println("getProductList(product_kind): " + e.getMessage());
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return productList;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
