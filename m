Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE435D75D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Apr 2021 07:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhDMFmk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Apr 2021 01:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbhDMFmh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Apr 2021 01:42:37 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FDFC061756
        for <linux-integrity@vger.kernel.org>; Mon, 12 Apr 2021 22:42:17 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x13so15216156lfr.2
        for <linux-integrity@vger.kernel.org>; Mon, 12 Apr 2021 22:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MITjT2ay51KOcdM71HVFO+ySm3JooSqiJI3Cb7Ri/aQ=;
        b=on4KYu7s8YlB0xwBDXTiFFbdyzkvcU7IAPfyGWXq5powKidROTOJGmYgHpqcw41WBk
         LKpnOH6b+gid2kUOFlDS9dLSbLUnXOhlFRgMmQBNx+hlvAIRZtZ07ga9CeO/UbifKU1F
         k7bY/jo0BhF5LCfDddP8BLCX368gJlErfsjpgCrp3qE9NdnNmtf2G+6Eg2SdPpJoGmtF
         IIkg9jc4Me4BMMIgM5CJEzPfYIECwFOi2unjFtYwX2tBiRT7FxVTQv2i2lnTZqAD00ZB
         plosOla9KJY3ZZTEUXfgwMTXbWAQ2jUh9L3av/iP1JtGxs75TTJ+qEV2j1rvPxBSr0vi
         ytpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MITjT2ay51KOcdM71HVFO+ySm3JooSqiJI3Cb7Ri/aQ=;
        b=pUSFPREFmjUtF489M9ciG//A7ZuncnrCYlYdzYFj5sVe+5V1BMXQ5m4Irx8/+jum1U
         utdPRW3GTkAGk/fgeaUV84y0qXQia56KnHWnSg/YCE2Tq+TfDeXH5MVOJCevCdgkKRUI
         AVaNSY5dqAth/nP82Hl6yk3F7yzRyTjMQFQUpmz+0pLC6KNqDa1btHotiUTmuIpzGOBw
         CXQswqEa+9AuXQ+2oQimiHHNzSwgDRAf3bwpHarrYbLAQIW08QFxWeL5Oytt6jf/1jKE
         WpejwY0eZJ1ZWWy8idPmWupXUrqDczczi65JbrtLPInjwLAnOmXiRFwGODEIPJaEZG6V
         G44w==
X-Gm-Message-State: AOAM532nIOVdv2s0oMzSkvSY/Fru21XV3W88QU3x8oz4rkWz6DW75K5L
        kcelD/1uyJ0urAaUK5cW4gATcntGvFf8r/PMzNExow==
X-Google-Smtp-Source: ABdhPJyMKOQIyeojpXPuo0SSdzWliMMkGmlkNBcznqsQM2TOrLpFA1+nvOPmwAotZazrF73OIccOTqzdFp3YLO7vuwY=
X-Received: by 2002:a05:6512:3c8e:: with SMTP id h14mr3031818lfv.113.1618292535723;
 Mon, 12 Apr 2021 22:42:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210412160101.1627882-1-colin.king@canonical.com>
 <adeb7c73d0bb354f04f8117c5ccf6b006dfc15de.camel@linux.ibm.com> <53fef8cf-0dd4-e4fe-260b-0f5ad25d9014@canonical.com>
In-Reply-To: <53fef8cf-0dd4-e4fe-260b-0f5ad25d9014@canonical.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 13 Apr 2021 11:12:04 +0530
Message-ID: <CAFA6WYPt97daNPQ+tWpFunTK77Q-vP=sdya7k+bUEJ9YHDq-Jg@mail.gmail.com>
Subject: Re: [PATCH][next] KEYS: trusted: Fix missing null return from kzalloc call
To:     Colin Ian King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 12 Apr 2021 at 22:34, Colin Ian King <colin.king@canonical.com> wrote:
>
> On 12/04/2021 17:48, James Bottomley wrote:
> > On Mon, 2021-04-12 at 17:01 +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The kzalloc call can return null with the GFP_KERNEL flag so
> >> add a null check and exit via a new error exit label. Use the
> >> same exit error label for another error path too.
> >>
> >> Addresses-Coverity: ("Dereference null return value")
> >> Fixes: 830027e2cb55 ("KEYS: trusted: Add generic trusted keys
> >> framework")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  security/keys/trusted-keys/trusted_core.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/security/keys/trusted-keys/trusted_core.c
> >> b/security/keys/trusted-keys/trusted_core.c
> >> index ec3a066a4b42..90774793f0b1 100644
> >> --- a/security/keys/trusted-keys/trusted_core.c
> >> +++ b/security/keys/trusted-keys/trusted_core.c
> >> @@ -116,11 +116,13 @@ static struct trusted_key_payload
> >> *trusted_payload_alloc(struct key *key)
> >>
> >>      ret = key_payload_reserve(key, sizeof(*p));
> >>      if (ret < 0)
> >> -            return p;
> >> +            goto err;
> >>      p = kzalloc(sizeof(*p), GFP_KERNEL);
> >> +    if (!p)
> >> +            goto err;
> >>
> >>      p->migratable = migratable;
> >> -
> >> +err:
> >>      return p;
> >
> > This is clearly a code migration bug in
> >
> > commit 251c85bd106099e6f388a89e88e12d14de2c9cda
> > Author: Sumit Garg <sumit.garg@linaro.org>
> > Date:   Mon Mar 1 18:41:24 2021 +0530
> >
> >     KEYS: trusted: Add generic trusted keys framework
> >
> > Which has for addition to trusted_core.c:
> >
> > +static struct trusted_key_payload *trusted_payload_alloc(struct key
> > *key)
> > +{
> > +       struct trusted_key_payload *p = NULL;
> > +       int ret;
> > +
> > +       ret = key_payload_reserve(key, sizeof(*p));
> > +       if (ret < 0)
> > +               return p;
> > +       p = kzalloc(sizeof(*p), GFP_KERNEL);
> > +
> > +       p->migratable = migratable;
> > +
> > +       return p;
> > +}
> >
> > And for trusted_tpm1.c:
> >
> > -static struct trusted_key_payload *trusted_payload_alloc(struct key
> > *key)
> > -{
> > -       struct trusted_key_payload *p = NULL;
> > -       int ret;
> > -
> > -       ret = key_payload_reserve(key, sizeof *p);
> > -       if (ret < 0)
> > -               return p;
> > -       p = kzalloc(sizeof *p, GFP_KERNEL);
> > -       if (p)
> > -               p->migratable = 1; /* migratable by default */
> > -       return p;
> > -}
> >
> > The trusted_tpm1.c code was correct and we got this bug introduced by
> > what should have been a simple cut and paste ... how did that happen?

It was a little more than just cut and paste where I did generalized
"migratable" flag to be provided by the corresponding trust source's
ops struct.

> > And therefore, how safe is the rest of the extraction into
> > trusted_core.c?
> >
>
> fortunately it gets caught by static analysis, but it does make me also
> concerned about what else has changed and how this gets through review.
>

I agree that extraction into trusted_core.c was a complex change but
this patch has been up for review for almost 2 years [1]. And
extensive testing can't catch this sort of bug as allocation wouldn't
normally fail.

[1] https://lwn.net/Articles/795416/

-Sumit

> > James
> >
> >
>
