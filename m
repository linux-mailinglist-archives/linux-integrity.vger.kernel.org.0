Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4A42D1979
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Dec 2020 20:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLGT2q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Dec 2020 14:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGT2q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Dec 2020 14:28:46 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1383C061793
        for <linux-integrity@vger.kernel.org>; Mon,  7 Dec 2020 11:28:05 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id y15so2698497qtv.5
        for <linux-integrity@vger.kernel.org>; Mon, 07 Dec 2020 11:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3QgAlPsbwF8UgttG1BQwndoXM5UWF7rYLhDWgqTcAo=;
        b=YrX/hht9Lmvjo/zfsC6XKDCBN4R4gbKwzoAKOilZlQhn7HDa3NQXQkL0b3oGSDsy4k
         pH++h4TpKxJPVTjCNUS/9QmRYfNnI7uCN9sFYEGwZPyCy7EMySg6GzEm0lh6h0uTxE7Q
         09i7UgLqD7gseDt8hmiUybWLpjfzlqc4CXRsblOzx4HC27ikvmDt6oAo/N8mnvlg6vLS
         TzibuoaOix1cE3FWRCoVtfaMnbQgveRZZsGjo454qEFfbgf6ujUxS92NCrl3mkxiP6Ar
         mXTT6P3aASuSwn7ShD7r9SLifwe3PIiAzb3QeLL1UX2tNH/ECVzziHkFAI0t51cFB2wl
         FiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3QgAlPsbwF8UgttG1BQwndoXM5UWF7rYLhDWgqTcAo=;
        b=IvXplBfoeruR3uZlMowqjsoTXntqrF3xMwrtnx6PGDP7g+OMM7cRuUUUYKJMe+Lu8I
         P17dI8tMSj1zaftg9Z47OMZLLEQl0BWqm00MM1OUawXqcaKCKE+PgppKtkI0u6BqGj6y
         4phjAa8qAVN4g+yjOEoc4d64Bi18S32/oF5FKAioWb5PLPelI3Gl+ogEFU3zNt148AwR
         jNjCF62s6Lb0gxi/Rfm3TyU3wykiZ3ARp1rgt0bsD/a4KHa8rZ+Kb+CE5xk8+XjKZ8/x
         79SwzUHp60PS5CE0u+/Zk8XkpS8HUBLNa3jh63JlF61/632pdnHakawk4KDx5LIrmeLm
         /w/w==
X-Gm-Message-State: AOAM532OscMh/2EunIyDKmTJFEScNU9UdE/FHJCEZWnHAb2FpceH8aqO
        HqaLsJjMxf667GEFLjTONYb75YLwXDtBbg==
X-Google-Smtp-Source: ABdhPJxxnyKPy9Vcras0kbGYLZWTk+L+RsBCWMBKbQ+cMI81iSEB3CFPTmj2Cp6J0/ZkbylyCKnixA==
X-Received: by 2002:ac8:6b54:: with SMTP id x20mr25374730qts.170.1607369284968;
        Mon, 07 Dec 2020 11:28:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id v5sm5648146qkv.64.2020.12.07.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:28:03 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kmMB1-007OGx-1k; Mon, 07 Dec 2020 15:28:03 -0400
Date:   Mon, 7 Dec 2020 15:28:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 3/4] tpm_tis: Disable interrupts if interrupt storm
 detected
Message-ID: <20201207192803.GH5487@ziepe.ca>
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-4-jsnitsel@redhat.com>
 <87tusy7n3b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tusy7n3b.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Dec 06, 2020 at 08:26:16PM +0100, Thomas Gleixner wrote:
> Just as a side note. I was looking at tpm_tis_probe_irq_single() and
> that function is leaking the interrupt request if any of the checks
> afterwards fails, except for the final interrupt probe check which does
> a cleanup. That means on fail before that the interrupt handler stays
> requested up to the point where the module is removed. If that's a
> shared interrupt and some other device is active on the same line, then
> each interrupt from that device will call into the TPM code. Something
> like the below is needed.
> 
> Also the X86 autoprobe mechanism is interesting:
> 
> 	if (IS_ENABLED(CONFIG_X86))
> 		for (i = 3; i <= 15; i++)
> 			if (!tpm_tis_probe_irq_single(chip, intmask, 0, i))
> 				return;
> 
> The third argument is 'flags' which is handed to request_irq(). So that
> won't ever be able to probe a shared interrupt. But if an interrupt
> number > 0 is handed to tpm_tis_core_init() the interrupt is requested
> with IRQF_SHARED. Same issue when the chip has an interrupt number in
> the register. It's also requested exclusive which is pretty likely
> to fail on ancient x86 machines.

It is very likely none of this works any more, it has been repeatedly
reworked over the years and just left behind out of fear someone needs
it. I've thought it should be deleted for a while now.

I suppose the original logic was to try and probe without SHARED
because a probe would need exclusive access to the interrupt to tell
if the TPM was actually the source, not some other device.

It is all very old and very out of step with current thinking, IMHO. I
skeptical that TPM interrupts were ever valuable enough to deserve
this in the first place.

Jason
