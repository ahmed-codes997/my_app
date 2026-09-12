
















// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gal/gal.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'مصمم البطاقات',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

// // ====================== الشاشة الافتتاحية ======================
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );
//     _controller.forward();
//     Future.delayed(const Duration(milliseconds: 3200), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (_, __, ___) => const MainScreen(),
//             transitionsBuilder: (_, animation, __, child) {
//               return FadeTransition(opacity: animation, child: child);
//             },
//             transitionDuration: const Duration(milliseconds: 700),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF42A5F5)],
//           ),
//         ),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(22),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.15),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.2),
//                           blurRadius: 20,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.auto_awesome, size: 70, color: Colors.white),
//                   ),
//                   const SizedBox(height: 40),
//                   const Text(
//                     'Eng. Ahmed Oransa',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 1.2,
//                       shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 6)],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     width: 80,
//                     height: 3,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.7),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'لتعيش حياة أسهل',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4),
//                   ),
//                   const SizedBox(height: 60),
//                   const SizedBox(
//                     width: 28,
//                     height: 28,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ====================== الشاشة الرئيسية ======================
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
//   Uint8List? _backgroundImage;
//   int? _imageWidth;
//   int? _imageHeight;
//   List<String> _questions = [];
//   bool _isProcessing = false;
//   String _statusMessage = '';
//   double _fontSize = 42;
//   double _textXPercent = 0.5;
//   double _textYPercent = 0.35;
//   String _previewText = 'نص تجريبي';
//   String _topic = '';
//   int _questionsCount = 10;
//   int _currentQuestionIndex = 0;
//   final List<String> _generatedImagePaths = [];
//   String _lastGeneratedPrompt = '';
//   bool _waitingForQuestions = false;

//   // ألوان قوية وواضحة
//   final List<Color> _questionColors = [
//     const Color(0xFF1565C0),
//     const Color(0xFF2E7D32),
//     const Color(0xFFC62828),
//     const Color(0xFF6A1B9A),
//     const Color(0xFFE65100),
//     const Color(0xFFAD1457),
//     const Color(0xFF00695C),
//     const Color(0xFF283593),
//     const Color(0xFFF9A825),
//     const Color(0xFF00838F),
//     const Color(0xFFBF360C),
//     const Color(0xFF4527A0),
//     const Color(0xFF558B2F),
//     const Color(0xFF0277BD),
//     const Color(0xFF6D4C41),
//     const Color(0xFF37474F),
//     const Color(0xFFD84315),
//     const Color(0xFF00897B),
//     const Color(0xFF5E35B1),
//     const Color(0xFFC2185B),
//     const Color(0xFF1976D2),
//     const Color(0xFF388E3C),
//     const Color(0xFFF57C00),
//     const Color(0xFF7B1FA2),
//   ];

