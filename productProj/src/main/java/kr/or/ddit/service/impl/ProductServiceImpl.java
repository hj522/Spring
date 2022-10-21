package kr.or.ddit.service.impl;

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
}
