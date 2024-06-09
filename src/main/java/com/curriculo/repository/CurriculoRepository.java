package com.curriculo.repository;

import com.curriculo.model.Curriculo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CurriculoRepository extends JpaRepository<Curriculo, Long> {
    // Métodos personalizados, se necessário
}
