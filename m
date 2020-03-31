Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF28A19A14A
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 23:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgCaVvH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 17:51:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18504 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731098AbgCaVvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 17:51:07 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02VLYX23076878;
        Tue, 31 Mar 2020 17:51:03 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303ymkgg6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 17:51:03 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02VLoNV9013165;
        Tue, 31 Mar 2020 21:51:02 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 301x76m51t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Mar 2020 21:51:02 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02VLp2ug37945770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 21:51:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2592D28058;
        Tue, 31 Mar 2020 21:51:02 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5522805E;
        Tue, 31 Mar 2020 21:51:02 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 Mar 2020 21:51:01 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3] tpm: Add support for event log pointer found in TPM2 ACPI table
Date:   Tue, 31 Mar 2020 17:51:00 -0400
Message-Id: <20200331215100.883860-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003310171
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

In case a TPM2 is attached, search for a TPM2 ACPI table when trying
to get the event log from ACPI. If one is found, use it to get the
start and length of the log area. This allows non-UEFI systems, such
as SeaBIOS, to pass an event log when using a TPM2.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c | 56 +++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..e714a2bd0423 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -49,9 +49,8 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	void __iomem *virt;
 	u64 len, start;
 	struct tpm_bios_log *log;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return -ENODEV;
+	struct acpi_table_tpm2 *tbl;
+	int format;
 
 	log = &chip->log;
 
@@ -61,23 +60,38 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	if (!chip->acpi_dev_handle)
 		return -ENODEV;
 
-	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
-	status = acpi_get_table(ACPI_SIG_TCPA, 1,
-				(struct acpi_table_header **)&buff);
-
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	switch(buff->platform_class) {
-	case BIOS_SERVER:
-		len = buff->server.log_max_len;
-		start = buff->server.log_start_addr;
-		break;
-	case BIOS_CLIENT:
-	default:
-		len = buff->client.log_max_len;
-		start = buff->client.log_start_addr;
-		break;
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
+		status = acpi_get_table("TPM2", 1,
+					(struct acpi_table_header **)&tbl);
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+		if (tbl->header.length < sizeof(*tbl))
+			return -ENODEV;
+		len = tbl->log_area_minimum_length;
+		start = tbl->log_area_start_address;
+		if (!start || !len)
+			return -ENODEV;
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	} else {
+		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
+		status = acpi_get_table(ACPI_SIG_TCPA, 1,
+					(struct acpi_table_header **)&buff);
+
+		if (ACPI_FAILURE(status))
+			return -ENODEV;
+
+		switch (buff->platform_class) {
+		case BIOS_SERVER:
+			len = buff->server.log_max_len;
+			start = buff->server.log_start_addr;
+			break;
+		case BIOS_CLIENT:
+		default:
+			len = buff->client.log_max_len;
+			start = buff->client.log_start_addr;
+			break;
+		}
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
 	}
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
@@ -98,7 +112,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return format;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.14.5

