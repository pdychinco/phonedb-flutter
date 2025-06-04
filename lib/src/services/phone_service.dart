import 'package:phonedb_front/src/repositories/supabase_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for the phone service
final phoneServiceProvider = Provider<PhoneService>((ref) {
  return PhoneService(ref.watch(supabaseClientProvider));
});

class PhoneService {
  final SupabaseService _supabase;

  PhoneService(this._supabase);

  // Get first 5 phones from the database
  Future<List<Map<String, dynamic>>> getAllPhones() async {
    try {
      final response = await _supabase.supabaseClient
          .from('main')
          .select('*, products!inner(brand, model, msrp), carrier!inner(name)',)
          .order('latest_entry_date', ascending: false);
      final flattenedResponse = response.map((item) {
        final product = item['products'] as Map<String, dynamic>;
        final carrier = item['carrier'] as Map<String, dynamic>;
        
        return {
          ...item,
          'brand': product['brand'],
          'model': product['model'],
          'msrp': product['msrp'],
          'carrier_name': carrier['name'],
        }..removeWhere((key, value) => key == 'products' || key == 'carrier');
      }).toList();
      
      return List<Map<String, dynamic>>.from(flattenedResponse);
    } catch (e) {
      print('Error fetching phones: $e');
      return [];
    }
  }

  // Get phone by ID
  Future<Map<String, dynamic>?> getPhoneById(String id) async {
    try {
      final response = await _supabase.supabaseClient
          .from('phones')
          .select()
          .eq('id', id)
          .single();
      
      return response as Map<String, dynamic>?;
    } catch (e) {
      print('Error fetching phone: $e');
      return null;
    }
  }

  // Search phones by name or model
  Future<List<Map<String, dynamic>>> searchPhones(String query) async {
    try {
      final response = await _supabase.supabaseClient
          .from('phones')
          .select()
          .or('name.ilike.%$query%,model.ilike.%$query%')
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Error searching phones: $e');
      return [];
    }
  }
} 