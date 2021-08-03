Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72F3DF65D
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Aug 2021 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhHCU0n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Aug 2021 16:26:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhHCU0m (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Aug 2021 16:26:42 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173K4Ir8013434;
        Tue, 3 Aug 2021 16:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=S27uxvI2pwAJQtLsR9UGJeyznABvEv9jBk5FBJ/cBow=;
 b=CDzkenJBvoTkccesmiaihQaF+mMbZ+tfMCFX2bAQQCqD8gTdGL8s+YybJGLRlGGImZ8x
 ek141/rt6w4HdsXNOoWniNJxZvXCZH741EJUncbcOoR/Ec59ZlHf5012Y9eNA1Z771jd
 0cX3hEFnj0GBMQYQ/5xrST3SkxBAGhb+d1fkdKRKyfLiJSuirhXJz6+yj3yLxBSpeBKc
 5xFD4L1WMhHbpbgiFlp5nAiovDFGrdB2NFhsk7MWjcgtQ7oeswYDC+7QWUWXEfbmKu7n
 MqpzcuRMusNy3d6j7TJEdpQXE02IKwSClcXOMP6gJLIto2/qsMdx3DEewPtTlnZngaGg Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r5kb9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 16:26:29 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 173K4nEU015291;
        Tue, 3 Aug 2021 16:26:29 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a76r5kb9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 16:26:29 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173KHBFV018937;
        Tue, 3 Aug 2021 20:26:28 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3a4x5cfhfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 20:26:28 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173KQR0H51184054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 20:26:27 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E7A4AE064;
        Tue,  3 Aug 2021 20:26:27 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72798AE06A;
        Tue,  3 Aug 2021 20:26:27 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  3 Aug 2021 20:26:27 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH v2] tpm: ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Tue,  3 Aug 2021 16:26:22 -0400
Message-Id: <20210803202622.1537040-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HVsUldfjHVlMyGofX2GBhkA6klA4ztK2
X-Proofpoint-ORIG-GUID: SQObnDq0iy9VLTXX46i06fUi9od-XlHx
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_05:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030126
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
                               !ibmvtpm->tpm_processing_cmd);

Rather than waiting for the response in the low level driver, have it use
the polling loop in tpm_try_transmit() that uses a command's duration to
poll until a result has been returned by the TPM, thus ending when the
timeout has occurred but not responding to signals and ctrl-c anymore. To
stay in this polling loop extend tpm_ibmvtpm_status() to return
TPM_STATUS_BUSY for as long as the vTPM is busy. Since the loop requires
the TPM's timeouts, get them now using tpm_get_timeouts() after setting
the TPM2 version flag on the chip.

Rename the tpm_processing_cmd to tpm_status in ibmvtpm_dev and set the
TPM_STATUS_BUSY flag while the vTPM is busy processing a command.

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

v2:
 - reworded commit text
---
 drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 903604769de9..5d795866b483 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -106,17 +106,12 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 	u16 len;
-	int sig;
 
 	if (!ibmvtpm->rtce_buf) {
 		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
 		return 0;
 	}
 
-	sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
-	if (sig)
-		return -EINTR;
-
 	len = ibmvtpm->res_len;
 
 	if (count < len) {
@@ -220,11 +215,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
-	if (ibmvtpm->tpm_processing_cmd) {
+	if ((ibmvtpm->tpm_status & TPM_STATUS_BUSY)) {
 		dev_info(ibmvtpm->dev,
 		         "Need to wait for TPM to finish\n");
 		/* wait for previous command to finish */
-		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
+		sig = wait_event_interruptible(ibmvtpm->wq,
+				(ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);
 		if (sig)
 			return -EINTR;
 	}
@@ -237,7 +233,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	 * set the processing flag before the Hcall, since we may get the
 	 * result (interrupt) before even being able to check rc.
 	 */
-	ibmvtpm->tpm_processing_cmd = true;
+	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
 
 again:
 	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
@@ -255,7 +251,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 			goto again;
 		}
 		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
-		ibmvtpm->tpm_processing_cmd = false;
+		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 	}
 
 	spin_unlock(&ibmvtpm->rtce_lock);
@@ -269,7 +265,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
 
 static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
 {
-	return 0;
+	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
+
+	return ibmvtpm->tpm_status;
 }
 
 /**
@@ -457,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
 	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = 0,
+	.req_complete_mask = TPM_STATUS_BUSY,
 	.req_complete_val = 0,
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
@@ -550,7 +548,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 		case VTPM_TPM_COMMAND_RES:
 			/* len of the data in rtce buffer */
 			ibmvtpm->res_len = be16_to_cpu(crq->len);
-			ibmvtpm->tpm_processing_cmd = false;
+			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 			wake_up_interruptible(&ibmvtpm->wq);
 			return;
 		default:
@@ -688,8 +686,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
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
diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
index b92aa7d3e93e..252f1cccdfc5 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.h
+++ b/drivers/char/tpm/tpm_ibmvtpm.h
@@ -41,7 +41,8 @@ struct ibmvtpm_dev {
 	wait_queue_head_t wq;
 	u16 res_len;
 	u32 vtpm_version;
-	bool tpm_processing_cmd;
+	u8 tpm_status;
+#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
 };
 
 #define CRQ_RES_BUF_SIZE	PAGE_SIZE
-- 
2.31.1

