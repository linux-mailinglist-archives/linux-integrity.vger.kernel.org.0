Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09312205A12
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgFWSBd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 14:01:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732913AbgFWSBd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 14:01:33 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHWsNg056507;
        Tue, 23 Jun 2020 14:01:32 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ukmde089-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 14:01:31 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NHi8Nv012717;
        Tue, 23 Jun 2020 18:01:30 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 31uk4fsdvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 18:01:30 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NI1U8C61473234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 18:01:30 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E730D13605E;
        Tue, 23 Jun 2020 18:01:29 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FCC913604F;
        Tue, 23 Jun 2020 18:01:28 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.30.158])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 18:01:28 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     zohar@linux.ibm.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        mdrocco@linux.vnet.ibm.com, roberto.sassu@huawei.com,
        serge@hallyn.com
Subject: [PATCH v2] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Date:   Tue, 23 Jun 2020 14:01:22 -0400
Message-Id: <20200623180122.209-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1592856871.4987.21.camel@linux.ibm.com>
References: <1592856871.4987.21.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=897 clxscore=1015 priorityscore=1501
 suspectscore=1 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Maurizio <maurizio.drocco@ibm.com>

If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
them into the digest.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
Changelog:
v2:
- Always include PCRs 8 & 9 to non-sha1 hashes
v1:
- Include non-zero PCRs 8 & 9 to boot aggregates 

 src/evmctl.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1d065ce..46b7092 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 		}
 	}
 
+	if (strcmp(bank->algo_name, "sha1") != 0) {
+		for (i = 8; i < 10; i++) {
+			err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
+			if (!err) {
+				log_err("EVP_DigestUpdate() failed\n");
+				return;
+			}
+		}
+	}
+
 	err = EVP_DigestFinal(pctx, bank->digest, &mdlen);
 	if (!err) {
 		log_err("EVP_DigestFinal() failed\n");
@@ -1972,8 +1982,9 @@ static int append_bootaggr(char *bootaggr, struct tpm_bank_info *tpm_banks)
 /*
  * The IMA measurement list boot_aggregate is the link between the preboot
  * event log and the IMA measurement list.  Read and calculate all the
- * possible per TPM bank boot_aggregate digests based on the existing
- * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
+ * possible per TPM bank boot_aggregate digests based on the existing PCRs
+ * 0 - 9 to validate against the IMA boot_aggregate record. If the digest
+ * algorithm is SHA1, only PCRs 0 - 7 are considered to avoid ambiguity.
  */
 static int cmd_ima_bootaggr(struct command *cmd)
 {
-- 
2.17.1

