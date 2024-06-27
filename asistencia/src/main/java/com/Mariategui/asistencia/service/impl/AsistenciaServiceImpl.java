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
        // Cambio en la asignación de variable
        Asistencia asistencia = asistenciaRepository.findById(id).orElse(null);

        if (asistencia != null) {
            // Cambio en la obtención del horario
            Evento evento = eventoService.listarPorId(asistencia.getEvento().getId()).orElse(null);

            if (evento != null) {
                List<AsistenciaDetalle> asistenciaDetalles = asistencia.getDetalle().stream()
                        .map(asistenciaDetalle -> {
                            System.out.println(asistenciaDetalle.toString());
                            System.out.println("Antes de la petición");
                            // Cambio en la obtención del alumno
                            AuthUser authUser = authUserFeign.listById(asistenciaDetalle.getUserId()).getBody();
                            System.out.println("Después de la petición");
                            System.out.println(authUser.toString());
                            System.out.println(authUser.getName());
                            asistenciaDetalle.setAuthUser(authUser);
                            return asistenciaDetalle;
                        }).collect(Collectors.toList());
                asistencia.setDetalle(asistenciaDetalles);

            }
        }
        return Optional.ofNullable(asistencia);
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaRepository.deleteById(id);
    }
}
