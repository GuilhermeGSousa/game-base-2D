# Game Base 2D


## About
------------------
A base structure for 2D games using Godot 4.

It aims to include everything needed to create a polished 2D game, from movement scripts to screen postprocessing shaders, while leveraging the new features of Godot 4 and using a clean, scalable and extensible code architecture.

## Install
-----------
This repo uses Godot 4.1 and above! If Godot 4.1 hasn't yet released when reading this, you will need to build Godot from source.

Simply fork this repo and start working on your game! Some sample scenes are available under `scenes/samples`.

## Content
-----------

### Samples
- A scene showcasing post-processing effects
- A simple top-down scene
- A simple platformer scene
- A simple platformer character scene with a basin animation state machine setup

### Common
- A simple audio manager
- Scene transitions with some cool effects!

### UI
- A main menu
- A settings menu with audio sliders
- A pause menu
- An dialog box for NPC and object interations
- A shader based minimap!

### Movement
- Top-down movement
- Side scroller movement with coyote jump and jump buffering

### Shaders
- Scene transition shaders
- Post processing shaders, including blur, chromatic aberration, CRT effect and vignette
- Shaders for in game effects, such as color flickering, color replace, 2D shake and outlines

### Camera
- Camera following
- Camera 2D shake
- Camera areas (the camera will stay in bounds while the player is inside that area)

### Sprites
