Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1420552F038
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbiETQLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351573AbiETQLX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 12:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0D11D301
        for <linux-integrity@vger.kernel.org>; Fri, 20 May 2022 09:11:19 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFvYSn025425;
        Fri, 20 May 2022 16:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gi1GSpgjWZSeFPeZ/+t7zcpxDuaJQ+rCFqStyFdpChA=;
 b=QuWwwE0dUP6zmclJEqtwguuRzgw0OAvWGT1F1KPYqkIq5AhxR6NiwK4xTtOeTqA6FjpZ
 9PAgYh3VQwfOHsloJfU/TYSYbkwdmS1ertSIGk7cGAiU1P1yfxJ4caCj6EJ6B6igjRW2
 QuMZvUB6lvMZfuYUv8L1sJICwS1yATAdHN+AwA7hUGCdfYJjvFBUZWkwd6HAUN8aOaDd
 ycIbZvaC/aFJcUyc153QagxmWbyp4NA6as08mpSqsF515F1LvEWgjFC575IlR+73WXQg
 VLPrg9f8Jfr9YNvjJrtJcKixprvFZC7S4zisqrpgCl/UtAcbShAAiHvnUky5rzM6EaLQ LA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g6e3a887q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:17 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24KFql1X023399;
        Fri, 20 May 2022 16:11:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3g2429h2sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:11:15 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24KGBCOa39125404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 May 2022 16:11:12 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA1BF5204E;
        Fri, 20 May 2022 16:11:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.82.251])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 4F3F85204F;
        Fri, 20 May 2022 16:11:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 3/3] Verify an fs-verity file digest based signature
Date:   Fri, 20 May 2022 12:11:03 -0400
Message-Id: <20220520161103.373554-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220520161103.373554-1-zohar@linux.ibm.com>
References: <20220520161103.373554-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HWD1erkWIIx9ZiAP4TaRtY9Ol04L2MmQ
X-Proofpoint-ORIG-GUID: HWD1erkWIIx9ZiAP4TaRtY9Ol04L2MmQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_04,2022-05-20_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205200106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima-evm-utils does not attempt to calculate or even read the fs-verity
file hash, but can verify the fs-verity signature based on the fsverity
file hash, both contained in the measurement list record.

Example:
evmctl ima_measurement --key <DER encoded public key> \
 --verify-sig /sys/kernel/security/ima/binary_runtime_measurements

Modify 'sig' argument of verify_hash() to be the full xattr in order to
differentiate signatures types.

Note:
Kernel commit b1aaab22e263 ("ima: pass full xattr with the signature")
added the 'type' to signature_v2_hdr struct, which hasn't been reflected
here. (todo)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 11 +++++--
 src/libimaevm.c | 77 ++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index c7c8c8cf6e89..6af72255bf72 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -909,7 +909,7 @@ static int verify_evm(const char *file)
 		return mdlen;
 	assert(mdlen <= sizeof(hash));
 
-	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
+	return verify_hash(file, hash, mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
@@ -1574,7 +1574,8 @@ void ima_ng_show(struct template_entry *entry)
 	fieldp += field_len;
 	total_len -= field_len;
 
-	if (!strcmp(entry->name, "ima-sig")) {
+	if (!strcmp(entry->name, "ima-sig") ||
+	    !strcmp(entry->name, "ima-sigv2")) {
 		/* get signature */
 		field_len = *(uint32_t *)fieldp;
 		fieldp += sizeof(field_len);
@@ -1620,11 +1621,17 @@ void ima_ng_show(struct template_entry *entry)
 			log_info(" ");
 			log_dump(sig, sig_len);
 		}
+
+		/*
+		 * Either verify the signature against the hash contained in
+		 * the measurement list or calculate the hash.
+		 */
 		if (verify_list_sig)
 			err = ima_verify_signature(path, sig, sig_len,
 						   digest, digest_len);
 		else
 			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
+
 		if (!err && imaevm_params.verbose > LOG_INFO)
 			log_info("%s: verification is OK\n", path);
 	} else {
diff --git a/src/libimaevm.c b/src/libimaevm.c
index af145bd62ac9..739ace5459e5 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -424,10 +424,21 @@ void init_public_keys(const char *keyfiles)
 }
 
 /*
+ * Verify a signature, prefixed with the signature_v2_hdr, either based
+ * directly or indirectly on the file data hash.
+ *
+ * version 2: directly based on the file data hash (e.g. sha*sum)
+ * version 3: indirectly based on the hash of the struct ima_file_id, which
+ *	      contains the xattr type (enum evm_ima_xattr_type), the hash
+ *	      algorithm (enum hash_algo), and the file data hash
+ *	      (e.g. fsverity digest).
+ *
  * Return: 0 verification good, 1 verification bad, -1 error.
+ *
+ * (Note: signature_v2_hdr struct does not contain the 'type'.)
  */
-static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
-			  unsigned char *sig, int siglen)
+static int verify_hash_common(const char *file, const unsigned char *hash,
+			      int size, unsigned char *sig, int siglen)
 {
 	int ret = -1;
 	EVP_PKEY *pkey, *pkey_free = NULL;
@@ -497,6 +508,39 @@ err:
 	return ret;
 }
 
