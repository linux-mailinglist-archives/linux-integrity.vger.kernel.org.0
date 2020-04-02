Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40819CD1E
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Apr 2020 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbgDBWvs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 18:51:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387919AbgDBWvq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 18:51:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 032MXUQv105298;
        Thu, 2 Apr 2020 18:51:43 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 302071ybm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 18:51:43 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 032Mov0G003921;
        Thu, 2 Apr 2020 22:51:42 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 301x77yd6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Apr 2020 22:51:42 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 032MpfvT53150190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Apr 2020 22:51:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61A19283FA;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52673283F9;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 Apr 2020 22:51:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 1/2] acpi: Extend TPM2 ACPI table with missing log fields
Date:   Thu,  2 Apr 2020 18:51:39 -0400
Message-Id: <20200402225140.922789-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
References: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-02_12:2020-04-02,2020-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020164
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Recent extensions of the TPM2 ACPI table added 3 more fields
including 12 bytes of start method specific parameters and Log Area
Minimum Length (u32) and Log Area Start Address (u64). So, we extend
the existing structure with these fields to allow non-UEFI systems
to access the TPM2's log.

The specification that has the new fields is the following:
  TCG ACPI Specification
  Family "1.2" and "2.0"
  Version 1.2, Revision 8

Adapt all existing table size calculations to use
offsetof(struct acpi_table_tpm2, start_method_specific)
[where start_method_specific is a newly added field]
rather than sizeof(struct acpi_table_tpm2) so that the addition
of the new fields does not affect current systems that may not
have them.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
 drivers/char/tpm/tpm_tis.c |  4 +++-
 include/acpi/actbl3.h      |  5 +++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index a9dcf31eadd2..0565aa5482f9 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
 
 	status = acpi_get_table(ACPI_SIG_TPM2, 1,
 				(struct acpi_table_header **) &buf);
-	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
+	if (ACPI_FAILURE(status) || buf->header.length <
+			offsetof(struct acpi_table_tpm2,
+				 start_method_specific)) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
 	}
@@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
 		return -ENOMEM;
 
 	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
-		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
+		if (buf->header.length <
+			(offsetof(struct acpi_table_tpm2,
+				  start_method_specific) +
+			 sizeof(*crb_smc))) {
 			dev_err(dev,
 				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
 				buf->header.length,
 				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
 			return -EINVAL;
 		}
-		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
+		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf,
+			   offsetof(struct acpi_table_tpm2,
+				    start_method_specific));
 		priv->smc_func_id = crb_smc->smc_func_id;
 	}
 
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..a80f36860bac 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -111,7 +111,9 @@ static int check_acpi_tpm2(struct device *dev)
 	 */
 	st =
 	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
-	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
+	if (ACPI_FAILURE(st) || tbl->header.length <
+			offsetof(struct acpi_table_tpm2,
+				 start_method_specific)) {
 		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
 		return -EINVAL;
 	}
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 2bf3baf819bb..b6118c67af0c 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -411,8 +411,9 @@ struct acpi_table_tpm2 {
 	u16 reserved;
 	u64 control_address;
 	u32 start_method;
-
-	/* Platform-specific data follows */
+	u8  start_method_specific[12];
+	u32 log_area_minimum_length;		/* optional */
+	u64 log_area_start_address;		/* optional */
 };
 
 /* Values for start_method above */
-- 
2.14.5

