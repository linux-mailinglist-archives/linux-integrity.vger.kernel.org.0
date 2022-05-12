Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFA95254DD
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357536AbiELSbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiELSbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 14:31:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F15E5D645
        for <linux-integrity@vger.kernel.org>; Thu, 12 May 2022 11:31:23 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIUhCE000374;
        Thu, 12 May 2022 18:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TP8E5HwA/lxyej2SH0hnXys25LZ0pFJdt5CX9KOV+6o=;
 b=DzFBXPG1Sasi68d7TKqf/gFpMFtunWo8dDymykSfKvU9GGBwcRPYaAkoKe7m3q3m6B7+
 3qZh78J582QUweHqrpw7LvU8kAZIOuMan1nmR3gXVTih1fP8Ku5of2uebd5G/eNTPcKT
 JwUudrG9XmWXSYVdbBwcjdrPplOiZ9DJBgWMYt2XDNx7myqCqCCyXCHv0Qaen+gaP9es
 fbE3NNg7QYQLZlyt6fwCrgRZMAY56vLjUkeP6iCqhJVNuuSxOWkxI/CpWD+OpzlzKnXt
 h8dkiqJE8N5k7f5H6j9kS5LWF5YLQQRix/HV8mY+/a1xLIu3CW49bz5Ch/UfcKEZakMT cA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g1645t02a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:31:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIF3l8024507;
        Thu, 12 May 2022 18:31:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8yetf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:31:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CIHZke49480166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 18:17:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B550042042;
        Thu, 12 May 2022 18:31:14 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314EC4203F;
        Thu, 12 May 2022 18:31:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.98.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 18:31:14 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 3/3] Verify an fs-verity file digest based signature
Date:   Thu, 12 May 2022 14:30:56 -0400
Message-Id: <20220512183056.307597-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220512183056.307597-1-zohar@linux.ibm.com>
References: <20220512183056.307597-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qmbRllRnR_oTGQCNt6imm6sPSmjOCnaz
X-Proofpoint-GUID: qmbRllRnR_oTGQCNt6imm6sPSmjOCnaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_15,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205120081
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

For the time being only fs-verity supports signature format v3 (sigv3).
To differentiate between the existing IMA and fs-verity file signatures,
modify the verify_hash() 'sig' argument to be a pointer to the entire
xattr, including the xattr type.

Example:
evmctl ima_measurement --key <DER encoded public key> \
 --verify-sig /sys/kernel/security/ima/binary_runtime_measurements

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 11 +++++++++--
 src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9152b0a5c7c2..593eed80f96a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -909,7 +909,7 @@ static int verify_evm(const char *file)
 		return mdlen;
 	assert(mdlen <= sizeof(hash));
 
-	return verify_hash(file, hash, mdlen, sig + 1, len - 1);
+	return verify_hash(file, hash, mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
@@ -1572,7 +1572,8 @@ void ima_ng_show(struct template_entry *entry)
 	fieldp += field_len;
 	total_len -= field_len;
 
-	if (!strcmp(entry->name, "ima-sig")) {
+	if (!strcmp(entry->name, "ima-sig") ||
+	    !strcmp(entry->name, "ima-sigv2")) {
 		/* get signature */
 		field_len = *(uint32_t *)fieldp;
 		fieldp += sizeof(field_len);
@@ -1618,11 +1619,17 @@ void ima_ng_show(struct template_entry *entry)
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
index 7c2ed5fb0556..8a37551132d6 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -534,11 +534,21 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 		return -EINVAL;
 	}
 
-	if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
-		log_err("Hash algorithm %s not supported\n", algo);
-		return -EINVAL;
+	/*
+	 * Calculating the hash is based on the fsverity hash algorithm,
+	 * while verifying the signature is based on the hash algorithm
+	 * contained in the signature header.
+	 */
+	if (algo) {
+		if ((hash_algo = imaevm_get_hash_algo(algo)) < 0) {
+			log_err("Hash algorithm %s not supported\n", algo);
+			return -EINVAL;
+		}
+		file_id.hash_algorithm = hash_algo;
+	} else {
+		algo = imaevm_params.hash_algo;
+		file_id.hash_algorithm = imaevm_get_hash_algo(algo);
 	}
-	file_id.hash_algorithm = hash_algo;
 
 	md = EVP_get_digestbyname(algo);
 	if (!md) {
@@ -622,7 +632,7 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 		default:
 			return -1;
 		}
-	} else if (sig[0] == DIGSIG_VERSION_2) {
+	} else if (sig[0] == DIGSIG_VERSION_2 || sig[0] == DIGSIG_VERSION_3) {
 		hashalgo = ((struct signature_v2_hdr *)sig)->hash_algo;
 		if (hashalgo >= PKEY_HASH__LAST)
 			return -1;
@@ -634,8 +644,11 @@ int imaevm_hash_algo_from_sig(unsigned char *sig)
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
 		int siglen)
 {
+	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
+	int ret;
+
 	/* Get signature type from sig header */
-	if (sig[0] == DIGSIG_VERSION_1) {
+	if (sig[1] == DIGSIG_VERSION_1) {
 		const char *key = NULL;
 
 		/* Read pubkey from RSA key */
@@ -643,9 +656,17 @@ int verify_hash(const char *file, const unsigned char *hash, int size, unsigned
 			key = "/etc/keys/pubkey_evm.pem";
 		else
 			key = imaevm_params.keyfile;
-		return verify_hash_v1(file, hash, size, sig, siglen, key);
-	} else if (sig[0] == DIGSIG_VERSION_2) {
-		return verify_hash_v2(file, hash, size, sig, siglen);
+		return verify_hash_v1(file, hash, size, sig + 1, siglen - 1,
+				      key);
+	} else if (sig[1] == DIGSIG_VERSION_2) {
+		return verify_hash_v2(file, hash, size, sig + 1, siglen - 1);
+	} else if (sig[1] == DIGSIG_VERSION_3) {
+		ret = calc_hash_sigv3(sig[0], NULL, hash, sigv3_hash);
+		if (ret < 0)
+			return ret;
+
+		return verify_hash_v2(file, sigv3_hash, size, sig + 1,
+				      siglen - 1);
 	} else
 		return -1;
 }
@@ -656,11 +677,16 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
 	unsigned char hash[MAX_DIGEST_SIZE];
 	int hashlen, sig_hash_algo;
 
-	if (sig[0] != EVM_IMA_XATTR_DIGSIG) {
+	if ((sig[0] != EVM_IMA_XATTR_DIGSIG) && (sig[0] != IMA_VERITY_DIGSIG)) {
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
@@ -674,14 +700,14 @@ int ima_verify_signature(const char *file, unsigned char *sig, int siglen,
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

