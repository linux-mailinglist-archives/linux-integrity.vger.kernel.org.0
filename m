Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE5A347784
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCXLhf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 07:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhCXLhb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 07:37:31 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095DBC061763
        for <linux-integrity@vger.kernel.org>; Wed, 24 Mar 2021 04:37:31 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c3so17601092qkc.5
        for <linux-integrity@vger.kernel.org>; Wed, 24 Mar 2021 04:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E19TEuvX44zTRKr5TDA3GuLli/wt/Gp44osX4iYRJ3I=;
        b=EasYVsqFNBZNE9BpTHv2ij/vzUXMWcqnSGBz0GgxkYhJJrCIlDzTyXWuwUHFd4G5Wb
         fIMD51n3s35jMGUiweEcXLUgE6xGSJhvZtyLdmN9Q/XmSs2h7hbEbf+otr8un77zYNNW
         s4C6FlmIoPAsr+QNxuMB3vcxwrJ7o34W5wlEOfLgl8oC0/xBZIQI8e0urTzVkSN8WF+V
         zGeKQxo49TEk4AB6qj+x7v79B2cTZMcFJt2VsCIHsQw39ZOz/LXEir6lsr+WQjmvdQTX
         r4wQ5pun/bhRM/TRAJNL/GjArtamZpiv2hBMmgW4tzVvaahP+PVAV4yxvoZGLo2rLbc/
         Qf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E19TEuvX44zTRKr5TDA3GuLli/wt/Gp44osX4iYRJ3I=;
        b=Nj103xBIwcTD/dOIjojoEPGwQqnvVhyWKcXPGr3EZ2j/pnxsIBg/18FqykpeThjBL0
         p1WZ4woPjEwCwBusUHXNE+IzkEGCg0ha6bSqnaqJAgOENOb+AomMQyoqcGKpt19e/xR2
         N5uD2nNDJcvTKlePSCJz7aQ4Yva5HlgJdNVemkPqCKfydxuZDr8sTtENHo4RHMHJWwv+
         fbP8kaq909QJSaaFV5CHcJtkdtfHivuw3Enc0sqggeR+btY+CjsFxgDzYajsxMc4NmO2
         bsUba7Qo93PH+a6R9qkWmblp6UXJZnCXtKQZ4Tvqe8zOdf06paENfPO6Yj2dGwnkuF7I
         6OMg==
X-Gm-Message-State: AOAM532SEPQ9xCFvN/w5I8XFsR0NbXQfAx4EoKbkrHdxZapZIxTJb2IY
        aOw4F2SWZF/hTyUyY9TNXi9t9fXbRxKXzNAbtmMjqGggo7w=
X-Google-Smtp-Source: ABdhPJxUQXHOcPFqFz9YEurtiZLdMzFKc0Qz7cpAwUH0MKTAcsKRp8DuAQWYVXimq0yx41t7Zm+ffTp1yobHrSFUJyQ=
X-Received: by 2002:a05:620a:981:: with SMTP id x1mr2381201qkx.501.1616585849962;
 Wed, 24 Mar 2021 04:37:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210319200358.22816-1-zohar@linux.ibm.com> <20210319200358.22816-2-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
 <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
 <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
 <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
 <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
 <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
 <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
 <721b4f8d38b014babb0f4ae829d76014bbf7734e.camel@linux.ibm.com>
 <0a0c5cc5-0e1b-ef01-60c4-5247af2124f4@i-love.sakura.ne.jp>
 <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com> <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
In-Reply-To: <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Mar 2021 12:37:18 +0100
Message-ID: <CACT4Y+Y+wzPytH7hMAn3O6zT0p2D4UyQwDbuKbUqc4REzPECkw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was initialized
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 24, 2021 at 12:21 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2021/03/24 20:10, Mimi Zohar wrote:
> > On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
> >> On 2021/03/24 1:13, Mimi Zohar wrote:
> >>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
> >>>> On 2021/03/23 23:47, Mimi Zohar wrote:
> >>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
> >>>>> time to reconsider.   For now, it makes sense to just fix the NULL
> >>>>> pointer dereferencing.
> >>>>
> >>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
> >>>
> >>> Not supplying "integrity" as an "lsm=" option is a user error.  There
> >>> are only two options - allow or deny the caller to proceed.   If the
> >>> user is expecting the integrity subsystem to be properly working,
> >>> returning a NULL and allowing the system to boot (RFC patch version)
> >>> does not make sense.   Better to fail early.
> >>
> >> What does the "user" mean? Those who load the vmlinux?
> >> Only the "root" user (so called administrators)?
> >> Any users including other than "root" user?
> >>
> >> If the user means those who load the vmlinux, that user is explicitly asking
> >> for disabling "integrity" for some reason. In that case, it is a bug if
> >> booting with "integrity" disabled is impossible.
> >>
> >> If the user means something other than those who load the vmlinux,
> >> is there a possibility that that user (especially non "root" users) is
> >> allowed to try to use "integrity" ? If processes other than global init
> >> process can try to use "integrity", wouldn't it be a DoS attack vector?
> >> Please explain in the descripotion why calling panic() does not cause
> >> DoS attack vector.
> >
> > User in this case, is anyone rebooting the system and is intentionally
> > changing the default values, dropping the "integrity" option on the
> > boot command line.
>
> OK. Then, I expect that the system boots instead of calling panic().
> That user is explicitly asking for disabling "integrity" for some reason.

That was actually my intention. The prebuilt kernel that I use for
things has all LSMs enabled, but then I needed to try some workload
with only 1 specific LSM, so I gave a different lsm= argument.
