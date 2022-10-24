package kr.or.ddit.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.ProductDAO;
import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	ProductDAO productDao;
	
	@Override
	public int insert(ProductVO productVO) {
		return this.productDao.insert(productVO);
	}
	
	// 상품 목록
	@Override
	public List<ProductVO> list() {
		return this.productDao.list();
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
}
