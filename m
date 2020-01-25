Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABCF14944C
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Jan 2020 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAYKPV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 25 Jan 2020 05:15:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43418 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgAYKPV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 25 Jan 2020 05:15:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so5362705ljm.10
        for <linux-integrity@vger.kernel.org>; Sat, 25 Jan 2020 02:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=KxFs/yLwqgi2QpMNph/3baUrTj+0XmwZVETW0CSnOBc=;
        b=DMkVn8t3p7WPjjRclhjZktvaCbPMTXVxdqxzccv0oKoAeDs578by/kyQa8334kNFSl
         xSQyZ6fciMq8jxxWhVGOrhQCY/X2f1d/zTwaiTccT16eGjXw9pllLX9fZIpuUux6epCc
         eNT0t+m6eIVIx6PCsp+S4FBHcJlDPiEWBPGPxlP8BalJr1EE/sSXcbP47dVC5KlM7nJh
         +yiPXTCrGgV6f1v8O3Y+pX60BcSTZe+bXUlGmCBZs+03MS5q7/SZUpRs/05PVRLH5DlP
         HHQcjH5LPbFcHgN7tOYuR8k6NFte8lpNc6V6PB+rGvvT8yIkDGolLSHmn+sy6CHKBjpp
         +OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=KxFs/yLwqgi2QpMNph/3baUrTj+0XmwZVETW0CSnOBc=;
        b=DKNpvvvwkQT5uVmLZBv4iWoLWNqmAmE0hbz2/k+5exh+2OSEO9QAWfLEHTQULxziWv
         W7tIQ+aCIW64p6OaFQMIsJKoeo84uGTwhckK2aLJgMEsB+q5N+bU79xzTjNf7kMXyiXz
         t79ETujuDqiGVZIT9piF3uSYSemIJo+2/X5Em+i563/vjnoOOTThoqPmv1LTqQ3V4q5h
         rKZQu2BTMOw5qOEbaArqWTnX8jpKK/4R9sTsqGgyRrHKEW3pZbBVwwoW1uppghznzOxm
         +j7s/SGz8KR1ddJwQHwNNtrzI9X0FGM0pCDa0YTHWb9GZL+jRH0kGosTMI0wE1ICMqq8
         YFBA==
X-Gm-Message-State: APjAAAVRGZNJEsKQlQK5ug0G8KYE1zB5dQmJCCZXwsIYoDX84Xj7j1rB
        PY+Op5Ftdy90a9qGGDnIiv+fJW+NRDLUkKEYvdJrHYxQ52U=
X-Google-Smtp-Source: APXvYqziIHWUZTafMlCZiqbrlUN/HQmThdh3xmnKOF52uXlPuhI/lHwTymbRaG8HrWuFgtxRmG82hJej3bzt+uOAZ1U=
X-Received: by 2002:a2e:93c9:: with SMTP id p9mr4676702ljh.136.1579947318380;
 Sat, 25 Jan 2020 02:15:18 -0800 (PST)
Received: from 1055973899907 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 25 Jan 2020 02:15:17 -0800
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Date:   Sat, 25 Jan 2020 02:15:17 -0800
Message-ID: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
Subject: [PATCH] Add support for TSS2 for PCR reading
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 configure.ac |   5 +++
 src/evmctl.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index eedf90e..58a7fee 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,9 @@ if test "x$TSSPCRREAD" = "xyes"; then
 	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread
binary installed])],
 fi

+AC_CHECK_LIB([tss2-esys], [Esys_PCR_Read])
+AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
+
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not
found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not
found. You need the libkeyutils development package.])])

@@ -78,4 +81,6 @@ echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"     tsspcrread: $TSSPCRREAD"
+echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_PCR_Read"
+echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo
diff --git a/src/evmctl.c b/src/evmctl.c
index b02be8b..5bc6773 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -69,6 +69,15 @@
 #define XATTR_NAME_APPARMOR XATTR_SECURITY_PREFIX XATTR_APPARMOR_SUFFIX
 #endif

+#ifdef HAVE_LIBTSS2_ESYS
+#include <tss2/tss2_esys.h>
+
+#ifdef HAVE_LIBTSS2_RC
+#include <tss2/tss2_rc.h>
+#endif
+#endif
+
+
 #define USE_FPRINTF

 #include "imaevm.h"
@@ -1407,9 +1416,110 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }

