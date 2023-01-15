Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C69466B193
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Jan 2023 15:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjAOOly (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 15 Jan 2023 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjAOOly (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 15 Jan 2023 09:41:54 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC201258E;
        Sun, 15 Jan 2023 06:41:53 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id v127so22377704vsb.12;
        Sun, 15 Jan 2023 06:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKRXr+WXrA/dL1K0gomkMRErU+ynIR4YAhv6r9tMF9E=;
        b=Epey5OmKyMV6pdasJF5nWoBZ0HGriVSB3rNH+Qe3l81/QR+Hn0Y8qdrx/S2W0MM0cB
         MfFsTJrZZdgjpzzory/7vMpsSbC5iPSrIFZwJcKw77Tyn+d/729Lthn2XngwtQ3WHJDm
         yeaRCZf5k3TkfBC35jdz0O345F6SxGJUPfJ7Sj03w8illfbhI9ZWYRzXBSJyRl/E2oB/
         yex8iZljXao0O7Oaio+/J3F0iRjyhF92V2fGCdiSKboHsxhTVvxIlbjfmLpR3UIVDJ1v
         13WWwLH5X0zO2jqY0wEK09Af3Y4vpDnlTMvhr14x0KTABRF9xODbay8Phk3SKz44u/I8
         l27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKRXr+WXrA/dL1K0gomkMRErU+ynIR4YAhv6r9tMF9E=;
        b=mCNhf9jZaxQmtcJpmh8LgvqICOhSc5S47ntgR+l2jLSj1VchwHv9UQREL21OPw8EYR
         43ijFZusO6uXqcJcSqYPSMnSkhtvuVSy4xw7I42tEonX7I+LKdWg0BnQ5J1CM/dremR+
         DTvEKw7cvTbFhATkcMe7Uo4IUopzajx/QJwYV7I4sLSsvURCVxQURuRW1Gr/Rk9+yu/9
         BQhTjpSe/n+AK8+lsCYBGB2JcYTZtnXHZHJOLe5DYhkLMMW0ItIc+X3p87/x9gtfzKGX
         qbL+oWAO25uANh5z5ckhqcLtIq7zyPs0rDmcrXhafP8yw+XKWw5Si4rCs5+DQWM821Ht
         p8VQ==
X-Gm-Message-State: AFqh2krO6WQxuJFZqVAyf0BXkS4qu7RDeRGDQYYDdgf0D5Y/GkTWqXrU
        jgZhEMRjE3s1fRDouuirgzDFBGp5arfY07SaBfY=
X-Google-Smtp-Source: AMrXdXsxpSdGaiA4L/vixK7taV2LSGUy7wESiesQ9ao9FbsrSM8r+EXws52J/xETSjmjax7A3sAf7biUGwD9y5CHSOE=
X-Received: by 2002:a05:6102:34d3:b0:3d2:3863:6363 with SMTP id
 a19-20020a05610234d300b003d238636363mr489520vst.47.1673793712344; Sun, 15 Jan
 2023 06:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com>
 <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com> <CAHSSk058UoBY2nDx8U7-siG_dbjNSKZaPukZVjSnq=f=CBSKsw@mail.gmail.com>
In-Reply-To: <CAHSSk058UoBY2nDx8U7-siG_dbjNSKZaPukZVjSnq=f=CBSKsw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Sun, 15 Jan 2023 08:41:41 -0600
Message-ID: <CAFftDdooms8AfKRhp3N8G7roCQUaV3CHayeF14gXVqoK3PeTwA@mail.gmail.com>
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

On Sat, Jan 14, 2023 at 9:05 PM Matthew Garrett <mgarrett@aurora.tech> wrote:
>
> On Sat, Jan 14, 2023 at 6:55 AM James Bottomley <jejb@linux.ibm.com> wrote:
> > Can we go back again to why you can't use locality?  It's exactly
> > designed for this since locality is part of creation data.  Currently
> > everything only uses locality 0, so it's impossible for anyone on Linux
> > to produce a key with anything other than 0 in the creation data for
> > locality.  However, the dynamic launch people are proposing that the
> > Kernel should use Locality 2 for all its operations, which would allow
> > you to distinguish a key created by the kernel from one created by a
> > user by locality.
> >
> > I think the previous objection was that not all TPMs implement
> > locality, but then not all laptops have TPMs either, so if you ever
> > come across one which has a TPM but no locality, it's in a very similar
> > security boat to one which has no TPM.
>
> It's not a question of TPM support, it's a question of platform
> support. Intel chipsets that don't support TXT simply don't forward
> requests with non-0 locality. Every Windows-sticker laptop since 2014
> has shipped with a TPM, but the number that ship with TXT support is a
> very small percentage of that. I agree that locality is the obvious
> solution for a whole bunch of problems, but it's just not usable in
> the generic case.

Instead of walling off a PCR, why not wall off an NV Index PCR and
use a policy?
