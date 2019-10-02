Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE786C8F4A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 19:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfJBRD6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 13:03:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43197 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbfJBRD6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 13:03:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so20528589wrx.10
        for <linux-integrity@vger.kernel.org>; Wed, 02 Oct 2019 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvNNDWNhX2Fb3QLVftkYDMZhyGKIzxVRGVz9KnZzIlA=;
        b=HGQ3gNIggfEXj7AYkwnJT9Qjz0IwaBjNifqvg2AUMkYBpkURvXrJ3mFFLx8YmRM01s
         MQFAu94mNsU0c82mxdT74zHcr8NAMDdqG/CQgoyxhTzvckbEFrY8NEfFHOxXy2DBxiIL
         kAVVbEoN5qr+o+totHIOgapck7eivCrc047FPvxseQattsch16J4/BhPLidznQjuCZQ2
         BaSOlYPJ3RSY0Ld4a15n0DWzM7NP4SgsUIp/U4lobd0ucRCYxUu+oLRYZwofmZYXR+b9
         j2G1/EkIlxdKPW9ZKbQEPAt369KCTEIqTm0hb3O7o8te55yL4yFi4c+TeWxwznbJtmLM
         TFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvNNDWNhX2Fb3QLVftkYDMZhyGKIzxVRGVz9KnZzIlA=;
        b=LaWLzjPE9qb2jpIe2kfGaLx0fkCNZw+p/nNvewynO3lw++RUOn4c1qugQ0xlEQH65f
         Ta000kCABNkHWSDvoIliCihCjc8D3tl4vjkupUde0m5Z3kqBg21Mmn37d7DYZtOcm8KL
         MqIgn9wDYOhNX2vxdjXQJ4lS0PbrFiDjiV+QCB5/Y8AE+CMtfGlwxyzU3sEcC8K+T73O
         4gkxzhXvV4QWAn0zWtZypA3s6JbZDiUvBh+pr6nf9+Q/gVxwhWDx1K58oy8cOpuVLlvP
         oRGENviyZJR+5XHl/10Bss5vn7Zb35yMHtBJZDTFlVAnUJJt0TpzqY9PFI3+JojJbm3A
         hJXw==
X-Gm-Message-State: APjAAAUHdMIfqtKLDoP3uppIpTZhQhX5Xj0if1nuURWhxLu6BHmxY9ax
        QC3Jt7kj2DfRKEG1TPF4Hd6JPg==
X-Google-Smtp-Source: APXvYqwrQBO8A3rwHTnKPxIeVjz0IPXL0H/YrWpwVQJZXWaJcoQXydKEl0dLpN5PIdPS798Wpk78qA==
X-Received: by 2002:a5d:490f:: with SMTP id x15mr3410913wrq.375.1570035835970;
        Wed, 02 Oct 2019 10:03:55 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:f145:3252:fc29:76c9])
        by smtp.gmail.com with ESMTPSA id f18sm7085459wmh.43.2019.10.02.10.03.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 10:03:55 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Dave Young <dyoung@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Lyude Paul <lyude@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Peter Jones <pjones@redhat.com>, Scott Talbert <swt@techie.net>
Subject: [PATCH 5/7] efi/tpm: only set efi_tpm_final_log_size after successful event log parsing
Date:   Wed,  2 Oct 2019 18:59:02 +0200
Message-Id: <20191002165904.8819-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
References: <20191002165904.8819-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jerry Snitselaar <jsnitsel@redhat.com>

If __calc_tpm2_event_size fails to parse an event it will return 0,
resulting tpm2_calc_event_log_size returning -1. Currently there is
no check of this return value, and efi_tpm_final_log_size can end up
being set to this negative value resulting in a panic like the
the one given below.

Also __calc_tpm2_event_size returns a size of 0 when it fails
to parse an event, so update function documentation to reflect this.

[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc00866ad
[    0.774788] #PF: supervisor read access in kernel mode
[    0.774788] #PF: error_code(0x0000) - not-present page
[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PTE 0
[    0.774788] Oops: 0000 [#1] SMP PTI
[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.elrdy.x86_64 #1
[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W (1.30 ) 09/14/2018
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Call Trace:
[    0.774788]  tpm_read_log_efi+0x156/0x1a0
[    0.774788]  tpm_bios_log_setup+0xc8/0x190
[    0.774788]  tpm_chip_register+0x50/0x1c0
[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
[    0.774788]  platform_drv_probe+0x35/0x80
[    0.774788]  really_probe+0xef/0x390
[    0.774788]  driver_probe_device+0xb4/0x100
[    0.774788]  device_driver_attach+0x4f/0x60
[    0.774788]  __driver_attach+0x86/0x140
[    0.774788]  ? device_driver_attach+0x60/0x60
[    0.774788]  bus_for_each_dev+0x76/0xc0
[    0.774788]  ? klist_add_tail+0x3b/0x70
[    0.774788]  bus_add_driver+0x14a/0x1e0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  driver_register+0x6b/0xb0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  init_tis+0x86/0xd8
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  ? driver_register+0x94/0xb0
[    0.774788]  do_one_initcall+0x46/0x1e4
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  kernel_init_freeable+0x199/0x242
[    0.774788]  ? rest_init+0xaa/0xaa
[    0.774788]  kernel_init+0xa/0x106
[    0.774788]  ret_from_fork+0x35/0x40
[    0.774788] Modules linked in:
[    0.774788] CR2: ffffbc8fc00866ad
[    0.774788] ---[ end trace 42930799f8d6eaea ]---
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Kernel panic - not syncing: Fatal exception
[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---

The root cause of the issue that caused the failure of event parsing
in this case is resolved by Peter Jone's patchset dealing with large
event logs where crossing over a page boundary causes the page with
the event count to be unmapped.

Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
Cc: linux-efi@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: Matthew Garrett <mjg59@google.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/tpm.c   | 9 ++++++++-
 include/linux/tpm_eventlog.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
index b9ae5c6f9b9c..703469c1ab8e 100644
--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -85,11 +85,18 @@ int __init efi_tpm_eventlog_init(void)
 						    final_tbl->nr_events,
 						    log_tbl->log);
 	}
+
+	if (tbl_size < 0) {
+		pr_err(FW_BUG "Failed to parse event in TPM Final Events Log\n");
+		goto out_calc;
+	}
+
 	memblock_reserve((unsigned long)final_tbl,
 			 tbl_size + sizeof(*final_tbl));
-	early_memunmap(final_tbl, sizeof(*final_tbl));
 	efi_tpm_final_log_size = tbl_size;
 
+out_calc:
+	early_memunmap(final_tbl, sizeof(*final_tbl));
 out:
 	early_memunmap(log_tbl, sizeof(*log_tbl));
 	return ret;
diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
index 12584b69a3f3..2dfdd63ac034 100644
--- a/include/linux/tpm_eventlog.h
+++ b/include/linux/tpm_eventlog.h
@@ -152,7 +152,7 @@ struct tcg_algorithm_info {
  * total. Once we've done this we know the offset of the data length field,
  * and can calculate the total size of the event.
  *
- * Return: size of the event on success, <0 on failure
+ * Return: size of the event on success, 0 on failure
  */
 
 static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
-- 
2.20.1

