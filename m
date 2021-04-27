Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A203B36CBB0
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Apr 2021 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbhD0TcW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 15:32:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238041AbhD0TcW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 15:32:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RJ4A5Y130970
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LDKkOg/Fk2QpDkpYT73sJMf9NcWBkYigjl+7a2zRCBI=;
 b=nLAASJY0OoV4GVY8sjtfuLQWrG+ucvKc6Beyza96VbtGvVoQrZeJouuNF8MyroNwhn9s
 oN7N7RapatUjXLrtTa79/rY4noUt1gQiUw9IX2hmLr5DvaEZnW4xfksh5qqvttDQcZGS
 scuvn6znNgAiGb4r7PFScAcA49Bnn0bbsWSipIXp9IPNhk4aefbyTgd6gc19g56N+Cpy
 82OKy8Hb62A+fZGQp4VD1fWKI2AirN0Roed0jEylJ/glA6XA3jnZf4p1N149ajIqRj6I
 mudQHaJu8G9VuJYtbMsPDU/ahjfio4BEWpz00ZTCmO71q2R97+p98P8iiOcVG78PYn2g AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386qursm70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13RJ4ivg133046
        for <linux-integrity@vger.kernel.org>; Tue, 27 Apr 2021 15:31:38 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 386qursm6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 15:31:38 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13RJNIpV018317;
        Tue, 27 Apr 2021 19:31:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 384qdj1h40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Apr 2021 19:31:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13RJVaZE32702766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Apr 2021 19:31:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 077C6AE064;
        Tue, 27 Apr 2021 19:31:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC8DAAE063;
        Tue, 27 Apr 2021 19:31:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Apr 2021 19:31:35 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/3] libimaevm: Implement imaevm_create_ima_signature
Date:   Tue, 27 Apr 2021 15:31:31 -0400
Message-Id: <20210427193133.1718367-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427193133.1718367-1-stefanb@linux.ibm.com>
References: <20210427193133.1718367-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DCSBiRV8O1q5xyoXBSnWUhUVB0tvbmOk
X-Proofpoint-GUID: ZhCc-Em4YoN9YIrlhzIHkbwIwolofISe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_11:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270126
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement imaevm_create_ima_signature that creates an IMA V2 signature
with a given private key and without writing the signature into an
extended attribute. This allows a caller to provide a single key for
creating a signature on multiple files without having to read the key
every time. It also allows the caller to store the signature wherever
it wants, which may not necessarily be an extended attribute.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---

v2:
 - use imaevm_calc_hash to also cover hash calculations of links,
   directories etc.
---
 src/imaevm.h    |   2 +
 src/libimaevm.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 4503919..fc4536b 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -225,5 +225,7 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen, unsig
 void init_public_keys(const char *keyfiles);
 int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
+int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey, const char *algo,
+                                unsigned char *sig, size_t siglen, char **error);
 
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..c4841c5 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -44,9 +44,11 @@
 #include <sys/types.h>
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <sys/mman.h>
 #include <asm/byteorder.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <fcntl.h>
 #include <string.h>
 #include <stdio.h>
 #include <assert.h>
@@ -238,7 +240,7 @@ static int add_dev_hash(struct stat *st, EVP_MD_CTX *ctx)
 	return !EVP_DigestUpdate(ctx, &dev, sizeof(dev));
 }
 
-int ima_calc_hash(const char *file, uint8_t *hash)
+static int imaevm_calc_hash(const char *file, uint8_t *hash, const char *hash_algo)
 {
 	const EVP_MD *md;
 	struct stat st;
@@ -259,10 +261,9 @@ int ima_calc_hash(const char *file, uint8_t *hash)
 		goto err;
 	}
 
-	md = EVP_get_digestbyname(imaevm_params.hash_algo);
+	md = EVP_get_digestbyname(hash_algo);
 	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n",
-			imaevm_params.hash_algo);
+		log_err("EVP_get_digestbyname(%s) failed\n", hash_algo);
 		err = 1;
 		goto err;
 	}
@@ -313,6 +314,10 @@ err:
 	return err;
 }
 
+int ima_calc_hash(const char *file, uint8_t *hash) {
+	return imaevm_calc_hash(file, hash, imaevm_params.hash_algo);
+}
+
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
@@ -879,6 +884,109 @@ out:
 	return len;
 }
 
