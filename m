Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2113A30CC8F
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 21:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbhBBUAP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 15:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbhBBT7S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 14:59:18 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A82C0613D6
        for <linux-integrity@vger.kernel.org>; Tue,  2 Feb 2021 11:58:38 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id e15so9597206lft.13
        for <linux-integrity@vger.kernel.org>; Tue, 02 Feb 2021 11:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MhhwgOn1N74JedwymJwOXrLMJkb43c4MiyURmK6IVGo=;
        b=zVNgJGnXIyk2NqarQYOjX0naPZllf/Flp65XRGcO8mHfJh8ZBg3oexxXjIeHo2X3g6
         3AL4psOfs0CSbAnrsAClzEr0mMq5bwdJqwOsxsMhS5kENf/z39NdBiMUGNPSjWyj0cL9
         LwVB+thx5znrhW660TgR3Rstt5kyWwHqymU8PSMwWpF1sp+amKlXVOL2jxp7Nm+If5pT
         aQZ2nqcGz0tP8mEW+weEp30nUmxkFdIb57q/q4r1hQHwgrarCwfFaRAKUSU1jMmafPwc
         x/TtkoL/wc3fYUWkn8QWikuxnG9KrqVdtuAVZSpNN6FgN9AF2BA3JyD9DAInefiJHCsr
         6Nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MhhwgOn1N74JedwymJwOXrLMJkb43c4MiyURmK6IVGo=;
        b=OGZcRW3QhXKIN4Gu27/K87qLG5CynxKcEob2EjcHje5V7aRrpUniZPZzMl54+RaJlC
         saO62qiRSqUwsQj5qx/45+FBfLmjEHOlX7uwKRkmKg900fY0pUiJ0Hh8FdZSU0B0LMlD
         qsvPt9ATsEBe5zK591L/42Gouz2K7LRWF+CXEeprNEYoIu8U/lYN15CeE2hjmDHEWE6y
         +868arZf/YBaPvXTFTD94XzmmY+mU3hRHcWd7pNMmo6HTfo+SMft1/w3UXExhrylkMDi
         9YH7HJlHsAnrRiM/JF4o4RFzaoMyhJi93oAc8vIMEjAsoPeUwR929IBuk9CwLhb3+Cu2
         Oxcw==
X-Gm-Message-State: AOAM533COycPws4OAOUPgo840QFyzKIUqE7vdIpRcgSWcV86PWA3URWl
        /HqEMt8BwLLKGVi4wzZMQb9lCA==
X-Google-Smtp-Source: ABdhPJw3xRWt+xOstMjuSIDg1/Lep2sxgfxOuRsHOVliUfBWABkoMPc3j+QW5xZR5lBPucR4aSRvtg==
X-Received: by 2002:a19:ef0b:: with SMTP id n11mr12005571lfh.562.1612295916422;
        Tue, 02 Feb 2021 11:58:36 -0800 (PST)
Received: from localhost.localdomain (89-70-221-122.dynamic.chello.pl. [89.70.221.122])
        by smtp.gmail.com with ESMTPSA id z128sm3405360lfa.72.2021.02.02.11.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 11:58:35 -0800 (PST)
From:   Lukasz Majczak <lma@semihalf.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dirk Gouders <dirk@gouders.net>
Cc:     Tj <ml.linux@elloe.vision>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: [PATCH v4] tpm_tis: Add missing tpm_request/relinquish_locality calls
Date:   Tue,  2 Feb 2021 20:57:24 +0100
Message-Id: <20210202195724.628468-1-lma@semihalf.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210202155139.521421-1-lma@semihalf.com>
References: <20210202155139.521421-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There are missing calls to tpm_request_locality before the calls to
the tpm_get_timeouts() and tpm_tis_probe_irq_single() - both functions
internally send commands to the tpm. As the current
approach might work for tpm2, it fails for tpm1.x - in that case
call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
without acquired locality fails and in turn causes tpm_tis_core_init()
to fail, it can be observed in the log with the following warning
trace:

