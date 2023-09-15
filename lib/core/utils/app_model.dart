import 'package:flutter/material.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/meduls/provider/ui/account_provider_screen/account_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/home_screen/home_screen.dart';
import 'package:hatlli/meduls/provider/ui/orders_provider_screen/orders_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/products_provider_screen/products_provider_screen.dart';
import 'package:hatlli/meduls/user/ui/account_screen/account_screen.dart';
import 'package:hatlli/meduls/user/ui/home_user_screen/home_user_screen.dart';
import 'package:hatlli/meduls/user/ui/orders_screen/orders_screen.dart';
import 'package:hatlli/meduls/user/ui/providers_screen/providers_screen.dart';

import '../../meduls/common/models/address_model.dart';
import '../../meduls/common/models/category.dart';
import '../../meduls/common/models/current_user.dart';
import '../../meduls/common/models/provider.dart';

UserDetailsPref currentUser = UserDetailsPref();
Provider? currentProvider;
AddressModel? currentAddress;
String token = "";


class AppModel {
  static String userRole = "user";
  static String providerRole = "provider";
  static String token = "";
  static String lang = "";
  static String deviceToken = "";
  static String apiKey = "AIzaSyD6khcrjnt6bBk5TXIfbESW6GoprKc_knE";
 static double currentLat = 0.0;
static double currentLng = 0.0;
}

List<Widget> screensUser = [
  const HomeUserScreen(),
  OrdersScreen(),
  ProvidersScreen(),
  AccountScreen()
];

List<Widget> screensProvider = [
  const HomeProviderScreen(),
  const OrdersProviderScreen(),
  const ProductsProviderScreen(),
  const AccountProviderScreen()
];

String aboutUs = """
تعتبر هاتلي منصة فريدة بفكرتها في السوق السعودي بحيث توفر فرص البيع والشراء بالنطاق الجغرافي من حول العميل بدون دفع مبالغ اضافيه لشركات الطرف الثالث مما يزيد التكلفة على المستهلك  ( هاتلي ) تتيح للتجار والمحلات التجارية والأسر المنتجة النشر الإلكتروني لمنتجاتهم مع توصيلها للعملاء مجانا
(هاتلي ) مؤسسة رسمية مسجلة وفق الأنظمة في المملكه العربية السعودية ومقرها الرياض ومسجلة باسم مؤسسة هاتلي للتوصيل الطرود سجل تجاري رقم /  ١٠١٠٨٧٧٣٣٠
""";

String servicesText = """هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، 
لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن 
تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى 
زيادة عدد الحروف التى يولدها """;

List<CategoryModel> categories = [];

List<String> brands = ["Marka 1", "Marka 2", "Marka 3", "Marka 4", "Marka 5"];

class ColorModel {
  Color color;
  String name;
  bool isSelector;

  ColorModel(
      {required this.color, required this.name, required this.isSelector});
}

class SizeModel {
  String name;
  bool isSelector;

  SizeModel({required this.name, required this.isSelector});
}

List<ColorModel> colorsList = [
  ColorModel(color: Colors.green, name: "أخضر", isSelector: false),
  ColorModel(color: Colors.red, name: "أحمر", isSelector: false),
  ColorModel(color: Colors.black, name: "أسود", isSelector: false),
  ColorModel(color: Colors.white, name: "أبيض", isSelector: false),
  ColorModel(color: Colors.blue, name: "ازرق", isSelector: false),
  ColorModel(color: Colors.yellow, name: "اصفر", isSelector: false),
];

List<SizeModel> sizesList = [
  SizeModel(name: "S", isSelector: false),
  SizeModel(name: "M", isSelector: false),
  SizeModel(name: "L", isSelector: false),
  SizeModel(name: "XL", isSelector: false),
];

List<String> orderStatus = const [
  "جديد",
  "قيد التجهيز",
  "قيد التوصيل",
  "مستلم",
  "ملغي"
];

List<Color> orderStatusColors = const [
  Palette.mainColor,
 Colors.amber,
  Colors.orange,
  Colors.green,
 Colors.red
];

