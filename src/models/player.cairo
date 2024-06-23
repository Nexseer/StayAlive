#[derive(Serde, Copy, Drop, Introspect)]
enum CharacterType {
    Crawler,
    Creep,
    Horror,
    Asuna,
    Robot,
    SpearMan,
    Pilot,
    RobotWhite,
    RobotSphere,
    MillitaryX,
    ZombieY
}

#[derive(Copy, Drop, Serde)]
#[dojo::model]
struct Player {
    #[key]
    character_id: u8,
    character_type: CharacterType,
    hp: u64,
    attack: u64,
}

trait PlayerTrait {
    fn select_type(character_type: CharacterType) -> Player;
}

impl CharacterTypeIntoU8 of Into<CharacterType, u8> {
    fn into(self: CharacterType) -> u8 {
        match self {
            CharacterType::Crawler => 0,
            CharacterType::Creep => 1,
            CharacterType::Horror => 2,
            CharacterType::Asuna => 3,
            CharacterType::Robot => 4,
            CharacterType::SpearMan => 5,
            CharacterType::Pilot => 6,
            CharacterType::RobotWhite => 7,
            CharacterType::RobotSphere => 8,
            CharacterType::MillitaryX => 9,
            CharacterType::ZombieY => 10,
        }
    }
}

impl PlayerImpl of PlayerTrait {
    fn select_type(character_type: CharacterType) -> Player {
        let player = match character_type {
            CharacterType::Crawler => create_crawler(character_type.into()),
            CharacterType::Creep => create_creep(character_type.into()),
            CharacterType::Horror => create_horror(character_type.into()),
            CharacterType::Asuna => create_asuna(character_type.into()),
            CharacterType::Robot => create_robot(character_type.into()),
            CharacterType::SpearMan => create_spearMan(character_type.into()),
            CharacterType::Pilot => create_pilot(character_type.into()),
            CharacterType::RobotWhite => create_robotWhite(character_type.into()),
            CharacterType::RobotSphere => create_robotSphere(character_type.into()),
            CharacterType::MillitaryX => create_millitaryX(character_type.into()),
            CharacterType::ZombieY => create_zombieY(character_type.into()),
        };

        player
    }
}

fn create_crawler(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Crawler,
        hp: 80,
        attack: 20,
    }
}

fn create_creep(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Creep,
        hp: 100,
        attack: 15,
    }
}

fn create_horror(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Horror,
        hp: 60,
        attack: 30,
    }
}

fn create_asuna(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Asuna,
        hp: 90,
        attack: 15,
    }
}

fn create_robot(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Robot,
        hp: 150,
        attack: 5,
    }
}

fn create_spearMan(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::SpearMan,
        hp: 95,
        attack: 15,
    }
}

fn create_pilot(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::Pilot,
        hp: 120,
        attack: 8,
    }
}

fn create_robotWhite(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::RobotWhite,
        hp: 140,
        attack: 3,
    }
}

fn create_robotSphere(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::RobotSphere,
        hp: 200,
        attack: 0,
    }
}

fn create_millitaryX(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::MillitaryX,
        hp: 100,
        attack: 10,
    }
}

fn create_zombieY(id: u8) -> Player {
    Player {
        character_id: id,
        character_type: CharacterType::ZombieY,
        hp: 110,
        attack: 10,
    }
}
