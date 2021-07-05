Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D133BC14A
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhGEQA7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 12:00:59 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:55374
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230305AbhGEQA7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 12:00:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhGHoG6dqJIyWbAkdkKIvwnYyO19LAikWhh0IMguuCmWpytJGR8KSOWUqWzmSby/joFJ8gWptxxIcmM+1g2mSpwM49Egjtb46GUtYp9CjPqGceod14+tSD9ThvRUDT0r31U3hzyV9pJkoy8ig5o4I0WrJiOmqR7/LvWTGPJtMlhKiwt2vtxqQaS6J/vYNmcFKmHf5jUxFo+vDpBnieyezh00psP8ot+X/HSbQuizIPefGdXZFhSVPbIrwi/X815NeTmibbwW4Dv1ZD/43RJaRJJc+h5hKEx5xmTP7lq/63PmE9TTiY5Aj+ZUSPs3QYrdYqwTSBKVr4YB0+rvH3TnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEtgoy8F2idYQhUwu1pVMaQ/CaMlgDY+UOpUeTgqe2A=;
 b=YJBy0GZv4XCL9o1wMWFiNMcYUxr8OidhAlfYR71O8ZPChFXHdpR4bmF6HbTcwZ/JGMdrl3HxVarp0JUq6362yprPvnW51d/UQ3rL35qX99NES9I3rFTqrrRqelGoY/ZQC+96FV/ijGLYj/YKdwrebIQ3rhDGJzmdzvyhnQX9QO/sUqqAm5blnXVOWuPGAZTkWL4swPs0KaH3/0kA6CZI2JrSMu62icmAbqW7CrsTTZt30STBPssAdc6Bxv19ZHT5Q8NcyoeqpGnMac0fSjxEvQic+xLEO6HOCI4d5EzupgzcRsnFcG+VeBI3HoLPR4KhtAWY5c2+0TZwPs2e4Rb9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEtgoy8F2idYQhUwu1pVMaQ/CaMlgDY+UOpUeTgqe2A=;
 b=shQ7Gb3VtZAzgG2KK+v/x+reoIr419w6of/aoa+beNN/ZdvXN39gMftqJ2eQExJLyV5pqPwqU4R8qY+GINFzEVOPoIOn4qE/DnrQWsyJ8Ny/ESSsTOspAdu3pGS2h+c+bbmgEguQXsa9Kxv208hfvNym8KQM1vdbutqKfKQ6qEorJ8Rii5KkzvSfAYX2SkbOwACJChNWKNGQjdNomdxL9GGCJY5suEdKtS7fJHI6cPXu2s8PPi61GhobZHwYupnPOJn5F5DaySR+aq0RgvgRXBbv/6Xj2Zjc/4k10MucaPSJsoSkzXaul9vdkQmKgcrexkIvt6jjvc25b4DWNzS7sw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM0P191MB0276.EURP191.PROD.OUTLOOK.COM (2603:10a6:208:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 15:58:18 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038%8]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:58:18 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, patrick@puiterwijk.org
