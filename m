Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2724E664598
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jan 2023 17:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjAJQHm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Jan 2023 11:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjAJQHV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Jan 2023 11:07:21 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7C5BA04;
        Tue, 10 Jan 2023 08:07:19 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id i185so12752156vsc.6;
        Tue, 10 Jan 2023 08:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7lBJtTBxnALC6grjQqf4FSHZfr4Mitb99+GWM0e9uhs=;
        b=Vsrprx/YTNYgXI7V82WQOnEvBW/BbUlySs6Pjd6MQNVVl8PBHfRf1SczZQlFmAgiiG
         ptpWKqXrwxohyPm9Y89UQEaqCTV97L5ZUAoK/q+rvqf3XoozqsSP2LKJeGibSBD8vuzQ
         HtwmOxlpQn1NafGtCH/+JIZFZVVbFwW9Mr649+7yvEcgFBgz6S9I6c9PVJuam2CqaOI9
         moI9bujuwgSs97sWkmNZGB43muGiRQS4gUBrf+51OPk8yZx1Hu6tGkhU96TPh6vlF3sw
         32H2CYiaVi3g/0UE7v6b7zdQq6Xzqvc7cFmXdi7N0g7x9AzlnU4cyjzJ3IQVsVex+Rm5
         t4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lBJtTBxnALC6grjQqf4FSHZfr4Mitb99+GWM0e9uhs=;
        b=10UyVi96Pi1yNfpTvmz+PezBy/kX9kST32lDjsKyLSBDWQ0W47TOfA5ZIfo+SwgW/z
         GQY32WFo1lWyGSgnD4c7zhHG6AYxKMFGGoErvPBlClO9eC89foSAPXoYOKigGz+M61Ao
         kA/oqRQ5DVx5K6V2DZxW984j1u0Zml3vrI+Bqnd1CRcfTUdkUuHHFA/vR0spJ/HXRTYG
         NCyPLV/7munjcZ7+0m/tZO8Jk/4JmZwxDhkg+IjZDZpes5YCIataUvj60zBrzl3BFvBm
         Jp4fibRfi+HNIVR2OrnXtUNrrtuYc+RQJNH1f+IpTU+QJvSjXHG+56o1mH5bzgSzhCoD
         j5og==
X-Gm-Message-State: AFqh2kpoXgXfqfGOAwfLp68ARBr4FSwy2r1R0eetzPTd+jxyvtM/+NX7
        djzXMxOrU7gQEmgJTlbytPm7h42J0DrHkyezb3lYy2eQ
X-Google-Smtp-Source: AMrXdXt+VFH/EwMwIYRX13+37qAkug1uWDPlom227tSOY5cIPsVKnrVStSUyDp81LqjUZ7aMLi0tiVQOPKd/FnryqQ4=
X-Received: by 2002:a05:6102:55a6:b0:3b5:35ee:814f with SMTP id
 dc38-20020a05610255a600b003b535ee814fmr10332248vsb.21.1673366838083; Tue, 10
 Jan 2023 08:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com> <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
In-Reply-To: <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 10 Jan 2023 10:07:06 -0600
Message-ID: <CAFftDdp5vqnzJEqAYOStvn2UqDE_VUOrO-_tnsUCmd7ML8X_uA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     Matthew Garrett <mgarrett@aurora.tech>
Cc:     jejb@linux.ibm.com, Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 3, 2023 at 2:43 PM Matthew Garrett <mgarrett@aurora.tech> wrote:
>
> On Mon, Nov 14, 2022 at 9:11 AM James Bottomley <jejb@linux.ibm.com> wrote:
> >
> > On Fri, 2022-11-11 at 15:16 -0800, Evan Green wrote:
> > > Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> > > restricts usermode's ability to extend or reset PCR 23.
> >
> > Could I re ask the question here that I asked of Matthew's patch set:
> >
> > https://lore.kernel.org/all/b0c4980c8fad14115daa3040979c52f07f7fbe2c.camel@linux.ibm.com/
> >
> > Which was could we use an NVRAM index in the TPM instead of a PCR?  The
> > reason for asking was that PCRs are rather precious and might get more
> > so now that Lennart has some grand scheme for using more of them in his
> > unified boot project.  Matthew promised to play with the idea but never
> > got back to the patch set to say whether he investigated this or not.
>
> Is there any way to get key creation data to include NV indexes? If
> not, no, we can't use NVRAM.

No theirs not, but there's room for qualifyingData. So some background
on this is they use the PCR value to verify it's the right key.
Since it's added by the TPM within the trust boundary its an
unforgeable value, unlike the qdata.

I think there are better ways to verify it's the right key, i.e. the
ability to wield the key, or if you have some ability to remember
state, you
could verify the name which is cryptgraphically bound to the private
key and thus TPM2_Load will fail. From what I understand they
have no ability to remember state as their verifying and executing a
resume kernel, but I am not well versed in that area of the kernel.
It makes me think that they are checking against a hardcoded known
PCR23 state and rolling it to prevent other keys from being
generated. I would consider policy locality for controlling who can
use the key and couple with policynv if revoking long lasting keys
is a need. If they are ephemeral, theirs the NULL hierarchy.

A lot of this is conjecture, as Matthew just stopped responding.
Perhaps they are away or busy, but I just wanted to weigh in on this.
