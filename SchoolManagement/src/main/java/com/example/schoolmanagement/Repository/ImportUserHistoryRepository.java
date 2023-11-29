package com.example.schoolmanagement.Repository;

import com.example.schoolmanagement.Model.ImportUserHistory;
import com.example.schoolmanagement.Model.Users;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.sql.Date;
import java.util.List;
import java.util.Optional;

@Repository
@Transactional
public interface ImportUserHistoryRepository extends JpaRepository<ImportUserHistory, Long> {

    List<ImportUserHistory> findImportUserHistoriesByAuthorAndDate(Users user, Date date);

    Optional<ImportUserHistory> findImportUserHistoriesByAuthorAndDateAndStatus(Users user, Date date, String status);

    Page<ImportUserHistory> findImportUserHistoriesByAuthor(Users author, Pageable pageable);
}
