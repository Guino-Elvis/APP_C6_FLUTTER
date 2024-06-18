package com.Mariategui.asistencia.service;

import java.util.List;
import java.util.Optional;

import com.Mariategui.asistencia.entity.Notificacion;

public interface NotificacionService {

    public List<Notificacion> listar();

    public Notificacion guardar(Notificacion notificacion);

    public Notificacion actualizar(Notificacion notificacion);

    public Optional<Notificacion> listarPorId(Integer id);

    public void eliminarPorId(Integer id);
}
