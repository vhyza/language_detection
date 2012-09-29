#include <stdio.h>
#include <string.h>
#include "encodings/compact_lang_det/compact_lang_det.h"
#include "encodings/compact_lang_det/ext_lang_enc.h"
#include "encodings/proto/encodings.pb.h"

typedef struct {
  const  char *name;
  const  char *code;
  int    percent;
  double score;
} LanguageDetail;

typedef struct {
  const char *name;
  const char *code;
  bool reliable;
  int  text_bytes;
  LanguageDetail *details;
} DetectedLanguage;

extern "C" {
  DetectedLanguage language_detection(const char * src, bool is_plain_text) {
    bool do_allow_extended_languages = true;
    bool do_pick_summary_language    = false;
    bool do_remove_weak_matches      = false;

    bool is_reliable;

    // "id" boosts Indonesian
    //
    const char* tld_hint = NULL;

    // SJS boosts Japanese
    //
    int encoding_hint = UNKNOWN_ENCODING;

    // ITALIAN boosts it
    //
    Language language_hint = UNKNOWN_LANGUAGE;

    double   normalized_score3[3];
    Language language3[3];
    int      percent3[3];
    int      text_bytes;

    Language lang;
    lang = CompactLangDet::DetectLanguage(0,
                                          src, strlen(src),
                                          is_plain_text,
                                          do_allow_extended_languages,
                                          do_pick_summary_language,
                                          do_remove_weak_matches,
                                          tld_hint,
                                          encoding_hint,
                                          language_hint,
                                          language3,
                                          percent3,
                                          normalized_score3,
                                          &text_bytes,
                                          &is_reliable);


    DetectedLanguage detected_language;
    LanguageDetail * details = new LanguageDetail [3];

    detected_language.name       = LanguageName(lang);
    detected_language.code       = ExtLanguageCode(lang);
    detected_language.reliable   = is_reliable;
    detected_language.text_bytes = text_bytes;

    for(int i = 0; i < 3; i++) {
      Language lang  = language3[i];
      LanguageDetail detail;

      detail.name    = LanguageName(lang);
      detail.code    = ExtLanguageCode(lang);
      detail.percent = percent3[i];
      detail.score   = normalized_score3[i];

      details[i] = detail;
    }

    detected_language.details = details;

    return detected_language;
  }
}