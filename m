Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5978F23B
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjHaR5I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbjHaR5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 13:57:07 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B49ACC
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 10:57:04 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a8506f5b73so674130b6e.0
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693504623; x=1694109423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Vw7y/sATNYmg+CnDBRVlhC4jceuaKp59KaohI9L20c=;
        b=C1kSYkie1WNwOs1kmU9bE+B3xZn4knPE9B7NbZnggBemg19WttP+NaKxYhkw/mNwUY
         PgcSSoaALtxIFpA8BpteUWVGQ+rsQ4FNB1r8JSRPI0P2NUGlBWCEXxXleJdAWWo+Zw1C
         hJD2vH03E+U1coICmCTdyEZLZ4q+6pe9AKXmXYmN0TSRe/7Fmy9FFyMlveMZx+i0rOHw
         e/z8E0PduEdaMdQkZMs5zS5zgspvTphusJyJ/qAlb2NJZTmahs7uGPJsviDpKtMZ/BoV
         /t1F+gJn8JrjAuAQMqup4QjUTvVpzULcL7EULDspbCLvztd6l/GBESXSP+5lKheS/FhD
         r5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504623; x=1694109423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vw7y/sATNYmg+CnDBRVlhC4jceuaKp59KaohI9L20c=;
        b=JMOSk2v+K329KeBvP1Z6HJI8K8bfWfx66wpAn8ndy0RpsTuJJR5JbVB22ozjDi+lYU
         oUNWqP650Wm0FtkZR1MmzNtvqjD3+LW5KtZ6a4sAzQRGK797j3O/KspXWzfj9Ys+Riad
         CVbdEsJNlVOXDSmPJ9KrPoUcBpK49KzywIajw6DdZevbN6WNpf+gGb2hdA8h3+PKZyM6
         Oz/ySa3TM31j4BZ4p3kWh9GxCMbL14J8KQdk3u+r4LzjxaErwS5gcBLcn7zhIOEIschT
         616skD7YvEkIgCVftO2jlfsQIwFvomz8vF9ZGfm6KqZdDDLgV7eohmWOGuhqpP6Hs6ng
         jaPw==
X-Gm-Message-State: AOJu0Yy2dX55j98BG6MtrTPpT3SPTVFO5T99sQTxqpMj43t3Y3Z2E24o
        i1p+tQgvxsnf6AIOGJ7j/kuq949qp/04xyl313RG
X-Google-Smtp-Source: AGHT+IGr70igKt/tEaJygcDeix/HwaHPsscAUhwqEcG8R2uSt7r9yy6+xjVuFSLpUh3ychzJ8C8yTqcJfidLivEII/4=
X-Received: by 2002:a05:6808:9bb:b0:3a7:2621:2daf with SMTP id
 e27-20020a05680809bb00b003a726212dafmr216996oig.42.1693504623564; Thu, 31 Aug
 2023 10:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
 <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
 <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
 <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
 <CAHC9VhStr3BAzb3tyHzHVPXzzuxyXjPQ4vmi+SrJqbTWio04+Q@mail.gmail.com>
 <2d800c3c0b6b4908843b490c36ef9df0cb4da134.camel@linux.ibm.com>
 <CAHC9VhSRepx+Q5pwhD3+AYPLXJAeL84FykLDnABfAwCUWXaWJA@mail.gmail.com>
 <CAHC9VhR1s+p-q35xqHL5Jj2WuzE=bhMrK6PBBThaUBiMRxwvuQ@mail.gmail.com>
 <0835ea7fd96df23419431301dfbc0d190e6c36f4.camel@linux.ibm.com>
 <CAHC9VhTbmmVrZCHCeZe-=s9fCGmEEDdb4p-skKJ=0wmX_K3arQ@mail.gmail.com> <20230831164627.GA4371@wind.enjellic.com>
In-Reply-To: <20230831164627.GA4371@wind.enjellic.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 31 Aug 2023 13:56:52 -0400
Message-ID: <CAHC9VhQx6LxSGEj_quZtVnf6VXfiBwazqpEqHdJT9Ro7BWTYHg@mail.gmail.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     "Dr. Greg" <greg@enjellic.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 31, 2023 at 12:47=E2=80=AFPM Dr. Greg <greg@enjellic.com> wrote=
:
> On Wed, Aug 30, 2023 at 07:22:27PM -0400, Paul Moore wrote:
> > On Wed, Aug 30, 2023 at 7:07???PM Mimi Zohar <zohar@linux.ibm.com> wrot=
e:
> > > On Wed, 2023-08-30 at 18:23 -0400, Paul Moore wrote:
> > > > On Wed, Aug 30, 2023 at 6:21???PM Paul Moore <paul@paul-moore.com> =
wrote:
> > > > > On Wed, Aug 30, 2023 at 5:50???PM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > > > > On Wed, 2023-08-30 at 16:47 -0400, Paul Moore wrote:
> > > > > > > On Wed, Aug 30, 2023 at 4:25???PM Mimi Zohar <zohar@linux.ibm=
.com> wrote:

...

> > Assuming Sush and Tushar rework the document to clarify the
> > motivation/purpose for the work, as you suggested earlier, I'm
> > assuming we can revisit this problem and solutions?
>
> IMA will obviously go, with our blessings, in its own direction.
>
> I would only call out, as I indicated in my reply to Ken Goldman, that
> our 20+ year old integrity and attestation architectures and models
> are now arguably challenged, given emerging technologies and their
> requirements for integrity and confidentiality.
>
> This thread highlights a lot of the issues that caused us to bring
> TSEM to the table ...

It would be helpful if you could refrain from hijacking barely
tangentially related threads as a marketing pitch for TSEM.

Everyone is welcome, and encouraged (!), to join the upstream
discussion threads, especially when one has something relevant to
contribute which hasn't been previously discussed.  However, when
every other contribution an individual makes follows the pattern of
"we could solve all of this if we only had feature 'X' which I
helpfully posted here <lore link>" then those contributions grow very
tiring and I tend to start ignoring that individual.

--=20
paul-moore.com
