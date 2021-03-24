Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FD93477C7
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 13:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCXL70 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhCXL6w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 07:58:52 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41108C061763
        for <linux-integrity@vger.kernel.org>; Wed, 24 Mar 2021 04:58:52 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s2so17280233qtx.10
        for <linux-integrity@vger.kernel.org>; Wed, 24 Mar 2021 04:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5jBoc89Kz6VevDsxjEVnyU/TFyYdt6APOAVRtmq0fb8=;
        b=uESPpmGPXBld0rbBdOFulTP/bp7Vw1vzzpsrBOc5gi4STO0QG+5a/mWq2Akav5obla
         hS4qWaawUXrss+CF3nbnj9alafYdmCCUjg+lB8R4JR6heBe7kp6FCGuiRzvdio1+G5fe
         +UQbuvAaQgL4POdelWCSljzq1R99V+DkakA52uLlci4jlgM9eKnVbWHCX9XA0bl5UXGP
         RsnmzvZLMNdB9kSGnwpgUhYgx69nmcQvj2MAFjOOJa1R5Fp4Y0+272VQP9Ns4vsbaWm/
         pKqMEbp+C8darD9/+7fpS71WO00e595WTxRPb3otBRMw5Sg4/h7uQKCEU3o4nhPg6w1E
         k+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5jBoc89Kz6VevDsxjEVnyU/TFyYdt6APOAVRtmq0fb8=;
        b=IgHmR//5fjJjrx1KGQ8PI3dgZiz8CrcmG4pElJMGqqXAYdAw9v9iHrDWLnbAgO0u8Q
         urm9DDghIIvkVrekT29VVcDWCHs3nLXwW0LMcXaanCAV5Rb4yTMqVDiFf0TG1H/r+4cx
         lNgytyjED5eSI3Pc0SRg3cDIdiqHhgBfnaWaadS7vZZiF4VeETYm8Cq1TT/Z3iDBaBNE
         Ub15MlGZL8LfGqLuvADJ0sqGljlDirsEcOATi09W/tOtP2HRLcjoueaiEe8WevUo4hqH
         m+0Oq46iyt40U+jMq7Bd4aIsibACQJ9fSbjCr08C2f1+RjkqnM6eTjF1W3hYjfV983f+
         663w==
X-Gm-Message-State: AOAM533vuRUlzVUoKjfRzoS7ZwxFtEGCkRTCP0ovteFja6i4fBe+Mc9+
        Fyo6KxbZKcYP/dfsqrxymtL7uuH3F5VubENVtd3RMWAEmhrLSw==
X-Google-Smtp-Source: ABdhPJzVvQlme5fr+htLlezPzoESHNVoYoGvv+4l+SvS1Gdr9SgaUqe2SOi2DcyBVIL+pkPFWwQFwpqVunWSny9LNAQ=
X-Received: by 2002:a05:622a:c3:: with SMTP id p3mr2487341qtw.43.1616587130686;
 Wed, 24 Mar 2021 04:58:50 -0700 (PDT)
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
 <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com>
 <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
 <CACT4Y+Y+wzPytH7hMAn3O6zT0p2D4UyQwDbuKbUqc4REzPECkw@mail.gmail.com> <ca2b63a47c2910072397d41448c46293750456f7.camel@linux.ibm.com>
In-Reply-To: <ca2b63a47c2910072397d41448c46293750456f7.camel@linux.ibm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 24 Mar 2021 12:58:39 +0100
Message-ID: <CACT4Y+YatH2MHMh5s1KJtb-5w-RvmZPtQyRZqpVk=YP=HJYMkg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was initialized
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 24, 2021 at 12:49 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2021-03-24 at 12:37 +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 24, 2021 at 12:21 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >
> > > On 2021/03/24 20:10, Mimi Zohar wrote:
> > > > On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
> > > >> On 2021/03/24 1:13, Mimi Zohar wrote:
> > > >>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
> > > >>>> On 2021/03/23 23:47, Mimi Zohar wrote:
> > > >>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
> > > >>>>> time to reconsider.   For now, it makes sense to just fix the NULL
> > > >>>>> pointer dereferencing.
> > > >>>>
> > > >>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
> > > >>>
> > > >>> Not supplying "integrity" as an "lsm=" option is a user error.  There
> > > >>> are only two options - allow or deny the caller to proceed.   If the
> > > >>> user is expecting the integrity subsystem to be properly working,
> > > >>> returning a NULL and allowing the system to boot (RFC patch version)
> > > >>> does not make sense.   Better to fail early.
> > > >>
> > > >> What does the "user" mean? Those who load the vmlinux?
> > > >> Only the "root" user (so called administrators)?
> > > >> Any users including other than "root" user?
> > > >>
> > > >> If the user means those who load the vmlinux, that user is explicitly asking
> > > >> for disabling "integrity" for some reason. In that case, it is a bug if
> > > >> booting with "integrity" disabled is impossible.
> > > >>
> > > >> If the user means something other than those who load the vmlinux,
> > > >> is there a possibility that that user (especially non "root" users) is
> > > >> allowed to try to use "integrity" ? If processes other than global init
> > > >> process can try to use "integrity", wouldn't it be a DoS attack vector?
> > > >> Please explain in the descripotion why calling panic() does not cause
> > > >> DoS attack vector.
> > > >
> > > > User in this case, is anyone rebooting the system and is intentionally
> > > > changing the default values, dropping the "integrity" option on the
> > > > boot command line.
> > >
> > > OK. Then, I expect that the system boots instead of calling panic().
> > > That user is explicitly asking for disabling "integrity" for some reason.
> >
> > That was actually my intention. The prebuilt kernel that I use for
> > things has all LSMs enabled, but then I needed to try some workload
> > with only 1 specific LSM, so I gave a different lsm= argument.
>
> IMA/EVM is dependent on "integrity".  Was your intention to also
> disable IMA and EVM?

I think, yes... or not sure. I was trying to test a bug that requires
a different major LSM and all minor LSMs are presumably irrelevant. I
dropped existing lsm= arg and added something like lsm=apparmor.

> If so, when disabling "integrity", don't load an
> IMA policy.

I don't really know what this means. I guess it simply comes from the
image? If so, there was no easy way to avoid loading.