[    4.324298] TPM returned invalid status
[    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
[    4.325888] Modules linked in:
[    4.326287] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         5.11.0-rc6-next-20210201-00003-g214461adb2e8 #43
[    4.327406] Hardware name: Google Caroline/Caroline, BIOS Google_Caroline.7820.430.0 07/20/2018
[    4.327918] RIP: 0010:tpm_tis_status+0x86/0x8f
[    4.328323] Code: 28 00 00 00 48 3b 45 f0 75 24 89 d8 48 83 c4 10 5b 5d c3 c6 05 58 d9 28 01 01 31 db 48 c7 c7 73 52 98 9c 31 c0 e8 c2 17 b0 ff <0f> 0b eb cd e8 cf 4f 55 00 0f 1f 44 00 00 55 48 89 e56
[    4.330592] RSP: 0000:ffff88810092f7a0 EFLAGS: 00010246
[    4.331223] RAX: 691ee151166db100 RBX: 0000000000000000 RCX: 0000000000000001
[    4.331860] RDX: 0000000000000006 RSI: ffffffff9c96d302 RDI: 00000000ffffffff
[    4.332272] RBP: ffff88810092f7b8 R08: dffffc0000000000 R09: fffffbfff39c96ce
[    4.332683] R10: fffffbfff39c96ce R11: 0000000000000001 R12: ffff8881053e2000
[    4.333109] R13: 0000000065000000 R14: ffff888105d71000 R15: ffff888105cd2628
[    4.333738] FS:  0000000000000000(0000) GS:ffff88842f200000(0000) knlGS:0000000000000000
[    4.334432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.334783] CR2: 0000000000000000 CR3: 0000000037828001 CR4: 00000000003706e0
[    4.335196] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.335886] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    4.336793] Call Trace:
[    4.337107]  tpm_tis_send_data+0x3d/0x22f
[    4.337506]  tpm_tis_send_main+0x30/0xf5
[    4.337746]  tpm_transmit+0xbf/0x327
[    4.338042]  ? __alloc_pages_nodemask+0x261/0x36d
[    4.338615]  tpm_transmit_cmd+0x2c/0x93
[    4.339109]  tpm1_getcap+0x232/0x285
[    4.339578]  tpm1_get_timeouts+0x48/0x47d
[    4.339964]  ? lockdep_init_map_type+0x71/0x257
[    4.340256]  ? lockdep_init_map_type+0x71/0x257
[    4.340719]  ? __raw_spin_lock_init+0x40/0x69
[    4.341208]  tpm_tis_core_init+0x402/0x5ee
[    4.341629]  tpm_tis_init+0x11d/0x1a2
[    4.341867]  tpm_tis_pnp_init+0x91/0xb5
[    4.342101]  ? tis_int_handler+0x15f/0x15f
[    4.342466]  pnp_device_probe+0x79/0x9f
[    4.342941]  really_probe+0x149/0x4a8
[    4.343412]  driver_probe_device+0xd6/0x144
[    4.343968]  device_driver_attach+0x42/0x5b
[    4.344382]  __driver_attach+0xca/0x139
[    4.344617]  ? driver_attach+0x1f/0x1f
[    4.344860]  bus_for_each_dev+0x85/0xb7
[    4.345096]  bus_add_driver+0x12b/0x228
[    4.345330]  driver_register+0x64/0xed
[    4.345560]  init_tis+0xa5/0xeb
[    4.345784]  ? lock_is_held_type+0x100/0x141
[    4.346044]  ? tpm_init+0x106/0x106
[    4.346259]  ? rcu_read_lock_sched_held+0x41/0x7e
[    4.346542]  ? tpm_init+0x106/0x106
[    4.346678] battery: ACPI: Battery Slot [BAT0] (battery present)
[    4.346754]  do_one_initcall+0x1b9/0x43d
[    4.346776]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
[    4.347659]  ? lockdep_hardirqs_on+0x8e/0x12e
[    4.347937]  ? lock_is_held_type+0x100/0x141
[    4.348196]  ? rcu_read_lock_sched_held+0x41/0x7e
[    4.348477]  do_initcall_level+0x99/0xa9
[    4.348717]  ? kernel_init+0xe/0x10a
[    4.348954]  do_initcalls+0x4e/0x79
[    4.349170]  kernel_init_freeable+0x15a/0x1ae
[    4.349434]  ? rest_init+0x1d6/0x1d6
[    4.349655]  kernel_init+0xe/0x10a
[    4.349882]  ret_from_fork+0x22/0x30
[    4.350103] irq event stamp: 700039
[    4.350318] hardirqs last  enabled at (700047): [<ffffffff9b735265>] console_unlock+0x4be/0x538
[    4.350836] hardirqs last disabled at (700056): [<ffffffff9b734e84>] console_unlock+0xdd/0x538
[    4.351331] softirqs last  enabled at (699522): [<ffffffff9c4004ec>] __do_softirq+0x4ec/0x539
[    4.351835] softirqs last disabled at (699517): [<ffffffff9c200f62>] asm_call_irq_on_stack+0x12/0x20

