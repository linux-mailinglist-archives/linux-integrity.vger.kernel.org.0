Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA427D3E2
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgI2Qu2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 12:50:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgI2Qu2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 12:50:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC0E5B288;
        Tue, 29 Sep 2020 16:50:26 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 2/4] IMA: Rewrite ima_boot_aggregate.c to new API
Date:   Tue, 29 Sep 2020 18:50:19 +0200
Message-Id: <20200929165021.11731-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929165021.11731-1-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The main reason was to see TCONF messages, which are printed into stderr
in new API (but to stdout in legacy API) and thus visible as the output
is redirected into the variable.

Changing boot_aggregate: to sha1: to be compatible with evmctl
ima_boot_aggregate.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
none

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 +++++++++---------
 .../security/integrity/ima/tests/ima_tpm.sh   |   2 +-
 2 files changed, 57 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 98893b99a..67f97ea04 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -1,19 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
-* Copyright (c) International Business Machines  Corp., 2009
-*
-* Authors:
-* Mimi Zohar <zohar@us.ibm.com>
-*
-* This program is free software; you can redistribute it and/or
-* modify it under the terms of the GNU General Public License as
-* published by the Free Software Foundation, version 2 of the
-* License.
-*
-* File: ima_boot_aggregate.c
-*
-* Calculate a SHA1 boot aggregate value based on the TPM
-* binary_bios_measurements.
-*/
+ * Copyright (c) International Business Machines  Corp., 2009
+ * Copyright (c) 2016-2019 Petr Vorel <pvorel@suse.cz>
+ *
+ * Authors: Mimi Zohar <zohar@us.ibm.com>
+ *
+ * Calculate a SHA1 boot aggregate value based on the TPM 1.2
+ * binary_bios_measurements.
+ */
+
+#include "config.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -23,10 +19,8 @@
 #include <unistd.h>
 #include <limits.h>
 
-#include "config.h"
-#include "test.h"
-
-char *TCID = "ima_boot_aggregate";
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
 
 #if HAVE_LIBCRYPTO
 #include <openssl/sha.h>
@@ -36,7 +30,24 @@ char *TCID = "ima_boot_aggregate";
 #define MAX_EVENT_DATA_SIZE (MAX_EVENT_SIZE - EVENT_HEADER_SIZE)
 #define NUM_PCRS 8		/*  PCR registers 0-7 in boot aggregate */
 
-int TST_TOTAL = 1;
+static char *debug;
+static char *file;
+
+static unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
+
+static struct {
+	struct {
+		u_int32_t pcr;
+		u_int32_t type;
+		u_int8_t digest[SHA_DIGEST_LENGTH];
+		u_int32_t len;
+	} header __attribute__ ((packed));
+	char *data;
+} event;
+
+static struct {
+	unsigned char digest[SHA_DIGEST_LENGTH];
+} pcr[NUM_PCRS];
 
 static void display_sha1_digest(unsigned char *pcr)
 {
@@ -47,45 +58,24 @@ static void display_sha1_digest(unsigned char *pcr)
 	printf("\n");
 }
 
-int main(int argc, char *argv[])
+static void do_test(void)
 {
-	unsigned char boot_aggregate[SHA_DIGEST_LENGTH];
-	struct {
-		struct {
-			u_int32_t pcr;
-			u_int32_t type;
-			u_int8_t digest[SHA_DIGEST_LENGTH];
-			u_int32_t len;
-		} header __attribute__ ((packed));
-		char *data;
-	} event;
-	struct {
-		unsigned char digest[SHA_DIGEST_LENGTH];
-	} pcr[NUM_PCRS];
 	FILE *fp;
-	int i;
-	int debug = 0;
 	SHA_CTX c;
+	int i;
 
-	if (argc != 2) {
-		printf("format: %s binary_bios_measurement file\n", argv[0]);
-		return 1;
-	}
-	fp = fopen(argv[1], "r");
-	if (!fp) {
-		perror("unable to open pcr file\n");
-		return 1;
-	}
+	if (!file)
+		tst_brk(TBROK, "missing binary_bios_measurement file, specify with -f");
+
+	fp = SAFE_FOPEN(file, "r");
 
 	/* Initialize psuedo PCR registers 0 - 7 */
 	for (i = 0; i < NUM_PCRS; i++)
 		memset(&pcr[i].digest, 0, SHA_DIGEST_LENGTH);
 
 	event.data = malloc(MAX_EVENT_DATA_SIZE);
-	if (!event.data) {
-		printf("Cannot allocate memory\n");
-		return 1;
-	}
+	if (!event.data)
+		tst_brk(TBROK, "cannot allocate memory");
 
 	/* Extend the pseudo PCRs with the event digest */
 	while (fread(&event, sizeof(event.header), 1, fp)) {
@@ -105,13 +95,14 @@ int main(int argc, char *argv[])
 
 #if MAX_EVENT_DATA_SIZE < USHRT_MAX
 		if (event.header.len > MAX_EVENT_DATA_SIZE) {
-			printf("Error event too long\n");
+			tst_res(TWARN, "error event too long");
 			break;
 		}
 #endif
 		fread(event.data, event.header.len, 1, fp);
 	}
-	fclose(fp);
+
+	SAFE_FCLOSE(fp);
 	free(event.data);
 
 	/* Extend the boot aggregate with the pseudo PCR digest values */
@@ -126,14 +117,22 @@ int main(int argc, char *argv[])
 	}
 	SHA1_Final(boot_aggregate, &c);
 
-	printf("boot_aggregate:");
+	printf("sha1:");
 	display_sha1_digest(boot_aggregate);
-	tst_exit();
+	tst_res(TPASS, "found sha1 hash");
 }
 
+static struct tst_option options[] = {
+	{"d", &debug, "-d       enable debug"},
+	{"f:", &file, "-f x     binary_bios_measurement file (required)\n"},
+	{NULL, NULL, NULL}
+};
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.options = options,
+};
+
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "test requires libcrypto and openssl development packages");
-}
+TST_TEST_TCONF("libcrypto and openssl development packages required");
 #endif
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index c69f891f1..dc958eb5c 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -33,7 +33,7 @@ test1()
 			tst_res TFAIL "bios boot aggregate is not 0"
 		fi
 	else
-		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
+		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
 		if [ "$boot_hash" = "$boot_aggregate" ]; then
 			tst_res TPASS "bios aggregate matches IMA boot aggregate"
 		else
-- 
2.28.0

