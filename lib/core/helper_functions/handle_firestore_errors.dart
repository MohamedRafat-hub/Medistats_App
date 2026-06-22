import 'package:cloud_firestore/cloud_firestore.dart';

String handleFirebaseError(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
      return 'عذراً، ليس لديك الصلاحية لحفظ بيانات هذا المريض. يرجى مراجعة مدير النظام.';
    case 'unavailable':
      return 'يبدو أن خدمة السيرفر غير متاحة حالياً، أو أن هناك مشكلة في إنترنت العيادة. يرجى التحقق من الاتصال.';
    case 'network-request-failed':
      return 'انقطع الاتصال بالإنترنت. تأكد من اتصال جهازك بالشبكة ثم أعد المحاولة.';
    case 'deadline-exceeded':
      return 'استغرقت العملية وقتاً أطول من المعتاد (انتهت مهلة الطلب). يرجى المحاولة مجدداً.';
    case 'cancelled':
      return 'تم إلغاء عملية حفظ بيانات المريض بواسطة المستخدم أو النظام.';
    default:
    // لو كود غريب مش متوقع، بنطلع الرسالة الأصلية بشكل نظيف أو رسالة عامة
      return e.message ?? 'حدث خطأ في السيرفر أثناء حفظ البيانات، يرجى المحاولة لاحقاً.';
  }
}
