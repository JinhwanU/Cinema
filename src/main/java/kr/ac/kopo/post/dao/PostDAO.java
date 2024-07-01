package kr.ac.kopo.post.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.ac.kopo.post.vo.PostVO;
import kr.ac.kopo.util.MyBatisConfig;

public class PostDAO {
	private SqlSession session;

	public PostDAO() {
		session = new MyBatisConfig().getInstance();
	}

	public void insertPost() {
		PostVO post = new PostVO();
		try {
			session.insert("post.dao.PostDAO.insert", post);
			session.commit();
		} catch (Exception e) {
			session.rollback();
		}
	}

	public List<PostVO> selectAllPosts() {
		List<PostVO> list = session.selectList("post.dao.PostDAO.selectAll");
		return list;
	}

	public void selectPostByNo() {
		PostVO post = new PostVO();
		post = session.selectOne("post.dao.PostDAO.selectByNo", post);
	}

}
