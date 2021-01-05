Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AAD2EA33E
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 03:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbhAECOY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 21:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbhAECOY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 21:14:24 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47791C061795
        for <linux-integrity@vger.kernel.org>; Mon,  4 Jan 2021 18:13:43 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x16so39358482ejj.7
        for <linux-integrity@vger.kernel.org>; Mon, 04 Jan 2021 18:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvV6FEczLH+8PfasNVXOCqdhthLBl7usYa45FALYpbY=;
        b=xz2K25aOL/42q3USBHxE817PRS+cpeKYlYXsD6knCfIbgZOhhDqnUGKBmS9Fi3H76r
         5APZiVGO+eEXnw/E61NSj79GlsT1I1RPnX4tB00uIfCMAY8CkMEZmdmjbJbzn3qBCt8d
         UECtGS1+2PInjKfAk0uMZ6a3T+gclJfxtAFB0t+nS12tYsPbkzcyo4EwvRf2Q667b7EH
         EnBOHa9nBFEc7HcAss4ze9V+TqgySTrRFQWam39hzF+hIYhaQ6zXMzKAwEXidmCrRW+H
         fTyOqFFwpKULfuQ+erBVKYMi+B5AXCUW/fGRM7Oc8E2fiGF3b8oyQKZwQk6RYr4y0wJp
         fGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvV6FEczLH+8PfasNVXOCqdhthLBl7usYa45FALYpbY=;
        b=KudQWhV4WNXvhAIrUasB9ZKbng/GVcWlibj+xKTL8s7XJt0ll3d1CBt1JDMhpSADQw
         soTNqnIYj+3LF054aoH0cLQELPXkU3h4+rh1pZdu1cLgGM9bNnBiFMTh37b44omEN7gB
         vvBpbMuUT0GNkZF+zT4jqLpzf4ALt9kg57pHPipSS9iQDE/8Dp+wD5VkFeQAzeENL0e3
         j5rouaKkJVWVOtvsOoL3wn6LRF7OMSbMlikEp5I6j+kSNYwlPq0g2NuLwlDMYgtS2Mkf
         p1HYgnjuOgs8O2jjmu3Jz79xyQvrX+54NJHqreyk56iz7mnidGIY7oCXC6BR1Pe/5nJt
         cJFA==
X-Gm-Message-State: AOAM532cPHTWYwNTIvVbLOVI1GtTWYn4yZfNQ4ZAG7FW+Fm5f0HihqkE
        fdRGe+/3VcJKBrhEFvo5Mo0lCu3PZq5G66+f97ld
X-Google-Smtp-Source: ABdhPJxgesvJvYIYjYXGI+ZNhOx8UyNLaM5OHTy3tIzCiNoBdqeOCTECBZdd3nkbSmgO657ZMh+Tl7Fz4T89S+WR1R0=
X-Received: by 2002:a17:907:4126:: with SMTP id mx6mr67633339ejb.91.1609812821733;
 Mon, 04 Jan 2021 18:13:41 -0800 (PST)
MIME-Version: 1.0
References: <20201212180251.9943-1-tusharsu@linux.microsoft.com>
 <20201212180251.9943-9-tusharsu@linux.microsoft.com> <CAHC9VhSao7DGtskbDMax8hN+PhQr8homFXUGjm+c7NtEUCtKhg@mail.gmail.com>
 <2dce2244-adbd-df2a-e890-271bbcc8f9f2@linux.microsoft.com>
