Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75244544320
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jun 2022 07:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiFIFYi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 01:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiFIFYa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 01:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F06CB854;
        Wed,  8 Jun 2022 22:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B6E861D07;
        Thu,  9 Jun 2022 05:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C954C34114;
        Thu,  9 Jun 2022 05:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654752266;
        bh=gR7Tftbpm2rm+WC0YD9ESf+wexNbl5yDTu6oejUROKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9xN8uACyHgE4TBurpqUMrazZhTOO7WCxnzZBwK6zSNWSO1JoWukpOw47b8aNjrSX
         TS/Qns8mKxpVAEKe18gWhZaUGbW1nS+tsLj2OVqdoky/35nf5wGa1aJPXpEz56mS2Q
         Hnbsx7MQua2CwtHMrlZ4LzJmq3GHsE6iNVz0LiyPEY/siNq/RpfQS6oBjGOiK60Cvk
         Y332UIEw9MxqvqxVG+7087cxgE75a926Q49m/ORQoMvunjWw1YbNKWKwQdnttYHZaq
         bh5/GQXo0UE8cNuWKSJCU5zA7kirNBzKLHHb0DbPSfRP3ZTw4HHM8tUiUWoWyRUgBP
         beWN8V2YZopfA==
Date:   Thu, 9 Jun 2022 08:22:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Message-ID: <YqGDlYGGOvC8rkf6@iki.fi>
References: <20220608131732.550234-1-niejianglei2021@163.com>
 <YqGDTVa64aknbldb@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqGDTVa64aknbldb@iki.fi>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 09, 2022 at 08:21:20AM +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 08, 2022 at 09:17:32PM +0800, Jianglei Nie wrote:
> > tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
> > but it is never freed, which leads to a memory leak. Free the memory
> > chunk with kfree() in the return path.
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> 
> You should write down the changelog ere. No idea what changed
> from the previous version.
> 
> >  security/keys/trusted-keys/trusted_tpm2.c | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> > index 0165da386289..8b7ab22950d1 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -32,6 +32,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  			   struct trusted_key_options *options,
> >  			   u8 *src, u32 len)
> >  {
> > +	int err;
> 
> Declare as the last local variable (reverse christmas tree order).
> 
> Also, I'd use "int ret" since in other functions that is used.
> 
> >  	const int SCRATCH_SIZE = PAGE_SIZE;
> >  	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> >  	u8 *work = scratch, *work1;
> > @@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  		unsigned char bool[3], *w = bool;
> >  		/* tag 0 is emptyAuth */
> >  		w = asn1_encode_boolean(w, w + sizeof(bool), true);
> > -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
> > -			return PTR_ERR(w);
> > +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
> > +			err = PTR_ERR(w);
> > +			goto out;
> > +		}
> >  		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
> >  	}
> >  
> > @@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  	 * trigger, so if it does there's something nefarious going on
> >  	 */
> >  	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
> > -		 "BUG: scratch buffer is too small"))
> > -		return -EINVAL;
> > +		 "BUG: scratch buffer is too small")) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> >  
> >  	work = asn1_encode_integer(work, end_work, options->keyhandle);
> >  	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
> > @@ -79,10 +84,16 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
> >  	work1 = payload->blob;
> >  	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
> >  				     scratch, work - scratch);
> > -	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
> > -		return PTR_ERR(work1);
> > +	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
> > +		err = -EINVAL;
> > +		goto out;
> 
> Why you are changing the return value from PTR_ERR(work1
> to -EINVAL?
> 
> > +	}
> > +	kfree(scratch);
> >  
> >  	return work1 - payload->blob;
> > +
> > +out:
> 
> Nit:
> 
> err:
> 
> It's only used for the error path.
> 
> > +	return err;
> >  }
> >  
> >  struct tpm2_key_context {
> > -- 
> > 2.25.1
> > 
> 
> BR, Jarkko

And the patch is also missing fixes tag:

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")

BR, Jarkko
