Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3916B4C1
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 00:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgBXXEj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Feb 2020 18:04:39 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:38419 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXEj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Feb 2020 18:04:39 -0500
Received: by mail-lj1-f177.google.com with SMTP id w1so11953674ljh.5
        for <linux-integrity@vger.kernel.org>; Mon, 24 Feb 2020 15:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=from:in-reply-to:references:mime-version:date:message-id:subject:to
         :cc;
        bh=hTIxE+4o+IO8UpbpJysOQStgu79JhOGctvYw0T4sucY=;
        b=XWl1HJbhYuQGYu0GHzDZfkA1tzyBt6T63puivhsbEIjQw8G2NZvGRSEJdwzH7jhEK3
         kwoe0SkYpTxJIMS+XNODRuGzgQ3MEGWCJjMx7P39WJbE23dnf+tvU4Xc9dZrKl7Q7iQK
         qDsaY5KaNrNY5TOz5qIc60ZWUemPTG5hLOLf0lnZIdrdXTh5o8ZmWTbumOl8xUN7xLK7
         iHZIHqGreYleAPb/QumbBdiRxSl1gNAYZKkzL71sFNtU9mnhaqYfpBnve5hHMpPDs5P8
         5KCCQOaxA6OrGYGkyXm3fY5h0VaG4zdjVQaYNTxarOoXIAJCUuxJI8NLOjUTkQRyBFDN
         8pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:in-reply-to:references:mime-version:date
         :message-id:subject:to:cc;
        bh=hTIxE+4o+IO8UpbpJysOQStgu79JhOGctvYw0T4sucY=;
        b=fKQK6n/hFE2JuwP2I91jF+OHICI34+gIcopw8sGfZPVHs/2rbtv6QJY/24XjeVF4Rl
         kLRcLet3UEcPSweje7A0ka4WF2SiMiDoTtKYEMjvQXjOgOtn01s2GR58w8qiMFfihP2o
         JQheEXEfLNRDPeM/BJso+jC8SamKd/7mZ8hNUa0I0E7jZkjLfoF179yv2BNucjSysy2/
         ilgRKKBeNgx01HwGNMO4UZkH0ZccRiRDGLvvz/r1sxNFXVPEezUQIMLax6pZ3N4nA5Ve
         3iuu4jSE1K7gO0yf2n3djmfvEm+mGP4ytPTQkg2E/FFnKmHvO6xgB875CEZZqavosCSx
         Z9aQ==
X-Gm-Message-State: APjAAAWjY4auT/41FY3ZHejWb3rwlDI1OShWisW50fk0+kgm8/YOwPWx
        ksRNSBj19Dlf8fM3cm7ANUekVQxkrzJbAHFKLJXIJQTHusK+RQ==
X-Google-Smtp-Source: APXvYqx2eBe1yEbN4ay3RsAoEgvCa2hHV1LCEFv48874iO0076ZyJwODxidTFAjSBVbh3XTD6pTqE4WV5+7BI2eQLfE=
X-Received: by 2002:a05:651c:8f:: with SMTP id 15mr12748586ljq.109.1582585474638;
 Mon, 24 Feb 2020 15:04:34 -0800 (PST)
Received: from 1055973899907 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Feb 2020 15:04:33 -0800
From:   patrick@puiterwijk.org
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
References: <CAJweMdarWZ7j5XrHbPqcp3ZV-XfzVBfeva5tMiuHMkd4M5HxMg@mail.gmail.com>
MIME-Version: 1.0
Date:   Mon, 24 Feb 2020 15:04:33 -0800
Message-ID: <CAJweMda2DC+L10v5T7G_FCF5LZxwQMp4x4LYdAdi4kTO2bFAiw@mail.gmail.com>
Subject: [PATCH v2] ima-evm-utils: Add support for Intel TSS2 for PCR reading
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, patrick@puiterwijk.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Patrick Uiterwijk <patrick@puiterwijk.org>

This patch makes it possible to use the Intel TSS2 for getting
PCR values from the SHA1/SHA256 banks on a TPM2.
It is somewhat naive as it doesn't use the multi-PCR selection
that TSS2 is capable of, that is for a future patch.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 configure.ac         |   7 ++
 src/Makefile.am      |  12 ++-
 src/evmctl.c         |  85 +--------------------
 src/pcr.h            |   3 +
 src/pcr_none.c       |  52 +++++++++++++
 src/pcr_tss.c        | 178 +++++++++++++++++++++++++++++++++++++++++++
 src/pcr_tsspcrread.c |  94 +++++++++++++++++++++++
 src/utils.c          |  32 ++++++++
 src/utils.h          |   5 ++
 9 files changed, 385 insertions(+), 83 deletions(-)
 create mode 100644 src/pcr.h
 create mode 100644 src/pcr_none.c
 create mode 100644 src/pcr_tss.c
 create mode 100644 src/pcr_tsspcrread.c
 create mode 100644 src/utils.c
 create mode 100644 src/utils.h

