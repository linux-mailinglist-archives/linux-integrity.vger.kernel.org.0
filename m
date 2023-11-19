Return-Path: <linux-integrity+bounces-91-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856027F07A0
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9CE280DFA
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51951549A;
	Sun, 19 Nov 2023 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tp50mtds"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1ED11D
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:51:13 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGAalx017153
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vU/emekjruWUbQd1mylP30ucEFIWuRh4gPBGdMI6kfY=;
 b=tp50mtdsqC9dbyJnScnhijiezzw4Kh3pPPSo1U78GytkWIsvkLjlKFyl/uXkeIEixy8E
 CReOjZOq7+eJydLwxgu1PH2xQQgWU5ZTc3DM3dYhbDosyt/LHFSjFZnVizeY9ZrylJ+w
 uOkLuDV/FkYmA6YrnmysjU/30A93f7g2O6fSFessIkyBOOadvzFj8f8tlFqUtrnvDGmM
 q+LP0VdBl1Uwvr/+kYmONz2qREBY1cz616TuYA/blAX4bnpgnAeZU2LNnbi0bgqBGmij
 F673n0HH//NO1vmIQw/LWv32rskKYkuhX6bzLOLWHGgA1WR17UCGicZ1y/TejpetcnrO hA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uf0k3979h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEEEJ2002233
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yy47kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:51:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGp8LM19792448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:51:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373F02004B;
	Sun, 19 Nov 2023 16:51:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 828B720040;
	Sun, 19 Nov 2023 16:51:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:51:07 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 12/12] Define and use a file specific "keypass" variable
Date: Sun, 19 Nov 2023 11:50:43 -0500
Message-Id: <20231119165043.46960-13-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: FsymO7FZzs49lXz7WUZa5dHb1IusL8J4
X-Proofpoint-ORIG-GUID: FsymO7FZzs49lXz7WUZa5dHb1IusL8J4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 mlxlogscore=971 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311190129

Instead of relying on the "imaevm_params.keypass" global variable, which
is not concurrency-safe, add keypass as a parameter to the static library
functions definitions.  Update function callers.

To avoid library incompatablity, don't remove imaevm_params.keypass
variable.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    |  9 +++++----
 src/libimaevm.c | 17 ++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index b802eeb1bf15..6d6160159a1f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -141,6 +141,7 @@ static bool evm_portable;
 static bool veritysig;
 static bool hwtpm;
 static char *hash_algo;
+static char *keypass;
 
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
@@ -3082,9 +3083,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'p':
 			if (optarg)
-				imaevm_params.keypass = optarg;
+				keypass = optarg;
 			else
-				imaevm_params.keypass = get_password();
+				keypass = get_password();
 			break;
 		case 'f':
 			sigfile = 1;
@@ -3226,8 +3227,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!imaevm_params.keypass)
-		imaevm_params.keypass = getenv("EVMCTL_KEY_PASSWORD");
+	if (!keypass)
+		keypass = getenv("EVMCTL_KEY_PASSWORD");
 
 	if (imaevm_params.keyfile != NULL &&
 	    imaevm_params.eng == NULL &&
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 18b6a6f27237..10ec847da08a 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -1124,7 +1124,8 @@ static int get_hash_algo_v1(const char *algo)
 }
 
 static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	int len = -1, hashalgo_idx;
 	SHA_CTX ctx;
@@ -1158,7 +1159,7 @@ static int sign_hash_v1(const char *hashalgo, const unsigned char *hash,
 	log_info("hash(%s): ", hashalgo);
 	log_dump(hash, size);
 
-	key = read_priv_key(keyfile, imaevm_params.keypass);
+	key = read_priv_key(keyfile, keypass);
 	if (!key)
 		return -1;
 
@@ -1211,7 +1212,8 @@ out:
  * Return: -1 signing error, >0 length of signature
  */
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
-			int size, const char *keyfile, unsigned char *sig)
+			int size, const char *keyfile, const char *keypass,
+			unsigned char *sig)
 {
 	struct signature_v2_hdr *hdr;
 	int len = -1;
@@ -1246,7 +1248,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	log_info("hash(%s): ", algo);
 	log_dump(hash, size);
 
-	pkey = read_priv_pkey(keyfile, imaevm_params.keypass);
+	pkey = read_priv_pkey(keyfile, keypass);
 	if (!pkey)
 		return -1;
 
@@ -1316,14 +1318,11 @@ err:
 
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size, const char *keyfile, const char *keypass, unsigned char *sig)
 {
-	if (keypass)
-		imaevm_params.keypass = keypass;
-
 	if (imaevm_params.x509)
-		return sign_hash_v2(hashalgo, hash, size, keyfile, sig);
+		return sign_hash_v2(hashalgo, hash, size, keyfile, keypass, sig);
 #if CONFIG_SIGV1
 	else
-		return sign_hash_v1(hashalgo, hash, size, keyfile, sig);
+		return sign_hash_v1(hashalgo, hash, size, keyfile, keypass, sig);
 #endif
 	log_info("Signature version 1 deprecated.");
 	return -1;
-- 
2.39.3


