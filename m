Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39D23E5C11
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbhHJNqZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:46:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241830AbhHJNqY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:46:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADYiNR005982
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h3+vniPVVvo94IM2IwxDGeOLsXKRGB+ucSBh0s23ptA=;
 b=brsmzmYkE62nIhQjz0JYK+UZwztByQ+EnktZzGgquMkcONl73K/CssJt02FXjp1bWQfM
 zB+JLTbJ1TLVO2NcNACkvz67bgN6EfLed1JSUr9G1pVgSdIZj7hRioHylVawQYfjCu0I
 S2KNmEMIyZpEk60uEpx72K0R/4ZPUB5javHyb7zDkW8pu6+k51GBQT8DHPKERkXrYGNp
 ucx0Vx0XeuwJUkiA6+raSVaowVgXt9B5i9Ft6Y/5rRM+AsHlbEr7W34ySXp0mIFWL+dA
 FuAsS4cB7k/icqmm3wpXrmqzCy2vzMdm4EwoN2TG98iX0IybKX+ZWhvhC20hchFHEHZW xQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aam0n4gy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:46:02 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADfvKO018806
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3a9htcuf90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:46:01 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxav41681366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A9BCB2081;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A2ABB2080;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 6/8] libimaevm: Add support for pkcs11 private keys for signing a v2 hash
Date:   Tue, 10 Aug 2021 09:45:55 -0400
Message-Id: <20210810134557.2444863-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I4S6kJ2OgLlxvUiMdxX9f_lIvfZHLzCI
X-Proofpoint-ORIG-GUID: I4S6kJ2OgLlxvUiMdxX9f_lIvfZHLzCI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
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

