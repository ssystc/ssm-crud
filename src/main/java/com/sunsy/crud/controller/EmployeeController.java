package com.sunsy.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sunsy.crud.bean.Employee;
import com.sunsy.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * 分页查询所有员工信息
	 * @return
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNum", defaultValue="1")Integer pageNum, Model model) {
		
		//引入分页插件pagehelper
		//在startPage后的第一个查询会变成分页查询
		PageHelper.startPage(pageNum, 5);
		List<Employee> emps = employeeService.getAll();
		
		//把查询结果放到pageInfo里，这个pagehelper提供的类很好用，封装了各种我们需要的信息，那个5代表连续现实的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		
		//把pageinfo放到model里，这样就会传给界面
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