Subject: [PATCH ima-evm-utils v2 2/2] Add test for using sign_hash API
Date:   Mon,  5 Jul 2021 17:49:50 +0200
Message-Id: <20210705154950.497359-3-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210705154950.497359-1-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
 <20210705154950.497359-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [45.148.140.78]
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.patrick.home.puiterwijk.org (45.148.140.78) by AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 15:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f1cc33-7177-4a22-4719-08d93fcdb4d0
X-MS-TrafficTypeDiagnostic: AM0P191MB0276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P191MB0276FE2327B4A6C0FB797100C81C9@AM0P191MB0276.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6s+31n8RssNef+lycz8k/AfSx7oU+06GjSmykbWx88m4YTzJLVRYmc+/CqKJUkRkWiMPC3pW6LyHpgOezHImdd1iPeULwH9hX/deHzyS9JT1QqQcoHII6jAp1Z511g5XEenh3YXfbOih8c3Ad+CNzHRqMQ89LiYO5G3LGrLn/gl45XciT0upuMzSD9OIa0QZwa4i//b8A7hzHPtAQcpZeK8FnOVGNngkOrcb1HPaU0NwJ43OexlU4KtUHs1CLfsfvt2vOz5d+kxU398wr8ZGBOzONzwgtd10OcPLA8hrlq0xi3JghiE7rXei/fIpaJm5LSYohp6z+BiFvBOpMyAChgxbQRd/1OpJefjyV/IkKT92nbxhjmr/3L5iIuKTbz9GlWuv4HKgGFUu2WeR8maWLzb7g2i/vhQj67z5DfegnzMxMb63UC2NBSJj+s3vl6klPHZzsLdACH6py9T+nVsGFciLZ/GVt7MFoUvLYHjvvULFGKnO9v7OmJ5a1CT30PvrHEehKVb2194+1ILr0SCi5bh6Dx0keFoQNkbwCFxGPa0lzGSTAFucoapvNNiEbGN/qsdmiPyyOZTwyViQZsxCtvDj2kUYoulAHqVGskjhngR6KDhCfDG+/q+DLFGNEi3O2RmefK7FM0H8j8jd7NzedSkNDU+c+RmXcluXrxaSLRAqEa4vjoWJd9JbrzfyrFKr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(376002)(346002)(6666004)(956004)(52116002)(7696005)(316002)(36756003)(2616005)(66946007)(66476007)(66556008)(6486002)(26005)(186003)(8936002)(38100700002)(38350700002)(478600001)(1076003)(86362001)(16526019)(2906002)(83380400001)(8676002)(4326008)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKzxMIvad3VcnObh4jijC4URybMZXrA6yVJVlHRmGfqDsk+q14OuAawwKSz7?=
 =?us-ascii?Q?e1zDx0vEfuAGMolvNbFc0a1Pu47RFHOQ8SS5aVb2N+NPr9lO8/B2zb1+evnd?=
 =?us-ascii?Q?+JU8UqUq3dxdbZit0jkxNpBtQwkZPjzncOJGHiBe8U44O1CX72FcRR5iW857?=
 =?us-ascii?Q?MWczIeRLb+FIpZ/+SMgYIHjoJTmrJk7A/SZ6maov/ajE7FOEAa7Ri5KKDinC?=
 =?us-ascii?Q?BwGYAI54QRwOVbjNNc9hxRVpKcNq3kJPb1otdnR852KIiif778wQFjgrBzNS?=
 =?us-ascii?Q?rm6Xd2YrSIBFDRL5p4FV/Db1x5YxGUJj+dLEzR5f8QFXTpiJht3Elk8WZr9B?=
 =?us-ascii?Q?PRK7sBeVB69VE/G+b3bPpaI3rp7+OEVYXPpmE42OTf+aR6xIUMiNAcOAd3aV?=
 =?us-ascii?Q?+KHPMFhPnFQEpwgpFnfcLWXlof5AqyJIIhm8ivVNJlrOgiMb3ZyLyzeDBcDh?=
 =?us-ascii?Q?vVa990sV07cRfDFiGnO30KSSFcnRnto10PJ2PAI/DsnR5LYQomQKElEt5Hz9?=
 =?us-ascii?Q?apt7VWHEjdey4WBixSY72VaX8OVVveZFSM94KMO3zK9iAfk3qG4LzuWRSEjv?=
 =?us-ascii?Q?r+QYDOZrSEcaxBl9twF2RfPFnvNCKBkvlzaDfv4KYOyS8OE6XmGEWIPJGYz2?=
 =?us-ascii?Q?LzxsNhCjpWo/NYvZCQ0CrThhdebkqp7Ut6vwNmjNPj+IMqERJYGLa5w8i4qq?=
 =?us-ascii?Q?5VansZWaEIdxyov0TnjP+8vBxwOyjemex1JfW+CY3M2RnVsi5zl+0wtPAZkq?=
 =?us-ascii?Q?udENtMI/n7220hKJlWZwaLeFnmkarG16M5KolVb6862d/00nv787ztqwLpnI?=
 =?us-ascii?Q?QNZ45MFtmL7DL3f+2Ry5fwP/9UV+r7HXm0BZoxNXNB1YXA9M25BLV/lbOJJK?=
 =?us-ascii?Q?NgOKtj/fKtDenud/jKJwqY7YZm5wlumkHusB/Ej4LiAgmYxYIzF+1t35crc7?=
 =?us-ascii?Q?34+sifUGpmbnEd34y3hmJVIi1KNtHbUgoGD9TMiLtngvY65SZLea5g4CxH8O?=
 =?us-ascii?Q?K2ecRD0BhCk95cXsDc9HN2rpyrO1VfHsMxdBu/xX7kFbPyF+9oyVu1tbM5TE?=
 =?us-ascii?Q?byzHYqXYiyu43vZtEl7hw2G+0wJ2Lgsil98/Rx+bxhsS3yJmRkageoQCOAh/?=
 =?us-ascii?Q?QKjxXoDnCiZCxrpxLNxfPbZxhghwDM8SYE/+DdUIUu36pT94WdIL/E3NpmFa?=
 =?us-ascii?Q?SC+7STafGuGtFSf5RknGd/WmVbHohZjnigEQx2JBqruu+mkMTvSN9wjUkezz?=
 =?us-ascii?Q?ioe3jpnzNi2WH3E84o3Nqha06oCuPk6SYwz89F3lEYL6I+YoTNdKy2N+H1Jj?=
 =?us-ascii?Q?l6TaxFWkjadnNsC/iK+rQimP?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f1cc33-7177-4a22-4719-08d93fcdb4d0
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:58:18.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxzGRNj2Q9+2u7dRm7GG6Eo9/YfLM/w4SBtO9KATlMgNYajB4CNz5OmxKPM9sjsDLIvakLFBzIOF/GCyT1SKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0276
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds a test with a small program that calls the sign_hash API, to
ensure that that codepath works.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c                | 23 ----------------
 src/utils.c                 | 20 ++++++++++++++
 src/utils.h                 |  1 +
 tests/.gitignore            |  2 ++
 tests/Makefile.am           |  5 ++++
 tests/sign_verify.apitest.c | 55 +++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test      | 30 ++++++++++++++++----
 7 files changed, 107 insertions(+), 29 deletions(-)
 create mode 100644 tests/sign_verify.apitest.c

