// Utilities for position-based name numerology (first/last letter logic)

const Map<String,int> kChaldean = {
  'A':1,'B':2,'C':3,'D':4,'E':5,'F':8,'G':3,'H':5,'I':1,'J':1,'K':2,'L':3,'M':4,
  'N':5,'O':7,'P':8,'Q':1,'R':2,'S':3,'T':4,'U':6,'V':6,'W':6,'X':5,'Y':1,'Z':7
};

const Map<String,String> kFirstLetterTraits = {
  'A': 'Pioneer/leader in early life',
  'B': 'Nurturing but cautious early life',
  'C': 'Creative, expressive start',
  'D': 'Determined, may face early struggles (Rahu-like)',
  'E': 'Adaptive and versatile',
  'F': 'Practical with focus on work',
  'G': 'Ambitious and social early life',
  'H': 'Helpful and idealistic',
  'I': 'Independent, intellectual start',
  'J': 'Assertive and creative',
  'K': 'Practical, action-oriented',
  'L': 'Stable, methodical start',
  'M': 'Strong will, possible early challenges',
  'N': 'Nurturing and communicative',
  'O': 'Visionary and philosophical',
  'P': 'Practical leader, steady',
  'Q': 'Quick learner, unusual path',
  'R': 'Responsible but sensitive',
  'S': 'Social and expressive',
  'T': 'Tenacious, structured start',
  'U': 'Freedom-seeking and changeable',
  'V': 'Practical and communicative',
  'W': 'Ambitious and varied',
  'X': 'Transformative energy',
  'Y': 'Intuitive and artistic',
  'Z': 'Strategic and resolute',
};

const Map<String,String> kLastLetterTraits = {
  'A': 'Outgoing, active in later life',
  'B': 'Moon-type ending — flagged in some systems as risky for late-life health',
  'C': 'Creative output manifests later',
  'D': 'Disciplined later life',
  'E': 'Adaptive later life',
  'F': 'Practical and service oriented later',
  'G': 'Respected elder, social influence',
  'H': 'Inner development and idealism',
  'I': 'Independent streak continues',
  'J': 'Leadership may emerge later',
  'K': 'Moon-type ending — caution advised for later-life stability',
  'L': 'Stable and secure later life',
  'M': 'Strong will across life',
  'N': 'Family and legacy focused later',
  'O': 'Spiritual/visionary later life',
  'P': 'Practical influence end',
  'Q': 'Unusual endings—watch for unpredictability',
  'R': 'Moon-type ending — sensitivity and potential health flags in later life',
  'S': 'Continued social expression',
  'T': 'Order and structure in later life',
  'U': 'Change and movement later in life',
  'V': 'Harmony and communication later',
  'W': 'Varied legacy or public work',
  'X': 'Late transformation and change',
  'Y': 'Subtle influence, artistic legacy',
  'Z': 'Strategic influence later',
};

const Set<String> kDangerousEndings = {'B','K','R'};
const Set<String> kRahuStarters = {'D','M','T'}; // per video: D, M, T indicate Rahu-like early struggles

class NamePositionResult {
  final String firstLetter;
  final String lastLetter;
  final String firstTrait;
  final String lastTrait;
  final List<String> flags;

  NamePositionResult({
    required this.firstLetter,
    required this.lastLetter,
    required this.firstTrait,
    required this.lastTrait,
    required this.flags,
  });
}

NamePositionResult analyzeNamePosition(String fullName) {
  final cleaned = fullName.toUpperCase().replaceAll(RegExp(r'[^A-Z]'), '');
  if (cleaned.isEmpty) {
    return NamePositionResult(
      firstLetter: '',
      lastLetter: '',
      firstTrait: '',
      lastTrait: '',
      flags: ['No name provided'],
    );
  }
  final first = cleaned[0];
  final last = cleaned[cleaned.length - 1];
  final flags = <String>[];
  final firstTrait = kFirstLetterTraits[first] ?? '';
  final lastTrait = kLastLetterTraits[last] ?? '';
  if (kDangerousEndings.contains(last)) {
    flags.add('Name ends with $last — flagged as risky per rules (consider alternatives).');
  }
  if (kRahuStarters.contains(first)) {
    flags.add('Name starts with $first — per rules this can indicate struggles/challenges in early life (Rahu-like).');
  }
  return NamePositionResult(
    firstLetter: first,
    lastLetter: last,
    firstTrait: firstTrait,
    lastTrait: lastTrait,
    flags: flags,
  );
}
