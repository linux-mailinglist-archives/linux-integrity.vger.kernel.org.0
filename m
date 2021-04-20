Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76531365F42
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhDTSbE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 14:31:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47381 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233545AbhDTSbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 14:31:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KI50h4145724
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=N1Hv30sxCEOeV9BxrzVVRvhXDa/DNH00ZYS4W5qY0Wg=;
 b=S+u6go8SnK7LYYB55Z1u/DwWMUWPVsY9H1+kVHhztwGsbrY6o7PleVB8JCIqZz1DsXvg
 qzhSglIQ/DEOoBkYel8cyudjN1+AFEjEihwq7q4nNk40KK4VIzzeTemXPE9zqzR6UUYJ
 uuvS1nizqf51B2NpvEl+PWh5sqHKWuI6NYsfB1I+jUclW6UvC6piQP+e8eUsly6bbQB/
 PA1G7VPUwxVl0qd7WghNhxJMGj+zMtTkHmNq2WZtqvQwfUFknxYwA7R20mdNDmVx8tKw
 LyPD/s/sh7L87A/77rCEByUBv8e7pKWAdNjdKgYJXyHn9BKYkUiZSsChrLH2DOTHC780 Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3823en9hsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KI5fi2149228
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3823en9hsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 14:30:24 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KIMQ5t011893;
        Tue, 20 Apr 2021 18:30:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 37yqa94aa2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 18:30:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KIUMJ418219482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 18:30:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C84B6E04E;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 243046E056;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/3] tests: Add program to create IMA signature with new API call
Date:   Tue, 20 Apr 2021 14:30:14 -0400
Message-Id: <20210420183015.861644-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183015.861644-1-stefanb@linux.ibm.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pN2fTXJmi7uQ9BOI9wJ8OkEmxRym6xIC
X-Proofpoint-ORIG-GUID: lm4bjsKm72vrwAqCeOZJ94moXqpLklmQ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_08:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since the new API call is not used by evmctl, implement a test program
'create_ima_signature' to use it. Extend _evmctl_sign to also created
IMA v2 signatures with RSA keys using this test program and compare the
results.

Evmctl's signature creation path is unmodified at this point, so the tests
ensure that the existing sign_hash_v2 and the new sign_hash_v2_pkey create
identical (RSA) signatures.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/Makefile.am            |   6 ++
 tests/create_ima_signature.c | 111 +++++++++++++++++++++++++++++++++++
 tests/sign_verify.test       |  21 ++++++-
 3 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 tests/create_ima_signature.c

diff --git a/tests/Makefile.am b/tests/Makefile.am
index ff928e1..5e255b1 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -3,6 +3,12 @@ TESTS = $(check_SCRIPTS)
 
 check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test
 
+check_PROGRAMS = \
+	create_ima_signature
+
+create_ima_signature_CFLAGS = -I$(top_srcdir)/src
+create_ima_signature_LDFLAGS = -lcrypto -L$(top_builddir)/src/.libs -limaevm
+
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
 
diff --git a/tests/create_ima_signature.c b/tests/create_ima_signature.c
new file mode 100644
index 0000000..649efcf
--- /dev/null
+++ b/tests/create_ima_signature.c
@@ -0,0 +1,111 @@
+/*
+ * create_ima_signature - Test program for imaevm_create_ima_signature
+ *
+ * Copyright (C) 2021 IBM Corporation
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
+ */
+
+#include <getopt.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <openssl/pem.h>
+
+#include "imaevm.h"
+
+int main(int argc, char *argv[]) {
+	unsigned char ima_signature[MAX_SIGNATURE_SIZE];
+	static struct option long_options[] = {
+		{"key", required_argument, NULL, 'k'},
+		{"hashalgo", required_argument, NULL, 'a'},
+		{NULL, 0, NULL, 0}
+	};
+	const char *hash_algo = "sha1";
+	const char *keyfile = NULL;
+	const char *file_to_sign;
+	EVP_PKEY *pkey = NULL;
+	char *error = NULL;
+	int option_index;
+	int siglen;
+	size_t i;
+	FILE *fp;
+	int opt;
+
+	while ((opt = getopt_long_only(argc, argv, "", long_options, &option_index)) != -1) {
+		switch (opt) {
+		case 'k':
+			keyfile = optarg;
+			break;
+		case 'a':
+			hash_algo = optarg;
+			break;
+		default:
+			fprintf(stderr, "Unhandled option %d.\n", opt);
+			return 1;
+		}
+	}
+	if (keyfile == NULL) {
+		fprintf(stderr, "Missing --key option.\n");
+		return 1;
+	}
+
+	if (optind == argc) {
+		fprintf(stderr, "Missing filename for file to sign.");
+	}
+
+	file_to_sign = argv[optind];
+
+	fp = fopen(keyfile, "r");
+	if (fp == NULL) {
+		fprintf(stderr, "Could not open private key file: %s\n", strerror(errno));
+		return 1;
+	}
+
+	pkey = PEM_read_PrivateKey(fp, NULL, NULL, NULL);
+	fclose(fp);
+	if (pkey == NULL) {
+		fprintf(stderr, "Could not read private key!\n");
+		return 1;
+	}
+
+	/* the library doesn't prepend this! */
+	ima_signature[0] = EVM_IMA_XATTR_DIGSIG;
+	siglen = imaevm_create_ima_signature(file_to_sign, pkey, hash_algo, &ima_signature[1],
+	                                     sizeof(ima_signature) - 1, &error);
+	if (siglen < 0) {
+		fprintf(stderr, "Failed to created IMA signature: %s\n", error);
+	} else {
+		fprintf(stdout, "Successfully created IMA signature!\n");
+		for (i = 0; i < siglen + 1; i++)
+			fprintf(stdout, "%02x", ima_signature[i]);
+		fprintf(stdout, "\n");
+	}
+
+	free(error);
+	EVP_PKEY_free(pkey);
+
+	return siglen < 0;
+}
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 288e133..14964ec 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -16,10 +16,10 @@
 # GNU General Public License for more details.
 
 cd "$(dirname "$0")" || exit 1
-PATH=../src:$PATH
+PATH=../src:.:$PATH
 source ./functions.sh
 
-_require cmp evmctl getfattr openssl xxd
+_require cmp evmctl getfattr openssl xxd create_ima_signature
 
 if cmp -b 2>&1 | grep -q "invalid option"; then
 	echo "cmp does not support -b (cmp from busybox?) Use cmp from diffutils"
@@ -118,7 +118,24 @@ _evmctl_sign() {
 
   if [ "$type" = ima ]; then
     _test_sigfile "$file" "$(_xattr "$type")" "$file.sig" "$file.sig2"
+    if [ $? -ne $OK ]; then
+        return "$FAIL"
+    fi
+  fi
+  # Compare evmctl IMA v2 signatures with RSA keys versus those from create_ima_signature
+  if [ "$type" = ima ] && [[ $key =~ rsa ]] && ! [[ $opts =~ --rsa ]] ; then
+    create_ima_signature --key "${key}" --hashalgo "${alg}" "${file}" |
+      sed -n 's/^03.*/\0/p' |
+      xxd -r -p > "$file.sig2"
+
+    if ! cmp -bl "$file.sig" "$file.sig2"; then
+      color_red
+      echo "evmctl vs. create_ima_signature: signatures on $file differ"
+      color_restore
+      return "$FAIL"
+    fi
   fi
+  return $OK
 }
 
 # Run and test {ima_,}sign operation
-- 
2.30.2

