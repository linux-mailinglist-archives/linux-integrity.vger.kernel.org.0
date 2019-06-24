Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88713519F0
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 19:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfFXRru (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 13:47:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42601 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfFXRru (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 13:47:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so7288490plb.9;
        Mon, 24 Jun 2019 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lba1BOUon5dqcIOzc5RFtxz1ZXdjiXb/UxRKeVauNzs=;
        b=eZNWkHPcbXHoF+cagga4RGoi/1YC+3Pvf6AlTiTtp+MK++RuNqrzCjDQ1+YL5dWpZf
         JbzCxe1F8mbsFw1MSyoQ1lMLidRAn+p65apKRr8LVbErHsvC3tyPHmhMCIBJGtiQt8QE
         LTkI31Uobr92nK/H1/2B3Nv0xFh79lh3dPtu8niLV5q6Nk4HTF83Xpx7rFXCXILXtDWK
         lBYLPneX3Wb6enW4pX+zE/AlREqVhFY91S6a3G3cukljE4ZTgF0q6B+fh7hGTJVOnS+x
         iFpCmWUL8WZrTutUsqgP2Dn4YR39akeOlzVzdpRjG2o1nwBBAaEHZFHASy7eqlwM3dpM
         ZnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lba1BOUon5dqcIOzc5RFtxz1ZXdjiXb/UxRKeVauNzs=;
        b=Mk/7Pvt00nD0mgR8mEGBJWqKvnrEo/oPDcNPUbDmz7Y6dEXpz1dmn4HBkiFPvx0Kqp
         z+5m85k1R883JGouK8hh79b4a+XHWw5hLG1DmgI4JHMXogZ1oocvK3SgLmBw2KoBbQbc
         GQLuKEf4TC9Tnm1qJe1PRRbCOCD29OOV0LIuxiICDWLQtRbp9nNvz3HgNBw8lYD1f7Qe
         m+iu3uwX+ACiXnjYw9OJYAJ49TwGQ+5qjbBP9dLJJPNHzdUsdqScxSpQkl/Y1kJ9umLQ
         LY43o/o2O2q4CLmE2r9AzKqumFvYU0jOzKcDSPo/jRq8hDr0JF5FadiaeTbkAAFsQ9qY
         Jpkw==
X-Gm-Message-State: APjAAAXeAypnjrOEKG87kSAcmOrjWVnZLzTmroS0ZgT7bYg9BTlbRmsz
        ARX+jQy+pPR28HT8zLHBQdw=
X-Google-Smtp-Source: APXvYqx9lmZ1nghKpJJ5dCShlS9w9aLGOBBJ4pynNlOtaYwGCmTyf58wqRkgUMr9FhlBbImW1kz+0Q==
X-Received: by 2002:a17:902:9688:: with SMTP id n8mr66862544plp.227.1561398469695;
        Mon, 24 Jun 2019 10:47:49 -0700 (PDT)
Received: from jorhand-ubuntu.corp.microsoft.com ([2001:4898:80e8:3:bdfa:627c:c51d:fa8])
        by smtp.googlemail.com with ESMTPSA id f186sm13033954pfb.5.2019.06.24.10.47.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 10:47:49 -0700 (PDT)
From:   Jordan Hand <jordanhand22@gmail.com>
X-Google-Original-From: Jordan Hand <jorhand@microsoft.com>
Cc:     Jordan Hand <jordanhand22@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] tpm: Get TCG log from TPM2 ACPI table for tpm2 systems
Date:   Mon, 24 Jun 2019 10:46:42 -0700
Message-Id: <20190624174643.21746-1-jorhand@microsoft.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jordan Hand <jordanhand22@gmail.com>

For TPM2-based systems, retrieve the TCG log from the TPM2 ACPI table.
The TPM2 ACPI table is defined in section 7.3 of the TCG ACPI
Specification (see link).

The TPM2 table is used primarily by legacy BIOS in place of the TCPA table
when the system's TPM is version 2.0 to denote (among other metadata) the
location of the crypto-agile TCG log. In particluar, the SeaBios firmware
used by default by QEMU makes use of this table for crypto-agile logs.

Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf

Signed-off-by: Jordan Hand <jordanhand22@gmail.com>
---

Same as v2 with more descriptive commit message

 drivers/char/tpm/eventlog/acpi.c | 67 +++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..b945c4ff3af6 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -41,17 +41,31 @@ struct acpi_tcpa {
 	};
 };
 
+struct acpi_tpm2 {
+	struct acpi_table_header hdr;
+	u16 platform_class;
+	u16 reserved;
+	u64 control_area_addr;
+	u32 start_method;
+	u8 start_method_params[12];
+	u32 log_max_len;
+	u64 log_start_addr;
+} __packed;
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
-	struct acpi_tcpa *buff;
+	struct acpi_table_header *buff;
+	struct acpi_tcpa *tcpa;
+	struct acpi_tpm2 *tpm2;
+
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
 
@@ -61,26 +75,41 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
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
+	/* If log_max_len and log_start_addr are set, start_method_params will
+	 * be 12 bytes, according to TCG ACPI spec. If start_method_params is
+	 * fewer than 12 bytes, the TCG log is not available
+	 */
+	if (is_tpm2 && (buff->length == sizeof(struct acpi_tpm2))) {
+		tpm2 = (struct acpi_tpm2 *)buff;
+		len = tpm2->log_max_len;
+		start = tpm2->log_start_addr;
+		log_type = EFI_TCG2_EVENT_LOG_FORMAT_TCG_2;
+	} else {
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
 	}
+
 	if (!len) {
-		dev_warn(&chip->dev, "%s: TCPA log area empty\n", __func__);
+		dev_warn(&chip->dev, "%s: %s log area empty\n",
+				table_sig, __func__);
 		return -EIO;
 	}
 
@@ -98,7 +127,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	memcpy_fromio(log->bios_event_log, virt, len);
 
 	acpi_os_unmap_iomem(virt, len);
-	return EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2;
+	return log_type;
 
 err:
 	kfree(log->bios_event_log);
-- 
2.17.1

