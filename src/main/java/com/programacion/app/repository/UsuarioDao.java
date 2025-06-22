package com.programacion.app.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("usuarioDao") // Especifica un nombre expl�cito para el bean
public class UsuarioDao {
    
    private final JdbcTemplate jdbcTemplate;

    @Autowired // Inyecci�n por constructor (m�s recomendado)
    public UsuarioDao(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
    
    public int contarUsuarios() {
        String sql = "SELECT COUNT(*) FROM users";
        return jdbcTemplate.queryForObject(sql, Integer.class);
    }
}