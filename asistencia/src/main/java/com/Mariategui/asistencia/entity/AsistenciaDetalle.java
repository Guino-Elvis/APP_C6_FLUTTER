package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;

import com.Mariategui.asistencia.dto.AuthUser;

import lombok.Data;

@Entity
@Data
public class AsistenciaDetalle {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private Integer userId;

    @Transient
    private AuthUser authUser;

    private String status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "asistencia_id")
    private Asistencia asistencia;
}
