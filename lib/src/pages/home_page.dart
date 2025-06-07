import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonedb_front/routes.dart';
import 'package:phonedb_front/src/layouts/base_layout.dart';
import 'package:phonedb_front/src/services/phone_service.dart';
import 'package:phonedb_front/src/layouts/card_layout.dart';
import 'package:intl/intl.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phoneService = ref.watch(phoneServiceProvider);

    return BaseLayout(
      currentRoute: AppRoutes.home,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PhoneDB'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search phones...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: phoneService.getAllPhones(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final phones = snapshot.data ?? [];
            final filteredPhones = phones.where((phone) {
              final brandModel = '${phone['brand']} ${phone['model']}'.toLowerCase();
              return brandModel.contains(_searchQuery);
            }).toList();

            if (filteredPhones.isEmpty) {
              return const Center(
                child: Text('No phones found'),
              );
            } 

            return ListView.builder(
              itemCount: filteredPhones.length,
              itemBuilder: (context, index) {
                final phone = filteredPhones[index];
                return PriceCard(
                  brandModel: '${phone['brand']} ${phone['model']}',
                  carrierName: phone['carrier_name'] ?? 'Unlocked',
                  currentPrice: phone['current_price']?.toDouble() ?? 0.0,
                  retailPrice: phone['msrp']?.toDouble() ?? 0.0,
                  discount: ((phone['msrp']?.toDouble() ?? 0.0) - (phone['current_price']?.toDouble() * 24 ?? 0.0)) / 
                           (phone['msrp']?.toDouble() ?? 1.0) * 100,
                  lowestPrice: phone['lowest_price']?.toDouble() ?? 0.0,
                  lowestEntryDate: DateFormat('yyyy-MM-dd').parse(phone['lowest_entry_date'] ?? DateTime.now().toIso8601String()),
                  lastUpdated: DateFormat('yyyy-MM-dd').parse(phone['latest_entry_date'] ?? DateTime.now().toIso8601String()),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 