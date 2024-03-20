String stocksApiKey = "pk_2c2662f7485242d69839aab2c92477e0";
String newsApiKey = "93e2b2db82984a4aa1e9e2810ead28fb";

Map<String, double> currencyValues = {
  "eur": 1.0864779039645,
  "gbp": 1.2722648789795,
  "jpy": 0.0067657404777473,
  "aud": 0.65873181501136,
  "chf": 1.1570895970271,
  "cad": 0.7428184559902,
  "htg": 0.0076034985422744,
  "hkd": 0.12796076287582,
  "sar": 0.26710202295988,
  "kgs": 0.011290830600485,
  "mad": 0.10186839451472,
  "uyu": 0.025634110787173,
  "nok": 0.095946586270565,
  "inr": 0.012029826306857,
  "rub": 0.011137803076882,
  "uzs": 8.1191389345466e-5,
  "ves": 0.027719855346771,
  "myr": 0.2126981224272,
  "pkr": 0.0035692355335174,
  "tjs": 0.091818395970474,
  "czk": 0.04390839275781,
  "sgd": 0.74601287101065,
  "mdl": 0.056439401782752,
  "ars": 0.0012142857142858,
  "brl": 0.20419056217216,
  "ron": 0.21838900389853,
  "xaf": 0.0016608029094794,
  "dzd": 0.0074901661892812,
  "crc": 0.0019463507769927,
  "dkk": 0.14580312604973,
  "cny": 0.13944328470664,
  "vnd": 4.0890359931017e-5,
  "iqd": 0.00076781777131953,
  "lyd": 0.21106849721157,
  "pyg": 0.00013702623906706,
  "ils": 0.27110715981869,
  "pen": 0.26399698823859,
  "tnd": 0.3264418861142,
  "mxn": 0.058274503849099,
  "byn": 0.30556861240347,
  "rsd": 0.009448081558722,
  "bgn": 0.55568703590791,
  "php": 0.017749907086305,
  "kzt": 0.0022212428965805,
  "jod": 1.4097653088752,
  "pln": 0.24825658483659,
  "zar": 0.053217055469115,
  "azn": 0.58858265111392,
  "cop": 0.00025510204081633,
  "try": 0.03300146128925,
  "twd": 0.032137163693701,
  "irr": 2.3948746860202e-5,
  "pab": 1,
  "idr": 6.3297187942814e-5,
  "ngn": 0.0011275377068341,
  "lbp": 6.7109760057039e-5,
  "aed": 0.27340431763316,
  "bob": 0.14577259475219,
  "sek": 0.095943318508991,
  "krw": 0.00074874733437124,
  "bdt": 0.0091388349825602,
  "tmt": 0.28738443295722,
  "dop": 0.017264761785449,
  "nzd": 0.61046733274666,
  "uah": 0.026462909946467,
  "gel": 0.37426914515459,
  "huf": 0.0028092879704651,
  "thb": 0.028238409150915,
  "egp": 0.032368971368879,
  "clp": 0.0010908419233548,
  "isk": 0.0073296620637611,
  "xof": 0.0016608029094794,
  "amd": 0.0024848667720103
};

