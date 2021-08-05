Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468963E1E29
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Aug 2021 23:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhHEVx0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Aug 2021 17:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11422 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229987AbhHEVxZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Aug 2021 17:53:25 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 175LXQZr077545;
        Thu, 5 Aug 2021 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4NEO9Q341ShW7CdW39sUr17PHph2LQ6gy+/LkF1fJgk=;
 b=XzBty3khLpuw12T+B8PgJYGLM0C2AbHOWsbhVO7E7wyjtpwfYdfHNK8sBmGQgZqF0851
 +PP0gMTol7ErusK8sDg8gAA7btiBtUe5M2rl6V/mJzmpcKqSYkqcglkC8/2XSr27wyz2
 84n41bdMxbhNqujZI3PPYxVwxy0CnSX9iWI7sUx4bN4ljkgSIic37LFOmf3ERKzNYEgK
 xBpg6BU/vkr+LrxrDlf0d+iDOm1HwUsciKGiHIgZDOxcKzRo+RiyhAzpXNl10lH0B70a
 TN0v1LzcSPVovUewz2IIz0tOPIpgd4T5X0WyyF4bcliSpCNAW7ECJpFo81lgHLDySlV5 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8qaf9csw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:10 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 175LY7gZ081015;
        Thu, 5 Aug 2021 17:53:09 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a8qaf9csg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 17:53:09 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 175LpN1A016949;
        Thu, 5 Aug 2021 21:53:08 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3a77h53vhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Aug 2021 21:53:08 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 175Lr6wM9240890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Aug 2021 21:53:06 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE2116E05F;
        Thu,  5 Aug 2021 21:53:06 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A3296E05E;
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
        George Wilson <gcwilson@linux.ibm.com>
Subject: [PATCH v3 1/2] tpm: ibmvtpm: Rename tpm_process_cmd to tpm_status and define flag
Date:   Thu,  5 Aug 2021 17:52:55 -0400
Message-Id: <20210805215256.1293987-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
References: <20210805215256.1293987-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kcR_3yBxen3qt7XyMCddzr7uVu29hbL9
X-Proofpoint-ORIG-GUID: TzjMDi9T1IsJIzD7X8ygV7YJAABmMSue
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-05_11:2021-08-05,2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050127
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Rename the field tpm_processing_cmd to tpm_status in ibmvtpm_dev and set
the TPM_STATUS_BUSY flag while the vTPM is busy processing a command.

Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 14 ++++++++------
 drivers/char/tpm/tpm_ibmvtpm.h |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 903604769de9..cd6457061a2e 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -113,7 +113,8 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		return 0;
 	}
 
-	sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
+	sig = wait_event_interruptible(ibmvtpm->wq,
+				(ibmvtpm->tpm_status & TPM_STATUS_BUSY) == 0);
 	if (sig)
 		return -EINTR;
 
@@ -220,11 +221,12 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
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
@@ -237,7 +239,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	 * set the processing flag before the Hcall, since we may get the
 	 * result (interrupt) before even being able to check rc.
 	 */
-	ibmvtpm->tpm_processing_cmd = true;
+	ibmvtpm->tpm_status |= TPM_STATUS_BUSY;
 
 again:
 	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
@@ -255,7 +257,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 			goto again;
 		}
 		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
-		ibmvtpm->tpm_processing_cmd = false;
+		ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 	}
 
 	spin_unlock(&ibmvtpm->rtce_lock);
@@ -550,7 +552,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 		case VTPM_TPM_COMMAND_RES:
 			/* len of the data in rtce buffer */
 			ibmvtpm->res_len = be16_to_cpu(crq->len);
-			ibmvtpm->tpm_processing_cmd = false;
+			ibmvtpm->tpm_status &= ~TPM_STATUS_BUSY;
 			wake_up_interruptible(&ibmvtpm->wq);
 			return;
 		default:
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

