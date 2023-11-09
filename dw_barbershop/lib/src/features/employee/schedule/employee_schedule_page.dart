import 'dart:developer';

import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:dw_barbershop/src/features/employee/schedule/employee_schedule_vm.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_vm.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime dateSelected;
  bool ignoreFirstLoad = true;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    dateSelected = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId) =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final scheduleAsync = ref.watch(
      EmployeeScheduleVmProvider(userId, dateSelected),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Agenda')),
      body: Column(
        children: [
          const Text(
            'Nome e sobrenome',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 44),
          scheduleAsync.when(
            loading: () => const BarbershopLoader(),
            error: (e, s) {
              log('Erro ao carregar agendamentos', error: e, stackTrace: s);
              return const Center(child: Text('Erro ao carregar página'));
            },
            data: (schedules) {
              return Expanded(
                child: SfCalendar(
                  view: CalendarView.day,
                  allowViewNavigation: true,
                  showNavigationArrow: true,
                  showTodayButton: true,
                  showDatePickerButton: true,
                  todayHighlightColor: ColorConstants.brown,
                  dataSource: AppointmentDs(schedules: schedules),
                  onViewChanged: (viewChangedDetails) {
                    if (ignoreFirstLoad) {
                      ignoreFirstLoad = false;
                      return;
                    }

                    ref
                        .read(employeeScheduleVmProvider(userId, dateSelected)
                            .notifier)
                        .changeDate(
                            userId, viewChangedDetails.visibleDates.first);
                  },
                  onTap: (calendarTapDetails) {
                    if (calendarTapDetails.appointments != null &&
                        calendarTapDetails.appointments!.isNotEmpty) {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat('dd/MM/yyyy HH:mm:ss');

                          return SizedBox(
                            height: 200,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cliente: ${calendarTapDetails.appointments!.first.subject}',
                                  ),
                                  Text(
                                    'Horário: ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  // appointmentBuilder: (context, calendarAppointmentDetails) {
                  //   return Container(
                  //     decoration: BoxDecoration(
                  //       color: ColorConstants.brown,
                  //       shape: BoxShape.rectangle,
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         calendarAppointmentDetails.appointments.first.subject,
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
