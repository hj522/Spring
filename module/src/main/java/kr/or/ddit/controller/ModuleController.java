package kr.or.ddit.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ModuleController {
	
   @GetMapping("tree/tree")
   public String treeTest() {
	   return "tree/tree";
	}
   
   @GetMapping("tree/tree2")
   public String treeTest2() {
	   return "tree/tree2";
	}
   
   @GetMapping("tree/tree3")
   public String treeTest3() {
	   return "tree/tree3";
	}
}
