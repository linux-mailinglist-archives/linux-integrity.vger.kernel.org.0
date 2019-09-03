Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC92A72D1
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfICSwz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 14:52:55 -0400
Received: from linux.microsoft.com ([13.77.154.182]:50306 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfICSwz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 14:52:55 -0400
Received: from jorhand-ubuntu.corp.microsoft.com (unknown [167.220.2.157])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0530520B7186;
        Tue,  3 Sep 2019 11:52:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0530520B7186
From:   Jordan Hand <jorhand@linux.microsoft.com>
To:     jarkko.sakkinen@linux.intel.com
Cc:     Jordan Hand <jorhand@linux.microsoft.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] tpm: Parse event log from TPM2 ACPI table
Date:   Tue,  3 Sep 2019 11:52:38 -0700
Message-Id: <20190903185239.30643-1-jorhand@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For systems with a TPM2 chip which use ACPI to expose event logs,
retrieve the crypto-agile event log from the TPM2 ACPI table. The TPM2
table is defined in section 7.3 of the TCG ACPI Specification (see link).

The TPM2 table is used by SeaBIOS in place of the TCPA table when the
system's TPM is version 2.0 to denote (among other metadata) the location
of the crypto-agile log.

Link: https://trustedcomputinggroup.org/resource/tcg-acpi-specification/
Signed-off-by: Jordan Hand <jorhand@linux.microsoft.com>
---

Notes:
    Changelog v2:
    - Fix compile error
    
    Changelog v3:
    - Fix commit message to be more specific and remove inconsistencies.
    - Remove acpi_tpm2 struct from earlier versions, use existing
    acpi_tpm2_trailer instead
    
    Changelog v4:
    - Address kbuild bot build errors
    - Add changelog for all earlier versions

 drivers/char/tpm/eventlog/acpi.c | 58 +++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..09059c1623fd 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -44,14 +44,16 @@ struct acpi_tcpa {
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
 
@@ -61,26 +63,44 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
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
+		tpm2_trailer =
+		    (struct acpi_tpm2_trailer *)((char *)buff +
+						 sizeof(struct acpi_table_tpm2));
+
+		len = tpm2_trailer->minimum_log_length;
+		start = tpm2_trailer->log_address;
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
 
@@ -98,7 +118,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return log_type;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.17.1

