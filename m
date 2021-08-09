Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702BD3E4CFC
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 21:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbhHITWd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 15:22:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235969AbhHITWa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 15:22:30 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179JLZrG068241;
        Mon, 9 Aug 2021 15:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mCjIYz+fifd+fTb+3aGtpnzzwUw9eSk+V/31fOgE/E8=;
 b=cysYrUeOJqlAt+yFzUz+IhugMqWf1ey4SIANZObObOMsuFAvdgTH7FvvVrfr6Vje/YUx
 wW0rBnlPMLkdHS8hCWtvd6y67mCIW58VWUquvHo2Wa681VQ3js/iaxOPGF4EUKYwl0Qk
 7MfITohdi8pJh0djpThCi4gQx44l+DqqpBu4xo3rrPrYaiJpSbV292YDAA1I7566IROk
 JX3g0eEirtZFD/RWXfWYdV4ClSGAWvFZPiO1Jwnr0yKVV7VRCF0Yvd8/plr1cVeruOqm
 +4SdE3PRJ625Zmzm89cHCQKopj2mh8wP1LHCX58pbVYfN0BDHeb7EBV8MHk6uTvzTqc4 vw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab8kjk6bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:22:09 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179JD1fw015299;
        Mon, 9 Aug 2021 19:22:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3a9htb4grh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:22:08 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179JM6R141615732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 19:22:06 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62987136068;
        Mon,  9 Aug 2021 19:22:06 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC89D13604F;
        Mon,  9 Aug 2021 19:22:05 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 19:22:05 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org
Cc:     nasastry@in.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>
Subject: [PATCH v4 2/2] tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status and define flag
Date:   Mon,  9 Aug 2021 15:21:59 -0400
Message-Id: <20210809192159.2176580-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mJxTcOB2z6lSRh-olochvjSVyAwjLWcB
X-Proofpoint-ORIG-GUID: mJxTcOB2z6lSRh-olochvjSVyAwjLWcB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_07:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 15 ++++++++-------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 7a9eca5768f8..5d795866b483 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -215,11 +215,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
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
@@ -232,7 +233,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	 * set the processing flag before the Hcall, since we may get the
 	 * result (interrupt) before even being able to check rc.
 	 */
-	ibmvtpm->tpm_processing_cmd = true;
+	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
 
 again:
 	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
@@ -250,7 +251,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 			goto again;
 		}
 		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
-		ibmvtpm->tpm_processing_cmd = false;
+		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 	}
 
 	spin_unlock(&ibmvtpm->rtce_lock);
@@ -266,7 +267,7 @@ static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 
-	return ibmvtpm->tpm_processing_cmd;
+	return ibmvtpm->tpm_status;
 }
 
 /**
@@ -454,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
 	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = true,
+	.req_complete_mask = TPM_STATUS_BUSY,
 	.req_complete_val = 0,
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
@@ -547,7 +548,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 		case VTPM_TPM_COMMAND_RES:
 			/* len of the data in rtce buffer */
 			ibmvtpm->res_len = be16_to_cpu(crq->len);
-			ibmvtpm->tpm_processing_cmd = false;
+			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 			wake_up_interruptible(&ibmvtpm->wq);
 			return;
 		default:
diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
index 51198b137461..252f1cccdfc5 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.h
+++ b/drivers/char/tpm/tpm_ibmvtpm.h
@@ -41,7 +41,8 @@ struct ibmvtpm_dev {
 	wait_queue_head_t wq;
 	u16 res_len;
 	u32 vtpm_version;
-	u8 tpm_processing_cmd;
+	u8 tpm_status;
+#define TPM_STATUS_BUSY		(1 << 0) /* vtpm is processing a command */
 };
 
 #define CRQ_RES_BUF_SIZE	PAGE_SIZE
-- 
2.31.1

