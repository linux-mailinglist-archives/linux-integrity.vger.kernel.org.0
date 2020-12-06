Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C072D0775
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Dec 2020 22:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgLFVr6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Dec 2020 16:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43942 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728075AbgLFVr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Dec 2020 16:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607291191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pt7TdFB7ulKa/lV+VvFZnu9g+M0yRQxxm6d6lfJIcJQ=;
        b=Mxv08pE88mred+M51TvZYbs/9lr+qwsYOKv7RyeXU64apN6hKar20jZhPTZb8Abyzr35Ja
        jzj6l+JFwheRqtZx6dwUmCQwaxqXYiqDaxLm3XR7p8OXRQ/zXg8kJFDzLdwmlMZhDOxPDC
        LmLIvvVwun/aa05Ntb7KX55PaOWmwrk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-C2IGiybZMfqw9l5yB82UDg-1; Sun, 06 Dec 2020 16:46:29 -0500
X-MC-Unique: C2IGiybZMfqw9l5yB82UDg-1
Received: by mail-qv1-f71.google.com with SMTP id n5so9785633qvt.14
        for <linux-integrity@vger.kernel.org>; Sun, 06 Dec 2020 13:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Pt7TdFB7ulKa/lV+VvFZnu9g+M0yRQxxm6d6lfJIcJQ=;
        b=tPxnvLWDIA1LE8Up7P9O0qlta/aHuxkjuGcAnBTj/tZnkDJuzCSNENKRVHDkqfZHHn
         ljulFZvR05wpjN+mlyjHpxdvhWrEWBEm4Mf8Ht+JPWi2t2iFcHDga0nGP6pxzYVl8hF1
         5UXXv2fY+A+90SqY9NYwOR0NVS+E8SuDDwMO+Bwq91xwgsL5Dj6/qDa3rIBpYXM8t/3E
         iAWBUKDYjR4og1TsPvF6nVk3B2IwF2Agf6vgt2Ups/la6SdzDEvH4Tm+Vi4CxpXySRJ9
         BWy1piNUjGussz8/FvCUq/YPD9WUrKUDw3ns1xUE0tvrqDzJiWPNZuzk0KCSgenkcT4l
         VVhQ==
X-Gm-Message-State: AOAM531lBtu4BY8B79WeQfA3U+SiA4734JWINhQMxiNj4WKSWyUPnT4d
        9B/IU6w3ToVgWp9cjIU7fvceFJHEO0NPRJC0md0xw2P5Lh1Y3nS49YkrxLYvLwgkm7MeK0M4UnR
        WtWWJLZjHVyZT8tqCjmeLe/azygrF
X-Received: by 2002:a37:7143:: with SMTP id m64mr21643207qkc.280.1607291188963;
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwdJmpyy0faO+c7dz32lK3lca+T2SB1F3DXtNcksxPbw00LbiUdsAxUQYUXlLzAVtknWfl5ZQ==
X-Received: by 2002:a37:7143:: with SMTP id m64mr21643187qkc.280.1607291188745;
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id a28sm46494qtm.80.2020.12.06.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 13:46:28 -0800 (PST)
References: <20201205014340.148235-1-jsnitsel@redhat.com>
 <20201205014340.148235-2-jsnitsel@redhat.com>
 <87y2ia7rbv.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel test robot <lkp@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 1/4] irq: export kstat_irqs
In-reply-to: <87y2ia7rbv.fsf@nanos.tec.linutronix.de>
Date:   Sun, 06 Dec 2020 14:46:26 -0700
Message-ID: <87lfeahakt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Thomas Gleixner @ 2020-12-06 10:54 MST:

> Jerry,
>
> On Fri, Dec 04 2020 at 18:43, Jerry Snitselaar wrote:
>
> The proper prefix is 'genirq:' git log kernel/irq/irqdesc.c would have
> told you. 
>
>> To try and detect potential interrupt storms that
>> have been occurring with tpm_tis devices it was suggested
>> to use kstat_irqs() to get the number of interrupts.
>> Since tpm_tis can be built as a module it needs kstat_irqs
>> exported.
>
> I'm not really enthused about exporting this without making it at least
> safe. Using it from an interrupt handler is obviously safe vs. concurrent
> removal, but the next driver writer who thinks this is cool is going to
> get it wrong for sure.
>
> Though I still have to figure out what the advantage of invoking a
> function which needs to do a radix tree lookup over a device local
> counter is just to keep track of this.
>
> I'll reply on the TPM part of this as well.
>
> Thanks,
>
>         tglx

I can rework it to use a device local counter.

