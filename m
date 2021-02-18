Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4388631F25E
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBRWdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:33:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43706 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBRWdv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:33:51 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6B75320B6C40;
        Thu, 18 Feb 2021 14:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B75320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613687590;
        bh=L6efO3OJdvnv5SH4SMVMlIIzaju+LhwEtznSacYkejQ=;
        h=From:To:Cc:Subject:Date:From;
        b=YJ2kZOgylHgCgliCjux0BWs3q+4RXj42+9SKD+sM6UgKKtXhWhg84r5tGrOGHqIcp
         NzijQuz515P5PDf8LcKvRi59IfpamHgWuqMB5DPQ/KTAuPiimD+Ced3kScsy18zPfM
         OfKDJNe/A4bnOKgHwlhorBgxb4u/PFP2061FIvm0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, joe@perches.com, catalin.marinas@arm.com,
        mpe@ellerman.id.au, sfr@canb.auug.org.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: error: 'const struct kimage' has no member named 'arch'
Date:   Thu, 18 Feb 2021 14:33:05 -0800
Message-Id: <20210218223305.2044-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

of_kexec_alloc_and_setup_fdt() defined in drivers/of/kexec.c builds
a new device tree object that includes architecture specific data
for kexec system call.  This should be defined only if the architecture
being built defines kexec architecture structure "struct kimage_arch".

Define a new boolean config OF_KEXEC that is enabled if
CONFIG_KEXEC_FILE and CONFIG_OF_FLATTREE are enabled, and
the architecture is arm64 or powerpc64.  Build drivers/of/kexec.c
if CONFIG_OF_KEXEC is enabled.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Fixes: 33488dc4d61f ("of: Add a common kexec FDT setup function")
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/of/Kconfig  | 6 ++++++
 drivers/of/Makefile | 7 +------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 18450437d5d5..f2e8fa54862a 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -100,4 +100,10 @@ config OF_DMA_DEFAULT_COHERENT
 	# arches should select this if DMA is coherent by default for OF devices
 	bool
 
+config OF_KEXEC
+	bool
+	depends on KEXEC_FILE
+	depends on OF_FLATTREE
+	default y if ARM64 || PPC64
+
 endif # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index c13b982084a3..287579dd1695 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -13,11 +13,6 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
 obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 obj-$(CONFIG_OF_NUMA) += of_numa.o
-
-ifdef CONFIG_KEXEC_FILE
-ifdef CONFIG_OF_FLATTREE
-obj-y	+= kexec.o
-endif
-endif
+obj-$(CONFIG_OF_KEXEC) += kexec.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
-- 
2.30.0