//   Color get _currentTextColor {
//     if (_questions.isEmpty) return Colors.white;
//     return _questionColors[_currentQuestionIndex % _questionColors.length];
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _requestPermissions();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       Future.delayed(
//         const Duration(milliseconds: 500),
//         () {
//           if (mounted) {
//             _checkClipboardForQuestions();
//           }
//         },
//       );
//     }
//   }

//   Future<void> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       await [Permission.photos, Permission.storage].request();
//     }
//     try {
//       await Gal.requestAccess();
//     } catch (_) {}
//     setState(() => _statusMessage = '✅ جاهز');
//   }

//   Future<void> _checkClipboardForQuestions() async {
//     if (!_waitingForQuestions || !mounted) return;
//     try {
//       final clipboardData = await Clipboard.getData('text/plain');
//       final text = clipboardData?.text?.trim();
//       if (text == null || text.isEmpty) return;
//       if (text == _lastGeneratedPrompt.trim()) return;

//       final lines = text
//           .split(RegExp(r'\r?\n'))
//           .map((line) => line.trim())
//           .where((line) => line.isNotEmpty)
//           .map((line) {
//             return line
//                 .replaceFirst(
//                   RegExp(r'^\s*(?:\d+[\.\)\-:]\s*|[-•●▪◦]\s*)'),
//                   '',
//                 )
//                 .trim();
//           })
//           .where((line) => line.length >= 5)
//           .toList();

//       if (lines.isEmpty) return;

//       final questions = lines.take(_questionsCount).toList();
//       if (questions.isEmpty) return;

//       _waitingForQuestions = false;
//       setState(() {
//         _questions = questions;
//         _currentQuestionIndex = 0;
//         _previewText = _questions.first;
//         _statusMessage = '✅ تم استيراد ${_questions.length} سؤال تلقائيًا';
//       });

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('✅ تم استيراد ${_questions.length} سؤال'),
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Clipboard error: $e');
//     }
//   }

//   double _getActualFontSize(String text) {
//     double fontSize = _fontSize;
//     if (text.length > 70) {
//       fontSize *= 0.65;
//     } else if (text.length > 50) {
//       fontSize *= 0.75;
//     } else if (text.length > 35) {
//       fontSize *= 0.85;
//     }
//     return fontSize.clamp(18.0, 100.0);
//   }

//   // ====================== اختيار الصورة ======================
//   Future<void> _pickBackgroundImage() async {
//     try {
//       final PermissionState ps = await PhotoManager.requestPermissionExtend();
//       if (!mounted) return;
//       if (!ps.hasAccess) {
//         setState(() => _statusMessage = '❌ لازم تسمح بالوصول للصور');
//         return;
//       }

//       final List<AssetEntity>? result = await AssetPicker.pickAssets(
//         context,
//         pickerConfig: const AssetPickerConfig(
//           maxAssets: 1,
//           requestType: RequestType.image,
//           themeColor: Colors.blue,
//           specialPickerType: SpecialPickerType.noPreview,
//           textDelegate: ArabicAssetPickerTextDelegate(),
//         ),
//       );

//       if (!mounted) return;
//       if (result == null || result.isEmpty) return;

//       final AssetEntity asset = result.first;
//       final Uint8List? bytes = await asset.originBytes;
//       if (!mounted) return;

//       if (bytes == null) {
//         setState(() => _statusMessage = '❌ فشل قراءة الصورة');
//         return;
//       }

//       final codec = await ui.instantiateImageCodec(bytes);
//       final frame = await codec.getNextFrame();
//       final image = frame.image;

//       if (!mounted) return;
//       setState(() {
//         _backgroundImage = bytes;
//         _imageWidth = image.width;
//         _imageHeight = image.height;
//         _statusMessage = '✅ تم اختيار الصورة (${image.width}×${image.height})';
//         _textXPercent = 0.5;
//         _textYPercent = 0.35;
//       });
//     } catch (e) {
//       if (mounted) setState(() => _statusMessage = '❌ خطأ في اختيار الصورة: $e');
//     }
//   }

//   // ====================== توليد الأسئلة ======================
//   Future<void> _generateQuestions() async {
//     if (_topic.trim().isEmpty) {
//       setState(() => _statusMessage = '❌ اكتب الموضوع أولاً');
//       return;
//     }

//     setState(() {
//       _isProcessing = true;
//       _statusMessage = '⏳ جاري تجهيز الرسالة...';
//       _questions.clear();
//       _currentQuestionIndex = 0;
//     });

//     try {
//       final prompt = '''
// أريد منك إنشاء $_questionsCount سؤال مختصر عن "$_topic".
// الشروط:
// - اكتب الأسئلة فقط.
// - لا تكتب أي مقدمة أو شرح أو خاتمة.
// - كل سؤال يكون في سطر منفصل.
// - الأسئلة تكون قصيرة وواضحة ومتنوعة.
// - لا تستخدم أرقام أو نقاط أو علامات إضافية قبل الأسئلة.
// - أرسل النتيجة كنص عادي فقط.
// ''';

//       _lastGeneratedPrompt = prompt.trim();
//       _waitingForQuestions = true;

//       await Clipboard.setData(ClipboardData(text: _lastGeneratedPrompt));

//       final uri = Uri.parse('https://chatgpt.com/');
//       final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

//       if (!opened) {
//         _waitingForQuestions = false;
//         setState(() {
//           _statusMessage = '⚠️ لم يتم فتح ChatGPT، لكن الرسالة تم نسخها';
//         });
//         return;
//       }

//       setState(() {
//         _statusMessage = '🤖 أرسل الرسالة في ChatGPT ثم انسخ الأسئلة وارجع للتطبيق';
//         _previewText = _lastGeneratedPrompt;
//       });
//     } catch (e) {
//       _waitingForQuestions = false;
//       setState(() => _statusMessage = '❌ حدث خطأ: $e');
//     } finally {
//       if (mounted) setState(() => _isProcessing = false);
//     }
//   }

//   // ====================== إنشاء الصورة ======================
//   Future<Uint8List> _createImageWithText(String text, Color color, {double? xPercent, double? yPercent}) async {
//     if (_backgroundImage == null || _imageWidth == null || _imageHeight == null) {
//       throw Exception('لم يتم اختيار صورة خلفية');
//     }

//     final ui.Image image = await decodeImageFromList(_backgroundImage!);
//     final double imgW = image.width.toDouble();
//     final double imgH = image.height.toDouble();
//     final double fontSize = _getActualFontSize(text);

//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);

//     canvas.drawImage(image, Offset.zero, Paint());

//     final paragraphStyle = ui.ParagraphStyle(
//       textAlign: ui.TextAlign.center,
//       textDirection: ui.TextDirection.rtl,
//       maxLines: 10,
//       height: 1.35,
//     );

//     final builder = ui.ParagraphBuilder(paragraphStyle);
//     builder.pushStyle(ui.TextStyle(
//       color: color,
//       fontSize: fontSize,
//       fontWeight: FontWeight.bold,
//     ));
//     builder.addText(text);
//     builder.pop();

//     final paragraph = builder.build();
//     final maxTextWidth = imgW * 0.95;
//     paragraph.layout(ui.ParagraphConstraints(width: maxTextWidth));

//     final double centerX = (xPercent ?? _textXPercent) * imgW;
//     final double centerY = (yPercent ?? _textYPercent) * imgH;

//     double textX = centerX - (paragraph.width / 2);
//     double textY = centerY - (paragraph.height / 2);

//     textX = textX.clamp(10.0, imgW - paragraph.width - 10);
//     textY = textY.clamp(10.0, imgH - paragraph.height - 10);

//     canvas.drawParagraph(paragraph, Offset(textX, textY));

//     final picture = recorder.endRecording();
//     final img = await picture.toImage(image.width, image.height);
//     final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

//     image.dispose();
//     img.dispose();

//     return byteData!.buffer.asUint8List();
//   }

//   // ====================== المعاينة ======================
//   Widget _buildPreview() {
//     return GestureDetector(
//       onTap: _isProcessing ? null : _pickBackgroundImage,
//       child: Container(
//         height: 380,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300, width: 2),
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.grey.shade100,
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             if (_backgroundImage == null) {
//               return const Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.add_photo_alternate_outlined, size: 64, color: Colors.grey),
//                     SizedBox(height: 12),
//                     Text(
//                       'اضغط هنا لاختيار صورة خلفية',
//                       style: TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             final imageWidth = _imageWidth!.toDouble();
//             final imageHeight = _imageHeight!.toDouble();
//             final imageAspectRatio = imageWidth / imageHeight;

//             double displayWidth = constraints.maxWidth;
//             double displayHeight = displayWidth / imageAspectRatio;

//             if (displayHeight > constraints.maxHeight) {
//               displayHeight = constraints.maxHeight;
//               displayWidth = displayHeight * imageAspectRatio;
//             }

//             final imageLeft = (constraints.maxWidth - displayWidth) / 2;
//             final imageTop = (constraints.maxHeight - displayHeight) / 2;

//             final double fontSize = _getActualFontSize(_previewText);
//             final scale = displayWidth / imageWidth;
//             final previewFontSize = fontSize * scale;
//             final maxTextWidth = displayWidth * 0.95;

//             final textPainter = TextPainter(
//               text: TextSpan(
//                 text: _previewText,
//                 style: TextStyle(
//                   fontSize: previewFontSize,
//                   fontWeight: FontWeight.bold,
//                   height: 1.35,
//                 ),
//               ),
//               textDirection: TextDirection.rtl,
//               textAlign: TextAlign.center,
//               maxLines: 10,
//             )..layout(maxWidth: maxTextWidth);

//             final textHeight = textPainter.height;

//             return Stack(
//               children: [
//                 Positioned(
//                   left: imageLeft,
//                   top: imageTop,
//                   width: displayWidth,
//                   height: displayHeight,
//                   child: Image.memory(_backgroundImage!, fit: BoxFit.fill),
//                 ),
//                 Positioned(
//                   left: imageLeft + (_textXPercent * displayWidth) - (maxTextWidth / 2),
//                   top: imageTop + (_textYPercent * displayHeight) - (textHeight / 2),
//                   width: maxTextWidth,
//                   child: GestureDetector(
//                     onPanUpdate: (details) {
//                       setState(() {
//                         _textXPercent += details.delta.dx / displayWidth;
//                         _textYPercent += details.delta.dy / displayHeight;
//                         _textXPercent = _textXPercent.clamp(0.08, 0.92);
//                         _textYPercent = _textYPercent.clamp(0.08, 0.92);
//                       });
//                     },
//                     child: Text(
//                       _previewText,
//                       textAlign: TextAlign.center,
//                       textDirection: TextDirection.rtl,
//                       style: TextStyle(
//                         color: _currentTextColor,
//                         fontSize: previewFontSize,
//                         fontWeight: FontWeight.bold,
//                         height: 1.35,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   right: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.65),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       '🖱️ اسحب النص لتحريكه',
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // ====================== توليد الصور ======================
//   Future<void> _generateAllImages() async {
//     if (_backgroundImage == null) {
//       setState(() => _statusMessage = '❌ اختر صورة خلفية أولاً');
//       return;
//     }
//     if (_questions.isEmpty) {
//       setState(() => _statusMessage = '❌ ولد الأسئلة أولاً');
//       return;
//     }

//     setState(() {
//       _isProcessing = true;
//       _statusMessage = '⏳ جاري التوليد... (0/${_questions.length})';
//       _generatedImagePaths.clear();
//     });

//     try {
//       bool canSaveToGallery = await Gal.hasAccess();
//       if (!canSaveToGallery) canSaveToGallery = await Gal.requestAccess();

//       Directory outputDir;
//       final extDir = await getExternalStorageDirectory();
//       if (extDir != null) {
//         outputDir = Directory('${extDir.path}/CardDesigner');
//       } else {
//         final temp = await getTemporaryDirectory();
//         outputDir = Directory('${temp.path}/CardDesigner');
//       }
//       if (!await outputDir.exists()) await outputDir.create(recursive: true);

//       int successCount = 0;
//       int galleryCount = 0;
//       List<String> failed = [];

//       for (int i = 0; i < _questions.length; i++) {
//         try {
//           final question = _questions[i];
//           final color = _questionColors[i % _questionColors.length];

//           final bytes = await _createImageWithText(
//             question,
//             color,
//             xPercent: _textXPercent,
//             yPercent: _textYPercent,
//           );

//           final fileName = 'بطاقة_${(i + 1).toString().padLeft(3, '0')}.png';
//           final filePath = '${outputDir.path}/$fileName';
//           await File(filePath).writeAsBytes(bytes);
//           _generatedImagePaths.add(filePath);
//           successCount++;

//           if (canSaveToGallery) {
//             try {
//               await Gal.putImageBytes(bytes, name: 'بطاقة_${(i + 1).toString().padLeft(3, '0')}');
//               galleryCount++;
//             } catch (_) {}
//           }
//         } catch (e) {
//           failed.add('سؤال ${i + 1}: $e');
//         }

//         setState(() => _statusMessage = '⏳ تم توليد $successCount من ${_questions.length}');
//         await Future.delayed(const Duration(milliseconds: 30));
//       }

//       setState(() {
//         _statusMessage = failed.isEmpty
//             ? '✅ تم توليد $successCount صورة'
//             : '⚠️ تم توليد $successCount صورة (فشل ${failed.length})';
//       });

//       if (mounted) _showSuccessDialog(successCount, galleryCount, outputDir.path, failed);
//     } catch (e) {
//       setState(() => _statusMessage = '❌ خطأ عام: $e');
//     } finally {
//       setState(() => _isProcessing = false);
//     }
//   }

//   Future<void> _shareAllImages() async {
//     if (_generatedImagePaths.isEmpty) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('مفيش صور للمشاركة')),
//       );
//       return;
//     }

//     try {
//       final files = _generatedImagePaths.map((path) => XFile(path)).toList();
//       await Share.shareXFiles(files, text: 'بطاقات من تطبيق مصمم البطاقات');
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ في المشاركة: $e')),
//       );
//     }
//   }

//   void _showSuccessDialog(int count, int galleryCount, String path, [List<String>? failed]) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(failed == null || failed.isEmpty ? '🎉 تم الانتهاء!' : '⚠️ تم مع بعض المشاكل'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('تم توليد $count صورة'),
//               if (galleryCount > 0) ...[
//                 const SizedBox(height: 8),
//                 Text('✅ $galleryCount صورة اتحفظت في المعرض'),
//               ],
//               const SizedBox(height: 12),
//               const Text('📁 مكان الصور:', style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               SelectableText(path, style: const TextStyle(fontSize: 13, color: Colors.blue)),
//               if (failed != null && failed.isNotEmpty) ...[
//                 const SizedBox(height: 12),
//                 const Text('الأخطاء:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
//                 ...failed.take(5).map((e) => Text('• $e', style: const TextStyle(fontSize: 12))),
//               ],
//             ],
//           ),
//         ),
//         actions: [
//           if (_generatedImagePaths.isNotEmpty)
//             ElevatedButton.icon(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _shareAllImages();
//               },
//               icon: const Icon(Icons.share),
//               label: const Text('مشاركة الصور'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
//         ],
//       ),
//     );
//   }

//   void _goToPreviousQuestion() {
//     if (_questions.isEmpty) return;
//     setState(() {
//       _currentQuestionIndex = (_currentQuestionIndex - 1 + _questions.length) % _questions.length;
//       _previewText = _questions[_currentQuestionIndex];
//     });
//   }

//   void _goToNextQuestion() {
//     if (_questions.isEmpty) return;
//     setState(() {
//       _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
//       _previewText = _questions[_currentQuestionIndex];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('مصمم البطاقات'),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade700,
//         foregroundColor: Colors.white,
//         elevation: 2,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               _buildPreview(),
//               const SizedBox(height: 12),

//               // أزرار السابق / التالي
//               if (_questions.isNotEmpty) ...[
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToPreviousQuestion,
//                       icon: const Icon(Icons.arrow_back_ios_new),
//                       color: Colors.blue.shade800,
//                       tooltip: 'السابق',
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue.shade900,
//                               fontSize: 15,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             _previewText.length > 42
//                                 ? '${_previewText.substring(0, 42)}...'
//                                 : _previewText,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.blue.shade700,
//                             ),
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToNextQuestion,
//                       icon: const Icon(Icons.arrow_forward_ios),
//                       color: Colors.blue.shade800,
//                       tooltip: 'التالي',
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//               ],

//               // ========== قسم توليد الأسئلة ==========
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('توليد الأسئلة تلقائيًا', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                       const SizedBox(height: 12),
//                       TextField(
//                         textDirection: TextDirection.rtl,
//                         decoration: InputDecoration(
//                           labelText: 'الموضوع (مثال: التاريخ الإسلامي)',
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                         ),
//                         onChanged: (v) => _topic = v.trim(),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           const Text('عدد الأسئلة:'),
//                           Expanded(
//                             child: Slider(
//                               value: _questionsCount.toDouble(),
//                               min: 1,
//                               max: 50,
//                               divisions: 49,
//                               label: '$_questionsCount',
//                               onChanged: (v) => setState(() => _questionsCount = v.round()),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 40,
//                             child: Text(
//                               '$_questionsCount',
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: _isProcessing ? null : _generateQuestions,
//                           icon: const Icon(Icons.auto_awesome),
//                           label: const Text('توليد الأسئلة'),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal.shade600,
//                             foregroundColor: Colors.white,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                         ),
//                       ),
//                       if (_questions.isNotEmpty) ...[
//                         const SizedBox(height: 10),
//                         Text(
//                           '✅ تم توليد ${_questions.length} سؤال',
//                           style: TextStyle(color: Colors.green.shade700),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // أزرار التحكم
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _isProcessing
//                           ? null
//                           : () => setState(() {
//                                 _textXPercent = 0.5;
//                                 _textYPercent = 0.35;
//                               }),
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('إعادة تعيين'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.purple.shade100,
//                         foregroundColor: Colors.purple.shade900,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _isProcessing ? null : _generateAllImages,
//                       icon: _isProcessing
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
//                             )
//                           : const Icon(Icons.bolt),
//                       label: Text(_isProcessing ? 'جاري التوليد...' : 'توليد الكل'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange.shade700,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // إعدادات الخط
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.text_fields, size: 22),
//                           const SizedBox(width: 8),
//                           const Text('نص المعاينة:'),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: TextField(
//                               onChanged: (v) => setState(() => _previewText = v.isEmpty ? 'نص تجريبي' : v),
//                               textDirection: TextDirection.rtl,
//                               decoration: InputDecoration(
//                                 hintText: 'اكتب نصاً للتجربة...',
//                                 filled: true,
//                                 fillColor: Colors.grey.shade100,
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           const Icon(Icons.format_size, size: 22),
//                           const SizedBox(width: 8),
//                           const Text('حجم الخط:'),
//                           Expanded(
//                             child: Slider(
//                               value: _fontSize,
//                               min: 20,
//                               max: 100,
//                               divisions: 40,
//                               label: _fontSize.round().toString(),
//                               onChanged: (v) => setState(() => _fontSize = v),
//                             ),
//                           ),
//                           Container(
//                             width: 50,
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               '${_fontSize.round()}',
//                               style: const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // رسالة الحالة
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       _statusMessage.contains('✅')
//                           ? Icons.check_circle
//                           : _statusMessage.contains('❌')
//                               ? Icons.error
//                               : _statusMessage.contains('⏳')
//                                   ? Icons.hourglass_top
//                                   : Icons.info_outline,
//                       color: _statusMessage.contains('✅')
//                           ? Colors.green
//                           : _statusMessage.contains('❌')
//                               ? Colors.red
//                               : _statusMessage.contains('⏳')
//                                   ? Colors.orange
//                                   : Colors.blue,
//                       size: 22,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         _statusMessage.isEmpty
//                             ? '📌 اضغط على مساحة الصورة لاختيار خلفية، اسحب النص، ثم ولّد'
//                             : _statusMessage,
//                         style: TextStyle(
//                           fontSize: 13.5,
//                           color: _statusMessage.contains('✅')
//                               ? Colors.green.shade800
//                               : _statusMessage.contains('❌')
//                                   ? Colors.red.shade800
//                                   : _statusMessage.contains('⏳')
//                                       ? Colors.orange.shade800
//                                       : Colors.grey.shade800,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }














// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:gal/gal.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';
// import 'package:photo_manager/photo_manager.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'مصمم البطاقات',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }

// // ====================== كلاس الترجمة العربي ======================
// class ArabicAssetPickerTextDelegate extends AssetPickerTextDelegate {
//   const ArabicAssetPickerTextDelegate();

//   @override
//   String get confirm => 'تأكيد';

//   @override
//   String get cancel => 'إلغاء';

//   @override
//   String get edit => 'تعديل';

//   @override
//   String get gifIndicator => 'GIF';

//   @override
//   String get loadFailed => 'فشل التحميل';

//   @override
//   String get original => 'الأصلية';

//   @override
//   String get preview => 'معاينة';

//   @override
//   String get select => 'اختيار';

//   @override
//   String get emptyList => 'مفيش صور';

//   @override
//   String get unSupportedAssetType => 'نوع الملف غير مدعوم';

//   @override
//   String get unableToAccessAll => 'مش قادر أوصل لكل الصور';

//   @override
//   String get viewingLimitedAssetsTip => 'بتشوف الصور المحدودة بس';

//   @override
//   String get changeAccessibleLimitedAssets => 'تغيير الوصول للصور المحدودة';

//   @override
//   String get accessAllTip => 'السماح بالوصول لكل الصور';

//   @override
//   String get goToSystemSettings => 'روح لإعدادات النظام';

//   @override
//   String get accessLimitedAssets => 'الوصول للصور المحدودة';

//   @override
//   String get accessiblePathName => 'مسار يمكن الوصول إليه';

//   @override
//   String get sTypeAudioLabel => 'صوت';

//   @override
//   String get sTypeImageLabel => 'صورة';

//   @override
//   String get sTypeVideoLabel => 'فيديو';

//   @override
//   String get sTypeOtherLabel => 'أخرى';

//   @override
//   String get sActionPlayHint => 'تشغيل';

//   @override
//   String get sActionPreviewHint => 'معاينة';

//   @override
//   String get sActionSelectHint => 'اختيار';

//   @override
//   String get sActionSwitchPathLabel => 'تغيير المسار';

//   @override
//   String get sActionUseCameraHint => 'استخدم الكاميرا';

//   @override
//   String get sNameDurationLabel => 'المدة';

//   @override
//   String get sUnitAssetCountLabel => 'عدد';
// }

// // ====================== الشاشة الافتتاحية ======================
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1800),
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
//     );
//     _controller.forward();
//     Future.delayed(const Duration(milliseconds: 3200), () {
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (_, __, ___) => const MainScreen(),
//             transitionsBuilder: (_, animation, __, child) {
//               return FadeTransition(opacity: animation, child: child);
//             },
//             transitionDuration: const Duration(milliseconds: 700),
//           ),
//         );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF42A5F5)],
//           ),
//         ),
//         child: SafeArea(
//           child: FadeTransition(
//             opacity: _fadeAnimation,
//             child: ScaleTransition(
//               scale: _scaleAnimation,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(22),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.15),
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withValues(alpha: 0.2),
//                           blurRadius: 20,
//                           offset: const Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.auto_awesome, size: 70, color: Colors.white),
//                   ),
//                   const SizedBox(height: 40),
//                   const Text(
//                     'Eng. Ahmed Oransa',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 1.2,
//                       shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 6)],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Container(
//                     width: 80,
//                     height: 3,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.7),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'لتعيش حياة أسهل',
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4),
//                   ),
//                   const SizedBox(height: 60),
//                   const SizedBox(
//                     width: 28,
//                     height: 28,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 3,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ====================== الشاشة الرئيسية ======================
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
//   bool _isFixedTextMode = false;

