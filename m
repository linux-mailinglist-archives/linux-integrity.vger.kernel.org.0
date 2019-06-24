Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5650142
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 07:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfFXFoH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 01:44:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35422 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfFXFoE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 01:44:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so6497333pgl.2;
        Sun, 23 Jun 2019 22:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atvVCCZlaaqvzEl6Yh465+OzoxbvPTqnW+FcPoxAmko=;
        b=dCs9iUVMJyqrd2/T7sKKRH+p0B2WfPpIE2OcecwSrrJFBpxBF4g8gg6xLeoURsDMhU
         SpwAFGDkvq99q4fx9JKaty/5erC6z8reYxaxW1L7YohqUq2TQNUp9PgaqLN7zgXWSFFk
         SuDy8SeiQoa7aX9gLJ5dckOnxNza7JYx/1Q4evNc1MrKWUWWyoZvmoEz1Ovfistwyc+t
         t3mT51xsj3BKbBYvXq39ztgc12hFPZcVWULzX0wYL0sHaNkccwvk0nCtQbkTsGPxewTl
         ddlfcraPP7hN1vCUH6cRdlqBbKLt7SdTndpij8arEh8xbue67P7jABIb0mqoP4ZL8UIY
         yNag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atvVCCZlaaqvzEl6Yh465+OzoxbvPTqnW+FcPoxAmko=;
        b=Y41Kk9LOqXcgHyVKNLtIzHy17l48+76iK9F8j1nfN0sLrBvGOCGGtRlG8wE3qLRoXj
         8zxEMnLb/i3b7tKL26G0ImnHw8bZO4m3Vc97Fd1tOhZdQ1z1j4XHRILRJ8Qk8atoc7Qu
         eMim1McVQVQ1XemiIxzIGszHyba6DBLLzfmssvFuZNbxJXxNZ6nWAr5Z9j8T6fg113ga
         TiHr4ToXnTgcPnFM48Sjf7SEcTNEAB4u4tNbJh0C0/h9FGf18VtsI7AKdYgf0ICnX6GU
         X4mmK/syD7opfhuQtErWuRBJ/zj0eFMKKyzHPsCbbx7iok8YPWKdEU9GPgd9W/arLNqe
         Z+Zw==
X-Gm-Message-State: APjAAAUi2LRiHWlzAjN8bIYxfrlJrn6QIR0gHYmuJEnrRlo9qfeZEKxH
        FWlEya06voi0JUvbGN//wtE=
X-Google-Smtp-Source: APXvYqwCf8aQbMfAF7+Kb3CzB9vu5dq4fm2q5GLjv+X4nbjUH8Z4lOK4+PjGKWxJKVrEBMrnnsoQrA==
X-Received: by 2002:a63:a41:: with SMTP id z1mr31007694pgk.290.1561355043781;
        Sun, 23 Jun 2019 22:44:03 -0700 (PDT)
Received: from localhost ([2601:600:103:d129:8c22:ab98:95b3:d831])
        by smtp.gmail.com with ESMTPSA id f7sm10146829pfd.43.2019.06.23.22.44.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 22:44:03 -0700 (PDT)
From:   Jordan Hand <jordanhand22@gmail.com>
Cc:     jordanhand22@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: Get TCG log from TPM2 ACPI table for tpm2 systems
Date:   Sun, 23 Jun 2019 22:42:31 -0700
Message-Id: <20190624054232.20216-1-jordanhand22@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624034734.15957-1-jordanhand22@gmail.com>
References: <20190624034734.15957-1-jordanhand22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For TPM2-based systems, retrieve the TCG log from the TPM2 ACPI table.

Signed-off-by: Jordan Hand <jordanhand22@gmail.com>
---
v2:
- Apologies, v1 had a silly compile error

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
2.20.1

