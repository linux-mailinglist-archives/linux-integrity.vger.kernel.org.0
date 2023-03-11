Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D0B6B5D18
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 16:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCKO7g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjCKO7e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 09:59:34 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C9F31F0
        for <linux-integrity@vger.kernel.org>; Sat, 11 Mar 2023 06:59:29 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-53916ab0c6bso156406007b3.7
        for <linux-integrity@vger.kernel.org>; Sat, 11 Mar 2023 06:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678546768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hP9f5ahD00gGd8rqkmyWxcLZVI5nl4ZoNtez5PA0r4=;
        b=PkUwoTwpZa3+W0h9YKjj42q47zdeK1CMRi+tRAQYRbwSYvvgX+PNs76C1XJj7WPTwS
         JNEIlZSuQA6b7FhqDp37dUJZR/GPShawVww3y3w3s60Rhj+eAxtZG3aZDBtjYRtA9zhP
         VTg1uCJtgAE59bZwp4kuHgdEIDIiaeq2VQXZ+wv3r1DiWssC4ntBhpQMarf47MxTzkEm
         y8f6RYMryhP39ECfBmqvSuCwcpwlMeHFHDZhE1IvJF/bqMSl8yWCvX4H63WDhl+fs5ZQ
         kLiuMQVJ5Aqcd1V9gYTmgVm4pEXjoer3Lo335C4QXCJyt3qqs+B2zZCEsx8Zy7JKOzVA
         8RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678546768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hP9f5ahD00gGd8rqkmyWxcLZVI5nl4ZoNtez5PA0r4=;
        b=ZRWCQrO9x4TBeURl9/9KbYvBUxJjwyE4OvTH8/ufWf3bMpA+j2oMkVCvtwU0sZvk5B
         9h6sLzOMjN9EwwtBG4riMgJvrNbHLd4tMh8UrsSvnDhs4HlNybBKhwnNJVigdprJjqMk
         0o1yPUnz2RKVootrJRKHC1MvL4SMC5rBeE8s2ikA2hcyqEXTNPtbvtrJGkiictfRacnM
         /Gzfr1obM1w3YA4WpAmzzn6mGEkuGCRovCRs9rIKDTmfA2CyVH0ihqdLYXJ/2Rnk9CxB
         nFrPKpcFbpNjtRMuft5Bl381K6kFgNR8Rz52frOPrgV3fzMrXCxnzgkolnVT38qm1Fph
         FUjw==
X-Gm-Message-State: AO0yUKUsyCjs/AF5EXXiWMGfqRUAs7y+7IK8iA8Z5sQ2N+SEXd96SkLB
        aTe/ghX3zUo4laCSDVAv6oZ7AIrsASJfo40MECIU
X-Google-Smtp-Source: AK7set81IOjSWwCoFQC0qeCyY/b34lVXphnKYgtEMgSkuNEAjDbexPT2fTgfLBBQH+V/2egtIg2cwLUOvhKErZY5p2k=
X-Received: by 2002:a81:ac28:0:b0:536:55e5:2eaa with SMTP id
 k40-20020a81ac28000000b0053655e52eaamr18718463ywh.3.1678546768643; Sat, 11
 Mar 2023 06:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr> <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
In-Reply-To: <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 11 Mar 2023 09:59:17 -0500
Message-ID: <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 10, 2023 at 5:53=E2=80=AFPM Mirsad Goran Todorovac
<mirsad.todorovac@alu.unizg.hr> wrote:
> On 10. 03. 2023. 23:33, Paul Moore wrote:
> > On Fri, Mar 10, 2023 at 2:26=E2=80=AFPM Mirsad Goran Todorovac
> > <mirsad.goran.todorovac@alu.hr> wrote:
> >>
> >> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o =
a proper
> >> kmem_cache_destroy() destructor.
> >>
> >> Introducing the release() hook would enable LSMs to release allocated =
resources
> >> on exit, and in proper order, rather than dying all together with kern=
el shutdown
> >> in an undefined order.
> >>
> >> Thanks,
> >>         Mirsad
> >>
> >> ---
> >>  include/linux/lsm_hooks.h | 1 +
> >>  security/integrity/iint.c | 7 +++++++
> >>  2 files changed, 8 insertions(+)
> >
> > I only see the 1/2 patch, did you send the 2/2 patch to the LSM list?
> > If not, you need to do that
>
> I will resend everything, because this first attempt was buggy and
> incorrect regarding the credits. Will try this, Andy said that I wait
> for the comments, but I did not expect them before the weekend.
>
> Thank you guys for patience, I am just finishing the test of devres
> patch and then I will proceed with integrity LSM patch submission.

Thank you for resending the patchset, although a couple of
administrative things to consider for your next posting:

* Each time you post a patchset it is generally considered a best
practice to increment the version number, e.g. "[PATCH vX 0/2]" with
'X' being the version number.  This makes it easier to identify
specific revisions and ensure that everyone is reviewing the latest
patchset.

* It is a good idea to use the "./scripts/get_maintainer.pl" script to
ensure you have included the right people and mailing lists on your
submissions as your latest resend did not include the LSM list when it
should have.

With that out of the way, I wanted to make a quick comment on the
patch itself.  Currently LSMs do not support unloading, or dynamic
loading for that matter.  There are several reasons for this, but
perhaps the most important is that in order to help meet the security
goals for several of the LSMs they need to be present in the kernel
from the very beginning and remain until the very end.  Adding a
proper "release" method to a LSM is going to be far more complicated
than what you've done with this patchset, involving a lot of
discussion both for the LSM layer itself and all of the currently
supported LSMs, and ultimately I don't believe it is something we will
want to support.

I appreciate your desire to help, and I want to thank you for your
patch and the effort behind it, but I don't believe the kobject memory
leak you saw at kernel shutdown was a real issue (it was only "leaked"
because the system was shutting down) and I'm not sure the current
behavior is something we want to change in the near future.

--
paul-moore.com