List<List< double>> stocks = [
  [131.78, 136.47, 134.31, 135.01, 134.83, 132.16, 133.04, 132.36, 135.02, 133.51,
    134.3, 133.82, 134.94, 132.44, 132.52, 129.8, 128.95, 125.83, 126.5, 123.87,
    123.66, 121.65, 120.11, 121.65, 120.35, 119.54, 122.82, 123.33, 120.33, 119.9,
    122.88, 124.05, 125.7, 121.41, 120.4, 122.54, 121.69, 119.03, 120.93, 120.98,
    121.75, 124.81, 128.41, 123.75, 122.59, 124.68, 124.94, 123.76, 128.01, 130.24,
    129.2, 131.25, 135.49, 134.35, 135.9, 136.48, 136.62, 136.03, 137.35, 136.3,
    135.76, 135.73, 133.75, 135.83, 139.52, 143.43, 143.6, 143.07, 136.28, 133.8,
    128.66, 127.78, 128.78, 130.8, 128.76, 128.5, 129.19, 132.43, 128.36, 127.72,
    128.89, 133.52, 134.08, 135.58, 138.05, 133.99, 131.32, 132.16, 131.61, 125.02,
    128.96, 128.9, 127.41, 124.34, 122.6, 122.43, 120.5, 124.53, 124.37, 122.31,
    122.6, 123.52, 122.02, 121.01, 116.97, 116.57, 115.55, 113.91, 117.18, 118.64,
    117.59, 118.61, 119.55, 118.92, 119.44, 119.62, 117.19, 115.55, 120.5, 118.32,
    117.95, 114.14, 109.66, 109.11, 111.06, 112.37, 115.05, 115.49, 114.01, 116.39,
    117.45, 116.67, 116.2, 119.96, 121.28, 118.72, 121, 125.27, 120.06, 115.28,
    116.25, 114.62, 115.7, 113.91, 112.89, 117.64, 113.79, 114.55, 115.01, 108.43,
    105.17, 111.62, 112.68, 104.54, 110.4, 109.72, 115.23, 118.33, 114.72, 114.57,
    120.36, 117.26, 113.95, 120.07, 126.91, 137.59],
  [235.06, 235.99, 235.61, 238, 231.86, 229.12, 227.08, 224.7, 217.7, 213.75, 213.52, 215.91, 214.02, 216.5,
    218.47, 218.68, 214.04, 212.17, 217.26, 222.53, 221.7, 225.23, 226.31, 224.45, 221.42, 223.11, 222.69, 217.55, 218.59,
    219.87, 214.75, 215.165, 213.1, 210.05, 211.77, 215.16, 213.97, 214.37, 214.22, 214.61, 214.88, 214.51, 214.1, 214.85,
    215.11, 209.59, 210.95, 212.2, 211.38, 213.65, 216.1, 214.87, 216.36, 217.21, 212.39, 214.5, 224.435, 222.26, 222.04,
    214.02, 203.89, 204.29, 203.5, 204.07, 207.67, 211.59, 213.85, 215.03, 213.93, 213.12, 215.8, 220.415, 220.15, 217.1,
    223, 222.72, 218.79, 211.23, 210.51, 207.06, 208.82, 207.22, 208, 213.49, 207.73, 209.35, 210.88, 203.55, 199.85, 207.9,
    205.06, 197.19, 202.8, 200.05, 210.62, 208.42, 204.24, 207.2, 213.4, 207.6, 206.5, 215.1, 229.27, 227.97, 225.51, 227,
    228.18, 222.89, 217.88, 213.1, 214.79, 213.86, 209.54, 211.49, 210.53, 209.6, 208.76, 209.44, 205.29, 207.155, 211.67,
    214.85, 212.34, 214.9, 214.17, 211.52, 204.4, 201, 202.5, 203.61, 201.47, 200.42, 207.19, 209.2, 213.66, 205, 204.47, 205.4,
    209.56, 206.13, 214.48, 213.62, 216.33, 210.07, 210.45, 208.834],
  [117.85, 117.82, 121.23, 121.16, 126.61, 126.67, 124.39,
    128.5, 128.88, 128.62, 129.61, 133.57, 134.28, 132.25, 129.06, 130.34, 132.18,
    126.38, 119.72, 121.78, 119.65, 118.41, 118.78, 118.97, 119.01, 118.09, 118.44,
    116.08, 120.29, 120.77, 122.43, 121.3, 122.65, 121.35, 119.6, 122.25, 119.7,
    121.05, 120.27, 119.44, 120.3, 120.15, 120.61, 121.75, 121.99, 120.1, 119.5,
    117.97, 118.25, 121.38, 119.32, 120.98, 116.13, 116.43, 119.21, 117.98, 118.95,
    113.39, 109.56, 110.05, 112.59, 110.43, 108.2, 105.42, 106.26, 107.23, 110.03,
    112.59, 108, 112.27, 113.53, 113.43, 113.29, 110.71, 112.58, 111.43, 112.13,
    113.05, 110, 108.3, 109.08, 107.12, 102.88, 102.51, 102.06, 103.83, 104.76,
    101.01, 100.58, 100.57, 101.35, 104.35, 108.14, 105.39, 106.63, 106.82, 105.78,
    104.34, 106.46, 104.5, 106.32, 108.74, 108.64, 106.75, 105.06, 106.73, 105.91,
    105.9, 104.59, 105.66, 104.53, 104.37, 103.48, 105.71, 106.98, 106.52, 105.17,
    106.15, 108.14, 107.74, 104.78, 101.61, 102.31, 103.86, 103.34, 99.22, 99.53,
    100.04, 100.99, 102.56, 102.34, 100.75, 101.51, 94.59, 94.22, 94, 94.75, 94.6,
    95.65, 90.73, 94.01, 89.89, 92.86, 94.32, 93.8, 96.32, 95.04, 95.53, 92.39,
    91.54, 91.82, 91.11, 94.09, 97.79, 95.74, 96.31, 94.85, 96.74, 97.85, 89.86,
    94.32, 98.23, 101.07, 100.22, 103.11, 103.77, 99.58, 99.75, 99.29, 97.33,
    96.94, 99.31, 95.93, 95, 91.32, 91.21, 91.87, 92.87, 91.31, 85.16, 81.4,
    84.13, 91.58, 90.41, 90.66, 88.42, 87.75, 88.91, 87.04],
  [75.81, 71.38, 69.29, 70.72, 73.11, 74.68, 72.08, 74.67,
    74.79, 76.12, 75.56, 75.64, 74.28, 74.28, 72.5, 72.51, 70.85, 71.49, 70.96,
    72.29, 72.44, 71.28, 71.07, 70.26, 70.03, 68.87, 68.59, 67.89, 69.0, 70.25,
    68.82, 67.46, 66.77, 67.18, 66.57, 68.79, 67.25, 67.09, 68.85, 68.5, 69.33,
    69.82, 67.67, 69.38, 67.92, 68.72, 67.17, 67.21, 66.69, 69.29, 68.95, 69.05,
    66.99, 66.03, 66.76, 66.66, 66.89, 63.1, 61.4, 60.58, 60.04, 57.97, 57.65,
    57.67, 58.85, 60.23, 59.48, 59.66, 59.34, 59.12, 58.3, 56.75, 56.67, 54.47,
    56.1, 54.73, 55.0, 56.31, 54.89, 54.05, 53.75, 52.24, 51.44, 51.05, 49.59,
    48.78, 48.9, 47.94, 47.02, 48.47, 47.69, 48.26, 48.92, 49.85, 49.75, 49.57,
    48.7, 49.29, 49.68, 49.73, 49.56, 50.89, 51.36, 51.19, 50.75, 49.98, 50.21,
    49.29, 50.19, 50.01, 49.97, 48.3, 46.78, 47.1, 47.0, 46.2, 46.18, 46.65,
    47.71, 47.3, 47.1, 46.48, 46.57, 46.45, 47.25, 45.71, 46.8, 47.07, 47.76,
    48.04, 48.46, 49.89, 50.09, 50.61, 51.47, 49.16, 47.61, 46.52, 46.7, 45.83,
    47.54, 47.63, 48.63, 48.19, 49.0, 49.06, 48.48, 46.19, 45.53, 45.66, 45.35,
    43.59, 44.8, 45.51, 44.59, 44.63, 43.51, 42.83, 43.0, 41.22, 42.7, 41.94,
    44.2, 44.66, 46.81, 47.64, 45.72, 45.49, 43.62, 42.46, 40.79, 42.01, 39.76,
    37.89, 36.42, 37.58, 36.73, 36.75, 36.71, 37.08, 37.36, 40.62, 39.59, 40.18,
    41.42, 40.76, 41.57, 40.65, 40.52, 42.25],
  [40.3181, 40.4976, 40.9962, 40.8666, 42.9508, 42.0134,
    41.9436, 45.2843, 46.2417, 45.0251, 47.1492, 47.2888, 47.219, 45.8927, 43.978,
    44.8755, 43.9281, 42.4123, 40.1287, 40.3879, 39.7996, 38.8821, 39.2511,
    39.4505, 39.8993, 39.301, 40.0888, 39.301, 41.8738, 42.6517, 42.7314, 42.542,
    43.958, 43.3896, 42.4921, 43.1602, 41.8838, 43.23, 42.173, 39.9392, 39.0716,
    40.7868, 41.814, 43.2799, 43.8783, 43.958, 40.2483, 39.2012, 38.6029, 38.8522,
    37.4162, 36.8478, 34.255, 34.5043, 35.8605, 34.255, 33.0682, 30.0466, 30.0167,
    29.5081, 30.635, 29.3386, 28.85, 28.0422, 29.2788, 30.0765, 31.6721, 32.1807,
    30.5353, 32.081, 32.8189, 34.0256, 34.7137, 33.7763, 33.9458, 35.4317, 34.973,
    35.8406, 34.4045, 33.3774, 34.7835, 33.4671, 31.4926, 32.1408, 32.6394,
    33.6267, 34.245, 32.9984, 32.7192, 34.2649, 34.245, 34.7137, 35.7009, 34.3048,
    34.0256, 33.6367, 33.148, 32.789, 34.3347, 34.7536, 35.2023, 36.2594, 35.9303,
    36.8976, 37.3165, 38.2439, 38.2239, 37.6655, 38.7226, 39.301, 38.2339, 38.5331,
    38.9519, 39.999, 40.5076, 40.6372, 40.1087, 41.0361, 40.2583, 40.4577, 38.4034,
    37.7652, 37.5358, 38.3935, 36.5586, 37.1669, 36.9475, 38.0145, 38.8622,
    39.4605, 39.8095, 40.6273, 40.4179, 40.9564, 39.989, 39.8494, 41.2356, 41.1757,
    42.0733, 39.3309, 40.019, 38.2539, 40.5475, 40.4677, 41.0361, 42.512, 41.7043,
    42.2328, 40.7569, 40.2882, 41.455, 40.5475, 42.881, 43.9979, 43.1204, 45.773,
    43.4096, 44.8655, 45.1747, 40.9564, 45.1846, 41.9636, 47.9071, 48.1165, 50.0711,
    47.2589, 44.5564, 44.9852, 43.8982, 42.1431, 42.4921, 44.5963, 44.2173, 44.686,
    42.7913, 44.2672, 43.4694, 43.5791, 43.3298, 39.7597, 38.8223, 40.9065, 42.5021,
    42.1131, 43.0007, 41.8838, 40.9763, 42.9807, 38.5131, 40.4278],
];
List<String> headlines = [
  "Global Supply Chain Chaos Sparks Market Uncertainty",
  "Consumer Spending Plummets, Impacting Retail and Services",
  "Tech Sector Faces Strain Amid Economic Turbulence",
  "Financial Institutions Struggle with Mounting Pressures",
  "Real Estate Markets Hit Hard as Property Values Decline",
  "Small Businesses Grapple with Economic Contraction",
  "Investor Confidence Wavers in Unpredictable Markets",
  "Commodities Market Volatility Rattles Global Economies",
  "Global Health Crisis Sends Shock Waves Through Pharma Industry",
   "Automotive Sector Slumps as Demand Takes a Hit",
   "Tourism and Hospitality Face Unprecedented Challenges",
   "Entertainment Industry Hit as Events and Productions Stall",
   "Agricultural Sector Adapts to Supply Chain Disruptions",
   "E-commerce Struggles with Increased Competition and Demand Shifts",
   "Metals and Mining Industry Grapples with Price Fluctuations",
   "Innovation Spurs Economic Revival in Key Industries",
   "Companies Chart Path to Growth in Post-Crisis Landscape",
   "Entrepreneurial Spirit Fuels New Ventures Amid Market Adjustments",
   "Sustainable Practices Gain Traction in Economic Renewal",
   "Remote Work Transforms Business Operations for the Long Term",
   "Technology Investments Propel Economic Renaissance",
   "Community Resilience Spurs Local Economic Revival",
   "Economic Resurgence: Industries Adapt for Post-Challenges Success",
   "Global Collaboration Drives Sustainable Economic Growth",
   "Inclusive Growth Strategies Propel Positive Transformations",
   "Financial Institutions Implement Robust Risk Management Strategies",
   "Renewable Energy Investments Blossom in Economic Reset",
   "Automotive Industry Innovates to Meet Evolving Consumer Needs",
   "Tourism and Hospitality Industry Reimagines Customer Experiences",
   "Agricultural Sector Adopts Technology for Sustainable Practices"
];