Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C96068CF
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Oct 2022 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJTTYB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Oct 2022 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJTTX7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Oct 2022 15:23:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926E20FB09
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 12:23:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id t25so628682qkm.2
        for <linux-integrity@vger.kernel.org>; Thu, 20 Oct 2022 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UXYBorl1dI3AKqx3xQmawJPVUjsdLNNAJw91kOBPSIk=;
        b=SQ8OK63PFQry61FWFejRq6pCAtpPieg4TVk5hrGs9yrj+h+2wqx1laUos+OOt2inze
         DxH8KYz/cFMdCorv+jYplUO9OBUoad0QYHCrDukFBDYQPBbyRbh85/wjBDyceg5Qn/Mw
         AY6c47hC4FlDCeYqXpsjlx5xcFXM2e8jCwRYjVjGrgARsDTjAxsyuPtQr8llfQEKnJg1
         X17NSzzxO60lqAYhBWrsrzqfsyp3nIWpLFhXkfq1bXrVeNlc6rHwsCfM0+veR6Lf7Tii
         ahBQKsXfUlV5kuc64s1qLlK24/w3Yz0Hj9ecP3Ukekz9WUV+Sr3+7HWIPNNvVSg5WPWS
         H9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXYBorl1dI3AKqx3xQmawJPVUjsdLNNAJw91kOBPSIk=;
        b=ldobWuwqBxfeGyKDKsoDt7g1tNsJbvqBSUJDx1TMD9byeaCBeQmCfyOvuAC9zgVXHS
         7bazMuL0f+UMJ14e/B9Twi2xIkwfK/INf6+N11Vyx78Zo4EMOk3nXIenWijRqv+h/nN0
         ZXCF/x1F18rjv5YzuhW2eNWHIqMEbtn+qm/7NmgL+Nk/Ka/6SSZaS4CC/f8T/eDQWYI8
         GlEB4gB1DtzRebZgohw1CVLinDrQ+zWkRzSy6YWscdAPuyK560OmvDs0owSVXI6QTjz8
         lc0+8I7cF/q0Gta/OfsQ7iMx9FvL1QFnSqrYnXYVfAS424BWOn3nVN8MRAVT0dREvOPz
         QPsA==
X-Gm-Message-State: ACrzQf0e2S2SFnZWLlhnY0Z9XzoftJHl89804jU6P5R0Oj1JnX1rBQLH
        ECvkeUaXsz1KwXLzkGIKBNgb8w==
X-Google-Smtp-Source: AMsMyM6/PxGqTil/yztlMG8oGxbBRTidnNsSg45nwoJJ8KtNHLjmGAlx/eEJkbzdVhzCbBBaGVTwmg==
X-Received: by 2002:a05:620a:1512:b0:6ee:b258:51f1 with SMTP id i18-20020a05620a151200b006eeb25851f1mr10701716qkk.716.1666293835335;
        Thu, 20 Oct 2022 12:23:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id ew5-20020a05622a514500b0039cc9d24843sm6594369qtb.66.2022.10.20.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 12:23:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1olb8z-00Ay3E-DR;
        Thu, 20 Oct 2022 16:23:53 -0300
Date:   Thu, 20 Oct 2022 16:23:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "gilad@benyossef.com" <gilad@benyossef.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "michael@walle.cc" <michael@walle.cc>,
        "john.ernberg@actia.se" <john.ernberg@actia.se>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Sahil Malhotra <sahil.malhotra@nxp.com>,
        Kshitiz Varshney <kshitiz.varshney@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH v0 3/8] crypto: hbk flags & info added to the
 tfm
Message-ID: <Y1GgSX+ZmOsxhB2N@ziepe.ca>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
 <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
 <DU2PR04MB8630CBBB8ABDC3768320C18195209@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <Y0Q3JKnWSNIC4Xlu@zx2c4.com>
 <Y0UxY51KQoKCq59o@gondor.apana.org.au>
 <Y0XLqd/+C1sxq2G0@zx2c4.com>
 <Y0aDiLp7BztzwNez@gondor.apana.org.au>
 <Y0m2TU5k78I1AR+p@ziepe.ca>
 <Y1DN3SqEyFZd9i37@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1DN3SqEyFZd9i37@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Oct 19, 2022 at 09:26:05PM -0700, Eric Biggers wrote:

> Are you referring to the support for hardware-wrapped inline crypto keys?  It
> isn't upstream yet, but my latest patchset is at
> https://lore.kernel.org/linux-fscrypt/20220927014718.125308-2-ebiggers@kernel.org/T/#u.
> There's also a version of it used by some Android devices already.  Out of
> curiosity, are you using it in an Android device, or have you adopted it in some
> other downstream?

Unrelated to Android, similar functionality, but slightly different
ultimate purpose. We are going to be sending a fscrypt patch series
for mlx5 and nvme soonish.

> > Yes, it would be nice to see a comprehensive understand on how HW
> > resident keys can be modeled in the keyring.
> 
> Note that the keyrings subsystem is not as useful as it might seem.  It sounds
> like something you want (you have keys, and there is a subsystem called
> "keyrings", so it should be used, right?), but often it isn't.  fscrypt has
> mostly moved away from using it, as it caused lots of problems.  I would caution
> against assuming that it needs to be part of any solution.

That sounds disappointing that we are now having parallel ways for the
admin to manipulate kernel owned keys.

Jason
