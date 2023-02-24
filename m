Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55AC6A154B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 04:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBXDZT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Feb 2023 22:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBXDZS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Feb 2023 22:25:18 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F084ECF7
        for <linux-integrity@vger.kernel.org>; Thu, 23 Feb 2023 19:25:16 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNFdM6r6Fz4x7x;
        Fri, 24 Feb 2023 14:25:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677209112;
        bh=/9VqHm7jT+WqQqauMLXrjukLOqUdxO0gBCzMxDE6cBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNQDpe+xPhWVvJ6Ln+YY3R77+Ki+zPV3UZ2PhwOAv0q6cFjsr4aTmHt13iX6JcHeT
         iEXh6ckWZ7DE+n63hotFqB47AGfzALF+STNaQoOQc+p7x1GzqUYcyL4/oEFLbhaT2j
         u1GW//RIVzfoLd01lbPZ829sl7JhLymTTCNSofIc4A3XMr3SCdyoREEpATjOWbHexB
         caeSVg+NjpNQl+JNgp6J9hgs0HmhVTzbyajSdtLTrZgeOokkkVX/RmG5/DpmPSeade
         yUxqw7nuS2oHorPlwbvinIWCiSDQGYSBhZyPJd/AvF1oBztIVHyy/PZHGobVr3DWpv
         TIEKYbLfijZ7g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     linux-integrity@vger.kernel.org, yangyingliang@huawei.com,
        eajames@linux.ibm.com, jgg@ziepe.ca, jarkko@kernel.org,
        peterhuewe@gmx.de, <stefanb@linux.ibm.com>
Subject: [PATCH 2/2] powerpc/tpm: Reserve SML log when kexec'ing
Date:   Fri, 24 Feb 2023 14:25:08 +1100
Message-Id: <20230224032508.3331281-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230224032508.3331281-1-mpe@ellerman.id.au>
References: <20230224032508.3331281-1-mpe@ellerman.id.au>
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

The TPM code in prom_init.c creates a small buffer of memory to store
the TPM's SML (Stored Measurement Log). It's communicated to Linux via
the linux,sml-base/size device tree properties of the TPM node.

When kexec'ing that buffer can be overwritten, or when kdump'ing it may
not be mapped by the second kernel. The latter can lead to a crash when
booting the second kernel such as:

  tpm_ibmvtpm 71000003: CRQ initialization completed
  BUG: Unable to handle kernel data access on read at 0xc00000002ffb0000
  Faulting instruction address: 0xc0000000200a70e0
  Oops: Kernel access of bad area, sig: 11 [#1]
  LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.2.0-rc2-00134-g9307ce092f5d #314
  Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1200 0xf000005 of:SLOF,git-5b4c5a pSeries
  NIP:  c0000000200a70e0 LR: c0000000203dd5dc CTR: 0000000000000800
  REGS: c000000024543280 TRAP: 0300   Not tainted  (6.2.0-rc2-00134-g9307ce092f5d)
  MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24002280  XER: 00000006
  CFAR: c0000000200a70c8 DAR: c00000002ffb0000 DSISR: 40000000 IRQMASK: 0
  ...
  NIP memcpy_power7+0x400/0x7d0
  LR  kmemdup+0x5c/0x80
  Call Trace:
    memcpy_power7+0x274/0x7d0 (unreliable)
    kmemdup+0x5c/0x80
    tpm_read_log_of+0xe8/0x1b0
    tpm_bios_log_setup+0x60/0x210
    tpm_chip_register+0x134/0x320
    tpm_ibmvtpm_probe+0x520/0x7d0
    vio_bus_probe+0x9c/0x460
    really_probe+0x104/0x420
    __driver_probe_device+0xb0/0x170
    driver_probe_device+0x58/0x180
    __driver_attach+0xd8/0x250
    bus_for_each_dev+0xb4/0x140
    driver_attach+0x34/0x50
    bus_add_driver+0x1e8/0x2d0
    driver_register+0xb4/0x1c0
    __vio_register_driver+0x74/0x9c
    ibmvtpm_module_init+0x34/0x48
    do_one_initcall+0x80/0x320
    kernel_init_freeable+0x304/0x3ac
    kernel_init+0x30/0x1a0
    ret_from_kernel_thread+0x5c/0x64

To fix the crash, add the SML region to the usable memory areas for the
kdump kernel, so that the second kernel will map the region. To avoid
corruption of the region, add the region to the reserved memory areas,
so that the second kernel does not use the memory for something else.

Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/kexec_ranges.h |  1 +
 arch/powerpc/kexec/file_load_64.c       | 12 ++++++++++++
 arch/powerpc/kexec/ranges.c             | 20 ++++++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
index f83866a19e87..cf6a97f9113d 100644
--- a/arch/powerpc/include/asm/kexec_ranges.h
+++ b/arch/powerpc/include/asm/kexec_ranges.h
@@ -21,5 +21,6 @@ int add_kernel_mem_range(struct crash_mem **mem_ranges);
 int add_rtas_mem_range(struct crash_mem **mem_ranges);
 int add_opal_mem_range(struct crash_mem **mem_ranges);
 int add_reserved_mem_ranges(struct crash_mem **mem_ranges);
+int add_sml_mem_range(struct crash_mem **mem_ranges);
 
 #endif /* _ASM_POWERPC_KEXEC_RANGES_H */
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 110d28bede2a..90c10a89fcbc 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -79,6 +79,10 @@ static int get_exclude_memory_ranges(struct crash_mem **mem_ranges)
 	if (ret)
 		goto out;
 
+	ret = add_sml_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
 	ret = add_opal_mem_range(mem_ranges);
 	if (ret)
 		goto out;
@@ -122,6 +126,10 @@ static int get_usable_memory_ranges(struct crash_mem **mem_ranges)
 	if (ret)
 		goto out;
 
+	ret = add_sml_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
 	ret = add_opal_mem_range(mem_ranges);
 	if (ret)
 		goto out;
@@ -225,6 +233,10 @@ static int get_reserved_memory_ranges(struct crash_mem **mem_ranges)
 	if (ret)
 		goto out;
 
+	ret = add_sml_mem_range(mem_ranges);
+	if (ret)
+		goto out;
+
 	ret = add_tce_mem_ranges(mem_ranges);
 	if (ret)
 		goto out;
diff --git a/arch/powerpc/kexec/ranges.c b/arch/powerpc/kexec/ranges.c
index 5fc53a5fcfdf..8b01655ceb5e 100644
--- a/arch/powerpc/kexec/ranges.c
+++ b/arch/powerpc/kexec/ranges.c
@@ -350,6 +350,26 @@ int add_rtas_mem_range(struct crash_mem **mem_ranges)
 	return ret;
 }
 
+int add_sml_mem_range(struct crash_mem **mem_ranges)
+{
+	struct device_node *dn;
+	int ret = 0;
+	u64 base;
+	u32 size;
+
+	// Matches the device type in tpm_ibmvtpm.c
+	for_each_node_by_type(dn, "IBM,vtpm") {
+		if (of_property_read_u64(dn, "linux,sml-base", &base) == 0 &&
+		    of_property_read_u32(dn, "linux,sml-size", &size) == 0) {
+			ret = add_mem_range(mem_ranges, base, size);
+			if (ret)
+				break;
+		}
+	}
+
+	return ret;
+}
+
 /**
  * add_opal_mem_range - Adds OPAL region to the given memory ranges list.
  * @mem_ranges:         Range list to add the memory range to.
-- 
2.39.1

