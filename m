Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC745430E7
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 14:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbiFHM53 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 08:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiFHM52 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 08:57:28 -0400
X-Greylist: delayed 930 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 05:57:25 PDT
Received: from linderud.pw (linderud.dev [163.172.10.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2123A00E;
        Wed,  8 Jun 2022 05:57:24 -0700 (PDT)
Received: from linderud.pw (localhost [127.0.0.1])
        by linderud.pw (Postfix) with ESMTP id 85067C0273;
        Wed,  8 Jun 2022 14:32:46 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linderud.pw;
        s=linderud; t=1654691566;
        bh=M3XueMVFe7gOTM1GQj/+FxeEg3x7aocLkX7oHxmpKcA=;
        h=From:To:Cc:Subject:Date;
        b=KMQ+jTr9zGswdqCgz7EFNCXBQN8V1/e15wofI/Hy9Im+KwV/gaKnl+swjxYb8wcA7
         pj2SQgx+rsp6F5NmCnZlwBXGootjC6hC83SXFcGoG6neoPCXpLkFZjkpsOethxMs6k
         Xp1aG6U9X63Eab82633iTJnmEF44Cba1F/6LUHmibeN45AP7zq7Qcagvi67RbenzG6
         ytNlPcQqnfEniXwIGBWrMIRU1uSzY3qk5OtXuQQZdoN4Ei1foCrQAmSfD6QltKOuYV
         iJh25G5ZxR/OxphnSHsjU4kUpxOGzPNETgFP+wX7mdJEIABYaa7TI9KlH7mZqgmoz7
         WQRbOFhGqenM1Q/UmMXhtRba14wEjt7Y5QV7SEyBSq9rYezRG1VuzhpUhcn9qIsltc
         GaWj5RZLpa5REHZY3/VoRmlq/uSrUx4y1pcmphvNvbmLRXOhjUS3Faa4YQHOFv7hgR
         EhPYo001tQ8o1u1uZKZFQpRMS1UQGFVkShCV3hHGPDinPpuA9mx/3PjsSdedj+4JfC
         103QklHmgraPCzmj724lAjFULiNf4a39XVNzQyQAyPty6QX9KbunQBttRK7p+Q+rdK
         pi7+Gm/FHDAuPJGt+AMjIdJJTvnfhiVyEpPH5b4YLHiSWtXc6jl/0d/a8eaemHkhp7
         09ZYoru9vETf8eljjE9M3QO0=
Received: from localhost (101.81-167-132.customer.lyse.net [81.167.132.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: morten)
        by linderud.pw (Postfix) with ESMTPSA id 40FDDC0077;
        Wed,  8 Jun 2022 14:32:46 +0200 (CEST)
From:   Morten Linderud <morten@linderud.pw>
Cc:     Morten Linderud <morten@linderud.pw>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address
Date:   Wed,  8 Jun 2022 14:31:08 +0200
Message-Id: <20220608123109.678343-1-morten@linderud.pw>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm_read_log_acpi() should return -ENODEV when no eventlog from the ACPI
table is found. If the firmware vendor includes an invalid log address
we are unable to map from the ACPI memory and the function returns -EIO
which would abort discovery of the eventlog.

This change ensure we always return -ENODEV in tpm_read_log_acpi() and
fallback to the EFI configuration table.

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

Signed-off-by: Morten Linderud <morten@linderud.pw>

---

v2: Tweak commit message and opt to return -ENODEV instead of loosening up the
    if condition in tpm_read_log()

---
 drivers/char/tpm/eventlog/acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 1b18ce5ebab1..2b15d6eebd69 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -136,8 +136,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 
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
2.36.1
