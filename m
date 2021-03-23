Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F233457FA
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 07:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCWGt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 02:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCWGtL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 02:49:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588BC061574
        for <linux-integrity@vger.kernel.org>; Mon, 22 Mar 2021 23:49:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id e9so19563978wrw.10
        for <linux-integrity@vger.kernel.org>; Mon, 22 Mar 2021 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bjMmeP2tiZpI5j3vR5rGAM51dbC5Lw40o9O3p+5Duc=;
        b=SjkHnYTkXScDNSHN8Ru6BLy0/vbD1OsW+LJ1g8TQpw+WU/d17HBqTdCTbtsEf80KdH
         +Yio/RX+d9MTzHZZer6xqmx502mlnp3SBGMBAIu5A0P/9Rzj3N89iSIBDcIasr9AGAgh
         XKEsYdAF2PHVqXBbqm9r6x9qYve6wrnjYW8lgxNpDXq8b7kIGJ6vVBq6Bhya3f6Qc/5n
         WMFeIxBtOtocvJ/15vw3v0N0wQtShNUTQXVHw3YiLxG7NKmLlMNNDHp244jAB01/J5cF
         bP2NKb7+/kU1l1Qs7pHejz8KZhoP5uYMLGn56VDYd8ANMjXSYHD7+4gpv+4tJwvVfd5Q
         0V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bjMmeP2tiZpI5j3vR5rGAM51dbC5Lw40o9O3p+5Duc=;
        b=CAFyylPbHNdI8ilSWO+DkXdpX8G7Netf+UUBsNeqbVf5Uei1lboFnWD9q2mxjdVKJK
         9vXnHTHUxSuubP80WhzzsgPs68ejpHz0EgsYe8cdyLO6tRbxIgVpxTnFPoInByoXNbx7
         ITVi+KEPtLbp7FF2NriFF/AXJHAYA/J5tHWOvYVlGhE4hnqGDZT1zfMqXdB3wd2o5VCL
         Ph6OLRu9fhJZi6gTfKjelV9YyevdlmVrVYbhTuP5TGuzGWQgELd2j5sQTOvEO8xKHe/o
         zh1o1maV8MhPbVgZzJl/ehxmVKBHKNo6hVLmR3FCQ3T+x9oPGAXApYkUtps2TpJVy7dR
         EOtg==
X-Gm-Message-State: AOAM5325rkQEI7iFmYA7BgQG5cO248+/8OMHGkr7nv1UIBJzrP8hEicn
        D+0pNNaFroa7QS0WkAejzJ0Bi8mpnXnSs1KG+9b0vM8HE88=
X-Google-Smtp-Source: ABdhPJzycsZYS3BL8yfkBNGNrn76XgITBy2HwEvd2HiF4GjmmkdP+AKY4xyRj07ceB1RgkzWIf8Ya3zKhk/ZkRZbeiA=
X-Received: by 2002:a17:906:ecfb:: with SMTP id qt27mr3121005ejb.245.1616478725687;
 Mon, 22 Mar 2021 22:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210322205720.12F8CC061756@lindbergh.monkeyblade.net>
 <CAEjsYA4vSatmpK7dExmK=+-21xEfv01diTSxUUj4EZW5tAVb_w@mail.gmail.com> <YFlNwaLhuwPiIzYF@kernel.org>
In-Reply-To: <YFlNwaLhuwPiIzYF@kernel.org>
From:   Paul Enuta <paulenuta@gmail.com>
Date:   Tue, 23 Mar 2021 07:51:53 +0200
Message-ID: <CAEjsYA4ts2s5L0SCfo+3yFswHpqMtbmWapjhTno3cfFF9qNzSg@mail.gmail.com>
Subject: Re: 5.10.y Kernel Panic while poweroff and reboot - Null Pointer
 Exception - with TPM-Module SLB 9670
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,
it happens with 5.10.25-v7l (latest mainline in Raspberry PI OS) and
in my test it started with 5.10.0-v7+.
5.4.83-v7+ was OK.
Problems occur on fresh and clean installs with kernel versions above 5.10.
This quick fix solves:
--- tpm-chip.c.orig 2021-03-22 17:43:05.433433496 +0000
+++ tpm-chip.c 2021-03-22 18:22:52.000000000 +0000
@@ -101,6 +101,11 @@
 {
  int ret;

+    if (!chip->ops) {
+            pr_err("%s: Avoiding NULL ops pointer\n", __func__);
+            return -EIO;
+    }
+
  tpm_clk_enable(chip);

  if (chip->locality == -1) {

On Tue, Mar 23, 2021 at 4:09 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Mon, Mar 22, 2021 at 11:01:09PM +0200, Paul Enuta wrote:
> > Dear all,
> >
> > As described in the issue here:
> >  https://github.com/raspberrypi/linux/issues/4228
> > and here:
> >  https://www.raspberrypi.org/forums/viewtopic.php?f=75&t=303564&p=1817702#p1839351
> > starting with kernel 5.10.XX we encounter a system hang with kernel
> > panic at poweroff or reboot if we have dtoverlay=tpm-slb9670 loaded.
> > Applying the patch proposed here:
> > https://github.com/raspberrypi/linux/issues/4228#issuecomment-804081079
> > and rebuilding the kernel solves the issue.
> >
> > Please review the issue and provide guidance finding the cause and solving.
> >
> > Kind regards,
> > Paul Enuta
>
>
> So does this happen with the latest mainline? Patched kernels are not our
> concern.
>
>
> /Jarkko
