Return-Path: <linux-integrity+bounces-661-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EA98248A1
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEEEBB23676
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3C72C188;
	Thu,  4 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mlfEwva/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6E2C190
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404IEDrm015454
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hTD6syyNLN1jltQJFp/pTjxnTeeUiL7um4T2py1w/dc=;
 b=mlfEwva/WaBbhp3ZIiR6gaBjaWOZ61Xr7DuTCzsopIKqVZ1dcUHp4HPspZo+3dsz8s0w
 AZmj/APlImqzgcrKwUTbe6zbpQ3vB4ltxSwbGn9RfFg43rBVBTHqc+h2f0LdrFzxQoO+
 kgBV0yk0xeHybnPXR+36kdqGz4fu0G07vFsT5HgxG8JAgSbOfjru/W0YniOHIuw0beWs
 m6UVa2i2I0n7M1dM7ytiaQcUh9P+J3ZZ48v2Sfe1M9OZ3xZFCgi4jeG6I2wdbqdd2QBs
 TG5VUaYsF78LV61JhVpjPFQHjIR6FD7YlnDnqcVaF5DBNmsPNnlT5odyp/rm6frNjQFX lQ== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve1rxhbks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:21 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404IZabl027261
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhtkbq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6H2t21824088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E6032004B;
	Thu,  4 Jan 2024 19:06:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B9F20040;
	Thu,  4 Jan 2024 19:06:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:16 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 13/13] Define and use a file specific "keypass" variable
Date: Thu,  4 Jan 2024 14:05:58 -0500
Message-Id: <20240104190558.3674008-14-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: aT7FZyRh_8peo85G_2GgAqJ76PnplgpW
X-Proofpoint-GUID: aT7FZyRh_8peo85G_2GgAqJ76PnplgpW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401040149

Instead of relying on the "imaevm_parrams.keypass" global variable,
which is not concurrency-safe, define and use a file specific variable.

To avoid library incompatibility, don't remove imaevm_params.keypass
variable.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 37441b1b77ea..d050b5e36765 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -141,6 +141,7 @@ static bool evm_portable;
 static bool veritysig;
 static bool hwtpm;
 static char *g_hash_algo = DEFAULT_HASH_ALGO;
+static char *g_keypass;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -576,7 +577,7 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -662,7 +663,7 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
 		return len;
 	assert(len <= sizeof(hash));
 
-	len = sign_hash(hash_algo, hash, len, key, NULL, sig + 1);
+	len = sign_hash(hash_algo, hash, len, key, g_keypass, sig + 1);
 	if (len <= 1)
 		return len;
 	assert(len < sizeof(sig));
@@ -844,7 +845,7 @@ static int cmd_sign_hash(struct command *cmd)
 			}
 
 			siglen = sign_hash(algo, sigv3_hash, hashlen / 2,
-					   key, NULL, sig + 1);
+					   key, g_keypass, sig + 1);
 
 			sig[0] = IMA_VERITY_DIGSIG;
 			sig[1] = DIGSIG_VERSION_3;	/* sigv3 */
@@ -856,7 +857,7 @@ static int cmd_sign_hash(struct command *cmd)
 			hex2bin(hash, line, hashlen / 2);
 
 			siglen = sign_hash(g_hash_algo, hash,
-					   hashlen / 2, key, NULL, sig + 1);
+					   hashlen / 2, key, g_keypass, sig + 1);
 			sig[0] = EVM_IMA_XATTR_DIGSIG;
 		}
 
@@ -3092,9 +3093,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'p':
 			if (optarg)
-				imaevm_params.keypass = optarg;
+				g_keypass = optarg;
 			else
-				imaevm_params.keypass = get_password();
+				g_keypass = get_password();
 			break;
 		case 'f':
 			sigfile = 1;
@@ -3236,8 +3237,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!imaevm_params.keypass)
-		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
+	if (!g_keypass)
+		g_keypass = getenv("EVMCTL_KEY_PASSWORD");
 
 	if (imaevm_params.keyfile != NULL &&
 	    imaevm_params.eng == NULL &&
-- 
2.39.3


