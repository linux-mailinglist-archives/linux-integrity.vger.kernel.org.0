Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBC53A0849
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 02:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbhFIA1l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Jun 2021 20:27:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55072 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhFIA1j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:39 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42DCC20B7188;
        Tue,  8 Jun 2021 17:25:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42DCC20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623198346;
        bh=whfJfsHqMmmVau0YBJ0E1Ux41l/udPG1ewedmaTL4yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mrUWk/a/8WFLr9zvV00FelKa/DqkCQq5H5sdjPOZaay6RrKayhoRrGkE9T66n76vK
         REP1nDe9q2yDsPe4Cm8/DBkr+jVXrQF3QPevxwIk8PLGxGP24Meh3Ko0cVOKY8Z5h4
         CVxjwc7TS76OZHlUp0uZQ2KvW1NEmBijjwhyE8o4=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] optee: Refuse to load the driver under the kdump kernel
Date:   Tue,  8 Jun 2021 19:23:21 -0500
Message-Id: <20210609002326.210024-3-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix a hung task issue, seen when booting the kdump kernel, that is
caused by all of the secure world threads being in a permanent suspended
state:

 INFO: task swapper/0:1 blocked for more than 120 seconds.
       Not tainted 5.4.83 #1
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 swapper/0       D    0     1      0 0x00000028
 Call trace:
  __switch_to+0xc8/0x118
  __schedule+0x2e0/0x700
  schedule+0x38/0xb8
  schedule_timeout+0x258/0x388
  wait_for_completion+0x16c/0x4b8
  optee_cq_wait_for_completion+0x28/0xa8
  optee_disable_shm_cache+0xb8/0xf8
  optee_probe+0x560/0x61c
  platform_drv_probe+0x58/0xa8
  really_probe+0xe0/0x338
  driver_probe_device+0x5c/0xf0
  device_driver_attach+0x74/0x80
  __driver_attach+0x64/0xe0
  bus_for_each_dev+0x84/0xd8
  driver_attach+0x30/0x40
  bus_add_driver+0x188/0x1e8
  driver_register+0x64/0x110
  __platform_driver_register+0x54/0x60
  optee_driver_init+0x20/0x28
  do_one_initcall+0x54/0x24c
  kernel_init_freeable+0x1e8/0x2c0
  kernel_init+0x18/0x118
  ret_from_fork+0x10/0x18

The invoke_fn hook returned OPTEE_SMC_RETURN_ETHREAD_LIMIT, indicating
that the secure world threads were all in a suspended state at the time
of the kernel crash. This intermittently prevented the kdump kernel from
booting, resulting in a failure to collect the kernel dump.

Make kernel dump collection more reliable on systems utilizing OP-TEE by
refusing to load the driver under the kdump kernel.

Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ddb8f9ecf307..5288cd767d82 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/arm-smccc.h>
+#include <linux/crash_dump.h>
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -612,6 +613,16 @@ static int optee_probe(struct platform_device *pdev)
 	u32 sec_caps;
 	int rc;
 
+	/*
+	 * The kernel may have crashed at the same time that all available
+	 * secure world threads were suspended and we cannot reschedule the
+	 * suspended threads without access to the crashed kernel's wait_queue.
+	 * Therefore, we cannot reliably initialize the OP-TEE driver in the
+	 * kdump kernel.
+	 */
+	if (is_kdump_kernel())
+		return -ENODEV;
+
 	invoke_fn = get_invoke_func(&pdev->dev);
 	if (IS_ERR(invoke_fn))
 		return PTR_ERR(invoke_fn);
-- 
2.25.1

