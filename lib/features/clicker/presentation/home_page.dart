import 'package:autoclickmobileapp/core/constants/app_constants.dart';
import 'package:autoclickmobileapp/core/theme/colors.dart';
import 'package:autoclickmobileapp/core/theme/dimensions.dart';
import 'package:autoclickmobileapp/core/theme/typography.dart';
import 'package:autoclickmobileapp/data/models/click_configuration.dart';
import 'package:autoclickmobileapp/data/models/click_point.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Auto Clicker', style: AppTypography.title.copyWith(color: AppColors.textPrimary)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: AppColors.success),
                        const SizedBox(width: 6),
                        Text(
                          _viewModel.statusLabel(),
                          style: AppTypography.caption.copyWith(color: AppColors.success),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: _start,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primaryStrong,
                    foregroundColor: AppColors.background,
                  ),
                  child: const Text('START'),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _pause,
                      child: const Text('PAUSE'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _stop,
                      child: const Text('STOP'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildMetricCard(),
              const SizedBox(height: 20),
              _buildConfigPanel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _metricItem('Clicks', '${_viewModel.clickCount}'),
              _metricItem('Elapsed', _viewModel.formatElapsed()),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.divider),
          const SizedBox(height: 12),
          Text('Current Point', style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Text('${_viewModel.currentPointIndex + 1} / ${_viewModel.enabledPoints().length}', style: AppTypography.heading.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _metricItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.caption.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 6),
        Text(value, style: AppTypography.heading.copyWith(color: AppColors.textPrimary)),
      ],
    );
  }

  Widget _buildConfigPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Configuration', style: AppTypography.heading.copyWith(color: AppColors.textPrimary)),
          const SizedBox(height: 16),
          _infoRow('Click Interval', '${_viewModel.configuration.intervalMs} ms'),
          _infoRow('Delay', '${_viewModel.configuration.pointDelayMs} ms'),
          _infoRow('Loop', _viewModel.configuration.infiniteLoop ? 'Unlimited' : '${_viewModel.configuration.loopCount}'),
          _infoRow('Click Points', '${_viewModel.configuration.points.length}'),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.body.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTypography.body.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
