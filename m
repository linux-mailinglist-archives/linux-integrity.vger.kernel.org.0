Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6316F0A0
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 21:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgBYUxT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 15:53:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729130AbgBYUxS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 15:53:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PKoDnR056523;
        Tue, 25 Feb 2020 15:53:13 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yd1q8mgxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 15:53:13 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01PKgF1B013333;
        Tue, 25 Feb 2020 20:53:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2yaux6xxj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 20:53:12 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01PKrA3k45941180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Feb 2020 20:53:10 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE3F2136053;
        Tue, 25 Feb 2020 20:53:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C0DE136051;
        Tue, 25 Feb 2020 20:53:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 25 Feb 2020 20:53:10 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 4/4] tpm: ibmvtpm: Add support for TPM 2
Date:   Tue, 25 Feb 2020 15:53:05 -0500
Message-Id: <20200225205305.3948001-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200225205305.3948001-1-stefanb@linux.vnet.ibm.com>
References: <20200225205305.3948001-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_08:2020-02-25,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250145
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
version of TPM is connected through the vio_device_id.

In case a TPM 2 is found, we set the TPM_CHIP_FLAG_TPM2 flag.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/tpm_ibmvtpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index eee566eddb35..0df815f9a6c5 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
 static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 	{ "IBM,vtpm", "IBM,vtpm"},
+	{ "IBM,vtpm", "IBM,vtpm20"},
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
@@ -672,6 +673,9 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
+	if (!strcmp(id->compat, "IBM,vtpm20"))
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
+
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
-- 
2.23.0

