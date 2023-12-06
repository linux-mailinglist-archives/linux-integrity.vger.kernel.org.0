Return-Path: <linux-integrity+bounces-363-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3E780789F
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0212821CB
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB347F51;
	Wed,  6 Dec 2023 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CwZENLyg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E910F0
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:14 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6HWUDC009735
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H0SG/17+ryLopEJiE8hvdPuX0QWkkgd7FfhXknHExQg=;
 b=CwZENLygeE7uzlKpXpbaMdhaqqvILs1OVu9B5aZP3qRBP/pnljv4Ved+9zuyoQDjBnR1
 MMfaK3HOrRZLQU4d6jkSs0iKOABXBYPd9IQRxGur4jE5tB+QeHC1CODdFsyeJnoMPb7h
 jjseKUwdNXFKtuIjGhMLMXEkmFwoK5ZN3CHiinMPkMZ3MM4/eXAihUtFmenvGCk8Jr/u
 jzdiC42tYtymmIL8jpM8rTJ5lV6NlZ6IDu+LvZ4Y1MHm9rICNDg+NFjDMZZMhPwKx7zK
 lvNM/jfBvZSdJF5tTKc6CeD4Aoe77v2bPuMRWrpOLMsgA5v3ueYQU83LFwDF91f5Awk/ 3g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utwem2w35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:14 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6ITnlU004681
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4ekvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:13 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSAFn48366024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A51D20043;
	Wed,  6 Dec 2023 19:28:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5892004B;
	Wed,  6 Dec 2023 19:28:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:09 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 05/13] Update cmd_verify_ima() to define and use a local list of public keys
Date: Wed,  6 Dec 2023 14:27:26 -0500
Message-Id: <20231206192734.339999-6-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: CDTZydhbma8gc552RyMjPohWfstOz2Yr
X-Proofpoint-GUID: CDTZydhbma8gc552RyMjPohWfstOz2Yr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Update the static verify_ima() function definition to include
"public_keys".

Replace calling init_public_keys() with the imaevm_init_public_keys()
version.  Similarly replace ima_verify_signature() with the
ima_verify_signature2() version.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 2710a27cb305..3ae79262efbb 100644
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
@@ -999,34 +999,43 @@ static int verify_ima(const char *file)
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
+			err = imaevm_init_public_keys(imaevm_params.keyfile,
+						      &public_keys);
+		else			   /* assume read pubkey from x509 cert */
+			err = imaevm_init_public_keys("/etc/keys/x509_evm.der",
+						      &public_keys);
+		if (err < 0) {
+			log_info("Failed loading public keys");
+			return err;
+		}
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
+	imaevm_free_public_keys(public_keys);
 	return fails > 0;
 }
 
-- 
2.39.3


