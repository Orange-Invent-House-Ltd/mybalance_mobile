enum MeansOfId {
  internationalPassport('International Passport'),
  nin('NIN'),
  votersCard('Voter\'s Card'),
  driversLicense('Driver’s License');

  const MeansOfId(this.label);

  final String label;
}
