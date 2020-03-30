Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7397197F60
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2020 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgC3PQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Mar 2020 11:16:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64172 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727942AbgC3PQt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Mar 2020 11:16:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UF4kGK033477;
        Mon, 30 Mar 2020 11:15:39 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 301ygv18ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 11:15:39 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02UFFGRn013176;
        Mon, 30 Mar 2020 15:15:38 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02wdc.us.ibm.com with ESMTP id 301x76hn09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Mar 2020 15:15:38 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02UFFcHO54198616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 15:15:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 034E7B2066;
        Mon, 30 Mar 2020 15:15:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E940FB205F;
        Mon, 30 Mar 2020 15:15:37 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 30 Mar 2020 15:15:37 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org, jarkko.sakkinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/3] tpm: Rearrange ACPI log code to easier extend for TPM2 case
Date:   Mon, 30 Mar 2020 11:15:35 -0400
Message-Id: <20200330151536.871700-3-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
References: <20200330151536.871700-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-30_06:2020-03-30,2020-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003300139
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Rearrange the ACPI table based log code to allow for easier extension
for the TPM2 case.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 drivers/char/tpm/eventlog/acpi.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..1ef2267c9378 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -50,9 +50,6 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	u64 len, start;
 	struct tpm_bios_log *log;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return -ENODEV;
-
 	log = &chip->log;
 
 	/* Unfortuntely ACPI does not associate the event log with a specific
@@ -61,23 +58,27 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	if (!chip->acpi_dev_handle)
 		return -ENODEV;
 
-	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
-	status = acpi_get_table(ACPI_SIG_TCPA, 1,
-				(struct acpi_table_header **)&buff);
-
-	if (ACPI_FAILURE(status))
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		return -ENODEV;
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
 	}
 	if (!len) {
 		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
-- 
2.14.5

