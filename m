Return-Path: <linux-integrity+bounces-87-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F67F079C
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5041C209CD
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71CE14AB9;
	Sun, 19 Nov 2023 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hU6xiF91"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE1131
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:09 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAcMZ017391
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9vvkwpEZcAohfpkYGEMtMEDReGeC6jLu2WKBBRjVq8M=;
 b=hU6xiF91It2ZT/RG81R0Yim3dcBtZgm8/qh84bVt/QTBssrBrwCmEDUFxMVclMsj74vO
 +m2y7z/We6Mwyven1O/YmY4tmfBFCpp3y4Vghw29z2il4tPRPxya5pOmeYqGxthT6HSD
 5hE8NqPd8AeHzKiVds0NdOi1Xufoi5wya/oO7zQrsD8yThv9z1nJ7qKftlO/h8YO3jri
 9d89sTnC7aVrh9V26+KuHwe5Hez3WU7PnsyfbPvVX2tYqDHNWmmydEgBnDWLsB1r7l2I
 EDBO22jxGs2Ee/rv9rcMyFRObuhPN+H1e+7ngRvbpaueyhOzrV1Q0BNDNMb9cuSFoR8B Jw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf0k39785-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:09 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEFH0e002179
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy47kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp0QX22413984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7153B20049;
	Sun, 19 Nov 2023 16:51:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AD3A20040;
	Sun, 19 Nov 2023 16:50:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:59 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 05/12] Update cmd_verify_ima() to define and use a local list of public keys
Date: Sun, 19 Nov 2023 11:50:36 -0500
Message-Id: <20231119165043.46960-6-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: doBd-GtrH9ZZ2t5ltp4D91B4Gme6Wcuh
X-Proofpoint-ORIG-GUID: doBd-GtrH9ZZ2t5ltp4D91B4Gme6Wcuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311190129

Update the static verify_ima() fucntion definition to include "public_keys".

Replace calling init_public_keys() with the init_public_keys2() version.
Similarly replace ima_verify_signature() with the ima_verify_signature2()
version.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4190913f0295..bf1f8f07e9ca 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -972,7 +972,7 @@ static int cmd_verify_evm(struct command *cmd)
 	return err;
 }
 
-static int verify_ima(const char *file)
+static int verify_ima(void *public_keys, const char *file)
 {
 	unsigned char sig[MAX_SIGNATURE_SIZE];
 	int len;
@@ -999,34 +999,37 @@ static int verify_ima(const char *file)
 		}
 	}
 
-	return ima_verify_signature(file, sig, len, NULL, 0);
+	return ima_verify_signature2(public_keys, file, sig, len, NULL, 0);
 }
 
 static int cmd_verify_ima(struct command *cmd)
 {
 	char *file = g_argv[optind++];
+	void *public_keys = NULL;
 	int err, fails = 0;
 
-	if (imaevm_params.x509) {
-		if (imaevm_params.keyfile) /* Support multiple public keys */
-			init_public_keys(imaevm_params.keyfile);
-		else			   /* assume read pubkey from x509 cert */
-			init_public_keys("/etc/keys/x509_evm.der");
-	}
-
 	if (!file) {
 		log_err("Parameters missing\n");
 		print_usage(cmd);
 		return -1;
 	}
 
+	if (imaevm_params.x509) {
+		if (imaevm_params.keyfile) /* Support multiple public keys */
+			init_public_keys2(imaevm_params.keyfile, &public_keys);
+		else			   /* assume read pubkey from x509 cert */
+			init_public_keys2("/etc/keys/x509_evm.der", &public_keys);
+	}
+
 	do {
-		err = verify_ima(file);
+		err = verify_ima(public_keys, file);
 		if (err)
 			fails++;
 		if (!err && imaevm_params.verbose >= LOG_INFO)
 			log_info("%s: verification is OK\n", file);
 	} while ((file = g_argv[optind++]));
+
+	free_public_keys(public_keys);
 	return fails > 0;
 }
 
-- 
2.39.3


