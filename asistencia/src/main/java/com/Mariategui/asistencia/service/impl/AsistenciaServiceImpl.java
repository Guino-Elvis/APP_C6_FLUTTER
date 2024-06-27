package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.dto.AuthUser;
import com.Mariategui.asistencia.entity.Asistencia;
import com.Mariategui.asistencia.entity.AsistenciaDetalle;
import com.Mariategui.asistencia.entity.Evento;
import com.Mariategui.asistencia.feign.AuthUserFeign;
import com.Mariategui.asistencia.repository.AsistenciaRepository;
import com.Mariategui.asistencia.repository.EventoRepository;
import com.Mariategui.asistencia.service.AsistenciaService;

import feign.FeignException;

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
        Asistencia asistencia = asistenciaRepository.findById(id).orElse(null);
        if (asistencia != null) {
            System.out.println("Antes de la petición");
            Optional<Evento> eventoOptional = eventoService.listarPorId(asistencia.getEvento().getId());
            if (eventoOptional.isPresent()) {
                Evento evento = eventoOptional.get();
                asistencia.setEvento(evento);
            }

            try {
                AuthUser authUser = authUserFeign.listById(asistencia.getUserId()).getBody();
                if (authUser != null) {
                    System.out.println("Después de la petición de AuthUser");
                    System.out.println(authUser.toString());
                    System.out.println(authUser.getName());
                    asistencia.setAuthUser(authUser);
                } else {
                    // Manejo del caso en el que no se encuentra el usuario.
                    System.out.println("No se encontró el usuario.");
                    // Setea userId como null y authUser como null en la reserva.
                    asistencia.setUserId(null);
                    asistencia.setAuthUser(null);
                }
            } catch (FeignException ex) {
                // Manejo de errores específicos de Feign
                System.out.println("Error al llamar al servicio de autenticación: " + ex.getMessage());
                // Setea userId como null y authUser como null en la reserva.
                asistencia.setUserId(null);
                asistencia.setAuthUser(null);
            }
        }

        return Optional.ofNullable(asistencia);
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaRepository.deleteById(id);
    }

    @Override
    public List<Asistencia> listarPorEvento(Integer idEvento) {
        // Obtener la lista de Asistencias por categoría directamente desde el
        // repositorio
        return asistenciaRepository.findByEventoId(idEvento);
    }
}
