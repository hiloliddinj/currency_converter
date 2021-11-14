import 'dart:ui';

const Color mainColor = Color(0xFF212936);
const Color secondColor = Color(0xFF2849E5);
const String myApiKey = "4501f560-424b-11ec-96dd-23862cb51fef";
List<String> currencyList = [
  //https://free.currconv.com/api/v7/currencies?apiKey=do-not-use-this-api-key-IIm7WFMYA5aKg87Px29QO
  "ALL",
  "XCD",
  "EUR",
  "BBD",
  "BTN",
  "BND",
  "XAF",
  "CUP",
  "USD",
  "FKP",
  "GIP",
  "HUF",
  "IRR",
  "JMD",
  "AUD",
  "LAK",
  "LYD",
  "MKD",
  "XOF",
  "NZD",
  "OMR",
  "PGK",
  "RWF",
  "WST",
  "RSD",
  "SEK",
  "TZS",
  "AMD",
  "BSD",
  "BAM",
  "CVE",
  "CNY",
  "CRC",
  "CZK",
  "ERN",
  "GEL",
  "HTG",
  "INR",
  "JOD",
  "KRW",
  "LBP",
  "MWK",
  "MRO",
  "MZN",
  "ANG",
  "PEN",
  "QAR",
  "STD",
  "SLL",
  "SOS",
  "SDG",
  "SYP",
  "AOA",
  "AWG",
  "BHD",
  "BZD",
  "BWP",
  "BIF",
  "KYD",
  "COP",
  "DKK",
  "GTQ",
  "HNL",
  "IDR",
  "ILS",
  "KZT",
  "KWD",
  "LSL",
  "MYR",
  "MUR",
  "MNT",
  "MMK",
  "NGN",
  "PAB",
  "PHP",
  "RON",
  "SAR",
  "SGD",
  "ZAR",
  "SRD",
  "TWD",
  "TOP",
  "VEF",
  "DZD",
  "ARS",
  "AZN",
  "BYR",
  "BOB",
  "BGN",
  "CAD",
  "CLP",
  "CDF",
  "DOP",
  "FJD",
  "GMD",
  "GYD",
  "ISK",
  "IQD",
  "JPY",
  "KPW",
  "LVL",
  "CHF",
  "MGA",
  "MDL",
  "MAD",
  "NPR",
  "NIO",
  "PKR",
  "PYG",
  "SHP",
  "SCR",
  "SBD",
  "LKR",
  "THB",
  "TRY",
  "AED",
  "VUV",
  "YER",
  "AFN",
  "BDT",
  "BRL",
  "KHR",
  "KMF",
  "HRK",
  "DJF",
  "EGP",
  "ETB",
  "XPF",
  "GHS",
  "GNF",
  "HKD",
  "XDR",
  "KES",
  "KGS",
  "LRD",
  "MOP",
  "MVR",
  "MXN",
  "NAD",
  "NOK",
  "PLN",
  "RUB",
  "SZL",
  "TJS",
  "TTD",
  "UGX",
  "UYU",
  "VND",
  "TND",
  "UAH",
  "UZS",
  "TMT",
  "GBP",
  "ZMW",
  "BTC",
  "BYN",
  "BMD",
  "GGP",
  "CLF",
  "CUC",
  "IMP",
  "JEP",
  "SVC",
  "ZMK",
  "XAG",
  "ZWL",
];

List<String> filteredCurrencyList = [
  //https://free.currconv.com/api/v7/currencies?apiKey=do-not-use-this-api-key-IIm7WFMYA5aKg87Px29QO
  "ALL",
  "XCD",
  "BBD",
  "BTN",
  "BND",
  "XAF",
  "CUP",
  "FKP",
  "GIP",
  "HUF",
  "IRR",
  "JMD",
  "AUD",
  "LAK",
  "LYD",
  "MKD",
  "XOF",
  "NZD",
  "OMR",
  "PGK",
  "RWF",
  "WST",
  "RSD",
  "SEK",
  "TZS",
  "AMD",
  "BSD",
  "BAM",
  "CVE",
  "CNY",
  "CRC",
  "CZK",
  "ERN",
  "GEL",
  "HTG",
  "INR",
  "JOD",
  "KRW",
  "LBP",
  "MWK",
  "MRO",
  "MZN",
  "ANG",
  "PEN",
  "QAR",
  "STD",
  "SLL",
  "SOS",
  "SDG",
  "SYP",
  "AOA",
  "AWG",
  "BHD",
  "BZD",
  "BWP",
  "BIF",
  "KYD",
  "COP",
  "DKK",
  "GTQ",
  "HNL",
  "IDR",
  "ILS",
  "KZT",
  "KWD",
  "LSL",
  "MYR",
  "MUR",
  "MNT",
  "MMK",
  "NGN",
  "PAB",
  "PHP",
  "RON",
  "SAR",
  "SGD",
  "ZAR",
  "SRD",
  "TWD",
  "TOP",
  "VEF",
  "DZD",
  "ARS",
  "AZN",
  "BYR",
  "BOB",
  "BGN",
  "CAD",
  "CLP",
  "CDF",
  "DOP",
  "FJD",
  "GMD",
  "GYD",
  "ISK",
  "IQD",
  "JPY",
  "KPW",
  "LVL",
  "CHF",
  "MGA",
  "MDL",
  "MAD",
  "NPR",
  "NIO",
  "PKR",
  "PYG",
  "SHP",
  "SCR",
  "SBD",
  "LKR",
  "THB",
  "TRY",
  "AED",
  "VUV",
  "YER",
  "AFN",
  "BDT",
  "BRL",
  "KHR",
  "KMF",
  "HRK",
  "DJF",
  "EGP",
  "ETB",
  "XPF",
  "GHS",
  "GNF",
  "HKD",
  "XDR",
  "KES",
  "KGS",
  "LRD",
  "MOP",
  "MVR",
  "MXN",
  "NAD",
  "NOK",
  "PLN",
  "SZL",
  "TJS",
  "TTD",
  "UGX",
  "UYU",
  "VND",
  "TND",
  "UAH",
  "UZS",
  "TMT",
  "GBP",
  "ZMW",
  "BTC",
  "BYN",
  "BMD",
  "GGP",
  "CLF",
  "CUC",
  "IMP",
  "JEP",
  "SVC",
  "ZMK",
  "XAG",
  "ZWL",
];