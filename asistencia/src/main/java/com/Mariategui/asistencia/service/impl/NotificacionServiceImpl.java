package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.dto.AuthUser;
import com.Mariategui.asistencia.entity.Notificacion;
import com.Mariategui.asistencia.feign.AuthUserFeign;
import com.Mariategui.asistencia.repository.NotificacionRepository;
import com.Mariategui.asistencia.service.NotificacionService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class NotificacionServiceImpl implements NotificacionService {

    @Autowired
    private AuthUserFeign authUserFeign;

    @Autowired
    private NotificacionRepository notificacionRepository;

    @Override
    public List<Notificacion> listar() {
        return notificacionRepository.findAll();
    }

    @Override
    public Notificacion guardar(Notificacion notificacion) {
        return notificacionRepository.save(notificacion);
    }

    @Override
    public Notificacion actualizar(Notificacion notificacion) {
        return notificacionRepository.save(notificacion);
    }

    @Override
    public Optional<Notificacion> listarPorId(Integer id) {
        // Obtener la Notificacion de la base de datos
        Notificacion notificacion = notificacionRepository.findById(id).orElse(null);

        if (notificacion != null) {

            AuthUser authUser = authUserFeign.listById(notificacion.getUserId()).getBody();

            if (authUser != null) {
                notificacion.setAuthUser(authUser);
            }
        }

        return Optional.ofNullable(notificacion);
    }

    @Override
    public void eliminarPorId(Integer id) {
        notificacionRepository.deleteById(id);
    }
}
