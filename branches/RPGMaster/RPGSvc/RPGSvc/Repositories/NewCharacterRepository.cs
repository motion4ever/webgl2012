﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using RPGSvc.Entities;
using RPGSvc.Data;

namespace RPGSvc.Repositories
{
    public class NewCharacterRepository
    {
        public NewCharacterRepository()
        {
            //initialize various data objects here
        }

        public void AddNewCharacter(Player newPlayer){
            var ac = new AddCharacter();
            ac.AddNewCharacter(newPlayer);
        }

        public NewCharacter GetNewCharacter()
        {
            //Get player,player skills and player stats
            var newCharacter = new NewCharacter();
            newCharacter.Races = new StoredRaces().GetRaces();
            newCharacter.Stats = new StoredStat().GetStats();
            newCharacter.Skills = new StoredSkill().GetSkills();
            newCharacter.Feats = new StoredFeat().GetFeats();
            newCharacter.Genders = new StoredGender().GetGenders();
            newCharacter.Alignments = new StoredAlignment().GetAlignments();
            newCharacter.Classes = new StoredClass().GetClasses();

            return newCharacter;
        }
    }
}