package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProductDAO;
import kr.or.ddit.service.ProductService;
import kr.or.ddit.util.FileUploadUtil;
import kr.or.ddit.vo.CartVO;
import kr.or.ddit.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDAO productDao;
	
	@Override
	public int insert(ProductVO productVO) {
		int result = this.productDao.insert(productVO);
		// ATTACH 테이블에 다중 insert
		if(result > 0) { 	// insert 성공 시
			// 파일업로드 및 insert 수행
			FileUploadUtil.fileUploadAction(productVO.getProductImage(), productVO.getProductId());
		}
		return result;
	}
	
	// 상품 목록
	@Override
	public List<ProductVO> list(String keyword) {
		return this.productDao.list(keyword);
	}
	
	// 상품 상세
	@Override
	public ProductVO selectDetail(ProductVO productVO) {
		return this.productDao.selectDetail(productVO);
	}
	
	// 상품 수정
	public int update(ProductVO productVO) {
		return this.productDao.update(productVO);
	}

	// 상품 삭제
	@Override
	public int delete(String productId) {
		return this.productDao.delete(productId);
	}
	
	// CART 및 CART_DET 테이블에 insert
	@Override
	public int thankCustomer(CartVO cartVO) {
		// 1. CART 테이블에 insert
		int cartInCnt = this.productDao.insertCart(cartVO);
		log.info("cartInCnt: " + cartInCnt);
		// 2. CART_DET 테이블에 insert
		return 0;
	}
}
