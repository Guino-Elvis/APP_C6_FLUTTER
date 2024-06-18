package com.Mariategui.asistencia.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.asistencia.entity.Evento;

public interface EventoRepository extends JpaRepository<Evento, Integer> {

}
