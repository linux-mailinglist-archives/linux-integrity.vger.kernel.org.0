Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C05409F8E
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhIMWTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235916AbhIMWTm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:42 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DLEnOk029521
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TIeTJaxwIkIrl4wrTeOV+87sxLJZ2nQUCDb/tSHV6B8=;
 b=OK6+/5g0YrdLBgMP0yJq2x4NdRqK46X6YJyQLMCL23TCDsRdVkdPqME1YfXzuGFsR20k
 vvDQxYCXI2egfPbfJsNqPhLkEWuluVpMdUij54TN1QeEzlKui1pDD49nBQEQiM3CLtyT
 9mILCCV3DdOc8jaNNseINFwlAsuFgaRhLGcPYFTMvAYsxB2gbGXpLkVvqgfW0+uNxOkF
 wZyqkGjfFNEs/VTLRUk+MZBXv8naPLc5ftJINBiCkEPRTeml1cQm9iDjSydGHSIWXK/u
 dA9Wc54WvFwTpRVn8/dUo/BYNr/6MUudqAieRZeIfADkn0iGL1aGZuoDbgxYpxTod9o/ iA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3b24779d1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:25 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHkMc030307
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:24 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01wdc.us.ibm.com with ESMTP id 3b0m392y9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:24 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMINu645285690
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AB4ABE05D;
        Mon, 13 Sep 2021 22:18:23 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06C7ABE061;
        Mon, 13 Sep 2021 22:18:23 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 6/9] libimaevm: Add support for pkcs11 private keys for signing a v2 hash
Date:   Mon, 13 Sep 2021 18:18:10 -0400
Message-Id: <20210913221813.2554880-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 06pZnJ7-amwpgjszupLN7ePdaSV4MQfm
X-Proofpoint-ORIG-GUID: 06pZnJ7-amwpgjszupLN7ePdaSV4MQfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130063
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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

