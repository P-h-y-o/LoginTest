// import 'package:flutter/material.dart';
// import 'package:loginpage/product_model.dart';

// Widget _buildProductCard(Product products) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         height: 120,
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(12),
//                 bottomLeft: Radius.circular(12),
//               ),
//               child: Image.network(
//                 products.image,
//                 width: 120,
//                 height: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                   horizontal: 8,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       products.title,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     Text(
//                       products.id as String,
//                       style: TextStyle(color: Colors.teal, fontSize: 14),
//                     ),
//                     Text(
//                       products.description,
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
