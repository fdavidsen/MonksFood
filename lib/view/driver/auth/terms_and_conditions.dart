import 'package:flutter/material.dart';

String teks =
    'Insurance Terms and Conditions\nEffective Date: [Date]\nThese Insurance Terms and Conditions (hereinafter referred to as "Insurance Terms") apply to consumers who opt to participate in the insurance plan offered by [Company Name] (hereinafter referred to as "we", "us", or "our").\n1. Introduction\n1.1 These Insurance Terms govern your participation in the insurance plan offered through the App. By opting into the insurance plan, you agree to comply with and be legally bound by these Insurance Terms.\n2. Coverage\n2.1 The insurance plan provides coverage for specific incidents that occur during the course of your order delivery, including but not limited to damage, loss, or theft of goods.\n2.2 Detailed information about the coverage, including the limits and exclusions, is provided in the insurance policy document. It is your responsibility to review and understand the policy.\n3. Eligibility\n3.1 To be eligible for the insurance plan, you must:\n   - Be a registered user on the App.\n   - Opt into the insurance plan during the checkout process.\n   - Comply with all applicable Terms and Conditions.\n4. Premiums and Payments\n4.1 Participation in the insurance plan requires the payment of premiums. The premium amount will be specified during the opt-in process.\n4.2 Premiums will be added to your total order amount and charged using your selected payment method.\n5. Claims\n5.1 In the event of an incident, you must notify us and the insurance provider immediately and follow the prescribed claims procedure.\n5.2 You are required to provide accurate and complete information when filing a claim. False or misleading information may result in the denial of your claim and termination of your insurance coverage.\n6. Termination and Cancellation\n6.1 We reserve the right to terminate your participation in the insurance plan at any time for any reason, including but not limited to non-payment of premiums or violation of these Insurance Terms.\n6.2 You may cancel your participation in the insurance plan at any time before your order is out for delivery by providing us with written notice. Cancellation will be effective immediately, and any premiums paid will be refunded.\n7. Limitation of Liability\n7.1 To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your participation in the insurance plan.\n7.2 Our total liability to you for any claims arising from your participation in the insurance plan shall not exceed the amount of premiums you have paid in the six months preceding the event giving rise to the claim.\n8. Changes to Insurance Terms\n8.1 We reserve the right to modify these Insurance Terms at any time. Any changes will be effective immediately upon posting on the App. Your continued participation in the insurance plan after any such changes constitutes your acceptance of the new Insurance Terms.\n9. Governing Law\n9.1 These Insurance Terms are governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.\n10. Contact Us\n10.1 If you have any questions or concerns about these Insurance Terms, please contact us at [Contact Information].\nThank you for participating in our insurance plan!\n---\nMake sure to customize the placeholders (e.g., [App Name], [Company Name], [Date], [Your Country/State], [Contact Information]) with your specific details. Additionally, consider consulting with a legal professional to ensure that your Terms and Conditions comply with applicable laws and regulations.';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFEF2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEF2),
        foregroundColor: const Color(0xFFCD5638),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: const Color(0xFFCD5638).withOpacity(0.4), borderRadius: BorderRadius.circular(15)),
            child: Text(
              teks,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}