Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6F05FC1A5
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJLIMI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJLIMH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 04:12:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE356BB7
        for <linux-integrity@vger.kernel.org>; Wed, 12 Oct 2022 01:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA2746136E
        for <linux-integrity@vger.kernel.org>; Wed, 12 Oct 2022 08:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BA5C433D6;
        Wed, 12 Oct 2022 08:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665562326;
        bh=vpghSWR01Jz/aPtBfytrAgi+K13sf3gpIIM1HiM2zK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8ub82XkJwvEqOT4b/u9lmN2dY0hCP1CO3xU9ZdbNk/Ga1YSjP46UZftueQyG208A
         9EU8arKpAnvW/PWy/vklZh82fJ7qSlj6khKq9DahIOSXuXTwQfHRapv536fQPUXn9C
         IRGOeMX5S74jr80ERwS64wCqzIez6QhE4m8CWuPesUG4tFOJSUyJlK3x1TgpQCxOUj
         vKOfuE6a0NGQP3Gi9BhNMeDsyWEZK/WIsC9oLED4aUWNGMFgBflBPLeFeaPIUxg5Nv
         vW52Kvt4WUIHWxZbDs2Cx3P+ozQ9gSGqabbk41/DadNHOpYuX6iP12RfL3fAlprYpQ
         uTXvyNhgDdJrA==
Date:   Wed, 12 Oct 2022 11:12:03 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: Is efi_tpm_eventlog_init calling memblock_reserve correctly for
 the TPM final log?
Message-ID: <Y0Z202u2qpZT505i@kernel.org>
References: <CALzcddsfNchgJhKdxbUDDb3zBhbHZfYLCtRt9o6o=pv-zk_w_g@mail.gmail.com>
 <1d0b01793100651682413ab1e14c1b1d0e9f68f0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d0b01793100651682413ab1e14c1b1d0e9f68f0.camel@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 07, 2022 at 09:50:49AM -0700, Jerry Snitselaar wrote:
> On Wed, 2022-06-22 at 21:26 -0700, Jerry Snitselaar wrote:
> > Is this calling memblock_reserve() correctly for the final events
> > log?
> > 
> > For the tpm events log it does:
> > 
> > memblock_reserve(efi.tpm_log, tbl_size);
> > 
> > For the final events log it does:
> > 
> >           memblock_reserve((unsigned long)final_tbl,
> >                            tbl_size + sizeof(*final_tbl));
> > 
> > 
> > which ends up with something like:
> > 
> > [    0.000000] memblock_reserve:
> > [0x000000005d7b5018-0x000000005d7b958a]
> > efi_tpm_eventlog_init+0x82/0x370
> > [    0.000000] memblock_reserve:
> > [0xffffffffff2c0000-0xffffffffff2c00e4]
> > efi_tpm_eventlog_init+0x324/0x370
> > 
> > 
> > Regards,
> > Jerry
> > 
> 
> Hi Matthew and Jarrko,
> 
> Is efi_tpm_eventlog_init() calling memblock_reserve() with the correct
> argument for the TPM final log, or should it be the following instead:
> 
> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
> index 8f665678e9e3..e8d69bd548f3 100644
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -97,7 +97,7 @@ int __init efi_tpm_eventlog_init(void)
>  		goto out_calc;
>  	}
>  
> -	memblock_reserve((unsigned long)final_tbl,
> +	memblock_reserve(efi.tpm_final_log,
>  			 tbl_size + sizeof(*final_tbl));
>  	efi_tpm_final_log_size = tbl_size;

With a *long while* since last looked into this, it does look wrong as
'final_tbl' is just transient thing in the fixmap used internally in the
function.

BR, Jarkko
