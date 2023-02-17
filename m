Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4C669ADFA
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 15:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBQOXm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 09:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQOXl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 09:23:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8CD11674;
        Fri, 17 Feb 2023 06:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B5F61C4F;
        Fri, 17 Feb 2023 14:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03AC433A7;
        Fri, 17 Feb 2023 14:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676643811;
        bh=GODXqgeqpgz5lGuwIhTQ1lW5bCtNEeaidea8ClBIhuU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kxU5yAR5SCj+muB/Xs2TbpuwtjEhABVzAEixlG9Z+qHbS6Rk7znoh19fb9HyRTRJJ
         MWuPa1obj9XUsgqKpt5bX/rR/5Mj4wJ2cjggORwPHV+ADfwOSx9/JNz0MOzO8PPiZL
         RGU6Gg6EbhL9LME233NfYl2BH9xWgZuWz8X03C5OfvwoDKoICZLoqtmwyjv5SdLCdq
         L44gMNBJouvYMW3TjfZsK2R6+SPcCLAFR1IAfx0rYFX+ugg22VwmC0Fsksn6LA41Nj
         V8RSpELTEDyRudw4X6AMrY2wQVtvduj24hc8kHiSMVs2qLE3jn3FZc+sE4qwN7hq0W
         grXtXWPQniJAg==
Received: by mail-lf1-f51.google.com with SMTP id z18so2032617lfd.0;
        Fri, 17 Feb 2023 06:23:31 -0800 (PST)
X-Gm-Message-State: AO0yUKVk4SybCxS5EUIsTdd/7bS9XqfqwYOlRRUTy0OUKpt6AWdN45zz
        3WggXlIgiyN8Hk+pXMxsWDW85e+s3WOsZWALR7M=
X-Google-Smtp-Source: AK7set+iMeptDpXKK7t+ZaMa3/JwRtwGyEOYMxjqqoRCht9rygIHf/pWcFAaPefNqzI0TSy7tdqIO9nxGDQyUpC7fgk=
X-Received: by 2002:a05:6512:3b25:b0:4db:19cf:5212 with SMTP id
 f37-20020a0565123b2500b004db19cf5212mr3036262lfv.1.1676643809772; Fri, 17 Feb
 2023 06:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20230216201410.15010-8-James.Bottomley@HansenPartnership.com>
 <202302171905.Ornmq8g3-lkp@intel.com> <261954a66afd92a6d09b1097191f717bbb54b7d1.camel@HansenPartnership.com>
In-Reply-To: <261954a66afd92a6d09b1097191f717bbb54b7d1.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 17 Feb 2023 15:23:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHgCwDCaK=rGVsbAUgjY5hVeX=x4oGyHO2FpxyuoQD5bw@mail.gmail.com>
Message-ID: <CAMj1kXHgCwDCaK=rGVsbAUgjY5hVeX=x4oGyHO2FpxyuoQD5bw@mail.gmail.com>
Subject: Re: [PATCH 07/12] tpm: Add full HMAC and encrypt/decrypt session
 handling code
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     kernel test robot <lkp@intel.com>, linux-integrity@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 17 Feb 2023 at 15:22, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2023-02-17 at 19:30 +0800, kernel test robot wrote:
> [...]
> > > > ERROR: modpost: "aescfb_encrypt" [drivers/char/tpm/tpm.ko]
> > > > undefined!
> > > > ERROR: modpost: "aescfb_decrypt" [drivers/char/tpm/tpm.ko]
> > > > undefined!
>
> Ard,
>
> This happens because your aescfb_encrypt/decrypt() routines are missing
> EXPORT_SYMBOL statements.
>

OK, i'll add those.
