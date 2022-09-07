Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463965B0AEF
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Sep 2022 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiIGRC4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Sep 2022 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiIGRCy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Sep 2022 13:02:54 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA93B14E2
        for <linux-integrity@vger.kernel.org>; Wed,  7 Sep 2022 10:02:54 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1278a61bd57so19039392fac.7
        for <linux-integrity@vger.kernel.org>; Wed, 07 Sep 2022 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=QHc+dzwrG9zhOQ7C4s6n1WTuaaXkQxEQESnpVWN4LoI=;
        b=lW22XNnE/dd1CgVKzegBWEnUGdTcs6CZNzVN8GMT1yOwlH8Pg4axoGlYV2xDdjyrUl
         9vibGJ3Dids+Hk/xfei2pRRtSi4peEJRmJGUeSxuzU4Smgi5aIHfLjxki3tehWJ34DSv
         5KV/pnWH1GO9Tl3kROCcfqUWiSl7OmivZTkzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=QHc+dzwrG9zhOQ7C4s6n1WTuaaXkQxEQESnpVWN4LoI=;
        b=SebsLyKHy17dnrODzQ9CKN7uTSimBgngu4D/2tqYNOTaWeQpQb+6l4eplI47CcFvdZ
         +hhg/iQJ0sRPIAgPxZn3Rk7jBKPMyj4SOWn8ibwNU2fUF3Kep9bLc6N7L9jt/tT1aTRN
         Wcc2ujpCeFU9WM/E1RpCUhfQDDeePIgkS+u+qXeFVbzS0ZRpIxalZscEAZjAcSCRy+TO
         KPZW7ZmvBcOcBkrcmvAj/RNvL5pZSiMfRLNuOjPLhpSXF/2gjLxCSmd3hLnBlMZ8fBKN
         H/yWO529B+Y7k7Yxu8uh90gXynnAFJ/t84lLUKBVFfZmB42VsJwki2fHZFrIMWNrwmFX
         zcZQ==
X-Gm-Message-State: ACgBeo32qx23aZ8kG8JM0a5pA4u/7BWTctQSwdmo++cdduJTFAt8FaOi
        8b4RS5b2isk901fwoSUJVrQBeRdioOINpw==
X-Google-Smtp-Source: AA6agR4srodZaPIs6DiCyB31+8XZsY4QdxFbe5p5UB4EQd/wxhmdVAKhOUf7F+FrenoRQzWDQt30wQ==
X-Received: by 2002:a05:6870:e6d3:b0:126:fdc2:27c4 with SMTP id s19-20020a056870e6d300b00126fdc227c4mr10170271oak.70.1662570173028;
        Wed, 07 Sep 2022 10:02:53 -0700 (PDT)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com. [209.85.160.48])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0503000000b00339befdfad0sm6687583oif.50.2022.09.07.10.02.51
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 10:02:51 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1278624b7c4so19345010fac.5
        for <linux-integrity@vger.kernel.org>; Wed, 07 Sep 2022 10:02:51 -0700 (PDT)
X-Received: by 2002:a05:6808:3096:b0:342:ff93:4672 with SMTP id
 bl22-20020a056808309600b00342ff934672mr2052129oib.174.1662570170769; Wed, 07
 Sep 2022 10:02:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220823222526.1524851-1-evgreen@chromium.org>
 <20220823152108.v2.1.I776854f47e3340cc2913ed4d8ecdd328048b73c3@changeid> <Ywg3JZrWmRjvr/7f@kernel.org>
In-Reply-To: <Ywg3JZrWmRjvr/7f@kernel.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 7 Sep 2022 10:02:14 -0700
X-Gmail-Original-Message-ID: <CAE=gft6RuggyTSJXty5EskUcwLFEv4mrC1AL3HY-UgvXQRxvbA@mail.gmail.com>
Message-ID: <CAE=gft6RuggyTSJXty5EskUcwLFEv4mrC1AL3HY-UgvXQRxvbA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] tpm: Add support for in-kernel resetting of PCRs
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        apronin@chromium.org, Daniil Lunev <dlunev@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>, Hao Wu <hao.wu@rubrik.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, axelj <axelj@axis.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 25, 2022 at 8:00 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Aug 23, 2022 at 03:25:17PM -0700, Evan Green wrote:
> > From: Matthew Garrett <matthewgarrett@google.com>
> >
> > Add an internal command for resetting a PCR. This will be used by the
> > encrypted hibernation code to set PCR23 to a known value. The
> > hibernation code will seal the hibernation key with a policy specifying
> > PCR23 be set to this known value as a mechanism to ensure that the
> > hibernation key is genuine. But to do this repeatedly, resetting the PCR
> > is necessary as well.
> >
> > From: Matthew Garrett <mjg59@google.com>
>
> This is probably here by mistake.
>
> > Signed-off-by: Matthew Garrett <mjg59@google.com>
> >
>
> No empty line here.
>
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> > Matthew's original version of this patch was at:
> > https://patchwork.kernel.org/patch/12096487/
> >
> > (no changes since v1)
> >
> >  drivers/char/tpm/tpm-interface.c | 28 +++++++++++++++++++++++++
> >  drivers/char/tpm/tpm.h           |  2 ++
> >  drivers/char/tpm/tpm1-cmd.c      | 34 ++++++++++++++++++++++++++++++
> >  drivers/char/tpm/tpm2-cmd.c      | 36 ++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h              |  7 +++++++
> >  5 files changed, 107 insertions(+)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 1621ce8187052c..17b8643ee109c2 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -342,6 +342,34 @@ int tpm_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_pcr_extend);
> >
> > +/**
> > + * tpm_pcr_reset - reset the specified PCR
> > + * @chip:    a &struct tpm_chip instance, %NULL for the default chip
> > + * @pcr_idx: the PCR to be reset
> > + *
> > + * Return: same as with tpm_transmit_cmd()
> > + */
> > +int tpm_pcr_reset(struct tpm_chip *chip, u32 pcr_idx)
> > +{
> > +     int rc;
> > +
> > +     chip = tpm_find_get_ops(chip);
> > +     if (!chip)
> > +             return -ENODEV;
> > +
> > +     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +             rc = tpm2_pcr_reset(chip, pcr_idx);
> > +             goto out;
> > +     }
> > +
> > +     rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
> > +
> > +out:
> > +     tpm_put_ops(chip);
>
>         if (chip->flags & TPM_CHIP_FLAG_TPM2)
>                 rc = tpm2_pcr_reset(chip, pcr_idx);
>         else
>                 rc = tpm1_pcr_reset(chip, pcr_idx, "attempting to reset a PCR");
>
> Where does this asymmetry come with the parameters?

Sorry for the delay, I was out last week. I think it's modeled to
match the tpm1/2_pcr_extend functions, which have this same odd
asymmetry. Should I change it to have both use the tpm2_pcr_reset()
prototype?
-Evan
