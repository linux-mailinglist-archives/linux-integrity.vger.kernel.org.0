Return-Path: <linux-integrity+bounces-651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C65824897
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3CD1C21E45
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA56D28E2B;
	Thu,  4 Jan 2024 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hz4a6VEx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A3828E3D
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404Hiw0i029320
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=/SjvwMQUz6GBqW6PX13JlKwY/ip3y0Baand/3alfWPk=;
 b=hz4a6VExERGCzHP4o+4uAmBxeMywLEN0rWHSYZK8TIYclI6uzUilvpv9Jqpk2S4BMjTv
 rffqQYfSxjE79w0wlpSNYriCFpkwFJURjTMHtUwBCOGTmpAheOCMpcNWqqUkXk5cfZNi
 XLfqwGQArqkokK8zO0/lEePYSyrB+pTyJp0hQSybwClTdFtqRJjQdEKHw6MaxvxzIK3i
 fRcpdOTLjhpcW7dwkQy53ugcKyjH49VcTIcwTK2ttIVD5XNy+3ehZd5z6h8IlIgJa/YO
 DT2AFIJIb0nGsEA6EmRfCq6ju2v098kahwqmsSolOhBC/Fa7fcMVeP2ZObM/hwkErLoo MA== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1bnabyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:14 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404ICZa6024510
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082jmfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6AeB5112458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 830762004E;
	Thu,  4 Jan 2024 19:06:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ACCC20043;
	Thu,  4 Jan 2024 19:06:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:09 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 05/13] Update cmd_verify_ima() to define and use a local list of public keys
Date: Thu,  4 Jan 2024 14:05:50 -0500
Message-Id: <20240104190558.3674008-6-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GbdQREU_t35nUBjLCmfjIRWaBpu2gJAi
X-Proofpoint-GUID: GbdQREU_t35nUBjLCmfjIRWaBpu2gJAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

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
index 2710a27cb305..5d84a41a0762 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -972,7 +972,7 @@ static int cmd_verify_evm(struct command *cmd)
 	return err;
 }
 
-static int verify_ima(const char *file)
+static int verify_ima(struct public_key_entry *public_keys, const char *file)
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
+	struct public_key_entry *public_keys = NULL;
 	char *file = g_argv[optind++];
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


