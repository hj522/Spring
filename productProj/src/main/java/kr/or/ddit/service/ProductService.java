package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.ProductVO;

public interface ProductService {
	public int insert(ProductVO productVO);

	public List<ProductVO> list(String keyword);	// 상품 목록

	public ProductVO selectDetail(ProductVO productVO); // 특정 상품 상세
	
	public int update(ProductVO productVO); // 상품 수정
	
	public int delete(String productId); // 상품 삭제

	public int thankCustomer(CartVO cartVO);	// CART 및 CART_DET 테이블에 insert

}
