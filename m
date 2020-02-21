Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D971686CB
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2020 19:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgBUSjU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Feb 2020 13:39:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18642 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgBUSjT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Feb 2020 13:39:19 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIKciu109979
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y9tkdacy1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2020 13:39:17 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Feb 2020 18:39:16 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 18:39:14 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LIdD6952953326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 18:39:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B6F4AE04D;
        Fri, 21 Feb 2020 18:39:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79A39AE045;
        Fri, 21 Feb 2020 18:39:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.88])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 21 Feb 2020 18:39:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 6/8] ima-evm-utils: compare re-calculated PCRs with the TPM values
Date:   Fri, 21 Feb 2020 13:38:56 -0500
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
References: <1582310338-1562-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20022118-0020-0000-0000-000003AC6646
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022118-0021-0000-0000-00002204717C
Message-Id: <1582310338-1562-7-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_06:2020-02-21,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210140
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

After walking the measurement list, re-calculating and extending the TPM
PCRs with the appropriate template digest for each bank, compare the
re-calculated PCR values for each TPM bank with the actual TPM values.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 3e512cf4e3d2..9e21d3963556 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1701,6 +1701,38 @@ static struct tpm_bank_info *init_tpm_banks(int *num_banks)
 	return banks;
 }
 
+static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
+			     struct tpm_bank_info *tpm_bank)
+{
+	int i, j;
+	int ret = 0;
+
+	for (i = 0; i < num_banks; i++) {
+		if (!bank[i].supported || !tpm_bank[i].supported)
+			continue;
+		for (j = 0; j < NUM_PCRS; j++) {
+			if (memcmp(bank[i].pcr[j], zero, bank[i].digest_size)
+			    == 0)
+				continue;
+			log_info("%s: PCRAgg  %d: ", bank[i].algo_name, j);
+			log_dump(bank[i].pcr[j], bank[i].digest_size);
+
+			log_info("%s: TPM PCR-%d: ", tpm_bank[i].algo_name, j);
+			log_dump(tpm_bank[i].pcr[j], tpm_bank[i].digest_size);
+
+			ret = memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
+				     bank[i].digest_size);
+			if (!ret)
+				log_info("%s PCR-%d: succeed\n",
+					 bank[i].algo_name, j);
+			else
+				log_info("%s: PCRAgg %d does not match TPM PCR-%d\n",
+					 bank[i].algo_name, i, i);
+		}
+	}
+	return ret;
+}
+
 /* Calculate the template hash for a particular hash algorithm */
 static int calculate_template_digest(EVP_MD_CTX *pctx, const EVP_MD *md,
 				     struct template_entry *entry,
@@ -1959,8 +1991,10 @@ static int ima_measurement(const char *file)
 
 	if (!verify_failed)
 		err = 0;
+	else if (read_tpm_banks(num_banks, tpm_banks) != 0)
+		log_info("Failed to read TPM 2.0 PCRs\n");
 	else
-		read_tpm_banks(num_banks, tpm_banks);
+		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
 
 out:
 	fclose(fp);
-- 
2.7.5

