package com.curriculo.service;

import com.curriculo.model.Curriculo;
import com.curriculo.repository.CurriculoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CurriculoService {

    @Autowired
    private CurriculoRepository curriculoRepository;

    public List<Curriculo> listarCurriculos() {
        return curriculoRepository.findAll();
    }

    public Curriculo criarCurriculo(Curriculo curriculo) {
        // Garante que o ID do currículo seja nulo para evitar atualização acidental
        curriculo.setId(null);
        return curriculoRepository.save(curriculo);
    }

    public Curriculo atualizarCurriculo(Long id, Curriculo curriculo) {
        // Verifica se o currículo com o ID fornecido existe na base de dados
        Optional<Curriculo> curriculoOptional = curriculoRepository.findById(id);
        if (curriculoOptional.isPresent()) {
            Curriculo curriculoExistente = curriculoOptional.get();
            // Atualiza os dados do currículo existente com os dados do currículo recebido
            curriculoExistente.setNome(curriculo.getNome());
            curriculoExistente.setEmail(curriculo.getEmail());
            curriculoExistente.setTelefone(curriculo.getTelefone());
            curriculoExistente.setResumo(curriculo.getResumo());
            curriculoExistente.setExperiencia(curriculo.getExperiencia());
            curriculoExistente.setEducacao(curriculo.getEducacao());
            curriculoExistente.setHabilidades(curriculo.getHabilidades());
            return curriculoRepository.save(curriculoExistente);
        } else {
            throw new RuntimeException("Currículo não encontrado com o ID: " + id);
        }
    }

    public void excluirCurriculo(Long id) {
        // Verifica se o currículo com o ID fornecido existe na base de dados antes de excluí-lo
        if (curriculoRepository.existsById(id)) {
            curriculoRepository.deleteById(id);
        } else {
            throw new RuntimeException("Currículo não encontrado com o ID: " + id);
        }
    }
}






