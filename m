Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03682051C3
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbgFWMGo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 08:06:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42232 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732333AbgFWMGn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 08:06:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NC1BDd194257;
        Tue, 23 Jun 2020 08:06:39 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31ufmyu1vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 08:06:38 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NBxuQJ012491;
        Tue, 23 Jun 2020 12:06:38 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 31u20cwaua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 12:06:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NC6b6L24707410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 12:06:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D27C6124053;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B90C012405B;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 12:06:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 1/2] acpi: Extend TPM2 ACPI table with missing log fields
Date:   Tue, 23 Jun 2020 08:06:35 -0400
Message-Id: <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
References: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_06:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1011
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006230088
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
index b0b163b9efc6..8b55426bbcf6 100644
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
2.26.2

