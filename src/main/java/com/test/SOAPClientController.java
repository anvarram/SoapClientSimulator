package com.test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class SOAPClientController {
@RequestMapping("/")
	public String display()
	{
		return "index";
	}	
}
