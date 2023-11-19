Return-Path: <linux-integrity+bounces-83-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C867F0798
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD701F22246
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124914287;
	Sun, 19 Nov 2023 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZT/Y7kS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596B0C2
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:07 -0800 (PST)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGjlA8001278
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h8k5e1xi3ueTVsJb0ixqXSOjGig/p/ZOnqJW5ycn/u8=;
 b=DZT/Y7kSDgHNlJQfe9GPdYeRo9tqxEXRi/G5cakF+6SMlpi/C85eoUPZPXPBJz1G0O+R
 SkyvaKeTvMydCbFnHIQ/70AeVWPQeAZjY0m6kMFYTyqpAQmbstjLRKHzAOB/wWBAoE/F
 UzdJaffirMsV10CG7jSUyKf17x/CeZbW6WHII4b+eghprX3kNtp5QPTqo5qlAN4DzrCH
 Z1H8bRshC77AaiiQGIu58+YBcVYmbc0vcRx6X9X3+5++XYIYeOzqNRg8kxt/XVIUAC9q
 Stfkhohje0nxVS9aEUZP28CaqFMAIJGmAbB/ayJAxFj9o6/bXH5yfsPHIiG9UH2y1bhd TQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufn9t0rnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:06 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJE7qf8001217
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knc1rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:05 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp2ns30998812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:02 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 796AC20049;
	Sun, 19 Nov 2023 16:51:02 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C52F920040;
	Sun, 19 Nov 2023 16:51:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:01 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 07/12] Update ima_measurements to define and use a local list of public keys
Date: Sun, 19 Nov 2023 11:50:38 -0500
Message-Id: <20231119165043.46960-8-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231119165043.46960-1-zohar@linux.ibm.com>
References: <20231119165043.46960-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: __znljJbG173R28CcL64POA-c-t6MjKh
X-Proofpoint-GUID: __znljJbG173R28CcL64POA-c-t6MjKh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190128

Replace calling init_public_keys() with the init_public_keys2() version.
Similarly replace ima_verify_signature() with the ima_verify_signature2()
version.

Update the static ima_ng_show() function definition to include a
"public_keys" parameter.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f796edfce5f1..ad4565b3ee52 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1614,7 +1614,7 @@ static int lookup_template_name_entry(char *template_name)
 	return 0;
 }
 
-void ima_ng_show(struct template_entry *entry)
+static void ima_ng_show(void *public_keys, struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
@@ -1740,10 +1740,12 @@ void ima_ng_show(struct template_entry *entry)
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
@@ -2223,6 +2225,7 @@ static int ima_measurement(const char *file)
 	int first_record = 1;
 	unsigned int pseudo_padded_banks_mask, pseudo_banks_mask;
 	unsigned long entry_num = 0;
+	void *public_keys = NULL;
 	int c;
 
 	struct template_entry entry = { .template = NULL };
@@ -2252,9 +2255,9 @@ static int ima_measurement(const char *file)
 	}
 
 	if (imaevm_params.keyfile)	/* Support multiple public keys */
-		init_public_keys(imaevm_params.keyfile);
+		init_public_keys2(imaevm_params.keyfile, &public_keys);
 	else				/* assume read pubkey from x509 cert */
-		init_public_keys("/etc/keys/x509_evm.der");
+		init_public_keys2("/etc/keys/x509_evm.der", &public_keys);
 	if (errno)
 		log_errno_reset(LOG_DEBUG,
 				"Failure in initializing public keys");
@@ -2405,7 +2408,7 @@ static int ima_measurement(const char *file)
 		if (is_ima_template)
 			ima_show(&entry);
 		else
-			ima_ng_show(&entry);
+			ima_ng_show(public_keys, &entry);
 
 		if (!tpmbanks)
 			continue;
@@ -2464,6 +2467,7 @@ out_free:
 	free(pseudo_banks);
 	free(pseudo_padded_banks);
 	free(entry.template);
+	free_public_keys(public_keys);
 
 	return err;
 }
-- 
2.39.3


