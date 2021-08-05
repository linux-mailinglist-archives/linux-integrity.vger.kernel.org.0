Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1B3E1E2E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 23:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHEVx3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 17:53:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235464AbhHEVx1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 17:53:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175LoV3O017595;
        Thu, 5 Aug 2021 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=ZyoICrnkxQkw2owjShcf8xvHkTAw42OBHObumETu2Tc=;
 b=aliap+xQH8al1J9xsxvQ2MuwfnKSH+RKs7f2AyVqyOCdKn37cqBQL1tpRif8yxu1CUsr
 jgZN7JK6uE2lQbULNTCLd3YFmOzwFFioQmbyM2nBRarjmYmYu0Ev8pDXRFQF/t4qR7OX
 uNrFG4GoV/8SyMTD1YlICWVgPvYsi5ZF407GoGP4dFBJc4xRFpXc5ysh07rYqoCqB28j
 VZ7kRJtXnJbu3WP9fGD/0p7gJ2G2xqyJFXL3+U9oUK7pzfUkY/1gGfvIX9el+IhIke4L
 bIQ7dSqHzEo4KO1iUyl7/FAB1OUcF1gxinicwRa047qW6QtFOj/dfoizmqFibwm2izWn 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a8j8hap61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:10 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175LpDZO019169;
        Thu, 5 Aug 2021 17:53:10 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a8j8hap5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:10 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175LhHgd025561;
        Thu, 5 Aug 2021 21:53:09 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3a7vvaudxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 21:53:09 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175Lr7AM16515350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 21:53:07 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 661876E05B;
        Thu,  5 Aug 2021 21:53:07 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5FC16E064;
        Thu,  5 Aug 2021 21:53:06 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Aug 2021 21:53:06 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH v3 2/2] tpm: ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Thu,  5 Aug 2021 17:52:56 -0400
Message-Id: <20210805215256.1293987-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
References: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_3I9e3EApCbyRoF5w5fsVvYCJvSdieZ
X-Proofpoint-ORIG-GUID: eg3CDP9k6qipOGKBu0Zk6aHI46HcFLJq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_11:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

When rngd is run as root then lots of these types of message will appear
in the kernel log if the TPM has been configured to provide random bytes:

[ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4

The issue is caused by the following call that is interrupted while
waiting for the TPM's response.

sig = wait_event_interruptible(ibmvtpm->wq,
                        (ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);

Rather than waiting for the response in the low level driver, have it use
the polling loop in tpm_try_transmit() that uses a command's duration to
poll until a result has been returned by the TPM, thus ending when the
timeout has occurred but not responding to signals and ctrl-c anymore. To
stay in this polling loop extend tpm_ibmvtpm_status() to return
TPM_STATUS_BUSY for as long as the vTPM is busy. Since the loop requires
the TPM's timeouts, get them now using tpm_get_timeouts() after setting
the TPM2 version flag on the chip.

To recreat the resolved issue start rngd like this:

sudo rngd -r /dev/hwrng -t
sudo rngd -r /dev/tpm0 -t

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1981473
Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v3L
 - split for renaming of tpm_processing_cmd

v2:
 - reworded commit text
---
 drivers/char/tpm/tpm_ibmvtpm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index cd6457061a2e..5d795866b483 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -106,18 +106,12 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 	u16 len;
-	int sig;
 
 	if (!ibmvtpm->rtce_buf) {
 		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
 		return 0;
 	}
 
-	sig = wait_event_interruptible(ibmvtpm->wq,
-				(ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);
-	if (sig)
-		return -EINTR;
-
 	len = ibmvtpm->res_len;
 
 	if (count < len) {
@@ -271,7 +265,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
 
 static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
 {
-	return 0;
+	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
+
+	return ibmvtpm->tpm_status;
 }
 
 /**
@@ -459,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
 	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = 0,
+	.req_complete_mask = TPM_STATUS_BUSY,
 	.req_complete_val = 0,
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
@@ -690,8 +686,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 		goto init_irq_cleanup;
 	}
 
-	if (!strcmp(id->compat, "IBM,vtpm20")) {
+
+	if (!strcmp(id->compat, "IBM,vtpm20"))
 		chip->flags |= TPM_CHIP_FLAG_TPM2;
+
+	rc = tpm_get_timeouts(chip);
+	if (rc)
+		goto init_irq_cleanup;
+
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		rc = tpm2_get_cc_attrs_tbl(chip);
 		if (rc)
 			goto init_irq_cleanup;
-- 
2.31.1

