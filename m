Return-Path: <linux-integrity+bounces-90-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1D7F079F
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88DC280E80
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7997D15494;
	Sun, 19 Nov 2023 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DCXaWRNv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA256133
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:09 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAblC017234
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xsFDbpYv4KK3iZzG6K+S+qOaUg39s83duIgJ/jl3FDE=;
 b=DCXaWRNvQtOZFRl8Cx+jMvTPHB9QRGC33+lcZZgH25TtkL/aqcj8oiEvqUm4w3JCzh4j
 ltWUPXdXrd5xlXXsL0aR+bgFhpyZvdowIkUw89iBas1/gO1xkxL31dfgNGBihP1gKfZx
 DO0k36ktJ+q21Tp7eArV6XqLqcnChHBhQPmwt3v1+XuPgSduglEdSZeDgdDIhYCKZpgu
 gGz/K6T446tVbcHHXf3NLlQpONT2p7xxVXXp/NmUpXY4J9RGVbgOB42YH4q8BnUp8PWw
 xktOrMCLkjOLZ9YdWFHbNvlo6VcWCtvOLUUMgruoYHsL1aKCfmuLPRgH6x8wZ7h4h1kc lA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf0k39787-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEADkV020985
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:04 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7ksmbgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp1Rb22413982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 767CB2004B;
	Sun, 19 Nov 2023 16:51:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C245A20040;
	Sun, 19 Nov 2023 16:51:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:00 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 06/12] Update cmd_verify_evm to define and use a local list of public keys
Date: Sun, 19 Nov 2023 11:50:37 -0500
Message-Id: <20231119165043.46960-7-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: cw_EPaxtff2u7qhSBtgvwxXrVoZEW_mK
X-Proofpoint-ORIG-GUID: cw_EPaxtff2u7qhSBtgvwxXrVoZEW_mK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311190129

Replace calling init_public_keys() with the init_public_keys2() version.
Similarly replace verify_hash() with the verify_hash2() version.

Update the static function verify_evm() definition to include a
"public_keys" parameter.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index bf1f8f07e9ca..f796edfce5f1 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -905,7 +905,7 @@ static int cmd_sign_evm(struct command *cmd)
 	return do_cmd(cmd, sign_evm_path);
 }
 
-static int verify_evm(const char *file)
+static int verify_evm(void *public_keys, const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
@@ -945,12 +945,14 @@ static int verify_evm(const char *file)
 		return mdlen;
 	assert(mdlen <= sizeof(hash));
 
-	return verify_hash(file, hash, mdlen, sig, len);
+	return verify_hash2(public_keys, file, imaevm_params.hash_algo,
+			    hash, mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
 {
 	char *file = g_argv[optind++];
+	void *public_keys = NULL;
 	int err;
 
 	if (!file) {
@@ -961,14 +963,17 @@ static int cmd_verify_evm(struct command *cmd)
 
 	if (imaevm_params.x509) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
-			init_public_keys(imaevm_params.keyfile);
+			init_public_keys2(imaevm_params.keyfile, &public_keys);
 		else			   /* assume read pubkey from x509 cert */
-			init_public_keys("/etc/keys/x509_evm.der");
+			init_public_keys2("/etc/keys/x509_evm.der",
+					  &public_keys);
 	}
 
-	err = verify_evm(file);
+	err = verify_evm(public_keys, file);
 	if (!err && imaevm_params.verbose >= LOG_INFO)
 		log_info("%s: verification is OK\n", file);
+
+	free_public_keys(public_keys);
 	return err;
 }
 
-- 
2.39.3


