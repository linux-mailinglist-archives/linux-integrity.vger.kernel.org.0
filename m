Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C68B3C606F
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhGLQ2A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 12:28:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233719AbhGLQ17 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 12:27:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16CG3m2t172344;
        Mon, 12 Jul 2021 12:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UROfSqQwvdh21eBG4v+9kqE03iACV/yRY/pRhj07gTU=;
 b=RBENKBE1nduXCNo5kVKcr/rf3w5EQTp+o9E21ubvz4aO1WBWQsEOD6ZXYYpZ1sRSXSNt
 YtP/wnNOJgkXVtLoj6rAmqeqFjC5kRJyXcrkDehA7H2MBDpCT7Ut9PUHIA5DvUBAPdzg
 GR7B/7RQPChWmjlLO5xF4vcyA3NIQLOym37rQg5yRz3rHRoe1ZpeW9u0DEMO8ohIGXfg
 ssNV1xdwdESG1vlNiXsQribi9cRfKF2cyM2lkBdHKP2CFW3+O2Ao5LIg7HxXulhEv1Tj
 dK5hzU2yVv12SBKtzQ7vKMzIVIXjE8zwCo5QegelkJD/lJTTUtOdufvLclMVWuClCUvc kA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrf78259-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 12:25:10 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16CG4Djs174082;
        Mon, 12 Jul 2021 12:25:09 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrf7824g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 12:25:09 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16CGHOBb015811;
        Mon, 12 Jul 2021 16:25:08 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 39q36b97y4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jul 2021 16:25:08 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16CGP7Pv40632654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jul 2021 16:25:07 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C429112065;
        Mon, 12 Jul 2021 16:25:07 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CFEB112062;
        Mon, 12 Jul 2021 16:25:07 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 12 Jul 2021 16:25:07 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Mon, 12 Jul 2021 12:25:05 -0400
Message-Id: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KqhbcAIHfhqht3bpdAe-BA8-bSBCTZLz
X-Proofpoint-GUID: -xxLZQg3vsEtGn4ehvzhCPK2AVYLno5t
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-12_09:2021-07-12,2021-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107120122
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

The solution is to use wait_event() instead.

To recreat the issue start rngd like this:

sudo rngd -r /dev/hwrng -t

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1981473
Fixes: 6674ff145eef ("tpm_ibmvtpm: properly handle interrupted packet receptions")
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: George Wilson <gcwilson@linux.ibm.com>
Reported-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 903604769de9..99b0442a5fdf 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -106,16 +106,13 @@ static int tpm_ibmvtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
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
+	wait_event(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
 
 	len = ibmvtpm->res_len;
 
@@ -206,7 +203,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 	bool retry = true;
-	int rc, sig;
+	int rc;
 
 	if (!ibmvtpm->rtce_buf) {
 		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
@@ -224,9 +221,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		dev_info(ibmvtpm->dev,
 		         "Need to wait for TPM to finish\n");
 		/* wait for previous command to finish */
-		sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
-		if (sig)
-			return -EINTR;
+		wait_event(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);
 	}
 
 	spin_lock(&ibmvtpm->rtce_lock);
@@ -551,7 +546,7 @@ static void ibmvtpm_crq_process(struct ibmvtpm_crq *crq,
 			/* len of the data in rtce buffer */
 			ibmvtpm->res_len = be16_to_cpu(crq->len);
 			ibmvtpm->tpm_processing_cmd = false;
-			wake_up_interruptible(&ibmvtpm->wq);
+			wake_up(&ibmvtpm->wq);
 			return;
 		default:
 			return;
-- 
2.31.1

