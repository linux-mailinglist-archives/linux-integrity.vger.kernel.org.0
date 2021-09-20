Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2C41277A
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Sep 2021 22:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhITUsi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Sep 2021 16:48:38 -0400
Received: from linderud.dev ([163.172.10.146]:56146 "EHLO linderud.pw"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhITUqh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Sep 2021 16:46:37 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Sep 2021 16:46:37 EDT
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id D7453C01B4;
        Mon, 20 Sep 2021 22:35:00 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on velox
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.5-pre1
Received: from localhost (host-37-191-241-102.lynet.no [37.191.241.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 8BCA6C001C;
        Mon, 20 Sep 2021 22:35:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1632170100;
        bh=OwdRbJc/TbitNW2Zx/UmsifqU/l9t7XuLiHqlNN609c=;
        h=From:To:Cc:Subject:Date;
        b=WD0ci4ptMwbSYIcJHKMInvTa5b8ONt7V3npXO1wu5FgHIFAKvf8w0YLpyLFCUd+1t
         1gHzIML2FPa6/7sFhkEMxNQ6uc5GnAz4gvqxK4TN4DgbANwZy6ZtLGmDfW9zTEAFQ2
         n1eVMml+AFuexCp2wrGAI97vvng1+QfmOQ27w3GPvwD5XgnHGJ8/nrwW7C7Yzo96In
         rXgkWHxIuCBREF6WyrsUuFe7FOJzsuURZuBOv1Fa3j4cETCRsFI0a/0tbP9GEaAuVB
         viMs9A+mazsQzHJvXV+PjR/lBBGlh5MWAqUfKO7TGyrQd8068TFZ8+jN4hdh4/nXoq
         3n4VM38hpTozUBzJk662t5lhZy3J34OChEjwbxl13cOXFl92LYF09FBtaLsjeWkDfj
         +hp7O1tijTpQyJYhOx3AEvnGqWMyq3/c9lbMcE4uwREc5IzxEN4u9yMFtXs7wHwli8
         sECyYYBppWTOuFiMmyPnLz1ujTvYW4gM8izvqMYalh3RKU6EEsq4ynt0qbANFMZ0EU
         grWkQ6sge+ws2lTFo94A4Kyxa4AkfPHotZ7kLkt1d1mtQaR+86FS2Sxcv5Zn53qqTy
         Q7G1kDLHoTXGxMj5OlFXVY7BHyFLCBL8AsXIhOZ7c6BU8CrfsrrmRQui4I0jeL4iWk
         VKuBZVFOi1PfEUzRTp/CzqIA=
From:   Morten Linderud <morten@linderud.pw>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Morten Linderud <morten@linderud.pw>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI config
Date:   Mon, 20 Sep 2021 22:34:47 +0200
Message-Id: <20210920203447.4124005-1-morten@linderud.pw>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some vendors report faulty values in the acpi TPM2 table. This causes
the function to abort with EIO and essentially short circuits the
tpm_read_log function as we never even attempt to read the EFI
configuration table for a log.

This changes the condition to only look for a positive return value,
else hands over the eventlog discovery to the EFI configuration table
which should hopefully work better.

It's unclear to me if there is a better solution to this then just
failing. However, I do not see any clear reason why we can't properly
fallback to the EFI configuration table.

The following hardware was used to test this issue on:
    Framework Laptop (Pre-production)
    BIOS: INSYDE Corp, Revision: 3.2
    TPM Device: NTC, Firmware Revision: 7.2

Dump of the fault ACPI TPM2 table:
    [000h 0000   4]                    Signature : "TPM2"    [Trusted Platform Module hardware interface Table]
    [004h 0004   4]                 Table Length : 0000004C
    [008h 0008   1]                     Revision : 04
    [009h 0009   1]                     Checksum : 2B
    [00Ah 0010   6]                       Oem ID : "INSYDE"
    [010h 0016   8]                 Oem Table ID : "TGL-ULT"
    [018h 0024   4]                 Oem Revision : 00000002
    [01Ch 0028   4]              Asl Compiler ID : "ACPI"
    [020h 0032   4]        Asl Compiler Revision : 00040000

    [024h 0036   2]               Platform Class : 0000
    [026h 0038   2]                     Reserved : 0000
    [028h 0040   8]              Control Address : 0000000000000000
    [030h 0048   4]                 Start Method : 06 [Memory Mapped I/O]

    [034h 0052  12]            Method Parameters : 00 00 00 00 00 00 00 00 00 00 00 00
    [040h 0064   4]           Minimum Log Length : 00010000
    [044h 0068   8]                  Log Address : 000000004053D000

Signed-off-by: Morten Linderud <morten@linderud.pw>
---
 drivers/char/tpm/eventlog/acpi.c   | 5 +++--
 drivers/char/tpm/eventlog/common.c | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 1b18ce5ebab1..9ce39cdb0bd8 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -136,8 +136,10 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	ret = -EIO;
 	virt = acpi_os_map_iomem(start, len);
-	if (!virt)
+	if (!virt) {
+		dev_warn(&chip->dev, "%s: Failed to map acpi memory\n", __func__);
 		goto err;
+	}
 
 	memcpy_fromio(log->bios_event_log, virt, len);
 
@@ -145,7 +147,6 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
 	    !tpm_is_tpm2_log(log->bios_event_log, len)) {
-		/* try EFI log next */
 		ret = -ENODEV;
 		goto err;
 	}
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 8512ec76d526..f64256bc2f89 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -83,7 +83,11 @@ static int tpm_read_log(struct tpm_chip *chip)
 	}
 
 	rc = tpm_read_log_acpi(chip);
-	if (rc != -ENODEV)
+	/*
+	 * only return if we found a log else we try look for a
+	 * log in the EFI configuration table
+	 */
+	if (rc > 0)
 		return rc;
 
 	rc = tpm_read_log_efi(chip);
-- 
2.33.0
