package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.Mariategui.asistencia.dto.AuthUser;
import com.Mariategui.asistencia.entity.Evento;
import com.Mariategui.asistencia.feign.AuthUserFeign;
import com.Mariategui.asistencia.repository.EventoRepository;

import com.Mariategui.asistencia.service.EventoService;

import java.util.List;
import java.util.Optional;

@Service
public class EventoServiceImpl implements EventoService {

    @Autowired
    private AuthUserFeign authUserFeign;

    @Autowired
    private EventoRepository eventoRepository;

    @Override
    public List<Evento> listar() {
        return eventoRepository.findAll();
    }

    @Override
    public Evento guardar(Evento evento) {
        return eventoRepository.save(evento);
    }

    @Override
    public Evento actualizar(Evento evento) {
        return eventoRepository.save(evento);
    }

    @Override
    public Optional<Evento> listarPorId(Integer id) {
        // Obtener la Evento de la base de datos
        Evento evento = eventoRepository.findById(id).orElse(null);

        if (evento != null) {

            AuthUser authUser = authUserFeign.listById(evento.getUserId()).getBody();

            if (authUser != null) {
                evento.setAuthUser(authUser);
            }
        }

        return Optional.ofNullable(evento);
    }

    @Override
    public void eliminarPorId(Integer id) {
        eventoRepository.deleteById(id);
    }

}
