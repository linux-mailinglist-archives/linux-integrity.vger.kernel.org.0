Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE95A1686CC
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgBUSjV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgBUSjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LILxM5105671
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:20 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y9sbvsv5g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:20 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:18 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:16 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LIdFhH57475178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:15 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3965AE045;
        Fri, 21 Feb 2020 18:39:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFD08AE04D;
        Fri, 21 Feb 2020 18:39:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:14 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 8/8] ima-evm-utils: remove TPM 1.2 specific code
Date:   Fri, 21 Feb 2020 13:38:58 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-4275-0000-0000-000003A443FC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-4276-0000-0000-000038B853EB
Message-Id: <1582310338-1562-9-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=4
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Now that read_tpm_banks() reads the TPM 1.2 PCRs, remove the TPM 1.2
specific code for reading and verifying the SHA1 PCRs.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 64 +++---------------------------------------------------------
 1 file changed, 3 insertions(+), 61 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 49ce7ea2ce1a..b6b9d19749e6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1493,19 +1493,6 @@ static uint8_t fox[MAX_DIGEST_SIZE];
 
 int validate = 1;
 
-void ima_extend_pcr(uint8_t *pcr, uint8_t *digest, int length)
-{
-	SHA_CTX ctx;
-
-	SHA1_Init(&ctx);
-	SHA1_Update(&ctx, pcr, length);
-	if (validate && !memcmp(digest, zero, length))
-		SHA1_Update(&ctx, fox, length);
-	else
-		SHA1_Update(&ctx, digest, length);
-	SHA1_Final(pcr, &ctx);
-}
-
 static int ima_verify_template_hash(struct template_entry *entry)
 {
 	uint8_t digest[SHA_DIGEST_LENGTH];
@@ -1910,21 +1897,14 @@ static int ima_measurement(const char *file)
 	struct tpm_bank_info *tpm_banks;
 	int num_banks = 0;
 
-	uint8_t pcr[NUM_PCRS][SHA_DIGEST_LENGTH] = {{0}};
-	uint8_t hwpcr[SHA_DIGEST_LENGTH];
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
 	int err = -1;
-	bool verify_failed = false;
-	int i;
 
 	errno = 0;
 	memset(zero, 0, MAX_DIGEST_SIZE);
 	memset(fox, 0xff, MAX_DIGEST_SIZE);
 
-	log_debug("Initial PCR value: ");
-	log_debug_dump(pcr, sizeof(pcr));
-
 	pseudo_banks = init_tpm_banks(&num_banks);
 	tpm_banks = init_tpm_banks(&num_banks);
 
@@ -1940,9 +1920,6 @@ static int ima_measurement(const char *file)
 		init_public_keys("/etc/keys/x509_evm.der");
 
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
-		ima_extend_pcr(pcr[entry.header.pcr], entry.header.digest,
-			       SHA_DIGEST_LENGTH);
-
 		if (!fread(entry.name, entry.header.name_len, 1, fp)) {
 			log_err("Unable to read template name\n");
 			goto out;
@@ -1977,47 +1954,12 @@ static int ima_measurement(const char *file)
 			ima_ng_show(&entry);
 	}
 
-
-	for (i = 0; i < NUM_PCRS; i++) {
-		if (memcmp(pcr[i], zero, SHA_DIGEST_LENGTH) == 0)
-			continue;
-
-		log_info("PCRAgg %.2d: ", i);
-		log_dump(pcr[i], SHA_DIGEST_LENGTH);
-
-		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
-#ifdef HAVE_TSSPCRREAD
-			char *errmsg = NULL;
-
-			err = tpm2_pcr_read("sha1", i, hwpcr, sizeof(hwpcr),
-					    &errmsg);
-			if (err) {
-				log_info("Failed to read PCRs: (%s)\n", errmsg);
-				free(errmsg);
-				exit(1);
-			}
-#else
-			log_info("Failed to read TPM 1.2 PCRs.\n");
-			exit(1);
-#endif
-		}
-
-		log_info("HW PCR-%d: ", i);
-		log_dump(hwpcr, sizeof(hwpcr));
-
-		if (memcmp(pcr[i], hwpcr, sizeof(SHA_DIGEST_LENGTH)) != 0) {
-			log_err("PCRAgg %d does not match HW PCR-%d\n", i, i);
-
-			verify_failed = true;
-		}
-	}
-
-	if (!verify_failed)
+	if (read_tpm_banks(num_banks, tpm_banks) != 0) {
 		err = 0;
-	if (read_tpm_banks(num_banks, tpm_banks) != 0)
 		log_info("Failed to read any TPM PCRs\n");
-	else
+	} else {
 		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
+	}
 
 out:
 	fclose(fp);
-- 
2.7.5

