package com.sunsy.crud.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sunsy.crud.bean.Department;
import com.sunsy.crud.dao.DepartmentMapper;

@ContextConfiguration(locations={"classpath:applicationContext.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {
	

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Test
	public void testCRUD() {
		departmentMapper.insertSelective(new Department(null, "22"));
	}
	
}
