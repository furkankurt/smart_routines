final smartModelJson = {
  'id': '51550ab6-a1a8-4ade-9679-0026ef1e898a',
  'name': 'Bedroom Light',
  'type': 'device',
  'lastUpdated': '2024-11-17T15:59:06.000',
  'isActive': true,
  'properties': [
    {
      'id': '51550ab6-daa7-4cfe-920e-30e01b1b0f81',
      'modelId': '51550ab6-a1a8-4ade-9679-0026ef1e898a',
      'name': 'power',
      'description': 'Power state of the light',
      'value': false,
      'supportedConditions': ['equals', 'notEquals'],
    },
    {
      'id': '51550ab6-daa7-4cfe-920e-30e01b1b0f82',
      'modelId': '51550ab6-a1a8-4ade-9679-0026ef1e898a',
      'name': 'brightness',
      'description': 'Brightness of the light',
      'value': 50,
      'supportedConditions': ['equals', 'notEquals', 'above', 'below'],
    }
  ],
};

final alarmServiceJson = {
  'id': 'f1b3b3b4-1b1b-4b1b-8b1h-1g1g1g1g1g1g',
  'name': 'Alarm Service',
  'type': 'service',
  'lastUpdated': '2024-11-17T15:59:06.000',
  'isActive': true,
  'properties': [
    {
      'id': 'f1b3b3b4-1b1b-4b1b-8b1b-1d1d1d1d1d1d',
      'modelId': 'f1b3b3b4-1b1b-4b1b-8b1h-1g1g1g1g1g1g',
      'name': 'alarm',
      'description': 'Alarm state',
      'value': false,
      'supportedConditions': ['equals', 'notEquals'],
    }
  ],
};

final routineJson = {
  'id': 'd2mkjd23-a1a8-4ade-9679-23r230f932',
  'name': 'Wake Up',
  'trigger': {
    'modelId': 'f1b3b3b4-1b1b-4b1b-8b1h-1g1g1g1g1g1g',
    'propertyName': 'alarm',
    'condition': 'equals',
    'value': 'true',
  },
  'actions': [
    {
      'modelId': '51550ab6-a1a8-4ade-9679-0026ef1e898a',
      'propertyName': 'power',
      'value': 'true',
    },
    {
      'modelId': '51550ab6-a1a8-4ade-9679-0026ef1e898a',
      'propertyName': 'brightness',
      'value': '100',
    },
    {
      'modelId': 'f1b3b3b4-1b1b-4b1b-8b1h-1g1g1g1g1g1g',
      'propertyName': 'alarm',
      'value': 'true',
    }
  ],
  'isActive': true,
};
