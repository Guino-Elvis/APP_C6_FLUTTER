package com.Mariategui.asistencia.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.Mariategui.asistencia.entity.Asistencia;

public interface AsistenciaRepository extends JpaRepository<Asistencia, Integer> {

}
