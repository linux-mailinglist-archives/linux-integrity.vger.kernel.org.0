Return-Path: <linux-integrity+bounces-652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C67824898
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8221F22727
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF928E3D;
	Thu,  4 Jan 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VAUYhzoj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406628E1F
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HUDIh026730
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CFiN3XTLE8xDVB1edLK0y04EdQzzU1evn+JkhHQoRvs=;
 b=VAUYhzoj+vQo+OlBLfZL0sFN2B/tkhxYOK4/QT9Wc5NbwEHF2YiOXosGXOgFYmTJe/an
 exGDvJVjsfBlVFEGOEyEqFuJ0GtaHHSIzSatrZvIs9pCj7qb+ZvuzLiMdfrzrmVWHzJy
 CN1cBF8/rT4ImStARg6mCedQ2+9FJB2+JUc9X8S0R9dUqPIyU5oK5s3J7sgNWWMhfdQ3
 FvvVdrnHN2tAnPqjfalLxXJ8TIHD2zBA02ejjskpH3oTJxNwAad4SkaDJthBpT2HgCvL
 6JH01S1w/d4Drw1ehIiuZa3/Z66l6nVrIRPjzuanzeL3bE/VkH7e40BvnqyVOR4lFMsZ pA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve14rk4ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:15 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404IZabf027261
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vawhtkbpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J6BJj38339100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939E120043;
	Thu,  4 Jan 2024 19:06:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4C3720040;
	Thu,  4 Jan 2024 19:06:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:10 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 06/13] Update cmd_verify_evm to define and use a local list of public keys
Date: Thu,  4 Jan 2024 14:05:51 -0500
Message-Id: <20240104190558.3674008-7-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: HvAUTq-OCKDNoq7ETLj8irXM9D2BeDU6
X-Proofpoint-GUID: HvAUTq-OCKDNoq7ETLj8irXM9D2BeDU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040149

Replace calling init_public_keys() with the imaevm_init_public_keys()
version. Similarly replace verify_hash() with the imaevm_verify_hash()
version.

Update the static function verify_evm() definition to include a
"public_keys" parameter.

Free the local public keys list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5d84a41a0762..29c4d1dc1f0d 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -905,7 +905,7 @@ static int cmd_sign_evm(struct command *cmd)
 	return do_cmd(cmd, sign_evm_path);
 }
 
-static int verify_evm(const char *file)
+static int verify_evm(struct public_key_entry *public_keys, const char *file)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
@@ -945,11 +945,13 @@ static int verify_evm(const char *file)
 		return mdlen;
 	assert(mdlen <= sizeof(hash));
 
-	return verify_hash(file, hash, mdlen, sig, len);
+	return imaevm_verify_hash(public_keys, file, imaevm_params.hash_algo,
+				  hash, mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
 {
+	struct public_key_entry *public_keys = NULL;
 	char *file = g_argv[optind++];
 	int err;
 
@@ -961,14 +963,22 @@ static int cmd_verify_evm(struct command *cmd)
 
 	if (imaevm_params.x509) {
 		if (imaevm_params.keyfile) /* Support multiple public keys */
-			init_public_keys(imaevm_params.keyfile);
+			err = imaevm_init_public_keys(imaevm_params.keyfile,
+						      &public_keys);
 		else			   /* assume read pubkey from x509 cert */
-			init_public_keys("/etc/keys/x509_evm.der");
+			err = imaevm_init_public_keys("/etc/keys/x509_evm.der",
+						      &public_keys);
+		if (err < 0) {
+			log_info("Failed loading public keys");
+			return err;
+		}
 	}
 
-	err = verify_evm(file);
+	err = verify_evm(public_keys, file);
 	if (!err && imaevm_params.verbose >= LOG_INFO)
 		log_info("%s: verification is OK\n", file);
+
+	imaevm_free_public_keys(public_keys);
 	return err;
 }
 
-- 
2.39.3


