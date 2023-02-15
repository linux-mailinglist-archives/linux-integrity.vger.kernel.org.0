Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836B8697934
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Feb 2023 10:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjBOJnx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Feb 2023 04:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjBOJnm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Feb 2023 04:43:42 -0500
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 01:43:39 PST
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746FCB442;
        Wed, 15 Feb 2023 01:43:37 -0800 (PST)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id E641BC02F6;
        Wed, 15 Feb 2023 10:27:37 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1676453257;
        bh=JcWAyn8q70xL4QFfQr72WF4KdrylqsGgjLNgZGECBXc=;
        h=From:To:Cc:Subject:Date;
        b=QqN6IbVuNl4SKsNs6n4H8RbcxzxkfupowKT9WfPrNyAtjKROJApNgXequyk1Si5wG
         Bad48OGwDd94bD8bIHL57A6qi3eUQ6sSObzwKBg7E8duo15DyL22UyAxebudRd4v0W
         yqtcipBlP5ckeQBEfaK9rZA1t+8kvF0qL8qDomh64duFXCh/bm6H7R1kqtWlB1H3px
         G8B0iPDcS8M9vT2BRvVvJUgai/D8I5tj9mIqbrMYAP8WOiHnRQskRuVNITUL3gNn9O
         SV5Pfr+uIArA+mmyyZigxb72eyT/sFNYdEUf7ErILfrnqAr4kzaNZi6zEguyHkWHur
         DAGLNrD4yHMwVgWvZxQn7NhHj0ZpjSo1et+jphEpwtya3fJl9AeooG2bFLmwImUGIS
         TLaUbKi5hZXTwGkm5iS6ITam11vhhZ4lnWNZ7m3040u1ovfOjcALAV2NNyDoHLnsHs
         sa+V6hX3fLQsLeoRG/AmQyCaooCc3o+tdPhYQzlodt3/lCc8UO4JseCDctBT+U12v4
         4Ag7nnLYWEhCNtR4bm1o8K2pVlWl8taYZgixKSBfRlf62VEzyRwLPxZLz51T/k8CQU
         Gxhi/STUDwuaA0cF4IYDcGEfjvdSF09Ovfsp+Ea6dHLspmuC6UddusAr6ogbSsrx7b
         7fsHPx4Vefkl4HCaCBDNZblo=
Received: from localhost (eth1-9-167-demarc.sto-kn6.obe.net [195.128.255.107])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id A6460C015E;
        Wed, 15 Feb 2023 10:27:37 +0100 (CET)
From:   Morten Linderud <morten@linderud.pw>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jgg@ziepe.ca, jarkko@kernel.org, peterhuewe@gmx.de
Cc:     Morten Linderud <morten@linderud.pw>,
        Erkki Eilonen <erkki@bearmetal.eu>
Subject: [PATCH v3] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address
Date:   Wed, 15 Feb 2023 10:25:52 +0100
Message-Id: <20230215092552.3004363-1-morten@linderud.pw>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_read_log_acpi() should return -ENODEV when no eventlog from the ACPI
table is found. If the firmware vendor includes an invalid log address
we are unable to map from the ACPI memory and tpm_read_log() returns -EIO
which would abort discovery of the eventlog.

Change the return value from -EIO to -ENODEV when acpi_os_map_iomem()
fails to map the event log.

The following hardware was used to test this issue:
    Framework Laptop (Pre-production)
    BIOS: INSYDE Corp, Revision: 3.2
    TPM Device: NTC, Firmware Revision: 7.2

Dump of the faulty ACPI TPM2 table:
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

Fixes: 0cf577a03f21 ("tpm: Fix handling of missing event log")
Tested-By: Erkki Eilonen <erkki@bearmetal.eu>
Signed-off-by: Morten Linderud <morten@linderud.pw>

---

v2: Tweak commit message and opt to return -ENODEV instead of loosening up the
    if condition in tpm_read_log()

v3: Mention function name instead of "this" in the commit log. Added Tested-By
    and Fixes tags

---
 drivers/char/tpm/eventlog/acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 0913d3eb8d51..cd266021d010 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -143,8 +143,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
 	ret = -EIO;
 	virt = acpi_os_map_iomem(start, len);
-	if (!virt)
+	if (!virt) {
+		dev_warn(&chip->dev, "%s: Failed to map ACPI memory\n", __func__);
+		/* try EFI log next */
+		ret = -ENODEV;
 		goto err;
+	}
 
 	memcpy_fromio(log->bios_event_log, virt, len);
 
-- 
2.39.1
