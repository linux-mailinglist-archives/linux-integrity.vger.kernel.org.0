Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4454D34584B
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 08:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhCWHEt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhCWHE0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 03:04:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6A5C061574
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 00:04:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u21so7363456ejo.13
        for <linux-integrity@vger.kernel.org>; Tue, 23 Mar 2021 00:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xprKArxHsuX9j10A/Lpl1gtKfiRh/TZ8EoXfqz8FhI4=;
        b=HUCpNBjPd3wqI5jMZO9BkinTLcukQrvJDQQNV3RBKOhjye9Sv1BKDVIFb1KQZYXNDf
         j4lsfvRN60qySP2F7vLTqSL/IKXH8UKY8Sb5pbcS5o4C7wTcHZMWeZI6CaUfuLlSooW5
         XWlZUBGth5msJFv2OzGj9+HsQx73Aad6y9FBa7iABu+GgCb5elww/RiMs+SphQf2B9/e
         X11MNzcPfdzM619XnbMw1rqsJkRh5EBieaXKi1kIHzUIxa1bI5MD99XtVvDcCpNGMoaL
         8wSlHWTrqnQnGthi3mMzXtnl2FkgsMLSIRFSf4mhaSi0UU537bl/tdVcIVE7iJn1xzv8
         DOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xprKArxHsuX9j10A/Lpl1gtKfiRh/TZ8EoXfqz8FhI4=;
        b=hiv0lEJJQH9IYLUku0dpQ+Mk29N/7QEsEUgyZ7WDxwPgd5/q/qMev6PfPq+k6J5TP7
         hM+Ry1rpWuryTRTREs8JfUXyxPlOpIgQf1m4D1L+TaICrKph+EXNF47o9EWqUobxa6Lj
         +aDdePNnX10B8XPWqnAETps4X+25ZQsHlr+caLIgzAZaXkde1X9oXPB2Kek2ATk6TrxT
         /93pzUT/xf2NeYEw7yj+qW/bQNcyhicVBDUE3p7fe4C/4xnr1Fynlsst/g0I6S9lNC4b
         7a/U3RLmlNwARejKzuykqmyTXYeLHGdUJD4fJXeIXgD1tx+/oViPgUVImESGTTMV2nBb
         2Low==
X-Gm-Message-State: AOAM5330qdOXJNk8feh7GsrYLF0b3ZhH/srAt9nxPIlTWvono63Fbzcd
        HeFAu+tSACvNTvmLWClTgxtLV57FTzyDgdgD3kgh1sNLWNw=
X-Google-Smtp-Source: ABdhPJzpccENsZZ4kboNoOv1nrVvNVklIJWsoirnpaYGRdQ4ipTfJSHcsjQX7NceaJdjRQPKdAm6WOK/MjsITWfZcJg=
X-Received: by 2002:a17:906:2b0a:: with SMTP id a10mr3459338ejg.513.1616483064464;
 Tue, 23 Mar 2021 00:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
 <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com>
 <YFlNwaLhuwPiIzYF@kernel.org> <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
In-Reply-To: <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
From:   Paul Enuta <paulenuta@gmail.com>
Date:   Tue, 23 Mar 2021 09:04:11 +0200
Message-ID: <CAEjsYA5bW22QbhC+8PtzoR7yC4CdC9To-a9k9ZfFRYiNbtGPww@mail.gmail.com>
Subject: Re: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I only found this commit
https://github.com/raspberrypi/linux/commit/1e5ac6300a07ceecfc70a893ebef3352be21e6f8#
related to the problem.

BR,
Paul

On Tue, Mar 23, 2021 at 7:51 AM Paul Enuta <paulenuta@gmail.com> wrote:
>
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
