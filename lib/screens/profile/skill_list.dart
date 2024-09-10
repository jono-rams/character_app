import 'package:flutter/material.dart';
import 'package:character_app/models/character.dart';
import 'package:character_app/models/skill.dart';
import 'package:character_app/shared/styled_text.dart';
import 'package:character_app/theme.dart';

class SkillList extends StatefulWidget {
  const SkillList(this.character, {super.key});

  final Character character;

  @override
  State<SkillList> createState() => _SkillListState();
}

class _SkillListState extends State<SkillList> {

  late List<Skill> availableSkills;
  late Skill selectedSkill;

  @override
  void initState() {

    availableSkills = allSkills.where((skill) {
      return skill.vocation == widget.character.vocation;
    }).toList();

    selectedSkill = widget.character.skills.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: AppColors.secondaryColor.withOpacity(0.5),
          child: Column(
            children: [
              const StyledHeadline(text: 'Choose an active skill'),
              const StyledText(text: 'Skills are unique to your vocation.'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: availableSkills.map((skill) {
                  return Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(2),
                    color: skill == selectedSkill ? Colors.yellow : Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.character.updateSkill(skill);
                          selectedSkill = skill;
                        });
                      },
                      child: Image.asset('assets/img/skills/${skill.image}',
                        width: 70,
                      ),
                    ),
                  );
                }).toList()
              ),
              const SizedBox(height:10),
              StyledText(text: selectedSkill.name),
            ],
          ),
        )
    );
  }
}