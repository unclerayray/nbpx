package com.nb.nbpx.dao.wenda.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.wenda.IQuestionDao;
import com.nb.nbpx.pojo.wenda.Question;

@Component("QuestionDao")
@SuppressWarnings({"unchecked","rawtypes"})
public class QuestionDaoImpl extends BaseDaoImpl<Question, Integer> implements
		IQuestionDao {

	@Override
	public List<Question> queryQuestions(final Integer rows,
			final Integer start, final String sort, final String order,
			final Boolean closed) {
		List<Question> list = new ArrayList<Question>();
		list = getHibernateTemplate().executeFind(new HibernateCallback() {

			@Override
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				StringBuffer hql = new StringBuffer(
						"select new com.nb.nbpx.pojo.wenda.Question"
								+ " (q.questionId, q.title, q.content, q.isClosed, q.askDate, q.askedBy ) from Question q"
								+ " where 1 = 1 ");
				if (closed != null) {
					if (closed) {
						hql.append(" and closed = true ");
					} else {
						hql.append(" and closed = false ");
					}
				}
				
				hql.append(" group by q.questionId ");

				if (sort != null && !sort.isEmpty()) {
					if("answerNum".equals(sort)){
						hql.append(" order by " + sort);
					}else{
						hql.append(" order by q." + sort);
					}
					if (order != null && !order.isEmpty()) {
						hql.append(" " + order);
					}
				} else {
					hql.append(" order by q.questionId desc ");
				}
				Query query = session.createQuery(hql.toString());

				if (start != null && rows != null) {
					query.setFirstResult(start);
					query.setMaxResults(rows);
				}

				return query.list();
			}
		});
		return list;
	}
}
