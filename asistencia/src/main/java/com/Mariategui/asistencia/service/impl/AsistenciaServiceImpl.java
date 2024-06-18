package com.Mariategui.asistencia.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Mariategui.asistencia.dto.AuthUser;
import com.Mariategui.asistencia.entity.Asistencia;
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
        // Obtener la asistencia de la base de datos
        Asistencia asistencia = asistenciaRepository.findById(id).orElse(null);

        if (asistencia != null) {

            AuthUser authUser = authUserFeign.listById(asistencia.getUserId()).getBody();

            if (authUser != null) {
                asistencia.setAuthUser(authUser);
            }
        }

        return Optional.ofNullable(asistencia);
    }

    @Override
    public void eliminarPorId(Integer id) {
        asistenciaRepository.deleteById(id);
    }

}
