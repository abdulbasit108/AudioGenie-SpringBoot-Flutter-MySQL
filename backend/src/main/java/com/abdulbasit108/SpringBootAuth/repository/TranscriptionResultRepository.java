package com.abdulbasit108.SpringBootAuth.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import com.abdulbasit108.SpringBootAuth.model.TranscriptionResult;
import com.abdulbasit108.SpringBootAuth.model.User;

import java.util.List;

@Repository
public interface TranscriptionResultRepository extends CrudRepository<TranscriptionResult, Long>{
    List<TranscriptionResult> findByUser(User user);
}
