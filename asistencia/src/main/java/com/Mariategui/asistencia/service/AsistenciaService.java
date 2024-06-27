package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.Asistencia;

public interface AsistenciaService {
    public List<Asistencia> listar();

    public Asistencia guardar(Asistencia asistencia);

    public Asistencia actualizar(Asistencia asistencia);

    public Optional<Asistencia> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

    // Otros métodos existentes
    List<Asistencia> listarPorEvento(Integer idEvento);
}
