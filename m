Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759A5365F44
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhDTSbF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 14:31:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233544AbhDTSbC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 14:31:02 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KI49SD044718
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aq5UiTdJUra2Q3b0BEH0WkPybytkuZAIYjlVbTGdlGA=;
 b=P0+uzN/b55uovIAW2CJOBocbDQOYDwaXwi/xGeBg6s+EiosYs+/GnI7fWHgcTHxJ8GVV
 C+GjufQMCAZbPhj7nlMlNGWI337xjtKdjk9KglV1DnFc/WVCTElmWz9kWMnyWrjE/JCn
 TjjUiIlMuj4YJTLbnz7reU+T3M27Nayoz2hbu6LxmhGbSF3A9FZB4uJ5KJ/d3s8WamaY
 jWm9BeHPYOPJEBzbyOIYE3shxof1EvFo8jEoTV7nfZ36eL4fdl0UKMWA6A4yFDwzp30+
 sc7qENT4YEYL0+K2LTGcxvNqlpZViHaeieq8YorpyKVbCMKy4qcY6UMoD8fEKPDdM8E8 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3821xhcve7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:24 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KI4ICW046001
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:23 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3821xhcvdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 14:30:23 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KIMnJh006484;
        Tue, 20 Apr 2021 18:30:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 37yqa948ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 18:30:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KIUMNv22741266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 18:30:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F0AA6E04E;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BACED6E053;
        Tue, 20 Apr 2021 18:30:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 18:30:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/3] libimaevm: Implement imaevm_create_ima_signature
Date:   Tue, 20 Apr 2021 14:30:13 -0400
Message-Id: <20210420183015.861644-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183015.861644-1-stefanb@linux.ibm.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FOxuDEDhFsAI-WEuQ8nC_Peq__mHXr-r
X-Proofpoint-ORIG-GUID: 6W6wip80L1M-X0aYp00Xi8TZlTToLU8Z
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_08:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200123
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
 src/imaevm.h    |   2 +
 src/libimaevm.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

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
index fa6c278..bb425af 100644
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
@@ -879,6 +881,109 @@ out:
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
@@ -980,6 +1085,87 @@ int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const c
 		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
 }
 
+/*
+ * Create an IMA signature for a given file using a given private key for signing
+ *
+ * @filename: Name of the file to sign
+ * @pkey: Private key to use for signing
+ * @algo: Name of the algorithm to use to compute the hash, e.g. "sha256"
+ * @sig: Buffer for the signature; it is assumed to be of (MAX_SIGNATURE_SIZE - 1) size
+ * @siglen: Length of the signature buffer; it must be at least (MAX_SIGNATURE_SIZE - 1)
+ *          to be accepted
+ * @error: Pointer where a buffer with the error to report can be returned
+ *
+ * Returns -1 on error, the length of the signature, including header, otherwise
+ */
+int imaevm_create_ima_signature(const char *filename, EVP_PKEY *pkey, const char *algo,
+                                unsigned char *sig, size_t siglen, char **error)
+{
+	unsigned char hashbuf[EVP_MAX_MD_SIZE];
+	unsigned int hashbuf_size = sizeof(hashbuf);
+	struct stat statbuf;
+	EVP_MD_CTX *md_ctx;
+	const EVP_MD *md;
+	const char *st = NULL;
+	int len = -1;
+	void *addr = NULL;
+	int fd;
+	int n;
+
+	fd = open(filename, O_RDONLY);
+	if (!fd) {
+		asprintf(error, "Failed to open %s: %s", filename, strerror(errno));
+		return -1;
+	}
+
+	n = fstat(fd, &statbuf);
+	if (n != 0) {
+		asprintf(error, "Failed to stat %s: %s", filename, strerror(errno));
+		goto err_close;
+	}
+
+	if (statbuf.st_size > 0) {
+		addr = mmap(NULL, statbuf.st_size, PROT_READ, MAP_SHARED, fd, 0);
+		if (addr == MAP_FAILED) {
+			asprintf(error, "Failed to mmap file: %s", strerror(errno));
+			goto err_close;
+		}
+	}
+
+	st = "EVP_MD_CTX_new";
+	if (!(md_ctx = EVP_MD_CTX_new()))
+		goto err;
+	st = "EVP_get_digestbyname";
+	if (!(md = EVP_get_digestbyname(algo)))
+		goto err;
+	st = "EVP_DigestInit_ex";
+	if (EVP_DigestInit_ex(md_ctx, md, NULL) != 1)
+		goto err;
+	st = "EVP_DigestUpdate";
+	if (statbuf.st_size > 0 && EVP_DigestUpdate(md_ctx, addr, statbuf.st_size) != 1)
+		goto err;
+	st = "EVP_DigestFinal_ex";
+	if (EVP_DigestFinal_ex(md_ctx, hashbuf, &hashbuf_size) != 1)
+		goto err;
+	st = NULL;
+
+	len = sign_hash_v2_pkey(algo, hashbuf, hashbuf_size, pkey, sig, siglen, error);
+
+err:
+	if (len < 0 && st != NULL) {
+		asprintf(error,
+			 "%s: signing failed: (%s) in %s\n",
+			 __func__, ERR_reason_error_string(ERR_peek_error()), st);
+	}
+
+	EVP_MD_CTX_free(md_ctx);
+	munmap(addr, statbuf.st_size);
+err_close:
+	close(fd);
+
+	return len;
+}
+
 static void libinit()
 {
 
-- 
2.30.2

