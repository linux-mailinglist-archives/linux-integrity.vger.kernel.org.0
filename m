Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DFF3E4864
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 17:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhHIPLa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 11:11:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235207AbhHIPL3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 11:11:29 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179F9B0V047274
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 11:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=j++DwHVLBiWqes97vfA4qHfxgMDrtX3i+uTU7uTN02M=;
 b=azA9g3WYPgyyE91xhmqTZ8somlik0hkQks2R2N4G66FYvJlCF/TOHLZOrtvxvcu+gCyy
 Ny1Wqa2mINhM68A+IBMbu8JneB0Q/Qt/OzBXogeweRugzHcT7bpi0efhRUqCcNkPu9Lb
 WcLAr9uPquJEIxCXIa+ulrJkFtAG/jBytC5wrDnY7buE7HwRKWAZLr6MnGibxcroWQ2d
 N8Aeucp8zvmr1ARETIQbHXGbDpdAxPHNjsMtWQpPOj3JBnudjilwM0x+QYjXPLfGowhm
 AhK2JJanXcrnXsb0oLxbTYOxuOs8ZMS/gmB5qDm70iBx/ZBtBRF10G2PvKGgh04GwJNS wA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab6rjg3gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 11:11:04 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179F3FAo014173
        for <linux-integrity@vger.kernel.org>; Mon, 9 Aug 2021 15:10:30 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 3a9htauwxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 09 Aug 2021 15:10:30 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179FATZI10421050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 15:10:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 789077E2C9;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673127E2FB;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 15:10:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/4] libimaevm: Add support for pkcs11 private keys for signing a v2 hash
Date:   Mon,  9 Aug 2021 11:10:24 -0400
Message-Id: <20210809151026.195038-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
References: <20210809151026.195038-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bWaOG_RGV0nZtVFOiOLQTBH4QTJGBQ4U
X-Proofpoint-ORIG-GUID: bWaOG_RGV0nZtVFOiOLQTBH4QTJGBQ4U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_05:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090111
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Add support for pkcs11 private keys for signing a v2 hash.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 README          |  1 +
 src/evmctl.c    |  1 +
 src/libimaevm.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 50 insertions(+), 11 deletions(-)

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
index 58f8e66..2e85f8b 100644
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
index 8e96157..b84e5b8 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -60,6 +60,7 @@
 #include <openssl/x509.h>
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
+#include <openssl/engine.h>
 
 #include "imaevm.h"
 #include "hash_info.h"
@@ -803,21 +804,57 @@ static EVP_PKEY *read_priv_pkey(const char *keyfile, const char *keypass)
 {
 	FILE *fp;
 	EVP_PKEY *pkey;
+	ENGINE *e;
 
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
+		ENGINE_load_builtin_engines();
+		e = ENGINE_by_id("pkcs11");
+		if (!e) {
+			log_err("Failed to load pkcs11 engine\n");
+			goto err_pkcs11;
+		}
+		if (!ENGINE_init(e)) {
+			log_err("Failed to initialize the pkcs11 engine\n");
+			goto err_pkcs11;
+		}
+		if (keypass) {
+			if (!ENGINE_ctrl_cmd_string(e, "PIN", keypass, 0)) {
+				log_err("Failed to set the PIN for the private key\n");
+				goto err_pkcs11;
+			}
+		}
+		pkey = ENGINE_load_private_key(e, keyfile, NULL, NULL);
+		if (!pkey) {
+			log_err("Failed to load private key %s\n", keyfile);
+			goto err_pkcs11;
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
+err_pkcs11:
+	ENGINE_free(e);
+	output_openssl_errors();
+	return NULL;
 }
 
 static RSA *read_priv_key(const char *keyfile, const char *keypass)
-- 
2.31.1

