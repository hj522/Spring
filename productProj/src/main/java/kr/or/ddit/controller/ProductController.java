package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.ProductVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@RequestMapping(value="/create",method=RequestMethod.GET)
	public ModelAndView create() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/create");
		
		return mav;
	}
		
	@RequestMapping(value="/create",method=RequestMethod.POST)
	public ModelAndView createPost(ModelAndView mav, @ModelAttribute ProductVO productVO) {
		log.info("productVO: " + productVO.toString());
		
		int result = this.productService.insert(productVO);
		
		log.info("result: " + result);
		
		if(result<1) {
			mav.setViewName("redirect:/create");
		} else {
			mav.setViewName("redirect:/detail?productId=" + productVO.getProductId());
		}
		
		return mav;
	}
	
	// 상품 목록
	@RequestMapping(value="/products",method=RequestMethod.GET)
	public ModelAndView list(ModelAndView mav) {
		
		// Model
		List<ProductVO> data = this.productService.list();
		mav.addObject("data", data);
		// View
		mav.setViewName("product/products");
		return mav;
		
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, @ModelAttribute ProductVO productVO) {
		log.info("detail 확인");
		log.info("productVO: " + productVO.toString());
		
		ProductVO data = this.productService.selectDetail(productVO);
		
		mav.setViewName("product/detail");
		mav.addObject("data", data);
		mav.addObject("productId", data.getProductId());
		
		return mav;
	}
	
	@RequestMapping(value="/update",method=RequestMethod.GET)
	public ModelAndView update(ProductVO productVO, ModelAndView mav) {
		ProductVO data = this.productService.selectDetail(productVO);
		
		mav.addObject("data", data);
		mav.setViewName("product/update");
		
		return mav;
	}
	
	@RequestMapping(value="/update",method = RequestMethod.POST)
	public ModelAndView updatePost(@ModelAttribute ProductVO productVO, ModelAndView mav) {
		log.info("updatePost=>productVO: " + productVO.toString());
		
		int result = this.productService.update(productVO);
		
		if(result>0) {
			mav.setViewName("redirect:/detail?productId=" + productVO.getProductId());
		} else {
			mav.setViewName("redirect:/update?productId=" + productVO.getProductId());
		}
		
		return mav;
	}
	
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public ModelAndView delete(ModelAndView mav, int productId) {
		log.info("productId : " + productId);
		
		int result = this.productService.delete(productId);
		
		if(result>0) {
			mav.setViewName("redirect:/list");
		} else {
			mav.setViewName("redirect:/detail?productId=" + productId);
		}
		
		return mav;
	}
}
