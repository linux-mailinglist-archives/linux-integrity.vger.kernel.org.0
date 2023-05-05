Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2089B6F853D
	for <lists+linux-integrity@lfdr.de>; Fri,  5 May 2023 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjEEPGp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 May 2023 11:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjEEPGp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 May 2023 11:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F62D17DDC
        for <linux-integrity@vger.kernel.org>; Fri,  5 May 2023 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683299157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O5SZiWc9ZQHxSy9tyLMzwplB98tK2sb6qHqYLmntJ0g=;
        b=AprG1zXm26WiJntkrGo5uPhNzF/r20skOLQjMLnpvsaACjebj/1YEzmvZbMTHZui7rbrNp
        s3pwncfsLnttbQkju4r08fXeKnkYTRuXMKLWgy+VLK2ar6A+Xu0vgo8/lb0pgfbiqw5nca
        aRisdf/2e39kQfjz8tkOQlqvhmcTSHQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Kme4crLaO9OuUc1nJnezWA-1; Fri, 05 May 2023 11:05:56 -0400
X-MC-Unique: Kme4crLaO9OuUc1nJnezWA-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-75131c05344so1189569185a.1
        for <linux-integrity@vger.kernel.org>; Fri, 05 May 2023 08:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683299155; x=1685891155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5SZiWc9ZQHxSy9tyLMzwplB98tK2sb6qHqYLmntJ0g=;
        b=C8HRd3aMlsS8DXVo5XeaZNeZJFktPvZQB5RbHDHCQlNarOlouxnWDsdULqooYFZnJ9
         FV+fe2HlKex5N+g7h/HqLZ5eRjV1NtWAYLqWTCYCQ+h/7FwmVKHAf4babpqDE5jDvYXY
         xrFYRCkvRIGfwWzQxZBL+SN4C+y+bqORDtuBXcCSLVNHA9Vr8LOQmtGOzPwW6jM/neKD
         d2dBaWLrIk0txpJvqiFllUXkATTGSTT044i6frRbEP/roRrpFJ2EyvLZqMPb57fK92Vj
         +xqp7Zy9yxBngjmspPlvy0WYeSBXW45QJWb10Ic6VBRx0vSM2Qv+WKyv+daOObWw92S5
         uAuQ==
X-Gm-Message-State: AC+VfDyB7TJZRr4QUqGSy787JsE/4cKTUBVKL/yxkXtWM8pv9Yu8zsgx
        kXWkynuUpkxWmR2EAkHCPm78NOwKHFPxsn7mENhBo0orEVNC02uq43gahBYzzI2M/UMuhQcRUE2
        0PdAYqSQicmwQE1Lrrgbxyi1zXzln
X-Received: by 2002:ac8:5b88:0:b0:3ef:54c9:16d9 with SMTP id a8-20020ac85b88000000b003ef54c916d9mr12156243qta.28.1683299155357;
        Fri, 05 May 2023 08:05:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4POEqmXWHci+AjXCVt0sAvUpR0AkLFlvDawEXSUtFvnad8ZIwjDHy5wYB2CNDQnwSUTHjUeA==
X-Received: by 2002:ac8:5b88:0:b0:3ef:54c9:16d9 with SMTP id a8-20020ac85b88000000b003ef54c916d9mr12156169qta.28.1683299154936;
        Fri, 05 May 2023 08:05:54 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g1-20020a37e201000000b0074e2da97de4sm647023qki.33.2023.05.05.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 08:05:54 -0700 (PDT)
