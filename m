Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF23E30AB29
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhBAPYc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 10:24:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11202 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230436AbhBAPUK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 10:20:10 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111F2OU0182056;
        Mon, 1 Feb 2021 10:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XkFDbQLhTIFupP+vfDZ32Gfx1EJZyZA7D1DfhWtCCWE=;
 b=K/7CBWT3NS0psRKhmJlz4q1A93Cf4GksCGzPddAZf29wYiEJJMyTZU7tPqSX0an3YF3M
 56OZwWE2QXRPPk+TLndyO8PpDN4TbKf99p95QmbVlb76T+u5vDPNDBmtUVzNFGE0Zz0T
 WLplKPh+21V7+nl67cDdz0nExXO3V710wDAoIF9veFLU+CGc0mC8xu0R7QNxKKl95Uw7
 A7JNalluchW2Vp7pc7Isch/0UZCqnyBr4+XAXN4AfzGjBw8em+5aUpAbu4axhlHy8mqI
 OEWNlraRiBaK5OH6reVT30Tz5q2OGcAXdCXyBtcmaeIesveYA7YWEHHTq8+O4IpRzWcs 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ekm8h3fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:24 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111F2WQb182737;
        Mon, 1 Feb 2021 10:19:23 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ekm8h3ew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 10:19:23 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111FC1Zk008194;
        Mon, 1 Feb 2021 15:19:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 36cy3934qj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 15:19:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111FJKvL8257794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 15:19:20 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 343D26E05D;
        Mon,  1 Feb 2021 15:19:20 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6420A6E058;
        Mon,  1 Feb 2021 15:19:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 15:19:19 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 3/4] x509: Add support for parsing x509 certs with ECDSA keys
Date:   Mon,  1 Feb 2021 10:19:09 -0500
Message-Id: <20210201151910.1465705-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201151910.1465705-1-stefanb@linux.ibm.com>
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010077
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch adds support for parsing of x509 certificates that contain
ECDSA keys, such as NIST P256, that have been signed by a CA using any
of the current SHA hash algorithms.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org
---
 crypto/asymmetric_keys/public_key.c       | 19 ++++++++++++++
 crypto/asymmetric_keys/x509_cert_parser.c | 32 ++++++++++++++++++++++-
 include/linux/oid_registry.h              |  2 ++
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 8892908ad58c..7dae61b79d5a 100644
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
@@ -90,6 +91,24 @@ int software_key_determine_akcipher(const char *encoding,
 		return 0;
 	}
 
+	if (strcmp(encoding, "x962") == 0) {
+		enum OID oid;
+
+		if (parse_OID(pkey->params, pkey->paramlen, &oid) != 0)
+			return -EBADMSG;
+
+		switch (oid) {
+		case OID_id_prime192v1:
+			strcpy(alg_name, "ecdsa-nist-p192");
+			return 0;
+		case OID_id_prime256v1:
+			strcpy(alg_name, "ecdsa-nist-p256");
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	}
+
 	return -ENOPKG;
 }
 
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 1621ceaf5c95..0aff4e584b11 100644
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
@@ -478,6 +504,10 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 		case OID_sm2:
 			ctx->cert->pub->pkey_algo = "sm2";
 			break;
+		case OID_id_prime192v1:
+		case OID_id_prime256v1:
+			ctx->cert->pub->pkey_algo = "ecdsa";
+			break;
 		default:
 			return -ENOPKG;
 		}
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

