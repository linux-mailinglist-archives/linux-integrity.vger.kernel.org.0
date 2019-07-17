Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4298B6B371
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 03:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbfGQBhM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 21:37:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35798 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbfGQBhM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 21:37:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6H1agaX053495
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 21:37:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsqnmvu7c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 21:37:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 17 Jul 2019 02:37:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 17 Jul 2019 02:37:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6H1b4m152035678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 01:37:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F17B411C04A;
        Wed, 17 Jul 2019 01:37:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7558911C052;
        Wed, 17 Jul 2019 01:37:03 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.107])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jul 2019 01:37:03 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2] ima_evm_utils: erroneous "verification failed: 0 (invalid padding)" message
Date:   Tue, 16 Jul 2019 21:36:29 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19071701-0008-0000-0000-000002FE25F6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071701-0009-0000-0000-0000226B9DE9
Message-Id: <1563327389-28193-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-17_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170018
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When keys are not provided, the default key is used to verify the file
signature, resulting in this erroneous message.  Before using the default
key to verify the file signature, verify the keyid is correct.

This patch adds the public key from the default x509 certificate onto the
"public_keys" list.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    |  9 ++++++---
 src/libimaevm.c | 17 +++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 61808d276419..65cc5bd12bad 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -879,8 +879,10 @@ static int cmd_verify_ima(struct command *cmd)
 	char *file = g_argv[optind++];
 	int err;
 
-	if (params.keyfile)
+	if (params.keyfile)	/* Support multiple public keys */
 		init_public_keys(params.keyfile);
+	else			/* assume read pubkey from x509 cert */
+		init_public_keys("/etc/keys/x509_evm.der");
 
 	errno = 0;
 	if (!file) {
@@ -1602,9 +1604,10 @@ static int ima_measurement(const char *file)
 		return -1;
 	}
 
-	/* Support multiple public keys */
-	if (params.keyfile)
+	if (params.keyfile)	/* Support multiple public keys */
 		init_public_keys(params.keyfile);
+	else			/* assume read pubkey from x509 cert */
+		init_public_keys("/etc/keys/x509_evm.der");
 
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
 		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
diff --git a/src/libimaevm.c b/src/libimaevm.c
index ae487f9fe36c..afd21051b09a 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -302,6 +302,9 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
 
+	if (!keyfile)
+		return NULL;
+
 	fp = fopen(keyfile, "r");
 	if (!fp) {
 		log_err("Failed to open keyfile: %s\n", keyfile);
@@ -569,27 +572,21 @@ static int get_hash_algo_from_sig(unsigned char *sig)
 int verify_hash(const char *file, const unsigned char *hash, int size, unsigned char *sig,
 		int siglen)
 {
-	const char *key;
-	int x509;
+	const char *key = NULL;
 	verify_hash_fn_t verify_hash;
 
 	/* Get signature type from sig header */
 	if (sig[0] == DIGSIG_VERSION_1) {
 		verify_hash = verify_hash_v1;
+
 		/* Read pubkey from RSA key */
-		x509 = 0;
+		if (!params.keyfile)
+			key = "/etc/keys/pubkey_evm.pem";
 	} else if (sig[0] == DIGSIG_VERSION_2) {
 		verify_hash = verify_hash_v2;
-		/* Read pubkey from x509 cert */
-		x509 = 1;
 	} else
 		return -1;
 
-	/* Determine what key to use for verification*/
-	key = params.keyfile ? : x509 ?
-			"/etc/keys/x509_evm.der" :
-			"/etc/keys/pubkey_evm.pem";
-
 	return verify_hash(file, hash, size, sig, siglen, key);
 }
 
-- 
2.7.5

