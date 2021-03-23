Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844C434650A
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 17:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhCWQ0w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 12:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhCWQ0Z (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 12:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE84F6198C;
        Tue, 23 Mar 2021 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616516785;
        bh=Nke5P+B5e+vbjlH63dD13/OusNA15++oqdzjXUcgVoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmcGlWBudvSVmEJR8KRvsBPzMQ4bAQiJsddHnOLAywXLA2ut/z2OCvCD5kBUYHOgG
         WeyZJBDCFafdGpLbbUFBQwr9Toxo/nie2Ys13UUxpgx/yiQJ0BlsNyiiLxo8owqVdU
         iFhH42RCwGV3x/z5JtfjAvVCtXsTr3GSYEznVEB5KQJB/s9GzDOpmNPkGUUpYo14y0
         O599swv9yA4Rv9QTThEGFun04L3HSUnpDzN2GYyibhIiKuX06BRXiCxxkm/NNHnDQX
         h9lKcDQ98+ogJCxovNdN0U/tzhAYC2hikZzz5KC71SF2Z2AZib4fbM8vSsfviTfuHs
         QAyyyFsjFt9fg==
Date:   Tue, 23 Mar 2021 18:25:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Enuta <paulenuta@gmail.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
Message-ID: <YFoWlT7D/4Su49xE@kernel.org>
References: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
 <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
 <YFlNwaLhuwPiIzYF@kernel.org>
 <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 23, 2021 at 07:51:53AM +0200, Paul Enuta wrote:
> Hi,
> it happens with 5.10.25-v7l (latest mainline in Raspberry PI OS) and
> in my test it started with 5.10.0-v7+.
> 5.4.83-v7+ was OK.
> Problems occur on fresh and clean installs with kernel versions above 5.10.
> This quick fix solves:
> --- tpm-chip.c.orig 2021-03-22 17:43:05.433433496 +0000
> +++ tpm-chip.c 2021-03-22 18:22:52.000000000 +0000
> @@ -101,6 +101,11 @@
>  {
>   int ret;
> 
> +    if (!chip->ops) {
> +            pr_err("%s: Avoiding NULL ops pointer\n", __func__);
> +            return -EIO;
> +    }
> +
>   tpm_clk_enable(chip);
> 
>   if (chip->locality == -1) {
> 

Please try with the actual mainline. We don't care about RPi kernel.

> On Tue, Mar 23, 2021 at 4:09 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Mon, Mar 22, 2021 at 11:01:09PM +0200, Paul Enuta wrote:
> > > Dear all,
> > >
> > > As described in the issue here:
> > >  https://github.com/raspberrypi/linux/issues/4228
> > > and here:
> > >  https://www.raspberrypi.org/forums/viewtopic.php?f=75&t=303564&p=1817702#p1839351
> > > starting with kernel 5.10.XX we encounter a system hang with kernel
> > > panic at poweroff or reboot if we have dtoverlay=tpm-slb9670 loaded.
> > > Applying the patch proposed here:
> > > https://github.com/raspberrypi/linux/issues/4228#issuecomment-804081079
> > > and rebuilding the kernel solves the issue.
> > >
> > > Please review the issue and provide guidance finding the cause and solving.
> > >
> > > Kind regards,
> > > Paul Enuta
> >
> >
> > So does this happen with the latest mainline? Patched kernels are not our
> > concern.
> >
> >
> > /Jarkko
> 

/Jarkko
