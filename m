Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB5662B02A
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Nov 2022 01:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKPAjz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Nov 2022 19:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiKPAjy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Nov 2022 19:39:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14739633C;
        Tue, 15 Nov 2022 16:39:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BABA7B81BA2;
        Wed, 16 Nov 2022 00:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E5EC433D7;
        Wed, 16 Nov 2022 00:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668559191;
        bh=1s7px/nO60i1VmDsd4dRpmRql6FYfuQZsJ0QA09gMPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TlHN63iVnK8twn+tWlJj0hsD4dr9tBjDS3R1hMMmQoS7FA24/fDQDt8zJLfgEgfkG
         DrjrFzmXIKNLuAetlsKNDqNoZmr99v6cZVjVOlctyHw9UWX0yQG6eNBD6OX0EneV9Q
         SFZMCD2x0t2AQfVKYQXjRQGGkR0Boo/QHmXf7RgMb22cg/dW38UgL7gZU9jObStTbi
         2n2Furdl2G5PAZBn4lBHkUhjPRu7QODdFc2GETp/OiyFQ7XVFNIwS3h84ug7rU1QAQ
         52bodGV7l4VlYEr+dq4nM3o2RWDx2tDuHLdoC20fE0HqU8fmW0VJcA4oWflYT67/bj
         SUg7DkRnZO/vQ==
Date:   Wed, 16 Nov 2022 02:39:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jerome Forissier <jerome.forissier@linaro.org>
Subject: Re: [PATCH] KEYS: trusted: tee: Make registered shm dependency
 explicit
Message-ID: <Y3QxVI2LIHZblYPq@kernel.org>
References: <20221110111140.1999538-1-sumit.garg@linaro.org>
 <CAFA6WYMKSjvgNgbf=cJXiTE3LitS-whtRbqJW1cdkHMJ1TsdUg@mail.gmail.com>
 <Y3Qv0hehr/yKNvy4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Qv0hehr/yKNvy4@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Nov 16, 2022 at 02:33:24AM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 10, 2022 at 04:44:20PM +0530, Sumit Garg wrote:
> > + Jarkko (Apologies I accidently missed you while sending the original patch).
> > 
> > On Thu, 10 Nov 2022 at 16:42, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > TEE trusted keys support depends on registered shared memory support
> > > since the key buffers are needed to be registered with OP-TEE. So make
> > > that dependency explicit to not register trusted keys support if
> > > underlying implementation doesn't support registered shared memory.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > Tested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tee.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> > > index c8626686ee1b..ac3e270ade69 100644
> > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > @@ -219,7 +219,8 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
> > >
> > >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
> > >  {
> > > -       if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> > > +       if (ver->impl_id == TEE_IMPL_ID_OPTEE &&
> > > +           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> > >                 return 1;
> > >         else
> > >                 return 0;
> > > --
> > > 2.34.1
> > >
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko
