Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356BF5F19C1
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 06:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJAENN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Oct 2022 00:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJAENM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Oct 2022 00:13:12 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027615C1C6;
        Fri, 30 Sep 2022 21:13:12 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x29so433371pfp.7;
        Fri, 30 Sep 2022 21:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jn8KZ7zHSEtmmS5VV4/304mar3AY891GsOGGpWRjJrQ=;
        b=gknryzbNZURuvjyi3N6TrG5/ClGGZl5xINWIh1B5VIRO+J0NnHwsr/NbTsNfUeIejB
         frt3l+WUmQeZE2to6iHZPMhv/J7wKdHyIrBoUvsV1aTR/aGM0SIJGT44VpxGixBUSIcZ
         o1c17lXx3n8CvdyJL5v7Mh1NoarfkNajCYiH7MLYLMb3e7f/IB/jk0cfN93MyuEWjy0p
         gOOwuQTEQVD3TN1VxFsgzbl1FQ1jq68RPMPXHs2KXMTiGclRYpY64pt+N5Pb+EV6C9oM
         lAmSqwWrYX+MTwybmF6NL0c7yPFRI15Ix6CxN8rV76GAXExdoqlz151Z98u18IGFaPkN
         8CsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jn8KZ7zHSEtmmS5VV4/304mar3AY891GsOGGpWRjJrQ=;
        b=dyBHuzR3BB57Ebvlyay99nnj8z82sCFNS+zyFdRlZR593W5/3weHfAwRJ6sWsts0DP
         B2dq9e0N7/cbxhHZE/e9688RRz6dS6/4+NzCusWeGM3Hz3TTH7R2Wb3Winhk4nmkfR5v
         caJ4rqXZwyPehM0RbfR7etO3wRgGVsHcmO/k9DiAQHaYVI2yeHxX6sXqdIKBhhaFBTlh
         c9kYPizp7Q2S/dl4DRAHTVH4szBy76HEw6G+Af9ox7b6AjGWdSkJmjGUgxOH2cKAtndZ
         kfPSj9IhuAsaNf3XoJI+uwOhAD1TaEntcArm8i4JVkbo5XeBw25NYuxGlA0Hwq2mYUG7
         jK4g==
X-Gm-Message-State: ACrzQf1L4/ZPztMtW7Y6/Xx+O0Y0wOU76kxh+mwlYoZB7P08koAec9aA
        QrQdha2BxGklcdDLALibLxU=
X-Google-Smtp-Source: AMsMyM5XA9d1f4OIu/hfS3r0ediKFHRd+3sx+NwPH0+3Wn7uu/W/2d58HKcvPO7NE9tpJ8LzE0LGDQ==
X-Received: by 2002:a63:5fc4:0:b0:43d:c6cc:ef59 with SMTP id t187-20020a635fc4000000b0043dc6ccef59mr10109939pgb.585.1664597591394;
        Fri, 30 Sep 2022 21:13:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b0017b778ba8c0sm2676261plb.186.2022.09.30.21.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 21:13:10 -0700 (PDT)
Date:   Fri, 30 Sep 2022 21:13:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tpm: st33zp24: remove pointless checks on probe
Message-ID: <Yze+VDJ2u03zg2HC@google.com>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
 <20220926053958.1541912-3-dmitry.torokhov@gmail.com>
 <YzdVJYuzYzBTELI0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzdVJYuzYzBTELI0@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 11:44:21PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 25, 2022 at 10:39:58PM -0700, Dmitry Torokhov wrote:
> > Driver core will never call driver's probe method without appropriate
> > device structure, so testing them for NULL is pointless.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Missing a description what the patch does.
> 
> Also instead of "driver's probe method" you could just use
> "st33zp24_i2c_probe()". It's even shorter.

There are 2 interfaces: I2C and SPI, thus 2 separate probe methods.

Thanks.

-- 
Dmitry
