package com.Mariategui.asistencia.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Mariategui.asistencia.entity.Asistencia;
import com.Mariategui.asistencia.service.AsistenciaService;

import java.util.List;

@RestController
@RequestMapping("/asistencia")
public class AsistenciaController {
    @Autowired
    private AsistenciaService asistenciaService;

    @GetMapping("/asistenciaPorEvento/{idEvento}")
    public ResponseEntity<List<Asistencia>> listarAsistenciasPorEvento(@PathVariable Integer idEvento) {
        List<Asistencia> asistencias = asistenciaService.listarPorEvento(idEvento);
        return ResponseEntity.ok(asistencias);
    }

    @GetMapping()
    public ResponseEntity<List<Asistencia>> list() {
        return ResponseEntity.ok().body(asistenciaService.listar());
    }

    @PostMapping()
    public ResponseEntity<Asistencia> save(@RequestBody Asistencia asistencia) {
        return ResponseEntity.ok(asistenciaService.guardar(asistencia));
    }

    @PutMapping()
    public ResponseEntity<Asistencia> update(
            @RequestBody Asistencia asistencia) {
        return ResponseEntity.ok(asistenciaService.actualizar(asistencia));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Asistencia> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(asistenciaService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        asistenciaService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
