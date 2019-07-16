Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA776AA9A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPObE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 10:31:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726997AbfGPObE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 10:31:04 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GESHah118572
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 10:31:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tsf9vkq8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 10:31:02 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Jul 2019 15:31:00 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 15:30:59 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GEUvSK32047278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:30:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D44EC4C04A;
        Tue, 16 Jul 2019 14:30:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 216E24C052;
        Tue, 16 Jul 2019 14:30:57 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jul 2019 14:30:57 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/2] ima_evm_utils: erroneous "verification failed: 0 (invalid padding)" message
Date:   Tue, 16 Jul 2019 10:30:16 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19071614-4275-0000-0000-0000034D75C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071614-4276-0000-0000-0000385D881B
Message-Id: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When keys are not provided, the default key is used to verify the file
signature, resulting in this erroneous message.  Before using the default
key to verify the file signature, verify the keyid is correct.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index ae487f9fe36c..472ab53c7b42 100644
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
@@ -569,27 +572,25 @@ static int get_hash_algo_from_sig(unsigned char *sig)
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
+
 		/* Read pubkey from x509 cert */
-		x509 = 1;
+		if (!params.keyfile)
+			init_public_keys("/etc/keys/x509_evm.der");
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

