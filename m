Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5333E4CFE
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 21:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhHITWi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 15:22:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235965AbhHITWa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 15:22:30 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179JLgtx056246;
        Mon, 9 Aug 2021 15:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=oyV51m1px533fnkHQvqymjDjbzWJqzXaZyG4+plvQK8=;
 b=Osq6d81TO4519w3PhJ0KargYnQKXsFLTWw4JkCJQZO805UEY4Qhg5MC8qJDJtGk3ftKB
 7rRV4VgMp7q/NBrxZLBC+ZkmAXnbHYbi4mRX4OQ0CiSQ+02nos9M92BplfyUbfC8YjkD
 m8GD3bRyJfLjP+rEWRuD78IzlB5s92fbNegrwXu6Nl42hjkODcMYkKIXxlijkRGHEAfn
 h++pNpGemIKKqmRj9vQlm09QfgFuoRzVR5GCpOQpEFi+dmpx+OWTpWySDZt+zqWnDioi
 cdSDA7ygsnuwgfyII3OxCTZlBhleY9kD69XN5tgP2yQWy+06dv4cSLsqvOhEBww/qV/o sA== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3aa736thya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 15:22:09 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179JCaQT000662;
        Mon, 9 Aug 2021 19:22:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma05wdc.us.ibm.com with ESMTP id 3a9htavk95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 19:22:07 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179JM5iN27459932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 19:22:06 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDCB2136065;
        Mon,  9 Aug 2021 19:22:05 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D01C13604F;
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
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH v4 1/2] tpm: ibmvtpm: Avoid error message when process gets signal while waiting
Date:   Mon,  9 Aug 2021 15:21:58 -0400
Message-Id: <20210809192159.2176580-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
References: <20210809192159.2176580-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hNPOxCGVewa7FsnQjag2MaxEeeeAns0O
X-Proofpoint-ORIG-GUID: hNPOxCGVewa7FsnQjag2MaxEeeeAns0O
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_07:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090135
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

When rngd is run as root then lots of these types of message will appear
in the kernel log if the TPM has been configured to provide random bytes:

[ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4

The issue is caused by the following call that is interrupted while
waiting for the TPM's response.

sig = wait_event_interruptible(ibmvtpm->wq, !ibmvtpm->tpm_processing_cmd);

Rather than waiting for the response in the low level driver, have it use
the polling loop in tpm_try_transmit() that uses a command's duration to
poll until a result has been returned by the TPM, thus ending when the
timeout has occurred but not responding to signals and ctrl-c anymore. To
stay in this polling loop extend tpm_ibmvtpm_status() to return
'true' for as long as the vTPM is indicated as being busy in
tpm_processing_cmd. Since the loop requires the TPM's timeouts, get them
now using tpm_get_timeouts() after setting the TPM2 version flag on the
chip.

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
 drivers/char/tpm/tpm_ibmvtpm.c | 20 ++++++++++++--------
 drivers/char/tpm/tpm_ibmvtpm.h |  2 +-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 903604769de9..7a9eca5768f8 100644
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
@@ -269,7 +264,9 @@ static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
 
 static u8 tpm_ibmvtpm_status(struct tpm_chip *chip)
 {
-	return 0;
+	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
+
+	return ibmvtpm->tpm_processing_cmd;
 }
 
 /**
@@ -457,7 +454,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
 	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = 0,
+	.req_complete_mask = true,
 	.req_complete_val = 0,
 	.req_canceled = tpm_ibmvtpm_req_canceled,
 };
@@ -688,8 +685,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
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
index b92aa7d3e93e..51198b137461 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.h
+++ b/drivers/char/tpm/tpm_ibmvtpm.h
@@ -41,7 +41,7 @@ struct ibmvtpm_dev {
 	wait_queue_head_t wq;
 	u16 res_len;
 	u32 vtpm_version;
-	bool tpm_processing_cmd;
+	u8 tpm_processing_cmd;
 };
 
 #define CRQ_RES_BUF_SIZE	PAGE_SIZE
-- 
2.31.1

