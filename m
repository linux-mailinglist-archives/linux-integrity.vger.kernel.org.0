Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867FB403FC5
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhIHTY4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 15:24:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25470 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233358AbhIHTYz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 15:24:55 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188J2eTH025961
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 15:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h3+vniPVVvo94IM2IwxDGeOLsXKRGB+ucSBh0s23ptA=;
 b=V20YIl0ksKZiiwiFEJyVewlURm+faTztggBiF5CzuwV3Q99XybiHKDISrPWgmh3iVtxl
 tFi+Yb3/uHFsVNyuGbx9mMzMzLfogn3JRJ4BWnOlANBqn3KzoVE4biifOdhMPc9W3QDV
 3DFHt1V4QXvgMOl218RUc5jYCMfHNmnJLalAj7L6z/A1wRpHbL+L4aW+tvMS88UF3+Wl
 N5HyzbmHylx3xYKjtwNQkKq/5uOk9UU0IM6dfgyTumrAoOQ3KZbhJCylQO0Nr0mXPoSH
 ai9MnRT2ZGWz1v7xMgwvDa5qq/a1H23qgVTJAqj3+9EP3LCzyp4JEs5P+3Woa8fPqo9a Zg== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axt80fna1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 15:23:47 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188JHLFD026142
        for <linux-integrity@vger.kernel.org>; Wed, 8 Sep 2021 19:23:46 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3axcnqkf6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Sep 2021 19:23:46 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188JNjmK9110244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 19:23:45 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C491112070;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D8F11206B;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 19:23:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 6/9] libimaevm: Add support for pkcs11 private keys for signing a v2 hash
Date:   Wed,  8 Sep 2021 15:23:40 -0400
Message-Id: <20210908192343.4147739-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
References: <20210908192343.4147739-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _7TnjvOaJi2zvr-SiexOca0kvNNQQWU9
X-Proofpoint-ORIG-GUID: _7TnjvOaJi2zvr-SiexOca0kvNNQQWU9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080120
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add support for pkcs11 private keys for signing a v2 hash.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README          |  1 +
 src/evmctl.c    |  1 +
 src/libimaevm.c | 47 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/README b/README
index 1cc027f..2bb363c 100644
--- a/README
+++ b/README
@@ -48,6 +48,7 @@ OPTIONS
       --xattr-user   store xattrs in user namespace (for testing purposes)
       --rsa          use RSA key type and signing scheme v1
   -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
+                     or a pkcs11 URI
       --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)
       --keyid-from-cert file
                      read keyid value from SKID of a x509 cert file
diff --git a/src/evmctl.c b/src/evmctl.c
index 5178643..0a54ac3 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2503,6 +2503,7 @@ static void usage(void)
 		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
 		"      --rsa          use RSA key type and signing scheme v1\n"
 		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
+		"                     or a pkcs11 URI\n"
 		"      --keyid n      overwrite signature keyid with a 32-bit value in hex (for signing)\n"
 		"      --keyid-from-cert file\n"
 		"                     read keyid value from SKID of a x509 cert file\n"
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8e96157..6855184 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -60,6 +60,7 @@
 #include <openssl/x509.h>
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
+#include <openssl/engine.h>
 
 #include "imaevm.h"
 #include "hash_info.h"
@@ -804,20 +805,44 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 	FILE *fp;
 	EVP_PKEY *pkey;
 
-	fp = fopen(keyfile, "r");
-	if (!fp) {
-		log_err("Failed to open keyfile: %s\n", keyfile);
-		return NULL;
-	}
-	pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
-	if (!pkey) {
-		log_err("Failed to PEM_read_PrivateKey key file: %s\n",
-			keyfile);
-		output_openssl_errors();
+	if (!strncmp(keyfile, "pkcs11:", 7)) {
+		if (!imaevm_params.keyid) {
+			log_err("When using a pkcs11 URI you must provide the keyid with an option\n");
+			return NULL;
+		}
+
+		if (keypass) {
+			if (!ENGINE_ctrl_cmd_string(imaevm_params.eng, "PIN", keypass, 0)) {
+				log_err("Failed to set the PIN for the private key\n");
+				goto err_engine;
+			}
+		}
+		pkey = ENGINE_load_private_key(imaevm_params.eng, keyfile, NULL, NULL);
+		if (!pkey) {
+			log_err("Failed to load private key %s\n", keyfile);
+			goto err_engine;
+		}
+	} else {
+		fp = fopen(keyfile, "r");
+		if (!fp) {
+			log_err("Failed to open keyfile: %s\n", keyfile);
+			return NULL;
+		}
+		pkey = PEM_read_PrivateKey(fp, NULL, NULL, (void *)keypass);
+		if (!pkey) {
+			log_err("Failed to PEM_read_PrivateKey key file: %s\n",
+				keyfile);
+			output_openssl_errors();
+		}
+
+		fclose(fp);
 	}
 
-	fclose(fp);
 	return pkey;
+
+err_engine:
+	output_openssl_errors();
+	return NULL;
 }
 
 static RSA *read_priv_key(const char *keyfile, const char *keypass)
-- 
2.31.1