diff --git a/src/evmctl.c b/src/evmctl.c
index 7a6f202..867b142 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -166,29 +166,6 @@ struct tpm_bank_info {
 static char *pcrfile[MAX_PCRFILE];
 static unsigned npcrfile;
 
-static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
-{
-	FILE *fp;
-	char name[strlen(file) + (ext ? strlen(ext) : 0) + 2];
-	int err;
-
-	if (ext)
-		sprintf(name, "%s.%s", file, ext);
-	else
-		sprintf(name, "%s", file);
-
-	log_info("Writing to %s\n", name);
-
-	fp = fopen(name, "w");
-	if (!fp) {
-		log_err("Failed to open: %s\n", name);
-		return -1;
-	}
-	err = fwrite(data, len, 1, fp);
-	fclose(fp);
-	return err;
-}
-
 static unsigned char *file2bin(const char *file, const char *ext, int *size)
 {
 	FILE *fp;
diff --git a/src/utils.c b/src/utils.c
index fbb6a4b..ce2cc28 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -112,3 +112,23 @@ int hex2bin(void *dst, const char *src, size_t count)
 	}
 	return 0;
 }
+
+int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
+{
+	FILE *fp;
+	char name[strlen(file) + (ext ? strlen(ext) : 0) + 2];
+	int err;
+
+	if (ext)
+		sprintf(name, "%s.%s", file, ext);
+	else
+		sprintf(name, "%s", file);
+
+	fp = fopen(name, "w");
+	if (!fp)
+		return -1;
+
+	err = fwrite(data, len, 1, fp);
+	fclose(fp);
+	return err;
+}
diff --git a/src/utils.h b/src/utils.h
index 9ea179f..081997a 100644
--- a/src/utils.h
+++ b/src/utils.h
@@ -4,3 +4,4 @@
 int get_cmd_path(const char *prog_name, char *buf, size_t buf_len);
 int hex_to_bin(char ch);
 int hex2bin(void *dst, const char *src, size_t count);
+int bin2file(const char *file, const char *ext, const unsigned char *data, int len);
diff --git a/tests/.gitignore b/tests/.gitignore
index 9ecc984..c40735d 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -14,3 +14,5 @@
 *.key
 *.conf
 
+# Compiled version of apitest
+sign_verify_apitest
diff --git a/tests/Makefile.am b/tests/Makefile.am
index ff928e1..74f6125 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -10,3 +10,8 @@ distclean: distclean-keys
 .PHONY: distclean-keys
 distclean-keys:
 	./gen-keys.sh clean
