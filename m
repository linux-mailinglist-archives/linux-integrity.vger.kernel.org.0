Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975BC20B4E6
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 17:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgFZPj6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 11:39:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30606 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgFZPjz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 11:39:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05QFcS6P172810;
        Fri, 26 Jun 2020 11:39:53 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a44tyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 11:39:53 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05QFaD7B007796;
        Fri, 26 Jun 2020 15:39:52 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 31uus1mwmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jun 2020 15:39:52 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05QFdn4a29229356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jun 2020 15:39:49 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FE51BE053;
        Fri, 26 Jun 2020 15:39:51 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 084B1BE054;
        Fri, 26 Jun 2020 15:39:51 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 26 Jun 2020 15:39:50 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 2/2] tpm: Add support for event log pointer found in TPM2 ACPI table
Date:   Fri, 26 Jun 2020 11:39:48 -0400
Message-Id: <20200626153948.2059251-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200626153948.2059251-1-stefanb@linux.vnet.ibm.com>
References: <20200626153948.2059251-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_08:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006260106
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
 drivers/char/tpm/eventlog/acpi.c | 63 +++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..51312c460335 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -49,9 +49,9 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	void __iomem *virt;
 	u64 len, start;
 	struct tpm_bios_log *log;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return -ENODEV;
+	struct acpi_table_tpm2 *tbl;
+	struct acpi_tpm2_phy *t2phy;
+	int format;
 
 	log = &chip->log;
 
@@ -61,23 +61,44 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
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
+
+		if (tbl->header.length <
+				sizeof(*tbl) + sizeof(struct acpi_tpm2_phy))
+			return -ENODEV;
+
+		t2phy = (void *)tbl + sizeof(*tbl);
+		len = t2phy->log_area_minimum_length;
+
+		start = t2phy->log_area_start_address;
+		if (!start || !len)
+			return -ENODEV;
+
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	} else {
+		/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
+		status = acpi_get_table(ACPI_SIG_TCPA, 1,
+					(struct acpi_table_header **)&buff);
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
+
+		format = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
 	}
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
@@ -98,7 +119,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return format;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.26.2

