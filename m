Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7454F70E91A
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 00:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEWWdk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 18:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjEWWdj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 18:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3073983
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684881174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfRD3GZSe/po2Yvx+fZzXZZZfdk+kXJVJcq8DZsV4Kg=;
        b=NWHMKun8dl+ocNZby2V22xrhGysTrP1XoEhYvPa8NenEl3zsyg4avSE/7MzFqp9FiE80nL
        2M8oiVM3gy3kORHn3uXTEqujoWE1zbdTgCUI8FNeNJYtki9GSX5UVmS1K9ySP1z1/iveEi
        cCGlrJ5TOyIa/xDK7iHfa72JFkB/+Yc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641--NeOE-3_M92ZSSn_ECkxWg-1; Tue, 23 May 2023 18:32:53 -0400
X-MC-Unique: -NeOE-3_M92ZSSn_ECkxWg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6238a4e544bso1275146d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 23 May 2023 15:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684881172; x=1687473172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfRD3GZSe/po2Yvx+fZzXZZZfdk+kXJVJcq8DZsV4Kg=;
        b=G78H+5XlGjBBgjirJ5ettISzir1zwRjoLfB3bUlnKm9TwCYxYBRVMciOQFeLJNAu6w
         XENbyBntrWtpSgykaZaGyCuxDlyflYVv4WVb7RVhMOTcLkyaP84+oSkq49K3tvWCNDt8
         ikxRx9NGzf/vGnC/VjheEIhSyP3P/Tn3rLl8K+a28+5rDAHwf74T9mQUhunX1sqbcSTv
         HpP0MgTaETNcBBBy+63f6LVRSLHBXfE2Lu+vOw0W7Mh5IohSCOlEwjqe75SKiFg3SWcA
         0TRiU08VlQAa6gAW/gz4PULEYmuSVTmUyKhlHudPXKM/E972SBS3Ak5WF+VCeCh3Vckd
         LYUw==
X-Gm-Message-State: AC+VfDwNhzk3uWfuTsmDgnmgU1texG3pMlkQzx6sw8PiYjZxAzhSz7qa
        4GB2P2BD1sKe1FLKUCURH/0l2z3tCS0JDmyObqAznJpb5Q+Vth+uZoF6AKbZlyaZUJf162wdU6U
        jIZfZ/Ey5dwcDodVSq8ta3UIR/h1y
X-Received: by 2002:a05:6214:1251:b0:623:690c:3cd7 with SMTP id r17-20020a056214125100b00623690c3cd7mr26478320qvv.47.1684881172542;
        Tue, 23 May 2023 15:32:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pYBvrUPTIq4QFiKkKAkrD+OA0TF1qdjuEuroSHzONcos03Kg+SYc3DmzKyVVjvCUN1HrLag==
X-Received: by 2002:a05:6214:1251:b0:623:690c:3cd7 with SMTP id r17-20020a056214125100b00623690c3cd7mr26478302qvv.47.1684881172259;
        Tue, 23 May 2023 15:32:52 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id v16-20020a0ccd90000000b00604ee171d99sm3043919qvm.106.2023.05.23.15.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 15:32:51 -0700 (PDT)
Date:   Tue, 23 May 2023 15:32:50 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.sanfilippo@kunbus.com, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Message-ID: <kxb36qqgtnyqed4cgd5fpvmwway2v4watcfg3vdj3okm76scsy@prcbk5pjv4gk>
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <CSTW9UX4ERDZ.VBD1QIWLBM75@suppilovahvero>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CSTW9UX4ERDZ.VBD1QIWLBM75@suppilovahvero>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 23, 2023 at 10:12:49PM +0300, Jarkko Sakkinen wrote:
> On Tue May 23, 2023 at 9:53 PM EEST, Jarkko Sakkinen wrote:
> > On Mon May 22, 2023 at 5:31 PM EEST, Lino Sanfilippo wrote:
> > > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> > >
> > > Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> > > interrupts instead of polling on all capable TPMs. Unfortunately, on some
> > > products the interrupt line is either never asserted or never deasserted.
> > >
> > > The former causes interrupt timeouts and is detected by
> > > tpm_tis_core_init(). The latter results in interrupt storms.
> > >
> > > Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkPad
> > > L490 and Inspur NF5180M6:
> > >
> > > https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel@redhat.com/
> > > https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org/
> > >
> > > The current approach to avoid those storms is to disable interrupts by
> > > adding a DMI quirk for the concerned device.
> > >
> > > However this is a maintenance burden in the long run, so use a generic
> > > approach:
> >
> > I'm trying to comprehend how you evaluate, how big maintenance burden
> > this would be. Adding even a few dozen table entries is not a
> > maintenance burden.

I do worry about how many cases will be reported once 6.4 is released,
and this eventually makes its way into distributions. In either case
the dmi table will need to be maintained. The UPX-11i case is a
different issue, and IIRC the L490 it needed a DMI entry, because
trying to catch the irq storm wasn't solving the issue there. I
imagine other odd cases will be popping up as well.

So far we have 2 irq storm reports with peterz's P360 Tiny, and I
guess that Inspur system reported by the kernel test robot. Then there
is whatever is going on with Peter Ujfalusi's UPX-11i.

> >
> > On the other hand any new functionality is objectively a maintanance
> > burden of some measure (applies to any functionality). So how do we know
> > that taking this change is less of a maintenance burden than just add
> > new table entries, as they come up?
> >
> > > Detect an interrupt storm by counting the number of unhandled interrupts
> > > within a 10 ms time interval. In case that more than 1000 were unhandled
> > > deactivate interrupts, deregister the handler and fall back to polling.
> >
> > I know it can be sometimes hard to evaluate but can you try to explain
> > how you came up to the 10 ms sampling period and 1000 interrupt
> > threshold? I just don't like abritrary numbers.
> 
> Also here I wonder how you came up with this computational model. This
> is not same as saying it is wrong. There's just whole stack of options.
> 
> Out of top of my head you could e.g. window average the duration between
> IRQs. When the average goes beyond threshold, then you shutdown
> interrupts.

Just to make sure I have it clear in my head, you mean when the
average is shorter than the threshold duration between interrupts,
yes? My brain wants to read 'When the average goes beyond threshold'
as 'threshold < average'.

Does the check need to be a rolling window like 1/2 currently has? I
expect that if the problem exists it will be noticed in the first
window checked. I think what I originally tried was to check over some
interval from when the handler first ran, disable interrupts if
needed, and then skip the check from then on when the handler ran.

Regards,
Jerry

> 
> The pro I would see in this that it is much easier intuitively discuss
> how much there should be time in-between interrupts that the kernel
> handles it, than how many IRQs you can stack into time interval, which
> blows my head tbh.
> 
> BR, Jarkko

