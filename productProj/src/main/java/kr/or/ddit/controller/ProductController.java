package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public ModelAndView list(ModelAndView mav, @RequestParam(value="keyword", required=false) String keyword) {
		
		// Model
		List<ProductVO> list = this.productService.list(keyword);
		
		for(ProductVO vo :list) {
			log.info("vo: " + vo.toString());
		}
		
		mav.setViewName("product/products");
		mav.addObject("data", list);

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
	
	public ModelAndView detail(ModelAndView mav, @RequestParam(value="keyword", required=false) String keyword) {
		
		List<ProductVO> list = this.productService.list(keyword);
		
		for(ProductVO vo : list) {
			log.info("vo: " + vo.toString());
		}
		
		// forwarding
		mav.setViewName("product/list");
		mav.addObject("data", list);
		
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
	public ModelAndView delete(ModelAndView mav, String productId) {
		log.info("productId : " + productId);
		
		int result = this.productService.delete(productId);
		
		if(result>0) {
			mav.setViewName("redirect:/products");
		} else {
			mav.setViewName("redirect:/detail?productId=" + productId);
		}
		
		return mav;
	}
	
	// 요청URI: /addCart
	// 요청파라미터: {"productId":"P1234"}
	// 장바구니(=세션(cartlist))에 해당 상품을 넣음
	// spring에서 요청파라미터를 매개변수로 받을 수 있다
	@RequestMapping(value="/addCart",method = RequestMethod.POST)
	public String addCart(@RequestParam String productId, Model model, @ModelAttribute ProductVO productVO, HttpServletRequest request) {
		log.info("productId: " + productId);
		log.info("productVO " + productVO.toString());
		
		// 장바구니에 넣을 상품이 없다면..
		if(productId==null) {
			return "redirect:/detail?productId=" + productId;	
		}
		
		// 장바구니에 넣을 상품 찾기
		ProductVO vo = this.productService.selectDetail(productVO);
		log.info("vo: " + vo);
		
		// 검색해보니 상품 결과가 없다면
		if(vo==null) {
			// [상품없음] 예외처리 페이지로 이동
			return "redirect:/exceptionNoProductId";
		}
		
		// 장바구니(세션) => 세션명: cartlist
		HttpSession session = request.getSession();
		
		// 세션에 cartlist가 있는가...
		ArrayList<ProductVO> list = (ArrayList<ProductVO>)session.getAttribute("cartlist");
		
		// 장바구니가 없다면 생성해보자
		if(list==null) {
			// list는 null이므로 여기서 리스트를 생성해줘야 함
			list = new ArrayList<ProductVO>();
			// cartlist라는 세션명으로 생성
			session.setAttribute("cartlist", list);
		}
		
		// 장바구니가 있으면 다음을 실행
		int cnt = 0; // 장바구니에 상품이 담긴 개수
		
		for(int i=0;i<list.size();i++) {
			// list는 session 장바구니(P1234,P1235,P1236)
			// list.get(0) => P1234상품 1행
			// list.get(0).getProductId() => P1234
			if(list.get(i).getProductId().equals(productId)) {
				cnt++;
				// 장바구니에 상품이 이미 들어있다면 장바구니에 담은 개수만 1 증가
				list.get(i).setQuantity(list.get(i).getQuantity()+1);
			}
		}
		
		// 장바구니에 해당 상품이 없다면
		if(cnt==0) {
			vo.setQuantity(1);
			// 최종목표: 장바구니에 상품을 추가
			list.add(vo);
		}
		
		// 장바구니 확인
		for(ProductVO pv : list) {
			log.info("pv " + pv.toString());
		}
		
		return "redirect:/detail?productId=" + productId;
	}
	
	// 요청URI: /cart
	@RequestMapping(value="/cart",method=RequestMethod.GET)
	public String cart() {
		return "product/cart";
	}
}
