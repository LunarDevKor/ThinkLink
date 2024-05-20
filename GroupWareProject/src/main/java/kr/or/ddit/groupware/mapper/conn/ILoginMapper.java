package kr.or.ddit.groupware.mapper.conn;

import kr.or.ddit.groupware.controller.conn.LoginController;
import kr.or.ddit.groupware.vo.EmployeeVO;
import kr.or.ddit.groupware.vo.LogVO;

/**
 * 로그인 SQL Mapper
 * @author 이명문
 * @version 1.0
 * @see LoginController
 */
public interface ILoginMapper {

	public EmployeeVO readByEmployeeId(String username);

	public EmployeeVO loginCheck(EmployeeVO employeeVO);

}