//   List<Uint8List> _backgroundImages = [];
//   List<int> _imageWidths = [];
//   List<int> _imageHeights = [];
//   int _currentImageIndex = 0;

//   List<String> _questions = [];
//   String _fixedText = '';
//   String _previewText = 'نص تجريبي';
//   String _topic = '';
//   int _questionsCount = 10;
//   int _currentQuestionIndex = 0;

//   bool _isProcessing = false;
//   String _statusMessage = '';
//   double _fontSize = 42;
//   double _textXPercent = 0.5;
//   double _textYPercent = 0.35;
//   final List<String> _generatedImagePaths = [];
//   String _lastGeneratedPrompt = '';
//   bool _waitingForQuestions = false;

//   int _selectedColorIndex = 0;

// final List<Color> _availableColors = [
//   // أساسيات
//   const Color(0xFFFFFFFF), // أبيض
//   const Color(0xFF000000), // أسود
//   const Color(0xFFF5F5F5), // رمادي فاتح جدًا
//   const Color(0xFF212121), // رمادي غامق

//   // أزرق
//   const Color(0xFF1565C0),
//   const Color(0xFF1976D2),
//   const Color(0xFF2196F3),
//   const Color(0xFF03A9F4),
//   const Color(0xFF00BCD4),
//   const Color(0xFF0097A7),

//   // أخضر
//   const Color(0xFF2E7D32),
//   const Color(0xFF388E3C),
//   const Color(0xFF4CAF50),
//   const Color(0xFF8BC34A),
//   const Color(0xFF009688),
//   const Color(0xFF00796B),

//   // أحمر وبرتقالي
//   const Color(0xFFC62828),
//   const Color(0xFFE53935),
//   const Color(0xFFFF5722),
//   const Color(0xFFE65100),
//   const Color(0xFFFF9800),
//   const Color(0xFFFFC107),

//   // بنفسجي ووردي
//   const Color(0xFF6A1B9A),
//   const Color(0xFF7B1FA2),
//   const Color(0xFF9C27B0),
//   const Color(0xFFE91E63),
//   const Color(0xFFAD1457),
//   const Color(0xFFC2185B),

//   // ذهبي ونحاسي
//   const Color(0xFFFFD700), // ذهبي
//   const Color(0xFFFFC107),
//   const Color(0xFFFFB300),
//   const Color(0xFFD4AF37), // ذهبي كلاسيك
//   const Color(0xFFB8860B),
//   const Color(0xFFCD7F32), // نحاسي

//   // ألوان مميزة إضافية
//   const Color(0xFF3F51B5),
//   const Color(0xFF673AB7),
//   const Color(0xFF009688),
//   const Color(0xFF795548),
//   const Color(0xFF607D8B),
//   const Color(0xFF37474F),
//   const Color(0xFF1A237E),
//   const Color(0xFF004D40),
//   const Color(0xFFBF360C),
//   const Color(0xFF880E4F),
//   const Color(0xFF311B92),
//   const Color(0xFF1B5E20),
// ];
//   Color get _currentTextColor => _availableColors[_selectedColorIndex];

//   Uint8List? get _currentBackgroundImage {
//     if (_backgroundImages.isEmpty) return null;
//     return _backgroundImages[_currentImageIndex];
//   }

//   int? get _currentImageWidth {
//     if (_imageWidths.isEmpty) return null;
//     return _imageWidths[_currentImageIndex];
//   }

