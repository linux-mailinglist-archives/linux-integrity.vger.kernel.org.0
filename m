Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101622EBBCB
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 10:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAFJq5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 04:46:57 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:19939
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbhAFJq4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 04:46:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz9445XXLAwCdCfbXxdYPNeYNo14gFZPz2nnpFBcjkvQMlq+MrlCpxwM3G4b+Bd4jLFnEi2mkW//SLVrFPSSmK6XWKOcWM2MpJ3DsZmi7C6qR4eahyMmZEaiFNAMqmIBcVGAAgupH75uS+FCG4raDk75r0d4zB2jkDUp81IHoFPQUxuO+3SNGwrrVOvrinkNj3NKOxE0MvXhDWQyoiNEw2icKHyJKP2AhWbDzvpvwULb+CKVUV8ClvotGnJlaJuIQCg+8YYrLvc9tnwnzjdqSljyC6V3td6dzeFWrmW7O/gqFYpFM+2ezGhc3zpxLzOsVuWR2H9e42JkzEQwGuWgPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neDwzcJwzT23VLlU9U1FUmZpNdKQs+iZYJ+mTqde1RU=;
 b=lDaEW0b8a8QEyztPI2f+gZlW5QqU1xAhGuAH1KZ7YxkdiRPTngHh6I1khjmYhswdA+076zvgQKulNqlVLAtFC6WOQqxJ3noWqjMzQlgKY/xu62snSQ90gF4o+Nm3x9Wyvjxi77upuK4bxcH1Lwr9yTBNCOt+9Wpocpg2OuB+GTObUzcmaORU8VQasud6qlDcY2gy1fDJc2P/ciPcgkz0na+gnyUVWkmr6HMiRJe8hHxgcprI0MukzZ9xkK2lDsfUZ9QR4WSu54lu8GMkG7O8TYgWpp+LORqyi7/9n+yQ/KwEena45fvQsRDsGDUsQIAEz8Ect9RbWZ+Lgn/Pn5YfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neDwzcJwzT23VLlU9U1FUmZpNdKQs+iZYJ+mTqde1RU=;
 b=OZp1AYDnrAex6H+64tY4vZEF2ERrX0aUYF9iMFaNk82cEy0Q7QX+vJvs6in8QaauXzydpIpdG7kJdX7q90dkV2u7Lb6YmR1pIZG53kCBdO5NVsiWkFfnWSs+Bnta9mNYJRoBo6HFxnd/Qtv9hbzvSD2HQiNssWceseuzFuKhyrhUJbaUJz0VjqcWU8BOVjv6275kTqwG0irGu0686rTCsmRJBEacXX7ATaMKfRne4I0TCThPCp+OfW5LD39BfjRv5Q9rPoPYv0YwjpGcswk3b4jmljqHFOWBdu2KWYhp51MiY6QvuwedgPhW/02aeRFAuIi7/o5ni0qUYxadSszR9w==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM9P191MB1367.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 09:45:56 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09%7]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 09:45:56 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 2/2] Add test for using sign_hash API
