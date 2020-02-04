Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B50D151B4A
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2020 14:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBDN1f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Feb 2020 08:27:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbgBDN1e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Feb 2020 08:27:34 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014DLlrJ111111;
        Tue, 4 Feb 2020 08:27:29 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxm9dx45n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 08:27:27 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 014DP12L012074;
        Tue, 4 Feb 2020 13:27:19 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 2xw0y69fw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 13:27:19 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 014DRHnv47186282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 13:27:17 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94C2CC6057;
        Tue,  4 Feb 2020 13:27:17 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F071FC6059;
        Tue,  4 Feb 2020 13:27:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 13:27:16 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
Date:   Tue,  4 Feb 2020 08:27:06 -0500
Message-Id: <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_04:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040095
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
version of TPM is connected through the vio_device_id.

In case a TPM 2 is found, we set the TPM_OPS_AUTO_STARTUP flag to
have properly initialize the TPM and driver.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index eee566eddb35..d479d64a65aa 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
 static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 	{ "IBM,vtpm", "IBM,vtpm"},
+	{ "IBM,vtpm", "IBM,vtpm20"},
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
@@ -443,7 +444,7 @@ static bool tpm_ibmvtpm_req_canceled(struct tpm_chip *chip, u8 status)
 	return (status == 0);
 }
 
-static const struct tpm_class_ops tpm_ibmvtpm = {
+static struct tpm_class_ops tpm_ibmvtpm = {
 	.recv = tpm_ibmvtpm_recv,
 	.send = tpm_ibmvtpm_send,
 	.cancel = tpm_ibmvtpm_cancel,
@@ -672,6 +673,11 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
+	if (!strcmp(id->compat, "IBM,vtpm20")) {
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
+		tpm_ibmvtpm.flags = TPM_OPS_AUTO_STARTUP;
+	}
+
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
-- 
2.23.0

