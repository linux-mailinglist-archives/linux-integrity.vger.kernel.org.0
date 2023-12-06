Return-Path: <linux-integrity+bounces-366-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE458078A1
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC221C20FAD
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC04A47F5E;
	Wed,  6 Dec 2023 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CKvcl8vz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959761713
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:18 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6HWU38009768
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x2ndVhPT6oEEZ7o/Gv0NveNbZTy/slkZusrQu6FlV6s=;
 b=CKvcl8vz2ScOjgb1O0lC4zJkcvb9xWh4iAtAZpyH19KNQRA4kEvINxxl/0//4MRPqJLN
 Zb4fBx82eFKCF9/leH0zriXUtrfhClMfM3AzA7iBy3aMuQC+/fNI8gfffxUOVaLiqQC1
 KLufU31RU7iCc6cdnFZpV/quIZ7bYq4GM2iAuaYgeHFQ4reDuuKnXquPoo+kqnYRVGiq
 +dVA6K3kuU6nrfH1eL52MMxAfrbO3W2+XrSchN/e5E8hta3+Nu+Uv6B9rdt3qLvig/QX
 hOFhKln39Q7FZrdvtI5xapvekVsa+NeWtggRrbrLcNuZH+RTRGaA2jei3hw1C7iReC0e qQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utwem2w4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IT9X8013750
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utau46jua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSD4w41157306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F79E2004F;
	Wed,  6 Dec 2023 19:28:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBAAE20040;
	Wed,  6 Dec 2023 19:28:11 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:11 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 07/13] Update ima_measurements to define and use a local list of public keys
Date: Wed,  6 Dec 2023 14:27:28 -0500
Message-Id: <20231206192734.339999-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192734.339999-1-zohar@linux.ibm.com>
References: <20231206192734.339999-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7BxGbHqgLdg9M-MLUwhABZpv9Z1f_xEh
X-Proofpoint-GUID: 7BxGbHqgLdg9M-MLUwhABZpv9Z1f_xEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Replace calling init_public_keys() with the imaevm_init_public_keys()
version.  Similarly replace ima_verify_signature() with the
ima_verify_signature2() version.

Update the static ima_ng_show() function definition to include a
"public_keys" parameter.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 06cdffdd3755..5aea3652c80f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1625,7 +1625,7 @@ static int lookup_template_name_entry(char *template_name)
 	return 0;
 }
 
-void ima_ng_show(struct template_entry *entry)
+static void ima_ng_show(void *public_keys, struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
@@ -1751,10 +1751,12 @@ void ima_ng_show(struct template_entry *entry)
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
@@ -2234,6 +2236,7 @@ static int ima_measurement(const char *file)
 	int first_record = 1;
 	unsigned int pseudo_padded_banks_mask, pseudo_banks_mask;
 	unsigned long entry_num = 0;
+	void *public_keys = NULL;
 	int c;
 
 	struct template_entry entry = { .template = NULL };
@@ -2263,10 +2266,16 @@ static int ima_measurement(const char *file)
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
 
@@ -2416,7 +2425,7 @@ static int ima_measurement(const char *file)
 		if (is_ima_template)
 			ima_show(&entry);
 		else
-			ima_ng_show(&entry);
+			ima_ng_show(public_keys, &entry);
 
 		if (!tpmbanks)
 			continue;
@@ -2475,6 +2484,7 @@ out_free:
 	free(pseudo_banks);
 	free(pseudo_padded_banks);
 	free(entry.template);
+	imaevm_free_public_keys(public_keys);
 
 	return err;
 }
-- 
2.39.3