//   int? get _currentImageHeight {
//     if (_imageHeights.isEmpty) return null;
//     return _imageHeights[_currentImageIndex];
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _requestPermissions();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.resumed) {
//       Future.delayed(const Duration(milliseconds: 500), () {
//         if (mounted) _checkClipboardForQuestions();
//       });
//     }
//   }

//   Future<void> _requestPermissions() async {
//     if (Platform.isAndroid) {
//       await [Permission.photos, Permission.storage].request();
//     }
//     try {
//       await Gal.requestAccess();
//     } catch (_) {}
//     setState(() => _statusMessage = '✅ جاهز');
//   }

//   Future<void> _checkClipboardForQuestions() async {
//     if (!_waitingForQuestions || !mounted || _isFixedTextMode) return;
//     try {
//       final clipboardData = await Clipboard.getData('text/plain');
//       final text = clipboardData?.text?.trim();
//       if (text == null || text.isEmpty) return;
//       if (text == _lastGeneratedPrompt.trim()) return;

//       final lines = text
//           .split(RegExp(r'\r?\n'))
//           .map((line) => line.trim())
//           .where((line) => line.isNotEmpty)
//           .map((line) {
//             return line
//                 .replaceFirst(
//                   RegExp(r'^\s*(?:\d+[\.\)\-:]\s*|[-•●▪◦]\s*)'),
//                   '',
//                 )
//                 .trim();
//           })
//           .where((line) => line.length >= 5)
//           .toList();

//       if (lines.isEmpty) return;

//       final questions = lines.take(_questionsCount).toList();
//       if (questions.isEmpty) return;

//       _waitingForQuestions = false;
//       setState(() {
//         _questions = questions;
//         _currentQuestionIndex = 0;
//         _previewText = _questions.first;
//         _statusMessage = '✅ تم استيراد ${_questions.length} سؤال تلقائيًا';
//       });

//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('✅ تم استيراد ${_questions.length} سؤال'),
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     } catch (e) {
//       debugPrint('Clipboard error: $e');
//     }
//   }

//   double _getActualFontSize(String text) {
//     double fontSize = _fontSize;
//     if (text.length > 70) {
//       fontSize *= 0.65;
//     } else if (text.length > 50) {
//       fontSize *= 0.75;
//     } else if (text.length > 35) {
//       fontSize *= 0.85;
//     }
//     return fontSize.clamp(18.0, 100.0);
//   }

//   Future<void> _pickBackgroundImages() async {
//     try {
//       final PermissionState ps = await PhotoManager.requestPermissionExtend();
//       if (!mounted) return;
//       if (!ps.hasAccess) {
//         setState(() => _statusMessage = '❌ لازم تسمح بالوصول للصور');
//         return;
//       }

//       final int maxAssets = _isFixedTextMode ? 50 : 1;

//       final List<AssetEntity>? result = await AssetPicker.pickAssets(
//         context,
//         pickerConfig: AssetPickerConfig(
//           maxAssets: maxAssets,
//           requestType: RequestType.image,
//           themeColor: Colors.blue,
//           specialPickerType: SpecialPickerType.noPreview,
//           textDelegate: const ArabicAssetPickerTextDelegate(),
//         ),
//       );

//       if (!mounted) return;
//       if (result == null || result.isEmpty) return;

//       List<Uint8List> newImages = [];
//       List<int> newWidths = [];
//       List<int> newHeights = [];

//       for (final asset in result) {
//         final Uint8List? bytes = await asset.originBytes;
//         if (bytes == null) continue;

//         final codec = await ui.instantiateImageCodec(bytes);
//         final frame = await codec.getNextFrame();
//         final image = frame.image;

//         newImages.add(bytes);
//         newWidths.add(image.width);
//         newHeights.add(image.height);
//         image.dispose();
//       }

//       if (newImages.isEmpty) {
//         setState(() => _statusMessage = '❌ فشل قراءة الصور');
//         return;
//       }

//       setState(() {
//         _backgroundImages = newImages;
//         _imageWidths = newWidths;
//         _imageHeights = newHeights;
//         _currentImageIndex = 0;
//         _statusMessage = '✅ تم اختيار ${newImages.length} صورة';
//         _textXPercent = 0.5;
//         _textYPercent = 0.35;
//       });
//     } catch (e) {
//       if (mounted) setState(() => _statusMessage = '❌ خطأ في اختيار الصور: $e');
//     }
//   }

//   Future<void> _generateQuestions() async {
//     if (_topic.trim().isEmpty) {
//       setState(() => _statusMessage = '❌ اكتب الموضوع أولاً');
//       return;
//     }

//     setState(() {
//       _isProcessing = true;
//       _statusMessage = '⏳ جاري تجهيز الرسالة...';
//       _questions.clear();
//       _currentQuestionIndex = 0;
//     });

//     try {
//       final prompt = '''
// أريد منك إنشاء $_questionsCount سؤال مختصر عن "$_topic".
// الشروط:
// - اكتب الأسئلة فقط.
// - لا تكتب أي مقدمة أو شرح أو خاتمة.
// - كل سؤال يكون في سطر منفصل.
// - الأسئلة تكون قصيرة وواضحة ومتنوعة.
// - لا تستخدم أرقام أو نقاط أو علامات إضافية قبل الأسئلة.
// - أرسل النتيجة كنص عادي فقط.
// ''';

//       _lastGeneratedPrompt = prompt.trim();
//       _waitingForQuestions = true;

//       await Clipboard.setData(ClipboardData(text: _lastGeneratedPrompt));

//       final uri = Uri.parse('https://chatgpt.com/');
//       final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

//       if (!opened) {
//         _waitingForQuestions = false;
//         setState(() {
//           _statusMessage = '⚠️ لم يتم فتح ChatGPT، لكن الرسالة تم نسخها';
//         });
//         return;
//       }

//       setState(() {
//         _statusMessage = '🤖 أرسل الرسالة في ChatGPT ثم انسخ الأسئلة وارجع للتطبيق';
//         _previewText = _lastGeneratedPrompt;
//       });
//     } catch (e) {
//       _waitingForQuestions = false;
//       setState(() => _statusMessage = '❌ حدث خطأ: $e');
//     } finally {
//       if (mounted) setState(() => _isProcessing = false);
//     }
//   }

//   // ====================== إنشاء الصورة (مطابقة تامة) ======================
//   Future<Uint8List> _createImageWithText(
//     Uint8List backgroundBytes,
//     int imgWidth,
//     int imgHeight,
//     String text,
//     Color color, {
//     double? xPercent,
//     double? yPercent,
//   }) async {
//     final ui.Image image = await decodeImageFromList(backgroundBytes);
//     final double imgW = image.width.toDouble();
//     final double imgH = image.height.toDouble();
//     final double fontSize = _getActualFontSize(text);

//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);

//     canvas.drawImage(image, Offset.zero, Paint());

//     final textPainter = TextPainter(
//       text: TextSpan(
//         text: text,
//         style: TextStyle(
//           color: color,
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           height: 1.35,
//         ),
//       ),
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.rtl,
//       maxLines: 10,
//     );

//     final maxTextWidth = imgW * 0.92;
//     textPainter.layout(maxWidth: maxTextWidth);

//     final double centerX = (xPercent ?? _textXPercent) * imgW;
//     final double centerY = (yPercent ?? _textYPercent) * imgH;

//     double textX = centerX - (textPainter.width / 2);
//     double textY = centerY - (textPainter.height / 2);

//     textX = textX.clamp(8.0, imgW - textPainter.width - 8.0);
//     textY = textY.clamp(8.0, imgH - textPainter.height - 8.0);

//     textPainter.paint(canvas, Offset(textX, textY));

//     final picture = recorder.endRecording();
//     final img = await picture.toImage(image.width, image.height);
//     final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

//     image.dispose();
//     img.dispose();
//     textPainter.dispose();

//     return byteData!.buffer.asUint8List();
//   }

//   // ====================== المعاينة ======================
//   Widget _buildPreview() {
//     return GestureDetector(
//       onTap: _isProcessing ? null : _pickBackgroundImages,
//       child: Container(
//         height: 380,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300, width: 2),
//           borderRadius: BorderRadius.circular(14),
//           color: Colors.grey.shade100,
//         ),
//         clipBehavior: Clip.hardEdge,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             if (_currentBackgroundImage == null) {
//               return Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Icon(Icons.add_photo_alternate_outlined, size: 64, color: Colors.grey),
//                     const SizedBox(height: 12),
//                     Text(
//                       _isFixedTextMode
//                           ? 'اضغط هنا لاختيار مجموعة صور'
//                           : 'اضغط هنا لاختيار صورة خلفية',
//                       style: const TextStyle(color: Colors.grey, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             final imageWidth = _currentImageWidth!.toDouble();
//             final imageHeight = _currentImageHeight!.toDouble();
//             final imageAspectRatio = imageWidth / imageHeight;

//             double displayWidth = constraints.maxWidth;
//             double displayHeight = displayWidth / imageAspectRatio;

//             if (displayHeight > constraints.maxHeight) {
//               displayHeight = constraints.maxHeight;
//               displayWidth = displayHeight * imageAspectRatio;
//             }

//             final imageLeft = (constraints.maxWidth - displayWidth) / 2;
//             final imageTop = (constraints.maxHeight - displayHeight) / 2;

//             final double fontSize = _getActualFontSize(_previewText);
//             final scale = displayWidth / imageWidth;
//             final previewFontSize = fontSize * scale;
//             final maxTextWidth = displayWidth * 0.92;

//             final textPainter = TextPainter(
//               text: TextSpan(
//                 text: _previewText,
//                 style: TextStyle(
//                   fontSize: previewFontSize,
//                   fontWeight: FontWeight.bold,
//                   height: 1.35,
//                   color: _currentTextColor,
//                 ),
//               ),
//               textDirection: TextDirection.rtl,
//               textAlign: TextAlign.center,
//               maxLines: 10,
//             )..layout(maxWidth: maxTextWidth);

//             final textWidth = textPainter.width;
//             final textHeight = textPainter.height;

//             final double centerX = imageLeft + (_textXPercent * displayWidth);
//             final double centerY = imageTop + (_textYPercent * displayHeight);

//             double textLeft = centerX - (textWidth / 2);
//             double textTop = centerY - (textHeight / 2);

//             return Stack(
//               children: [
//                 Positioned(
//                   left: imageLeft,
//                   top: imageTop,
//                   width: displayWidth,
//                   height: displayHeight,
//                   child: Image.memory(_currentBackgroundImage!, fit: BoxFit.fill),
//                 ),
//                 Positioned(
//                   left: textLeft,
//                   top: textTop,
//                   width: textWidth,
//                   child: GestureDetector(
//                     onPanUpdate: (details) {
//                       setState(() {
//                         _textXPercent += details.delta.dx / displayWidth;
//                         _textYPercent += details.delta.dy / displayHeight;
//                         _textXPercent = _textXPercent.clamp(0.08, 0.92);
//                         _textYPercent = _textYPercent.clamp(0.08, 0.92);
//                       });
//                     },
//                     child: Text(
//                       _previewText,
//                       textAlign: TextAlign.center,
//                       textDirection: TextDirection.rtl,
//                       style: TextStyle(
//                         color: _currentTextColor,
//                         fontSize: previewFontSize,
//                         fontWeight: FontWeight.bold,
//                         height: 1.35,
//                       ),
//                     ),
//                   ),
//                 ),
//                 if (_isFixedTextMode && _backgroundImages.length > 1)
//                   Positioned(
//                     top: 10,
//                     left: 10,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withValues(alpha: 0.7),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'صورة ${_currentImageIndex + 1} / ${_backgroundImages.length}',
//                         style: const TextStyle(color: Colors.white, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                 Positioned(
//                   bottom: 10,
//                   right: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.65),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Text(
//                       '🖱️ اسحب النص لتحريكه',
//                       style: TextStyle(color: Colors.white, fontSize: 12),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Future<void> _generateAllImages() async {
//     if (_backgroundImages.isEmpty) {
//       setState(() => _statusMessage = '❌ اختر صور خلفية أولاً');
//       return;
//     }

//     if (_isFixedTextMode) {
//       if (_fixedText.trim().isEmpty) {
//         setState(() => _statusMessage = '❌ اكتب النص الثابت أولاً');
//         return;
//       }
//     } else {
//       if (_questions.isEmpty) {
//         setState(() => _statusMessage = '❌ ولد الأسئلة أولاً');
//         return;
//       }
//     }

//     setState(() {
//       _isProcessing = true;
//       _generatedImagePaths.clear();
//     });

//     try {
//       bool canSaveToGallery = await Gal.hasAccess();
//       if (!canSaveToGallery) canSaveToGallery = await Gal.requestAccess();

//       Directory outputDir;
//       final extDir = await getExternalStorageDirectory();
//       if (extDir != null) {
//         outputDir = Directory('${extDir.path}/CardDesigner');
//       } else {
//         final temp = await getTemporaryDirectory();
//         outputDir = Directory('${temp.path}/CardDesigner');
//       }
//       if (!await outputDir.exists()) await outputDir.create(recursive: true);

//       int successCount = 0;
//       int galleryCount = 0;
//       List<String> failed = [];

//       if (_isFixedTextMode) {
//         final text = _fixedText.trim();
//         final color = _currentTextColor;

//         for (int i = 0; i < _backgroundImages.length; i++) {
//           try {
//             setState(() => _statusMessage = '⏳ جاري التوليد... (${i + 1}/${_backgroundImages.length})');

//             final bytes = await _createImageWithText(
//               _backgroundImages[i],
//               _imageWidths[i],
//               _imageHeights[i],
//               text,
//               color,
//               xPercent: _textXPercent,
//               yPercent: _textYPercent,
//             );

//             final fileName = 'ثابت_${(i + 1).toString().padLeft(3, '0')}.png';
//             final filePath = '${outputDir.path}/$fileName';
//             await File(filePath).writeAsBytes(bytes);
//             _generatedImagePaths.add(filePath);
//             successCount++;

//             if (canSaveToGallery) {
//               try {
//                 await Gal.putImageBytes(bytes, name: 'ثابت_${(i + 1).toString().padLeft(3, '0')}');
//                 galleryCount++;
//               } catch (_) {}
//             }
//           } catch (e) {
//             failed.add('صورة ${i + 1}: $e');
//           }
//           await Future.delayed(const Duration(milliseconds: 30));
//         }
//       } else {
//         for (int i = 0; i < _questions.length; i++) {
//           try {
//             setState(() => _statusMessage = '⏳ جاري التوليد... (${i + 1}/${_questions.length})');

//             final question = _questions[i];
//             final color = _currentTextColor;

//             final bytes = await _createImageWithText(
//               _backgroundImages[0],
//               _imageWidths[0],
//               _imageHeights[0],
//               question,
//               color,
//               xPercent: _textXPercent,
//               yPercent: _textYPercent,
//             );

//             final fileName = 'بطاقة_${(i + 1).toString().padLeft(3, '0')}.png';
//             final filePath = '${outputDir.path}/$fileName';
//             await File(filePath).writeAsBytes(bytes);
//             _generatedImagePaths.add(filePath);
//             successCount++;

//             if (canSaveToGallery) {
//               try {
//                 await Gal.putImageBytes(bytes, name: 'بطاقة_${(i + 1).toString().padLeft(3, '0')}');
//                 galleryCount++;
//               } catch (_) {}
//             }
//           } catch (e) {
//             failed.add('سؤال ${i + 1}: $e');
//           }
//           await Future.delayed(const Duration(milliseconds: 30));
//         }
//       }

//       setState(() {
//         _statusMessage = failed.isEmpty
//             ? '✅ تم توليد $successCount صورة'
//             : '⚠️ تم توليد $successCount صورة (فشل ${failed.length})';
//       });

//       if (mounted) _showSuccessDialog(successCount, galleryCount, outputDir.path, failed);
//     } catch (e) {
//       setState(() => _statusMessage = '❌ خطأ عام: $e');
//     } finally {
//       setState(() => _isProcessing = false);
//     }
//   }

//   Future<void> _shareAllImages() async {
//     if (_generatedImagePaths.isEmpty) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('مفيش صور للمشاركة')),
//       );
//       return;
//     }

//     try {
//       final files = _generatedImagePaths.map((path) => XFile(path)).toList();
//       await Share.shareXFiles(files, text: 'بطاقات من تطبيق مصمم البطاقات');
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('خطأ في المشاركة: $e')),
//       );
//     }
//   }

