Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEA97C55C1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Oct 2023 15:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbjJKNm7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Oct 2023 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjJKNm4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Oct 2023 09:42:56 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D245B6
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2023 06:42:54 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4527d7f7305so2718453137.1
        for <linux-integrity@vger.kernel.org>; Wed, 11 Oct 2023 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697031773; x=1697636573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qTDjoIZ03CBcH7tMxcjA6MiVaUkDiBuhxsHI1DayPds=;
        b=YOA+1xFFutX/RIyhN+/R8fGTBEmjYDlqZas2kbAZtJycIYxadkjqrOBjkey27n/AFy
         q2ouVB+Cf3puvXQ6VujxCT4Hf+xR1x0Bxq/4P/jSgA0x99rc3bp/nJE9+5DmfvG/GWUj
         Di96SRjEyAp65ncUuSpkjgQjLHkCOhaF7m3O66JslKdMP4YvFJ6Bi8TS2Uvx0cSEHVne
         YU/LzIxqrxvauV7BgGfGWjer70qlJs/9uAVW1vynOJThzfVxGwy1tUGlFBWjvbXYEzBr
         VXdMHKn1xP6/a7mKg/Rysy56Hn1TltbHM44eEpH2ZoeMfK8jGMsCYAC43DuJxV4LoheG
         nUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031773; x=1697636573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTDjoIZ03CBcH7tMxcjA6MiVaUkDiBuhxsHI1DayPds=;
        b=ux2qgNR7sHROG79bLyutlQDOhT6wYrinvGJUaxuayt1Y52DSA7dRgjNKu8qj1B28y9
         egGPzA1bBuiWUJSUdo/85/+gwUP/MZobvbzNegVsDeMEf9xmmtD4BrvX19//f2OeSp1W
         YRxlCtw7Z5Tlt9JfAjL3uimoy+7p3FvVpuXyJ7S5uPpNije9Bvjomf7LPBDlOtsfTRti
         OaY8RxOTUF+hAorD8GP+W3+E3jQmeWNvYsGac2aHjFd3IgcdMH0w7jflT8uBfZ+8X1TP
         qvOX4ypZ+Knm4uMtUxdd+m/f1scagiaoq54YL1DpmfHAbSCT3bVadWNAX9j1ZXnodlDR
         Ebdg==
X-Gm-Message-State: AOJu0YzPK7higPCOi5Y7mImCFwSOoDqRKo17ImmPZtCnPBH4H2Y/4N+l
        h+VDNLGgr6hKwyqaHtYZbFk9M0Fa78Dj3WwCJ4B8LMFMlKsO0XSA
X-Google-Smtp-Source: AGHT+IF7fTsemx7KHasTe2i//MLXTne8Z40i/7x29q6/QnKrqOxnvNSIl039g1zxpsf4ZeNOC/vPbTSj6zNdmqzFRuw=
X-Received: by 2002:a05:6102:4a5:b0:44d:5a92:ec40 with SMTP id
 r5-20020a05610204a500b0044d5a92ec40mr20501986vsa.24.1697031773138; Wed, 11
 Oct 2023 06:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231010231616.3122392-1-jarkko@kernel.org> <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
 <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
 <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
 <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
 <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
 <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com> <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
In-Reply-To: <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 11 Oct 2023 19:12:41 +0530
Message-ID: <CAFA6WYN0vXWZveAkzOfV_6Kki77SxgX7C=Xqe9brZMX1Dj2iLg@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 11 Oct 2023 at 18:36, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, 2023-10-11 at 18:25 +0530, Sumit Garg wrote:
> > On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > > > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > >
> > > > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > > > > >
> > > > > > > > Do bind neither static calls nor trusted_key_exit() before a successful
> > > > > > > > init, in order to maintain a consistent state. In addition, depart the
> > > > > > > > init_trusted() in the case of a real error (i.e. getting back something
> > > > > > > > else than -ENODEV).
> > > > > > > >
> > > > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com/
> > > > > > > > Cc: stable@vger.kernel.org # v5.13+
> > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > ---
> > > > > > > >  security/keys/trusted-keys/trusted_core.c | 20 ++++++++++----------
> > > > > > > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > > > > > >                 if (!get_random)
> > > > > > > >                         get_random = kernel_get_random;
> > > > > > > >
> > > > > > > > -               static_call_update(trusted_key_seal,
> > > > > > > > -                                  trusted_key_sources[i].ops->seal);
> > > > > > > > -               static_call_update(trusted_key_unseal,
> > > > > > > > -                                  trusted_key_sources[i].ops->unseal);
> > > > > > > > -               static_call_update(trusted_key_get_random,
> > > > > > > > -                                  get_random);
> > > > > > > > -               trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > > > -               migratable = trusted_key_sources[i].ops->migratable;
> > > > > > > > -
> > > > > > > >                 ret = trusted_key_sources[i].ops->init();
> > > > > > > > -               if (!ret)
> > > > > > > > +               if (!ret) {
> > > > > > > > +                       static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > > > +                       static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
> > > > > > > > +                       static_call_update(trusted_key_get_random, get_random);
> > > > > > > > +
> > > > > > > > +                       trusted_key_exit = trusted_key_sources[i].ops->exit;
> > > > > > > > +                       migratable = trusted_key_sources[i].ops->migratable;
> > > > > > > > +               }
> > > > > > > > +
> > > > > > > > +               if (!ret || ret != -ENODEV)
> > > > > > >
> > > > > > > As mentioned in the other thread, we should allow other trust sources
> > > > > > > to be initialized if the primary one fails.
> > > > > >
> > > > > > I sent the patch before I received that response but here's what you
> > > > > > wrote:
> > > > > >
> > > > > > "We should give other trust sources a chance to register for trusted
> > > > > > keys if the primary one fails."
> > > > > >
> > > > > > 1. This condition is lacking an inline comment.
> > > > > > 2. Neither this response or the one that you pointed out has any
> > > > > >    explanation why for any system failure the process should
> > > > > >    continue.
> > > > > >
> > > > > > You should really know the situations (e.g. list of posix error
> > > > > > code) when the process can continue and "allow list" those. This
> > > > > > way way too abstract. It cannot be let all possible system failures
> > > > > > pass.
> > > > >
> > > > > And it would nice if it printed out something for legit cases. Like
> > > > > "no device found" etc. And for rest it must really withdraw the whole
> > > > > process.
> > > >
> > > > IMO, it would be quite tricky to come up with an allow list. Can we
> > > > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
> > > > these are all debatable.
> > >
> > > Yes, that does sounds reasonable.
> > >
> > > About the debate. Well, it is better eagerly block and tree falls down
> > > somewhere we can consider extending the list through a fix.
> > >
> > > This all wide open is worse than a few glitches somewhere, which are
> > > trivial to fix.
> > >
> >
> > Fair enough, I would suggest we document it appropriately such that it
> > is clear to the users or somebody looking at the code.
>
> I went throught the backends on how they implement init:
>
> 1. Returns -ENODEV when it does not exist.
> 2. Calls driver_register(). Something is wrong enough if that
>    fails to rollback the whole procedure.
> 3. TPM: -ENODEV
>
> Therefore, I would keep in the existing patch since there is no weird
> uapi visible legacy behavior to support in the first place. And for
> that reason there is no good reason to have all those four POSIX rc's
> in the list.

Okay I can live with this patch as long as it doesn't break the
intended use-case.

-Sumit

>
> BR, Jarkko
>
>
