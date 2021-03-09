Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A8E331BD6
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Mar 2021 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCIAnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Mar 2021 19:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCIAmf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Mar 2021 19:42:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FA9C06175F
        for <linux-integrity@vger.kernel.org>; Mon,  8 Mar 2021 16:42:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ci14so24033780ejc.7
        for <linux-integrity@vger.kernel.org>; Mon, 08 Mar 2021 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C76/WHac0N5dofcpCfqmmbgG/z/7d+A5P13qFcVNTw0=;
        b=aNi9vvcZjpTpC0ikBenjWHm1ZPsi4x8VyV09lw4CeHGd5H4Vaph8cgfFK3uIS8FqfJ
         KQ2jzaGIOm3wrWNR9VmtZyy7ECTl6fqS84xHDSjqj/3J8uCNjZoJZTr/72IHbUg6YvSX
         yZI07xMyXmv88iUtWnafN0Oucy3z3yEC/vmyxh+yMA1yEcSAQgw2Y947s+sIbyXZJgmG
         p4U+/iPP3AcGRJOncOCbb5NnDt9P2hriv6UROarWJ+qSSXmNc6te1gHbXnIaifZIwEjr
         jheymuT2SdP7g0l5H+zNWEFkqHdcrjavhRaK95kB+a/FaljGtFCaZjJD3peWQY/zhKUN
         R+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C76/WHac0N5dofcpCfqmmbgG/z/7d+A5P13qFcVNTw0=;
        b=E/aDgt+Yi0+WEoHzcEYzqSu3LDnm60EFa/WpCgMpj58UmtVCT9V5GJw+mv4wZnD17l
         pQvCSHA6vpDDWlyg/MV0kQc6sgGlesaorEeDaiDIwmwbtLH81rLewEk1LhsoZH5wJlkm
         MukYkRXEh2R3/lWXVAw9chmXGol6ure2Uu9z/9F8CUPyFtE2NGP8oXzKX6kGj4DWgQi5
         SsMxW60W4CF8VV0O4kwSL4uSoVSlfiXTz2ukEprocMLJy+JEw46regwSoXvOw2pq1o2l
         bTLIea1rVhXRYEj4ngWx++cPJ3wW0q7TN+Xk6/LtysatYk1VILiSasKqHqvjvmoveVgs
         3hJA==
X-Gm-Message-State: AOAM5322JOrNixj+l4ToTD5kwy/WqXMtnsDk2fH4hObpOm2SINhuyRHs
        eCF5myoA5wTgB/2hRBZ2KksfTtTs2gysu9TaoI84
X-Google-Smtp-Source: ABdhPJwIXGkaBF8V6dy+G5/2xAXi9yydRYkl9mxsxD52Mh+nITMM46/Nu7niLBb8GSPoDLAba2ZlQ7UqF7KtZM2svqE=
X-Received: by 2002:a17:906:3b84:: with SMTP id u4mr17224484ejf.431.1615250553701;
 Mon, 08 Mar 2021 16:42:33 -0800 (PST)
MIME-Version: 1.0
References: <20210212163709.3139-1-nramas@linux.microsoft.com>
 <CAHC9VhSMz8FtK5HMPA1+FMeU0cs4vfCCaimxb-J+VDj_Dyk-nA@mail.gmail.com>
 <af0f2d60c6584b613172b08e4fcea4119e231e93.camel@HansenPartnership.com>
 <CAHC9VhRBdJ9Vh1ESezim129OEf1UJ-Mxm1g9FpxEJmt-PUSLjg@mail.gmail.com> <9170636f-1793-2272-e3fe-1551c18edeb9@linux.microsoft.com>
In-Reply-To: <9170636f-1793-2272-e3fe-1551c18edeb9@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Mar 2021 19:42:22 -0500
Message-ID: <CAHC9VhQEAPB_kQFxBrJWtsL8wP9YoQkCzXnXmaD5gm9duBzYcQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 5, 2021 at 2:29 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 3/5/21 11:22 AM, Paul Moore wrote:
>
> Hi Paul,
>
> > On Fri, Mar 5, 2021 at 12:57 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> >> On Fri, 2021-03-05 at 12:52 -0500, Paul Moore wrote:
> >> [...]
> >>> This draft seems fine to me, but there is a small logistical blocker
> >>> at the moment which means I can't merge this until -rc2 is released,
> >>> which likely means this coming Monday.  The problem is that this
> >>> patch relies on code that went upstream via in the last merge window
> >>> via the IMA tree, not the SELinux tree; normally that wouldn't be a
> >>> problem as I typically rebase the selinux/next to Linus' -rc1 tag
> >>> once the merge window is closed, but in this particular case the -rc1
> >>> tag is dangerously broken for some system configurations (the tag has
> >>> since been renamed) so I'm not rebasing onto -rc1 this time around.
> >>>
> >>> Assuming that -rc2 fixes the swapfile/fs-corruption problem, early
> >>> next week I'll rebase selinux/next to -rc2 and merge this patch.
> >>> However, if the swapfile bug continues past -rc2 we can consider
> >>> merging this via the IMA tree, but I'd assume not do that if possible
> >>> due to merge conflict and testing reasons.
> >>
> >> If it helps, we rebased the SCSI tree on top of the merge for the
> >> swapfile fix which is this one, without waiting for -rc2:
> >
> > Considering that -rc2 is only two days away I'm not going to lose a
> > lot of sleep over it.
> >
>
> Thanks for reviewing the patch.
>
> I can wait until the swapfile issue is resolved (in rc2 or later) and
> you are able to merge this patch. Please take your time.

Thanks for your patience Lakshmi, I just merged this into my local
selinux/next branch and will be pushing it up to kernel.org later
tonight - thank you!

-- 
paul moore
www.paul-moore.com
