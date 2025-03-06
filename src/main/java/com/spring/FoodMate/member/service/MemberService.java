package com.spring.FoodMate.member.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.FoodMate.common.exception.UnauthorizedException;
import com.spring.FoodMate.common.utility.UtilMethod;
import com.spring.FoodMate.member.dao.MemberDAO;
import com.spring.FoodMate.member.dto.BuyerDTO;
import com.spring.FoodMate.member.dto.SellerDTO;

@Service("memberService")
@Transactional(propagation=Propagation.REQUIRED)
public class MemberService {
	@Autowired
	private MemberDAO memberDAO;
	
	public BuyerDTO byrLoginProcess(String userId, String password) throws Exception{
		BuyerDTO userInfo = memberDAO.getInfoById(userId);
		if (userInfo==null) { // 아이디로 검색했는데 암것도 안뜨면
			System.out.println("아이디 없는 오류 뜨는중");
			throw new UnauthorizedException(108); // 아이디나 비번없음 오류
		}
		System.out.println("가져온 유저 이름은" + userInfo.getName());
		System.out.println("입력한 비번은" + password);
		System.out.println("비교할 암호는" + userInfo.getPassword());
		if (!UtilMethod.checkPassword(password, userInfo.getPassword())) {
			// 입력비번을 암호화한거랑 이미 암호화된 비번 비교한게 다르면
			System.out.println("비번 비교 실패한 오류 뜨는중");
			throw new UnauthorizedException(108); // 아이디나 비번없음 오류
		}
		
		return userInfo; // 전부 통과하면 userInfo를 반환
	}
	
	public SellerDTO loginslr(Map  loginMap) throws Exception{
		return memberDAO.loginslr(loginMap);
	}
	
	public String buyerIDoverlapped(String id) throws Exception{
		return memberDAO.selectOverlappedBuyerID(id);
	}
	
	public String sellerIDoverlapped(String id) throws Exception{
		return memberDAO.selectOverlappedSellerID(id);
	}
	
	public String findBuyerId(BuyerDTO buyerVO) throws Exception{
		return memberDAO.selectFindBuyerID(buyerVO);
	}
	
	public String findSellerId(SellerDTO sellerVO) throws Exception{
		return memberDAO.selectFindSellerID(sellerVO);
	}
	
	public String findBuyerPW(BuyerDTO buyerVO) throws Exception{
		return memberDAO.selectFindBuyerPW(buyerVO);
	}
	
	public String findSellerPW(SellerDTO sellerVO) throws Exception{
		return memberDAO.selectFindSellerPW(sellerVO);
	}
	
	public void resetBuyerPW(BuyerDTO buyerVO) throws Exception{
		memberDAO.updateResetBuyerPW(buyerVO);
	}
	
	public void resetSellerPW(SellerDTO sellerVO) throws Exception{
		memberDAO.updateResetSellerPW(sellerVO);
	}
	
	public void addBuyer(BuyerDTO buyerDTO) throws Exception{
		
		String ssn1 = buyerDTO.getSsn1();
		if (ssn1 != null && (ssn1.equals("1") || ssn1.equals("3"))) {
			buyerDTO.setSex("M");
        } else if (ssn1 != null && (ssn1.equals("2") || ssn1.equals("4"))) {
        	buyerDTO.setSex("F");
        } else {
        	buyerDTO.setSex("N");
        }
		
		if(buyerDTO.getEmail_domain().equals("custom")) {
			buyerDTO.setEmail_domain(buyerDTO.getCustomMail());
		}
		
		String email = buyerDTO.getEmail_id() + "@" + buyerDTO.getEmail_domain();
		buyerDTO.setEmail(email);
		
		memberDAO.insertNewBuyer(buyerDTO);
	}
	
	public void addSeller(SellerDTO sellerDTO) throws Exception{
		
		sellerDTO.setBusiness_no(sellerDTO.getBsnum1() + sellerDTO.getBsnum2() + sellerDTO.getBsnum3());
		
		if(sellerDTO.getEmail_domain().equals("custom")) {
			sellerDTO.setEmail_domain(sellerDTO.getCustomMail());
		}
		
		String email = sellerDTO.getEmail_id() + "@" + sellerDTO.getEmail_domain();
		sellerDTO.setEmail(email);
		
		memberDAO.insertNewSeller(sellerDTO);
	}
	
	public void updateBuyer(BuyerDTO buyerDTO) throws Exception{
		memberDAO.updateBuyer(buyerDTO);
	}
	
	public void updateSeller(SellerDTO sellerDTO) throws Exception{
		memberDAO.updateSeller(sellerDTO);
	}
	
	public boolean deleteMember(String buyer_Id, String password) throws Exception{
		BuyerDTO buyerDTO = new BuyerDTO();
		buyerDTO.setByr_id(buyer_Id);
		buyerDTO.setPassword(password);
		if(memberDAO.deleteMember(buyerDTO) > 0) {
			return true;
		} else {
			return false;
		}	
	}
}
