Return-Path: <linux-integrity+bounces-653-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31282489B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E13EB2217E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE32C190;
	Thu,  4 Jan 2024 19:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqISvJfc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7F28E38
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404IE68p014965
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kXNpuz3i/aN1IbKt/wlEQyOJ7JDI4sUJ8nz3YleBP3c=;
 b=DqISvJfcvLfSHfRuxulJYEDlHZWehx7/yblSqHkZVe8zTP/9Pld4H3JAFRWAzCjJA4UT
 ihzjpABaXhQAJLqseGvhfJm0tCvOZImYkVVbWqRH+ff0zs+p5pxcdaS0M9jruqntzZCf
 Ao9LwLm1nN8hURp9blnT57/Sz4UI9OqDju914EQy8fz3IE7wIOXn2CaOP2y3LXTdFpxg
 2BHWI83ATAOmiL9TtKp9tFxAznYnTNrOa28gZZ4u2g5zjmZEpP4opfq3Dn7kfen1E1Oy
 hSEOuRmQkV1jOCMAyVwrdeI/rHsCboFhhmenOGYEUBDc0fO0meiFBPuQ6Th6g6tC2pIn Lg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1rxhbht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:16 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404Gwm3F019309
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30stab6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6CPx56099230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C0772004B;
	Thu,  4 Jan 2024 19:06:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C602A20040;
	Thu,  4 Jan 2024 19:06:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:11 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 07/13] Update ima_measurements to define and use a local list of public keys
Date: Thu,  4 Jan 2024 14:05:52 -0500
Message-Id: <20240104190558.3674008-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240104190558.3674008-1-zohar@linux.ibm.com>
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UpWtb_M2XWgh8jle8ux5Og-f2WCS8NeK
X-Proofpoint-GUID: UpWtb_M2XWgh8jle8ux5Og-f2WCS8NeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040149

Replace calling init_public_keys() with the imaevm_init_public_keys()
version.  Similarly replace ima_verify_signature() with the
ima_verify_signature2() version.

Update the static ima_ng_show() function definition to include a
"public_keys" parameter.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 29c4d1dc1f0d..2ccaaf244aa9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1625,7 +1625,8 @@ static int lookup_template_name_entry(char *template_name)
 	return 0;
 }
 
-void ima_ng_show(struct template_entry *entry)
+static void ima_ng_show(struct public_key_entry *public_keys,
+			struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
@@ -1751,10 +1752,12 @@ void ima_ng_show(struct template_entry *entry)
 		 * the measurement list or calculate the hash.
 		 */
 		if (verify_list_sig)
-			err = ima_verify_signature(path, sig, sig_len,
-						   digest, digest_len);
+			err = ima_verify_signature2(public_keys, path,
+						    sig, sig_len,
+						    digest, digest_len);
 		else
-			err = ima_verify_signature(path, sig, sig_len, NULL, 0);
+			err = ima_verify_signature2(public_keys, path,
+						    sig, sig_len, NULL, 0);
 
 		if (!err && imaevm_params.verbose > LOG_INFO)
 			log_info("%s: verification is OK\n", path);
@@ -2225,6 +2228,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 
 static int ima_measurement(const char *file)
 {
+	struct public_key_entry *public_keys = NULL;
 	struct tpm_bank_info *pseudo_padded_banks;
 	struct tpm_bank_info *pseudo_banks = NULL;
 	struct tpm_bank_info *tpm_banks = NULL;
@@ -2263,10 +2267,16 @@ static int ima_measurement(const char *file)
 	}
 
 	if (imaevm_params.keyfile)	/* Support multiple public keys */
-		init_public_keys(imaevm_params.keyfile);
+		err = imaevm_init_public_keys(imaevm_params.keyfile,
+					      &public_keys);
 	else				/* assume read pubkey from x509 cert */
-		init_public_keys("/etc/keys/x509_evm.der");
-	if (errno)
+		err = imaevm_init_public_keys("/etc/keys/x509_evm.der",
+					      &public_keys);
+	/*
+	 * Without public keys, cannot validate signatures, but can
+	 * still calculate and verify the measurement list against TPM PCRs.
+	 */
+	if (errno || err < 0)
 		log_errno_reset(LOG_DEBUG,
 				"Failure in initializing public keys");
 
@@ -2416,7 +2426,7 @@ static int ima_measurement(const char *file)
 		if (is_ima_template)
 			ima_show(&entry);
 		else
-			ima_ng_show(&entry);
+			ima_ng_show(public_keys, &entry);
 
 		if (!tpmbanks)
 			continue;
@@ -2475,6 +2485,7 @@ out_free:
 	free(pseudo_banks);
 	free(pseudo_padded_banks);
 	free(entry.template);
+	imaevm_free_public_keys(public_keys);
 
 	return err;
 }
-- 
2.39.3


