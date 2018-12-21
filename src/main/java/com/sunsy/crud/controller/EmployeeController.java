package com.sunsy.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sunsy.crud.bean.Employee;
import com.sunsy.crud.bean.Msg;
import com.sunsy.crud.service.EmployeeService;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * 分页查询所有员工信息，返回json的形式
	 * 使用responsebody需要加入解析json的包（springboot就不需要了）
	 */
	@RequestMapping("/emps")
	@ResponseBody	
	public Msg getEmpsWithJson(@RequestParam(value="pageNum", defaultValue="1")Integer pageNum) {
		//引入分页插件pagehelper
		//在startPage后的第一个查询会变成分页查询
		PageHelper.startPage(pageNum, 5);
		List<Employee> emps = employeeService.getAll();
		
		//把查询结果放到pageInfo里，这个pagehelper提供的类很好用，封装了各种我们需要的信息，那个5代表连续现实的页数
		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("checkuser")
	public Msg checkuser(@RequestParam("empName") String empName) {
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail();
		}
	}
	
	
//	/**
//	 * 分页查询所有员工信息，返回model的形式
//	 * @return
//	 */
//	@RequestMapping("/emps")
//	public String getEmps(@RequestParam(value="pageNum", defaultValue="1")Integer pageNum, Model model) {
//		
//		//引入分页插件pagehelper
//		//在startPage后的第一个查询会变成分页查询
//		PageHelper.startPage(pageNum, 5);
//		List<Employee> emps = employeeService.getAll();
//		
//		//把查询结果放到pageInfo里，这个pagehelper提供的类很好用，封装了各种我们需要的信息，那个5代表连续现实的页数
//		PageInfo<Employee> page = new PageInfo<Employee>(emps, 5);
//		
//		//把pageinfo放到model里，这样就会传给界面
//		model.addAttribute("pageInfo", page);
//		return "list";
//	}
}
