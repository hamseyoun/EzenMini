package com.kook.ezenPJT.command;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;

import com.kook.ezenPJT.dao.EzenDao;
import com.kook.ezenPJT.dto.EzenJoinDto;
import com.kook.ezenPJT.util.Constant;




public class EzenJoinCommand implements EzenCommand {

	@Override
	public void execute(HttpServletRequest request, Model model) {
		//��ȣȭ ��ü
		BCryptPasswordEncoder passwordEncoder= Constant.passwordEncoder;
		//form�� �Է� ���Ұ��� ����
		String bid = request.getParameter("pid");
		String bpw = request.getParameter("ppw"); //��ȣȭ��
		String baddress = request.getParameter("paddress");
		String bhobby = request.getParameter("phobby");
		String bprofile = request.getParameter("pprofile");
		
		//��ȣȭ�� bpw�� bpw_org�� ����
		String bpw_org = bpw; //bPw_org�� ��ȣȭ�� pw
		bpw = passwordEncoder.encode(bpw_org); //encode�޼���� ��ȣȭ
		
		EzenJoinDto dto = new EzenJoinDto(bid,bpw,baddress,bhobby,bprofile,null,null);
		
		EzenDao edao = Constant.edao;
		String result = edao.join(dto);
		System.out.println("result : " + result);
		
		request.setAttribute("result", result);
	}

}
