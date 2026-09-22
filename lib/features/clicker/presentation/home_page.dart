import 'package:autoclickmobileapp/core/constants/app_constants.dart';
import 'package:autoclickmobileapp/core/theme/colors.dart';
import 'package:autoclickmobileapp/core/theme/dimensions.dart';
import 'package:autoclickmobileapp/core/theme/typography.dart';
import 'package:autoclickmobileapp/core/widgets/premium_components.dart';
import 'package:autoclickmobileapp/data/models/click_configuration.dart';
import 'package:autoclickmobileapp/data/models/click_point.dart';
import 'package:autoclickmobileapp/features/clicker/domain/clicker_status.dart';
import 'package:autoclickmobileapp/features/clicker/presentation/clicker_view_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ClickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    final configuration = ClickConfiguration(
      intervalMs: AppConstants.defaultIntervalMs,
      pointDelayMs: AppConstants.defaultPointDelayMs,
      loopMode: LoopMode.unlimited,
      loopCount: AppConstants.defaultLoopCount,
      points: [
        ClickPoint(x: 500, y: 800, enabled: true, delayMs: 50),
        ClickPoint(x: 700, y: 900, enabled: true, delayMs: 50),
        ClickPoint(x: 400, y: 1200, enabled: true, delayMs: 50),
      ],
      infiniteLoop: true,
    );
    _viewModel = ClickerViewModel(configuration: configuration);
  }

  void _start() {
    setState(() => _viewModel.start());
  }

  void _pause() {
    setState(() => _viewModel.pause());
  }

  void _stop() {
    setState(() => _viewModel.stop());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Auto Clicker',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.8,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _viewModel.statusLabel(),
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        StatusBadge(
                          label: _viewModel.statusLabel(),
                          active: _viewModel.status == ClickerStatus.running,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryActionButton(
                      label: 'START',
                      onPressed: _start,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SecondaryActionButton(
                          label: 'PAUSE',
                          onPressed: _pause,
                        ),
                        const SizedBox(width: 12),
                        SecondaryActionButton(
                          label: 'STOP',
                          onPressed: _stop,
                          isPrimary: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MetricTile(
                                label: 'Clicks',
                                value: '${_viewModel.clickCount}',
                              ),
                              MetricTile(
                                label: 'Elapsed',
                                value: _viewModel.formatElapsed(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: AppColors.divider),
                          const SizedBox(height: 12),
                          Text(
                            'Current Point',
                            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${_viewModel.currentPointIndex + 1} / ${_viewModel.enabledPoints().length}',
                            style: AppTypography.heading.copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    AppSectionCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Configuration',
                            style: AppTypography.heading.copyWith(color: AppColors.textPrimary),
                          ),
                          const SizedBox(height: 16),
                          CompactInfoRow(
                            label: 'Interval',
                            value: '${_viewModel.configuration.intervalMs} ms',
                          ),
                          CompactInfoRow(
                            label: 'Click Points',
                            value: '${_viewModel.configuration.points.length}',
                          ),
                          CompactInfoRow(
                            label: 'Loops',
                            value: _viewModel.configuration.infiniteLoop ? 'Unlimited' : '${_viewModel.configuration.loopCount}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
