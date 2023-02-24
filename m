Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A26A154C
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 04:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBXDZT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBXDZS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 22:25:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6744ECFE
        for <linux-integrity@vger.kernel.org>; Thu, 23 Feb 2023 19:25:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNFdK6DS1z4x5Q;
        Fri, 24 Feb 2023 14:25:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677209111;
        bh=f9fEx8j0jj89BVTy91Dw+yN7Hc8qMMhDUTexCxs3yxg=;
        h=From:To:Cc:Subject:Date:From;
        b=g3OSz7cUBWWWWLJZLFoU23xQhHI5WPBtC6wyvchBhsR09XL/E2NcKtlr1su0w/qZq
         +QvW6JkoguCNxth8RxOX6pixkO0Tqqm4m+1yHjNYz2oYbYB7xRu+SwtL0nmoejkv3L
         ScYrMr4lbenKGiFUANVIor0Y0erggqW9Ur/Mp4wmY/HEGStkbDJFoNL9Nga+KdfBCk
         GgfA+6ZzOtquO2odxVywkjSNRevr0SzhwV2GnrOqEVDx2f+iRorIVR1xSipl6LQ8tc
         P2lfrYuDXCMJG72d/Z1l3GJ1XEayq/86l0shrZnHfGAs6rh0d4X1zWovpjsm/q+786
         To9KbydKUZ1+Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     linux-integrity@vger.kernel.org, yangyingliang@huawei.com,
        eajames@linux.ibm.com, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, <stefanb@linux.ibm.com>
Subject: [PATCH 1/2] powerpc/tpm: Create linux,sml-base/size as big endian
Date:   Fri, 24 Feb 2023 14:25:07 +1100
Message-Id: <20230224032508.3331281-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There's code in prom_instantiate_sml() to do a "SML handover" (Stored
Measurement Log) from OF to Linux, before Linux shuts down Open
Firmware.

This involves creating a buffer to hold the SML, and creating two device
tree properties to record its base address and size. The kernel then
later reads those properties from the device tree to find the SML.

When the code was initially added in commit 4a727429abec ("PPC64: Add
support for instantiating SML from Open Firmware") the powerpc kernel
was always built big endian, so the properties were created big endian
by default.

However since then little endian support was added to powerpc, and now
the code lacks conversions to big endian when creating the properties.

This means on little endian kernels the device tree properties are
little endian, which is contrary to the device tree spec, and in
contrast to all other device tree properties.

To cope with that a workaround was added in tpm_read_log_of() to skip
the endian conversion if the properties were created via the SML
handover.

A better solution is to encode the properties as big endian as they
should be, and remove the workaround.

Typically changing the encoding of a property like this would present
problems for kexec. However the SML is not propagated across kexec, so
changing the encoding of the properties is a non-issue.

Fixes: e46e22f12b19 ("tpm: enhance read_log_of() to support Physical TPM event log")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/prom_init.c |  8 ++++++--
 drivers/char/tpm/eventlog/of.c  | 23 ++++-------------------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d464ba412084..72fe306b6820 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1900,6 +1900,7 @@ static void __init prom_instantiate_sml(void)
 	u32 entry = 0, size = 0, succ = 0;
 	u64 base;
 	__be32 val;
+	__be64 val64;
 
 	prom_debug("prom_instantiate_sml: start...\n");
 
@@ -1956,10 +1957,13 @@ static void __init prom_instantiate_sml(void)
 
 	reserve_mem(base, size);
 
+	val64 = cpu_to_be64(base);
 	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
-		     &base, sizeof(base));
+		     &val64, sizeof(val64));
+
+	val = cpu_to_be32(size);
 	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
-		     &size, sizeof(size));
+		     &val, sizeof(val));
 
 	prom_debug("sml base     = 0x%llx\n", base);
 	prom_debug("sml size     = 0x%x\n", size);
diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index 930fe43d5daf..0bc0cb6333c6 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -51,8 +51,8 @@ static int tpm_read_log_memory_region(struct tpm_chip *chip)
 int tpm_read_log_of(struct tpm_chip *chip)
 {
 	struct device_node *np;
-	const u32 *sizep;
-	const u64 *basep;
+	const __be32 *sizep;
+	const __be64 *basep;
 	struct tpm_bios_log *log;
 	u32 size;
 	u64 base;
@@ -73,23 +73,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	if (sizep == NULL || basep == NULL)
 		return -EIO;
 
-	/*
-	 * For both vtpm/tpm, firmware has log addr and log size in big
-	 * endian format. But in case of vtpm, there is a method called
-	 * sml-handover which is run during kernel init even before
-	 * device tree is setup. This sml-handover function takes care
-	 * of endianness and writes to sml-base and sml-size in little
-	 * endian format. For this reason, vtpm doesn't need conversion
-	 * but physical tpm needs the conversion.
-	 */
-	if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
-	    of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
-		size = be32_to_cpup((__force __be32 *)sizep);
-		base = be64_to_cpup((__force __be64 *)basep);
-	} else {
-		size = *sizep;
-		base = *basep;
-	}
+	size = be32_to_cpup(sizep);
+	base = be64_to_cpup(basep);
 
 	if (size == 0) {
 		dev_warn(&chip->dev, "%s: Event log area empty\n", __func__);
-- 
2.39.1

