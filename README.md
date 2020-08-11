PH_BetterTauntMenu
=================

An extensively-modified version of Vash Baldeus' Prop Hunt taunt menu code, rewritten to be more easily configured and dynamically updated. Simply copy your sound file table from the gamemode and add corresponding button texts.

Go into the init.lua file in your Prop Hunt gamemode folder and simply comment out the entire function GM:ShowSpare1(pl) section

2020 Update: Taunt menu now recognizes sound durations, regardless of file type. Please note configuration requires several additional steps to accomplish this (see the lua files for instructions).
