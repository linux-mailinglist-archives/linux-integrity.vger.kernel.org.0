Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73616152FD
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKAUSY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiKAUSX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:23 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213D510B0
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:22 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1IL85U031986;
        Tue, 1 Nov 2022 20:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VZiTnDEE4sThFcQnHekhpoTB+Lipx63Bf2mxNtmEOh8=;
 b=eO6OK/BoscE8uRz2wctsZkpm/zg//hk2ZURbpyPd6EtvmXe9z4We5Do/3PZpE24oEyt4
 7dkA6gkWsQVV1dPBy12502x7ykc+/HqbTUGXI6XvDkV9IVgn4wwCjpgZAr3EY3wAgN5z
 XmQVw5NUyUt/3R1sN86PSZvZyMwG7VQpPFjmuqy+JoVoLZa2yi0ty9VE8pWFXbXkHMtA
 g++G2K6ZLbw99z/dGyngTmINq3rGyU1cLLn8iurvK/WBbOwWF316VDjtZvoAguWb8yN4
 E9jBCc11JOmJDvsPUYlGA+cTbFqQz6hBl+dcU0rwgPX3wAOxGyuidl23YwYzmaLJx1X8 Yg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjw7ubhxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:14 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K7DWP028524;
        Tue, 1 Nov 2022 20:18:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3kgut9bwhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:12 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KIkl713631858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAB63A405F;
        Tue,  1 Nov 2022 20:18:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11777A4054;
        Tue,  1 Nov 2022 20:18:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:08 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 02/17] log and reset 'errno' after failure to open non-critical files
Date:   Tue,  1 Nov 2022 16:17:48 -0400
Message-Id: <20221101201803.372652-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aO4awrvqwtCiGoAmMnzyuoe9wq9pgnu1
X-Proofpoint-GUID: aO4awrvqwtCiGoAmMnzyuoe9wq9pgnu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211010143
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