+/*
+ * Verify a signature, prefixed with the signature_v2_hdr, directly based
+ * on the file data hash.
+ *
+ * Return: 0 verification good, 1 verification bad, -1 error.
+ */
+static int verify_hash_v2(const char *file, const unsigned char *hash,
+			  int size, unsigned char *sig, int siglen)
+{
+	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
+	return verify_hash_common(file, hash, size, sig + 1, siglen - 1);
+}
+
+/*
+ * Verify a signature, prefixed with the signature_v2_hdr, indirectly based
+ * on the file data hash.
+ *
+ * Return: 0 verification good, 1 verification bad, -1 error.
+ */
+static int verify_hash_v3(const char *file, const unsigned char *hash,
+			  int size, unsigned char *sig, int siglen)
+{
+	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
+	int ret;
+
+	ret = calc_hash_sigv3(sig[0], NULL, hash, sigv3_hash);
+	if (ret < 0)
+		return ret;
+
+	/* note: signature_v2_hdr does not contain 'type', use sig + 1 */
+	return verify_hash_common(file, sigv3_hash, size, sig + 1, siglen - 1);
+}
+
 #define HASH_MAX_DIGESTSIZE 512
 
 struct ima_file_id {
@@ -536,6 +580,9 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 		return -EINVAL;
 	}
 
+	if (!algo)
+		algo = imaevm_params.hash_algo;
+
 	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
 		log_err("Hash algorithm %s not supported\n", algo);
 		return -EINVAL;
@@ -624,7 +671,7 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		default:
 			return -1;
 		}
-	} else if (sig[0] == DIGSIG_VERSION_2) {
+	} else if (sig[0] == DIGSIG_VERSION_2 || sig[0] == DIGSIG_VERSION_3) {
 		hashalgo = ((struct signature_v2_hdr *)sig)->hash_algo;
 		if (hashalgo >= PKEY_HASH__LAST)
 			return -1;
@@ -633,11 +680,11 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		return -1;
 }
 
-int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
-		int siglen)
+int verify_hash(const char *file, const unsigned char *hash, int size,
+		unsigned char *sig, int siglen)
 {
 	/* Get signature type from sig header */
-	if (sig[0] == DIGSIG_VERSION_1) {
+	if (sig[1] == DIGSIG_VERSION_1) {
 		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
@@ -645,9 +692,12 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 			key = "/etc/keys/pubkey_evm.pem";
 		else
 			key = imaevm_params.keyfile;
-		return verify_hash_v1(file, hash, size, sig, siglen, key);
-	} else if (sig[0] == DIGSIG_VERSION_2) {
+		return verify_hash_v1(file, hash, size, sig + 1, siglen - 1,
+					 key);
+	} else if (sig[1] == DIGSIG_VERSION_2) {
 		return verify_hash_v2(file, hash, size, sig, siglen);
+	} else if (sig[1] == DIGSIG_VERSION_3) {
+		return verify_hash_v3(file, hash, size, sig, siglen);
 	} else
 		return -1;
 }
@@ -658,11 +708,16 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
 
-	if (sig[0] != EVM_IMA_XATTR_DIGSIG) {
+	if (sig[0] != EVM_IMA_XATTR_DIGSIG && sig[0] != IMA_VERITY_DIGSIG) {
 		log_err("%s: xattr ima has no signature\n", file);
 		return -1;
 	}
 
+	if (!digest && sig[0] == IMA_VERITY_DIGSIG) {
+		log_err("%s: calculating the fs-verity digest is not supported\n", file);
+		return -1;
+	}
+
 	sig_hash_algo = imaevm_hash_algo_from_sig(sig + 1);
 	if (sig_hash_algo < 0) {
 		log_err("%s: Invalid signature\n", file);
@@ -676,14 +731,14 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	 * measurement list, not by calculating the local file digest.
 	 */
 	if (digestlen > 0)
-	    return verify_hash(file, digest, digestlen, sig + 1, siglen - 1);
+		return verify_hash(file, digest, digestlen, sig, siglen);
 
 	hashlen = ima_calc_hash(file, hash);
 	if (hashlen <= 1)
 		return hashlen;
 	assert(hashlen <= sizeof(hash));
 
-	return verify_hash(file, hash, hashlen, sig + 1, siglen - 1);
+	return verify_hash(file, hash, hashlen, sig, siglen);
 }
 
 /*
-- 
2.27.0

