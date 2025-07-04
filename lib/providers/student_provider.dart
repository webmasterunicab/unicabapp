import 'package:flutter/foundation.dart';
import '../models/general/estudiante.dart';
import '../services/estudiante_service.dart';

class StudentProvider extends ChangeNotifier {
  // ID del estudiante actual (estático por ahora, luego será del login)
  static const String _currentStudentId =
      "1"; // 🔄 Cambia este ID según necesites

  // Estado interno
  Estudiante? _currentStudent;
  bool _isLoading = false;
  String? _error;
  bool _initialized = false;

  // Getters públicos
  Estudiante? get currentStudent => _currentStudent;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get initialized => _initialized;
  String get currentStudentId => _currentStudentId;

  // Getter para verificar si hay un estudiante cargado
  bool get hasStudent => _currentStudent != null;

  // Getter para el nombre del estudiante
  String get studentName => _currentStudent?.nombre ?? 'Usuario';

  // Getter para la foto del estudiante
  String get studentPhoto => _currentStudent?.foto ?? '';

  // Getter para el email del estudiante
  String get studentEmail => _currentStudent?.email ?? '';

  // Getter para la carrera del estudiante
  String get studentCarrera => _currentStudent?.carrera ?? '';

  // Getter para el semestre del estudiante
  int get studentSemestre => _currentStudent?.semestre ?? 0;

  StudentProvider() {
    // Inicializar automáticamente al crear el provider
    _initializeStudent();
  }

  // Inicializar el estudiante actual
  Future<void> _initializeStudent() async {
    if (_initialized) return; // No inicializar si ya está inicializado

    await loadCurrentStudent();
    _initialized = true;
  }

  // Cargar el estudiante actual desde la API
  Future<void> loadCurrentStudent() async {
    _setLoading(true);
    _clearError();

    try {
      final estudiante =
          await EstudianteService.obtenerEstudiantePorId(_currentStudentId);

      if (estudiante != null) {
        _currentStudent = estudiante;
      } else {
        _setError('No se encontró el estudiante con ID: $_currentStudentId');
      }
    } catch (e) {
      _setError('Error al cargar estudiante: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Actualizar el estudiante actual (para futuro login)
  Future<void> updateCurrentStudent(String newStudentId) async {
    if (newStudentId == _currentStudentId) {
      return; // No actualizar si es el mismo ID
    }

    // Nota: Para cambiar el ID necesitarás modificar la constante _currentStudentId
    // En el futuro, esto vendrá del login
    _setLoading(true);
    _clearError();

    try {
      final estudiante =
          await EstudianteService.obtenerEstudiantePorId(newStudentId);

      if (estudiante != null) {
        _currentStudent = estudiante;
      } else {
        _setError('No se encontró el estudiante con ID: $newStudentId');
      }
    } catch (e) {
      _setError('Error al actualizar estudiante: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Refrescar la información del estudiante actual
  Future<void> refreshStudent() async {
    await loadCurrentStudent();
  }

  // Limpiar el estudiante actual (para logout futuro)
  void clearStudent() {
    _currentStudent = null;
    _clearError();
    _initialized = false;
    notifyListeners();
  }

  // Métodos privados para manejo de estado
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  // Método para debug - imprimir información del estudiante
  void printStudentInfo() {
    if (_currentStudent != null) {
      debugPrint('👤 Estudiante Actual:');
      debugPrint('   ID: ${_currentStudent!.id}');
    } else {
      debugPrint('❌ No hay estudiante cargado');
    }
  }
}
