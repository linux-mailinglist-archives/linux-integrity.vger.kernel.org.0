Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DC06EC0DF
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 17:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjDWPuF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 11:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDWPuE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 11:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A2E51;
        Sun, 23 Apr 2023 08:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1410614A5;
        Sun, 23 Apr 2023 15:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929A7C433D2;
        Sun, 23 Apr 2023 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265002;
        bh=uz157tjFSjPvS0caMpsIus4wA/SfBsI/pU6q3ps1DYY=;
        h=From:To:Cc:Subject:Date:From;
        b=nsiZ4pManAKyLfWpMgQrfBArhmiARbLo4l2k042eCn0eEQr6fPeqcjcCntuppCywO
         HqEzKw3eSzcS7JZmQNZCiHBhH0U9EkRruORul0rf88ABBcdX1RMNsj2+LQkhSkH84t
         dR8JqHPBzuE4Ov/O2PGRI9URxUEP2ZnDeMZnJ+Xoor+ccjzObONNg5PvNKNoHcU9C3
         aVJ4BGB/j3nnKH6IxJkuf+WV83ZPGaR6ObOdVzSYIL1cHoiRHpYRD0beVxOX21aCyM
         3qTf4DqHBWhL4RjGaiimFpq/Z3hfzNdDE0fJFCOvHZCy9NcxjVW0eRv1KmL967IiTJ
         eJSVR2RVsz04g==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Martin Dimov <martin@dmarto.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site
Date:   Sun, 23 Apr 2023 18:49:58 +0300
Message-Id: <20230423154958.805992-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following crash was reported:

[ 1950.279393] list_del corruption, ffff99560d485790->next is NULL
[ 1950.279400] ------------[ cut here ]------------
[ 1950.279401] kernel BUG at lib/list_debug.c:49!
[ 1950.279405] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[ 1950.279407] CPU: 11 PID: 5886 Comm: modprobe Tainted: G O 6.2.8_1 #1
[ 1950.279409] Hardware name: Gigabyte Technology Co., Ltd. B550M AORUS PRO-P/B550M AORUS PRO-P,
BIOS F15c 05/11/2022
[ 1950.279410] RIP: 0010:__list_del_entry_valid+0x59/0xc0
[ 1950.279415] Code: 48 8b 01 48 39 f8 75 5a 48 8b 72 08 48 39 c6 75 65 b8 01 00 00 00 c3 cc cc cc
cc 48 89 fe 48 c7 c7 08 a8 13 9e e8 b7 0a bc ff <0f> 0b 48 89 fe 48 c7 c7 38 a8 13 9e e8 a6 0a bc
ff 0f 0b 48 89 fe
[ 1950.279416] RSP: 0018:ffffa96d05647e08 EFLAGS: 00010246
[ 1950.279418] RAX: 0000000000000033 RBX: ffff99560d485750 RCX: 0000000000000000
[ 1950.279419] RDX: 0000000000000000 RSI: ffffffff9e107c59 RDI: 00000000ffffffff
[ 1950.279420] RBP: ffffffffc19c5168 R08: 0000000000000000 R09: ffffa96d05647cc8
[ 1950.279421] R10: 0000000000000003 R11: ffffffff9ea2a568 R12: 0000000000000000
[ 1950.279422] R13: ffff99560140a2e0 R14: ffff99560127d2e0 R15: 0000000000000000
[ 1950.279422] FS: 00007f67da795380(0000) GS:ffff995d1f0c0000(0000) knlGS:0000000000000000
[ 1950.279424] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1950.279424] CR2: 00007f67da7e65c0 CR3: 00000001feed2000 CR4: 0000000000750ee0
[ 1950.279426] PKRU: 55555554
[ 1950.279426] Call Trace:
[ 1950.279428] <TASK>
[ 1950.279430] hwrng_unregister+0x28/0xe0 [rng_core]
[ 1950.279436] tpm_chip_unregister+0xd5/0xf0 [tpm]

Add the forgotten !tpm_amd_is_rng_defective() invariant to the
hwrng_unregister() call site inside tpm_chip_unregister().

Reported-by: Martin Dimov <martin@dmarto.com>
Link: https://lore.kernel.org/linux-integrity/3d1d7e9dbfb8c96125bc93b6b58b90a7@dmarto.com/
Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm-chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 33319a78767f..6fdfa65a00c3 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -692,7 +692,8 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
 void tpm_chip_unregister(struct tpm_chip *chip)
 {
 	tpm_del_legacy_sysfs(chip);
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
+	    !tpm_amd_is_rng_defective(chip))
 		hwrng_unregister(&chip->hwrng);
 	tpm_bios_log_teardown(chip);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
-- 
2.39.2

