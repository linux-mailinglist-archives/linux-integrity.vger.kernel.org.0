Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12FA3EA8A4
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhHLQnp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Aug 2021 12:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhHLQno (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Aug 2021 12:43:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D622C061756;
        Thu, 12 Aug 2021 09:43:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t9so14624280lfc.6;
        Thu, 12 Aug 2021 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpI49aW8bFob7ItIxFv2U2BpOItSUGPsyoYWNOaVyAM=;
        b=ITy3S46jRabnrnRf8obgqgBSxaRunH7J78b5tKf44HwsA5Io+wfq3pbWX0JjF72bL9
         TfAots5d8TEKprTPj6EDJDaeVsbjLkF/9d9GbQ5g+UX5B3+dJRq4EctGFonH4/bL6oBr
         Ab7cOLWHXJUaucIEAVe8SAH0aqjjpkBGWA8PYhE6C2hSKsT4pU7FMdk+Sharq4iSFqAd
         IRKW5mVFUwLFa41iPkaIAjmTxANe+59DHw7dia4Qn4n+G1zvTZNb7+qv3PUXMQxsDqE1
         8N2A3175tNUroquCz1TtK1F92qc/WkZ6kINP53/3oVEm5Opia4DSm/NKQ5FihqkW4gKv
         b6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpI49aW8bFob7ItIxFv2U2BpOItSUGPsyoYWNOaVyAM=;
        b=nEsYzFK1apWNBPac1Vc5sbCmfO2Qzbg+YJq94vj6cxAJl8cJKp7D3mnEwF+Be6HZ1R
         v/pmkFB9hEk8ly7j60i7N7SsQ+BtULtD7uMIE19F28BFR4CLVwYCLHN2HzZ23WAborNB
         vR2nN7wnuxjnu/z8G5q6qDQ5mXIoJ1veN1Uf5yXTSZXyhV6n7q1/DusJmAIThGsP01T9
         nEhOoz3cEs41KmOtlVgSLRchekUxw+gjutcakd4oEZ/ZiD1M7wE8hQ2X5g/YRKdE2fYo
         9rVkPKYkiGhHDE4NFSMeySmA+yRhedHejuGDrYcxR6d9qSHGYy6dCf0XCagIhq4ijwuH
         rJIA==
X-Gm-Message-State: AOAM531HiAkmgPkAHK1BAAW2cNxA4zr8fhpK3pqCFP96uM1Xq5/u7Nfn
        JoE0a9OJdcdJd3TYmMYF9r27SCKHfRCc2u5SGMc=
X-Google-Smtp-Source: ABdhPJybcpJaSqzu5QJPDPXQ5Q8CvHZje9xGjMSbNK+CgYQobtyo0YZMiNC2i7TWnMkNZU90T1MT4WBI/78//sGZSWE=
X-Received: by 2002:a05:6512:1183:: with SMTP id g3mr3326832lfr.130.1628786597637;
 Thu, 12 Aug 2021 09:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru> <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
In-Reply-To: <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Thu, 12 Aug 2021 19:43:10 +0300
Message-ID: <CAEUiM9ObZD=miina1NsP8Ohtv=byO=33Kp2XaeF8_RB_R_uC1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

Thanks for thorough review. Will post the corrected version soon.

> > @@ -278,11 +279,11 @@ endchoice
> >
> >  config LSM
> >       string "Ordered list of enabled LSMs"
> > -     default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > -     default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > -     default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > -     default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > -     default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
> > +     default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
> > +     default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
> > +     default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
> > +     default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
> > +     default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
>
> I don't know the policy with regard to new LSMs, but enabling this one by default is maybe a bit violent?
> That said, considering the default mode is SECURITY_NAX_MODE_LOG, this would just log kernel messages and
> not break existing systems, so this shouldn't be a problem.

I've just oriended on landlock and lockdown. They are handled in the similar
way. But, yes, by default NAX module doesn't block anything.
If you suggest not to do that, I can remove it.

> > +__setup("nax_mode=", setup_mode);
> > +
> > +static int __init setup_quiet(char *str)
> > +{
> > +     unsigned long val;
> > +
> > +     if (!locked && !kstrtoul(str, 0, &val))
> > +             quiet = val ? 1 : 0;
>
> The order of the kernel parameters will have an impact on NAX behavior.
>
> "nax_mode=1 nax_locked=1" and "nax_locked=1 nax_mode=1" will end up with the same behavior.
> in the first case the mode is enforced, in the second case it isn't (well unless you changed
>  the kernel configuration from the default) and it can't be enabled later either.
>
> Is that desired?

Yes. The idea is that on boot you can set-up the proper options then block
further changing (especially turning the module off).
Initially it was implemented for sysctl parameters, so, you can change
something in init-scripts, then lock. Then, I've extended it to command-line
parameters.
I can ignore "locked" flag in setup_* functions to defer locking to sysctl
parsing. (Unless our command-line is glued by the bootloader from several
parts, so we want to lock it as early as possible...).

Thanks.
