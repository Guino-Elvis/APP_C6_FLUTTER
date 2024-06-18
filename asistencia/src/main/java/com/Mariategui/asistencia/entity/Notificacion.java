package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import com.Mariategui.asistencia.dto.AuthUser;

import lombok.Data;

@Entity
@Data
public class Notificacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer userId;
    @Transient
    private AuthUser authUser;
    private Integer leido = 1;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