List<double> areas = const [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

List<String> orderStatusText = const [
  "تأكيد الطلب",
  " تجهيز الطلب",
  "تسليم الطلب ",
  "الغاء الطلب"
];

List<CategoryModel> sortRateList = const [
  CategoryModel(
      id: 2,
      name: "الأكثر تقييما",
       nameEng: "Most rated",
      imageUrl: "imageUrl",
      status: 0,
      createdAt: "createdAt"),
  CategoryModel(
      id: 3,
      name: "الأقرب منك",
       nameEng: "Near you",
      imageUrl: "imageUrl",
      status: 0,
      createdAt: "createdAt")
];

String privacy = """
<div>
 <h1> شروط الاستخدام </h1>
 <p>مقدمه : </p>
 <p> 
 يشار إلى منصة هاتلي على أنها الطرف الأول وهي منصة تتيح للطرف الثاني النشر الإلكتروني التجاري عليها وفق الأنظمة في المملكه العربية السعودية ومقرها الرياض ومسجلة باسم مؤسسة هاتلي للتوصيل الطرود  سجل تجاري رقم /  ١٠١٠٨٧٧٣٣٠
ويشار لطرف الثاني على انه الناشر وهو التاجر .
كما أن جميع النزاعات القانونية تقام داخل اروقة المحاكم السعودية فقط
تجدر الإشارة أن استعمالك لمنصة هاتلي يعني الموافقة القانونية على جميع الشروط والأحكام الخاصة بالمنصة .
 </p>


 <h3>المادة الأولى :</h3>
<ol>شروط استعمال منصة ( هاتلي)


  <li>اختيار القسم الصحيح بمنتاجاتك ومراجعته جيداً</li>
  <li>رفع صور جيدة تعكس جودة منتجاتك</li>
  <li> عدم التلاعب بالاسعار مما يضر بالمستهلك والسوق</li>
  <li> عدم نشر المنتجات الممنوعة بنظام المملكه العربية السعودية
( راجع السلع الممنوعه بالأسفل )
</li>
  <li>عدم استعمال منصة هاتلي إذا كنت غير مؤهل شرعاً كالحجر آو الجنون إلى آخره</li>
  <li>٦-عدم تقمص دور منشأة أو جهة بدون علمها والترويج لمنتجاتها على هاتلي</li>
  <li>عدم انتهاك أنظمة حماية البيئة والحياة الفطرية</li>
  <li>عدم استعمال المنصة للعبث أو محاولات السبام أو الطلبات العشوائية أو محاولة الاغراق أو الاختراق إلى آخره.</li>
  <li> غير مسموح قطعاً التواصل مع التجار أو الأشخاص بإسم منصة هاتلي مهما كان السبب و المبرر</li>
  <li> عدم التحايل على العملاء سواء بالأسعار أو المنتجات أو أي طريقة كانت</li>
</ol>



 <h3> البند الثاني</h3>
<ol>السلع الممنوعة في منصة هاتلي


  <li>يمنع الترويج للممنوعات والكحول نهائيا</li>
  <li>منع الترويج لجميع الأجهزة الممنوعة مثل . أجهزة التنصت والتشويش و الليزر وغيرها</li>
<li>يمنع بيع الماركات المقلدة بجميع أنواعها وأشكالها</li>
<li>يمنع بيع وترويج أي مواد مقرصنة وتنتهك الحقوق الفكرية والأدبية وحقوق النسخ</li>
<li>منع الترويج للحيوانات المهددة بالانقراض أو مخالفة نظام الحياة الفطرية
</li>
<li>يمنع الترويج للأسلحة والذخائر وما يدخل في تركيبتها وتصنيعها</li>
<li>يمنع الترويج للأجهزة أو السلع المسروقة</li>
<li>يمنع منعاً باتاً الترويج للأجهزة الحكومية أو الأوسمة والأنواط  أو أي ممتلكات حكومية</li>
<li>منع أي سلعة ممنوعة حسب النظام  في المملكة العربية السعودية</li>

</ol>

 <h3> البند الثالث :</h3>
<ol>
أخلاقيات البيع ( خاصة بالبائع )

  <li>عدم التطفيف في الكيل بالنقص من الوزن مهما كان قليلا</li>
  <li>التعاون مع العميل والصبر عليه والأخذ بالمثل القائل( العميل على حق وأن كان مخطئاً )</li>
<li>أجعل لك سياسية مرنة بالإرجاع والتعاون وأكسب العملاء بحسن تعاونك</li>
<li>لا تتذمر من طلبات العملاء فهذا باب رزق يجب عليك الحمد عليه</li>
<li>اختيار الاسعار المناسبة للبيع وجذب العملاء بها وتذكر أن الكسب السريع لايدوم</li>
<li>إذا كنت تبيع الأكل يجب عليك الاهتمام بالأكل وجودة المواد وتذكر أنه يأكل منه الأطفال والمرضى وكبار السن</li>
<li>إذا كنت تعرض السلع المستعملة يجب عليك شرعا وقانوناً أن تبين مدة أستعمالها ومدى نظافتها وأي ملاحظة على السلعة أن وجدت</li>
<li>عدم زيادة بالسعر لأجل التعويض قيمة التوصيل لأن التوصيل من مهامك ومجاناً مقابل بيع وترويج منتجاتك على نطاق واسع من حولك </li>

</ol>

<hr>
<ol>
أخلاقيات الشراء ( خاصة بالمشتري )


  <li>الشراء والتسوق متعة فلا تعكر مزاجك بأشياء صغيرة مثل تأخير الطلب البسيط أو التغليف إذا كان منتجك بخير</li>
<li>استشعر أن التاجر إنسان ويقع منه الخطأ والنسيان مهما كان حريص يجب تفهم ذلك</li>
<li>تأكد من توفر المال معك قبل اتمام الطلب سواء كاش أو بحسابك البنكي</li>
<li>تقييمك مهم للتاجر يجب مراعاة هذا الأمر بجدية وتذكر أنك محاسب على تقييمك أمام الله</li>
<li>-البيع والشراء من الأمور الجدية بالحياة يجب الابتعاد عن الطلبات الغير جادة التي تضيع وقت وجهد التاجر في تجهيز طلبات وهمية</li>
<li>تذكر أن التاجر يعمل لكسب رزقه وهو موجود على المنصة لخدمتك حاول قدر المستطاع أن تكون له عونا وسندا لتطوير نفسه والكسب الحلال من خلال تكرار الطلب منه وقت حاجتك</li>
</ol>

</div>
 """;

String quiz = """
<div>
 <h1> الأسئلة الشائعة : </h1>
 <h3>
 من الذي يحق له التسجيل بمنصة هاتلي ؟
 </h3>
 <p>
 التسجيل متاح للجميع بكل الفئات سواءً أفراد أو مؤسسات وكذلك مقيم أو مواطن
 </p>

  <h3>
  من الذي يحق له البيع على هاتلي ؟
 </h3>
 <p>
 الجميع مرحب به سواء أفراد أو مؤسسات لبيع منتجاته على منصة هاتلي
 </p>


  <h3>
  ماهي المتطلبات والأوراق المطلوبة للبيع على هاتلي  ؟
 </h3>
 <p>
 للأفراد هوية سارية المفعول  ورخصة العمل الحر( أن وجدت) ورقم للتواصل وعنوان المكان الذي تبيع منه
للمؤسسات هوية صاحب المؤسسة والسجل التجاري ورقم التواصل وعنوان المكان الذي تبيع منه
 </p>


  <h3>
  كيف يتم تفعيل الحساب ؟
 </h3>
 <p>
 حساب المشترين يتم تفعيلها تلقائيا برقم الجوال الصحيح والدخول للحساب والشراء بكل سهولة
حساب المؤسسات يتم مراجعة الأوراق من قبل الموظف بشكل روتيني ويتم التفعيل بالعادة بغضون ساعة إلى ٢٤ ساعة بخلاف يوم الجمعة
 </p>


 <h3>
 حسابي لم يتم تفعيله ماذا أفعل ؟
 </h3>
 <p>
 إذا كان حسابك مشتري يتم بالعادة التفعيل بدون تدخل للمنصة عليك التأكد من رقم الجوال المدخل حتى تتمكن من ادخال الرمز المرسل لك في حال لم يصل الرمز تواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي : 0557755462
أما إذا كان الحساب للبائع تأكد من أدخال جميع الأوراق كاملة وواضحة القراءة مع إدراج رقم جوال صحيح في حال لم يتم التفعيل  بعد مضي ٢٤ ساعة يمكنك التواصل مع خدمة العملاء ( وآتساب ) على الرقم التالي: 0557755462
 </p>


  <h3>
  كيف يتم الشراء والدفع ؟
 </h3>
 <p>
 يستطيع كل شخص شراء أي منتج يحتاجه ويقوم التاجر بتوصيل الطلب لباب المنزل
برسوم ثابتة ٢ ريال فقط مهما كان حجم الطلب أو سعره
كما انه متاح الدفع الإلكتروني والدفع الكاش عند الاستلام بدون رسوم إضافية
 </p>


  <h3>
  لماذا قيمة التوصيل منخفضة مقارنة بالتطبيقات الأخرى؟
 </h3>
 <p>
 لاننا اتفقنا مع صاحب المنتج نفسه ان يقوم بالتوصيل وليس شركات طرف ثالث تأخذ مبالغ كبيرة على خدمة التوصيل وتأخذ نسب من قيمة المنتجات أيضاً وهذا مايميز منصة هاتلي عن باقي المنصات  الأخرى
 </p>

   <h3>
   كم نسبة منصة هاتلي من قيمة المبيعات ؟
 </h3>
 <p>
 لايوجد نسبة ( مجاناً )
 </p>


   <h3>
   كم سعر التوصيل ؟
 </h3>
 <p>
 هناك رسم رمزي ثابت لكل شحنة توصيل ٢ ريال فقط مهما كانت قيمة الشحنة ووزنها وعددها
 </p>


</div>

""";

String styleMap = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]

''';


//  <h3> البند الثاني</h3>
// <ol>



//   <li></li>
// <li></li>
// <li></li>
// <li></li>
// <li></li>
// <li></li>
// <li></li>
// <li></li>
// <li></li>
// </ol>