Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045555B10EC
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 02:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIHAZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 20:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHAZn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 20:25:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB86680E99
        for <linux-integrity@vger.kernel.org>; Wed,  7 Sep 2022 17:25:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 287Nv2ac031263;
        Thu, 8 Sep 2022 00:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hDlegQYjeBdHtowSJAt/SZjR/Y5XH8Zey1pvQbc+Vl8=;
 b=Vxgk93MyR30/Cv0oGt+r/Dzz78fu/CoWYqSvkurgsMa7a481LbbAXSznuXGt7kP23K8z
 5LSt4covwrviI09oB2t66KMTMI6w1P2zinou8e9/z3UmLD7H0oiWb2vLo5QUu5uIjzBU
 tWkB8uUAj+Iq7dq8nGIXK/fReItFiD0OnAJofTCISgjJYvCsGeeRYKrtlUura+GO0DP+
 yslqQ/U8WLhU+dw9Y319Ho2wGgRrt0ASWelmPMzy+SY9t7KxCrghAy6KtG/XoKI3yuLB
 wehzAJe8/uWLWh/pribR0TmHfDHDQ1TFkhdUUJuX3DDCxbWZqAemqZC1+bD/E6/vABCb dQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jf5dx0sv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:25:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2880M53B017599;
        Thu, 8 Sep 2022 00:25:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8vaea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 00:25:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2880PWGG37028170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 00:25:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45E7D4C050;
        Thu,  8 Sep 2022 00:25:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BAED4C046;
        Thu,  8 Sep 2022 00:25:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.160.65.6])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  8 Sep 2022 00:25:31 +0000 (GMT)
From:   Tergel Myanganbayar <tergel@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Tergel Myanganbayar <tergel@linux.ibm.com>,
        Tergel Myanganbayar <tergel@u.northwestern.edu>,
        Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2] add support for reading per bank TPM 2.0 PCRs via sysfs
Date:   Wed,  7 Sep 2022 20:25:00 -0400
Message-Id: <20220908002500.4710-1-tergel@linux.ibm.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1aSBoKR74YN7QPeHiJFkgQc-30JQtMSk
X-Proofpoint-ORIG-GUID: 1aSBoKR74YN7QPeHiJFkgQc-30JQtMSk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_10,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209070088
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
 src/evmctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 46a34cc..07209b6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1922,7 +1922,60 @@ static int read_sysfs_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
 	for (i = 1; i < num_banks; i++)
 		tpm_banks[i].supported = 0;
 	return 0;
+}
+
+static int read_tpm2_one_bank(struct tpm_bank_info *tpm_bank)
+{
+	FILE *fp;
+	char digest[MAX_DIGEST_SIZE + 1];
+	char file_name[NAME_MAX];
+	char *p;
+	int i;
+
+	for (i = 0; i < NUM_PCRS; i++) {
+		sprintf(file_name, "/sys/class/tpm/tpm0/pcr-%s/%d",
+			tpm_bank->algo_name, i);
+		fp = fopen(file_name, "r");
+		if (!fp)
+			return -1;
 
+		p = fgets(digest, tpm_bank->digest_size * 2 + 1, fp);
+		if (!p) {
+			fclose(fp);
+			return -1;
+		}
+
+		hex2bin(tpm_bank->pcr[i], digest, tpm_bank->digest_size);
+		fclose(fp);
+	}
+	return 0;
+}
+
+static int read_sysfs_tpm2_pcrs(int num_banks, struct tpm_bank_info *tpm_banks)
+{
+	int tpm_enabled = 0;
+	int rt, j;
+
+	if (imaevm_params.verbose > LOG_INFO)
+		log_info("Trying to read PCRs via sysfs.\n");
+
+	for (j = 0; j < num_banks; j++) {
+		rt = read_tpm2_one_bank(&tpm_banks[j]);
+		if (rt < 0) {
+			tpm_banks[j].supported = 0;
+			continue;
+		}
+		tpm_enabled = 1;
+	}
+
+	/* On failure to read any TPM bank PCRs, re-initialize the TPM banks*/
+	if (tpm_enabled == 0) {
+		for (j = 0; j < num_banks; j++)
+			tpm_banks[j].supported = 1;
+		return 1;
+	}
+
+	return 0;
 }
 
 /* Read PCRs from per-bank file(s) specified via --pcrs */
@@ -2008,6 +2061,9 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 	if (read_sysfs_pcrs(num_banks, bank) == 0)
 		return 0;
 
+	if (read_sysfs_tpm2_pcrs(num_banks, bank) == 0)
+		return 0;
+
 	/* Any userspace applications available for reading TPM 2.0 PCRs? */
 	if (!tpm2_pcr_supported()) {
 		log_debug("Failed to read TPM 2.0 PCRs\n");
-- 
2.32.1 (Apple Git-133)

