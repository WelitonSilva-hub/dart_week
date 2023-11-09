import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/contants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/features/home/employee/home_employee_provider.dart';
import 'package:dw_barbershop/src/features/home/widgets/home_header.dart';
import 'package:dw_barbershop/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeEployeePage extends ConsumerWidget {
  const HomeEployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModelAsync = ref.watch(getMeProvider);

    return Scaffold(
      body: userModelAsync.when(
        loading: () => const BarbershopLoader(),
        error: (e, s) {
          log('Erro ao carregar página', error: e, stackTrace: s);
          return const Center(child: Text('Erro ao carregar página'));
        },
        data: (user) {
          final UserModel(:name, id: userId) = user;

          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader.withoutFilter(),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const AvatarWidget(hideAddButton: true),
                      const SizedBox(height: 24),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 108,
                        width: MediaQuery.sizeOf(context).width * .8,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorConstants.grey, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer(
                              builder: (context, ref, child) {
                                final totalAsync = ref.watch(
                                  getTotalSchedulesTodayProvider(userId),
                                );

                                return totalAsync.when(
                                  loading: () => const BarbershopLoader(),
                                  skipLoadingOnRefresh: false,
                                  error: (e, s) {
                                    log(
                                      'Erro ao carregar o total de agendamentos',
                                      error: e,
                                      stackTrace: s,
                                    );
                                    return const Center(
                                      child: Text(
                                        'Erro ao carregar o total de agendamentos',
                                      ),
                                    );
                                  },
                                  data: (totalSchedule) {
                                    return Text(
                                      '$totalSchedule',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        color: ColorConstants.brown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            const Text(
                              'Hoje',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('AGENDAR CLIENTE'),
                        onPressed: () async {
                          await Navigator.of(context).pushNamed(
                            '/schedule',
                            arguments: user,
                          );
                          ref.invalidate(getTotalSchedulesTodayProvider);
                        },
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('VER AGENDA'),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            '/employee/schedule',
                            arguments: user,
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
