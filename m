Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07951FFC5A
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jun 2020 22:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgFRUMo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jun 2020 16:12:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728027AbgFRUMo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 16:12:44 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IK4KR0179981;
        Thu, 18 Jun 2020 16:12:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rb6a7jr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 16:12:22 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05IK5xcs185222;
        Thu, 18 Jun 2020 16:12:22 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rb6a7jqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 16:12:22 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05IKAngT004244;
        Thu, 18 Jun 2020 20:12:21 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 31rd958vsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Jun 2020 20:12:21 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05IKCKG048169234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jun 2020 20:12:20 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40352AE05C;
        Thu, 18 Jun 2020 20:12:20 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F2A8AE060;
        Thu, 18 Jun 2020 20:12:19 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.61.88])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Jun 2020 20:12:19 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     roberto.sassu@huawei.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        serge@hallyn.com, zohar@linux.ibm.com, mdrocco@linux.vnet.ibm.com
Subject: [PATCH] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Date:   Thu, 18 Jun 2020 16:11:26 -0400
Message-Id: <20200618201126.2081-2-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618201126.2081-1-maurizio.drocco@ibm.com>
References: <b744c1b79ba14a17a786f5de04c1f3c4@huawei.com>
 <20200618201126.2081-1-maurizio.drocco@ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=937 phishscore=0
 impostorscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006180148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Maurizio <maurizio.drocco@ibm.com>

If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
them into the digest.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
 src/evmctl.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1d065ce..554571e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1930,6 +1930,18 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 		}
 	}
 
+	if (strcmp(bank->algo_name, "sha1") != 0) {
+		for (i = 8; i < 10; i++) {
+			if (memcmp(bank->pcr[i], zero, bank->digest_size) != 0) {
+				err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
+				if (!err) {
+					log_err("EVP_DigestUpdate() failed\n");
+					return;
+				}
+			}
+		}
+	}
+
 	err = EVP_DigestFinal(pctx, bank->digest, &mdlen);
 	if (!err) {
 		log_err("EVP_DigestFinal() failed\n");
@@ -1973,7 +1985,9 @@ static int append_bootaggr(char *bootaggr, struct tpm_bank_info *tpm_banks)
  * The IMA measurement list boot_aggregate is the link between the preboot
  * event log and the IMA measurement list.  Read and calculate all the
  * possible per TPM bank boot_aggregate digests based on the existing
- * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
+ * PCRs 0 - 9 to validate against the IMA boot_aggregate record. If PCRs
+ * 8 - 9 are not set (i.e. all-zeros) or the digest algorithm is SHA1, only
+ * PCRs 0 - 7 are considered.
  */
 static int cmd_ima_bootaggr(struct command *cmd)
 {
-- 
2.17.1

