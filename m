Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B52BC6D1
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Nov 2020 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgKVQRK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Nov 2020 11:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgKVQRH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Nov 2020 11:17:07 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F1EC08E861
        for <linux-integrity@vger.kernel.org>; Sun, 22 Nov 2020 08:17:06 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id l17so1477509pgk.1
        for <linux-integrity@vger.kernel.org>; Sun, 22 Nov 2020 08:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LoGd3XD212DnUOzzxWdBwAHKcFiABUM1eku/Z5s9PQ=;
        b=ECdUiFozoGotedNMltHxGvt7ELeQp/og9KGaJat0+erwcdPPWVCrU8KkW+JV4RYPeo
         GTWUobzmr0s313q/lzhn4jF5RxJP4nhZO/aj20hZaH8d/g/a456RbO+LKniOS4LntN7M
         GHx9cYZv8xWYKIg8n9C3ZJn+Q+L/6/s35hbx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9LoGd3XD212DnUOzzxWdBwAHKcFiABUM1eku/Z5s9PQ=;
        b=n+pS2mygKY54neF6e75EJHeBjfC+dpBuL25+7VJol6uE9aGGmDnyWEai8TbXNVS024
         VlCXcq7XWieSenztJUblR5wVvwlVp0Rsig/hhkve3+XX1M9uF2UM2US9xpzdoi4CJK3i
         QYoEg96nlFX9lr0J2CW1iYV3ZrowgMVv3t3sMLX79FaLisIMn8WpGeVCNABTeci9mAua
         Ep41XXd36O6ldIKAfIGGeypkfo0AasnGiNg3bZ6RTAX0SC24WyY2eGD6UzuZuD9dh3Bv
         3EgirZCjxD4T3lCBZyIcCqrSpzWOP83Sg2fU16oJqO4w6y1gbI09lakXSPZmEHibww3y
         k3JQ==
X-Gm-Message-State: AOAM533MjrFCSTtsjH3FydGmBCjIeltjgZ1GttNHBvjdOD0oboAGR0hN
        3G+fGlzI9072QvH0lgtaIXEMrg==
X-Google-Smtp-Source: ABdhPJwZLmFbbTaRxBkTtuJWbjEgTUtKMFpd77L8KmHflX2OUVWZyNqpGNaeYR87Y149sjgotBbRUA==
X-Received: by 2002:a62:790f:0:b029:18a:ae57:353f with SMTP id u15-20020a62790f0000b029018aae57353fmr22300068pfc.78.1606061825417;
        Sun, 22 Nov 2020 08:17:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t5sm10642660pjj.31.2020.11.22.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2020 08:17:04 -0800 (PST)
Date:   Sun, 22 Nov 2020 08:17:03 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        amd-gfx@lists.freedesktop.org, bridge@lists.linux-foundation.org,
        ceph-devel@vger.kernel.org, cluster-devel@redhat.com,
        coreteam@netfilter.org, devel@driverdev.osuosl.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, GR-everest-linux-l2@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, intel-gfx@lists.freedesktop.org,
        intel-wired-lan@lists.osuosl.org, keyrings@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        linux-afs@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-decnet-user@lists.sourceforge.net,
        linux-ext4@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-geode@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-i3c@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mm@kvack.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
        op-tee@lists.trustedfirmware.org, oss-drivers@netronome.com,
        patches@opensource.cirrus.com, rds-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, samba-technical@lists.samba.org,
        selinux@vger.kernel.org, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        usb-storage@lists.one-eyed-alien.net,
        virtualization@lists.linux-foundation.org,
        wcn36xx@lists.infradead.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Message-ID: <202011220816.8B6591A@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> On Fri, 20 Nov 2020 11:30:40 -0800 Kees Cook wrote:
> > On Fri, Nov 20, 2020 at 10:53:44AM -0800, Jakub Kicinski wrote:
> > > On Fri, 20 Nov 2020 12:21:39 -0600 Gustavo A. R. Silva wrote:  
> > > > This series aims to fix almost all remaining fall-through warnings in
> > > > order to enable -Wimplicit-fallthrough for Clang.
> > > > 
> > > > In preparation to enable -Wimplicit-fallthrough for Clang, explicitly
> > > > add multiple break/goto/return/fallthrough statements instead of just
> > > > letting the code fall through to the next case.
> > > > 
> > > > Notice that in order to enable -Wimplicit-fallthrough for Clang, this
> > > > change[1] is meant to be reverted at some point. So, this patch helps
> > > > to move in that direction.
> > > > 
> > > > Something important to mention is that there is currently a discrepancy
> > > > between GCC and Clang when dealing with switch fall-through to empty case
> > > > statements or to cases that only contain a break/continue/return
> > > > statement[2][3][4].  
> > > 
> > > Are we sure we want to make this change? Was it discussed before?
> > > 
> > > Are there any bugs Clangs puritanical definition of fallthrough helped
> > > find?
> > > 
> > > IMVHO compiler warnings are supposed to warn about issues that could
> > > be bugs. Falling through to default: break; can hardly be a bug?!  
> > 
> > It's certainly a place where the intent is not always clear. I think
> > this makes all the cases unambiguous, and doesn't impact the machine
> > code, since the compiler will happily optimize away any behavioral
> > redundancy.
> 
> If none of the 140 patches here fix a real bug, and there is no change
> to machine code then it sounds to me like a W=2 kind of a warning.

FWIW, this series has found at least one bug so far:
https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/

-- 
Kees Cook
