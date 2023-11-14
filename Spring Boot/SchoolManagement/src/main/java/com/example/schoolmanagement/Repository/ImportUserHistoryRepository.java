package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.ImportUserHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.Date;
import java.util.List;

@Repository
@Transactional
public interface ImportUserHistoryRepository extends JpaRepository<ImportUserHistory, Long> {

    List<ImportUserHistory> findImportUserHistoriesByDate(Date date);

}
