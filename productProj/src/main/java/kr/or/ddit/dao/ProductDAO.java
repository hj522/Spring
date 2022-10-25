package kr.or.ddit.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.ddit.vo.ProductVO;

@Repository
public class ProductDAO {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insert(ProductVO productVO) {
		return this.sqlSessionTemplate.insert("product.insert",productVO);
	}
	
	// 상품 목록
	public List<ProductVO> list(String keyword) {
		return this.sqlSessionTemplate.selectList("product.list", keyword);
	}

	// 상품 상세 보기
	public ProductVO selectDetail(ProductVO productVO) {
		return this.sqlSessionTemplate.selectOne("product.select_detail", productVO);
	}

	// 상품 수정
	public int update(ProductVO productVO) {
		return this.sqlSessionTemplate.update("product.update", productVO);
	}

	// 상품 삭제
	public int delete(String productId) {
		return this.sqlSessionTemplate.delete("product.delete", productId);
	}
}
