import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_provider.dart';

class StudentInfoWidget extends StatelessWidget {
  final bool showDetails;
  final bool showRefreshButton;

  const StudentInfoWidget({
    super.key,
    this.showDetails = true,
    this.showRefreshButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('Cargando información...'),
                ],
              ),
            ),
          );
        }

        if (provider.error != null) {
          return Card(
            color: Colors.red[50],
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[700]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Error al cargar estudiante',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (showRefreshButton)
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () => provider.refreshStudent(),
                          tooltip: 'Reintentar',
                        ),
                    ],
                  ),
                  if (showDetails) ...[
                    const SizedBox(height: 8),
                    Text(
                      provider.error!,
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }

        if (!provider.hasStudent) {
          return const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.person_off, color: Colors.grey),
                  SizedBox(width: 12),
                  Text('No hay información del estudiante'),
                ],
              ),
            ),
          );
        }

        return Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: showDetails ? 30 : 20,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.person,
                        size: showDetails ? 30 : 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.studentName,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          if (showDetails &&
                              provider.studentEmail.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              provider.studentEmail,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (showRefreshButton)
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: provider.isLoading
                            ? null
                            : () => provider.refreshStudent(),
                        tooltip: 'Refrescar',
                      ),
                  ],
                ),
                if (showDetails) ...[
                  const SizedBox(height: 12),
                  if (provider.studentCarrera.isNotEmpty) ...[
                    _buildInfoRow(
                      context,
                      Icons.school,
                      'Carrera',
                      provider.studentCarrera,
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (provider.studentSemestre > 0) ...[
                    _buildInfoRow(
                      context,
                      Icons.calendar_today,
                      'Semestre',
                      '${provider.studentSemestre}',
                    ),
                    const SizedBox(height: 8),
                  ],
                  _buildInfoRow(
                    context,
                    Icons.badge,
                    'ID',
                    provider.currentStudentId,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[800],
                ),
          ),
        ),
      ],
    );
  }
}
