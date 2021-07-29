Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9228D3DA8C7
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhG2QTo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jul 2021 12:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231668AbhG2QTn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jul 2021 12:19:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TGIgJo006512;
        Thu, 29 Jul 2021 12:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=5Zxuck6xXSAocuv1PazxRDLordw2Ud4JT3bPChBew18=;
 b=Evzwb8pGE7dqwsQle25xqb0KHbnieh2V+cQPpxI3v009p8KlmOm1my9sOl4Dhrj1np4b
 nLfXxotdupITwn3TEZkGDtv62wAuJmDQmJJPuv9O8sbG0UzgvIWKKRMJmsVZQ4MtfAwj
 jS7h/N3j8OkCBXiyjjZRuYD9ydS1o+RGeYxx4tmrduVPqRtXO3tDo7zljoCTIlUbkyo9
 CTw179E+UyE9cjiJimkF+qfcg3+X5L3LSG9k/GnWZ9A660B++tj0apKNcfxASxO05Ll0
 NIHpfs2V1IsqkezcA3ogzsZMYyMWYzbGQe+vYrfIxR6LlIXNkeKJzrcDOnwl+JM1//cu 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3yqt012r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:19:38 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16TGJbk0013906;
        Thu, 29 Jul 2021 12:19:37 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a3yqt012e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 12:19:37 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16TGCwMX017362;
        Thu, 29 Jul 2021 16:19:37 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 3a235skfn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 16:19:37 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16TGJZhN42205594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jul 2021 16:19:35 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF222112062;
        Thu, 29 Jul 2021 16:19:35 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFC0A112072;
        Thu, 29 Jul 2021 16:19:35 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Jul 2021 16:19:35 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Thu, 29 Jul 2021 12:19:31 -0400
Message-Id: <20210729161931.3609894-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V3FyMKd6o9AAKRLhO-IlNn338K0xZY0W
X-Proofpoint-GUID: HnvNjbmutjbe-adenl_3hw59qTn9Lczq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_12:2021-07-29,2021-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107290101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

When rngd is run as root then lots of these types of message will appear
in the kernel log if the TPM has been configure to provide random bytes:

[ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4

The issue is caused by the following call that is interrupted while
waiting for the TPM's response.

sig = wait_event_interruptible(ibmvtpm->wq,
                               !ibmvtpm->tpm_processing_cmd);

Rather than waiting for the response in the low level driver, have it use
the polling loop in tpm_try_transmit() that uses a command's duration to
poll until a result has been returned by the TPM, thus ending when the
timeout has occurred but not responding to signals and ctrl-c anymore.
To stay in this polling loop we now extend tpm_ibmvtpm_status() to return
PM_STATUS_BUSY for as long as the vTPM is busy. Since we will need the
timeouts in this loop now we get the TPM 1.2 and TPM 2 timeouts with
tpm_get_timeouts().

Rename the tpm_processing_cmd to tpm_status in ibmvtpm_dev and set the
TPM_STATUS_BUSY flag while the vTPM is busy processing a command.

To recreat the issue start rngd like this:

sudo rngd -r /dev/hwrng -t

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1981473
Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
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