+
+AUTOMAKE_OPTIONS = subdir-objects
+bin_PROGRAMS = sign_verify_apitest
+sign_verify_apitest_SOURCES = sign_verify.apitest.c ../src/utils.c
+sign_verify_apitest_LDFLAGS = -limaevm -L../src/.libs
diff --git a/tests/sign_verify.apitest.c b/tests/sign_verify.apitest.c
new file mode 100644
index 0000000..3fcd043
--- /dev/null
+++ b/tests/sign_verify.apitest.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sign_verify.apitest: Test program for verifying sign_hash
+ *
+ * Copyright (C) 2021 Patrick Uiterwijk <patrick@puiterwijk.org>
+ * Copyright (C) 2013,2014 Samsung Electronics
+ * Copyright (C) 2011,2012,2013 Intel Corporation
+ * Copyright (C) 2011 Nokia Corporation
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+
+#include "../src/imaevm.h"
+#include "../src/utils.h"
+
+int main(int argc, char **argv)
+{
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
+	int len, err;
+	char *file = argv[1];
+	char *key = argv[2];
+	char *algo = argv[3];
+	char *digest = argv[4];
+
+	len = strlen(digest) / 2;
+	if (hex2bin(hash, digest, len) != 0) {
+		fprintf(stderr, "Error during hex2bin\n");
+		return 1;
+	}
+
+	len = sign_hash(algo, hash, len, key, NULL, sig + 1);
+	if (len <= 1) {
+		fprintf(stderr, "Error signing\n");
+		return 1;
+	}
+
+	/* add header */
+	len++;
+	sig[0] = EVM_IMA_XATTR_DIGSIG;
+
+	bin2file(file, "sig", sig, len);
+
+	err = lsetxattr(file, "user.ima", sig, len, 0);
+	if (err < 0) {
+		log_err("setxattr failed: %s\n", file);
+		return 1;
+	}
+
+	return 0;
+}
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3d7aa51..6f92801 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -66,14 +66,14 @@ _keyid_from_cert() {
 
 # Convert test $type into evmctl op prefix
 _op() {
-  if [ "$1" = ima ]; then
+  if [ "$1" = ima -o "$1" = ima_api ]; then
     echo ima_
   fi
 }
 
 # Convert test $type into xattr name
 _xattr() {
-  if [ "$1" = ima ]; then
+  if [ "$1" = ima -o "$1" = ima_api ]; then
     echo user.ima
   else
     echo user.evm
@@ -113,11 +113,13 @@ _evmctl_sign() {
   [ "$type" = ima ] && opts+=" --sigfile"
 
   # shellcheck disable=SC2086
-  ADD_TEXT_FOR="$alg ($key)" ADD_DEL=$file \
+  [ "$type" = ima -o "$type" = evm ] && (ADD_TEXT_FOR="$alg ($key)" ADD_DEL=$file \
     _evmctl_run "$(_op "$type")sign" $opts \
-    --hashalgo "$alg" --key "$key" --xattr-user "$file" || return
+    --hashalgo "$alg" --key "$key" --xattr-user "$file" || return)
+  [ "$type" = ima_api ] && ADD_TEXT_FOR="$alg ($key)" ADD_DEL=$file \
+    ./sign_verify_apitest "$file" "$key" "$alg" "$(openssl dgst $OPENSSL_ENGINE -$ALG -hex -r $FILE | awk '{print $1}')"
 
-  if [ "$type" = ima ]; then
+  if [ "$type" = ima -o "$type" = ima_api ]; then
     _test_sigfile "$file" "$(_xattr "$type")" "$file.sig" "$file.sig2"
   fi
 }
@@ -125,12 +127,14 @@ _evmctl_sign() {
 # Run and test {ima_,}sign operation
 check_sign() {
   # Arguments are passed via global vars:
-  # TYPE (ima or evm),
+  # TYPE (ima, ima_api or evm),
   # KEY,
   # ALG (hash algo),
   # PREFIX (signature header prefix in hex),
   # OPTS (additional options for evmctl),
   # FILE (working file to sign).
+  [ "$TYPE" = ima_api ] && [[ "$OPTS" =~ --rsa ]] && return "$SKIP"
+
   local "$@"
   local KEY=${KEY%.*}.key
   local FILE=${FILE:-$ALG.txt}
@@ -268,6 +272,20 @@ sign_verify() {
     # Multiple files and some don't verify
     expect_fail check_verify FILE="/dev/null $file"
 
+    setfattr -x user.ima "$FILE"
+    rm "$FILE.sig"
+  fi
+
+  TYPE=ima_api
+  if expect_pass check_sign; then
+
+    # Normal verify with proper key should pass
+    expect_pass check_verify
+    expect_pass check_verify OPTS="--sigfile"
+
+    # Multiple files and some don't verify
+    expect_fail check_verify FILE="/dev/null $file"
+
     rm "$FILE.sig"
   fi
 
-- 
2.31.1

