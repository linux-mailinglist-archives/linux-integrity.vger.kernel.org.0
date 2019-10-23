Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD26FE1C66
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 15:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405809AbfJWNXa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 09:23:30 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38853 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405807AbfJWNXa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 09:23:30 -0400
Received: by mail-yb1-f193.google.com with SMTP id r68so6293719ybf.5
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puiterwijk.org; s=google;
        h=from:mime-version:date:message-id:subject:to:cc;
        bh=uPeMaZOkGHrflBRJTqdhDF+ATp6kVRTq7v4zsJZwR9c=;
        b=GOtBMYMTdzFWvQWweGnPNTL6nAEzPuMRZ7AprVDWKZzeZBOTpjsO0yn7LnU42uq9zl
         735BiYNdQSiG+lX1U/Da0QuwuEHlf2f1rNxUzU3SnLwukV5q5CJOZzcwpOvaqpLpoMhk
         KdwTmpHt4Xavf05ckSo00nYC4gdft7Tvhc39JTzbKAf/yJVVEbiYz+7WGBGT/qp0YZbK
         ZUHMr1Zt4/OJAEsliWFWu9sLkHhjdxELdvmD/EjNY2vDoc2+zCv3HhvzJ88adZyJCtwj
         nJP/TRNI2uHxmgDig9AOYGyA4aDOVxTTC4w65JTK485IYoFPGIXdtyrkA//szVK28FqA
         q+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:date:message-id:subject:to:cc;
        bh=uPeMaZOkGHrflBRJTqdhDF+ATp6kVRTq7v4zsJZwR9c=;
        b=rrGvMG0tap5Qmc+kZjO+Zk3+8o76F8pLnWSE2EE3Ue+6394QlbTwB0RE9ecJmk9+J4
         qw7QkXU5FGnrmYTUb7dL55okhFK5pUfYJ3bHr6K9FwQLydRe2MTgPTx5Mr+3Ru50jLXd
         4wTMaVZvSYpy/026bQjk5cUEC6XmnBWjeYOTmUC78pRMWSLU4TE/rfUWiX+rVmqUb4uN
         ujnhtY0KoQ56Hxb3DqVqcNWKp59/fCMKK72HRsR7+HklrodmOt6wQYWE38doktiLJnh7
         WQmn37AR235XvabU0ssfO9FJrJTQjFbMJDWwyY1vT/QuE+//AUJ+bJzTILnxmcBv00De
         4Vjg==
X-Gm-Message-State: APjAAAX4xWvHeXizIctLdFqFLJNnlFKaL+HA3AArEZuSXMsY9rQDZLhJ
        ewDxHaMae0M3TGayR7vbRB8HMSQLI+9NfGhw0Itdk5Jl3UKcyw==
X-Google-Smtp-Source: APXvYqytVLGyhTocA90VkB+2BUT3su+WEoGoqH9AFTIPYEzkj/N3xvtYq04aLqCATUS5XF6xS4GVy2I3AzPTRVqeOXE=
X-Received: by 2002:a25:bd89:: with SMTP id f9mr5558896ybh.46.1571837008230;
 Wed, 23 Oct 2019 06:23:28 -0700 (PDT)
Received: from 1055973899907 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 23 Oct 2019 06:23:27 -0700
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Date:   Wed, 23 Oct 2019 06:23:27 -0700
Message-ID: <CAJweMdZSL_Qe+gOxBTROZ3s2doTfSB+JtorsGteWMbhWZ=rRrQ@mail.gmail.com>
Subject: [PATCH] ima-evm-utils: add support for tpm2-tools to read the TPM 2.0 PCRs
To:     linux-integrity@vger.kernel.org
Cc:     Patrick Uiterwijk <patrick@puiterwijk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds support for reading TPM 2.0 PCRs using the tpm2-tools TSS.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 configure.ac |  6 ++++++
 src/evmctl.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7747481..adcc6ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,11 @@ if test "x$TSSPCRREAD" = "xyes"; then
 	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread
binary installed])
 fi

+AC_CHECK_PROG(TPM2PCRLIST, [tpm2_pcrlist], yes, no)
+if test "x$TPM2PCRLIST" = "xyes"; then
+	AC_DEFINE(HAVE_TPM2PCRLIST, 1, [Define to 1 if you have the
tpm2_pcrlist binary installed])
+fi
+
 AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not
found. You need the c-library development package.])])
 AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not
found. You need the libkeyutils development package.])])

@@ -78,4 +83,5 @@ echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
 echo	"     tsspcrread: $TSSPCRREAD"
+echo	"   tpm2_pcrlist: $TPM2PCRLIST"
 echo
diff --git a/src/evmctl.c b/src/evmctl.c
index be59ead..393a20d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1421,15 +1421,20 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int len)
 	return result;
 }

-#ifdef HAVE_TSSPCRREAD
+#if defined(HAVE_TSSPCRREAD) || defined(HAVE_TPM2PCRLIST)
 static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
 {
 	FILE *fp;
+	char *pcrval;
 	char pcr[100];	/* may contain an error */
 	char cmd[50];
 	int ret;

+	#if defined(HAVE_TSSPCRREAD)
 	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
+	#elif defined(HAVE_TPM2PCRLIST)
+	sprintf(cmd, "tpm2_pcrlist -L sha1:%d", idx);
+	#endif
 	fp = popen(cmd, "r");
 	if (!fp) {
 		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
@@ -1439,18 +1444,39 @@ static int tpm2_pcr_read(int idx, uint8_t
*hwpcr, int len, char **errmsg)
 	}

 	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
-		ret = asprintf(errmsg, "tsspcrread failed: %s",
+		ret = asprintf(errmsg, "PCR Reading failed: %s",
 			       strerror(errno));
 		if (ret == -1)	/* the contents of errmsg is undefined */
 			*errmsg = NULL;
 		ret = pclose(fp);
 		return -1;
 	}
+	pcrval = &pcr;
+
+	#ifdef HAVE_TPM2PCRLIST
+	/* Get the second line of output as PCR value */
+	if (fgets(pcr, sizeof(pcr), fp) == NULL) {
+		ret = asprintf(errmsg, "PCW Reading failed: %s",
+			       strerror(errno));
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		ret = pclose(fp);
+		return -1;
+	}
+	pcrval = strchr(&pcr, ':');
+	if (pcrval == NULL) {
+		*errmsg = NULL;
+		ret = pclose(fp);
+		return -1;
+	}
+	/* Skip the colon */
+	pcrval++;
+	#endif

 	/* get the popen "cmd" return code */
 	ret = pclose(fp);
 	if (!ret)
-		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
+		hex2bin(hwpcr, pcrval, SHA_DIGEST_LENGTH);
 	else
 		*errmsg = strndup(pcr, strlen(pcr) - 1); /* remove newline */

@@ -1715,7 +1741,7 @@ static int ima_measurement(const char *file)
 		log_dump(pcr[i], SHA_DIGEST_LENGTH);

 		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
-#ifdef HAVE_TSSPCRREAD
+#if defined(HAVE_TSSPCRREAD) || defined(HAVE_TPM2PCRLIST)
 			char *errmsg = NULL;

 			err = tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);
-- 
2.21.0
