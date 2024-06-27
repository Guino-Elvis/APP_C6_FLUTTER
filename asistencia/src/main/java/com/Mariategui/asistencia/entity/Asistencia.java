package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.List;

import com.Mariategui.asistencia.dto.AuthUser;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Entity
@Data
public class Asistencia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer userId;
    @Transient
    private AuthUser authUser;

    private Date fecha;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "evento_id")
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Evento evento;

    private String estado;

    // Custom method to set userId with a message if authUser is null
    public void setUserIdWithMessage(String message) {
        if (authUser == null) {
            userId = null;
        } else {
            userId = authUser.getId();
        }
    }
}
