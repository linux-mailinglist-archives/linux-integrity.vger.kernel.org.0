Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5F5ED421
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 07:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiI1FKl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 01:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiI1FKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 01:10:40 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC911D0EE;
        Tue, 27 Sep 2022 22:10:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r6so643574wru.8;
        Tue, 27 Sep 2022 22:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fAgZ5tRHZZRRHERZLI7/VYVjT/NV9E6VbCAjwipHzgk=;
        b=jyzgohuSp/UPukht3ZdHLxEs4mLcJJivttqHddKq7VS3qE9LduWwlHFnlJVuX5lufJ
         WLn7sTXhzluTmtBmNGesJ8VAKiyovpjLRvKzxTkAIQ3s+QyuMA8ARdySwdkxocH2Y6Aw
         md5IfY9BXKDv0eBdIByrW54+0idk67nSFYS6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fAgZ5tRHZZRRHERZLI7/VYVjT/NV9E6VbCAjwipHzgk=;
        b=GdevUA2J9t9uuB+/ZqRXtabYaAp6Q6yR1p8RMh+Xsgo9nMHS8nwMcQvd74mPI9AwPb
         GoDD3Xb0GuLzox4wM2NUjthti0WmLOhlcCcupjlOIYQA8BDLC2ZAXcrcALQo/LqyVGOh
         dOAPvrcrWeaA0i8MLRI9EMYBDvVq5FQ17PeDCiPc/WUdboSLZJoiU90MiLM/FC7Kmk/U
         yvlgXHn19lC9HksDqHlnIDX9aw7VQza7DLgPj8RKPLEA9o0w1EXBRURqg6Qcwq9cj7eN
         2gpQsOupnUHzC0+wUc52PPqJcFmrpFdcg4fG8aTbHFe6t1+k0Y/TILCtvAMpdOHohmH1
         2bDg==
X-Gm-Message-State: ACrzQf0CzA3dlZQgEA81Em6ZqWlVYzE+D3iAggZhii2DAokHILGCv2YS
        z9OaL22JZQN3YgCyY2p1sUXIgTvdS9vxILjUOYnzd7DfGJWOpg==
X-Google-Smtp-Source: AMsMyM4ZY/+ny8VzMnpfRJPd15YWX9Knuyrf35sLqo8Xz/xOY8VYV36VWkMmcx5pKaj3akTM4QjhjvI7WlwaQ6mul/U=
X-Received: by 2002:a5d:52c9:0:b0:22c:c9e0:8547 with SMTP id
 r9-20020a5d52c9000000b0022cc9e08547mr165724wrv.3.1664341837285; Tue, 27 Sep
 2022 22:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220907164317.80617-1-eajames@linux.ibm.com> <Yxl8CJBZiROgqhd6@kernel.org>
 <1a20cd56-cc6f-d1c3-2e9d-c6b1fe278959@linux.ibm.com>
In-Reply-To: <1a20cd56-cc6f-d1c3-2e9d-c6b1fe278959@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Sep 2022 05:10:25 +0000
Message-ID: <CACPK8XfRC==6CmFV3LoTW9oF_KLxMXH2KZQD0WFfnYpgnBERXQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add flag to use default cancellation policy
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.or, jgg@ziepe.ca,
        Alexander.Steffen@infineon.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 8 Sept 2022 at 13:53, Eddie James <eajames@linux.ibm.com> wrote:
>
>
> On 9/8/22 00:22, Jarkko Sakkinen wrote:
> > On Wed, Sep 07, 2022 at 11:43:17AM -0500, Eddie James wrote:
> >> The check for cancelled request depends on the VID of the chip, but
> >> some chips share VID which shouldn't share their cancellation
> >> behavior. This is the case for the Nuvoton NPCT75X, which should use
> >> the default cancellation check, not the Winbond one.
> >> To avoid changing the existing behavior, add a new flag to indicate
> >> that the chip should use the default cancellation check and set it
> >> for the I2C TPM2 TIS driver.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++--------
> >>   drivers/char/tpm/tpm_tis_core.h |  1 +
> >>   drivers/char/tpm/tpm_tis_i2c.c  |  1 +
> >>   3 files changed, 12 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> >> index 757623bacfd5..175e75337395 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.c
> >> +++ b/drivers/char/tpm/tpm_tis_core.c
> >> @@ -682,15 +682,17 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
> >>   {
> >>      struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> >>
> >> -    switch (priv->manufacturer_id) {
> >> -    case TPM_VID_WINBOND:
> >> -            return ((status == TPM_STS_VALID) ||
> >> -                    (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> >> -    case TPM_VID_STM:
> >> -            return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> >> -    default:
> >> -            return (status == TPM_STS_COMMAND_READY);
> >> +    if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
> >> +            switch (priv->manufacturer_id) {
> >> +            case TPM_VID_WINBOND:
> >> +                    return ((status == TPM_STS_VALID) ||
> >> +                            (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
> >> +            case TPM_VID_STM:
> >> +                    return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
> >> +            }
> > Why there is no default: ?
>
>
> Well I didn't want to duplicate the line "status ==
> TPM_STS_COMMAND_READY" in the default case and for the flagged case. So
> now the switch just falls through for default. I can add default: break
> instead

This code was in the original patch series submitted by Nuvoton:

https://lore.kernel.org/r/20211104140211.6258-3-amirmizi6@gmail.com

Perhaps something like that would be better?

>
>
> >
> >>      }
> >> +
> >> +    return status == TPM_STS_COMMAND_READY;
> >>   }
> >>
> >>   static irqreturn_t tis_int_handler(int dummy, void *dev_id)
> >> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> >> index 66a5a13cd1df..b68479e0de10 100644
> >> --- a/drivers/char/tpm/tpm_tis_core.h
> >> +++ b/drivers/char/tpm/tpm_tis_core.h
> >> @@ -86,6 +86,7 @@ enum tis_defaults {
> >>   enum tpm_tis_flags {
> >>      TPM_TIS_ITPM_WORKAROUND         = BIT(0),
> >>      TPM_TIS_INVALID_STATUS          = BIT(1),
> >> +    TPM_TIS_DEFAULT_CANCELLATION    = BIT(2),
> >>   };
> >>
> >>   struct tpm_tis_data {
> >> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> >> index 0692510dfcab..6722588e0217 100644
> >> --- a/drivers/char/tpm/tpm_tis_i2c.c
> >> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> >> @@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
> >>      if (!phy->io_buf)
> >>              return -ENOMEM;
> >>
> >> +    set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
> > What if you just zeroed manufacturer ID?
>
>
> It's already zero there, and gets set to the VID as part of the core
> init function.
>
>
> Thanks,
>
> Eddie
>
>
> >
> >>      phy->i2c_client = dev;
> >>
> >>      /* must precede all communication with the tpm */
> >> --
> >> 2.31.1
> >>
> > BR, Jarkko
