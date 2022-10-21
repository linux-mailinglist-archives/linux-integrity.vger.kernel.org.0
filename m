Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F3607BF3
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJUQRr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 12:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJUQRp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 12:17:45 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9174F237FB0
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 09:17:43 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3139725pjc.5
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 09:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W3+QLYmXHbj4Y7O3zA2pzQuqaG2CIwHAAxODSpq5Wy8=;
        b=UIgsPTyZd1bzfWaRYZeJh1M7ipVxG1t/5RMXgAZVBiwFPPLTU2SxTlMaJOYoCf+Jdw
         rGnXwACPCqTkmItvozbBLGFErPShk8b3ZI9/9rFOKSZoQmxN5TanxaEXwx2jzvdzStM3
         XGZBoxb3OzlCUpJHIyV3GPAbxbm8D+3rvNoBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3+QLYmXHbj4Y7O3zA2pzQuqaG2CIwHAAxODSpq5Wy8=;
        b=zFRdBcao84IZQaXtAr7jcfI+oWVEo/Mmi9GAZuBQxcG7M2pA7J2I5VWNAARIwe63Ov
         FtahfsKDQ+pKkCoXqkjHzE1hj2LYcX/ZGAp5zOkCved3bB/2lV6eCplOf02PYmnl8dbl
         HAqMODi0zlDLL0F06DRxr/o6qR0OHLflqhTxvIGsucEabTXH6h5bhfmIb6yHvsI5Rjes
         xdpAoaErhEWPiLmNhLe68/oQnfFKyMw3gV0+pIWI3iIxJ6C7OFEF7TNhu+aduetKseUI
         bpPTSILUlHr3qzUwnyoYL5nilSVc52lWDz1xU5s+duNatvS1kWx/nE59MwR6EixBhuuZ
         tpwA==
X-Gm-Message-State: ACrzQf300VDbuLCBnfxJGr2T/XAa8ECufMxduj/PYFYNFUe7CR4inHl9
        TwY/yQkHXllVKFhQ+P7/9gz8Kg==
X-Google-Smtp-Source: AMsMyM5PVsZuIOrl5Q5nE95/imf2ifwCKfEpbEMrzat8Xlso1Xm4jDa3kWIGqiEx/Ff4sqDasUP1/g==
X-Received: by 2002:a17:90b:1bd2:b0:212:cf30:3d53 with SMTP id oa18-20020a17090b1bd200b00212cf303d53mr4327175pjb.18.1666369063042;
        Fri, 21 Oct 2022 09:17:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018668bee7cdsm3468239plx.77.2022.10.21.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:17:42 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:17:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <202210210917.955806F@keescook>
References: <20221021123309.2770740-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021123309.2770740-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 21, 2022 at 02:33:09PM +0200, Ard Biesheuvel wrote:
> The TPM code registers put_device() as a devm cleanup handler, and casts
> the reference to the right function pointer type for this to be
> permitted by the compiler.
> 
> However, under kCFI, this is rejected at runtime, resulting in a splat
> like
> 
>    CFI failure at devm_action_release+0x24/0x3c (target: put_device+0x0/0x24; expected type: 0xa488ebfc)
>    Internal error: Oops - CFI: 0000000000000000 [#1] PREEMPT SMP
>    Modules linked in:  ...
>    CPU: 20 PID: 454 Comm: systemd-udevd Not tainted 6.1.0-rc1+ #51
>    Hardware name: Socionext SynQuacer E-series DeveloperBox, BIOS build #1 Oct  3 2022
>    pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : devm_action_release+0x24/0x3c
>    lr : devres_release_all+0xb4/0x114
>    sp : ffff800009bb3630
>    x29: ffff800009bb3630 x28: 0000000000000000 x27: 0000000000000011
>    x26: ffffaa6f9922c0c8 x25: 0000000000000002 x24: 000000000000000f
>    x23: ffff800009bb3648 x22: ffff7aefc3be2100 x21: ffff7aefc3be2e00
>    x20: 0000000000000005 x19: ffff7aefc1e1ec10 x18: ffff800009af70a8
>    x17: 00000000a488ebfc x16: 0000000094ee7df3 x15: 0000000000000000
>    x14: 4075c5c2ef7affff x13: e46a91c5c5e2ef42 x12: ffff7aefc2c57540
>    x11: 0000000000000001 x10: 0000000000000001 x9 : 0000000100000000
>    x8 : ffffaa6fa09b39b4 x7 : 7f7f7f7f7f7f7f7f x6 : 8000000000000000
>    x5 : 000000008020000e x4 : ffff7aefc2c57500 x3 : ffff800009bb3648
>    x2 : ffff800009bb3648 x1 : ffff7aefc3be2e80 x0 : ffff7aefc3bb7000
>    Call trace:
>     devm_action_release+0x24/0x3c
>     devres_release_all+0xb4/0x114
>     really_probe+0xb0/0x49c
>     __driver_probe_device+0x114/0x180
>     driver_probe_device+0x48/0x1ec
>     __driver_attach+0x118/0x284
>     bus_for_each_dev+0x94/0xe4
>     driver_attach+0x24/0x34
>     bus_add_driver+0x10c/0x220
>     driver_register+0x78/0x118
>     __platform_driver_register+0x24/0x34
>     init_module+0x20/0xfe4 [tpm_tis_synquacer]
>     do_one_initcall+0xd4/0x248
>     do_init_module+0x44/0x28c
>     load_module+0x16b4/0x1920
> 
> Fix this by going through a helper function of the correct type.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
