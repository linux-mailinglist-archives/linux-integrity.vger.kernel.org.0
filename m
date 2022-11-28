Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA063A28A
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiK1IPi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 03:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiK1IPh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 03:15:37 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC953B59;
        Mon, 28 Nov 2022 00:15:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 64BE61F891;
        Mon, 28 Nov 2022 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669623334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpsChWLvBe9ZeeIRjIMdX78OPm+ymyYWRY7iDGoQytA=;
        b=Fsd8J11bX757kLipnyZCVlQ/2M8si4tHQt+s2u2j+hdpNOMjJgGpsJjIvGYQu8K295iMAS
        nvI4zL42cCf/w/k5hsZnhXNbw52cKQ1KWscgHYZ4UySGH87WTOxoIphZvTZGnKFG2U6XrE
        8nrn4TAGNbNXUBN+jLEkNLjwkdofAxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669623334;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpsChWLvBe9ZeeIRjIMdX78OPm+ymyYWRY7iDGoQytA=;
        b=VLHB0azxmXrI01Fheg48bpFOappDGjFEaGOt2oFdLC4CR+R1bI0pqfCmawxX4oaFt9up5K
        0o6Jgv7+F7woOgDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3ACA813273;
        Mon, 28 Nov 2022 08:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IkyGDSZuhGMSVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Nov 2022 08:15:34 +0000
Message-ID: <c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz>
Date:   Mon, 28 Nov 2022 09:15:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: [REGRESSION] suspend to ram fails in 6.1 due to tpm errors
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>
Cc:     regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I've noticed my Lenovo T460 developed a failure to suspend to ram related to
TPM errors. Seems at each suspend/resume cycle there's a chance the errors
develop and then further suspends are blocked by the stuck TPM (or its driver?)
I can say for sure it never happened before 6.1, however I didn't test all 6.1
RCs and suspend/resume enough times to pinpoint it was 6.1-rc1 (which would be
naturally suspicious). Bisecting would also be time consuming and unreliable,
so hopefully this historical account will be sufficient:

The tpm messages on boot are always the same, here from 6.0.0-rc7:

tpm_tis 00:08: 1.2 TPM (device-id 0x1B, rev-id 16)
tpm tpm0:a TPM is disabled/deactivated (0x6)
tpm tpm0: tpm_read_log_acpi: TCPA log area empty

And normally during resume from suspend to ram I can see:

tpm tpm0: TPM is disabled/deactivated (0x6)

With 6.1-rc3 (the first 6.1-rcX I've tried on this laptop) this was still
behaving OK, suspend/resume went fine 4 times until I updated the kernel
and rebooted. Maybe it just wasn't enough cycles to hit the issue.

With 6.1-rc4, there were initially 3 resumes OK, but on 4th resume I saw:

tpm tpm0: tpm_try_transmit: send(): error -5
tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
CPU: 2 PID: 15299 Comm: systemd-sleep Not tainted 6.1.0-rc4-2.gc03e512-default #1 openSUSE Tumbleweed (unreleased) 232cc11569ae1616983f707f1010e2c19601c7ee
Hardware name: LENOVO 20FMS27W03/20FMS27W03, BIOS R06ET71W (1.45 ) 02/21/2022
Call Trace:
 <TASK>
 dump_stack_lvl+0x44/0x5c
 tpm_tis_status.cold+0x19/0x1e
 wait_for_tpm_stat+0x120/0x200
 ? tpm_tcg_read_bytes+0x8f/0xa0
 tpm_tis_send_data+0x8c/0x260
 tpm_tis_send_main+0x33/0x130
 tpm_transmit+0xd4/0x3e0
 tpm_transmit_cmd+0x25/0x90
 tpm1_do_selftest+0x88/0x130
 ? set_next_entity+0xda/0x150
 tpm_tis_resume+0x8d/0x1b0
 pnp_bus_resume+0x60/0xa0
 ? pnp_bus_suspend+0x10/0x10
 dpm_run_callback+0x47/0x150
 device_resume+0x104/0x270
 ? dpm_show_time.cold+0x62/0x62
 dpm_resume+0x191/0x2e0
 dpm_resume_end+0xd/0x20
 suspend_devices_and_enter+0x1c3/0x880
 pm_suspend.cold+0x2d2/0x35e
 state_store+0x68/0xd0
 kernfs_fop_write_iter+0x11b/0x1f0
 vfs_write+0x1f4/0x3b0
 ksys_write+0x63/0xe0
 do_syscall_64+0x58/0x80
 ? do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6197f079d4
Code: ff eb b7 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 80 3d cd 0f 0f 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 48 83 ec 28 48 89 54 24 18 48
RSP: 002b:00007ffdaf9a92d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6197f079d4
RDX: 0000000000000004 RSI: 00007ffdaf9a93c0 RDI: 0000000000000004
RBP: 00007ffdaf9a93c0 R08: 0000563fe8e33650 R09: 0000000000000073
R10: 00000000ffffffff R11: 0000000000000202 R12: 0000000000000004
R13: 0000563fe8e152d0 R14: 0000000000000004 R15: 00007f6197fe69e0
 </TASK>

and a second later

tpm tpm0: tpm_try_transmit: send(): error -62

But that appears not to be the main issue. I've just noticed it while gathering
the info now, and didn't notice it back then as there were another 5 resumes ok
continuing the same kernel boot.

But then on another resume I got:

tpm tpm0: A TPM error (28) occurred continue selftest

And afterwards, many messages scattered in the log:

tpm tpm0: A TPM error (28) occurred attempting get random

And since then, suspend to ram no longer works and I see this:

tpm tpm0: Error (28) sending savestate before suspend
tpm_tis 00:08: PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns 28
tpm_tis 00:08: PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x10 returns 28
tpm_tis 00:08: PM: failed to suspend: error 28
PM: Some devices failed to suspend, or early wake event detected

After reboot to 6.1-rc6, initially 3 resumes ok, and then again on 4th resume:

tpm tpm0: A TPM error (28) occurred continue selftest

and same story with the errors attempting get random, and suspend failing.
Notably this was without the tpm_try_transmit splat above, so that is
probably indeed not tha main issue. The moment things go wrong is
the "A TPM error (28) occurred continue selftest" during resume.

Dominik on IRC pointed me to commit b006c439d58d ("hwrng: core - start hwrng
kthread also for untrusted sources"), which could make sense if the TPM was not
used at all before and now it's used for randomness. But then it probably "just"
uncovered a pre-existing issue? Maybe there's a race with getting the randomness
and suspend? Could it be exactly what this patch is attempting to fix?
https://lore.kernel.org/all/20221103145450.1409273-2-jsd@semihalf.com/

Thanks,
Vlastimil

#regzbot introduced: v6.0..v6.1-rc4
