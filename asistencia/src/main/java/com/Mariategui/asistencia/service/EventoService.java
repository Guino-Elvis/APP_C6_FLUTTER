package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.Evento;

public interface EventoService {

    public List<Evento> listar();

    public Evento guardar(Evento evento);

    public Evento actualizar(Evento evento);

    public Optional<Evento> listarPorId(Integer id);

    public void eliminarPorId(Integer id);

}
