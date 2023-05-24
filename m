Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7317470EAB3
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 03:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjEXBVT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 21:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjEXBVS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 21:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB84189;
        Tue, 23 May 2023 18:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67A4061B8C;
        Wed, 24 May 2023 01:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08409C433EF;
        Wed, 24 May 2023 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684891266;
        bh=AVTc4E3Ttt3nT4KFEok8KBW7NMbqTnBLOY9relIrJKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M4i5M1VwI4Lgjzwfp5Y1UbSlOb9usXVqUWfMQa651Xa2LhUcbjQiuIlt3ZMGAXLSe
         qTean5+w4TP/GU9s0zi8FJABCj9Cqn2EC75B3b5kAN5zvTeIM+E0zMijKypSu5r/5y
         9pHxXdHrvPuCGStuzpqD8wSkW/Qwf6/lrPasISai/pvKUBIdN7I9B2QkbLqeWaVM2h
         rONOh6CFR446n3se9ODacUXPV2uwYgWuoobGKYrkMcygpBbBA/DGDjwmgz0PHddpPf
         fdxVBDJ/AJJ15oH07qbns+o4acujOU9HEZUEEodJg75tOHNfU/p/NhA7PGPrOlh888
         PSWUSHl8t9nFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 04:21:01 +0300
Message-Id: <CSU43S5BY69V.23N6V1T28OEBY@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc:     "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <hdegoede@redhat.com>, <oe-lkp@lists.linux.dev>,
        <lkp@intel.com>, <peter.ujfalusi@linux.intel.com>,
        <peterz@infradead.org>, <linux@mniewoehner.de>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <l.sanfilippo@kunbus.com>, <lukas@wunner.de>,
        <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <CSTVVFNKUVJW.P69FKI6IF3ZN@suppilovahvero>
 <CSTW9UX4ERDZ.VBD1QIWLBM75@suppilovahvero>
 <kxb36qqgtnyqed4cgd5fpvmwway2v4watcfg3vdj3okm76scsy@prcbk5pjv4gk>
In-Reply-To: <kxb36qqgtnyqed4cgd5fpvmwway2v4watcfg3vdj3okm76scsy@prcbk5pjv4gk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed May 24, 2023 at 1:32 AM EEST, Jerry Snitselaar wrote:
> I do worry about how many cases will be reported once 6.4 is released,
> and this eventually makes its way into distributions. In either case
> the dmi table will need to be maintained. The UPX-11i case is a
> different issue, and IIRC the L490 it needed a DMI entry, because
> trying to catch the irq storm wasn't solving the issue there. I
> imagine other odd cases will be popping up as well.
>
> So far we have 2 irq storm reports with peterz's P360 Tiny, and I
> guess that Inspur system reported by the kernel test robot. Then there
> is whatever is going on with Peter Ujfalusi's UPX-11i.

Yeah, I agree that we need both in order to reach stability.

> > Out of top of my head you could e.g. window average the duration betwee=
n
> > IRQs. When the average goes beyond threshold, then you shutdown
> > interrupts.
>
> Just to make sure I have it clear in my head, you mean when the
> average is shorter than the threshold duration between interrupts,
> yes? My brain wants to read 'When the average goes beyond threshold'
> as 'threshold < average'.
>
> Does the check need to be a rolling window like 1/2 currently has? I
> expect that if the problem exists it will be noticed in the first
> window checked. I think what I originally tried was to check over some
> interval from when the handler first ran, disable interrupts if
> needed, and then skip the check from then on when the handler ran.

How about just: average' =3D (average / (then - now)) /2

And if average' > thershold, disable interrupts.

BR, Jarkko
