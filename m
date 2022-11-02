Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51335616CF8
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 19:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbiKBSpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiKBSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B22F67B
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 11:45:44 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IMklo028217
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PWs2AHLJL8xhcllbFVIM7JmUfUrg8HTvC7B5wjYrP2Y=;
 b=qrLMaj/BttxKfEvLmi/Rj51gX2UPtR9w8IzwYWxq8/flUMUpdyC+W5JvanNa995+5KvJ
 niO1d/6cEfN8fChPY57PW32Noh15t4gpM+9Fvfi+CdHaLD7BOIFaQ+qeXaolbxPunN9v
 vJnxZ0NkZp7zHooePsdjWnH3Mpr95xJV3fYqJYicbZYJgdSQ4bvbAUxSfDBAB8K5fc01
 M9FDtFXYZMkqB4segXSAp1f4kaUGZaCFk8xpSOGyCOAch7KF5ya7XxYFG3zkXDQKbAbv
 0/IowvscHEdgO4NLtG5Z/Xm3SgtBer5Ur3gvXNYlaZvsJBZeJQlMl7aK5G0V/pOGOKDg uA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkws2rmrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:43 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2Ia9eF017774
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:42 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3kguta4fp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2IjdVt25166166
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:45:39 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 176425805E;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C85F758055;
        Wed,  2 Nov 2022 18:45:40 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 18:45:40 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v1 1/4] Fix memory leaks of tpm_bank_info allocations
Date:   Wed,  2 Nov 2022 14:45:31 -0400
Message-Id: <20221102184534.1075049-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4GMhUPRwLM2MFjMW_jTAh-CuTrBUeS4q
X-Proofpoint-GUID: 4GMhUPRwLM2MFjMW_jTAh-CuTrBUeS4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 349215e..c2fe152 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1711,8 +1711,10 @@ static struct tpm_bank_info *init_tpm_banks(int *num_banks)
 	int i, j;
 
 	banks = calloc(num_algos, sizeof(struct tpm_bank_info));
-	if (!banks)
-		return banks;
+	if (!banks) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
 
 	/* re-calculate the PCRs digests for only known algorithms */
 	*num_banks = num_algos;
@@ -2083,8 +2085,8 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
 static int ima_measurement(const char *file)
 {
 	struct tpm_bank_info *pseudo_padded_banks;
-	struct tpm_bank_info *pseudo_banks;
-	struct tpm_bank_info *tpm_banks;
+	struct tpm_bank_info *pseudo_banks = NULL;
+	struct tpm_bank_info *tpm_banks = NULL;
 	int is_ima_template, cur_template_fmt;
 	int num_banks = 0;
 	int tpmbanks = 1;
@@ -2102,13 +2104,21 @@ static int ima_measurement(const char *file)
 	memset(zero, 0, MAX_DIGEST_SIZE);
 
 	pseudo_padded_banks = init_tpm_banks(&num_banks);
+	if (!pseudo_padded_banks)
+		return -1;
+
 	pseudo_banks = init_tpm_banks(&num_banks);
+	if (!pseudo_banks)
+		goto out_free;
+
 	tpm_banks = init_tpm_banks(&num_banks);
+	if (!tpm_banks)
+		goto out_free;
 
 	fp = fopen(file, "rb");
 	if (!fp) {
 		log_err("Failed to open measurement file: %s\n", file);
-		return -1;
+		goto out;
 	}
 
 	if (imaevm_params.keyfile)	/* Support multiple public keys */
@@ -2311,6 +2321,11 @@ static int ima_measurement(const char *file)
 
 out:
 	fclose(fp);
+out_free:
+	free(tpm_banks);
+	free(pseudo_banks);
+	free(pseudo_padded_banks);
+
 	return err;
 }
 
@@ -2556,6 +2571,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
 	 */
 	if (file) {
 		tpm_banks = init_tpm_banks(&num_banks);
+		if (!tpm_banks)
+			return -1;
 
 		/* TPM 1.2 only supports SHA1.*/
 		for (i = 1; i < num_banks; i++)
@@ -2565,12 +2582,19 @@ static int cmd_ima_bootaggr(struct command *cmd)
 		if (err) {
 			log_err("Failed reading the TPM 1.2 event log (%s)\n",
 				file);
+			free(tpm_banks);
+
 			return -1;
 		}
 	} else {
 		tpm_banks = init_tpm_banks(&num_banks);
+		if (!tpm_banks)
+			return -1;
+
 		if (read_tpm_banks(num_banks, tpm_banks) != 0) {
 			log_info("Failed to read any TPM PCRs\n");
+			free(tpm_banks);
+
 			return -1;
 		}
 	}
@@ -2604,7 +2628,10 @@ static int cmd_ima_bootaggr(struct command *cmd)
 	}
 	bootaggr[bootaggr_len] = '\0';
 	printf("%s", bootaggr);
+
 	free(bootaggr);
+	free(tpm_banks);
+
 	return 0;
 }
 
-- 
2.38.1

