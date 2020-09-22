Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27887273EB4
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Sep 2020 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIVJlt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Sep 2020 05:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJlt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Sep 2020 05:41:49 -0400
Received: from e123331-lin.nice.arm.com (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE322239A1;
        Tue, 22 Sep 2020 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600767708;
        bh=ttUaxpIoiZeqwIvQOhaNFmyYIhNSRt/G+yBAvPlz2is=;
        h=From:To:Cc:Subject:Date:From;
        b=BJ39ovw6VE7ZMD0AA2u98IyiuiYME3jBM9sXvoNy8Ft+JWMjZyHcVJwtvmPFPE//W
         /iK5le6ma37lYtFiGtTrtRTAx1/r1AShY/LYID9q0S/5Fd76/JbiG+jtmNHxPpZ6g5
         i7VSqgb94mZiYrIHEvum2OdY3lHxtJiL9rNlW/5s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: of: avoid __va() translation for event log address
Date:   Tue, 22 Sep 2020 11:41:28 +0200
Message-Id: <20200922094128.26245-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The TPM event log is provided to the OS by the firmware, by loading
it into an area in memory and passing the physical address via a node
in the device tree.

Currently, we use __va() to access the memory via the kernel's linear
map: however, it is not guaranteed that the linear map covers this
particular address, as we may be running under HIGHMEM on a 32-bit
architecture, or running firmware that uses a memory type for the
event log that is omitted from the linear map (such as EfiReserved).

So instead, use memremap(), which will reuse the linear mapping if
it is valid, or create another mapping otherwise.

Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/tpm/eventlog/of.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/of.c b/drivers/char/tpm/eventlog/of.c
index a9ce66d09a75..9178547589a3 100644
--- a/drivers/char/tpm/eventlog/of.c
+++ b/drivers/char/tpm/eventlog/of.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/tpm_eventlog.h>
 
@@ -25,6 +26,7 @@ int tpm_read_log_of(struct tpm_chip *chip)
 	struct tpm_bios_log *log;
 	u32 size;
 	u64 base;
+	void *p;
 
 	log = &chip->log;
 	if (chip->dev.parent && chip->dev.parent->of_node)
@@ -65,7 +67,11 @@ int tpm_read_log_of(struct tpm_chip *chip)
 		return -EIO;
 	}
 
-	log->bios_event_log = kmemdup(__va(base), size, GFP_KERNEL);
+	p = memremap(base, size, MEMREMAP_WB);
+	if (!p)
+		return -ENOMEM;
+	log->bios_event_log = kmemdup(p, size, GFP_KERNEL);
+	memunmap(p);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
-- 
2.17.1

