Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27946B82BA
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Mar 2023 21:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCMU2l (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Mar 2023 16:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjCMU2j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Mar 2023 16:28:39 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0A28B337
        for <linux-integrity@vger.kernel.org>; Mon, 13 Mar 2023 13:27:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id e65so4604370ybh.10
        for <linux-integrity@vger.kernel.org>; Mon, 13 Mar 2023 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678739273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFnxh6ChwFpFm5r6DaepAUcIfT7/Tx7g2a94eMxrXFM=;
        b=gixUeT4Ubigv+gUryvD1n8kXhVuY6FIFBf8gg4I7hdEB5cz0ej/6HVI4XQXVUFbqHu
         Md2v534oXJ5kUonyMVSwW6G+UiHQZ1l7WWkB3FcnpcFUpWlqV9Lz9GQAcPW6rHI06dqv
         5guJ9aHDXhUq3vcvdWKETFKP1Uk0rDckcCR3prsdIEwRB6QjCVCvDp08XZQ0TAGZAxdc
         ry3KXn9w9lG+tv8gAMQf3hrLraK4M1naV8n8Zw99xYqLrfvAOECHLge7mUSMBUHft02A
         m4I1Lzb+1yrEewh0+XQmcUlesZDHUvdtoDKSymWhsEzW6lR4dx+a3cm5r1rlwZoDrPKf
         CE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678739273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFnxh6ChwFpFm5r6DaepAUcIfT7/Tx7g2a94eMxrXFM=;
        b=Sc+ITd7MO1aoVenCXxqDzNXO93UC1tFFfbxESp10J0ij4BoVw6vIP9zYdcWjcq+ft6
         wGbJUGGMRZy8JwMfF4rfyhDNwc4WRzKcpPq95mgf3Je5t5Nx4HNWHFU2sHMg4lBByd5J
         TlC3pHUoJvrTtd8Oya++j4kKfQkzUBVJLCFB9ZKCueL3G12mg4nHbB9TIrBWg3dIZUcl
         sLu5mbdq1+fgoz2IeSHcx0d6Byjh/HxAwo0gq8qvho+GTo2+YTiCRV0lmRwEPjOG0wnc
         g0WU52aBFnPuJG63MQ5T4wx9S+1jIzq9jPTkvTW1ZNFfD/qr6mdGXNTYobEW6fDrA60d
         XhtQ==
X-Gm-Message-State: AO0yUKWultHc6VvjmD+aEVsqfzfqeyuM5u7f7ZQafKcbz/OZolZN/nja
        25bM3hNxETlDjkjbE0oVLva5vhhVHXKs4caqEfPK
X-Google-Smtp-Source: AK7set/I0y9ItLKYj2Yw/npMPux8FEEhdrk4Zeo1yP8Tu8wlBFXVCN12SYX3+ZYI4S6xcsXkyCtr2vJKznbvJX29hYU=
X-Received: by 2002:a5b:40e:0:b0:ac2:ffe:9cc9 with SMTP id m14-20020a5b040e000000b00ac20ffe9cc9mr22178487ybp.3.1678739273093;
 Mon, 13 Mar 2023 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr> <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr> <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
 <ZA7tyrscjwavzY3a@smile.fi.intel.com>
In-Reply-To: <ZA7tyrscjwavzY3a@smile.fi.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Mar 2023 16:27:42 -0400
Message-ID: <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Mar 13, 2023 at 5:33=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> > On Fri, Mar 10, 2023 at 5:53=E2=80=AFPM Mirsad Goran Todorovac
> > <mirsad.todorovac@alu.unizg.hr> wrote:
>
> ...
>
> > With that out of the way, I wanted to make a quick comment on the
> > patch itself.  Currently LSMs do not support unloading, or dynamic
> > loading for that matter.  There are several reasons for this, but
> > perhaps the most important is that in order to help meet the security
> > goals for several of the LSMs they need to be present in the kernel
> > from the very beginning and remain until the very end.  Adding a
> > proper "release" method to a LSM is going to be far more complicated
> > than what you've done with this patchset, involving a lot of
> > discussion both for the LSM layer itself and all of the currently
> > supported LSMs, and ultimately I don't believe it is something we will
> > want to support.
> >
> > I appreciate your desire to help, and I want to thank you for your
> > patch and the effort behind it, but I don't believe the kobject memory
> > leak you saw at kernel shutdown was a real issue (it was only "leaked"
> > because the system was shutting down) and I'm not sure the current
> > behavior is something we want to change in the near future.
>
> Currently the security module so secure that even adds an unneeded noise =
to
> the debugging output.
>
> At very least it would be nice to add a stub and put a big comment
> (on your taste) explaining why we do not do anything there.
>
> Agree?

No.  At least not without a lot of additional work beyond what was
presented in this patchset.  What about all of the other kobject
caches created by other LSMs, this is more than just the IMA
iint_cache.  I'm also skeptical that this patchset was ever tested and
verified as the newly added release() method was never actually called
from anywhere that I could see.

I think we would need to see a proper, verified fix before I could say
for certain.  If you want to discuss potential designs, we can do that
too, but please remember the constraints that were already mentioned
about intentionally not allowing the LSMs to be unloaded (prior to
system shutdown).

I don't know the answer to this, but I'm guessing the LSMs aren't the
only kernel subsystems to "leak" memory on system shutdown; working on
the assumption that this is the case, how are those "leaked"
allocations handled?

--
paul-moore.com