Date:   Fri, 5 May 2023 08:05:53 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, hdegoede@redhat.com,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tpm_sis IRQ storm on ThinkStation P360 Tiny
Message-ID: <toe7jsgedknsqj3dgw2fasjlqcpgpiqgloifxow4vnt3tntabw@l6emb5zpbff5>
References: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505130731.GO83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 05, 2023 at 03:07:31PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> I recently saw my Alderlake NUC spewing on boot:
> 
> [   13.166514] irq 109: nobody cared (try booting with the "irqpoll" option)
> [   13.166614] CPU: 5 PID: 0 Comm: swapper/5 Not tainted 6.3.0+ #66
> [   13.166694] Hardware name: LENOVO 30FBS0B800/330E, BIOS M4GKT18A 04/26/2022
> [   13.166779] Call Trace:
> [   13.166812]  <IRQ>
> [   13.166840]  dump_stack_lvl+0x5b/0x90
> [   13.166891]  __report_bad_irq+0x2b/0xc0
> [   13.166941]  note_interrupt+0x2ac/0x2f0
> [   13.166991]  handle_irq_event+0x6f/0x80
> [   13.167041]  handle_fasteoi_irq+0x94/0x1f0
> [   13.167093]  __common_interrupt+0x72/0x160
> [   13.167112] intel_rapl_common: Found RAPL domain package
> [   13.167141]  common_interrupt+0xb8/0xe0
> [   13.167200] intel_rapl_common: Found RAPL domain core
> [   13.167242]  </IRQ>
> [   13.167297] intel_rapl_common: Found RAPL domain uncore
> [   13.167322]  <TASK>
> [   13.167437]  asm_common_interrupt+0x26/0x40
> [   13.167492] RIP: 0010:cpuidle_enter_state+0xff/0x500
> [   13.167554] Code: c0 48 0f a3 05 72 34 ad 01 0f 82 fc 02 00 00 31 ff e8 35 b3 52 ff 45 84 ff 0f 85 cc 02 00 00 e8 f7 13 64 ff fb 0f 1f 44 00 00 <45> 85 f6 0f 88 eb 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
> [   13.167766] RSP: 0018:ffffc900001ebe90 EFLAGS: 00000206
> [   13.167843] RAX: 000000000012a8f3 RBX: ffffe8ffff480a00 RCX: 0000000000000000
> [   13.167928] RDX: 0000000000000000 RSI: ffffffff8244c6ee RDI: ffffffff8242ca22
> [   13.168021] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
> [   13.168105] R10: 0000000000000003 R11: 000000000000000a R12: ffffffff83625a80
> [   13.168189] R13: 0000000310c8ee5e R14: 0000000000000001 R15: 0000000000000000
> [   13.168289]  cpuidle_enter+0x2d/0x40
> [   13.168339]  do_idle+0x231/0x290
> [   13.168383]  cpu_startup_entry+0x1d/0x20
> [   13.168432]  start_secondary+0x11b/0x140
> [   13.168482]  secondary_startup_64_no_verify+0xf9/0xfb
> [   13.168549]  </TASK>
> [   13.168587] handlers:
> [   13.168617] [<00000000497ef927>] irq_default_primary_handler threaded [<00000000cf102de1>] tis_int_handler
> [   13.168767] Disabling IRQ #109
> 
> this is apparently:
> 
> root@alderlake:~# cat /proc/interrupts | grep 109
> 109:          0          0          0          0          0     100002          0          0          0          0          0          0          0          0          0          0          0          0          0          0          00          0          0  IR-IO-APIC  109-fasteoi   tpm0
> 
> the TPM thing, which per same dmesg above is:
> 
> [   10.948058] tpm_tis MSFT0101:00: 2.0 TPM (device-id 0x1D, rev-id 54)
> 
> Booting with tpm_tis.interrupts=0 seems to cure things, and AFAICT the
> tpm device actually works -- that is, tpm2 getcap -l and tpm2 pcrread
> both give output, I'm presuming this is 'good'. I've never operated a
> TPM before.
> 
> The machine in question is:
> 
> 	Manufacturer: LENOVO
> 	Product Name: 30FBS0B800
> 	Version: ThinkStation P360 Tiny
> 
> So I'm thinking that perhaps Lenovo carried the bug mentioned in commit:
> b154ce11ead9 ("tpm_tis: Disable interrupts on ThinkPad T490s") to more
> products.

Hi Peter,

It will poll like it has for years with tpm_tis.interrupts=0 so that
should be working as it was prior to 6.3 when interrupts were re-enabled
for tpm_tis. Are you seeing this with 6.2 as well? IIRC with that Thinkpad
case is when it was first realized that interrupts had accidentally been
disabled for tpm_tis at one point by a change.

I guess myself or someone else needs to revisit catching this in
general when the irq storm happens, and disabling interrupts for
tpm_tis. I think last time I was incorporating some feedback from
tglx, let my adhd get me distracted with some other issue and never
returned to it.

The diff below should (compile tested) work for the P360, but
tpm_tis.interrupts=0 is a good work-around.

Regards,
Jerry


diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 7af389806643..12dfdbef574d 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -122,6 +122,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T490s"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "ThinkStation P360 Tiny",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkStation P360 Tiny"),
+		},
+	},
 	{}
 };

