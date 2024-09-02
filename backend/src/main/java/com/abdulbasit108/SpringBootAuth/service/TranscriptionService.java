package com.abdulbasit108.SpringBootAuth.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.assemblyai.api.AssemblyAI;
import com.assemblyai.api.resources.transcripts.types.Transcript;
import com.assemblyai.api.resources.transcripts.types.TranscriptOptionalParams;
import com.assemblyai.api.resources.transcripts.types.TranscriptStatus;

@Service
public class TranscriptionService {
    @Value("${assemblyai.api-key}")
    private String apiKey;

    public String transcribeAudio(String audioUrl) throws Exception {
        AssemblyAI client = AssemblyAI.builder()
                .apiKey(apiKey)
                .build();

        var params = TranscriptOptionalParams.builder()
                .entityDetection(true)
                .build();

        Transcript transcript = client.transcripts().transcribe(audioUrl, params);

        if (transcript.getStatus() == TranscriptStatus.ERROR) {
            throw new Exception("Transcript failed with error: " + transcript.getError());

        }
        return transcript.getEntities().get().toString();
    }
}