//   void _showSuccessDialog(int count, int galleryCount, String path, [List<String>? failed]) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(failed == null || failed.isEmpty ? '🎉 تم الانتهاء!' : '⚠️ تم مع بعض المشاكل'),
//         content: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('تم توليد $count صورة'),
//               if (galleryCount > 0) ...[
//                 const SizedBox(height: 8),
//                 Text('✅ $galleryCount صورة اتحفظت في المعرض'),
//               ],
//               const SizedBox(height: 12),
//               const Text('📁 مكان الصور:', style: TextStyle(fontWeight: FontWeight.bold)),
//               const SizedBox(height: 4),
//               SelectableText(path, style: const TextStyle(fontSize: 13, color: Colors.blue)),
//               if (failed != null && failed.isNotEmpty) ...[
//                 const SizedBox(height: 12),
//                 const Text('الأخطاء:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
//                 ...failed.take(5).map((e) => Text('• $e', style: const TextStyle(fontSize: 12))),
//               ],
//             ],
//           ),
//         ),
//         actions: [
//           if (_generatedImagePaths.isNotEmpty)
//             ElevatedButton.icon(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 await _shareAllImages();
//               },
//               icon: const Icon(Icons.share),
//               label: const Text('مشاركة الصور'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//               ),
//             ),
//           TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
//         ],
//       ),
//     );
//   }

//   void _goToPreviousQuestion() {
//     if (_questions.isEmpty) return;
//     setState(() {
//       _currentQuestionIndex = (_currentQuestionIndex - 1 + _questions.length) % _questions.length;
//       _previewText = _questions[_currentQuestionIndex];
//     });
//   }

//   void _goToNextQuestion() {
//     if (_questions.isEmpty) return;
//     setState(() {
//       _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
//       _previewText = _questions[_currentQuestionIndex];
//     });
//   }

//   void _goToPreviousImage() {
//     if (_backgroundImages.length <= 1) return;
//     setState(() {
//       _currentImageIndex = (_currentImageIndex - 1 + _backgroundImages.length) % _backgroundImages.length;
//     });
//   }

