<!--
Guilherme_Vieira@USPGameDev
kazuyuki@USPGameDev
-->

### Dungeon Jump

#### Ngised Document

**Summary**

1.  [Overview](#1)
    1. [Concept](#1.1)
    2. [Target audience](#1.2)
2. [Gameplay](#2)
    1. [Objectives](#2.1)
    2. [Progression](#2.2)
    3. [Mechanics](#2.3)
        1. [Movement](#2.3.1)
        2. [Combat](#2.3.2)
        3. [Stages](#2.3.3)
        4. [Character jobs](#2.3.4)
        5. [Items and equipments](#2.3.5)
        6. [Quests](#2.3.6)
    4. [Game settings](#2.4)
    5. [Screen flow](#2.5)
3. [Background](#3)
    1. [Back story](#3.1)
    2. [Characters](#3.2)
4. [Enemies](#4)
    1. [Enemies](#4.1)
    2. [Bosses](#4.2)
5. [Stages](#5)
    1. [Stages](#5.1)
    2. [Tutorial stage](#5.2)
6. [Interface](#6)
    1. [GUI](#6.1)
    2. [Input and control](#6.2)
    3. [Help system](#6.3)
7. [Game art](#7)
    1. [Style](#7.1)
    2. [Visual assets](#7.2)
    3. [Sound assets](#7.3)
        1. [Music](#7.3.1)
        2. [SFX](#7.3.2)
8. [Software and conventions](#8)

<a name="1"></a>
### 1. Overview

<a name="1.1"></a>
#### 1.1. Concept

Dungeon Jump is an action jumping platformer: the player must control a
constantly jumping character while fighting foes and avoiding obstacles.
Equipment, such as armor and weapons, and power-ups are unlocked during
gameplay to aid the player. Like similar games, stages are practically endless.
Upon reaching a certain score, the player may fight the stage's boss. Defeating
enemies will grant the player experience points which may be used to unlock
skills.

<a name="1.2"></a>
#### 1.2. Target audience

As a mobile game, Dungeon Jump is targeted at casual players of no specific
age. Intended playing sessions range from 5 to 15 minutes, so players with
little spare time may also enjoy the game.

<a name="2"></a>
### 2. Gameplay

<a name="2.1"></a>
#### 2.1. Objectives

The player's main objective is to defeat all bosses. Extra challenges (quests)
are available and may reward the player with money to buy equipments or
experience points.  
Since the enemies in general get gradually stronger along the game, the player
will have to take some time doing quests or grinding in order to progress. It
is possible to continue playing even after all bosses are defeated.

<a name="2.2"></a>
#### 2.2. Progression

Game and player progression are typically linear: defeat enemies to get
experience points and money, get better skills and equipments, defeat stronger
enemies to get more rewards and so on.
Not only the enemies get stronger but the structure of the stages (ocurrence
and types of platforms) will also change to add difficulty.

<a name="2.3"></a>
#### 2.3. Mechanics

<a name="2.3.1"></a>
**2.3.1. Movement**

The player's character will automatically jump upon landing on a platform.
Tilting the device left and right will move the character horizontally. Enemies
either stand still or have simple movement patterns.

<a name="2.3.2"></a>
**2.3.2. Combat**

There are weapon main weapon classes: melee and ranged. Attacking with a melee
weapon will turn the character to the touched side of the screen while attacking
with a ranged weapon will launch a projectile on the direction of the touch
point.  
Both melee and ranged weapons may be of physical or magical damage. Physical
damage weapons will consume stamina points, which are quickly recovered after a
cooldown between attacks. Magical damage weapons consume magic points, which
are only recovered with certain items, but inflict special effects on enemies.  

<a name="2.3.3"></a>
**2.3.3. Stages**

Stages are filled with different types of platforms: regular, fake, moving,
cursed or blessed.

* Regular platforms have no special effects
* Fake platforms will break on landing and the character fall straight
* Moving platforms move horizontally in a variable range
* Cursed platforms will inflict damage or a negative effect on the player on
  landing. Once this effect is triggered cursed platforms behave just like
  regular platforms
* Blessed platforms behave like cursed ones but their effects are positive
  (such as healing and buffs)

Stage items may spawn on platforms, like launchers, which boosts the next jump,
and healing or magic recovering consumables.  
If the stage's boss hasn't been defeated yet, achieving the necessary score
will teleport the player to the boss room. The player's score is increased when
reaching higher platforms or defeating enemies and resets each time the
character enters the stage. After defeating the stage's boss the player will
return to the stage selection screen and next runs won't be limited.

<a name="2.3.4"></a>
**2.3.4. Character jobs**

There are four character jobs:

* Warriors have melee combat skills and bonuses and high defense
* Rangers have ranged combat skills and bonuses and low defense, but their
  stamina recovers faster than other jobs'
* Battlemage have magical based skills and bonuses and low defense, but have
  better chances to find magic recovering items in stages
* Jumpers have higher defense and jump than other jobs, but no magic points or
  combat skills

The player must spend experience points (awarded from combat) to unlock skills.

<a name="2.3.5"></a>
**2.3.5. Items and equipments**

The player may choose up to three consumable items in their inventory to use on
a stage. Consumables are either recover items or status items.  
There are three equipment slots: head, body and weapon. It's not possible to
change the character's equipment in a stage.  
To get consumables or equipments one may either complete quests or buy them at
the store with money (awarded from combat). Quest rewards are better than items offered at the store.

<a name="2.3.6"></a>
**2.3.6. Quests**

Quests are extra challenges which reward the player experience points, money or
items. Harder challenges lead to better rewards.  
There are regular and stage specific quests.

<a name="2.4"></a>
#### 2.4. Game settings

* Sound and vibration options
* Difficulty level (Enemy ocurrence, base enemy stats)

<a name="2.5"></a>
#### 2.5. Screen flow

* Splash screen -> Character creation
* Main Menu
* World map (titled World of Worldmap) -> Stage
* Inventory -> Store
* Skill tree
* Quests

<a name="3"></a>
### 3. Background

<a name="3.1"></a>
#### 3.1. Back story

O jogador assume o papel de um cavaleiro, incumbido de cumprir um mandado de
prisão contra o poderoso mago Evilmage por sonegação de impostos. Ao ser
confrontado, o mago lança uma terrível maldição sobre o cavaleiro: pular, pular
para o resto da vida. Assim, o cavaleiro sai em uma jornada pelo mundo de
Worldmap em busca de algum mago que possa desfazer a maldição (quebrando a cara
de quem ousar não cooperar).

<a name="3.2"></a>
#### 3.2. Characters

* Professor Teechur: a gentle magic teacher with no aptitude for combat
* Druid: an apathic master of natural magic and anarchocapitalist, she is a
  pioneer in the GMO industry and will fight to kill anyone who dares to enter
  her property without invitation
* Necromancer: a student of the forbidden crafts, lost his mind after years
  isolated at his crypt. No longer he can tell the difference between life and
  death
* Tyrlyth, aspect of fire: after a lifetime studying the magical properties of
  fire, she became a being of magical fire herself and no longer gets older.
  Likes to tell jokes and runs a HVAC company
* The autocrat: the mysterious ruler of the Void, has unlimited power in his
  realm and can't die or be hurt (pain is an option). Fights for fun
* Evilmage: constantly angry, won't pay taxes. Currently unemployed

<a name="4"></a>
### 4. Enemies

<a name="4.1"></a>
#### 4.1. Enemies

All enemies will only attack if the player is in melee range.  
There are four types of enemies:

* Static weak (SW)
* Static strong (SS)
* Moving weak (MW)
* Moving strong (MS)

Each stage has it's set of enemies based on those types:

* Professor's Vertical House
    * Student (SW)
    * Bully (MW)
* Druid's Tree
    * Pigeon (MW)
    * Winged monkey (MS)
* Necromancer's Tower
    * Zombie (SW)
    * Skeleton (SS)
    * Skeleton Mage (MW)
* Tower of Eternal Fire
    * Fire totem (SS)
    * Living flame (MW)
    * Fire elemental (MS)
* The Void
    * Doppelganger (SS)
    * Wraith (MS)
* Evilmage's Evil Tower
    * Henchman (SW)
    * Henchman Elite (SS)
    * Gargoyle (MW)
    * Drake (MS)

<a name="4.2"></a>
#### 4.2. Bosses

**Professor Teechur**

* Room: Teechur's office
* Regular attack: nothing
* Special attack: nothing
* Movement: none
* Spawns students

**Druid**

* Room: tree top
* Regular attack: turns her hand into a bear paw and attacks
* Special attack: spiked tree branches rise straight from the bottom (destroyed
  after a short amount of time)
* Movement: moves up and down, freezing before changing direction
* Spawns pigeons

**Necromancer**

* Room: sacrifice chamber
* Regular attack: nothing
* Special attack: drains player's health points in a small area around himself
* Movement: moves left and right, freezing before changing direction
* Spawns skeletons

**Tyrlyth, aspect of fire**

* Room: throne room
* Regular attack: shoots fire balls
* Special attack: lava drops from the top
* Movement: moves clockwise between corners
* Spawns nothing

**The autocrat**

* Room: an empty room
* Regular attack: attacks with a pike
* Special attack: creates a black hole that attracts the player and damages
  upon contact
* Movement: moves to a random point and freezes for a reasonable amount of time
* Spawns wraiths

**Evilmage**

* Room: evil library
* Regular attack: shoots fire balls. In melee range turns his hand into a bear
  paw and attacks
* Special attack: shoots ice spikes that damage and slow the player and drains
  player's health points in a small area around himself
* Movement: moves to a random point and freezes for a reasonable amount of time
* Spawns gargoyles

<a name="5"></a>
### 5. Stages

<a name="5.1"></a>
### 5.1. Stages

Six stages are available:

* Professor's Vertical House: school theme
* Druid's Tree: tree theme
* Necromancer's Tower: graveyard theme
* Tower of Eternal Fire: volcano theme
* The Void: "Damnation" theme
* Evilmage's Evil Tower: witch theme

<a name="5.2"></a>
### 5.2. Tutorial stage
