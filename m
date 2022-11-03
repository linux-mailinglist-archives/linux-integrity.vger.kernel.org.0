Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4054D6187AF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKCSjZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKCSjY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA152DE7
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:23 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IAUYk026995;
        Thu, 3 Nov 2022 18:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VZiTnDEE4sThFcQnHekhpoTB+Lipx63Bf2mxNtmEOh8=;
 b=OGdt8UuzYgf66pPKq5is9eTvvDxbuC/4w8oAsg+ZVVrmKATVuZYr1PqgC41rbyIO0hjq
 XVDjsOy6sNxq/6+WuNj/6T9v+nRfETJF79J2C0tV9DFo/kZtMOaESrHN6/AIjnNjLZSF
 vHi6lpoXc1RP28c5rPJThN9fJi+8CIWletx1yrc+StuvVwM2j3bKyRh0HWWm6ZJ8fGjb
 hP9/otRqBa/DmuwOg258FZkX13Z//RvRK7e0TLRzQXFXKQXRDneLNyr9TJg1IvTxOw9F
 dkjtNw0R1vdzAgt0G0ZAehkYRs/QHryhEKst9uEPnSCzoDqpoSQxsgi+znbgaVCSlBBm vA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmfxyyr97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3Iapqq005420;
        Thu, 3 Nov 2022 18:39:17 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9974k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IXfRl50004404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:33:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA4A04203F;
        Thu,  3 Nov 2022 18:39:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 022D742042;
        Thu,  3 Nov 2022 18:39:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 02/17] log and reset 'errno' after failure to open non-critical files
Date:   Thu,  3 Nov 2022 14:38:49 -0400
Message-Id: <20221103183904.103562-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nD8GvXotgowX1yuIG0ssvbff8Eepu3E-
X-Proofpoint-ORIG-GUID: nD8GvXotgowX1yuIG0ssvbff8Eepu3E-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Define a log_errno_reset macro to emit the errno string at or near the
time of error, similar to the existing log_errno macro, but also reset
errno to avoid dangling or duplicate errno messages on exit.

The initial usage is for non-critical file open failures.

Suggested-by: Vitaly Chikunov <vt@altlinux.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 0412bc0ac2b0..54123bf20f03 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -166,6 +166,9 @@ struct tpm_bank_info {
 static char *pcrfile[MAX_PCRFILE];
 static unsigned npcrfile;
 
+#define log_errno_reset(level, fmt, args...) \
+	{do_log(level, fmt " (errno: %s)\n", ##args, strerror(errno)); errno = 0; }
+
 static int bin2file(const char *file, const char *ext, const unsigned char *data, int len)
 {
 	FILE *fp;
@@ -1911,8 +1914,10 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 	fp = fopen(pcrs, "r");
 	if (!fp)
 		fp = fopen(misc_pcrs, "r");
-	if (!fp)
+	if (!fp) {
+		log_errno_reset(LOG_DEBUG, "Failed to read TPM 1.2 PCRs");
 		return -1;
+	}
 
 	result = read_one_bank(&tpm_banks[0], fp);
 	fclose(fp);
@@ -2055,7 +2060,6 @@ static int ima_measurement(const char *file)
 	int err_padded = -1;
 	int err = -1;
 
-	errno = 0;
 	memset(zero, 0, MAX_DIGEST_SIZE);
 
 	pseudo_padded_banks = init_tpm_banks(&num_banks);
@@ -2072,6 +2076,8 @@ static int ima_measurement(const char *file)
 		init_public_keys(imaevm_params.keyfile);
 	else				/* assume read pubkey from x509 cert */
 		init_public_keys("/etc/keys/x509_evm.der");
+	if (errno)
+		log_errno_reset(LOG_DEBUG, "Failed to initialize public keys");
 
 	/*
 	 * Reading the PCRs before walking the IMA measurement list
@@ -2746,6 +2752,8 @@ int main(int argc, char *argv[])
 	unsigned long keyid;
 	char *eptr;
 
+	errno = 0;	/* initialize global errno */
+
 #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
 	OPENSSL_init_crypto(
 #ifndef DISABLE_OPENSSL_CONF
-- 
2.31.1

