package kr.or.ddit.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.ddit.service.ProductService;
import kr.or.ddit.vo.CartDetVO;
import kr.or.ddit.vo.CartVO;
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
	
	// 장바구니 특정 상품 삭제
	// 요청 URI: /removeCart?productId=P1234
	@RequestMapping(value="/removeCart",method = RequestMethod.GET)
	public String removeCart(@RequestParam String productId, Model model,
			@ModelAttribute ProductVO productVO, HttpServletRequest request) {
		log.info("removeCart productId: " + productId);
		
		HttpSession session = request.getSession();
		ArrayList<ProductVO> cartlist = (ArrayList<ProductVO>)session.getAttribute("cartlist");
		
		for(int i=0; i<cartlist.size(); i++) {
			if(cartlist.get(i).getProductId().equals(productId)) {
				cartlist.remove(cartlist.get(i));
			}
		}
		return "redirect:/cart";	// "product/cart"와 동일
	}
	
	// 장바구니 전체 비우기
	// 요청 URI: /deleteCart?cartId=~~~~
	@RequestMapping(value="/deleteCart", method=RequestMethod.GET)
	public String deleteCart(@RequestParam String cartId, HttpSession session) {
		
		log.info("deleteCart cartId: " + cartId);
		
		// cartId가 없네? => cart.jsp로 이동
		if(cartId==null || cartId.trim().equals("")) {
			return "redirect:/cart";
		}
		
		session.invalidate();
		
		return "redirect:/cart";
	}
	
	// 장바구니에서 주문하기 클릭
	// 요청 URI: /shippingInfo?cartId=~~~~~~
	@RequestMapping(value="/shippingInfo",method=RequestMethod.GET)
	public String shippingInfo(@RequestParam String cartId, Model model) {
		log.info("cartId: " + cartId);
		
		model.addAttribute("cartId", cartId);
		
		// forwarding
		return "/product/shippingInfo";
	}
	
	// 요청 URI: /processShippingInfo
	// 요청파라미터 => 배송정보들
	@RequestMapping(value="/processShippingInfo",method=RequestMethod.POST)
	public String processShippingInfo(@ModelAttribute CartVO cartVO, HttpServletResponse response, Model model) throws Exception {
		
		Cookie cartId = new Cookie("Shipping_cartId", URLEncoder.encode(cartVO.getCartId(),"UTF-8"));
		Cookie name = new Cookie("Shipping_name", URLEncoder.encode(cartVO.getName(),"UTF-8"));
		Cookie shippingDate = new Cookie("Shipping_shippingDate", URLEncoder.encode(cartVO.getShippingDate(),"UTF-8"));
		Cookie country = new Cookie("Shipping_country", URLEncoder.encode(cartVO.getCountry(),"UTF-8"));
		Cookie zipCode = new Cookie("Shipping_zipCode", URLEncoder.encode(cartVO.getZipCode(),"UTF-8"));
		Cookie addressName = new Cookie("Shipping_addressName", URLEncoder.encode(cartVO.getAddressName(),"UTF-8"));
		Cookie addressDetail = new Cookie("Shipping_addressDetail", URLEncoder.encode(cartVO.getAddressDetail(),"UTF-8"));

		// 쿠키의 유효 기간을 1일로 설정(초단위) -> 1초*60*60*24
		cartId.setMaxAge(24*60*60);
		name.setMaxAge(24*60*60);
		shippingDate.setMaxAge(24*60*60);
		country.setMaxAge(24*60*60);
		zipCode.setMaxAge(24*60*60);
		addressName.setMaxAge(24*60*60);
		addressDetail.setMaxAge(24*60*60);
		
		// 생성된 쿠키를 등록(서버에서 생성이 되어 response객체에 담겨서 클라이언트로 가져와짐)
		response.addCookie(cartId);
		response.addCookie(name);
		response.addCookie(shippingDate);
		response.addCookie(country);
		response.addCookie(zipCode);
		response.addCookie(addressName);
		response.addCookie(addressDetail);
		
		model.addAttribute("cartVO", cartVO);
		
		// forwarding
		return "product/orderConfirmation";
	}
	
	// 배송 후 마무리. 세션 종료. 쿠키 종료.
	// 요청URI : /thankCustomer
	@RequestMapping(value="/thankCustomer", method=RequestMethod.GET)
	public String thankCustomer(HttpServletRequest request, CartVO cartVO) throws Exception {
		
		//1. 쿠키 정보를 가져와 CART 테이블로 insert
	      String Shipping_name = "";
	      String Shipping_zipCode = "";
	      String Shipping_country = "";
	      String Shipping_addressName = "";
	      String Shipping_addressDetail = "";
	      String Shipping_shippingDate = "";
	      String Shipping_cartId = "";

	      Cookie[] cookies = request.getCookies();
	      
	      //쿠키의 개수만큼 반복
	      for(int i=0;i<cookies.length;i++){
	         Cookie thisCookie = cookies[i];
	         //쿠키 이름 가져옴
//	          out.print(thisCookie.getName() + "<br />");
	         //쿠키 값 가져옴
//	          out.print(URLDecoder.decode(thisCookie.getValue(),"UTF-8")+"<br />");
	         if(thisCookie.getName().equals("Shipping_name")){
	            Shipping_name = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setName(Shipping_name);
	         }
	         if(thisCookie.getName().equals("Shipping_zipCode")){
	            Shipping_zipCode = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setZipCode(Shipping_zipCode);
	         }
	         if(thisCookie.getName().equals("Shipping_country")){
	            Shipping_country = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setCountry(Shipping_country);
	         }
	         if(thisCookie.getName().equals("Shipping_addressName")){
	            Shipping_addressName = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setAddressName(Shipping_addressName);
	         }
	         if(thisCookie.getName().equals("Shipping_addressDetail")){
	        	 Shipping_addressDetail = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	        	 cartVO.setAddressDetail(Shipping_addressDetail);
	         }
	         if(thisCookie.getName().equals("Shipping_shippingDate")){
	            Shipping_shippingDate = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setShippingDate(Shipping_shippingDate);
	         }
	         if(thisCookie.getName().equals("Shipping_cartId")){
	            Shipping_cartId = URLDecoder.decode(thisCookie.getValue(),"UTF-8");
	            cartVO.setCartId(Shipping_cartId);
	         }
	         
	      }
	      log.info("cartVO: " + cartVO.toString());

	      // 2. 세션 정보를 가져와 CART_DET 테이블로 다중 insert
	      HttpSession session = request.getSession();
	      List<ProductVO> list = (ArrayList<ProductVO>)session.getAttribute("cartlist");
	      
	      // 3. CartVO: CartDetVO = 1 : N
	      List<CartDetVO> cartDetVOList = new ArrayList<CartDetVO>();
	      for(ProductVO vo : list) {
	    	  CartDetVO cartDetVO = new CartDetVO();
	    	  cartDetVO.setCartId(cartVO.getCartId());
	    	  cartDetVO.setProductId(vo.getProductId());
	    	  cartDetVO.setUnitPrice(vo.getUnitPrice());
	    	  cartDetVO.setQuantity(vo.getQuantity());
	    	  cartDetVO.setAmount(vo.getUnitPrice() * vo.getQuantity());
	    	  
	    	  cartDetVOList.add(cartDetVO);
	      }
	      cartVO.setCartDetVOList(cartDetVOList);
	      
	      log.info("cartVO: " + cartVO.toString());
	      
	      this.productService.thankCustomer(cartVO);
	      
	      //forwarding
	      return "product/thankCustomer";
	}
	
	// 주문 취소
	// 요청URI: /checkOutCancelled
	// 목적: 세션 종료
	@RequestMapping(value="/checkOutCancelled", method=RequestMethod.GET)
	public String checkOutCancelled() {
		// forwarding
		return "product/checkOutCancelled";
	}
	
	// PRODUCT테이블의 기본키 자동 생성
	// JSON 데이터로 return : {"productId":"P1236"}
	@ResponseBody
	@PostMapping("/getProductId")
	public Map<String, String> getProductId() {
		Map<String,String> map = new HashMap<String, String>();
		
		String productId = this.productService.getProductId();
		
		map.put("productId", productId);
		
		return map;
	}
}
