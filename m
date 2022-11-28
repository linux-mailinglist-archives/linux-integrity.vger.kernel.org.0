Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB463A166
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 07:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiK1Gma (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 01:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiK1Gm3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 01:42:29 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BCAA187
        for <linux-integrity@vger.kernel.org>; Sun, 27 Nov 2022 22:42:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ho10so23365078ejc.1
        for <linux-integrity@vger.kernel.org>; Sun, 27 Nov 2022 22:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWp/pTvdmVyjmSr2ClbgspEYXcXDUVYuKRfbj3qcDes=;
        b=lOVOIIWd232bkr2Ti+UCmxkELRC9E8XWP1rkfrAXZ01AW6TIsKDFwS+ijxdIqSuQXj
         l9aix8QQ/8oHee0dxOBICL3i15cgrZLLLzOyqaVN8aF9dXddYmpqe+deNI3ylfSBMYlW
         EGPu4wDYlJ0WokDru94Kt4xHbjq6FlEUCnPQhLfqLV72lb7kOX8neRBG8uSOza9LjS5t
         XAFAR2WN+Ba8faWnkEb0QYItWwiLwE06TNgrCfs8TDLuksGd2Tti3iCDxsfDUtDCT+Ys
         rLMiHqVI29B/SzLc1csg/Tf1KwEFXxBUErahQ7J45DE2WqcBn6zSVkEdJeYSIJ//mthi
         Bv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWp/pTvdmVyjmSr2ClbgspEYXcXDUVYuKRfbj3qcDes=;
        b=3T+f2Hgkw2KUl1zbYpPH5IoxJo/nR0C/greVIc5n8Fw2gsrD5Qpc5AnSnnZ14KnZhh
         JJJSemXXVubotouQcXJ7t2U3KFoxJiUxuw30NxzluXdex+n9IBF31hpVSPfNK8y/4wB4
         GrdH3Ox7EjxLBs8ACMX7zrLzY6l4Nq7OTqU1+4a3HgL51XiK2AfnWRgH9pbA4Rb9fhyE
         MWJpvV31DUE2GSoKkz5G53WtJa6MRwjVYTa9N+jGrBRTKcOux647oxz31PAWiBkeZe4Q
         5sqH92MmT8/ute4Wzt45k2n7yEK5t9Une4Q2txYgwUnhXpeV3bamwzaWEXXO0Es7WovW
         M6Fg==
X-Gm-Message-State: ANoB5pkGtptrdx/Rpp4u9JWy7OYzOV/6LJoHuLoiKFupTZbYV7Rq0fwB
        7nDRw74dBo7rTYvgWMxKGJDWMUWI7Er2HkLoN82k6w==
X-Google-Smtp-Source: AA0mqf5rWWXHxxXux26kVnkwODxEwfJusp/Xic1gaXAD1DvVFuqTeoqQhdV2xXOBVtwyQm9UCxpeaJ/ZvFbp1KqaDtw=
X-Received: by 2002:a17:906:9445:b0:7bb:7520:f168 with SMTP id
 z5-20020a170906944500b007bb7520f168mr16547404ejx.423.1669617747177; Sun, 27
 Nov 2022 22:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20221124031926.16963-1-yuancan@huawei.com> <Y4QNhBTwC9M9hXm4@kernel.org>
In-Reply-To: <Y4QNhBTwC9M9hXm4@kernel.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 28 Nov 2022 09:42:15 +0300
Message-ID: <CAD8XO3YWE50kq3U-tJ=Xjq0UvhGn_t8C0QPcTX+wTDME7STJjg@mail.gmail.com>
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix error handling in ftpm_mod_init()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Yuan Can <yuancan@huawei.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        sumit.garg@linaro.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

yea, for backward compatibility both platfrom_driver and driver_ were
supported. Maybe it's time to reconsider this now...
Thanks for the clean up fix.

Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Best regards,
Maxim.

On Mon, 28 Nov 2022 at 04:23, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Nov 24, 2022 at 03:19:26AM +0000, Yuan Can wrote:
> > The ftpm_mod_init() returns the driver_register() directly without checking
> > its return value, if driver_register() failed, the ftpm_tee_plat_driver is
> > not unregistered.
> >
> > Fix by unregister ftpm_tee_plat_driver when driver_register() failed.
> >
> > Fixes: 9f1944c23c8c ("tpm_ftpm_tee: register driver on TEE bus")
> > Signed-off-by: Yuan Can <yuancan@huawei.com>
> > ---
> >  drivers/char/tpm/tpm_ftpm_tee.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
> > index 5c233423c56f..deff23bb54bf 100644
> > --- a/drivers/char/tpm/tpm_ftpm_tee.c
> > +++ b/drivers/char/tpm/tpm_ftpm_tee.c
> > @@ -397,7 +397,13 @@ static int __init ftpm_mod_init(void)
> >       if (rc)
> >               return rc;
> >
> > -     return driver_register(&ftpm_tee_driver.driver);
> > +     rc = driver_register(&ftpm_tee_driver.driver);
> > +     if (rc) {
> > +             platform_driver_unregister(&ftpm_tee_plat_driver);
> > +             return rc;
> > +     }
> > +
> > +     return 0;
> >  }
> >
> >  static void __exit ftpm_mod_exit(void)
> > --
> > 2.17.1
> >
>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> BR, Jarkko
