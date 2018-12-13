package com.sunsy.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sunsy.crud.dao.DepartmentMapper;
import com.sunsy.crud.dao.EmployeeMapper;

@ContextConfiguration(locations={"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {
	

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Test
	public void testCRUD() {
		
//		//测试插入部门
//		departmentMapper.insertSelective(new Department(1, "研发部"));
//		departmentMapper.insertSelective(new Department(2, "销售部"));
		
//		//测试插入员工
//		employeeMapper.insertSelective(new Employee(null, "sunsy", "M", "sunsy@123.com", 1));
		
		
//		//批量插入，需要创建一个可以执行批量操作的sqlSession
//		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
//		
//		
//		Long startTime1 = System.currentTimeMillis();
//		for(int i = 0; i<1000; i++) {
//			mapper.insertSelective(new Employee(null, i+"", "M", "test@123.com", 1));
//		}
//		Long endTime1 = System.currentTimeMillis();
//		System.out.println("插入完成" + "耗时：" + (endTime1-startTime1));
		
		
//		//测试查询
//		Employee emp = employeeMapper.selectByPrimaryKey(1);
//		System.out.println(emp.getDepartment());
//		
//		Employee emp1 = employeeMapper.selectByPrimaryKeyWithDept(1);
//		System.out.println(emp1.getDepartment());
		
		
	}
	
}