//   void _goToNextImage() {
//     if (_backgroundImages.length <= 1) return;
//     setState(() {
//       _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('مصمم البطاقات'),
//         centerTitle: true,
//         backgroundColor: Colors.blue.shade700,
//         foregroundColor: Colors.white,
//         elevation: 2,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // اختيار الوضع
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   child: Row(
//                     children: [
//                       const Text('الوضع:', style: TextStyle(fontWeight: FontWeight.bold)),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: SegmentedButton<bool>(
//                           segments: const [
//                             ButtonSegment(value: false, label: Text('أسئلة'), icon: Icon(Icons.quiz, size: 18)),
//                             ButtonSegment(value: true, label: Text('نص ثابت'), icon: Icon(Icons.text_fields, size: 18)),
//                           ],
//                           selected: {_isFixedTextMode},
//                           onSelectionChanged: (Set<bool> newSelection) {
//                             setState(() {
//                               _isFixedTextMode = newSelection.first;
//                               _backgroundImages.clear();
//                               _imageWidths.clear();
//                               _imageHeights.clear();
//                               _currentImageIndex = 0;
//                               _questions.clear();
//                               _previewText = _isFixedTextMode
//                                   ? (_fixedText.isEmpty ? 'نص تجريبي' : _fixedText)
//                                   : 'نص تجريبي';
//                               _statusMessage = _isFixedTextMode
//                                   ? '📌 اختر مجموعة صور واكتب النص الثابت'
//                                   : '📌 اختر صورة واحدة وولّد الأسئلة';
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               _buildPreview(),
//               const SizedBox(height: 12),

//               if (_isFixedTextMode && _backgroundImages.length > 1) ...[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToPreviousImage,
//                       icon: const Icon(Icons.arrow_back_ios_new),
//                       color: Colors.blue.shade800,
//                     ),
//                     Text(
//                       'صورة ${_currentImageIndex + 1} من ${_backgroundImages.length}',
//                       style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
//                     ),
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToNextImage,
//                       icon: const Icon(Icons.arrow_forward_ios),
//                       color: Colors.blue.shade800,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//               ],

//               if (!_isFixedTextMode && _questions.isNotEmpty) ...[
//                 Row(
//                   children: [
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToPreviousQuestion,
//                       icon: const Icon(Icons.arrow_back_ios_new),
//                       color: Colors.blue.shade800,
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue.shade900,
//                               fontSize: 15,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Text(
//                             _previewText.length > 42 ? '${_previewText.substring(0, 42)}...' : _previewText,
//                             style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
//                             textAlign: TextAlign.center,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: _isProcessing ? null : _goToNextQuestion,
//                       icon: const Icon(Icons.arrow_forward_ios),
//                       color: Colors.blue.shade800,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//               ],

//               // قسم النص / الأسئلة
//               Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         _isFixedTextMode ? 'النص الثابت' : 'توليد الأسئلة تلقائيًا',
//                         style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 12),

//                       if (_isFixedTextMode) ...[
//                         TextField(
//                           textDirection: TextDirection.rtl,
//                           maxLines: 3,
//                           decoration: InputDecoration(
//                             labelText: 'اكتب النص الثابت هنا',
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                             filled: true,
//                             fillColor: Colors.grey.shade50,
//                             hintText: 'مثال: سبحان الله وبحمده',
//                           ),
//                           onChanged: (v) {
//                             setState(() {
//                               _fixedText = v;
//                               _previewText = v.isEmpty ? 'نص تجريبي' : v;
//                             });
//                           },
//                         ),
//                         const SizedBox(height: 8),
//                         if (_backgroundImages.isNotEmpty)
//                           Text(
//                             '✅ تم اختيار ${_backgroundImages.length} صورة',
//                             style: TextStyle(color: Colors.green.shade700),
//                           ),
//                       ] else ...[
//                         TextField(
//                           textDirection: TextDirection.rtl,
//                           decoration: InputDecoration(
//                             labelText: 'الموضوع (مثال: التاريخ الإسلامي)',
//                             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                             filled: true,
//                             fillColor: Colors.grey.shade50,
//                           ),
//                           onChanged: (v) => _topic = v.trim(),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             const Text('عدد الأسئلة:'),
//                             Expanded(
//                               child: Slider(
//                                 value: _questionsCount.toDouble(),
//                                 min: 1,
//                                 max: 50,
//                                 divisions: 49,
//                                 label: '$_questionsCount',
//                                 onChanged: (v) => setState(() => _questionsCount = v.round()),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 40,
//                               child: Text(
//                                 '$_questionsCount',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton.icon(
//                             onPressed: _isProcessing ? null : _generateQuestions,
//                             icon: const Icon(Icons.auto_awesome),
//                             label: const Text('توليد الأسئلة'),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.teal.shade600,
//                               foregroundColor: Colors.white,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                             ),
//                           ),
//                         ),
//                         if (_questions.isNotEmpty) ...[
//                           const SizedBox(height: 10),
//                           Text(
//                             '✅ تم توليد ${_questions.length} سؤال',
//                             style: TextStyle(color: Colors.green.shade700),
//                           ),
//                         ],
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // أزرار التحكم
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _isProcessing
//                           ? null
//                           : () => setState(() {
//                                 _textXPercent = 0.5;
//                                 _textYPercent = 0.35;
//                               }),
//                       icon: const Icon(Icons.refresh),
//                       label: const Text('إعادة تعيين'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.purple.shade100,
//                         foregroundColor: Colors.purple.shade900,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton.icon(
//                       onPressed: _isProcessing ? null : _generateAllImages,
//                       icon: _isProcessing
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
//                             )
//                           : const Icon(Icons.bolt),
//                       label: Text(_isProcessing ? 'جاري التوليد...' : 'توليد الكل'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.orange.shade700,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // إعدادات الخط + اللون
//               Card(
//                 elevation: 3,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(Icons.text_fields, size: 22),
//                           const SizedBox(width: 8),
//                           const Text('نص المعاينة:'),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: TextField(
//                               onChanged: (v) => setState(() => _previewText = v.isEmpty ? 'نص تجريبي' : v),
//                               textDirection: TextDirection.rtl,
//                               decoration: InputDecoration(
//                                 hintText: 'اكتب نصاً للتجربة...',
//                                 filled: true,
//                                 fillColor: Colors.grey.shade100,
//                                 contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           const Icon(Icons.format_size, size: 22),
//                           const SizedBox(width: 8),
//                           const Text('حجم الخط:'),
//                           Expanded(
//                             child: Slider(
//                               value: _fontSize,
//                               min: 20,
//                               max: 100,
//                               divisions: 40,
//                               label: _fontSize.round().toString(),
//                               onChanged: (v) => setState(() => _fontSize = v),
//                             ),
//                           ),
//                           Container(
//                             width: 50,
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.symmetric(vertical: 4),
//                             decoration: BoxDecoration(
//                               color: Colors.blue.shade50,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               '${_fontSize.round()}',
//                               style: const TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       const Row(
//                         children: [
//                           Icon(Icons.color_lens, size: 22),
//                           SizedBox(width: 8),
//                           Text('لون النص:', style: TextStyle(fontWeight: FontWeight.w500)),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Wrap(
//                         spacing: 10,
//                         runSpacing: 10,
//                         children: List.generate(_availableColors.length, (index) {
//                           final color = _availableColors[index];
//                           final isSelected = index == _selectedColorIndex;
//                           return GestureDetector(
//                             onTap: () => setState(() => _selectedColorIndex = index),
//                             child: Container(
//                               width: 36,
//                               height: 36,
//                               decoration: BoxDecoration(
//                                 color: color,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                   color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
//                                   width: isSelected ? 3 : 1.5,
//                                 ),
//                                 boxShadow: isSelected
//                                     ? [
//                                         BoxShadow(
//                                           color: Colors.blue.withValues(alpha: 0.4),
//                                           blurRadius: 6,
//                                           spreadRadius: 1,
//                                         )
//                                       ]
//                                     : null,
//                               ),
//                               child: isSelected
//                                   ? Icon(
//                                       Icons.check,
//                                       size: 18,
//                                       color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
//                                     )
//                                   : null,
//                             ),
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // رسالة الحالة
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(14),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade50,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(
//                       _statusMessage.contains('✅')
//                           ? Icons.check_circle
//                           : _statusMessage.contains('❌')
//                               ? Icons.error
//                               : _statusMessage.contains('⏳')
//                                   ? Icons.hourglass_top
//                                   : Icons.info_outline,
//                       color: _statusMessage.contains('✅')
//                           ? Colors.green
//                           : _statusMessage.contains('❌')
//                               ? Colors.red
//                               : _statusMessage.contains('⏳')
//                                   ? Colors.orange
//                                   : Colors.blue,
//                       size: 22,
//                     ),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         _statusMessage.isEmpty
//                             ? (_isFixedTextMode
//                                 ? '📌 اختر مجموعة صور + اكتب النص الثابت ثم ولّد'
//                                 : '📌 اضغط على مساحة الصورة لاختيار خلفية، اسحب النص، ثم ولّد')
//                             : _statusMessage,
//                         style: TextStyle(
//                           fontSize: 13.5,
//                           color: _statusMessage.contains('✅')
//                               ? Colors.green.shade800
//                               : _statusMessage.contains('❌')
//                                   ? Colors.red.shade800
//                                   : _statusMessage.contains('⏳')
//                                       ? Colors.orange.shade800
//                                       : Colors.grey.shade800,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مصمم البطاقات',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ====================== كلاس الترجمة العربي ======================
class ArabicAssetPickerTextDelegate extends AssetPickerTextDelegate {
  const ArabicAssetPickerTextDelegate();

  @override
  String get confirm => 'تأكيد';

  @override
  String get cancel => 'إلغاء';

  @override
  String get edit => 'تعديل';

  @override
  String get gifIndicator => 'GIF';

  @override
  String get loadFailed => 'فشل التحميل';

  @override
  String get original => 'الأصلية';

  @override
  String get preview => 'معاينة';

  @override
  String get select => 'اختيار';

  @override
  String get emptyList => 'مفيش صور';

  @override
  String get unSupportedAssetType => 'نوع الملف غير مدعوم';

  @override
  String get unableToAccessAll => 'مش قادر أوصل لكل الصور';

  @override
  String get viewingLimitedAssetsTip => 'بتشوف الصور المحدودة بس';

  @override
  String get changeAccessibleLimitedAssets => 'تغيير الوصول للصور المحدودة';

  @override
  String get accessAllTip => 'السماح بالوصول لكل الصور';

  @override
  String get goToSystemSettings => 'روح لإعدادات النظام';

  @override
  String get accessLimitedAssets => 'الوصول للصور المحدودة';

  @override
  String get accessiblePathName => 'مسار يمكن الوصول إليه';

  @override
  String get sTypeAudioLabel => 'صوت';

  @override
  String get sTypeImageLabel => 'صورة';

  @override
  String get sTypeVideoLabel => 'فيديو';

  @override
  String get sTypeOtherLabel => 'أخرى';

  @override
  String get sActionPlayHint => 'تشغيل';

  @override
  String get sActionPreviewHint => 'معاينة';

  @override
  String get sActionSelectHint => 'اختيار';

  @override
  String get sActionSwitchPathLabel => 'تغيير المسار';

  @override
  String get sActionUseCameraHint => 'استخدم الكاميرا';

  @override
  String get sNameDurationLabel => 'المدة';

  @override
  String get sUnitAssetCountLabel => 'عدد';
}

// ====================== الشاشة الافتتاحية ======================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
    Future.delayed(const Duration(milliseconds: 3200), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MainScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 700),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF42A5F5)],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, size: 70, color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Eng. Ahmed Oransa',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                      shadows: [Shadow(color: Colors.black26, offset: Offset(2, 2), blurRadius: 6)],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 80,
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'لتعيش حياة أسهل',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, height: 1.4),
                  ),
                  const SizedBox(height: 60),
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ====================== الشاشة الرئيسية ======================
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  // ========== رابط ملف النسخة (غيّره برابطك) ==========
  static const String versionJsonUrl = 'https://raw.githubusercontent.com/USERNAME/REPO/main/version.json';

  bool _isFixedTextMode = false;

  List<Uint8List> _backgroundImages = [];
  List<int> _imageWidths = [];
  List<int> _imageHeights = [];
  int _currentImageIndex = 0;

  List<String> _questions = [];
  String _fixedText = '';
  String _previewText = 'نص تجريبي';
  String _topic = '';
  int _questionsCount = 10;
  int _currentQuestionIndex = 0;

  bool _isProcessing = false;
  String _statusMessage = '';
  double _fontSize = 42;
  double _textXPercent = 0.5;
  double _textYPercent = 0.35;
  final List<String> _generatedImagePaths = [];
  String _lastGeneratedPrompt = '';
  bool _waitingForQuestions = false;

  int _selectedColorIndex = 0;

  final List<Color> _availableColors = [
    const Color(0xFFFFFFFF),
    const Color(0xFF000000),
    const Color(0xFFF5F5F5),
    const Color(0xFF212121),
    const Color(0xFF1565C0),
    const Color(0xFF1976D2),
    const Color(0xFF2196F3),
    const Color(0xFF03A9F4),
    const Color(0xFF00BCD4),
    const Color(0xFF0097A7),
    const Color(0xFF2E7D32),
    const Color(0xFF388E3C),
    const Color(0xFF4CAF50),
    const Color(0xFF8BC34A),
    const Color(0xFF009688),
    const Color(0xFF00796B),
    const Color(0xFFC62828),
    const Color(0xFFE53935),
    const Color(0xFFFF5722),
    const Color(0xFFE65100),
    const Color(0xFFFF9800),
    const Color(0xFFFFC107),
    const Color(0xFF6A1B9A),
    const Color(0xFF7B1FA2),
    const Color(0xFF9C27B0),
    const Color(0xFFE91E63),
    const Color(0xFFAD1457),
    const Color(0xFFC2185B),
    const Color(0xFFFFD700),
    const Color(0xFFD4AF37),
    const Color(0xFFB8860B),
    const Color(0xFFCD7F32),
    const Color(0xFF3F51B5),
    const Color(0xFF673AB7),
    const Color(0xFF795548),
    const Color(0xFF607D8B),
    const Color(0xFF37474F),
    const Color(0xFF1A237E),
    const Color(0xFF004D40),
    const Color(0xFFBF360C),
    const Color(0xFF880E4F),
    const Color(0xFF311B92),
    const Color(0xFF1B5E20),
  ];

  Color get _currentTextColor => _availableColors[_selectedColorIndex];

  Uint8List? get _currentBackgroundImage {
    if (_backgroundImages.isEmpty) return null;
    return _backgroundImages[_currentImageIndex];
  }

  int? get _currentImageWidth {
    if (_imageWidths.isEmpty) return null;
    return _imageWidths[_currentImageIndex];
  }

  int? get _currentImageHeight {
    if (_imageHeights.isEmpty) return null;
    return _imageHeights[_currentImageIndex];
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _requestPermissions();
    // فحص التحديث بعد ما الشاشة تفتح
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _checkForUpdate();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _checkClipboardForQuestions();
      });
    }
  }

  // ====================== نظام التحديث ======================
  Future<void> _checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version; // مثال: 1.0.0

      final response = await http.get(Uri.parse(versionJsonUrl)).timeout(
        const Duration(seconds: 8),
      );

      if (response.statusCode != 200) return;

      final data = json.decode(response.body);
      final remoteVersion = data['version']?.toString() ?? '';
      final downloadUrl = data['downloadUrl']?.toString() ?? '';
      final message = data['message']?.toString() ?? 'يوجد تحديث جديد للتطبيق';

      if (remoteVersion.isEmpty || downloadUrl.isEmpty) return;

      // مقارنة بسيطة للنسخ
      if (_isVersionNewer(remoteVersion, currentVersion)) {
        if (!mounted) return;
        _showUpdateDialog(remoteVersion, downloadUrl, message);
      }
    } catch (e) {
      debugPrint('Update check failed: $e');
    }
  }

  bool _isVersionNewer(String remote, String current) {
    try {
      final r = remote.split('.').map(int.parse).toList();
      final c = current.split('.').map(int.parse).toList();

      for (int i = 0; i < r.length; i++) {
        if (i >= c.length) return true;
        if (r[i] > c[i]) return true;
        if (r[i] < c[i]) return false;
      }
      return false;
    } catch (_) {
      return remote != current;
    }
  }

  void _showUpdateDialog(String newVersion, String downloadUrl, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.system_update, color: Colors.blue),
            SizedBox(width: 10),
            Text('تحديث جديد'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('النسخة الجديدة: $newVersion'),
            const SizedBox(height: 12),
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لاحقاً'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              Navigator.pop(context);
              final uri = Uri.parse(downloadUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            icon: const Icon(Icons.download),
            label: const Text('تحديث الآن'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [Permission.photos, Permission.storage].request();
    }
    try {
      await Gal.requestAccess();
    } catch (_) {}
    setState(() => _statusMessage = '✅ جاهز');
  }

  Future<void> _checkClipboardForQuestions() async {
    if (!_waitingForQuestions || !mounted || _isFixedTextMode) return;
    try {
      final clipboardData = await Clipboard.getData('text/plain');
      final text = clipboardData?.text?.trim();
      if (text == null || text.isEmpty) return;
      if (text == _lastGeneratedPrompt.trim()) return;

      final lines = text
          .split(RegExp(r'\r?\n'))
          .map((line) => line.trim())
          .where((line) => line.isNotEmpty)
          .map((line) {
            return line
                .replaceFirst(
                  RegExp(r'^\s*(?:\d+[\.\)\-:]\s*|[-•●▪◦]\s*)'),
                  '',
                )
                .trim();
          })
          .where((line) => line.length >= 5)
          .toList();

      if (lines.isEmpty) return;

      final questions = lines.take(_questionsCount).toList();
      if (questions.isEmpty) return;

      _waitingForQuestions = false;
      setState(() {
        _questions = questions;
        _currentQuestionIndex = 0;
        _previewText = _questions.first;
        _statusMessage = '✅ تم استيراد ${_questions.length} سؤال تلقائيًا';
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ تم استيراد ${_questions.length} سؤال'),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      debugPrint('Clipboard error: $e');
    }
  }

  double _getActualFontSize(String text) {
    double fontSize = _fontSize;
    if (text.length > 70) {
      fontSize *= 0.65;
    } else if (text.length > 50) {
      fontSize *= 0.75;
    } else if (text.length > 35) {
      fontSize *= 0.85;
    }
    return fontSize.clamp(18.0, 100.0);
  }

  Future<void> _pickBackgroundImages() async {
    try {
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (!mounted) return;
      if (!ps.hasAccess) {
        setState(() => _statusMessage = '❌ لازم تسمح بالوصول للصور');
        return;
      }

      final int maxAssets = _isFixedTextMode ? 50 : 1;

      final List<AssetEntity>? result = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: maxAssets,
          requestType: RequestType.image,
          themeColor: Colors.blue,
          specialPickerType: SpecialPickerType.noPreview,
          textDelegate: const ArabicAssetPickerTextDelegate(),
        ),
      );

      if (!mounted) return;
      if (result == null || result.isEmpty) return;

      List<Uint8List> newImages = [];
      List<int> newWidths = [];
      List<int> newHeights = [];

      for (final asset in result) {
        final Uint8List? bytes = await asset.originBytes;
        if (bytes == null) continue;

        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        final image = frame.image;

        newImages.add(bytes);
        newWidths.add(image.width);
        newHeights.add(image.height);
        image.dispose();
      }

      if (newImages.isEmpty) {
        setState(() => _statusMessage = '❌ فشل قراءة الصور');
        return;
      }

      setState(() {
        _backgroundImages = newImages;
        _imageWidths = newWidths;
        _imageHeights = newHeights;
        _currentImageIndex = 0;
        _statusMessage = '✅ تم اختيار ${newImages.length} صورة';
        _textXPercent = 0.5;
        _textYPercent = 0.35;
      });
    } catch (e) {
      if (mounted) setState(() => _statusMessage = '❌ خطأ في اختيار الصور: $e');
    }
  }

  Future<void> _generateQuestions() async {
    if (_topic.trim().isEmpty) {
      setState(() => _statusMessage = '❌ اكتب الموضوع أولاً');
      return;
    }

    setState(() {
      _isProcessing = true;
      _statusMessage = '⏳ جاري تجهيز الرسالة...';
      _questions.clear();
      _currentQuestionIndex = 0;
    });

    try {
      final prompt = '''
أريد منك إنشاء $_questionsCount سؤال مختصر عن "$_topic".
الشروط:
- اكتب الأسئلة فقط.
- لا تكتب أي مقدمة أو شرح أو خاتمة.
- كل سؤال يكون في سطر منفصل.
- الأسئلة تكون قصيرة وواضحة ومتنوعة.
- لا تستخدم أرقام أو نقاط أو علامات إضافية قبل الأسئلة.
- أرسل النتيجة كنص عادي فقط.
''';

      _lastGeneratedPrompt = prompt.trim();
      _waitingForQuestions = true;

      await Clipboard.setData(ClipboardData(text: _lastGeneratedPrompt));

      final uri = Uri.parse('https://chatgpt.com/');
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened) {
        _waitingForQuestions = false;
        setState(() {
          _statusMessage = '⚠️ لم يتم فتح ChatGPT، لكن الرسالة تم نسخها';
        });
        return;
      }

      setState(() {
        _statusMessage = '🤖 أرسل الرسالة في ChatGPT ثم انسخ الأسئلة وارجع للتطبيق';
        _previewText = _lastGeneratedPrompt;
      });
    } catch (e) {
      _waitingForQuestions = false;
      setState(() => _statusMessage = '❌ حدث خطأ: $e');
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  Future<Uint8List> _createImageWithText(
    Uint8List backgroundBytes,
    int imgWidth,
    int imgHeight,
    String text,
    Color color, {
    double? xPercent,
    double? yPercent,
  }) async {
    final ui.Image image = await decodeImageFromList(backgroundBytes);
    final double imgW = image.width.toDouble();
    final double imgH = image.height.toDouble();
    final double fontSize = _getActualFontSize(text);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    canvas.drawImage(image, Offset.zero, Paint());

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          height: 1.35,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.rtl,
      maxLines: 10,
    );

    final maxTextWidth = imgW * 0.92;
    textPainter.layout(maxWidth: maxTextWidth);

    final double centerX = (xPercent ?? _textXPercent) * imgW;
    final double centerY = (yPercent ?? _textYPercent) * imgH;

    double textX = centerX - (textPainter.width / 2);
    double textY = centerY - (textPainter.height / 2);

    textX = textX.clamp(8.0, imgW - textPainter.width - 8.0);
    textY = textY.clamp(8.0, imgH - textPainter.height - 8.0);

    textPainter.paint(canvas, Offset(textX, textY));

    final picture = recorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    image.dispose();
    img.dispose();
    textPainter.dispose();

    return byteData!.buffer.asUint8List();
  }

  Widget _buildPreview() {
    return GestureDetector(
      onTap: _isProcessing ? null : _pickBackgroundImages,
      child: Container(
        height: 380,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.shade100,
        ),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (_currentBackgroundImage == null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.add_photo_alternate_outlined, size: 64, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text(
                      _isFixedTextMode
                          ? 'اضغط هنا لاختيار مجموعة صور'
                          : 'اضغط هنا لاختيار صورة خلفية',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              );
            }

            final imageWidth = _currentImageWidth!.toDouble();
            final imageHeight = _currentImageHeight!.toDouble();
            final imageAspectRatio = imageWidth / imageHeight;

            double displayWidth = constraints.maxWidth;
            double displayHeight = displayWidth / imageAspectRatio;

            if (displayHeight > constraints.maxHeight) {
              displayHeight = constraints.maxHeight;
              displayWidth = displayHeight * imageAspectRatio;
            }

            final imageLeft = (constraints.maxWidth - displayWidth) / 2;
            final imageTop = (constraints.maxHeight - displayHeight) / 2;

            final double fontSize = _getActualFontSize(_previewText);
            final scale = displayWidth / imageWidth;
            final previewFontSize = fontSize * scale;
            final maxTextWidth = displayWidth * 0.92;

            final textPainter = TextPainter(
              text: TextSpan(
                text: _previewText,
                style: TextStyle(
                  fontSize: previewFontSize,
                  fontWeight: FontWeight.bold,
                  height: 1.35,
                  color: _currentTextColor,
                ),
              ),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              maxLines: 10,
            )..layout(maxWidth: maxTextWidth);

            final textWidth = textPainter.width;
            final textHeight = textPainter.height;

            final double centerX = imageLeft + (_textXPercent * displayWidth);
            final double centerY = imageTop + (_textYPercent * displayHeight);

            double textLeft = centerX - (textWidth / 2);
            double textTop = centerY - (textHeight / 2);

            return Stack(
              children: [
                Positioned(
                  left: imageLeft,
                  top: imageTop,
                  width: displayWidth,
                  height: displayHeight,
                  child: Image.memory(_currentBackgroundImage!, fit: BoxFit.fill),
                ),
                Positioned(
                  left: textLeft,
                  top: textTop,
                  width: textWidth,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _textXPercent += details.delta.dx / displayWidth;
                        _textYPercent += details.delta.dy / displayHeight;
                        _textXPercent = _textXPercent.clamp(0.08, 0.92);
                        _textYPercent = _textYPercent.clamp(0.08, 0.92);
                      });
                    },
                    child: Text(
                      _previewText,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: _currentTextColor,
                        fontSize: previewFontSize,
                        fontWeight: FontWeight.bold,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
                if (_isFixedTextMode && _backgroundImages.length > 1)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'صورة ${_currentImageIndex + 1} / ${_backgroundImages.length}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '🖱️ اسحب النص لتحريكه',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _generateAllImages() async {
    if (_backgroundImages.isEmpty) {
      setState(() => _statusMessage = '❌ اختر صور خلفية أولاً');
      return;
    }

    if (_isFixedTextMode) {
      if (_fixedText.trim().isEmpty) {
        setState(() => _statusMessage = '❌ اكتب النص الثابت أولاً');
        return;
      }
    } else {
      if (_questions.isEmpty) {
        setState(() => _statusMessage = '❌ ولد الأسئلة أولاً');
        return;
      }
    }

    setState(() {
      _isProcessing = true;
      _generatedImagePaths.clear();
    });

    try {
      bool canSaveToGallery = await Gal.hasAccess();
      if (!canSaveToGallery) canSaveToGallery = await Gal.requestAccess();

      Directory outputDir;
      final extDir = await getExternalStorageDirectory();
      if (extDir != null) {
        outputDir = Directory('${extDir.path}/CardDesigner');
      } else {
        final temp = await getTemporaryDirectory();
        outputDir = Directory('${temp.path}/CardDesigner');
      }
      if (!await outputDir.exists()) await outputDir.create(recursive: true);

      int successCount = 0;
      int galleryCount = 0;
      List<String> failed = [];

      if (_isFixedTextMode) {
        final text = _fixedText.trim();
        final color = _currentTextColor;

        for (int i = 0; i < _backgroundImages.length; i++) {
          try {
            setState(() => _statusMessage = '⏳ جاري التوليد... (${i + 1}/${_backgroundImages.length})');

            final bytes = await _createImageWithText(
              _backgroundImages[i],
              _imageWidths[i],
              _imageHeights[i],
              text,
              color,
              xPercent: _textXPercent,
              yPercent: _textYPercent,
            );

            final fileName = 'ثابت_${(i + 1).toString().padLeft(3, '0')}.png';
            final filePath = '${outputDir.path}/$fileName';
            await File(filePath).writeAsBytes(bytes);
            _generatedImagePaths.add(filePath);
            successCount++;

            if (canSaveToGallery) {
              try {
                await Gal.putImageBytes(bytes, name: 'ثابت_${(i + 1).toString().padLeft(3, '0')}');
                galleryCount++;
              } catch (_) {}
            }
          } catch (e) {
            failed.add('صورة ${i + 1}: $e');
          }
          await Future.delayed(const Duration(milliseconds: 30));
        }
      } else {
        for (int i = 0; i < _questions.length; i++) {
          try {
            setState(() => _statusMessage = '⏳ جاري التوليد... (${i + 1}/${_questions.length})');

            final question = _questions[i];
            final color = _currentTextColor;

            final bytes = await _createImageWithText(
              _backgroundImages[0],
              _imageWidths[0],
              _imageHeights[0],
              question,
              color,
              xPercent: _textXPercent,
              yPercent: _textYPercent,
            );

            final fileName = 'بطاقة_${(i + 1).toString().padLeft(3, '0')}.png';
            final filePath = '${outputDir.path}/$fileName';
            await File(filePath).writeAsBytes(bytes);
            _generatedImagePaths.add(filePath);
            successCount++;

            if (canSaveToGallery) {
              try {
                await Gal.putImageBytes(bytes, name: 'بطاقة_${(i + 1).toString().padLeft(3, '0')}');
                galleryCount++;
              } catch (_) {}
            }
          } catch (e) {
            failed.add('سؤال ${i + 1}: $e');
          }
          await Future.delayed(const Duration(milliseconds: 30));
        }
      }

      setState(() {
        _statusMessage = failed.isEmpty
            ? '✅ تم توليد $successCount صورة'
            : '⚠️ تم توليد $successCount صورة (فشل ${failed.length})';
      });

      if (mounted) _showSuccessDialog(successCount, galleryCount, outputDir.path, failed);
    } catch (e) {
      setState(() => _statusMessage = '❌ خطأ عام: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _shareAllImages() async {
    if (_generatedImagePaths.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('مفيش صور للمشاركة')),
      );
      return;
    }

    try {
      final files = _generatedImagePaths.map((path) => XFile(path)).toList();
      await Share.shareXFiles(files, text: 'بطاقات من تطبيق مصمم البطاقات');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في المشاركة: $e')),
      );
    }
  }

  void _showSuccessDialog(int count, int galleryCount, String path, [List<String>? failed]) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(failed == null || failed.isEmpty ? '🎉 تم الانتهاء!' : '⚠️ تم مع بعض المشاكل'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('تم توليد $count صورة'),
              if (galleryCount > 0) ...[
                const SizedBox(height: 8),
                Text('✅ $galleryCount صورة اتحفظت في المعرض'),
              ],
              const SizedBox(height: 12),
              const Text('📁 مكان الصور:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              SelectableText(path, style: const TextStyle(fontSize: 13, color: Colors.blue)),
              if (failed != null && failed.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text('الأخطاء:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                ...failed.take(5).map((e) => Text('• $e', style: const TextStyle(fontSize: 12))),
              ],
            ],
          ),
        ),
        actions: [
          if (_generatedImagePaths.isNotEmpty)
            ElevatedButton.icon(
              onPressed: () async {
                Navigator.pop(context);
                await _shareAllImages();
              },
              icon: const Icon(Icons.share),
              label: const Text('مشاركة الصور'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('حسناً')),
        ],
      ),
    );
  }

  void _goToPreviousQuestion() {
    if (_questions.isEmpty) return;
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex - 1 + _questions.length) % _questions.length;
      _previewText = _questions[_currentQuestionIndex];
    });
  }

  void _goToNextQuestion() {
    if (_questions.isEmpty) return;
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
      _previewText = _questions[_currentQuestionIndex];
    });
  }

  void _goToPreviousImage() {
    if (_backgroundImages.length <= 1) return;
    setState(() {
      _currentImageIndex = (_currentImageIndex - 1 + _backgroundImages.length) % _backgroundImages.length;
    });
  }

  void _goToNextImage() {
    if (_backgroundImages.length <= 1) return;
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _backgroundImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مصمم البطاقات'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      const Text('الوضع:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: false, label: Text('أسئلة'), icon: Icon(Icons.quiz, size: 18)),
                            ButtonSegment(value: true, label: Text('نص ثابت'), icon: Icon(Icons.text_fields, size: 18)),
                          ],
                          selected: {_isFixedTextMode},
                          onSelectionChanged: (Set<bool> newSelection) {
                            setState(() {
                              _isFixedTextMode = newSelection.first;
                              _backgroundImages.clear();
                              _imageWidths.clear();
                              _imageHeights.clear();
                              _currentImageIndex = 0;
                              _questions.clear();
                              _previewText = _isFixedTextMode
                                  ? (_fixedText.isEmpty ? 'نص تجريبي' : _fixedText)
                                  : 'نص تجريبي';
                              _statusMessage = _isFixedTextMode
                                  ? '📌 اختر مجموعة صور واكتب النص الثابت'
                                  : '📌 اختر صورة واحدة وولّد الأسئلة';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              _buildPreview(),
              const SizedBox(height: 12),

              if (_isFixedTextMode && _backgroundImages.length > 1) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _isProcessing ? null : _goToPreviousImage,
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.blue.shade800,
                    ),
                    Text(
                      'صورة ${_currentImageIndex + 1} من ${_backgroundImages.length}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                    ),
                    IconButton(
                      onPressed: _isProcessing ? null : _goToNextImage,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.blue.shade800,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],

              if (!_isFixedTextMode && _questions.isNotEmpty) ...[
                Row(
                  children: [
                    IconButton(
                      onPressed: _isProcessing ? null : _goToPreviousQuestion,
                      icon: const Icon(Icons.arrow_back_ios_new),
                      color: Colors.blue.shade800,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'السؤال ${_currentQuestionIndex + 1} من ${_questions.length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _previewText.length > 42 ? '${_previewText.substring(0, 42)}...' : _previewText,
                            style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: _isProcessing ? null : _goToNextQuestion,
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.blue.shade800,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isFixedTextMode ? 'النص الثابت' : 'توليد الأسئلة تلقائيًا',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 12),

                      if (_isFixedTextMode) ...[
                        TextField(
                          textDirection: TextDirection.rtl,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'اكتب النص الثابت هنا',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                            hintText: 'مثال: سبحان الله وبحمده',
                          ),
                          onChanged: (v) {
                            setState(() {
                              _fixedText = v;
                              _previewText = v.isEmpty ? 'نص تجريبي' : v;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        if (_backgroundImages.isNotEmpty)
                          Text(
                            '✅ تم اختيار ${_backgroundImages.length} صورة',
                            style: TextStyle(color: Colors.green.shade700),
                          ),
                      ] else ...[
                        TextField(
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            labelText: 'الموضوع (مثال: التاريخ الإسلامي)',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            filled: true,
                            fillColor: Colors.grey.shade50,
                          ),
                          onChanged: (v) => _topic = v.trim(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('عدد الأسئلة:'),
                            Expanded(
                              child: Slider(
                                value: _questionsCount.toDouble(),
                                min: 1,
                                max: 50,
                                divisions: 49,
                                label: '$_questionsCount',
                                onChanged: (v) => setState(() => _questionsCount = v.round()),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: Text(
                                '$_questionsCount',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isProcessing ? null : _generateQuestions,
                            icon: const Icon(Icons.auto_awesome),
                            label: const Text('توليد الأسئلة'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        if (_questions.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Text(
                            '✅ تم توليد ${_questions.length} سؤال',
                            style: TextStyle(color: Colors.green.shade700),
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing
                          ? null
                          : () => setState(() {
                                _textXPercent = 0.5;
                                _textYPercent = 0.35;
                              }),
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة تعيين'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade100,
                        foregroundColor: Colors.purple.shade900,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isProcessing ? null : _generateAllImages,
                      icon: _isProcessing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                            )
                          : const Icon(Icons.bolt),
                      label: Text(_isProcessing ? 'جاري التوليد...' : 'توليد الكل'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.text_fields, size: 22),
                          const SizedBox(width: 8),
                          const Text('نص المعاينة:'),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onChanged: (v) => setState(() => _previewText = v.isEmpty ? 'نص تجريبي' : v),
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                hintText: 'اكتب نصاً للتجربة...',
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.format_size, size: 22),
                          const SizedBox(width: 8),
                          const Text('حجم الخط:'),
                          Expanded(
                            child: Slider(
                              value: _fontSize,
                              min: 20,
                              max: 100,
                              divisions: 40,
                              label: _fontSize.round().toString(),
                              onChanged: (v) => setState(() => _fontSize = v),
                            ),
                          ),
                          Container(
                            width: 50,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${_fontSize.round()}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        children: [
                          Icon(Icons.color_lens, size: 22),
                          SizedBox(width: 8),
                          Text('لون النص:', style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(_availableColors.length, (index) {
                          final color = _availableColors[index];
                          final isSelected = index == _selectedColorIndex;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedColorIndex = index),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.blue.shade700 : Colors.grey.shade400,
                                  width: isSelected ? 3 : 1.5,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: Colors.blue.withValues(alpha: 0.4),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        )
                                      ]
                                    : null,
                              ),
                              child: isSelected
                                  ? Icon(
                                      Icons.check,
                                      size: 18,
                                      color: color.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                                    )
                                  : null,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      _statusMessage.contains('✅')
                          ? Icons.check_circle
                          : _statusMessage.contains('❌')
                              ? Icons.error
                              : _statusMessage.contains('⏳')
                                  ? Icons.hourglass_top
                                  : Icons.info_outline,
                      color: _statusMessage.contains('✅')
                          ? Colors.green
                          : _statusMessage.contains('❌')
                              ? Colors.red
                              : _statusMessage.contains('⏳')
                                  ? Colors.orange
                                  : Colors.blue,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _statusMessage.isEmpty
                            ? (_isFixedTextMode
                                ? '📌 اختر مجموعة صور + اكتب النص الثابت ثم ولّد'
                                : '📌 اضغط على مساحة الصورة لاختيار خلفية، اسحب النص، ثم ولّد')
                            : _statusMessage,
                        style: TextStyle(
                          fontSize: 13.5,
                          color: _statusMessage.contains('✅')
                              ? Colors.green.shade800
                              : _statusMessage.contains('❌')
                                  ? Colors.red.shade800
                                  : _statusMessage.contains('⏳')
                                      ? Colors.orange.shade800
                                      : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}