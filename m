Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDD421F65F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jul 2020 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGNPrK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jul 2020 11:47:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59882 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgGNPrJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jul 2020 11:47:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1809AAD46;
        Tue, 14 Jul 2020 15:47:09 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] Check for tsspcrread in runtime
Date:   Tue, 14 Jul 2020 17:46:59 +0200
Message-Id: <20200714154659.8080-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

instead of checking in build time as it's runtime dependency.
Also log when tsspcrread not found to make debugging easier.

We search for tsspcrread unless there is tss2-esys with Esys_PCR_Read(),
thus pcr_none.c was dropped as unneeded.

file_exist(), file_exist() and MIN() taken from LTP project.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

small improvement based on the current next-testing branch
(9638068aff2476b567185d7eb94126449ad89ca7).

I'm sorry I don't have the required setup, thus didn't test this patch.

Kind regards,
Petr

 configure.ac         |  7 -----
 src/Makefile.am      |  4 ---
 src/evmctl.c         |  5 +--
 src/pcr.h            |  2 +-
 src/pcr_none.c       | 52 ------------------------------
 src/pcr_tss.c        |  2 +-
 src/pcr_tsspcrread.c | 22 ++++++++++---
 src/utils.c          | 75 ++++++++++++++++++++++++++++++++++++++++++++
 src/utils.h          |  1 +
 9 files changed, 99 insertions(+), 71 deletions(-)
 delete mode 100644 src/pcr_none.c

diff --git a/configure.ac b/configure.ac
index f246182..e7df7cd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -30,12 +30,6 @@ AC_SUBST(KERNEL_HEADERS)
 AC_CHECK_HEADER(unistd.h)
 AC_CHECK_HEADERS(openssl/conf.h)
 
-AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
-if test "x$TSSPCRREAD" = "xyes"; then
-	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binary installed])
-fi
-AM_CONDITIONAL([USE_PCRTSSPCRREAD], [test "x$TSSPCRREAD" = "xyes"])
-
 AC_CHECK_LIB([tss2-esys], [Esys_PCR_Read])
 AC_CHECK_LIB([tss2-rc], [Tss2_RC_Decode])
 AM_CONDITIONAL([USE_PCRTSS], [test "x$ac_cv_lib_tss2_esys_Esys_PCR_Read" = "xyes"])
@@ -83,7 +77,6 @@ echo
 echo	"Configuration:"
 echo	"          debug: $pkg_cv_enable_debug"
 echo	"   openssl-conf: $enable_openssl_conf"
-echo	"     tsspcrread: $TSSPCRREAD"
 echo	"      tss2-esys: $ac_cv_lib_tss2_esys_Esys_PCR_Read"
 echo	" tss2-rc-decode: $ac_cv_lib_tss2_rc_Tss2_RC_Decode"
 echo
diff --git a/src/Makefile.am b/src/Makefile.am
index 9bbff50..ba9719b 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -25,11 +25,7 @@ evmctl_LDADD =  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
 if USE_PCRTSS
 evmctl_SOURCES += pcr_tss.c
 else
-if USE_PCRTSSPCRREAD
 evmctl_SOURCES += pcr_tsspcrread.c
-else
-evmctl_SOURCES += pcr_none.c
-endif
 endif
 
 AM_CPPFLAGS = -I$(top_srcdir) -include config.h
diff --git a/src/evmctl.c b/src/evmctl.c
index 90a3eeb..1d75e58 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1844,8 +1844,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 		return 0;
 
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
-	if (!tpm2_pcr_supported()) {
-		log_debug("Failed to read TPM 2.0 PCRs\n");
+	if (!tpm2_pcr_supported(&errmsg)) {
+		log_debug("Failed to read TPM 2.0 PCRs: (%s)\n", errmsg);
+		free(errmsg);
 		return 1;
 	}
 
diff --git a/src/pcr.h b/src/pcr.h
index 79547bd..0284f1c 100644
--- a/src/pcr.h
+++ b/src/pcr.h
@@ -1,3 +1,3 @@
-int tpm2_pcr_supported(void);
+int tpm2_pcr_supported(char **errmsg);
 int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 		 int len, char **errmsg);
diff --git a/src/pcr_none.c b/src/pcr_none.c
deleted file mode 100644
index 43d053d..0000000
--- a/src/pcr_none.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * ima-evm-utils - IMA/EVM support utilities
- *
- * Copyright (C) 2011 Nokia Corporation
- * Copyright (C) 2011,2012,2013 Intel Corporation
- * Copyright (C) 2013,2014 Samsung Electronics
- *
- * Authors:
- * Dmitry Kasatkin <dmitry.kasatkin@nokia.com>
- *                 <dmitry.kasatkin@intel.com>
- *                 <d.kasatkin@samsung.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * As a special exception, the copyright holders give permission to link the
- * code of portions of this program with the OpenSSL library under certain
- * conditions as described in each individual source file and distribute
- * linked combinations including the program with the OpenSSL library. You
- * must comply with the GNU General Public License in all respects
- * for all of the code used other than as permitted herein. If you modify
- * file(s) with this exception, you may extend this exception to your
- * version of the file(s), but you are not obligated to do so. If you do not
- * wish to do so, delete this exception statement from your version. If you
- * delete this exception statement from all source files in the program,
- * then also delete it in the license file.
- *
- * File: pcr_none.c
- *	 PCR reading implementation that always fails
- */
-
-#include <stdint.h>
-
-int tpm2_pcr_supported(void)
-{
-	return 0;
-}
-
-int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
-		 int len, char **errmsg)
-{
-	return -1;
-}
diff --git a/src/pcr_tss.c b/src/pcr_tss.c
index da7be2e..87b8df3 100644
--- a/src/pcr_tss.c
+++ b/src/pcr_tss.c
@@ -51,7 +51,7 @@
 #endif
 #endif
 
