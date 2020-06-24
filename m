Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159DA207EB1
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404404AbgFXVgM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:36:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27062 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403996AbgFXVgM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:36:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OLV6Gb011486;
        Wed, 24 Jun 2020 17:36:03 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwys03jx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:36:03 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OLV6L8011493;
        Wed, 24 Jun 2020 17:36:02 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwys03jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:36:02 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OLFeKG018178;
        Wed, 24 Jun 2020 21:36:02 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 31uurt0n2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 21:36:02 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OLa1ZA36634894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 21:36:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F6B8B2064;
        Wed, 24 Jun 2020 21:36:01 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 801EFB205F;
        Wed, 24 Jun 2020 21:36:00 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.33.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jun 2020 21:36:00 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     bmeneg@redhat.com
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, maurizio.drocco@ibm.com,
        mdrocco@linux.vnet.ibm.com, roberto.sassu@huawei.com,
        serge@hallyn.com, stefanb@linux.ibm.com, zohar@linux.ibm.com
Subject: [PATCH v3] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Date:   Wed, 24 Jun 2020 17:35:58 -0400
Message-Id: <20200624213558.4265-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624213345.GB2639@glitch>
References: <20200624213345.GB2639@glitch>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_16:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=918
 adultscore=0 suspectscore=1 mlxscore=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Maurizio <maurizio.drocco@ibm.com>

cal_bootaggr should include PCRs 8-9 in non-SHA1 digests.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
Changelog:
v3:
- Fixed patch description
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

