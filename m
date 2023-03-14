Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6432E6B9B97
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCNQdC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 12:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjCNQc7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 12:32:59 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C779008E
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 09:32:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5416b0ab0ecso186125737b3.6
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678811561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b85EPB17+oEFtvuVLS7pjbvgxBH7B6j5VMNkZta2dsI=;
        b=aRxhXZqxGJlYvW0/kbH4ymUQx8mnwM+MdFKi4TLnegF5PG3ylcN+ERc8VXhv/QO9eB
         j7EBNDoHKyNLm4QoHGvscMy37ZBKEs+8zDRPq56DhNdnX88Cq9SpWl36b+9hGS+M3QtV
         TB2WnDXGUh1FwFZ7hGlChkAzyR3Oakl/ltjMltcF+5rjC07tnL2Y8UpFJuTNHL9FhBhQ
         Ns+snrvvkVBwu1nKFqhVH9a2E99hYbaPT3lBaFs+LGhQ9JAI5fSYC3gM1lK1cbZai0tZ
         +0b0pzSvNkS6KLaVLkNHmZg0YAL2Rm+OErvfDNCqtTPBVjcWBAdW+VHSdCurQYeiKdWo
         F+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678811561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b85EPB17+oEFtvuVLS7pjbvgxBH7B6j5VMNkZta2dsI=;
        b=lbifIhLpKVx4YYHIYmVJh0TcHrDP/tR7VV0oAxNZm+7/34nRycGwgsXbSdyDid7m/U
         J6aalKYYNKsyUFk7YUWd8iI3DoGfa8bD4WjBiQSfuEEzQpGGvkP7DAobNweurPSxx4mS
         0BOvPrVtyjj+Dy9fJztmaFXRQQHJXnGNYwnhuBd0J5NhZX1ymo5LFNjwAu38EDDz5MCM
         y9uZAafGWu6WGlHcYnxy00FlhhYqVzApWoXFWvLR/7tauOMUJfLG35OUIvXteMRQy3Vi
         nLkLJQdBnanrjj+AqnVq4BzM8AHIVozZcEYgdoIM+g/tU0dtlakkEu7rnNK9IIi/e0XM
         goYA==
X-Gm-Message-State: AO0yUKU7GR9K3S7UUaGma1Qbq9we9Jqvi5ziSuFIX/CABt1dvc4mpohC
        Ko2g5Lnkd0CHCyKRv8cnohEfHI2k9Al+cbr1t0f9
X-Google-Smtp-Source: AK7set9jXAnKEIerlCQTH/fhrcZasdDtAc6VU4b20coSWiHPjprD1U1EHV3TBe1B3goWwNCo9Cs22k94pipz/rRtQkY=
X-Received: by 2002:a81:4424:0:b0:536:3c2c:bf5e with SMTP id
 r36-20020a814424000000b005363c2cbf5emr25366437ywa.8.1678811560787; Tue, 14
 Mar 2023 09:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230310192614.GA528@domac.alu.hr> <CAHC9VhSzppHevG_Td+hKU4KRSDgV_NYf2RSeKA06PR-rD+dJLw@mail.gmail.com>
 <c1c1cbcc-10b6-de3f-81e8-78e6b173d46f@alu.unizg.hr> <CAHC9VhRFQtqTZku==BkW0uz1oZgG63j15GoQD1iexW4aPoAPcA@mail.gmail.com>
 <ZA7tyrscjwavzY3a@smile.fi.intel.com> <CAHC9VhTMoCAFhaa36Bq7_jiKGiaeMbYTuWv7tTQP1OHpY0EUsg@mail.gmail.com>
 <ZBBU9diKqetWQztO@smile.fi.intel.com>
In-Reply-To: <ZBBU9diKqetWQztO@smile.fi.intel.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Mar 2023 12:32:30 -0400
Message-ID: <CAHC9VhTenpSXwvorisXYWYGfx345ZOL9fOrwyhntoUFsLX_ENw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 14, 2023 at 7:05=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Mar 13, 2023 at 04:27:42PM -0400, Paul Moore wrote:
> > On Mon, Mar 13, 2023 at 5:33=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Sat, Mar 11, 2023 at 09:59:17AM -0500, Paul Moore wrote:
> > > > On Fri, Mar 10, 2023 at 5:53=E2=80=AFPM Mirsad Goran Todorovac
> > > > <mirsad.todorovac@alu.unizg.hr> wrote:
>
> ...
>
> > > > With that out of the way, I wanted to make a quick comment on the
> > > > patch itself.  Currently LSMs do not support unloading, or dynamic
> > > > loading for that matter.  There are several reasons for this, but
> > > > perhaps the most important is that in order to help meet the securi=
ty
> > > > goals for several of the LSMs they need to be present in the kernel
> > > > from the very beginning and remain until the very end.  Adding a
> > > > proper "release" method to a LSM is going to be far more complicate=
d
> > > > than what you've done with this patchset, involving a lot of
> > > > discussion both for the LSM layer itself and all of the currently
> > > > supported LSMs, and ultimately I don't believe it is something we w=
ill
> > > > want to support.
> > > >
> > > > I appreciate your desire to help, and I want to thank you for your
> > > > patch and the effort behind it, but I don't believe the kobject mem=
ory
> > > > leak you saw at kernel shutdown was a real issue (it was only "leak=
ed"
> > > > because the system was shutting down) and I'm not sure the current
> > > > behavior is something we want to change in the near future.
> > >
> > > Currently the security module so secure that even adds an unneeded no=
ise to
> > > the debugging output.
> > >
> > > At very least it would be nice to add a stub and put a big comment
> > > (on your taste) explaining why we do not do anything there.
> > >
> > > Agree?
> >
> > No.
>
> Are you sure? I'm proposing to add a stub which is no-op, but with a comm=
ent
> inside explaining why. In such case we:
>
> 1) shut the kobject infra up;
> 2) keep the status quo in LSM;
> 3) put in the code a good explanation for others on what's going on.
>
> > At least not without a lot of additional work beyond what was
> > presented in this patchset.  What about all of the other kobject
> > caches created by other LSMs, this is more than just the IMA
> > iint_cache.  I'm also skeptical that this patchset was ever tested and
> > verified as the newly added release() method was never actually called
> > from anywhere that I could see.
>
> I'm not talking about this patchset, but you are right that it wasn't
> tested.
>
> > I think we would need to see a proper, verified fix before I could say
> > for certain.
>
> And continuing to spread the noise in the logs just because LSM is stubbo=
rn?
>
> > If you want to discuss potential designs, we can do that
> > too, but please remember the constraints that were already mentioned
> > about intentionally not allowing the LSMs to be unloaded (prior to
> > system shutdown).
> >
> > I don't know the answer to this, but I'm guessing the LSMs aren't the
> > only kernel subsystems to "leak" memory on system shutdown; working on
> > the assumption that this is the case, how are those "leaked"
> > allocations handled?
>
> Note, I'm full for the proper fix, but the current issue is logs flooding=
 done
> by LSM that needs to be addressed.

If you want to introduce a change to add a release method, do it
properly so it does the right thing for all the LSMs and not just the
one you happen to care about at this moment.  If you don't do the
change properly it means I'm going to have to complete the work and
I've got more important things relating to the LSM that need my
attention.

--=20
paul-moore.com
