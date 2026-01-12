import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:oms_ecommerce/core/constant/colors_constant.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_bloc.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_event.dart';
import 'package:oms_ecommerce/screen/privacy_policy/bloc/privacy_state.dart';

class PrivacyPolicyPage extends StatefulWidget {
  final String title;
  const PrivacyPolicyPage({super.key,required this.title});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  @override
  void initState() {
    context.read<PrivacyBloc>().add(PrivacyReqEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String toClassName(String input) {
      return input
          .replaceAll('_', ' ')
          .split(' ')
          .map((word) => word.isNotEmpty
          ? word[0].toUpperCase() + word.substring(1).toLowerCase()
          : '')
          .join(' ')
          .trim();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(toClassName(widget.title)),
        centerTitle: true,
      //  backgroundColor: gPrimaryColor,
        leading:  InkWell(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Bootstrap.chevron_left)),
      ),
      body: BlocBuilder<PrivacyBloc,PrivacyState>(builder: (BuildContext context, state) {
        if(state is PrivacyLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }else if(state is PrivacyLoadedState){
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,

                  child: ListView.builder(
                    itemCount: state.privacyPolicyRes!.privacyPolicy.length,
                      itemBuilder: (context , index){

                        var titleKey="";
                        var title="";
                          if(state.privacyPolicyRes!.privacyPolicy[index].key == widget.title){
                            titleKey  = state.privacyPolicyRes!.privacyPolicy[index].value!;
                            title  =state.privacyPolicyRes!.privacyPolicy[index].fileList.isNotEmpty ? state.privacyPolicyRes!.privacyPolicy[index].fileList[0].title! : "";
                          }
                          return  htmlShow(context,titleKey,title);
                      }
                  ),
                )
              ],

            ),
          );
        }else{
          return Center(child: Text("No data....."),);
        }
      },),
    );
  }

  Widget htmlShow(context,htmlText,title){
   if(htmlText != ""){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 16),
           child: Html(
             extensions: [
               TableHtmlExtension(
               ),
             ],
             data: htmlText,
             style: {
               "table": Style(
                 border: Border.all(color: Colors.grey),
                 margin: Margins.zero,
                 display: Display.inline,
               ),
               "th": Style(
                 fontWeight: FontWeight.bold,
                 border: Border.all(color: Colors.grey),
                 padding: HtmlPaddings.all(5),
                 backgroundColor: Colors.grey[200],
                 // width: Width(100), // Force header to fill cell width
                 display: Display.block, // Make header fill full width
               ),
               "td": Style(
                 padding: HtmlPaddings.all(8),
                 border: Border.all(color: Colors.grey),

               ),
               "tr": Style(
                 display: Display.inline, // Enable flex layout for equal distribution
               ),
             },
           ),
         ),
         if(title != "")
         Padding(
           padding: const EdgeInsets.only(left: 16),
           child: Text(title,style: GoogleFonts.poppins(
             fontWeight: FontWeight.w800
           ),),
         )
       ],
     );
   }else{
     return SizedBox.shrink();
   }
  }
}
