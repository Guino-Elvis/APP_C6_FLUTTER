package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.dto.AuthUser;
import com.Mariategui.asistencia.entity.Asistencia;
import com.Mariategui.asistencia.entity.AsistenciaDetalle;
import com.Mariategui.asistencia.entity.Evento;
import com.Mariategui.asistencia.feign.AuthUserFeign;
import com.Mariategui.asistencia.repository.AsistenciaRepository;
import com.Mariategui.asistencia.service.AsistenciaService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class AsistenciaServiceImpl implements AsistenciaService {

    @Autowired
    private AuthUserFeign authUserFeign;

    @Autowired
    private EventoServiceImpl eventoService;

    @Autowired
    private AsistenciaRepository asistenciaRepository;

    @Override
    public List<Asistencia> listar() {
        return asistenciaRepository.findAll();
    }

    @Override
    public Asistencia guardar(Asistencia asistencia) {
        return asistenciaRepository.save(asistencia);
    }

    @Override
    public Asistencia actualizar(Asistencia asistencia) {
        return asistenciaRepository.save(asistencia);
    }

    @Override
    public Optional<Asistencia> listarPorId(Integer id) {
        Optional<Asistencia> asistenciaOptional = asistenciaRepository.findById(id);

        if (asistenciaOptional.isPresent()) {
            Asistencia asistencia = asistenciaOptional.get();
            Optional<Evento> eventoOptional = eventoService.listarPorId(asistencia.getEvento().getId());

            if (eventoOptional.isPresent()) {
                Evento evento = eventoOptional.get();
                List<AsistenciaDetalle> asistenciaDetalles = asistencia.getDetalle().stream().map(asistenciaDetalle -> {
                    AuthUser authUser = authUserFeign.listById(asistenciaDetalle.getUserId()).getBody();
                    asistenciaDetalle.setAuthUser(authUser);
                    return asistenciaDetalle;
                }).collect(Collectors.toList());

                asistencia.setDetalle(asistenciaDetalles);
                asistencia.setEvento(evento);
            }
            return Optional.of(asistencia);
        } else {
            return Optional.empty();
        }
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaRepository.deleteById(id);
    }
}