-int tpm2_pcr_supported(void)
+int tpm2_pcr_supported(char **errmsg  __attribute__((unused)))
 {
 	return 1;
 }
diff --git a/src/pcr_tsspcrread.c b/src/pcr_tsspcrread.c
index 9c58dcb..3164a5d 100644
--- a/src/pcr_tsspcrread.c
+++ b/src/pcr_tsspcrread.c
@@ -39,6 +39,7 @@
  */
 
 #include <errno.h>
+#include <limits.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
@@ -47,8 +48,21 @@
 
 #include "utils.h"
 
-int tpm2_pcr_supported(void)
+#define CMD "tsspcrread"
+
+static char path[PATH_MAX];
+
+int tpm2_pcr_supported(char **errmsg)
 {
+	int ret;
+
+	if (get_cmd_path(CMD, path, sizeof(path))) {
+		ret = asprintf(errmsg, "Couldn't find '%s' in $PATH", CMD);
+		if (ret == -1)	/* the contents of errmsg is undefined */
+			*errmsg = NULL;
+		return 0;
+	}
+
 	return 1;
 }
 
@@ -57,11 +71,11 @@ int tpm2_pcr_read(const char *algo_name, int idx, uint8_t *hwpcr,
 {
 	FILE *fp;
 	char pcr[100];	/* may contain an error */
-	char cmd[50];
+	char cmd[PATH_MAX + 50];
 	int ret;
 
-	sprintf(cmd, "tsspcrread -halg %s -ha %d -ns 2> /dev/null",
-		algo_name, idx);
+	sprintf(cmd, "%s -halg %s -ha %d -ns 2> /dev/null",
+		path, algo_name, idx);
 	fp = popen(cmd, "r");
 	if (!fp) {
 		ret = asprintf(errmsg, "popen failed: %s", strerror(errno));
diff --git a/src/utils.c b/src/utils.c
index 22702ed..416a88c 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -1,7 +1,82 @@
 #include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
 
 #include "utils.h"
 
+#ifndef MIN
+# define MIN(a, b) ({ \
+	typeof(a) _a = (a); \
+	typeof(b) _b = (b); \
+	_a < _b ? _a : _b; \
+})
+#endif /* MIN */
+
+static int file_exist(const char *path)
+{
+	struct stat st;
+
+	if (!access(path, R_OK) && !stat(path, &st) && S_ISREG(st.st_mode))
+		return 1;
+
+	return 0;
+}
+
+int get_cmd_path(const char *prog_name, char *buf, size_t buf_len)
+{
+	const char *path = (const char *)getenv("PATH");
+	const char *start = path;
+	const char *end;
+	size_t size, ret;
+
+	if (path == NULL)
+		return -1;
+
+	do {
+		end = strchr(start, ':');
+
+		if (end != NULL)
+			snprintf(buf, MIN(buf_len, (size_t) (end - start + 1)),
+				 "%s", start);
+		else
+			snprintf(buf, buf_len, "%s", start);
+
+		size = strlen(buf);
+
+		/*
+		 * "::" inside $PATH, $PATH ending with ':' or $PATH starting
+		 * with ':' should be expanded into current working directory.
+		 */
+		if (size == 0) {
+			snprintf(buf, buf_len, ".");
+			size = strlen(buf);
+		}
+
+		/*
+		 * If there is no '/' ad the end of path from $PATH add it.
+		 */
+		if (buf[size - 1] != '/')
+			ret =
+			    snprintf(buf + size, buf_len - size, "/%s",
+				     prog_name);
+		else
+			ret =
+			    snprintf(buf + size, buf_len - size, "%s",
+				     prog_name);
+
+		if (buf_len - size > ret && file_exist(buf))
+			return 0;
+
+		start = end + 1;
+
+	} while (end != NULL);
+
+	return -1;
+}
+
 int hex_to_bin(char ch)
 {
 	if ((ch >= '0') && (ch <= '9'))
diff --git a/src/utils.h b/src/utils.h
index 7c0ce15..9ea179f 100644
--- a/src/utils.h
+++ b/src/utils.h
@@ -1,5 +1,6 @@
 #include <ctype.h>
 #include <sys/types.h>
 
+int get_cmd_path(const char *prog_name, char *buf, size_t buf_len);
 int hex_to_bin(char ch);
 int hex2bin(void *dst, const char *src, size_t count);
-- 
2.27.0

