package com.Mariategui.asistencia.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.Mariategui.asistencia.entity.Evento;
import com.Mariategui.asistencia.service.EventoService;

import java.util.List;

@RestController
@RequestMapping("/evento")

public class EventoController {
    @Autowired
    private EventoService eventoService;

    @GetMapping()
    public ResponseEntity<List<Evento>> list() {
        return ResponseEntity.ok().body(eventoService.listar());
    }

    @PostMapping()
    public ResponseEntity<Evento> save(@RequestBody Evento evento) {
        return ResponseEntity.ok(eventoService.guardar(evento));
    }

    @PutMapping()
    public ResponseEntity<Evento> update(
            @RequestBody Evento evento) {
        return ResponseEntity.ok(eventoService.actualizar(evento));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Evento> listById(@PathVariable(required = true) Integer id) {
        return ResponseEntity.ok().body(eventoService.listarPorId(id).get());
    }

    @DeleteMapping("/{id}")
    public String deleteById(@PathVariable(required = true) Integer id) {
        eventoService.eliminarPorId(id);
        return "Eliminacion Correcta";
    }
}
