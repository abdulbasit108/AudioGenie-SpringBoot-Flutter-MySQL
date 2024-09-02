package com.abdulbasit108.SpringBootAuth.service;

import org.springframework.stereotype.Service;

import com.abdulbasit108.SpringBootAuth.model.TranscriptionResult;
import com.abdulbasit108.SpringBootAuth.model.User;
import com.abdulbasit108.SpringBootAuth.repository.TranscriptionResultRepository;

import java.util.List;

@Service
public class TranscriptionResultService {
    private final TranscriptionResultRepository transcriptionResultRepository;

    public TranscriptionResultService(TranscriptionResultRepository transcriptionResultRepository) {
        this.transcriptionResultRepository = transcriptionResultRepository;
    }

    public TranscriptionResult createTranscriptionResult(String audioLink, String entities, User user) {
        TranscriptionResult result = new TranscriptionResult(audioLink, entities, user);
        return transcriptionResultRepository.save(result);
    }

    public List<TranscriptionResult> allTranscriptionsByUser(User user) {
        return transcriptionResultRepository.findByUser(user);
    }
}
