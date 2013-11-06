package com.nb.nbpx.dao.system.impl;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;
import com.nb.nbpx.dao.impl.BaseDaoImpl;
import com.nb.nbpx.dao.system.ICountDao;

@SuppressWarnings("rawtypes")
@Component("CountDao")
public class CountDaoImpl  extends BaseDaoImpl implements ICountDao {

	public static Logger log = Logger.getLogger(CountDaoImpl.class);
	private JdbcTemplate jdbcTemplate;
	@Resource
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}
	@Override
	public void updateArticlesHitsList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update articles set hits = ? + hits where articlesId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateCoursesHitsList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update courses set hits = ? + hits where courseId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateKeywordsHitsList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update keywords set hits = ? + hits where keyId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateSubjectsHitsList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update subjects set hits = ? + hits where subjectId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateKeywordsSearchCntList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update keywords set searchCnt = ? + searchCnt where keyId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateSubjectsSearchCntList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update subjects set searchCnt = ? + searchCnt where subjectId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

	@Override
	public void updateDownloadCntList(List<Entry<Integer, Integer>> list) {
		final int batchSize = 3000;
		for (int j = 0; j < list.size(); j += batchSize) {

			final List<Entry<Integer, Integer>> batchList = list.subList(j, j
					+ batchSize > list.size() ? list.size() : j + batchSize);
			log.info("第" + j + "次执行批处理-----------------------");
			String sql = "update documents set counts = ? + counts where documentId = ?;";
			jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {

				@Override
				public int getBatchSize() {
					return batchList.size();
				}

				@Override
				public void setValues(PreparedStatement ps, int i)
						throws SQLException {
					Entry<Integer, Integer> e = batchList.get(i);
					ps.setInt(1, e.getValue());
					ps.setInt(2, e.getKey());
				}

			});
		}
	}

}