-#ifdef HAVE_TSSPCRREAD
+#ifdef HAVE_LIBTSS2_ESYS
+static int pcr_selections_match(TPML_PCR_SELECTION *a, TPML_PCR_SELECTION *b)
+{
+	if (a->count != b->count)
+		return 0;
+	for (int i = 0; i < a->count; i++) {
+		if (a->pcrSelections[i].hash != b->pcrSelections[i].hash)
+			return 0;
+		if (a->pcrSelections[i].sizeofSelect != b->pcrSelections[i].sizeofSelect)
+			return 0;
+		for (int j = 0; j < a->pcrSelections[i].sizeofSelect; j++) {
+			if (a->pcrSelections[i].pcrSelect[j] != b->pcrSelections[i].pcrSelect[j])
+				return 0;
+		}
+	}
+
+	return 1;
+}
+
+static inline int tpm2_set_errmsg(char **errmsg, const char *message,
TSS2_RC ret)
+{
+#ifdef HAVE_LIBTSS2_RC
+		ret = asprintf(errmsg, "%s: %s", message, Tss2_RC_Decode(ret));
+#else
+		ret = asprintf(errmsg, "%s: #%d", message, ret);
+#endif
+}
+#endif
+
 static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
 {
+#if defined(HAVE_LIBTSS2_ESYS)
+	TSS2_ABI_VERSION abi_version = {
+		.tssCreator = 1,
+		.tssFamily = 2,
+		.tssLevel = 1,
+		.tssVersion = 108,
+	};
+	ESYS_CONTEXT *ctx = NULL;
+	TSS2_RC ret = 0;
+	TPML_PCR_SELECTION pcr_select_in = {
+		.count = 1,
+		.pcrSelections = {
+			{
+				.hash = TPM2_ALG_SHA1,
+				.sizeofSelect = 3,
+				.pcrSelect = { 0x00, 0x00, 0x00 },
+			}
+		}
+	};
+	TPML_PCR_SELECTION *pcr_select_out;
+	TPML_DIGEST *pcr_digests;
+	UINT32 pcr_update_counter;
+
+	pcr_select_in.pcrSelections[0].pcrSelect[idx / 8] = (1 << (idx % 8));
+
+	ret = Esys_Initialize(&ctx, NULL, &abi_version);
+	if (ret != 0) {
+		ret = tpm2_set_errmsg(errmsg, "esys initialize failed", ret);
+		if (ret == -1)	/* the contents of errmsg are undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+
+	ret = Esys_PCR_Read(ctx,
+			    ESYS_TR_NONE,
+			    ESYS_TR_NONE,
+			    ESYS_TR_NONE,
+			    &pcr_select_in,
+			    &pcr_update_counter,
+			    &pcr_select_out,
+			    &pcr_digests);
+	Esys_Finalize(&ctx);
+	if (ret != 0) {
+		ret = tpm2_set_errmsg(errmsg, "esys PCR reading failed", ret);
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+
+	if (!pcr_selections_match(&pcr_select_in, pcr_select_out)) {
+		Esys_Free(pcr_select_out);
+		Esys_Free(pcr_digests);
+
+		ret = asprintf(errmsg, "TPM returned incorrect PCRs");
+		if (ret == -1)	/* the contents of errmsg are undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+	Esys_Free(pcr_select_out);
+
+	if (pcr_digests->count != 1 || pcr_digests->digests[0].size !=
SHA_DIGEST_LENGTH) {
+		Esys_Free(pcr_digests);
+		ret = asprintf(errmsg, "TPM returned incorrect digests");
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+
+	memcpy(hwpcr, pcr_digests->digests[0].buffer, len);
+	Esys_Free(pcr_digests);
+	return 0;
+
+#elif defined(HAVE_TSSPCRREAD)
 	FILE *fp;
 	char pcr[100];	/* may contain an error */
 	char cmd[50];
@@ -1441,8 +1551,8 @@ static int tpm2_pcr_read(int idx, uint8_t
*hwpcr, int len, char **errmsg)
 		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */

 	return ret;
-}
 #endif
+}

 #define TCG_EVENT_NAME_LEN_MAX	255

@@ -1701,7 +1811,7 @@ static int ima_measurement(const char *file)
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);

 		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
-#ifdef HAVE_TSSPCRREAD
+#if defined(HAVE_TSSPCRREAD) || defined(HAVE_LIBTSS2_ESYS)
 			char *errmsg = NULL;

 			err = tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);
-- 
2.24.1