diff --git a/configure.ac b/configure.ac
index eedf90e..09b24fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -34,6 +34,11 @@ AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
 if test "x$TSSPCRREAD" = "xyes"; then
 	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread
binary installed])],
 fi
+AM_CONDITIONAL([USE_PCRTSSPCRREAD], [test "x$TSSPCRREAD" = "xyes"])
+
+AC_CHECK_LIB([tss2-esys], [Esys_PCR_Read])
+AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
+AM_CONDITIONAL([USE_PCRTSS], [test
"x$ac_cv_lib_tss2_esys_Esys_PCR_Read" = "xyes"])

 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not
found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not
found. You need the libkeyutils development package.])])
@@ -78,4 +83,6 @@ echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"     tsspcrread: $TSSPCRREAD"
+echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_PCR_Read"
+echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index b794c50..3665242 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -17,11 +17,21 @@ hash_info.h: Makefile

 bin_PROGRAMS = evmctl

-evmctl_SOURCES = evmctl.c
+evmctl_SOURCES = evmctl.c utils.c
 evmctl_CPPFLAGS = $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
 evmctl_LDFLAGS = $(LDFLAGS_READLINE)
 evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la

+if USE_PCRTSS
+evmctl_SOURCES += pcr_tss.c
+else
+if USE_PCRTSSPCRREAD
+evmctl_SOURCES += pcr_tsspcrread.c
+else
+evmctl_SOURCES += pcr_none.c
+endif
+endif
+
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h

 CLEANFILES = hash_info.h
diff --git a/src/evmctl.c b/src/evmctl.c
index 27df8ee..97f9c6e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -64,6 +64,8 @@
 #include <openssl/rsa.h>
 #include <openssl/engine.h>
 #include "hash_info.h"
+#include "pcr.h"
+#include "utils.h"

 #ifndef XATTR_APPAARMOR_SUFFIX
 #define XATTR_APPARMOR_SUFFIX "apparmor"
@@ -230,35 +232,6 @@ static int find_xattr(const char *list, int
list_size, const char *xattr)
 	return 0;
 }

-static int hex_to_bin(char ch)
-{
-	if ((ch >= '0') && (ch <= '9'))
-		return ch - '0';
-	ch = tolower(ch);
-	if ((ch >= 'a') && (ch <= 'f'))
-		return ch - 'a' + 10;
-	return -1;
-}
-
-static int hex2bin(void *dst, const char *src, size_t count)
-{
-	int hi, lo;
-
-	while (count--) {
-		if (*src == ' ')
-			src++;
-
-		hi = hex_to_bin(*src++);
-		lo = hex_to_bin(*src++);
-
-		if ((hi < 0) || (lo < 0))
-			return -1;
-
-		*(uint8_t *)dst++ = (hi << 4) | lo;
-	}
-	return 0;
-}
-
 #define hex_asc_lo(x)   hex_asc[((x) & 0x0f)]
 #define hex_asc_hi(x)   hex_asc[((x) & 0xf0) >> 4]

@@ -1408,58 +1381,6 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }

