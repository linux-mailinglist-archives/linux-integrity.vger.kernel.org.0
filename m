Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B271860798C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJUO0k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJUO0j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 10:26:39 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24E27020B
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 07:26:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c23so1704776qtw.8
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WkpZpN+5guunfMfs9Ho23gqkDVOq+GpOA2uDceX8XJM=;
        b=kdIMtnd2zjOJAGzob9/rapKewAxnVg8iSmmrt+qn/Np9Wf/YKILlv1t2EtfAKxmzhE
         azrR6pvDwyaZzqbp1njtDGjltCxWo7hCUS/Glb19MRwg/+QUbriLb5/ZglZfojD5TfZK
         YRWqp9oHTT+fTa6NV0IYIJ23X5zDqcmh+1TPVLcwLC+GEodNoyunratirlrmjmF/r4ep
         lys13Hrf5y9+zcMFI7KWvkwsThNynErtlGbRKm2z4gDKgiCMrkehbHIDKbxDayEyepEp
         6BMxC4GHjQvPZfaJFt4E8EXTVtrlHe24UQDmEtW8S/Bt92SBUEu/2RyyaO0T1eJGhRBa
         O03w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkpZpN+5guunfMfs9Ho23gqkDVOq+GpOA2uDceX8XJM=;
        b=QcX9sahlbS3N+cedbwSQ6xzwEVEFfH6Iz+IBtvMvaslbOh3kkEOp5TXPHgmDnUiA64
         GlEGbiC7PdjF+Ao4Y2LeXKAaqYLr1vD/9KB8/l8gVbXkergHUMYMe8IWTI+D4jxsWdDB
         rNHx9adt2YvFeT7hQTezSvuHrEb0+DWuMtjiv4+IwdUnxIAC8od3yk5XNg+Tcwe8LSXj
         o+3OMTVX/hSY7HnTQ1j8jXWjZ4L9fUhivpixe6nkcq64COpo7CmD0oSevanDfX+tHJjN
         7QF2i1RqjB4xZlDu+jkOdD885rBo+p7lO3L1iCNxybwqqpsmEKXmgFspYK0WEWWrU0en
         HVJQ==
X-Gm-Message-State: ACrzQf3r7ohTa8DIgBUFefwFN8m2nUHO0srnckk6Ozr96yJxrJVP2TS1
        LUav7XGqnHe59g6J4+GEHmoegQ==
X-Google-Smtp-Source: AMsMyM4GLlwzSgiDn6oSWU0avcVSlT+5sn8qfe0sZ7q5b9zsxdTcwacLLDAbhOJTFyY0gNuOgzY3wA==
X-Received: by 2002:a05:622a:1389:b0:39c:c847:f384 with SMTP id o9-20020a05622a138900b0039cc847f384mr17105694qtk.301.1666362390416;
        Fri, 21 Oct 2022 07:26:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id bn4-20020a05622a1dc400b0039ccbf75f92sm7994103qtb.11.2022.10.21.07.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:26:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1olsyi-00BKqE-N8;
        Fri, 21 Oct 2022 11:26:28 -0300
Date:   Fri, 21 Oct 2022 11:26:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        linux-integrity@vger.kernel.org, keescook@chromium.org,
        samitolvanen@google.com
Subject: Re: [PATCH] tpm: Avoid function type cast of put_device()
Message-ID: <Y1KsFLr/8zjjT0DW@ziepe.ca>
References: <20221021123309.2770740-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021123309.2770740-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> ---
>  drivers/char/tpm/tpm-chip.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
