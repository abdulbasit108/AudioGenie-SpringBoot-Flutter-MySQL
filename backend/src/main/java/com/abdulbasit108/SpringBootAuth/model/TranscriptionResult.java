package com.abdulbasit108.SpringBootAuth.model;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "result")
@Getter
@Setter
public class TranscriptionResult {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String audioLink;

    @Lob
    @Column(columnDefinition = "LONGTEXT")
    private String entities;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public TranscriptionResult(String audioLink, String entities, User user) {
        this.audioLink = audioLink;
        this.entities = entities;
        this.user = user;
    }

    public TranscriptionResult() {
    }
}
