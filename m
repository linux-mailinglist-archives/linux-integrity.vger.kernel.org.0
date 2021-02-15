Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65F31BF3C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Feb 2021 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBOQ2x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Feb 2021 11:28:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230247AbhBOQ0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Feb 2021 11:26:39 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FG3bdw013169;
        Mon, 15 Feb 2021 11:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4elSH7pnromYFTr60I9HvAkv7Kx0HPkXHrcawwxxbsw=;
 b=jyUKEaJClLE1chKTZj7UoslNcRs5Kjm9WE5MJN2S+420weo6+wO08xqYKp4bz2BBpjJR
 d/F7IvwqADdmaNsPiLafHET+agIzZEfiHipk6/aWj/xJmIu1wveUf0H3Tgr4xNxvqMnw
 zom3G7WCgGPz14w1wttmvQj+KrpP6PlRsiMGz/qiL1aTHbImQiqThcegyKtrZW4raZMk
 eTTQztEd6qlGq2DOPVR9J7zYI/gO9xTPpQIzYkE6avDeuzNVzLrNLjg9IEJW+nqzCR8G
 1ZJTVDB6FivPxyG7z9jEYLsDflJzk4+CX6+i60X3bvXo4xc6de5lxk6MSvtXExTGaBY+ Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qutysc9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FG4KgF017194;
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qutysc99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FGLgkY025046;
        Mon, 15 Feb 2021 16:25:49 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 36p6d8r7j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:25:49 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FGPmSm16253320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:25:48 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AEF06A054;
        Mon, 15 Feb 2021 16:25:48 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A549F6A051;
        Mon, 15 Feb 2021 16:25:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Feb 2021 16:25:47 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 3/4] x509: Add support for parsing x509 certs with ECDSA keys
Date:   Mon, 15 Feb 2021 11:25:31 -0500
Message-Id: <20210215162532.1077098-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215162532.1077098-1-stefanb@linux.ibm.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_11:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support for parsing of x509 certificates that contain
ECDSA keys, such as NIST P256, that have been signed by a CA using any
of the current SHA hash algorithms.

Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

v7->v8:
 - do not detect key algo using parse_OID() in public_key.c but set
   pkey_algo to the key type 'ecdsa-nist-p192/256' when parsing cert
---
 crypto/asymmetric_keys/public_key.c       |  4 ++-
 crypto/asymmetric_keys/x509_cert_parser.c | 34 ++++++++++++++++++++++-
 crypto/asymmetric_keys/x509_public_key.c  |  4 ++-
 include/linux/oid_registry.h              |  2 ++
 4 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 788a4ba1e2e7..4fefb219bfdc 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/scatterlist.h>
+#include <linux/asn1.h>
 #include <keys/asymmetric-subtype.h>
 #include <crypto/public_key.h>
 #include <crypto/akcipher.h>
@@ -85,7 +86,8 @@ int software_key_determine_akcipher(const char *encoding,
 		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
 	}
 
-	if (strcmp(encoding, "raw") == 0) {
+	if (strcmp(encoding, "raw") == 0 ||
+	    strcmp(encoding, "x962") == 0) {
 		strcpy(alg_name, pkey->pkey_algo);
 		return 0;
 	}
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 1621ceaf5c95..f5d547c6dfb5 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -227,6 +227,26 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 		ctx->cert->sig->hash_algo = "sha224";
 		goto rsa_pkcs1;
 
+	case OID_id_ecdsa_with_sha1:
+		ctx->cert->sig->hash_algo = "sha1";
+		goto ecdsa;
+
+	case OID_id_ecdsa_with_sha224:
+		ctx->cert->sig->hash_algo = "sha224";
+		goto ecdsa;
+
+	case OID_id_ecdsa_with_sha256:
+		ctx->cert->sig->hash_algo = "sha256";
+		goto ecdsa;
+
+	case OID_id_ecdsa_with_sha384:
+		ctx->cert->sig->hash_algo = "sha384";
+		goto ecdsa;
+
+	case OID_id_ecdsa_with_sha512:
+		ctx->cert->sig->hash_algo = "sha512";
+		goto ecdsa;
+
 	case OID_gost2012Signature256:
 		ctx->cert->sig->hash_algo = "streebog256";
 		goto ecrdsa;
@@ -255,6 +275,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	ctx->cert->sig->encoding = "raw";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
+ecdsa:
+	ctx->cert->sig->pkey_algo = "ecdsa";
+	ctx->cert->sig->encoding = "x962";
+	ctx->algo_oid = ctx->last_oid;
+	return 0;
 }
 
 /*
@@ -276,7 +301,8 @@ int x509_note_signature(void *context, size_t hdrlen,
 
 	if (strcmp(ctx->cert->sig->pkey_algo, "rsa") == 0 ||
 	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0 ||
-	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0) {
+	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0 ||
+	    strcmp(ctx->cert->sig->pkey_algo, "ecdsa") == 0) {
 		/* Discard the BIT STRING metadata */
 		if (vlen < 1 || *(const u8 *)value != 0)
 			return -EBADMSG;
@@ -478,6 +504,12 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_sm2:
 			ctx->cert->pub->pkey_algo = "sm2";
 			break;
+		case OID_id_prime192v1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p192";
+			break;
+		case OID_id_prime256v1:
+			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
+			break;
 		default:
 			return -ENOPKG;
 		}
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index ae450eb8be14..3d45161b271a 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -129,7 +129,9 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 	}
 
 	ret = -EKEYREJECTED;
-	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
+	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0 &&
+	    (strncmp(cert->pub->pkey_algo, "ecdsa-", 6) != 0 ||
+	     strcmp(cert->sig->pkey_algo, "ecdsa") != 0))
 		goto out;
 
 	ret = public_key_verify_signature(cert->pub, cert->sig);
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index f3b2c097c886..ff3cad9f8c1f 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -21,6 +21,8 @@ enum OID {
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
 	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
+	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
+	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
 	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
 	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
 	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
-- 
2.29.2

