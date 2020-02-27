Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BF0172281
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgB0Pur (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 10:50:47 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729217AbgB0Pur (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 10:50:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RFodrd086491;
        Thu, 27 Feb 2020 10:50:43 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydq611ftu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 10:50:40 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01RFlXqQ012100;
        Thu, 27 Feb 2020 15:50:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 2ydcmkpbws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 15:50:36 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01RFoZna53739956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 15:50:35 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6000DC605F;
        Thu, 27 Feb 2020 15:50:35 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09301C6055;
        Thu, 27 Feb 2020 15:50:34 +0000 (GMT)
Received: from crimini9.aus.stglabs.ibm.com (unknown [9.40.192.141])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 15:50:34 +0000 (GMT)
From:   George Wilson <gcwilson@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        George Wilson <gcwilson@linux.ibm.com>,
        Linh Pham <phaml@us.ibm.com>
Subject: [PATCH] tpm: ibmvtpm: retry on H_CLOSED in tpm_ibmvtpm_send()
Date:   Thu, 27 Feb 2020 10:50:03 -0500
Message-Id: <20200227155003.592321-1-gcwilson@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_05:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1011 bulkscore=0 suspectscore=1 mlxscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002270123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_ibmvtpm_send() can fail during LPM resume with an H_CLOSED return
from ibmvtpm_send_crq().  The PAPR says, 'The “partner partition
suspended” transport event disables the associated CRQ such that any
H_SEND_CRQ hcall() to the associated CRQ returns H_Closed until the CRQ
has been explicitly enabled using the H_ENABLE_CRQ hcall.' This patch
adds a check in tpm_ibmvtpm_send() for an H_CLOSED return from
ibmvtpm_send_crq() and in that case calls tpm_ibmvtpm_resume() and
retries the ibmvtpm_send_crq() once.

Reported-by: Linh Pham <phaml@us.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 78cc52690177..ba3bd503e080 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2012 IBM Corporation
+ * Copyright (C) 2012-2020 IBM Corporation
  *
  * Author: Ashley Lai <ashleydlai@gmail.com>
  *
@@ -25,6 +25,8 @@
 #include "tpm.h"
 #include "tpm_ibmvtpm.h"
 
+static int tpm_ibmvtpm_resume(struct device *dev);
+
 static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
 static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
@@ -147,6 +149,7 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct ibmvtpm_dev *ibmvtpm = dev_get_drvdata(&chip->dev);
 	int rc, sig;
+	bool retry = true;
 
 	if (!ibmvtpm->rtce_buf) {
 		dev_err(ibmvtpm->dev, "ibmvtpm device is not ready\n");
@@ -179,18 +182,28 @@ static int tpm_ibmvtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	 */
 	ibmvtpm->tpm_processing_cmd = true;
 
+again:
 	rc = ibmvtpm_send_crq(ibmvtpm->vdev,
 			IBMVTPM_VALID_CMD, VTPM_TPM_COMMAND,
 			count, ibmvtpm->rtce_dma_handle);
+
 	if (rc != H_SUCCESS) {
+		/*
+		 * H_CLOSED can be returned after LPM resume.  Call
+		 * tpm_ibmvtpm_resume() to re-enable the CRQ then retry
+		 * ibmvtpm_send_crq() once before failing.
+		 */
+		if (rc == H_CLOSED && retry) {
+			tpm_ibmvtpm_resume(ibmvtpm->dev);
+			retry = false;
+			goto again;
+		}
 		dev_err(ibmvtpm->dev, "tpm_ibmvtpm_send failed rc=%d\n", rc);
-		rc = 0;
 		ibmvtpm->tpm_processing_cmd = false;
-	} else
-		rc = 0;
+	}
 
 	spin_unlock(&ibmvtpm->rtce_lock);
-	return rc;
+	return 0;
 }
 
 static void tpm_ibmvtpm_cancel(struct tpm_chip *chip)
-- 
2.23.0

