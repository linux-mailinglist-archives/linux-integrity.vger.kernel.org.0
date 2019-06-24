Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4650059
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 05:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFXDsk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Jun 2019 23:48:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43100 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfFXDsj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Jun 2019 23:48:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so6681478pfg.10;
        Sun, 23 Jun 2019 20:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxLh5bacpaEbPEgyRw0bk27sc0jWaPgYJYjIXjgo33A=;
        b=GhZUc0bSh9odzWJr8A9l4V9YbZ7WOEQfA8ezqs8d4I9b204HgGVhyhCAeoUAzusB0+
         vQi3QusFCSeL+fgy/Vt7/yNTUoO1SaDCCRBguglKq+bkmON8QUg64+gHQzmRa0KdUgpo
         AFMxVVWYh/stfp4k5afgp5YC5ZYZfzMV8lwwvFBOtAcguOX5vv0QEWFvRbHsEvJCqpKq
         upahY483hsbmVhufRqFTDgjQIiEv2VTV3UPaWsvD7HINq7GUBmQaKW9Uf6I1AbxlJJ+B
         Xiau+4OIEn/G7XeNB13ZQEFio/zIbLoRFG5UZ9wHsjQdefe+1/gcCoDEml/WdPTme7Ma
         yUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HxLh5bacpaEbPEgyRw0bk27sc0jWaPgYJYjIXjgo33A=;
        b=mpFz5TREMWeZI5vZV0FnqsI1sk33pvpR/PPfTgg+vGDuckh8Jh5uPbrXegDEUFlEtW
         F+t156MtPS5ET7kqPvq1YhRCEmgoSyyb1wzvok285ff9AxF8y5s7t8H2MuJNLdJBr4Jf
         wsvYLD/A4qDFbmrSSfzC+2+uXbPwb60R5B1wPZCPf7eZHozCQcTIID7sn5i7PIcYEWld
         niKAk1H/EHBTAEwXLULxAM+7CVnLp4L+aX5M59FzHciyQ07mHo4cAylNEYoQYIMjNRAu
         hwjtUwIYru4v8qHb8JAUTceKPciDi44z4ao7031Bn2hPaJBluxMr8AVqB5oqg6POu7wa
         l3qg==
X-Gm-Message-State: APjAAAU6KfGC4uK4ypINt8xyHWwe3TkOHmyXZ91USd3SP242rkcs5bUf
        GDye7h42J1+5Ro4YtCtYHKMFc/gqHYGGjA==
X-Google-Smtp-Source: APXvYqwUGAkdev3Lth6QIcfTFndeH/dXnC4Ay6j09REyaesdUSXcxsVRiRTu2tBjGKSEdP4p+amZBA==
X-Received: by 2002:a65:518d:: with SMTP id h13mr30373503pgq.22.1561348119000;
        Sun, 23 Jun 2019 20:48:39 -0700 (PDT)
Received: from localhost ([2601:600:10a:3c04:4c61:fdbe:e215:fc10])
        by smtp.gmail.com with ESMTPSA id t13sm8991228pjo.13.2019.06.23.20.48.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 20:48:38 -0700 (PDT)
From:   Jordan Hand <jordanhand22@gmail.com>
Cc:     jordanhand22@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Get TCG log from TPM2 ACPI table for tpm2 systems
Date:   Sun, 23 Jun 2019 20:47:33 -0700
Message-Id: <20190624034734.15957-1-jordanhand22@gmail.com>
X-Mailer: git-send-email 2.20.1
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
 drivers/char/tpm/eventlog/acpi.c | 67 +++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 63ada5e53f13..942d282e2738 100644
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
+	if (is_tpm2 && (buff->length == sizeof(acpi_tpm2))) {
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

