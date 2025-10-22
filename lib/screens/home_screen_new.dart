import 'package:flutter/material.dart';

// Clase para representar a un empleado
class Employee {
  final String id;
  final String name;
  final String department;
  final String phone;
  final bool isActive;
  final int performance; // porcentaje de rendimiento (0-100)

  Employee({
    required this.id,
    required this.name,
    required this.department,
    required this.phone,
    required this.isActive,
    required this.performance,
  });
}

class HomeScreen_new extends StatefulWidget {
  const HomeScreen_new({super.key});

  @override
  State<HomeScreen_new> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen_new> {
  int _currentIndex = 0;

  // Lista de empleados ficticios
  final List<Employee> _employees = [
    Employee(
      id: '001',
      name: 'Carlos Pérez',
      department: 'Desarrollo',
      phone: '315-789-4532',
      isActive: true,
      performance: 85,
    ),
    Employee(
      id: '002',
      name: 'Ana Gómez',
      department: 'Diseño',
      phone: '321-456-7890',
      isActive: true,
      performance: 92,
    ),
    Employee(
      id: '003',
      name: 'Luis Rodríguez',
      department: 'Marketing',
      phone: '300-123-4567',
      isActive: false,
      performance: 45,
    ),
    Employee(
      id: '004',
      name: 'María Sánchez',
      department: 'Recursos Humanos',
      phone: '310-987-6543',
      isActive: true,
      performance: 78,
    ),
    Employee(
      id: '005',
      name: 'Juan Martínez',
      department: 'Ventas',
      phone: '312-345-6789',
      isActive: false,
      performance: 30,
    ),
    Employee(
      id: '006',
      name: 'Diana López',
      department: 'Diseño',
      phone: '311-222-3333',
      isActive: true,
      performance: 88,
    ),
    Employee(
      id: '007',
      name: 'Roberto Jiménez',
      department: 'Desarrollo',
      phone: '314-555-6666',
      isActive: true,
      performance: 79,
    ),
    Employee(
      id: '008',
      name: 'Laura Moreno',
      department: 'Marketing',
      phone: '317-777-8888',
      isActive: false,
      performance: 55,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculamos algunas estadísticas
    final int totalEmployees = _employees.length;
    final int activeEmployees = _employees.where((e) => e.isActive).length;
    final int inactiveEmployees = totalEmployees - activeEmployees;
    final double averagePerformance =
        _employees.isEmpty
            ? 0
            : _employees.map((e) => e.performance).reduce((a, b) => a + b) /
                totalEmployees;

    // Se ha comentado la verificación de autenticación para mostrar siempre la pantalla home_new
    /*
    if (!authProvider.isAuthenticated) {
      Future.microtask(
        () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SigninScreen()),
        ),
      );
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    */

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'TalentHub Pro',
          style: TextStyle(
            color: Color(0xFF4568DC),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black54,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: const Text('JB', style: TextStyle(color: Colors.black54)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF4568DC),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Empleados'),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Horarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dashboard Cards
                Row(
                  children: [
                    _buildDashboardCard(
                      'Total Empleados',
                      totalEmployees.toString(),
                      Icons.people_outline,
                      Colors.blue.shade100,
                    ),
                    const SizedBox(width: 16),
                    _buildDashboardCard(
                      'Empleados Activos',
                      activeEmployees.toString(),
                      Icons.person_outline,
                      Colors.green.shade100,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildDashboardCard(
                      'Empleados Inactivos',
                      inactiveEmployees.toString(),
                      Icons.person_off_outlined,
                      Colors.amber.shade100,
                    ),
                    const SizedBox(width: 16),
                    _buildDashboardCard(
                      'Rendimiento Promedio',
                      '${averagePerformance.toStringAsFixed(0)}%',
                      Icons.trending_up,
                      Colors.purple.shade100,
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Gestión de Empleados
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Gestión de Empleados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.people, size: 18),
                      label: const Text('Ver todos los empleados'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4568DC),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Table Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Empleado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Departamento',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Teléfono',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Estado',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Rendimiento',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Lista de empleados
                Container(
                  constraints: const BoxConstraints(maxHeight: 400),
                  child:
                      _employees.isEmpty
                          ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Icon(
                                    Icons.folder_outlined,
                                    size: 40,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No hay datos',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                          : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: _employees.length,
                            itemBuilder: (context, index) {
                              final employee = _employees[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      index % 2 == 0
                                          ? Colors.white
                                          : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    // ID
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        employee.id,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    // Nombre
                                    Expanded(
                                      flex: 3,
                                      child: Text(employee.name),
                                    ),
                                    // Departamento
                                    Expanded(
                                      flex: 3,
                                      child: Text(employee.department),
                                    ),
                                    // Teléfono
                                    Expanded(
                                      flex: 2,
                                      child: Text(employee.phone),
                                    ),
                                    // Estado
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              employee.isActive
                                                  ? Colors.green.withOpacity(
                                                    0.2,
                                                  )
                                                  : Colors.red.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          employee.isActive
                                              ? 'Activo'
                                              : 'Inactivo',
                                          style: TextStyle(
                                            color:
                                                employee.isActive
                                                    ? Colors.green.shade700
                                                    : Colors.red.shade700,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    // Rendimiento
                                    Expanded(
                                      flex: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _getPerformanceColor(
                                                employee.performance,
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${employee.performance}%',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                ),

                const SizedBox(height: 16),

                // Distribution section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Distribución por Departamento',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              height: 120,
                              alignment: Alignment.center,
                              child: Text(
                                'No hay datos disponibles',
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Acciones Rápidas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildActionButton(
                              'Gestionar Empleados',
                              Icons.people,
                            ),
                            const SizedBox(height: 12),
                            _buildActionButton(
                              'Programar Evaluación',
                              Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(title),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF4568DC),
          side: const BorderSide(color: Color(0xFF4568DC)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  // Helper method to determine color based on performance percentage
  Color _getPerformanceColor(int performance) {
    if (performance >= 80) {
      return Colors.green.shade600;
    } else if (performance >= 50) {
      return Colors.orange.shade600;
    } else {
      return Colors.red.shade600;
    }
  }
}