Date:   Wed,  6 Jan 2021 10:43:35 +0100
Message-Id: <20210106094335.3178261-3-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106094335.3178261-1-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:daf9:2c4e:f3f0:a740]
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.home.puiterwijk.org (2a10:3781:662:0:daf9:2c4e:f3f0:a740) by AM0PR02CA0202.eurprd02.prod.outlook.com (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 09:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1536064-089e-4d9c-40b5-08d8b227dd6a
X-MS-TrafficTypeDiagnostic: AM9P191MB1367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P191MB13679A30583BB1D54F389F87C8D00@AM9P191MB1367.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NIQKqmnX6KBSutG42hjI1LSHv4YPwrp+vdOaRnYhrsNgF2QUtqmruwPaB8DJh2pKDs+seBkrJR40B3UhJh/WKn5u5cxJhCipgE9FUsuFPeKrM9I1BkCQ6Kpm0BrKkuG0DkuggjRYwep6iogG6ACXEBbbk1GU92FuCytxBjMa6KuRhUx61Es+Hejd+9OxE0DueZVITelqekal1iB4NvL4XJQEjdhEJ6+Xm6+E8usVz/x7JXar4Fbf3To4PFW1EbFH1+Zietw6RFNpT80RV+BCiK9ShuXwYx3w3tW2t+hkvE0XjcWvSWaUqS3HHQENbceU34WWCoyNI+qN40KT2bnF7DxjnbJNxqLBzEXfJ5rLJzaw8o2sZi689C4dg66G7nLvd53rkXwpUnWhsckLk/sfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39830400003)(376002)(346002)(6486002)(16526019)(186003)(83380400001)(36756003)(316002)(52116002)(8936002)(7696005)(107886003)(4326008)(6666004)(86362001)(2906002)(1076003)(2616005)(66556008)(66476007)(66946007)(478600001)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jTzJ4jIqcVj5+wP7AISqYw7JjI5zevxUSjjOVZDqyWbSIxsQKztbsXpyJuaZ?=
 =?us-ascii?Q?VsYQCLrLQ5eEPBvU76iOy29UeUHnyxBqDPwFZ1iILSXvLhfekNtgY3WAFQQS?=
 =?us-ascii?Q?g0OC8oKzV9/1wKaVr/0XNBSWNfiTpJWWjkIaMKv88AoaWep2GLzAtxXIZRPT?=
 =?us-ascii?Q?wYTajQn4iT+MFWMKbl0/OVdtMRIwa9/CfAwORj0jRKJGCJ0MNdteZLLkV2D/?=
 =?us-ascii?Q?JlNCTsKiCiJ6tCXTEsSVBdDNjcWy5eObrHOG6ml0epbWrlJ3xPHQYMi6GWI8?=
 =?us-ascii?Q?pITYtCj9//A0Hg16UPOrw3Dfqgw7L8eIQLfU0aknmUnvJGVPWFAoTlKmCiMT?=
 =?us-ascii?Q?yYoZsXdZUIkH5V40V3zstGJQmsyQzBV1qIz1K0kRoMr7h2UbnG0vBJQRJJ7z?=
 =?us-ascii?Q?FxfeOEiTfZE9C8F5TkWWSRAyBr1OB2kKphLKpvH2kmQwU91jKWKIRHS5sP32?=
 =?us-ascii?Q?MXPo3YOcfytkAIRNCq/f7oKA4Km09XnrfZGfEtqLmMoKnGTV79Y7TbwS60j2?=
 =?us-ascii?Q?RlcCcwPSXEEFQ2GK0dzNamuOONPLt+9NeBKUoSEzXBgSEmLYC01yLUKgfO6U?=
 =?us-ascii?Q?GRbKikbXunmHxeYb7kD2zr6GQs7oX+TYcByxQygvVOAIF0eWwEQn2ahp0TGn?=
 =?us-ascii?Q?x0GfBTxcOhplHEbXqB9m4gXiee+svuyw0FjN7desywONTo+5+096nIg2/DRG?=
 =?us-ascii?Q?xRW2IZXL1rAfSh0IydNqH5p7tgOp+TTS6+1IwdjmnUCPxAaSGIzjzpWf1w+B?=
 =?us-ascii?Q?f51VILOLO2nUlicz4Q8zMaGqenZoSQ29c0yGX6J/94I+vueJtzIIu8T3tzQR?=
 =?us-ascii?Q?UcjXpIcTXMj+mvqFNrj0mV7SpOXV1XpEkxz1v4IXx9qsZekQQCGiEt0s8lSW?=
 =?us-ascii?Q?dsQstyS9EvpVIUg3PPcpJb5+GmhMNnKQsStnChuqxnENfx/QRsGOnrKMHnvx?=
 =?us-ascii?Q?5L8YuWDF/yVFKKADXAwTUr9DDOGRKHtmv390hxLRSD3XskLf+DRA0DquLHqd?=
 =?us-ascii?Q?xKcOxSFl/UgQ50NT3pXGNeY7MwAeTgsN8DDy/eKmVqdqM+Y=3D?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 09:45:55.9877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-Network-Message-Id: d1536064-089e-4d9c-40b5-08d8b227dd6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXbUEwEy/IvApjd3j0uniWn8k41R5hb3TxmYQIj4Q2X5asR7+XA2uFl03pIl7DpkmrQlqDvn6awAwtgNptKYNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1367
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This adds a test with a small program that calls the sign_hash API, to
ensure that that codepath works.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
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
index 1815f55..bb51688 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -165,29 +165,6 @@ struct tpm_bank_info {
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
index fbb6a4b..6b99e78 100644
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
+	if (!fp) {
+		return -1;
+	}
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
index 0000000..20e2160
--- /dev/null
+++ b/tests/sign_verify.apitest.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * sign_verify.apitest: Test program for verifying sign_hash
+ *
+ * Copyright (C) 2020 Patrick Uiterwijk <patrick@puiterwijk.org>
+ * Copyright (C) 2013,2014 Samsung Electronics
+ * Copyright (C) 2011,2012,2013 Intel Corporation
+ * Copyright (C) 2011 Nokia Corporation
+ * Copyright (C) 2010 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/types.h>
+#include <attr/xattr.h>
+
+#include "../src/imaevm.h"
+#include "../src/utils.h"
+
+int main(int argc, char **argv) {
+	unsigned char hash[MAX_DIGEST_SIZE];
+	unsigned char sig[MAX_SIGNATURE_SIZE];
+	int len, err;
+    char *file = argv[1];
+    char *key = argv[2];
+    char *algo = argv[3];
+    char *digest = argv[4];
+
+    len = strlen(digest) / 2;
+    if (hex2bin(hash, digest, len) != 0) {
+        fprintf(stderr, "Error during hex2bin\n");
+        return 1;
+    }
+
+    len = sign_hash(algo, hash, len, key, NULL, sig + 1);
+	if (len <= 1) {
+        fprintf(stderr, "Error signing\n");
+        return 1;
+    }
+
+	/* add header */
+	len++;
+	sig[0] = EVM_IMA_XATTR_DIGSIG;
+
+    bin2file(file, "sig", sig, len);
+
+    err = lsetxattr(file, "user.ima", sig, len, 0);
+    if (err < 0) {
+        log_err("setxattr failed: %s\n", file);
+        return 1;
+    }
+
+	return 0;
+}
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 288e133..e909d01 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -65,14 +65,14 @@ _keyid_from_cert() {
 
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
@@ -112,11 +112,13 @@ _evmctl_sign() {
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
@@ -124,12 +126,14 @@ _evmctl_sign() {
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
@@ -267,6 +271,20 @@ sign_verify() {
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
2.26.2

