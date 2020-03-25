Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BF01932CD
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 22:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgCYVfW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 17:35:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbgCYVfT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 17:35:19 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PLY0Bg018627
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 17:35:18 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yxw7f5xf7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 17:35:18 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 21:35:13 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 21:35:10 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PLZCpY53936318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 21:35:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93AD511C050;
        Wed, 25 Mar 2020 21:35:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8837F11C052;
        Wed, 25 Mar 2020 21:35:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 21:35:11 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima-evm-utils: calculate the per TPM bank boot_aggregate
Date:   Wed, 25 Mar 2020 17:35:01 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20032521-0008-0000-0000-000003643ECD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032521-0009-0000-0000-00004A85B059
Message-Id: <1585172101-19501-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_11:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=3 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA measurement list boot_aggregate is the link between the preboot
event log and the IMA measurement list.  Read and calculate all the
possible per TPM bank boot_aggregate digests based on PCRs 0 - 7.

Reading the TPM PCRs requires root permission, unless access to the
device (/dev/tpm0 or /dev/tpmrm0) has been granted.

Prior to calculating the boot_aggregate, the TPM PCRs themselves should
be validated by walking the TPM event log and re-calculating the PCRs.
(Such a test should be included as part of the TSS regression testsuites.)

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 50258dd158fc..675980823636 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1900,6 +1900,77 @@ static int cmd_ima_measurement(struct command *cmd)
 	return ima_measurement(file);
 }
 
+static void calc_bootaggr(struct tpm_bank_info *bank)
+{
+	EVP_MD_CTX *pctx;
+	unsigned int mdlen;
+	const EVP_MD *md;
+#if OPENSSL_VERSION_NUMBER < 0x10100000
+	EVP_MD_CTX ctx;
+	pctx = &ctx;
+#else
+	pctx = EVP_MD_CTX_new();
+#endif
+	int err = 0;
+	int i;
+
+	md = EVP_get_digestbyname(bank->algo_name);
+
+	err = EVP_DigestInit(pctx, md);
+	if (!err) {
+		printf("EVP_DigestInit() failed\n");
+		goto out;
+	}
+
+	for (i = 0; i < 8;  i++) {
+		err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
+		if (!err) {
+			log_err("EVP_DigestUpdate() failed\n");
+			return;
+		}
+	}
+
+	err = EVP_DigestFinal(pctx, bank->digest, &mdlen);
+	if (!err) {
+		log_err("EVP_DigestFinal() failed\n");
+		goto out;
+	}
+
+out:
+	printf("%s:", bank->algo_name);
+	imaevm_hexdump(bank->digest, bank->digest_size);
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
+#endif
+}
+
+/*
+ * The IMA measurement list boot_aggregate is the link between the preboot
+ * event log and the IMA measurement list.  Read and calculate all the
+ * possible per TPM bank boot_aggregate digests based on the existing
+ * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
+ */
+static int cmd_ima_bootaggr(struct command *cmd)
+{
+	struct tpm_bank_info *tpm_banks;
+	int num_banks = 0;
+	int i;
+
+	tpm_banks = init_tpm_banks(&num_banks);
+
+	if (read_tpm_banks(num_banks, tpm_banks) != 0) {
+		log_info("Failed to read any TPM PCRs\n");
+		return -1;
+	}
+
+	for (i = 0; i < num_banks; i++) {
+		if (!tpm_banks[i].supported)
+			continue;
+		calc_bootaggr(&tpm_banks[i]);
+	}
+	return 0;
+}
+
 static void print_usage(struct command *cmd)
 {
 	printf("usage: %s %s\n", cmd->name, cmd->arg ? cmd->arg : "");
@@ -2015,6 +2086,7 @@ struct command cmds[] = {
 	{"ima_setxattr", cmd_setxattr_ima, 0, "[--sigfile file]", "Set IMA signature from sigfile\n"},
 	{"ima_hash", cmd_hash_ima, 0, "file", "Make file content hash.\n"},
 	{"ima_measurement", cmd_ima_measurement, 0, "file", "Verify measurement list (experimental).\n"},
+	{"ima_boot_aggregate", cmd_ima_bootaggr, 0, "", "Calculate per TPM bank boot_aggregate digests\n"},
 	{"ima_fix", cmd_ima_fix, 0, "[-t fdsxm] path", "Recursively fix IMA/EVM xattrs in fix mode.\n"},
 	{"ima_clear", cmd_ima_clear, 0, "[-t fdsxm] path", "Recursively remove IMA/EVM xattrs.\n"},
 	{"sign_hash", cmd_sign_hash, 0, "[--key key] [--pass [password]", "Sign hashes from shaXsum output.\n"},
-- 
2.7.5

