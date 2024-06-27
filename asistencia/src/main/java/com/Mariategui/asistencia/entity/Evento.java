package com.Mariategui.asistencia.entity;

import java.sql.Date;
import java.time.LocalDateTime;
import com.Mariategui.asistencia.dto.AuthUser;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Evento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String nombre;
    private String seccion;
    private String tipo;
    private Date fecha_inicio;
    private Date fecha_fin;
    private String foto;
    private Integer userId;
    @Transient
    private AuthUser authUser;

    private LocalDateTime created_at = LocalDateTime.now();
    private LocalDateTime updated_at = LocalDateTime.now();

    @PreUpdate
    private void preUpdate() {
        updated_at = LocalDateTime.now();
    }
}
