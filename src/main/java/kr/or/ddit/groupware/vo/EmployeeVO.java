package kr.or.ddit.groupware.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class EmployeeVO {
	 private int emplNo;
	 private int clsfCode;
	 private String clsfNm;
	 private String deptCode;
	 private String deptNm;
	 private String emplNm;
	 private String emplId;
	 private String emplPassword;
	 private String emplZip;
	 private String emplAdres;
	 private String emplAdres2;
	 private String emplEmail;
	 private String emplTelno;
	 private int emplBirth;
	 private String emplIhidnum;
	 private String emplProflPhoto;
	 private String emplSign;
	 private String enabled;
	 private Date emplEncpn;
	 private Date rgsde;
	 private int register;
	 private Date updde;
	 private int updusr;
	 
	 private String longevity;
	 private Double longevityDouble;
	 
	 private ClassOfPositionVO classOfPositionVO;
	 private EmployeeDetailVO employeeDetailVO;
	 
	 private List<EmpAuthorityVO> AuthList;
}