-#ifdef HAVE_TSSPCRREAD
-static int tpm2_pcrread = 1;
-static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
-			 int len, char **errmsg)
-{
-	FILE *fp;
-	char pcr[100];	/* may contain an error */
-	char cmd[50];
-	int ret;
-
-	sprintf(cmd, "tsspcrread -halg %s -ha %d -ns 2> /dev/null",
-		algo_name, idx);
-	fp = popen(cmd, "r");
-	if (!fp) {
-		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
-		if (ret == -1)	/* the contents of errmsg is undefined */
-			*errmsg = NULL;
-		return -1;
-	}
-
-	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
-		ret = asprintf(errmsg, "tsspcrread failed: %s",
-			       strerror(errno));
-		if (ret == -1)	/* the contents of errmsg is undefined */
-			*errmsg = NULL;
-		ret = pclose(fp);
-		return -1;
-	}
-
-	/* get the popen "cmd" return code */
-	ret = pclose(fp);
-
-	/* Treat an unallocated bank as an error */
-	if (!ret && (strlen(pcr) < SHA_DIGEST_LENGTH))
-		ret = -1;
-
-	if (!ret)
-		hex2bin(hwpcr, pcr, len);
-	else
-		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
-
-	return ret;
-}
-#else
-static int tpm2_pcrread = 0;
-static int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
-			 int len, char **errmsg)
-{
-	return -1;
-}
-#endif
-
 #define TCG_EVENT_NAME_LEN_MAX	255

 struct template_entry {
@@ -1852,7 +1773,7 @@ static int read_tpm_banks(int num_banks, struct
tpm_bank_info *bank)
 		return 0;

 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
-	if (!tpm2_pcrread) {
+	if (!tpm2_pcr_supported()) {
 		log_debug("Failed to read TPM 2.0 PCRs\n");
 		return 1;
 	}
diff --git a/src/pcr.h b/src/pcr.h
new file mode 100644
index 0000000..79547bd
--- /dev/null
+++ b/src/pcr.h
@@ -0,0 +1,3 @@
+int tpm2_pcr_supported(void);
+int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+		 int len, char **errmsg);
diff --git a/src/pcr_none.c b/src/pcr_none.c
new file mode 100644
index 0000000..43d053d
--- /dev/null
+++ b/src/pcr_none.c
@@ -0,0 +1,52 @@
+/*
+ * ima-evm-utils - IMA/EVM support utilities
+ *
+ * Copyright (C) 2011 Nokia Corporation
+ * Copyright (C) 2011,2012,2013 Intel Corporation
+ * Copyright (C) 2013,2014 Samsung Electronics
+ *
+ * Authors:
+ * Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
+ *                 <dmitry.kasatkin@intel.com>
+ *                 <d.kasatkin@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * As a special exception, the copyright holders give permission to link the
+ * code of portions of this program with the OpenSSL library under certain
+ * conditions as described in each individual source file and distribute
+ * linked combinations including the program with the OpenSSL library. You
+ * must comply with the GNU General Public License in all respects
+ * for all of the code used other than as permitted herein. If you modify
+ * file(s) with this exception, you may extend this exception to your
+ * version of the file(s), but you are not obligated to do so. If you do not
+ * wish to do so, delete this exception statement from your version. If you
+ * delete this exception statement from all source files in the program,
+ * then also delete it in the license file.
+ *
+ * File: pcr_none.c
+ *	 PCR reading implementation that always fails
+ */
+
+#include <stdint.h>
+
+int tpm2_pcr_supported(void)
+{
+	return 0;
+}
+
+int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+		 int len, char **errmsg)
+{
+	return -1;
+}
diff --git a/src/pcr_tss.c b/src/pcr_tss.c
new file mode 100644
index 0000000..da7be2e
--- /dev/null
+++ b/src/pcr_tss.c
@@ -0,0 +1,178 @@
+/*
+ * ima-evm-utils - IMA/EVM support utilities
+ *
+ * Copyright (C) 2011 Nokia Corporation
+ * Copyright (C) 2011,2012,2013 Intel Corporation
+ * Copyright (C) 2013,2014 Samsung Electronics
+ *
+ * Authors:
+ * Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
+ *                 <dmitry.kasatkin@intel.com>
+ *                 <d.kasatkin@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * As a special exception, the copyright holders give permission to link the
+ * code of portions of this program with the OpenSSL library under certain
+ * conditions as described in each individual source file and distribute
+ * linked combinations including the program with the OpenSSL library. You
+ * must comply with the GNU General Public License in all respects
+ * for all of the code used other than as permitted herein. If you modify
+ * file(s) with this exception, you may extend this exception to your
+ * version of the file(s), but you are not obligated to do so. If you do not
+ * wish to do so, delete this exception statement from your version. If you
+ * delete this exception statement from all source files in the program,
+ * then also delete it in the license file.
+ *
+ * File: pcr_tss.c
+ *	 PCR reading implementation based on Intel TSS2
+ */
+
+#include <stdio.h>
+#include <string.h>
+
+#include <openssl/sha.h>
+
+#ifdef HAVE_LIBTSS2_ESYS
+#include <tss2/tss2_esys.h>
+
+#ifdef HAVE_LIBTSS2_RC
+#include <tss2/tss2_rc.h>
+#endif
+#endif
+
+int tpm2_pcr_supported(void)
+{
+	return 1;
+}
+
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
+		return asprintf(errmsg, "%s: %s", message, Tss2_RC_Decode(ret));
+#else
+		return asprintf(errmsg, "%s: #%d", message, ret);
+#endif
+}
+
+static TPM2_ALG_ID algo_to_tss2(const char *algo_name)
+{
+	if (!strcmp(algo_name, "sha1"))
+		return TPM2_ALG_SHA1;
+	else if (!strcmp(algo_name, "sha256"))
+		return TPM2_ALG_SHA256;
+
+	return TPM2_ALG_ERROR;
+}
+
+int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+		 int len, char **errmsg)
+{
+	TSS2_ABI_VERSION abi_version = {
+		.tssCreator = 1,
+		.tssFamily = 2,
+		.tssLevel = 1,
+		.tssVersion = 108,
+	};
+	ESYS_CONTEXT *ctx = NULL;
+	TSS2_RC ret = 0;
+	TPML_PCR_SELECTION *pcr_select_out;
+	TPML_DIGEST *pcr_digests;
+	UINT32 pcr_update_counter;
+
+	TPM2_ALG_ID algid = algo_to_tss2(algo_name);
+	if (algid == TPM2_ALG_ERROR) {
+		ret = asprintf(errmsg, "unsupported tss2 algorithm");
+		if (ret == -1)	/* the contents of errmsg are undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+
+	TPML_PCR_SELECTION pcr_select_in = {
+		.count = 1,
+		.pcrSelections = {
+			{
+				.hash = algid,
+				.sizeofSelect = 3,
+				.pcrSelect = { 0x00, 0x00, 0x00 },
+			}
+		}
+	};
+
+	pcr_select_in.pcrSelections[0].pcrSelect[idx / 8] = (1 << (idx % 8));
+
+	ret = Esys_Initialize(&ctx, NULL, &abi_version);
+	if (ret != TPM2_RC_SUCCESS) {
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
+	if (ret != TPM2_RC_SUCCESS) {
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
+	if (pcr_digests->count != 1 || pcr_digests->digests[0].size != len) {
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
+}
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
new file mode 100644
index 0000000..f6c6fc5
--- /dev/null
+++ b/src/pcr_tsspcrread.c
@@ -0,0 +1,94 @@
+/*
+ * ima-evm-utils - IMA/EVM support utilities
+ *
+ * Copyright (C) 2011 Nokia Corporation
+ * Copyright (C) 2011,2012,2013 Intel Corporation
+ * Copyright (C) 2013,2014 Samsung Electronics
+ *
+ * Authors:
+ * Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
+ *                 <dmitry.kasatkin@intel.com>
+ *                 <d.kasatkin@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * As a special exception, the copyright holders give permission to link the
+ * code of portions of this program with the OpenSSL library under certain
+ * conditions as described in each individual source file and distribute
+ * linked combinations including the program with the OpenSSL library. You
+ * must comply with the GNU General Public License in all respects
+ * for all of the code used other than as permitted herein. If you modify
+ * file(s) with this exception, you may extend this exception to your
+ * version of the file(s), but you are not obligated to do so. If you do not
+ * wish to do so, delete this exception statement from your version. If you
+ * delete this exception statement from all source files in the program,
+ * then also delete it in the license file.
+ *
+ * File: pcr_tsspcrread.c
+ *	 PCR reading implementation based on IBM TSS2
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <openssl/sha.h>
+
+#include "utils.h"
+
+int tpm2_pcr_supported(void)
+{
+	return 1;
+}
+
+int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
+		 int len, char **errmsg)
+{
+	FILE *fp;
+	char pcr[100];	/* may contain an error */
+	char cmd[50];
+	int ret;
+
+	sprintf(cmd, "tsspcrread -halg %s -ha %d -ns 2> /dev/null",
+		algo_name, idx);
+	fp = popen(cmd, "r");
+	if (!fp) {
+		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		return -1;
+	}
+
+	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
+		ret = asprintf(errmsg, "tsspcrread failed: %s",
+			       strerror(errno));
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		ret = pclose(fp);
+		return -1;
+	}
+
+	/* get the popen "cmd" return code */
+	ret = pclose(fp);
+
+	/* Treat an unallocated bank as an error */
+	if (!ret && (strlen(pcr) < SHA_DIGEST_LENGTH))
+		ret = -1;
+
+	if (!ret)
+		hex2bin(hwpcr, pcr, len);
+	else
+		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */
+
+	return ret;
+}
diff --git a/src/utils.c b/src/utils.c
new file mode 100644
index 0000000..22702ed
--- /dev/null
+++ b/src/utils.c
@@ -0,0 +1,32 @@
+#include <stdint.h>
+
+#include "utils.h"
+
+int hex_to_bin(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	ch = tolower(ch);
+	if ((ch >= 'a') && (ch <= 'f'))
+		return ch - 'a' + 10;
+	return -1;
+}
+
+int hex2bin(void *dst, const char *src, size_t count)
+{
+	int hi, lo;
+
+	while (count--) {
+		if (*src == ' ')
+			src++;
+
+		hi = hex_to_bin(*src++);
+		lo = hex_to_bin(*src++);
+
+		if ((hi < 0) || (lo < 0))
+			return -1;
+
+		*(uint8_t *)dst++ = (hi << 4) | lo;
+	}
+	return 0;
+}
diff --git a/src/utils.h b/src/utils.h
new file mode 100644
index 0000000..7c0ce15
--- /dev/null
+++ b/src/utils.h
@@ -0,0 +1,5 @@
+#include <ctype.h>
+#include <sys/types.h>
+
+int hex_to_bin(char ch);
+int hex2bin(void *dst, const char *src, size_t count);
-- 
2.24.1
