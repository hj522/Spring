package kr.or.ddit.controller;

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
}
