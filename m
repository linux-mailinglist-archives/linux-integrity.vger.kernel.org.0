Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811421FB71B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 17:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgFPPnt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 11:43:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20160 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731853AbgFPPns (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 11:43:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05GF40A6193988
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 11:43:47 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31phf5uw1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 11:43:47 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05GFJHEm022988
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 15:43:46 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 31pe8p4nes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jun 2020 15:43:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05GFgjqk37880298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 15:42:45 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EE3AAC05F;
        Tue, 16 Jun 2020 15:42:45 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B56AAC05B;
        Tue, 16 Jun 2020 15:42:45 +0000 (GMT)
Received: from DESKTOP-AV6EVPG.localdomain (unknown [9.160.15.214])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jun 2020 15:42:45 +0000 (GMT)
From:   Maurizio Drocco <maurizio.drocco@ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Maurizio <maurizio.drocco@ibm.com>
Subject: [PATCH] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Date:   Tue, 16 Jun 2020 08:02:28 -0400
Message-Id: <20200616120228.16068-1-maurizio.drocco@ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-16_04:2020-06-16,2020-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 impostorscore=0 lowpriorityscore=0 suspectscore=1
 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=784 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Maurizio <maurizio.drocco@ibm.com>

If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
them into the digest.

Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
---
 src/evmctl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1d065ce..701d643 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
 		}
 	}
 
+	for (i = 8; i < 10; i++) {
+		if (memcmp(bank->pcr[i], zero, bank->digest_size) != 0) {
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
@@ -1973,7 +1983,8 @@ static int append_bootaggr(char *bootaggr, struct tpm_bank_info *tpm_banks)
  * The IMA measurement list boot_aggregate is the link between the preboot
  * event log and the IMA measurement list.  Read and calculate all the
  * possible per TPM bank boot_aggregate digests based on the existing
- * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
+ * PCRs 0 - 9 to validate against the IMA boot_aggregate record. If PCRs
+ * 8 - 9 are not set (i.e. all-zeros), only PCRs 0 - 7 are considered.
  */
 static int cmd_ima_bootaggr(struct command *cmd)
 {
-- 
2.17.1

