Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9585ABB09
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Sep 2022 01:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIBXIY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 19:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiIBXIY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 19:08:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C332AF32C5
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 16:08:21 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282MprZX024611;
        Fri, 2 Sep 2022 23:08:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ACvGCS10ZUs4A/Ey5tLCkHiBPbs58mC8ksyY7E9Shi0=;
 b=p6xqkifNkseHbSI90LTjj/nbAiPuUJDREXftd9fHdi1z7BIl6md2z/1h2yN8HgztJagf
 v78Rjogi3z6vrfGNU0j5o0CdGUIomTQiuiD7VGHVjCGADtkDic+/KAyc4pqEfbtn7MVk
 wFickj3weHueGnAGq8FYd4od6qCX8FYXCelgHgppAtuKKd0HhQiZsNxsvHe/k+lscefu
 fdQQqLTC/Fi65FR36M9/69OT7Hop/eHCjmrscUH4IKS3rPB7kqkBfpsxuM5ADsN1nXEm
 S9QNyUFzcvObL2zTVCPZmfXVRKYzYVokVwqinQXLOvkt0w/GRux85NoMPdJfgI7hPDrK Xw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbu0gra7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 23:08:18 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282N6E0n026192;
        Fri, 2 Sep 2022 23:08:17 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3j7awadcfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 23:08:17 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282N8GDX2294290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 23:08:16 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0345112063;
        Fri,  2 Sep 2022 23:08:16 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E68112062;
        Fri,  2 Sep 2022 23:08:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.77.134.254])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 23:08:16 +0000 (GMT)
From:   Tergel Myanganbayar <tergel@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Tergel Myanganbayar <tergel@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tergel Myanganbayar <tergel@u.northwestern.edu>
Subject: [PATCH ima-evm-utils] add support for reading per bank TPM 2.0 PCRs via sysfs
Date:   Fri,  2 Sep 2022 19:08:15 -0400
Message-Id: <20220902230815.35448-1-tergel@linux.ibm.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sWV8j4gzj4rOOMC90pl_4h3eecg8N44N
X-Proofpoint-ORIG-GUID: sWV8j4gzj4rOOMC90pl_4h3eecg8N44N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Until Linux kernel version 5.11, a TSS was required to read TPM 2.0 PCR
values. A feature which exposed the per bank TPM 2.0 PCRs directly via
sysfs was upstreamed in newer Kernel versions.

Use this recent feature in IMA-EVM-UTILS to remove TSS dependency.

Signed-off-by: Tergel Myanganbayar <tergel@linux.ibm.com>
---
 src/evmctl.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 46a34cc..d5fe988 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1899,6 +1899,7 @@ static int read_one_bank(struct tpm_bank_info *tpm_bank, FILE *fp)
 
 static char *pcrs = "/sys/class/tpm/tpm0/device/pcrs";  /* Kernels >= 4.0 */
 static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
+static char tpm2_pcr_path[28] = "/sys/class/tpm/tpm0/pcr-sha";
 
 /* Read one of the TPM 1.2 sysfs files if present */
 static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
@@ -1922,7 +1923,55 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 	for (i = 1; i < num_banks; i++)
 		tpm_banks[i].supported = 0;
 	return 0;
+}
+
+static int read_tpm2_one_bank(struct tpm_bank_info *tpm_bank, int bank)
+{
+	FILE *fp;
+	char file_name[NAME_MAX];
+	char digest[MAX_DIGEST_SIZE + 1];
+	char *p;
+	int i;
+
+	for (i = 0; i < NUM_PCRS; i++) {
+		sprintf(file_name, "%s%d/%d", tpm2_pcr_path, bank, i);
+		fp = fopen(file_name, "r");
+		if (!fp)
+			return -1;
+
+		p = fgets(digest, (tpm_bank->digest_size * 2 + 1), fp);
+		if (!p)
+			return -1;
+
+		hex2bin(tpm_bank->pcr[i], digest, tpm_bank->digest_size);
+		fclose(fp);
+	}
+	return 0;
+}
+
+static int read_sysfs_tpm2_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+{
+	int banks[2] = {1, 256};
+	int rt, j;
+	int tpm_enabled = 0;
 
+	if (imaevm_params.verbose > LOG_INFO)
+		log_info("Trying to read TPM 2.0 PCRs via sysfs.\n");
+
+	for (j = 0; j < num_banks; j++) {
+		rt = read_tpm2_one_bank(&tpm_banks[j], banks[j]);
+		tpm_banks[j].supported = 0;
+
+		if (rt < 0)
+			continue;
+
+		tpm_enabled = 1;
+		tpm_banks[j].supported = 1;
+	}
+
+	if (tpm_enabled == 0)
+		return -1;
+	return 0;
 }
 
 /* Read PCRs from per-bank file(s) specified via --pcrs */
@@ -2008,6 +2057,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	if (read_sysfs_pcrs(num_banks, bank) == 0)
 		return 0;
 
+	if (read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
+		return 0;
+
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
 	if (!tpm2_pcr_supported()) {
 		log_debug("Failed to read TPM 2.0 PCRs\n");
@@ -2024,6 +2076,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 					    bank[i].pcr[pcr_handle],
 					    bank[i].digest_size,
 					    &errmsg);
+			bank[i].supported = 1;
 			if (err) {
 				log_debug("Failed to read %s PCRs: (%s)\n",
 					  bank[i].algo_name, errmsg);
-- 
2.32.1 (Apple Git-133)

