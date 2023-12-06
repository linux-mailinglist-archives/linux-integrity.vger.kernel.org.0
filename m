Return-Path: <linux-integrity+bounces-365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08DF8078A0
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 20:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB8B282153
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Dec 2023 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8047F50;
	Wed,  6 Dec 2023 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ai7L/SFW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AD71705
	for <linux-integrity@vger.kernel.org>; Wed,  6 Dec 2023 11:28:16 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6I6vTN032547
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cKAmdkcODZ25lYH68cF5dYSc+em6si6O0+Wd+QwwAeo=;
 b=ai7L/SFWtWypdWuLssY7MLr9wYzVkecTaset8BzK4L20v2rki+ER/BQQ5OgRsNdTQMAJ
 oieAX8TGuHlHc1189+RZbmpbpZezh9tej/sGDorbfntyit+/AW3Zi5SfldhPGaN8kgW3
 QpuMy1iOUELd/VNLbVcqjDERpk3RAx9E9LgC0OOK4cL8j/lw2lOau7JOB6TArGS723cr
 veN5ahlxusYspUdsnB40hsXL7MNlsd/KoZ2p+uQ82BuQtwWW0RrxBCUR/kP5QPb5BEnJ
 S9JbMO1Q2RBJZYdVnFi/jiRrBv1WQ/jDqQHb58tUafitUpTspg5Mh52S6dx3hsZeHkvi gQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utv6qwmbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6IY6N5028450
	for <linux-integrity@vger.kernel.org>; Wed, 6 Dec 2023 19:28:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavjpjha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 06 Dec 2023 19:28:14 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6JSBv644630360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 19:28:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C7820040;
	Wed,  6 Dec 2023 19:28:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AF202004B;
	Wed,  6 Dec 2023 19:28:10 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.99.183])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 19:28:10 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v2 06/13] Update cmd_verify_evm to define and use a local list of public keys
Date: Wed,  6 Dec 2023 14:27:27 -0500
Message-Id: <20231206192734.339999-7-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: ayHAHGg4rUCOywzlsu9yHixVGt5knWWU
X-Proofpoint-ORIG-GUID: ayHAHGg4rUCOywzlsu9yHixVGt5knWWU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060141

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
index 3ae79262efbb..06cdffdd3755 100644
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
+	return imaevm_verify_hash(public_keys, file, imaevm_params.hash_algo,
+				  hash, mdlen, sig, len);
 }
 
 static int cmd_verify_evm(struct command *cmd)
 {
 	char *file = g_argv[optind++];
+	void *public_keys = NULL;
 	int err;
 
 	if (!file) {
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


