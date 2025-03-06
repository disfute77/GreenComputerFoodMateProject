package com.spring.FoodMate.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.spring.FoodMate.member.dto.BuyerDTO;
import com.spring.FoodMate.member.dto.SellerDTO;

@Repository("memberDAO")
public class MemberDAO {
	@Autowired
	private SqlSession sqlSession;	
	
	
	public BuyerDTO getInfoById(String userId) throws DataAccessException{
		BuyerDTO buyer=(BuyerDTO)sqlSession.selectOne("mapper.member.getInfoById", userId);
	   return buyer;
	}
	
	public SellerDTO loginslr(Map loginMap) throws DataAccessException{
		SellerDTO seller=(SellerDTO)sqlSession.selectOne("mapper.member.loginslr",loginMap);
	   return seller;
	}
	
	public String selectOverlappedBuyerID(String id) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectOverlappedBuyerID",id);
		return result;
	}
	public String selectOverlappedSellerID(String id) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectOverlappedSellerID",id);
		return result;
	}
	
	public String selectFindBuyerID(BuyerDTO buyerVO) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectFindBuyerID",buyerVO);
		return result;
	}
	public String selectFindSellerID(SellerDTO sellerVO) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectFindSellerID",sellerVO);
		return result;
	}
	
	public String selectFindBuyerPW(BuyerDTO buyerVO) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectFindBuyerPW",buyerVO);
		return result;
	}
	public String selectFindSellerPW(SellerDTO sellerVO) throws DataAccessException {
		String result = sqlSession.selectOne("mapper.member.selectFindSellerPW",sellerVO);
		return result;
	}
	
	public void updateResetBuyerPW(BuyerDTO buyerDTO) throws DataAccessException{
		sqlSession.update("mapper.member.updateResetBuyerPW",buyerDTO);
	}
	
	public void updateResetSellerPW(SellerDTO sellerVO) throws DataAccessException{
		sqlSession.update("mapper.member.updateResetSellerPW",sellerVO);
	}
	
	public void insertNewBuyer(BuyerDTO buyerVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewBuyer",buyerVO);
	}
	
	public void insertNewSeller(SellerDTO sellerVO) throws DataAccessException{
		sqlSession.insert("mapper.member.insertNewSeller",sellerVO);
	}
	
	public void updateBuyer(BuyerDTO buyerDTO) throws DataAccessException{
		sqlSession.update("mapper.member.updateBuyer",buyerDTO);
	}
	
	public void updateSeller(SellerDTO sellerDTO) throws DataAccessException{
		sqlSession.update("mapper.member.updateSeller",sellerDTO);
	}
	
	public int deleteMember(BuyerDTO buyerDTO) throws DataAccessException{
		return sqlSession.update("mapper.member.updateMemberdeleting",buyerDTO);
	}
}
