Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9753A79DE
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 11:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbhFOJQW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 05:16:22 -0400
Received: from smtp1.axis.com ([195.60.68.17]:30212 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhFOJQW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 05:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1623748458;
  x=1655284458;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qElVcfvIwYnEaQT7arkqSk0OGx8rWQJa8m6BPTAteKQ=;
  b=g5otGcuQ/GDICemRDsxDUX0y+MtKBlQ1CB9VEvQ4EeveCcolV2v+W0sN
   xA2ub1cUWFDdKrrHN/6/eTcwjV4tG0ewhHsjH/n2XPn7iLMHiEZf2FfYS
   CAQr+bpQMbEpeHDJutgqKQ2Hr7rk9rJItpNZMiqhZJ4DMBPiNKbstvKse
   rtwk1pZn0Z7BfZIWlPmg8UnzMy7vxYtJPRXPOyRGRNDamVfTC/otXeKe0
   iiNhGIE5JK79+XZPu2QAKZwqSE6Jg2tYOoGZEUdfvze+zrx/YFBCAxfSF
   h3IgMyvYUg1xmbCw15e7GhOefzmrP6Rci0gf2bRM1Bf16hXQJcye182om
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] tpm: Fix tpmrm reference counting
Date:   Tue, 15 Jun 2021 11:14:08 +0200
Message-ID: <20210615091410.17007-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The code added by commit 8979b02aaf1d6de8 ("tpm: Fix reference count to
main device") tries to take an extra reference to the main device only
for TPM2 by looking at the flags, but the flags are actually not set
at the time when tpm_chip_alloc() is called, so no extra reference is
ever taken, leading to a use-after-free if the TPM modules are removed
when the tpmrm device is in use.

 ==================================================================
 BUG: KASAN: use-after-free in __mutex_lock+0xe0/0xbd0
 Read of size 8 at addr ffff888116c6acc0 by task sh/1210

 CPU: 0 PID: 1210 Comm: sh Not tainted 5.13.0-rc5+ #200
 Call Trace:
  __mutex_lock+0xe0/0xbd0
  tpm2_del_space+0x24/0xa0 [tpm]
  tpmrm_release+0x3f/0x50 [tpm]
  __fput+0x110/0x3c0
  task_work_run+0x94/0xd0
  do_exit+0x683/0x13e0
  do_syscall_64+0x3c/0x80

 Allocated by task 1153:
  kasan_save_stack+0x19/0x40
  __kasan_kmalloc+0x7f/0xa0
  tpm_chip_alloc+0x3b/0x360 [tpm]
  tpmm_chip_alloc+0x11/0x70 [tpm]
  tpm_tis_core_init+0xce/0x570 [tpm_tis_core]
  pnp_device_probe+0x9c/0x100
  ...

 Freed by task 1243:
  kfree+0x121/0x340
  device_release+0x59/0xf0
  kobject_put+0xa5/0x120
  release_nodes+0x37f/0x3f0
  driver_detach+0x7c/0xf0
  bus_remove_driver+0x86/0x110
  __x64_sys_delete_module+0x27b/0x320
  ...
 ==================================================================

The real fix to the problem which that commit tried to solve is to make
tpmm_chip_alloc() put the ->devs device in the devm release function,
since that is never done anywhere currently.  This is safe since
device_initialize() is always called on ->devs.  No conditional
reference taking is needed.

Fixes: 8979b02aaf1d6de8 ("tpm: Fix reference count to main device")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/char/tpm/tpm-chip.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..029ee61c38de 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -358,10 +358,9 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	/* get extra reference on main device to hold on
 	 * behalf of devs.  This holds the chip structure
 	 * while cdevs is in use.  The corresponding put
-	 * is in the tpm_devs_release (TPM2 only)
+	 * is in the tpm_devs_release
 	 */
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
-		get_device(&chip->dev);
+	get_device(&chip->dev);
 
 	if (chip->dev_num == 0)
 		chip->dev.devt = MKDEV(MISC_MAJOR, TPM_MINOR);
@@ -402,6 +401,14 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 }
 EXPORT_SYMBOL_GPL(tpm_chip_alloc);
 
+static void tpmm_chip_release(void *data)
+{
+	struct tpm_chip *chip = data;
+
+	put_device(&chip->devs);
+	put_device(&chip->dev);
+}
+
 /**
  * tpmm_chip_alloc() - allocate a new struct tpm_chip instance
  * @pdev: parent device to which the chip is associated
@@ -419,9 +426,7 @@ struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
 	if (IS_ERR(chip))
 		return chip;
 
-	rc = devm_add_action_or_reset(pdev,
-				      (void (*)(void *)) put_device,
-				      &chip->dev);
+	rc = devm_add_action_or_reset(pdev, tpmm_chip_release, chip);
 	if (rc)
 		return ERR_PTR(rc);
 
-- 
2.28.0

