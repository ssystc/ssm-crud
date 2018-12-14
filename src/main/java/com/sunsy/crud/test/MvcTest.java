package com.sunsy.crud.test;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageInfo;
import com.sunsy.crud.bean.Employee;


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations= {"classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {

	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		//模拟请求拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pageNum", "9")).andReturn();
		
		//请求成功后，返回值中会有pageInfo
//		HttpServletRequest request = result.getRequest();
//		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		
		//也可以直接从result中获取model，再从model里获取pageInfo，效果和上边注释的代码一样
		ModelAndView model = result.getModelAndView();
		Map<String, Object> modelAndView = model.getModel();
		PageInfo pageInfo = (PageInfo) modelAndView.get("pageInfo");

		
		System.out.println("当前页码：" + pageInfo.getPageNum());
		System.out.println("总页码：" + pageInfo.getPages());
		System.out.println("总记录数：" + pageInfo.getTotal());
		System.out.println("在页面连续显示的页码");
		int[] numbers = pageInfo.getNavigatepageNums();
		for(int i:numbers) {
			System.out.print(i+" ");
		}
		
		//获取员工数据
		List<Employee> list = pageInfo.getList();
		for(Employee emp: list) {
			System.out.println("ID:" + emp.getEmpId() + " Name:" + emp.getEmpName() + " deptName:" + emp.getDepartment().getDeptName());
		}
	}
	
}
