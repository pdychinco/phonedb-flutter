import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonedb_front/routes.dart';
import 'package:phonedb_front/src/layouts/base_layout.dart';
import 'package:phonedb_front/src/services/phone_service.dart';
import 'package:phonedb_front/src/layouts/card_layout.dart';
import 'package:intl/intl.dart';

class PhoneListPage extends ConsumerStatefulWidget {
  const PhoneListPage({super.key});

  @override
  ConsumerState<PhoneListPage> createState() => _PhoneListPageState();
}

class _PhoneListPageState extends ConsumerState<PhoneListPage> {
  String? selectedBrand;
  String? selectedCarrier;

  @override
  Widget build(BuildContext context) {
    final phoneService = ref.watch(phoneServiceProvider);

    return BaseLayout(
      currentRoute: AppRoutes.phoneList,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Phone List'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: phoneService.getUniqueBrands(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Brand',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          ),
                          value: selectedBrand,
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('All Brands', overflow: TextOverflow.ellipsis),
                            ),
                            ...snapshot.data!.map((brand) {
                              return DropdownMenuItem<String>(
                                value: brand,
                                child: Text(brand, overflow: TextOverflow.ellipsis),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedBrand = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FutureBuilder<List<String>>(
                      future: phoneService.getUniqueCarriers(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Carrier',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          ),
                          value: selectedCarrier,
                          isExpanded: true,
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('All Carriers', overflow: TextOverflow.ellipsis),
                            ),
                            ...snapshot.data!.map((carrier) {
                              return DropdownMenuItem<String>(
                                value: carrier,
                                child: Text(carrier, overflow: TextOverflow.ellipsis),
                              );
                            }),
                          ],
                          onChanged: (value) {
                            setState(() {
                              selectedCarrier = value;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
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
                    final matchesBrand = selectedBrand == null || 
                        phone['brand'] == selectedBrand;
                    final matchesCarrier = selectedCarrier == null || 
                        phone['carrier_name'] == selectedCarrier;
                    return matchesBrand && matchesCarrier;
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
                        discount: ((phone['msrp']?.toDouble() ?? 0.0) - 
                                (phone['current_price']?.toDouble() * 24 ?? 0.0)) / 
                                (phone['msrp']?.toDouble() ?? 1.0) * 100,
                        lowestPrice: phone['lowest_price']?.toDouble() ?? 0.0,
                        lowestEntryDate: DateFormat('yyyy-MM-dd')
                            .parse(phone['lowest_entry_date'] ?? DateTime.now().toIso8601String()),
                        lastUpdated: DateFormat('yyyy-MM-dd')
                            .parse(phone['latest_entry_date'] ?? DateTime.now().toIso8601String()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 