Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B6D3EC2EA
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Aug 2021 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhHNNkT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Aug 2021 09:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhHNNkT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Aug 2021 09:40:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C77DC061764;
        Sat, 14 Aug 2021 06:39:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id r9so15962334lfn.3;
        Sat, 14 Aug 2021 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e98SZfO+ZKBiZVbyVNuKJ9MqrAdTMA2e/JRZ/Y2nvzg=;
        b=DCPN1NwusEzCCkE6w/fWDxn7/Ni8ADyBlpTOPYNYectBsh4N69mIiRPK119gDjk0ZG
         SXjoPF2OWEGP0FfXpCUQ5zH+oSOiMAKiiZpokbN9BPWoy3umfPGMEA91xVFQjJ6xMpsp
         Z8NA83cMXT8WSHHn8xXeaDgbIH1HNUKC2ClqVGFxAT3g7t4o/s8lClxRfb0/8d5PXDF6
         SvAL5RHhho8SDt38n4cYqbQCGsVZdCsGrF01H47cLi4Uk+iJavuzHTIb5pP9Sc2DuTqj
         AdXyxLONRexvb3zvfai7gOL4xZBZF8Txa0Bj2/V2jWxWuohN8dneFg5/zOYcEIQACBw4
         RpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e98SZfO+ZKBiZVbyVNuKJ9MqrAdTMA2e/JRZ/Y2nvzg=;
        b=TsLnfb1v8DjAzGkBpHiTtsLQXhWKfhnumXecE8U5hsvRNfQ3J7HZB7eR9P9aerxrTm
         oL2vghujpQ3z1gNwEMWgdh7eLc2ZdG46lujjevEzAv17zyToFvB2nOUw1xmr9pZB7SsV
         wknz5uqiO2EmOKImi4eUMKRoR66XdHixpqy1EzBrdvcSsiCmAsQjrvWugOut5QB+Mh+b
         8Q2oPN2LWmjKRq0wWDCS1OpCZwK50GsK7pMjfQckHwLmq/akB4bdBdik+Di8V6nP04lS
         4RLMdTX20g8ih39xa8/Bu10dZVETuKAAfRYn7zQr5iIZzAHMU7DE9Iye7xA977sZZt3G
         7E3g==
X-Gm-Message-State: AOAM533bC1gB5+tUBvbXYZo9FssAUFHSO2cnFN4MjQpehz79AlcnSeJh
        5JwfhdKwNtlLKM0qPXEAjaXySnVIUcwEsel8u9HgatIR6tyDcw==
X-Google-Smtp-Source: ABdhPJyE4Z6/p4Bh8t5khfG2outGZ4QT6azexqNd62m7FqbU1UI26g0olRIPNlEmWHu8o1t/v4dQEflsH3TC6gWb+bg=
X-Received: by 2002:a19:8c4e:: with SMTP id i14mr4986679lfj.17.1628948388468;
 Sat, 14 Aug 2021 06:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru> <d97d7fdb-1676-9670-6cf5-2427f780ec6f@viveris.fr>
 <CAEUiM9ObZD=miina1NsP8Ohtv=byO=33Kp2XaeF8_RB_R_uC1Q@mail.gmail.com> <a41a0116-8d05-3aea-d979-090cdbb1d52f@viveris.fr>
In-Reply-To: <a41a0116-8d05-3aea-d979-090cdbb1d52f@viveris.fr>
From:   Igor Zhbanov <izh1979@gmail.com>
Date:   Sat, 14 Aug 2021 16:39:43 +0300
Message-ID: <CAEUiM9N-ELgr2bPvn=5P4NR8wQAKwkZ6tGFZAE8wjH16sWPZVg@mail.gmail.com>
Subject: Re: [PATCH 1/1] NAX LSM: Add initial support support
To:     THOBY Simon <Simon.THOBY@viveris.fr>
Cc:     Igor Zhbanov <i.zhbanov@omp.ru>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

=D0=BF=D1=82, 13 =D0=B0=D0=B2=D0=B3. 2021 =D0=B3. =D0=B2 11:08, THOBY Simon=
 <Simon.THOBY@viveris.fr>:
> For the matter of have a kernel commandline being the result of concatena=
tions from multiple
> sources, I think that if any attacker is able to alter part of the comman=
d line, they can
> already write 'lsm=3D' to it and completely disable NAX, thus I'm not sur=
e 'nax_locked' should
> impact other setup_* functions.
>
> I believe keeping the nax_locked parameter, but not checking for the 'loc=
ked' status in the other setup_*
> functions should be enought, as sysctls writes will still be protected by=
 the 'locked' variable.

I thought again about it. Currently it is possible to set parameters
value in Kconfig, including "locked".
So, if one needed some static configuration, that cannot be altered by
any means, they can set
the desired values at compilation time in Kconfig and it will be
impossible to change it, nor by sysctl,
nor by command-line.

But if I remove that (!locked) check, then the command-line options
would alway be able to override
the compile-time configuration, including unlocking the locked state.

Thank you.
