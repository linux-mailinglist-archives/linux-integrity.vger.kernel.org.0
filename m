Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25961EB791
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2020 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgFBIkx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jun 2020 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBIkw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jun 2020 04:40:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A08C08C5C1
        for <linux-integrity@vger.kernel.org>; Tue,  2 Jun 2020 01:40:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u10so10327638ljj.9
        for <linux-integrity@vger.kernel.org>; Tue, 02 Jun 2020 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ba7tS1EJd6J4rrFJlCgFQCMg5mXZk8lm0TUhKeqkFLg=;
        b=DaRRRUXPe+h4lT7HKYjlwOZPLtpKjj5wrJfc7A/FfABHr7pqA6sBVcDxFpYhyNGX2f
         mhQciVg9mJcl5lbwYvIUHYTLOz+H/JseFNTfhgEH1PUTCmGJfi2vmR2tmRbnXSyFTDE4
         w4eCcHJwLE+Jelj9ifdDTlnu0lIKZx10kGWKP+LOH+aLlwER7WRXA5g20mnYOxnaNwWm
         3M56FsBpyAAfxXgbKJti+9pbhLY8t86m4/VdbDv6kUVoyahF+iMYkTHJDo4u8M+83rUy
         MafhdMblZid34Foa6n+p2WuWVyEuwMjkPZdBGHlFOS0Ezjf8cSGe7D1etislzBDLC4++
         g6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ba7tS1EJd6J4rrFJlCgFQCMg5mXZk8lm0TUhKeqkFLg=;
        b=Grh0klCshXIlUM5DhU03pC265tsmTfTiddNgtSWRwpUnH9LxwrAUC1H716kCfWBwCj
         +XujlhDoXUrZsc4XR13MHB1GykgeMXsPHrhJ5sFiQ175QEZlTlopck607aXlv4rlzgtG
         LrzLQVcLIk36rR6V7DdFn6KfejmYuc/d0EM4oz6HcVf2zLmBqXAjSPDSLN1X/8WdYNma
         a6bTn2SElMMGH2Oic1N6U5F22q/vL+u+n9eOJIgZ64cyHeA4MjW89be65zwnIhsh8voh
         UbIOtLGqPp5JJvG9L5AelEpr2y+BH2PE+IlS2na5yQ7WuzTEa5rkKt3USPDUKaAjuoAt
         8Bdg==
X-Gm-Message-State: AOAM5321PdKfUJaRiLRe7i+YBoE/FCJ2135ETdUp4gEz0sSaF3OmRfOL
        mMEuMGzRhm2B4plSZJLt7S7taxTjg3b1252gZzBPng==
X-Google-Smtp-Source: ABdhPJxsrkSYKmMolrGDzGBzVUCmpV4Czal5MWGq3rA63F0c5cGNbbd8XSdXd5KOBCD+j1AK6KQkyAzoPLSK90Osl+U=
X-Received: by 2002:a2e:81c5:: with SMTP id s5mr11803430ljg.372.1591087248899;
 Tue, 02 Jun 2020 01:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <1588758017-30426-1-git-send-email-sumit.garg@linaro.org>
 <1588758017-30426-2-git-send-email-sumit.garg@linaro.org> <20200601021132.GA796225@linux.intel.com>
 <CAFA6WYP55W2xKtjHWWwu6Pbqy2TGY=eymwAoXxQh-5mF8deR6A@mail.gmail.com> <20200602071407.GB16602@linux.intel.com>
In-Reply-To: <20200602071407.GB16602@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 2 Jun 2020 14:10:37 +0530
Message-ID: <CAFA6WYOVho3sAO=ABaeO3CGw-DfWuGOE9H_D48pCwAq0+VX9Qw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <jejb@linux.ibm.com>, dhowells@redhat.com,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2 Jun 2020 at 12:44, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, Jun 01, 2020 at 02:41:55PM +0530, Sumit Garg wrote:
> > > This, I think is wrong. You should have a compile time flag for TPM e.g.
> > > CONFIG_TRUSTED_TPM, not this dynamic mess.
> > >
> >
> > The whole idea to have it dynamic was to have a common trusted keys
> > module which could support both TPM and TEE implementation depending
> > on hardware. I guess it may be useful in scenarios where a particular
> > hardware supports a TPM chip while other doesn't but both need to run
> > a common kernel image.
>
> For now it should only scale to what is needed. No problems refining
> it later when there is something to enable.
>

Fair enough, will switch to compile time mode then.

-Sumit

> /Jarkko
