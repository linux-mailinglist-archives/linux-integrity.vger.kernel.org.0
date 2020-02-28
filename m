Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE224172F1C
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2020 04:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgB1DEz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Feb 2020 22:04:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbgB1DEz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Feb 2020 22:04:55 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S2xCEs075889;
        Thu, 27 Feb 2020 22:04:47 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepwtddeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 22:04:47 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01S331f0019313;
        Fri, 28 Feb 2020 03:04:46 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2yepv2smys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 03:04:46 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S34j2T52560140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 03:04:45 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07CAC2806A;
        Fri, 28 Feb 2020 03:04:45 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18E30280C1;
        Fri, 28 Feb 2020 03:03:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 03:03:34 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 2/3] tpm: ibmvtpm: Wait for buffer to be set before proceeding
Date:   Thu, 27 Feb 2020 22:03:29 -0500
Message-Id: <20200228030330.18081-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
References: <20200228030330.18081-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_08:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280025
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Synchronize with the results from the CRQs before continuing with
the initialization. This avoids trying to send TPM commands while
the rtce buffer has not been allocated, yet.

This patch fixes an existing race condition that may occurr if the
hypervisor does not quickly respond to the VTPM_GET_RTCE_BUFFER_SIZE
request sent during initialization and therefore the ibmvtpm->rtce_buf
has not been allocated at the time the first TPM command is sent.

Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 9 +++++++++
 drivers/char/tpm/tpm_ibmvtpm.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 78cc52690177..eee566eddb35 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -571,6 +571,7 @@ static irqreturn_t ibmvtpm_interrupt(int irq, void *vtpm_instance)
 	 */
 	while ((crq = ibmvtpm_crq_get_next(ibmvtpm)) != NULL) {
 		ibmvtpm_crq_process(crq, ibmvtpm);
+		wake_up_interruptible(&ibmvtpm->crq_queue.wq);
 		crq->valid = 0;
 		smp_wmb();
 	}
@@ -618,6 +619,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	}
 
 	crq_q->num_entry = CRQ_RES_BUF_SIZE / sizeof(*crq_q->crq_addr);
+	init_waitqueue_head(&crq_q->wq);
 	ibmvtpm->crq_dma_handle = dma_map_single(dev, crq_q->crq_addr,
 						 CRQ_RES_BUF_SIZE,
 						 DMA_BIDIRECTIONAL);
@@ -670,6 +672,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
+	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
+				ibmvtpm->rtce_buf != NULL,
+				HZ)) {
+		dev_err(dev, "Initialization failed\n");
+		goto init_irq_cleanup;
+	}
+
 	return tpm_chip_register(chip);
 init_irq_cleanup:
 	do {
diff --git a/drivers/char/tpm/tpm_ibmvtpm.h b/drivers/char/tpm/tpm_ibmvtpm.h
index 7983f1a33267..b92aa7d3e93e 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.h
+++ b/drivers/char/tpm/tpm_ibmvtpm.h
@@ -26,6 +26,7 @@ struct ibmvtpm_crq_queue {
 	struct ibmvtpm_crq *crq_addr;
 	u32 index;
 	u32 num_entry;
+	wait_queue_head_t wq;
 };
 
 struct ibmvtpm_dev {
-- 
2.23.0

