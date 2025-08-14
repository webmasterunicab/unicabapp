import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:uniconecta/models/observador/follow_up_model.dart';
import 'package:uniconecta/models/observador/remark_model.dart';
import 'package:uniconecta/models/observador/response_observador.dart';
import 'package:uniconecta/models/observador/student_remark.dart';
import 'package:uniconecta/providers/user_provider.dart';
import 'package:uniconecta/repositories/observador_repository.dart';
import 'package:uniconecta/screens/observador_falta/observador_falta_screen.dart';
import 'package:uniconecta/widgets/observador_related/card_observador.dart';
import 'package:uniconecta/widgets/shared/navegationBar/main_navegation_bar.dart';
import 'package:uniconecta/widgets/shared/orange_button.dart';
import 'package:uniconecta/widgets/shared/screen_name_display.dart';

class ObservadorScreen extends StatelessWidget {
  const ObservadorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainNavegationBar(navType: NavBarTypes.navegating),
            SizedBox(height: 31),
        
            ScreenNameDisplay(
              name: "OBSERVADOR", 
              suffix: OrangeButton(buttonText: "Editar", 
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ObservadorFaltaScreen()));
                }, 
                textWeight: FontWeight.normal, 
                padding: EdgeInsets.all(0),
                fontSize: 15.sp,
              ),
              suffixSize: 60,
            ),

            _CardsList(),
          ],
        ),
      ),
    );
  }
}

class _CardsList extends StatelessWidget {
  const _CardsList();

  @override
Widget build(BuildContext context) {
  final UserProvider provider = context.watch<UserProvider>();

  if (provider.user == null) {
    return const Text(
      "Error al cargar los datos del usuario, \n Inténtelo más tarde."
    );
  }

  return FutureBuilder<ResponseObservador>(
      future: ObservadorRepository.getRemarks(
        role: provider.user!.userRole,
        email: provider.user!.email,
      ),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(strokeWidth: 2.5),
          ));
        }

        if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text('Ha ocurrido un error no esperado,\nIntentelo mas tarde.'),
          );
        }

        if (!snapshot.hasData) {
          return const Text('No hay datos disponibles.');
        }

        final remarkList = snapshot.data!;

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: remarkList.students.length,
          itemBuilder: (_, idx) {
            final StudentRemark student = remarkList.finalRemarks[idx];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                if (student.hasAssessment)
                  CardObservador(
                    fontSize: 13.sp,
                    studentName: student.name,
                    type: "VALORACIÓN",
                    dependency: student.assessmentDependency,
                    charge: student.assessmentCharge,
                    date: student.assessmentDate,
                    cardInfo: 'MOTIVO:\n${student.assessmentReason}\n\nPERSONALIDAD:\n${student.assessmentPersonality}\n\nGENERAL:\n${student.assessmentGeneral}',
                    fieldHeight: 150,
                  ),

                if (student.hasFollowUps)
                  for (FollowUpModel followUp in student.followUps)
                    if (followUp.isOpen)
                      CardObservador(
                        fontSize: 13.sp,
                        studentName: student.name,
                        type: "SEGUIMIENTOS",
                        dependency: followUp.dependency,
                        charge: followUp.charge,
                        date: followUp.date,
                        cardInfo: 'OBJETIVO:\n${followUp.objective}\n\nAVANCES:\n${followUp.progress}\n\nACCIONES ESTUDIANTE:\n${followUp.studentActions}\n\nACCIONES ACUDIENTE:\n${followUp.attendantActions}\n\nCOMPROMISOS:\n${followUp.commitments}\n\n',
                        fieldHeight: 140,
                      ),

                if (student.hasRemarks)
                  for (RemarkModel remark in student.remarks)
                    CardObservador(
                      fontSize: 13.sp,
                      studentName: student.name,
                      type: "OBSERVACIONES",
                      dependency: remark.dependency,
                      charge: remark.charge,
                      date: remark.date,
                      cardInfo: remark.remark,
                      fieldHeight: 130,
                    ),
              ],
            );
          },
        );
      },
    );
  }

}