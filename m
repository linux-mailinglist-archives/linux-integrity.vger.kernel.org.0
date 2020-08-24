Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2691250B83
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Aug 2020 00:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHXWSY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 18:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHXWSU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 18:18:20 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BF7C0613ED
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 15:18:19 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j25so4735027ejk.9
        for <linux-integrity@vger.kernel.org>; Mon, 24 Aug 2020 15:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zbf1ipuYiVgdUWQ8HAa35vLjx5URShNXD1uA8qol15c=;
        b=q8aqKNgAlrJcW1DfAsWkK0x70/h9sqAj6sG9yqn4l/81Q41m4/G0P59I57LZClkaXi
         CPRLqLU/FdeEg+A0IImj5/xmgMzpxLzV0U9aJUwFuwU3geGJYK3FSk86WpPspnvnCuHc
         lw2P/Pm6qanEAdo3l1ruLGUEqfthWuBXvPR7BlqcKs2ZOdJXVKdhy5zbtJGbRokQ+hlf
         Rc/Zp2cKm0uj5jtbaIIJ7vTYZl3New8ZpWpAvBSNXx6c6BJLfSJczOJCxTqywbT6jrff
         qDtfZZQwwLNKFMrIDwZ5J/yokHCrMA2+vPPJ17xngNIpCph3FoV8syaw2e0zK33I2uSz
         IaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zbf1ipuYiVgdUWQ8HAa35vLjx5URShNXD1uA8qol15c=;
        b=Nf/3FM5TDy9ko/1WunmU5ly9P2RWdF7NHYidCrWIbd8yLREujalM1epvdODe8QHxY6
         ZWb6qCAOiSCTv3e2b7JfG5HCOJuCXQ+/2KOmBqqoOJBLLZCzxRq6dssG0ePyIB4KgOYP
         NZ1V5uNZfYxGEk1ZUKDraHkAWcjimXmiYIeUXz7AFK3+EsV5VG8VmwCt5aDQlqDqqj/k
         s2AYt28piOt6xcgDi1p+Aks5vd6M2stFowpgI3873VT5bHVjhj7bYyJAdPia8yDVu/7H
         NuqwaddeB8Nvt8f3rWQfCHuE9uwRZURG/rqFwVb77qik8Ij5Cs5DYJ/tGNL7SgIwfnjH
         Hzjw==
X-Gm-Message-State: AOAM533xW45NK53CQnIoGlAX9pX5JaPZZAXztmq4GJzXK79mn5sR5lX3
        raiGyZiI6n02tGoKiucSHM8nZcxxgS5UEy3aLdyV
X-Google-Smtp-Source: ABdhPJyWFqwCWCfOf3aV/DF5A9ybjw9coxTPI7UoJ5H9ThnSSr/T7I4PmxsgQ0RTLjLnYwrNv3pGmxT7ITZ5GTP/Ijs=
X-Received: by 2002:a17:906:e0e:: with SMTP id l14mr7179237eji.398.1598307497548;
 Mon, 24 Aug 2020 15:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
 <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
 <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com> <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
In-Reply-To: <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 18:18:05 -0400
Message-ID: <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        tusharsu@linux.microsoft.com, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 24, 2020 at 5:29 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 8/24/20 1:01 PM, Ondrej Mosnacek wrote:
> > On Mon, Aug 24, 2020 at 9:30 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> >> On Mon, Aug 24, 2020 at 2:13 PM Lakshmi Ramasubramanian
> >> <nramas@linux.microsoft.com> wrote:
> >>> On 8/24/20 7:00 AM, Stephen Smalley wrote:

...

> >>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
> >>
> >> No, I think perhaps we should move the mutex to selinux_state instead
> >> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> >> it can then use it indirectly.  Note that your patches are going to
> >> conflict with other ongoing work in the selinux next branch that is
> >> refactoring policy load and converting the policy rwlock to RCU.
> >
> > Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
> > that would allow you to do this in a straightforward way without even
> > messing with the fsi->mutex. My patch may or may not be eventually
> > committed, but either way I'd recommend holding off on this for a
> > while until the dust settles around the RCU conversion.
>
> I can make the SELinux\IMA changes in "selinux next branch" taking
> dependencies on Stephen's patches + relevant IMA patches.

I know it can be frustrating to hear what I'm about to say, but the
best option is probably just to wait a little to let things settle in
the SELinux -next branch.  There is a lot of stuff going on right now
with patches flooding in (at least "flooding" from a SELinux kernel
development perspective) and we/I've haven't gotten through all of
them yet.

> Could you please let me know the URL to the "selinux next branch"?

git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next

-- 
paul moore
www.paul-moore.com
