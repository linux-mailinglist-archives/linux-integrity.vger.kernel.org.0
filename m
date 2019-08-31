Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A04E4A4237
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Aug 2019 06:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfHaEZr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 31 Aug 2019 00:25:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48286 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHaEZr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 31 Aug 2019 00:25:47 -0400
Received: from localhost.localdomain (c-67-168-100-174.hsd1.wa.comcast.net [67.168.100.174])
        by linux.microsoft.com (Postfix) with ESMTPSA id 51D4820B7186
        for <linux-integrity@vger.kernel.org>; Fri, 30 Aug 2019 21:25:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51D4820B7186
From:   Jordan Hand <jorhand@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org
Subject: [PATCH v3] tpm: Parse event log from TPM2 ACPI table
Date:   Fri, 30 Aug 2019 21:25:29 -0700
Message-Id: <20190831042529.1424-1-jorhand@linux.microsoft.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For systems with a TPM2 chip which use ACPI to expose event logs, retrieve the
crypto-agile event log from the TPM2 ACPI table. The TPM2 table is defined
in section 7.3 of the TCG ACPI Specification (see link).

The TPM2 table is used by SeaBIOS in place of the TCPA table when the system's
TPM is version 2.0 to denote (among other metadata) the location of the
crypto-agile log.

Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>
---
 drivers/char/tpm/eventlog/acpi.c | 60 ++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..38a8bcec1dd5 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -41,17 +41,23 @@ struct acpi_tcpa {
 	};
 };
 
+/* If an event log is present, the TPM2 ACPI table will contain the full
+ * trailer
+ */
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
-	struct acpi_tcpa *buff;
+	struct acpi_table_header *buff;
+	struct acpi_tcpa *tcpa;
+	struct acpi_tpm2_trailer *tpm2_trailer;
 	acpi_status status;
 	void __iomem *virt;
 	u64 len, start;
+	int log_type;
 	struct tpm_bios_log *log;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		return -ENODEV;
+	bool is_tpm2 = chip->flags & TPM_CHIP_FLAG_TPM2;
+	acpi_string table_sig;
 
 	log = &chip->log;
 
@@ -61,26 +67,42 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	if (!chip->acpi_dev_handle)
 		return -ENODEV;
 
-	/* Find TCPA entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
-	status = acpi_get_table(ACPI_SIG_TCPA, 1,
-				(struct acpi_table_header **)&buff);
+	/* Find TCPA or TPM2 entry in RSDT (ACPI_LOGICAL_ADDRESSING) */
+	table_sig = is_tpm2 ? ACPI_SIG_TPM2 : ACPI_SIG_TCPA;
+	status = acpi_get_table(table_sig, 1, &buff);
 
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
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
+	if (!is_tpm2) {
+		tcpa = (struct acpi_tcpa *)buff;
+		switch (tcpa->platform_class) {
+		case BIOS_SERVER:
+			len = tcpa->server.log_max_len;
+			start = tcpa->server.log_start_addr;
+			break;
+		case BIOS_CLIENT:
+		default:
+			len = tcpa->client.log_max_len;
+			start = tcpa->client.log_start_addr;
+			break;
+		}
+		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	} else if (buff->length ==
+		   sizeof(struct acpi_table_tpm2) +
+		   sizeof(struct acpi_tpm2_trailer)) {
+		tpm2_trailer = (struct acpi_tpm2_trailer *)buff;
+
+		len = tpm2_trailer.minimum_log_length;
+		start = tpm2_trailer.log_address;
+		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	} else {
+		return -ENODEV;
 	}
+
 	if (!len) {
-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
+		dev_warn(&chip->dev, "%s: %s log area empty\n",
+			 __func__, table_sig);
 		return -EIO;
 	}
 
@@ -98,7 +120,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return log_type;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.20.1

