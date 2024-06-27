package com.Mariategui.asistencia.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.List;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Entity
@Data
public class Asistencia {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Date fecha;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "evento_id")
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private Evento evento;

    @OneToMany(mappedBy = "asistencia", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
    private List<AsistenciaDetalle> detalle;
}
