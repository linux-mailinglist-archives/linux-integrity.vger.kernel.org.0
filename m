Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2FC1183594
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Mar 2020 16:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgCLPzs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Mar 2020 11:55:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726395AbgCLPzs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Mar 2020 11:55:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CFqKGO095859;
        Thu, 12 Mar 2020 11:55:42 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqpyau4bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 11:55:40 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02CFmSoN006877;
        Thu, 12 Mar 2020 15:53:33 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2ypjxrdyky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 15:53:33 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02CFrXl613632074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 15:53:33 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6293EAE05C;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A0ECAE062;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Mar 2020 15:53:33 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Stefan Berger <stefanb@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH v7 3/3] tpm: ibmvtpm: Add support for TPM2
Date:   Thu, 12 Mar 2020 11:53:32 -0400
Message-Id: <20200312155332.671464-4-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
References: <20200312155332.671464-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_07:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120082
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Support TPM2 in the IBM vTPM driver. The hypervisor tells us what
version of TPM is connected through the vio_device_id.

In case a TPM2 device is found, we set the TPM_CHIP_FLAG_TPM2 flag
and get the command codes attributes table. The driver does
not need the timeouts and durations, though.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: Nayna Jain <nayna@linux.ibm.com>
---
 drivers/char/tpm/tpm.h         | 1 +
 drivers/char/tpm/tpm2-cmd.c    | 2 +-
 drivers/char/tpm/tpm_ibmvtpm.c | 8 ++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 2b2c225e1190..0fbcede241ea 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -226,6 +226,7 @@ int tpm2_auto_startup(struct tpm_chip *chip);
 void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type);
 unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
 int tpm2_probe(struct tpm_chip *chip);
+int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip);
 int tpm2_find_cc(struct tpm_chip *chip, u32 cc);
 int tpm2_init_space(struct tpm_space *space);
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space);
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 760329598b99..76f67b155bd5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -615,7 +615,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
 	return rc;
 }
 
-static int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
+int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 {
 	struct tpm_buf buf;
 	u32 nr_commands;
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index cfe40e7b1ba4..1a49db9e108e 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
 
 static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
 	{ "IBM,vtpm", "IBM,vtpm"},
+	{ "IBM,vtpm", "IBM,vtpm20"},
 	{ "", "" }
 };
 MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
@@ -672,6 +673,13 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
 	if (rc)
 		goto init_irq_cleanup;
 
+	if (!strcmp(id->compat, "IBM,vtpm20")) {
+		chip->flags |= TPM_CHIP_FLAG_TPM2;
+		rc = tpm2_get_cc_attrs_tbl(chip);
+		if (rc)
+			goto init_irq_cleanup;
+	}
+
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
-- 
2.23.0

