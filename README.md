# DOOM Clone

FPS 3D inspirado em DOOM, desenvolvido em Godot 4 e GDScript como projeto de estudo.

## Sobre

Experimento de desenvolvimento de jogos 3D focado em mecânicas clássicas de FPS: movimentação em primeira pessoa, combate e inimigos com IA simples. Foi meu primeiro contato com a Godot Engine, então parte do código ainda reflete essa curva de aprendizado inicial — a ideia é continuar evoluindo o projeto e aprofundar GDScript aos poucos.

## Tecnologias

- Godot 4
- GDScript
- Blender
- Git / GitHub

## Funcionalidades

**Implementado**
- Movimentação do jogador em primeira pessoa, com gravidade e colisão
- Sistema de tiro via raycast
- Inimigo com IA de perseguição
- Sistema de vida do jogador, com barra visual e cor dinâmica conforme o dano
- Sons de tiro e morte
- Animação de morte (câmera inclinando e descendo, arma desaparecendo)
- Cenário de teste com ambientação visual (céu, luz direcional e neblina)

**Planejado**
- Munição e recarga
- Spawn dinâmico de inimigos
- Mais tipos de inimigos
- Level design definitivo
- Boss

## Estrutura

```
doom-clone/
├── Sprites/
├── player.gd
├── player.tscn
├── Zombie.gd
├── zombie.tscn
├── world.tscn
└── project.godot
```

## Status

Em desenvolvimento. O projeto avança sessão a sessão, priorizando entender cada sistema implementado.

## Objetivo

Praticar desenvolvimento de jogos 3D com Godot: movimentação, física, inimigos, combate e level design.

---

Desenvolvido por Roberto Dias.
