Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4884E35553A
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Apr 2021 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhDFNdl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Apr 2021 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhDFNdj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Apr 2021 09:33:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F0CC06174A
        for <linux-integrity@vger.kernel.org>; Tue,  6 Apr 2021 06:33:31 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id k8so10380557pgf.4
        for <linux-integrity@vger.kernel.org>; Tue, 06 Apr 2021 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eq1J0x+uPrnChExmxy8p/1XZSJwfhF7tuMhKMHcRZZQ=;
        b=jbp9pBkEyb90MEIaLpxebhgELBP8l41ocCZ4ixcrM/juskZ3EIAxOb3/qCyFgqwtLP
         j//znZuYs9d1SwJwniKIPGaFq4z1ZvUZw1LkL9kf2DvECWCubyk3fHv0Pl8so16T/wId
         /EAEa/MKXZt3baOea9i1G7/u1047RGBIc88WfXXJjJUb67xHuG/Y2a4DBS8WLVHoRsrQ
         4hIximZj4IcoI/l+w+eLESQtfUFp4RUXxkRXWiWgjJqz9GBezpS9c/WuzVWm3daZFq/x
         lYrvgzdouS+bYKAPN5ksbpviXf5zVKDdBOM1zDDymwSdS/v067UQ83mKSVSd5DSQvGlO
         H1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eq1J0x+uPrnChExmxy8p/1XZSJwfhF7tuMhKMHcRZZQ=;
        b=hliDJ3uv7fiuxAl+c/poA045X8n2CZTViKHuX/j7GJDh8F2LLmaluNjC5d70rnmBkn
         Nps3hld+Ys90xXbHpBbTsuCuvasz1EHL3p0dYjJkYXvAVBo6rs2mAYk15fsLQ142a2+0
         z3aWqP0OMoEa4mQwZZ1LDZ260h3j/k3uzyIpYIqjzoySWX6+GzJrvfiSWud2gVE9igWB
         yvf0ER1YJoLpknZ6X5W39cXRSkc2JkPoKCt5cYvCkUOmWs/AqFlOlKJsRw7abxTjL7fy
         VkkRkmExm61YsKumfLJAfkwaZIY+vnI1AY8RlydmuOX1tScNsOw+gY+AdsAcpf2R+GsY
         2JFg==
X-Gm-Message-State: AOAM531ZzvPZoy5z8wMcRolob59xIFI3UQA8hzMdiApyQVL385XP2cms
        0ejo2xe6d1JKm8vJQIMEw8c=
X-Google-Smtp-Source: ABdhPJwwxdF/RCaIDgdOworM5pfKwDYA23XjIr80sTOGi35QimVUuzEnbqEZ6xG7ffcbd1EYkP0tNg==
X-Received: by 2002:a63:e515:: with SMTP id r21mr26867389pgh.412.1617716010663;
        Tue, 06 Apr 2021 06:33:30 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 144sm18723866pfy.75.2021.04.06.06.33.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:33:30 -0700 (PDT)
From:   Hongbo Li <herbert.tencent@gmail.com>
To:     zohar@linux.ibm.com, herberthbli@tencent.com
Cc:     linux-integrity@vger.kernel.org, herbert@gondor.apana.org.au,
        Hongbo Li <herbert.tencent@gmail.com>
Subject: [PATCH] rsa: add pss encoding support
Date:   Tue,  6 Apr 2021 21:32:54 +0800
Message-Id: <1617715974-29632-1-git-send-email-herbert.tencent@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support for rsa with pss encoding.
Add two new params: encoding and saltlen.

Signed-off-by: Hongbo Li <herbert.tencent@gmail.com>
---
 src/evmctl.c    | 19 +++++++++++++++++--
 src/imaevm.h    |  2 ++
 src/libimaevm.c | 22 ++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..bff1dc2 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2440,6 +2440,8 @@ static void usage(void)
 	printf(
 		"\n"
 		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512, streebog256, streebog512\n"
+		"  -e, --encoding     pkcs1 (default), pss\n"
+		"  -l, --saltlen      pss salt lenght, digest length is used by default\n"
 		"  -s, --imasig       make IMA signature\n"
 		"  -d, --imahash      make IMA hash\n"
 		"  -f, --sigfile      store IMA signature in .sig file instead of xattr\n"
@@ -2500,6 +2502,8 @@ static struct option opts[] = {
 	{"imasig", 0, 0, 's'},
 	{"imahash", 0, 0, 'd'},
 	{"hashalgo", 1, 0, 'a'},
+	{"encoding", 1, 0, 'e'},
+	{"saltlen", 1, 0, 'l'},
 	{"pass", 2, 0, 'p'},
 	{"sigfile", 0, 0, 'f'},
 	{"uuid", 2, 0, 'u'},
@@ -2567,7 +2571,7 @@ static char *get_password(void)
 
 int main(int argc, char *argv[])
 {
-	int err = 0, c, lind;
+	int err = 0, c, lind, val;
 	ENGINE *eng = NULL;
 
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
@@ -2581,7 +2585,7 @@ int main(int argc, char *argv[])
 	g_argc = argc;
 
 	while (1) {
-		c = getopt_long(argc, argv, "hvnsda:op::fu::k:t:ri", opts, &lind);
+		c = getopt_long(argc, argv, "hvnsda:e:l:op::fu::k:t:ri", opts, &lind);
 		if (c == -1)
 			break;
 
@@ -2607,6 +2611,17 @@ int main(int argc, char *argv[])
 		case 'a':
 			imaevm_params.hash_algo = optarg;
 			break;
+		case 'e':
+			imaevm_params.encoding = optarg;
+			break;
+		case 'l':
+			val = atoi(optarg);
+			if (val <= 0) {
+				log_err("invalid pss salt len\n");
+				exit(1);
+			}
+			imaevm_params.saltlen = val;
+			break;
 		case 'p':
 			if (optarg)
 				imaevm_params.keypass = optarg;
diff --git a/src/imaevm.h b/src/imaevm.h
index 4503919..4e2dc3a 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -194,6 +194,8 @@ struct libimaevm_params {
 	int verbose;
 	int x509;
 	const char *hash_algo;
+	const char *encoding;
+	uint32_t saltlen;
 	const char *keyfile;
 	const char *keypass;
 };
diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..1bf6c67 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -530,6 +530,13 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
+
+	if (imaevm_params.encoding &&
+	    !strcmp(imaevm_params.encoding, "pss")) {
+		if (EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_PSS_PADDING) <= 0)
+			goto err;
+	}
+
 	st = "EVP_PKEY_verify";
 	ret = EVP_PKEY_verify(ctx, sig + sizeof(*hdr),
 			      siglen - sizeof(*hdr), hash, size);
@@ -895,6 +902,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	size_t sigsize;
 	const char *st;
 	uint32_t keyid;
+	int saltlen;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -947,6 +955,20 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	st = "EVP_PKEY_CTX_set_signature_md";
 	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
 		goto err;
+
+	if (imaevm_params.encoding &&
+	    !strcmp(imaevm_params.encoding, "pss")) {
+		if (EVP_PKEY_CTX_set_rsa_padding(ctx, RSA_PKCS1_PSS_PADDING) <= 0)
+			goto err;
+
+		if (imaevm_params.saltlen)
+			saltlen = imaevm_params.saltlen;
+		else
+			saltlen = -1;
+		if (EVP_PKEY_CTX_set_rsa_pss_saltlen(ctx, saltlen) <= 0)
+			goto err;
+	}
+
 	st = "EVP_PKEY_sign";
 	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
 	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
-- 
1.8.3.1

