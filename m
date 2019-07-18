Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD46D747
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2019 01:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfGRXal (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 19:30:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfGRXal (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 19:30:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6INRSjv110056
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 19:30:40 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tu0ct4a5n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 19:30:40 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 19 Jul 2019 00:30:37 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Jul 2019 00:30:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6INUKwX37159376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 23:30:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1248411C05B;
        Thu, 18 Jul 2019 23:30:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D38711C050;
        Thu, 18 Jul 2019 23:30:33 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.110.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jul 2019 23:30:33 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4] ima_evm_utils: erroneous "verification failed: 0 (invalid padding)" message
Date:   Thu, 18 Jul 2019 19:30:00 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19071823-0028-0000-0000-00000385D21C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071823-0029-0000-0000-00002445FD72
Message-Id: <1563492600-23396-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180234
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When public keys are specified on the boot command line (--key <public
key file>, [<public key file>, ...]), the appropriate public key is used
to verify EVM or file signatures.  If no keys are specified, the default
x509_evm.der or x509_evm.pem file is used to verify the DIGSIG_VERSION_2
or DIGSIG_VERSION_1 signatures respectively, without first checking the
keyids.  Instead of emitting a "verification failed: 0 (invalid
padding)" message, an "unknown keyid" message would be clearer.

To address this problem, when no public keys are specified, this patch
loads the x509_evm.der default public key onto the "public_keys" list,
while the x509_evm.pem continues to be passed to verify_hash_v1()

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog:
- reverted most of the v3 changes, but kept the patch description and the
cmd_verify_evm() change, in order to pick up Vitaly's patches.


 src/evmctl.c    | 14 +++++++++++---
 src/libimaevm.c | 17 +++++++----------
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 61808d276419..9e0926f10404 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -838,6 +838,11 @@ static int cmd_verify_evm(struct command *cmd)
 		return -1;
 	}
 
+	if (params.keyfile)	/* Support multiple public keys */
+		init_public_keys(params.keyfile);
+	else			/* assume read pubkey from x509 cert */
+		init_public_keys("/etc/keys/x509_evm.der");
+
 	err = verify_evm(file);
 	if (!err && params.verbose >= LOG_INFO)
 		log_info("%s: verification is OK\n", file);
@@ -879,8 +884,10 @@ static int cmd_verify_ima(struct command *cmd)
 	char *file = g_argv[optind++];
 	int err;
 
-	if (params.keyfile)
+	if (params.keyfile)	/* Support multiple public keys */
 		init_public_keys(params.keyfile);
+	else			/* assume read pubkey from x509 cert */
+		init_public_keys("/etc/keys/x509_evm.der");
 
 	errno = 0;
 	if (!file) {
@@ -1602,9 +1609,10 @@ static int ima_measurement(const char *file)
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

