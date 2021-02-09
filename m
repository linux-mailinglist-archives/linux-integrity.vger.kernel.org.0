Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB9B3159F8
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 00:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbhBIXUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 18:20:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8616 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234118AbhBIWOy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 17:14:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 119MB5B2099937;
        Tue, 9 Feb 2021 17:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LJb2RhTGcey2XAuGiTPl+2s13U76TtD+RW9lxSMcY7k=;
 b=YV91Ibac8V2eQyzjhsRPlstuTGBt/G0KXlDmUU2876GsyIVKiT5rFqXmSNmVx0WzNM7s
 p+bfGKjHu7OabaOOREkkJtqM485/NoiBmWWcjsTlFy7YIkEnTVTAa8NLc7Xcsmi1ZeW7
 09NV2l3XgU76ed4pg4I7SsnvgmAC75ezivdi1kVS/RmN0M5JPMwu5VyOMfYPBuDXfwwQ
 1RTc0Y4HCoyxqKErXO/9Gi8Pw2S16rUvQzWN4YqmpuhzEMJdlRSSAI/VgbuhEp7sRb9b
 yvJazZKEaYamoc0uePN2oRKmJCXAZi8FiohMlRqYB0QZID7X+1bQW2yBIAh7If4IgW/T ng== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m24695v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:13:44 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 119MBijg101603;
        Tue, 9 Feb 2021 17:13:44 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36m24695uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 17:13:44 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 119MCm5x016181;
        Tue, 9 Feb 2021 22:13:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03dal.us.ibm.com with ESMTP id 36hjr9880y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 22:13:43 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 119MDgP819923368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 22:13:42 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 181F513607D;
        Tue,  9 Feb 2021 22:13:42 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885DA13605D;
        Tue,  9 Feb 2021 22:13:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  9 Feb 2021 22:13:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jarkko@kernel.org, peterhuewe@gmx.de,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: Avoid -EINTR error when IMA talks to TPM
Date:   Tue,  9 Feb 2021 17:13:39 -0500
Message-Id: <20210209221339.875739-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_07:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When IMA is taking measurements during compilation for example and a
user presses ctrl-c to abort the compilation, lots of these types of
messages will appear in the kernel log:

[ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
[ 7406.275242] ima: Error Communicating to TPM chip, result: -4

The issue is caused by the fact that the IBM vTPM driver's recv()
function is called immediately after send() without waiting for
status on whether a response was received. It currently waits for
the current command to finish using this call that ends up throwing
these error messages because it is 'interruptible':

sig = wait_event_interruptible(ibmvtpm->wq,
                               !ibmvtpm->tpm_processing_cmd);

Instead, it should be using the polling loop in tpm_try_transmit()
that uses a command's duration to poll until a result has been
returned by the TPM, thus ending when the timeout has occurred but
not responding to users' ctrl-c request anymore. To stay in this
polling loop we now extend tpm_ibmvtpm_status() to return
PM_STATUS_BUSY for as long as the vTPM is busy. Since we will need
the timeouts in this loop now we get the TPM 1.2 and TPM 2 timeouts
with tpm_get_timeouts().

We change tpm_processing_cmd to tpm_status and set the TPM_STATUS_BUSY
flag while the vTPM is busy processing a command.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Fixes: 18b3670d79ae9 ("tpm: ibmvtpm: Add support for TPM2")
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 31 ++++++++++++++++++-------------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 994385bf37c0..6290bd8889e4 100644
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
@@ -459,7 +457,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
 	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = 0,
+	.req_complete_mask = TPM_STATUS_BUSY,
 	.req_complete_val = 0,
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
@@ -552,7 +550,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 		case VTPM_TPM_COMMAND_RES:
 			/* len of the data in rtce buffer */
 			ibmvtpm->res_len = be16_to_cpu(crq->len);
-			ibmvtpm->tpm_processing_cmd = false;
+			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 			wake_up_interruptible(&ibmvtpm->wq);
 			return;
 		default:
@@ -690,8 +688,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
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
2.29.2

