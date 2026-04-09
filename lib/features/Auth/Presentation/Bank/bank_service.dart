class Bank {
  final String name;
  final String code;

  const Bank({required this.name, required this.code});
}

class BankService {
  static const List<Bank> nigerianBanks = [
    Bank(name: 'Access Bank', code: '044'),
    Bank(name: 'Access Bank (Diamond)', code: '063'),
    Bank(name: 'Alat by Wema', code: '035A'),
    Bank(name: 'EcoBank Nigeria', code: '050'),
    Bank(name: 'Fidelity Bank', code: '070'),
    Bank(name: 'First Bank of Nigeria', code: '011'),
    Bank(name: 'First City Monument Bank (FCMB)', code: '214'),
    Bank(name: 'Guaranty Trust Bank (GTB)', code: '058'),
    Bank(name: 'Heritage Bank', code: '030'),
    Bank(name: 'Jaiz Bank', code: '301'),
    Bank(name: 'Keystone Bank', code: '082'),
    Bank(name: 'Kuda Bank', code: '50211'),
    Bank(name: 'Moniepoint MFB', code: '50515'),
    Bank(name: 'Opay (Paycom)', code: '999992'),
    Bank(name: 'Palmpay', code: '999991'),
    Bank(name: 'Polaris Bank', code: '076'),
    Bank(name: 'Providus Bank', code: '101'),
    Bank(name: 'Stanbic IBTC Bank', code: '221'),
    Bank(name: 'Standard Chartered Bank', code: '068'),
    Bank(name: 'Sterling Bank', code: '232'),
    Bank(name: 'Suntrust Bank', code: '100'),
    Bank(name: 'Union Bank of Nigeria', code: '032'),
    Bank(name: 'United Bank for Africa (UBA)', code: '033'),
    Bank(name: 'Unity Bank', code: '215'),
    Bank(name: 'VFD Microfinance Bank', code: '566'),
    Bank(name: 'Wema Bank', code: '035'),
    Bank(name: 'Zenith Bank', code: '057'),
  ];
}
