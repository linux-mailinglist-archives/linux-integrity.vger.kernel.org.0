Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A84164FED
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 21:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbgBSUdF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Feb 2020 15:33:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39558 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUdF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Feb 2020 15:33:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id t23so1195899lfk.6
        for <linux-integrity@vger.kernel.org>; Wed, 19 Feb 2020 12:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guzman.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3D/G80Wt59tM43j8yIDvUlrc1Yx4YyAzf7cqmsooQfg=;
        b=IlnefV8MaNlFoRxh65jFNxdoxQoE9Y6qBiY64oQymxZN/F1j6Hz/HAaGK3cK/PNhtR
         EQcdoyfG1aWDmVLaiy9cdMKNVY+JfNsORlCi3Xd2krppODQZN9Jtpu4k7w7aaCd2R7uU
         zqwsQVCqfnekcoEqeAohkdV/jCOrVlV6N/wT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3D/G80Wt59tM43j8yIDvUlrc1Yx4YyAzf7cqmsooQfg=;
        b=KbSNw4PRz2+672V2gE1TDJJmn7fORi2q9XOnZOMfElOE0EWaBqb49UsI/U4Ztv4j1x
         ynp1/uUUiNRIh9tB2HF+Fh79vmQf0mJedDL1zri0wiiXSxvcvE6QA3OLqeGcRuHqG2cu
         u1eSPs04Dwfa9DS5tf+UJLQCt4k9eIlvT0KgJHCnGOmcITTapiXuvjalLtpieCcDqWth
         Gw6XONr3e3VY9zgttsNfQQMQX8SAgznp0ROpa427yBSWLPzqOVie/sKm0qaIeZmr06YT
         XbuIQ6+4NKWx69f+12r9SAtQYj8M3Wqb0vftqkBqf+3FsNoMxadZqunN1bJVDTZlEfbJ
         uAqQ==
X-Gm-Message-State: APjAAAV19kypW4qCFYLf2EKuAvkfS9aN1ovuQev32RP9MZUdMmBoJtJB
        MyVrO4wz4oELOu7l090caoKfXfrrdPH+hM8Lobciwg==
X-Google-Smtp-Source: APXvYqxBRlBi2rTEPuFUikHtOGpmZFADpqCFD0QYf4BkO6Oikr4fk4TfLKo5+mq7ccQVPfaf/yskurHrsFwpWQT3z5A=
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr14665335lfg.81.1582144382010;
 Wed, 19 Feb 2020 12:33:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJ7-PMaLw_H8Fc1tyoT95f5EWpS3nvJt1Wx9=xpuiSotJ2h9VA@mail.gmail.com>
 <CAJ7-PMbJ5fiQAj-5QAzAcFW0eMNkxpQSs=r_wUEfED33XZAPDg@mail.gmail.com>
 <1581712162.16860.8.camel@HansenPartnership.com> <20200214210203.dgzhkrvagiozezfi@cantor>
 <1581714273.16860.18.camel@HansenPartnership.com> <76b24921c76dbc8fe6ea04b44e695d8a5c89a356.camel@guzman.io>
 <233ecdf9-0495-90d1-9d9d-7e7d7e60d011@intel.com>
In-Reply-To: <233ecdf9-0495-90d1-9d9d-7e7d7e60d011@intel.com>
From:   Alex Guzman <alex@guzman.io>
Date:   Wed, 19 Feb 2020 15:32:50 -0500
Message-ID: <CAJ7-PMbujee92N1f9xVF8vtXgS49qpe7qHkeWh1Z0R-Rk-Jkaw@mail.gmail.com>
Subject: Re: Debugging errors with Dell XPS 9560 TPM
To:     Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

My gentoo ebuild has these config flags set:

        --with-crypto="$(usex gcrypt gcrypt ossl)" \
        --with-udevrulesdir="$(get_udevdir)/rules.d" \
        --with-udevrulesprefix=60- --disable-defaultflags \
        --disable-tcti-device-async

So I'm already testing with async off as far as I can tell.

I just updated to the latest commits of tpm2-tss and tpm2-tools
(21c6bf9e75391a7033b74c517c88e336d2da4a9d and
711250043ee075a4ebef7c8ad2a22d23e542ca00 respectively) as well as
updating to 5.6_rc2. Still the same result.


On Tue, Feb 18, 2020 at 12:52 PM Tadeusz Struk <tadeusz.struk@intel.com> wrote:
>
> On 2/14/20 5:47 PM, Alex Guzman wrote:
> > I just tested with 5.6_rc1. The behavior is still present:
> >
> >
> > ERROR:tcti:src/tss2-tcti/tcti-device.c:290:tcti_device_receive() Failed
> > to read response from fd 3, got errno 1: Operation not permitted
> > ERROR:esys:src/tss2-
> > esys/api/Esys_GetCapability.c:307:Esys_GetCapability_Finish() Received
> > a non-TPM Error
> > ERROR:esys:src/tss2-
> > esys/api/Esys_GetCapability.c:107:Esys_GetCapability() Esys Finish
> > ErrorCode (0x000a000a)
> > ERROR: Esys_GetCapability(0xA000A) - tcti:IO failure
> > ERROR: Unable to run tpm2_getcap
>
> I tried to reproduce this, but I couldn't. Do you know what version
> of TSS are you using, and what is the configuration used to build it.
> Could you try to rebuild it with --enable-tcti-device-async=no
> and try that.
> Thanks,
> --
> Tadeusz
