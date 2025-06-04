import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceCard extends StatelessWidget {
  final double currentPrice;
  final double retailPrice;
  final double discount;
  final double lowestPrice;
  final DateTime lowestEntryDate;
  final DateTime lastUpdated;
  final String brandModel;
  final String carrierName;

  const PriceCard({
    super.key,
    required this.currentPrice,
    required this.retailPrice,
    required this.discount,
    required this.lowestPrice,
    required this.lowestEntryDate,
    required this.lastUpdated,
    required this.brandModel,
    required this.carrierName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              brandModel,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              carrierName,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Price: \$${currentPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Total Cost: \$${(currentPrice * 24).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: discount <= 0 
                        ? Colors.red 
                        : discount <= 25 
                            ? Colors.orange 
                            : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${discount.toStringAsFixed(1)}% OFF',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Retail Price: \$${retailPrice.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Lowest Recorded: \$${lowestPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            Text(
              'Lowest Entry Date: ${DateFormat('yyyy-MM-dd').format(lowestEntryDate)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                'Last updated: ${DateFormat('yyyy-MM-dd').format(lastUpdated)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 