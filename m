Return-Path: <linux-integrity+bounces-372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 924B08078A7
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 354EAB20E43
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055847F47;
	Wed,  6 Dec 2023 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p17T0Vml"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA81BD
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:25 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IHOWp007014
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RSBkrG3KUw0eynBcW1iS7UEpw7sLjPzCDfymDTqumnU=;
 b=p17T0Vml4DSqw8GvTdINOjSpaU1YUhnRiDhqghuzn/NoIHrmAc/qewHhs/hMz6a76Vb+
 QZbCDM7zcwrwM9WLjgEAVWoLYiAsNPQvYGe5dafggnJ8Iz2ip0gKgFcz/nQKCSn4gbZX
 wujoqpnYPe57FO3twXA08PDDZyWqAJg6ICIP10cOMseGSaeEgL9SYh9ai36+56jACpFH
 oJCUSPBZ8fpBCTqh+0gmGcmVomiBdSmHZox20rve3n8LCPNNMb6CVGs5KznyhTz2ghUw
 vX+todz120ylLOZjS6smTwWnW3y3kCqDAbmBY+/djrO8YdYMc0MCHN8uGy9XTBK3I2+Z 3Q== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utvv9mavv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IPZZQ027021
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav2xjsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSKjA35455398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE252004E;
	Wed,  6 Dec 2023 19:28:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A694B2004B;
	Wed,  6 Dec 2023 19:28:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:19 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 13/13] Define and use a file specific "keypass" variable
Date: Wed,  6 Dec 2023 14:27:34 -0500
Message-Id: <20231206192734.339999-14-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pVmnj1LAYQHlGjyHasWh7kkuO5DPu_N_
X-Proofpoint-GUID: pVmnj1LAYQHlGjyHasWh7kkuO5DPu_N_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=919 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060141

Instead of relying on the "imaevm_parrams.keypass" global variable,
which is not concurrency-safe, define and use a file specific variable.

To avoid library incompatibility, don't remove imaevm_params.keypass
variable.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8eb2c46fbff0..72b800f6884c 100644
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
 
@@ -3091,9 +3092,9 @@ int main(int argc, char *argv[])
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
@@ -3235,8 +3236,8 @@ int main(int argc, char *argv[])
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