+/* Sign a hash with the given private key.
+ *
+ * @algo: Name of the algorithm that was used to compute the hash, e.g. "sha256"
+ * @hash: The hash
+ * @size: Size of the hash
+ * @pkey: Private key to use for signing
+ * @sig: Buffer for the signature; it is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
+ * @siglen: Length of the signature buffer; it must be at least (MAX_SIGNATURE_SIZE - 1)
+ *          to be accepted
+ * @error: Pointer where a buffer with the error to report can be returned
+ *
+ * Returns -1 on error, the length of the signature, including header, otherwise
+ */
+static int sign_hash_v2_pkey(const char *algo, const unsigned char *hash,
+			     int size, EVP_PKEY *pkey, unsigned char *sig, size_t siglen,
+			     char **error)
+{
+	struct signature_v2_hdr *hdr;
+	EVP_PKEY_CTX *ctx = NULL;
+	const char *st = NULL;
+	const EVP_MD *md;
+	size_t sigsize;
+	uint32_t keyid;
+	char name[20];
+	int len = -1;
+
+	if (!hash) {
+		asprintf(error, "sign_hash_v2_pkey: hash is null");
+		return -1;
+	}
+
+	if (size < 0) {
+		asprintf(error, "sign_hash_v2_pkey: size is negative: %d", size);
+		return -1;
+	}
+
+	if (!pkey) {
+		asprintf(error, "sign_hash_v2_pkey: pkey is null");
+		return -1;
+	}
+
+	if (!sig) {
+		asprintf(error, "sign_hash_v2_pkey: sig is null");
+		return -1;
+	}
+
+	if (siglen < MAX_SIGNATURE_SIZE - 1) {
+		asprintf(error, "sign_hash_v2_pkey: siglen must be at least %d bytes\n",
+		         MAX_SIGNATURE_SIZE - 1);
+		return -1;
+	}
+
+	if (!algo) {
+		asprintf(error, "sign_hash_v2_pkey: algo is null");
+		return -1;
+	}
+
+	hdr = (struct signature_v2_hdr *)sig;
+	hdr->version = (uint8_t) DIGSIG_VERSION_2;
+
+	hdr->hash_algo = imaevm_get_hash_algo(algo);
+	if (hdr->hash_algo == (uint8_t)-1) {
+		asprintf(error, "sign_hash_v2_pkey: hash algo is unknown: %s", algo);
+		return -1;
+	}
+
+	calc_keyid_v2(&keyid, name, pkey);
+	hdr->keyid = keyid;
+
+	st = "EVP_PKEY_CTX_new";
+	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
+		goto err;
+	st = "EVP_PKEY_sign_init";
+	if (!EVP_PKEY_sign_init(ctx))
+		goto err;
+	st = "EVP_get_digestbyname";
+	if (!(md = EVP_get_digestbyname(algo)))
+		goto err;
+	st = "EVP_PKEY_CTX_set_signature_md";
+	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+		goto err;
+	st = "EVP_PKEY_sign";
+	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
+	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+		goto err;
+	st = NULL;
+
+	len = (int)sigsize;
+
+	/* we add bit length of the signature to make it gnupg compatible */
+	hdr->sig_size = __cpu_to_be16(len);
+	len += sizeof(*hdr);
+
+err:
+	if (len == -1 && st != NULL) {
+		asprintf(error, "sign_hash_v2_pkey: signing failed: (%s) in %s",
+			ERR_reason_error_string(ERR_peek_error()), st);
+	}
+	EVP_PKEY_CTX_free(ctx);
+
+	return len;
+}
+
 /*
  * @sig is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
  * Return: -1 signing error, >0 length of signature
@@ -980,6 +1088,33 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
 }
 
+/*
+ * Create an IMA signature for a given file using a given private key for signing
+ *
+ * @filename: Name of the file to sign
+ * @pkey: Private key to use for signing
+ * @hash_algo: Name of the algorithm to use to compute the hash, e.g. "sha256"
+ * @sig: Buffer for the signature; it is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
+ * @siglen: Length of the signature buffer; it must be at least (MAX_SIGNATURE_SIZE - 1)
+ *          to be accepted
+ * @error: Pointer where a buffer with the error to report can be returned
+ *
+ * Returns -1 on error, the length of the signature, including header, otherwise
+ */
+int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey, const char *hash_algo,
+                                unsigned char *sig, size_t siglen, char **error)
+{
+	unsigned char hash[MAX_DIGEST_SIZE];
+	int hashlen;
+
+	hashlen = imaevm_calc_hash(filename, hash, hash_algo);
+	if (hashlen <= 1)
+		return hashlen;
+	assert(hashlen <= sizeof(hash));
+
+	return sign_hash_v2_pkey(hash_algo, hash, hashlen, pkey, sig, siglen, error);
+}
+
 static void libinit()
 {
 
-- 
2.30.2

