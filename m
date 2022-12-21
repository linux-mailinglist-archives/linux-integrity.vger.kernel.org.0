Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9356537DC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Dec 2022 21:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiLUUxf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Dec 2022 15:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUUxe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Dec 2022 15:53:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2839421E11;
        Wed, 21 Dec 2022 12:53:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B683D60FB5;
        Wed, 21 Dec 2022 20:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A486BC433F0;
        Wed, 21 Dec 2022 20:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671656012;
        bh=Ei1yd0A82cwikByLCenh3iB6L944+LMrF6j1GxO8bf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G5jGAqypOPugBDeBfljlBfqGpIg1CtpmK5YPSiF3ulCeyCVKT1o8fHPY0+KDTUTrd
         0QpiL09R+a8OR24QIM+xsNYE1vgL0WE7xahHbhzi6/zZ0UwFGrDJwBH/ZPhsAl/DK9
         alY1H80WlcMsYrYAtKd/xvKFJbzX0PLJxuhEn0WOqSr1QLiEAEz27gG3VVNsFckcbf
         3m8DDNmvZN1rnsXfTvWmRRG9P3MT4Ac/TTasR6IdGk7A0MgKpDXit2P+LGLbaQ0zXz
         xvIOraqshLgWFRbBtE0R/ZpfG31ag6KxxAHln38RnLxQyUP6LmQhPjPp21H/i8APsX
         ycpfem4iJSDug==
Date:   Wed, 21 Dec 2022 12:53:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [v2 PATCH] lib/mpi: Fix buffer overrun when SG is too long
Message-ID: <Y6NySck5p/DXhSUJ@sol.localdomain>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
 <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
 <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
 <Y6IbWA5aZeBnn4n2@gmail.com>
 <Y6Kthn+rIUnCEJWz@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Kthn+rIUnCEJWz@gondor.apana.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 21, 2022 at 02:53:58PM +0800, Herbert Xu wrote:
> On Tue, Dec 20, 2022 at 08:30:16PM +0000, Eric Biggers wrote:
> >
> > > Tried, could not boot the UML kernel.
> > > 
> > > After looking, it seems we have to call sg_miter_stop(). Or alternatively,
> > > we could let sg_miter_next() be called but not writing anything inside the
> > > loop.
> > > 
> > > With either of those fixes, the tests pass (using one scatterlist).
> 
> Thanks for the quick feedback Roberto!
> 
> > I think it should look like:
> > 
> > 	while (nbytes) {
> > 		sg_miter_next(&miter);
> > 		...
> > 	}
> > 	sg_miter_stop(&miter);
> 
> You're right Eric.  However, we could also do it by simply not
> checking nbytes since we already set nents according to nbytes
> at the top of the function.
> 
> ---8<---
> The helper mpi_read_raw_from_sgl sets the number of entries in
> the SG list according to nbytes.  However, if the last entry
> in the SG list contains more data than nbytes, then it may overrun
> the buffer because it only allocates enough memory for nbytes.
> 
> Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
> Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
> index 39c4c6731094..157ef532a6a2 100644
> --- a/lib/mpi/mpicoder.c
> +++ b/lib/mpi/mpicoder.c
> @@ -504,7 +501,8 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
>  
>  	while (sg_miter_next(&miter)) {
>  		buff = miter.addr;
> -		len = miter.length;
> +		len = min_t(unsigned, miter.length, nbytes);
> +		nbytes -= len;
>  
>  		for (x = 0; x < len; x++) {
>  			a <<= 8;

That's fine, I guess.  One quirk of the above approach is that if the last
needed element of the scatterlist has a lot of extra pages, this will iterate
through all those extra pages, processing 0 bytes from each.  It could just stop
when done.  I suppose it's not worth worrying about that case, though.

- Eric
