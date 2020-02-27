Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA489170D2E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2020 01:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgB0A1E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Feb 2020 19:27:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728003AbgB0A1D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Feb 2020 19:27:03 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01R0Kfxe036693;
        Wed, 26 Feb 2020 19:26:57 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ydcnh0vfg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Feb 2020 19:26:57 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01R0AF1Q018267;
        Thu, 27 Feb 2020 00:26:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 2ydcmkuf9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 00:26:56 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01R0QttM50856304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Feb 2020 00:26:55 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D61EB28059;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD73128058;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 27 Feb 2020 00:26:55 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/4] tpm: ibmvtpm: Wait for buffer to be set before proceeding
Date:   Wed, 26 Feb 2020 19:26:52 -0500
Message-Id: <20200227002654.7536-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
References: <20200227002654.7536-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-26_09:2020-02-26,2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270000
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

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Fixes: 132f76294744 ("Add new device driver to support IBM vTPM")
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

