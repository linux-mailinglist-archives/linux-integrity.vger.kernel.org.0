Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC46527DD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Dec 2022 21:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiLTUaX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Dec 2022 15:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLTUaW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Dec 2022 15:30:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08506BCBB;
        Tue, 20 Dec 2022 12:30:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FCCB8197A;
        Tue, 20 Dec 2022 20:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B110C433D2;
        Tue, 20 Dec 2022 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671568218;
        bh=sru7LQzWJgHhTjq6GGgq1igtkj+AD/SkpfcWXzTJ0tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dc346weOE7CjZdtk6aJU8cIiWUvyMmIAz1qs8SsVmoOGwSibZi2W8kzYotUXZdMet
         r4DxSdAYwFEQRnWz9P5axU3/iN/AZB+/OwfNtBVn5k/6UhkgkOLGX9r3foFlUl3Pv1
         qvIyr8zoJgnWyVNmKCokwOqjkW4qIbnEtfFEvYKquv6wIbX5qzL9IKdzQPwdahl4Nk
         9p+46oNa5XnMqkbit+txcwdAe0Hwaxoc6fJJn0RxJvXsp0m9Vw8P9b3w+BC0QeajCT
         AEvkM4BPuj6dh/LyhDxyrXJABgJV9XMwzNdOgZ4RMkSYMdHQqFLcu+QFce0fhm3+v6
         N3Xqgep6f2rCg==
Date:   Tue, 20 Dec 2022 20:30:16 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>, dhowells@redhat.com,
        davem@davemloft.net, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Subject: Re: [PATCH] lib/mpi: Fix buffer overrun when SG is too long
Message-ID: <Y6IbWA5aZeBnn4n2@gmail.com>
References: <20221209150633.1033556-1-roberto.sassu@huaweicloud.com>
 <Y5OGr59A9wo86rYY@sol.localdomain>
 <fa8a307541735ec9258353d8ccb75c20bb22aafe.camel@huaweicloud.com>
 <Y5bxJ5UZNPzxwtoy@gondor.apana.org.au>
 <0f80852578436dbba7a0fce03d86c3fa2d38c571.camel@huaweicloud.com>
 <Y6FjQPZiJYTEG1zI@gondor.apana.org.au>
 <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04e6458-6814-97fc-f03a-617809e2e6ce@huaweicloud.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Dec 20, 2022 at 11:36:50AM +0100, Roberto Sassu wrote:
> On 12/20/2022 8:24 AM, Herbert Xu wrote:
> > On Mon, Dec 19, 2022 at 09:49:29AM +0100, Roberto Sassu wrote:
> > > 
> > > do you have any news on this bug?
> > 
> > Thanks for the reminder.  Could you please try this patch?
> 
> Tried, could not boot the UML kernel.
> 
> After looking, it seems we have to call sg_miter_stop(). Or alternatively,
> we could let sg_miter_next() be called but not writing anything inside the
> loop.
> 
> With either of those fixes, the tests pass (using one scatterlist).
> 
> Roberto
> 
> > ---8<---
> > The helper mpi_read_raw_from_sgl ignores the second parameter
> > nbytes when reading the SG list and may overrun its own buffer
> > because it only allocates enough memory according to nbytes.
> > 
> > Fixes: 2d4d1eea540b ("lib/mpi: Add mpi sgl helpers")
> > Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > 
> > diff --git a/lib/mpi/mpicoder.c b/lib/mpi/mpicoder.c
> > index 39c4c6731094..6bffc68c1a5a 100644
> > --- a/lib/mpi/mpicoder.c
> > +++ b/lib/mpi/mpicoder.c
> > @@ -494,17 +494,15 @@ MPI mpi_read_raw_from_sgl(struct scatterlist *sgl, unsigned int nbytes)
> >   	val->sign = 0;
> >   	val->nlimbs = nlimbs;
> > -	if (nbytes == 0)
> > -		return val;
> > -
> >   	j = nlimbs - 1;
> >   	a = 0;
> >   	z = BYTES_PER_MPI_LIMB - nbytes % BYTES_PER_MPI_LIMB;
> >   	z %= BYTES_PER_MPI_LIMB;
> > -	while (sg_miter_next(&miter)) {
> > +	while (nbytes && sg_miter_next(&miter)) {
> >   		buff = miter.addr;
> > -		len = miter.length;
> > +		len = min_t(unsigned, miter.length, nbytes);
> > +		nbytes -= len;
> >   		for (x = 0; x < len; x++) {
> >   			a <<= 8;

I think it should look like:

	while (nbytes) {
		sg_miter_next(&miter);
		...
	}
	sg_miter_stop(&miter);

- Eric
