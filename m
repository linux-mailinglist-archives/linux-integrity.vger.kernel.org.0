Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D82257B7B
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHaOrT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaOrP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 10:47:15 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFCC061573;
        Mon, 31 Aug 2020 07:47:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g96so2946895otb.12;
        Mon, 31 Aug 2020 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2tcN9Jz0h7kw1m7OiNmzbCBKujbmSV8MqHohL1aMxc=;
        b=okkSFCeO2nLOMIkvoDn5wLrmrRFbpUKUqcypUHRgryOCdvmz3bPyt7lDX0PFnuYEhO
         6c1MpCfws1lykdrr5sGQGnJ3t2/jkaOafYInME7Uaowdrhymh8jFoBia/4swJJohXsyq
         QgGEF/yDCmAs0V0u9D3NiJEDrjYd9qH3H6Co+ZRgTYBFxrqUeC8fQ+D1V+PmFF66zVu2
         pMJrZ0kfwK9NJM9tJ+lwaDcSSBJKkFv6wWGhPOB3InIaQTDMNjD2B6KBwy+kLr52z2ux
         AVdRnxjK4d1VkohanZCV2N5dT0GVBilRt+j/7o/mxVGHgM2S03t5opG2vu74RxPAaz9+
         5YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2tcN9Jz0h7kw1m7OiNmzbCBKujbmSV8MqHohL1aMxc=;
        b=SdjyGfHfLkTiniboi0XyCntDZA9EHvE1FvqlVkrwMOsyifVZlhmaTLatpqb65I9t5i
         KKtjeT3GTzakiqUzlF1vkcf4Ug/I+sKUsHwZUyaisnJloUhWMUK3KkBt/AXabWO2cZ/g
         UVKnhl+c7Jo6lAwrDbRnNuhPW8PWy8p7yRmH4iUjhPGppSqLVhQaGqrm7ud5wF/H/BEZ
         weuk3HhJ1Skpv4bqMhR8nG5hLOVgTLiiW3guyYGWOq7DLLm9pK7efEiEFbQZkwUisIi7
         7Dm9YbFx8utYYf2aGLe3k2ytCwIvs672pVbgIJOGMGaM4DnawboJrsoGZPAGZJO7yZy1
         MPyA==
X-Gm-Message-State: AOAM5317WEQUhprz+kgRZFhdAZypa728ybuXV/6gm2pt5raYtcpA6O2U
        dJbIYb9EXWvoi5MfFzRsm6zHOTUeY9WDzIjin1g=
X-Google-Smtp-Source: ABdhPJxPXXHtDiYGXjiJJVFSGYMXS15SU9DduSu2S4QuZFBZsnY3dQXEFlX9xjhw6RNRvh0QzILJ6LFIiS2sjeJp1Y8=
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr1192602otp.162.1598885233434;
 Mon, 31 Aug 2020 07:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200822010018.19453-1-nramas@linux.microsoft.com>
 <CAEjxPJ5Kok-TBfS=XQ+NUC5tuaZRkyLBOawG4UDky51_bsMnGw@mail.gmail.com>
 <418618c4-a0c6-6b28-6718-2726a29b83c5@linux.microsoft.com>
 <CAEjxPJ6-8WnZRJnADsn=RVakzJiESjEjK-f8nSkscpT7dnricQ@mail.gmail.com>
 <CAFqZXNvVQ5U6Ea3gT32Z0hfWbu7GPR-mTF2z6-JZZJT57Heuuw@mail.gmail.com>
 <f041e8ee-3955-9551-b72d-d4d7fa6e636d@linux.microsoft.com>
 <CAHC9VhQP7_rV+Oi6weLjVhrx2d8iu9UJ8zeE=ZcqnBMqngrJ4Q@mail.gmail.com>
 <07854807-c495-b7e5-fc44-26d78ff14f1b@linux.microsoft.com> <CAEjxPJ4TkEEKG+pXwUjyysov1s1mFk4jbGGVyC7ghmpfd3TJ4w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4TkEEKG+pXwUjyysov1s1mFk4jbGGVyC7ghmpfd3TJ4w@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 10:47:02 -0400
Message-ID: <CAEjxPJ6GkUot29g5qq2GVYzmY2xwfTvVJkNP2kK54OcW7tkz1Q@mail.gmail.com>
Subject: Re: [PATCH] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
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

On Wed, Aug 26, 2020 at 8:51 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 4:49 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > On 8/24/20 3:18 PM, Paul Moore wrote:
> >
> > Hi Paul,
> >
> > >>>>> Is Ondrej's re-try approach I need to use to workaround policy reload issue?
> > >>>>
> > >>>> No, I think perhaps we should move the mutex to selinux_state instead
> > >>>> of selinux_fs_info.  selinux_fs_info has a pointer to selinux_state so
> > >>>> it can then use it indirectly.  Note that your patches are going to
> > >>>> conflict with other ongoing work in the selinux next branch that is
> > >>>> refactoring policy load and converting the policy rwlock to RCU.
> > >>>
> > >>> Yeah, and I'm experimenting with a patch on top of Stephen's RCU work
> > >>> that would allow you to do this in a straightforward way without even
> > >>> messing with the fsi->mutex. My patch may or may not be eventually
> > >>> committed, but either way I'd recommend holding off on this for a
> > >>> while until the dust settles around the RCU conversion.
> > >>
> > >> I can make the SELinux\IMA changes in "selinux next branch" taking
> > >> dependencies on Stephen's patches + relevant IMA patches.
> > >
> > > I know it can be frustrating to hear what I'm about to say, but the
> > > best option is probably just to wait a little to let things settle in
> > > the SELinux -next branch.  There is a lot of stuff going on right now
> > > with patches flooding in (at least "flooding" from a SELinux kernel
> > > development perspective) and we/I've haven't gotten through all of
> > > them yet.
> > >
> >
> > Could you please let me know when the current set of changes in SELinux
> > next branch would be completed and be ready to take new changes?
> >
> > I mean, roughly - would it be a month from now or you expect that to
> > take longer?
>
> I can't speak for Paul but I would expect it to be sooner rather than
> later. Ondrej has some follow ups on top of my policy rcu conversion
> but then it should be good to go.

I think the major changes are now merged although there are still a
couple of changes coming from Ondrej that could affect your code.  For
your purposes, the important things to note are:

1) The mutex has moved from selinux_fs_info to selinux_state and is
now named policy_mutex.  You will need to take it around your call to
security_read_policy_kernel().

2) security_policydb_len() was removed and security_read_policy() just
directly reads the policydb len.  You can do the same from your
security_read_policy_kernel() variant.

3) Ondrej has a pending change to move the policycap[] array from
selinux_state to selinux_policy so that it can be atomically updated
with the policy.

4) Ondrej has a pending change to eliminate the separate initialized
boolean from selinux_state and just test whether selinux_state.policy
is non-NULL but as long as you are using selinux_initialized() to
test, your code should be unaffected.
