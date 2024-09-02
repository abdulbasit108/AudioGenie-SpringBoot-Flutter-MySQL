package com.abdulbasit108.SpringBootAuth.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.abdulbasit108.SpringBootAuth.dto.TranscribeAudioDto;
import com.abdulbasit108.SpringBootAuth.model.TranscriptionResult;
import com.abdulbasit108.SpringBootAuth.model.User;
import com.abdulbasit108.SpringBootAuth.service.TranscriptionResultService;
import com.abdulbasit108.SpringBootAuth.service.TranscriptionService;

import java.util.List;

@RequestMapping("/transcription")
@RestController
public class TranscriptionResultController {
    private final TranscriptionService transcriptionService;
    private final TranscriptionResultService transcriptionResultService;

    public TranscriptionResultController(TranscriptionService transcriptionService,
            TranscriptionResultService transcriptionResultService) {
        this.transcriptionService = transcriptionService;
        this.transcriptionResultService = transcriptionResultService;
    }

    @PostMapping("/generate")
    public ResponseEntity<?> generateTranscription(@RequestBody TranscribeAudioDto transcribeAudioDto) {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User currentUser = (User) authentication.getPrincipal();

            String audioUrl = transcribeAudioDto.getAudioLink();

            String result = transcriptionService.transcribeAudio(audioUrl);

            TranscriptionResult transcriptionResult = transcriptionResultService.createTranscriptionResult(audioUrl,
                    result,
                    currentUser);

            return ResponseEntity.ok(transcriptionResult);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @GetMapping("/me")
    public ResponseEntity<List<TranscriptionResult>> allTranscriptionsByUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User currentUser = (User) authentication.getPrincipal();

        List<TranscriptionResult> results = transcriptionResultService.allTranscriptionsByUser(currentUser);
        return ResponseEntity.ok(results);
    }
}
