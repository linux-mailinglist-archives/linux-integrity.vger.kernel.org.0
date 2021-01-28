Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81E4306BB4
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Jan 2021 04:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhA1Des (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 22:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhA1Dee (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 22:34:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD3C06174A
        for <linux-integrity@vger.kernel.org>; Wed, 27 Jan 2021 19:33:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f1so4934351edr.12
        for <linux-integrity@vger.kernel.org>; Wed, 27 Jan 2021 19:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lg0aZvX/Z7DG/BSJJpeI6lt7+vzjbMgpBvQcOOM0A9M=;
        b=rXnNgGYgmLL3oBvQhr7H/Xa47h/d32c0XCMJrctZo7OR3DjiOlLrjZLDQdDLUZNRAq
         JGZPdDvFSFb1AW1thMVEcU1sDUL3WjOyuihQ/LOkPBVXn0gh7OX4RVW6R1SDLN3u/D+p
         SEf+S39VyXR6fqt0G3tzpl8NDjvXaIS/JQZ65IDrJFqn/t6bO7dlursPqlJgnjJnlSzo
         22m9OYuZNgP1mUxgjT1TiXj03I2cFz4WrMK3qJip69Qsrto3+Hryk3/1NDds6edBeWcg
         eWKn0X2PGegK+eGqLP/dN0x5Gtnk8HJPHHvDEKajUmNOe3lJaCLmBcjoCRT48Etn7T2p
         OQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lg0aZvX/Z7DG/BSJJpeI6lt7+vzjbMgpBvQcOOM0A9M=;
        b=TNojqIqrdfeelTvkYpJcW5py6DowcUiE2ZL1LywQzA2nxNPz+qClUaw6/dnpqHYGYW
         JMI5X3MHcMiJcheNcmVd1XRdfaDJqCx9QtIFWPJxFjXt/SZabKXCTdK+uMOeNSWcbl/3
         KgYQ6FuDJ9/Bi2UvZp7cuGEfiMLBLOwzi3px/HxswP1XbUzOsoK9kcCH30s2JdDJbY8d
         j8YNHaxPm3+vebWG1TyqA+SKETaiAzHaWAdvgyzpc50uRwQLBQmns1o2y0WKIoZiEZ4b
         iOxGUEkSeWEndeou5sqCvqFkV3JCKpNgPvEavKtkYds0IPXIvVB73xfxEDNG4kCZM+fE
         fN3w==
X-Gm-Message-State: AOAM5320/rMCpeI3NST3TrWWzclfvRhfZl/BhORshemKSKbUsydYymXs
        /io335+4XR1u1qXXVgv+ZSKHcV+RqTH80JPYgCvn
X-Google-Smtp-Source: ABdhPJxzQzlMQINkQGtgusn8x3KlFXQ/4GU7tlgwwblRaGpA95RboHliLDm1HFhptD2hzonh8LpJDVD0O66OR92ZFQo=
X-Received: by 2002:a05:6402:34e:: with SMTP id r14mr12133430edw.269.1611804832864;
 Wed, 27 Jan 2021 19:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20210121200150.2448-1-nramas@linux.microsoft.com>
 <CAHC9VhT13nhaHY3kJZ6ni4rjUffSG-hD5vOfK-q2KfsVFOtaCg@mail.gmail.com> <c61e3ea5-7412-7e39-4d71-945f906d68a3@linux.microsoft.com>
In-Reply-To: <c61e3ea5-7412-7e39-4d71-945f906d68a3@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Jan 2021 22:33:41 -0500
Message-ID: <CAHC9VhS2j4cAqdPtUHzHcc_ShLAP7cndVurcpcLj9G1cAxSMMQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: measure state and policy capabilities
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
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

On Sun, Jan 24, 2021 at 12:04 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 1/22/21 1:21 PM, Paul Moore wrote:

...

> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index 644b17ec9e63..879a0d90615d 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -7407,6 +7408,10 @@ int selinux_disable(struct selinux_state *state)
> >>
> >>          selinux_mark_disabled(state);
> >>
> >> +       mutex_lock(&state->policy_mutex);
> >> +       selinux_ima_measure_state(state);
> >> +       mutex_unlock(&state->policy_mutex);
> >
> > I'm not sure if this affects your decision to include this action in
> > the measurements, but this function is hopefully going away in the not
> > too distant future as we do away with support for disabling SELinux at
> > runtime.
> >
> > FWIW, I'm not sure it's overly useful anyway; you only get here if you
> > never had any SELinux policy/state configured and you decide to
> > disable SELinux instead of loading a policy.  However, I've got no
> > objection to this code.
>
> If support for disabling SELinux at runtime will be removed, then I
> don't see a reason to trigger a measurement here. I'll remove this
> measurement.

It's currently marked as deprecated, see
Documentation/ABI/obsolete/sysfs-selinux-disable.

-- 
paul moore
www.paul-moore.com
