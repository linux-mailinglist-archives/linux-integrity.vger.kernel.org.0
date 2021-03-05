Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF332DE7A
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 01:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhCEAwV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Mar 2021 19:52:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231467AbhCEAwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Mar 2021 19:52:20 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1250WdTm180995;
        Thu, 4 Mar 2021 19:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vUEseM+aVjVhLaeamkaXjUdpXoah2QfHINEZcnJmkaY=;
 b=KrgZznopM+TrkqP8XYA/3vz/DJYZ7ZSX5qLyb19QGUXIUx12EAzrhZ53u5WQED7Y1QmP
 lmfX3KbUyfsFXtN3UsI0Y073degvJ0L/K0JcCu6f3lEapOeq8BGoBNqf3hfvkXiGOEGv
 TmrBh1WiJbWCrEYWQLxH5J8aQc9c1P6bTjLrSiSEJAzNwtpSYstfrm/30I0n6vJzL7w+
 E/1wUpz/GjxHgZiN7lbn3/2+ArQONQ1unNChz7QWyK0AbkViCGxDllR4jZTRr4NZ141a
 z4aDdqFMnNcbOcNx699G0sImSeW2BMZ2/21I1HUko75k/hTYb2bXgI9sF3x9A1hZmTqy oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373a2cgkxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:15 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1250Wj3F181396;
        Thu, 4 Mar 2021 19:52:14 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 373a2cgkxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 19:52:14 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1250WUt7009505;
        Fri, 5 Mar 2021 00:52:13 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 371b01gnfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 00:52:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1250qC8l11534772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Mar 2021 00:52:12 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 436F8C605A;
        Fri,  5 Mar 2021 00:52:12 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA811C6055;
        Fri,  5 Mar 2021 00:52:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Mar 2021 00:52:11 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v10 6/9] x509: Add support for parsing x509 certs with ECDSA keys
Date:   Thu,  4 Mar 2021 19:52:00 -0500
Message-Id: <20210305005203.3547587-7-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_09:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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
index f32d91895e4d..3583908cf1ca 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -20,6 +20,8 @@ enum OID {
 	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
+	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
+	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
 	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
 	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
-- 
2.29.2