In-Reply-To: <2dce2244-adbd-df2a-e890-271bbcc8f9f2@linux.microsoft.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Jan 2021 21:13:30 -0500
Message-ID: <CAHC9VhQ8H+UCnLTJ4Mb=GHCdExGvVEB_+nbK+-keMVie-tnbnQ@mail.gmail.com>
Subject: Re: [PATCH v9 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 4, 2021 at 6:30 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
> On 12/23/20 1:10 PM, Paul Moore wrote:
> Hi Paul,

Hello.

> >> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> >> new file mode 100644
> >> index 000000000000..b7e24358e11d
> >> --- /dev/null
> >> +++ b/security/selinux/measure.c
> >> @@ -0,0 +1,79 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * Measure SELinux state using IMA subsystem.
> >> + */
> >> +#include <linux/vmalloc.h>
> >> +#include <linux/ktime.h>
> >> +#include <linux/ima.h>
> >> +#include "security.h"
> >> +
> >> +/*
> >> + * This function creates a unique name by appending the timestamp to
> >> + * the given string. This string is passed as "event_name" to the IMA
> >> + * hook to measure the given SELinux data.
> >> + *
> >> + * The data provided by SELinux to the IMA subsystem for measuring may have
> >> + * already been measured (for instance the same state existed earlier).
> >> + * But for SELinux the current data represents a state change and hence
> >> + * needs to be measured again. To enable this, pass a unique "event_name"
> >> + * to the IMA hook so that IMA subsystem will always measure the given data.
> >> + *
> >> + * For example,
> >> + * At time T0 SELinux data to be measured is "foo". IMA measures it.
> >> + * At time T1 the data is changed to "bar". IMA measures it.
> >> + * At time T2 the data is changed to "foo" again. IMA will not measure it
> >> + * (since it was already measured) unless the event_name, for instance,
> >> + * is different in this call.
> >> + */
> >> +static char *selinux_event_name(const char *name_prefix)
> >> +{
> >> +       struct timespec64 cur_time;
> >> +
> >> +       ktime_get_real_ts64(&cur_time);
> >> +       return kasprintf(GFP_KERNEL, "%s-%lld:%09ld", name_prefix,
> >> +                        cur_time.tv_sec, cur_time.tv_nsec);
> >> +}
> >
> > Why is this a separate function?  It's three lines long and only
> > called from selinux_measure_state().  Do you ever see the SELinux/IMA
> > code in this file expanding to the point where this function is nice
> > from a reuse standpoint?
>
> Earlier I had two measurements - one for SELinux configuration/state and
> another for SELinux policy. selinux_event_name() was used to generate
> event name for each of them.
>
> In this patch set I have included only one measurement - for SELinux
> policy. I plan to add "SELinux configuration/state" measurement in a
> separate patch - I can reuse selinux_event_name() in that patch.

I'm curious about this second measurement.  My apologies if you posted
it previously, this patchset has gone through several iterations and
simply can't recall all the different versions without digging through
the list archives.

Is there a reason why the second measurement isn't included in this
patch?  Or this patchset if it is too big to be a single patch?

> Also, I think the comment in the function header for
> selinux_event_name() is useful.
>
> I prefer to have a separate function, if that's fine by you.

Given just this patch I would prefer if you folded
selinux_event_name() into selinux_measure_state().  However, I agree
with you that the comments in the selinux_event_name() header block is
useful, I would suggest moving those into the body of
selinux_measure_state() directly above the calls to
ktime_get_real_ts64() and kasprintf().

> > Also, I assume you are not concerned about someone circumventing the
> > IMA measurements by manipulating the time?  In most systems I would
> > expect the time to be a protected entity, but with many systems
> > getting their time from remote systems I thought it was worth
> > mentioning.
>
> I am using time function to generate a unique name for the IMA
> measurement event, such as, "selinux-policy-hash-1609790281:860232824".
> This is to ensure that state changes in SELinux data are always measured.
>
> If you think time manipulation can be an issue, please let me know a
> better way to generate unique event names.

Yes, I understand that you are using the time value as a way of
ensuring you always have a different event name and hence a new
measurement.  However, I was wondering if you would be okay if the
time was adjusted such that an event name was duplicated and a
measurement missed?  Is that a problem for you?  It seems like it
might be an issue, but you and Mimi know IMA better than I do.

> >> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> >> index 9704c8a32303..dfa2e00894ae 100644
> >> --- a/security/selinux/ss/services.c
> >> +++ b/security/selinux/ss/services.c
> >> @@ -3875,8 +3876,33 @@ int security_netlbl_sid_to_secattr(struct selinux_state *state,
> >>   }
> >>   #endif /* CONFIG_NETLABEL */
> >>
> >> +/**
> >> + * security_read_selinux_policy - read the policy.
> >> + * @policy: SELinux policy
> >> + * @data: binary policy data
> >> + * @len: length of data in bytes
> >> + *
> >> + */
> >> +static int security_read_selinux_policy(struct selinux_policy *policy,
> >> +                                       void *data, size_t *len)
> >
> > Let's just call this "security_read_policy()".
> There is another function in this file with the name security_read_policy().
>
> How about changing the above function name to "read_selinux_policy()"
> since this is a local/static function.

Ooops, sorry about that!  I'm not sure what I was thinking there :)

How about "__security_read_policy()"?

-- 
paul moore
www.paul-moore.com
