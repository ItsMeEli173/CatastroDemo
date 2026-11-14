import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/widgets/feedback.dart';
import '../data/farmer_providers.dart';
import '../domain/entities/farmer.dart';

/// Confirma y elimina un agricultor, informando el bloqueo por parcelas.
Future<bool> deleteFarmer(
  BuildContext context,
  WidgetRef ref,
  Farmer farmer,
) async {
  final confirmed = await confirmAction(
    context,
    title: 'Eliminar agricultor',
    message:
        '¿Eliminar a ${farmer.fullName}? Esta acción no se puede deshacer.',
    confirmLabel: 'Eliminar',
    destructive: true,
  );
  if (!confirmed || !context.mounted) return false;
  try {
    await ref.read(farmerRepositoryProvider).delete(farmer.id);
    if (!context.mounted) return true;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agricultor eliminado.')),
    );
    return true;
  } on InUseFailure catch (error) {
    if (context.mounted) showFailure(context, error);
    return false;
  } catch (error) {
    if (context.mounted) showFailure(context, error);
    return false;
  }
}
