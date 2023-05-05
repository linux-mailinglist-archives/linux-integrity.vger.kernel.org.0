Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD276F8378
	for <lists+linux-integrity@lfdr.de>; Fri,  5 May 2023 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjEENHn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 May 2023 09:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjEENHm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 May 2023 09:07:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8371C0DA;
        Fri,  5 May 2023 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zSm7FKoo47r4DuDS3TDYCRGMWBs8XVqzNW72UI+hAsM=; b=bPMh84xPUo6S6r2GqYVJdW/Lz2
        t42upSEhbyj+LTRhSAOmqnqZjFwCOh3IhzpHs49kwJxJnY1WsFN2remtGbi7kRVzv/l5VP4IIvkDs
        R5K3DXXieKWdBApBktUl5aJ3Y00+be4FRUMKqLAqOaTdsNIkPSU4+qcaUo5268U0gAKIxz2IsEs4u
        hJbSs7QSobWsrnoeoxLChgdiAJrUSQpbvBu3WoqOKn1bYIUB26KGXfgkwVfsmB5sU2TP9jZCPPVtc
        BxWwhWzD/Wh5yT+5RP1FoWikFLmdi7r9ZAO5KXjjd6001TDPjau1FtDMr0V3QoVmj7QKMAZmGTofh
        e4Y8Sdqg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puv9p-003FqB-1f;
        Fri, 05 May 2023 13:07:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22C0E306127;
        Fri,  5 May 2023 15:07:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E9B2323886FF1; Fri,  5 May 2023 15:07:31 +0200 (CEST)
Date:   Fri, 5 May 2023 15:07:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: tpm_sis IRQ storm on ThinkStation P360 Tiny
Message-ID: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

I recently saw my Alderlake NUC spewing on boot:

[   13.166514] irq 109: nobody cared (try booting with the "irqpoll" option)
[   13.166614] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 6.3.0+ #66
[   13.166694] Hardware name: LENOVO 30FBS0B800/330E, BIOS M4GKT18A 04/26/2022
[   13.166779] Call Trace:
[   13.166812]  <IRQ>
[   13.166840]  dump_stack_lvl+0x5b/0x90
[   13.166891]  __report_bad_irq+0x2b/0xc0
[   13.166941]  note_interrupt+0x2ac/0x2f0
[   13.166991]  handle_irq_event+0x6f/0x80
[   13.167041]  handle_fasteoi_irq+0x94/0x1f0
[   13.167093]  __common_interrupt+0x72/0x160
[   13.167112] intel_rapl_common: Found RAPL domain package
[   13.167141]  common_interrupt+0xb8/0xe0
[   13.167200] intel_rapl_common: Found RAPL domain core
[   13.167242]  </IRQ>
[   13.167297] intel_rapl_common: Found RAPL domain uncore
[   13.167322]  <TASK>
[   13.167437]  asm_common_interrupt+0x26/0x40
[   13.167492] RIP: 0010:cpuidle_enter_state+0xff/0x500
[   13.167554] Code: c0 48 0f a3 05 72 34 ad 01 0f 82 fc 02 00 00 31 ff e8 35 b3 52 ff 45 84 ff 0f 85 cc 02 00 00 e8 f7 13 64 ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 eb 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[   13.167766] RSP: 0018:ffffc900001ebe90 EFLAGS: 00000206
[   13.167843] RAX: 000000000012a8f3 RBX: ffffe8ffff480a00 RCX: 0000000000000000
[   13.167928] RDX: 0000000000000000 RSI: ffffffff8244c6ee RDI: ffffffff8242ca22
[   13.168021] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
[   13.168105] R10: 0000000000000003 R11: 000000000000000a R12: ffffffff83625a80
[   13.168189] R13: 0000000310c8ee5e R14: 0000000000000001 R15: 0000000000000000
[   13.168289]  cpuidle_enter+0x2d/0x40
[   13.168339]  do_idle+0x231/0x290
[   13.168383]  cpu_startup_entry+0x1d/0x20
[   13.168432]  start_secondary+0x11b/0x140
[   13.168482]  secondary_startup_64_no_verify+0xf9/0xfb
[   13.168549]  </TASK>
[   13.168587] handlers:
[   13.168617] [<00000000497ef927>] irq_default_primary_handler threaded [<00000000cf102de1>] tis_int_handler
[   13.168767] Disabling IRQ #109

this is apparently:

root@alderlake:~# cat /proc/interrupts | grep 109
109:          0          0          0          0          0     100002          0          0          0          0          0          0          0          0          0          0          0          0          0          0          00          0          0  IR-IO-APIC  109-fasteoi   tpm0

the TPM thing, which per same dmesg above is:

[   10.948058] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)

Booting with tpm_tis.interrupts=0 seems to cure things, and AFAICT the
tpm device actually works -- that is, tpm2 getcap -l and tpm2 pcrread
both give output, I'm presuming this is 'good'. I've never operated a
TPM before.

The machine in question is:

	Manufacturer: LENOVO
	Product Name: 30FBS0B800
	Version: ThinkStation P360 Tiny

So I'm thinking that perhaps Lenovo carried the bug mentioned in commit:
b154ce11ead9 ("tpm_tis: Disable interrupts on ThinkPad T490s") to more
products.