Following the trace one can also notice a comment in the tpm_tis_status():

		/*
		 * If this trips, the chances are the read is
		 * returning 0xff because the locality hasn't been
		 * acquired.  Usually because tpm_try_get_ops() hasn't
		 * been called before doing a TPM operation.
		 */
In this case we don't have to call tpm_try_get_ops()
as both calls (tpm_get_timeouts() and tpm_tis_probe_irq_single()) are
in the tpm_tis_core_init function and don't require any locking or clock
enablement. Similar usage is in the probe_itpm() function also called
inside tpm_tis_core_init().
Tested on Samsung Chromebook Pro (Caroline).

Signed-off-by: Lukasz Majczak <lma@semihalf.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Hi Dirk,

Good catch, thank you.

v3 -> v4:
- Added EXPORT_SYMBOL_GPL for tpm_request_locality/tpm_relinquish_locality

 drivers/char/tpm/tpm-chip.c      |  6 ++++--
 drivers/char/tpm/tpm-interface.c | 13 ++++++++++---
 drivers/char/tpm/tpm.h           |  2 ++
 drivers/char/tpm/tpm_tis_core.c  | 14 +++++++++++---
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..ce9c2650fbe5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -32,7 +32,7 @@ struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
 
-static int tpm_request_locality(struct tpm_chip *chip)
+int tpm_request_locality(struct tpm_chip *chip)
 {
 	int rc;
 
@@ -46,8 +46,9 @@ static int tpm_request_locality(struct tpm_chip *chip)
 	chip->locality = rc;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(tpm_request_locality);
 
-static void tpm_relinquish_locality(struct tpm_chip *chip)
+void tpm_relinquish_locality(struct tpm_chip *chip)
 {
 	int rc;
 
@@ -60,6 +61,7 @@ static void tpm_relinquish_locality(struct tpm_chip *chip)
 
 	chip->locality = -1;
 }
+EXPORT_SYMBOL_GPL(tpm_relinquish_locality);
 
 static int tpm_cmd_ready(struct tpm_chip *chip)
 {
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1621ce818705..2a9001d329f2 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -241,10 +241,17 @@ int tpm_get_timeouts(struct tpm_chip *chip)
 	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
 		return 0;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		return tpm2_get_timeouts(chip);
-	else
-		return tpm1_get_timeouts(chip);
+	} else {
+		ssize_t ret = tpm_request_locality(chip);
+
+		if (ret)
+			return ret;
+		ret = tpm1_get_timeouts(chip);
+		tpm_relinquish_locality(chip);
+		return ret;
+	}
 }
 EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 947d1db0a5cc..8c13008437dd 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
 
 int tpm_chip_start(struct tpm_chip *chip);
 void tpm_chip_stop(struct tpm_chip *chip);
+int tpm_request_locality(struct tpm_chip *chip);
+void tpm_relinquish_locality(struct tpm_chip *chip);
 struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
 __must_check int tpm_try_get_ops(struct tpm_chip *chip);
 void tpm_put_ops(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 431919d5f48a..d4f381d6356e 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -708,11 +708,19 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
 	u32 cap2;
 	cap_t cap;
 
-	if (chip->flags & TPM_CHIP_FLAG_TPM2)
+	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
-	else
-		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
+	} else {
+		ssize_t ret = tpm_request_locality(chip);
+
+		if (ret)
+			return ret;
+		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
 				  0);
+		tpm_relinquish_locality(chip);
+		return ret;
+	}
+
 }
 
 /* Register the IRQ and issue a command that will cause an interrupt. If an
-- 
2.25.1

