Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79702F05BF
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Jan 2021 07:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbhAJGyV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Jan 2021 01:54:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:52862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbhAJGyV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Jan 2021 01:54:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17B9923884;
        Sun, 10 Jan 2021 06:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610261620;
        bh=zkbXK6BnoIMcnVylcGQ3Y2IBNNSj9bS1jAU9NzNCeiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bYQCbsBDLTQFKB/qib2gQU9NwhewXR0H5EQnYrmo2MSPdX1DozlrhICO6yGnoC+Z3
         tkxkopqVjgeDnjp3yr/jYG24F34Pxlx4VvSgPtHIu5WwsV62ZtoQT4c1eGEYLK1VI6
         szqUC09R9wk+YIHl/Br36iPzfo3sxWnKtACQWmzLi3eN5e1QhWHB+6Rgsr4zGiqGso
         SX2XbAlSoXUhoyZvNpTAHE1eL6MfNjclbD/ZUtwfmT5XpLE+UGreaLYcvWTegcQKz3
         Zep9eBTpbfz/F10vWx+OWGGP/D5CG20Lb0Gpzj3IivD7PJ+EdVkWd8al+lsJ4VYbaa
         c7sCoCOCOXinQ==
Date:   Sat, 9 Jan 2021 22:53:38 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] evm: Fix memleak in init_desc
Message-ID: <X/qkcgLg2h8Yxn3a@sol.localdomain>
References: <20210109113305.11035-1-dinghao.liu@zju.edu.cn>
 <X/nixOkNqQdWUAv8@sol.localdomain>
 <5a36a73a.2e704.176eac332ca.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a36a73a.2e704.176eac332ca.Coremail.dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 10, 2021 at 01:27:09PM +0800, dinghao.liu@zju.edu.cn wrote:
> > On Sat, Jan 09, 2021 at 07:33:05PM +0800, Dinghao Liu wrote:
> > > When kmalloc() fails, tmp_tfm allocated by
> > > crypto_alloc_shash() has not been freed, which
> > > leads to memleak.
> > > 
> > > Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
> > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > ---
> > >  security/integrity/evm/evm_crypto.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> > > index 168c3b78ac47..39fb31a638ac 100644
> > > --- a/security/integrity/evm/evm_crypto.c
> > > +++ b/security/integrity/evm/evm_crypto.c
> > > @@ -73,7 +73,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
> > >  {
> > >  	long rc;
> > >  	const char *algo;
> > > -	struct crypto_shash **tfm, *tmp_tfm;
> > > +	struct crypto_shash **tfm, *tmp_tfm = NULL;
> > >  	struct shash_desc *desc;
> > >  
> > >  	if (type == EVM_XATTR_HMAC) {
> > > @@ -118,13 +118,18 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
> > >  alloc:
> > >  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
> > >  			GFP_KERNEL);
> > > -	if (!desc)
> > > +	if (!desc) {
> > > +		if (tmp_tfm)
> > > +			crypto_free_shash(tmp_tfm);
> > >  		return ERR_PTR(-ENOMEM);
> > > +	}
> > >  
> > >  	desc->tfm = *tfm;
> > >  
> > >  	rc = crypto_shash_init(desc);
> > >  	if (rc) {
> > > +		if (tmp_tfm)
> > > +			crypto_free_shash(tmp_tfm);
> > >  		kfree(desc);
> > >  		return ERR_PTR(rc);
> > >  	}
> > 
> > There's no need to check for NULL before calling crypto_free_shash().
> > 
> 
> I find there is a crypto_shash_tfm() in the definition of 
> crypto_free_shash(). Will this lead to null pointer dereference
> when we use it to free a NULL pointer?
> 

No.  It does &tfm->base, not tfm->base.

- Eric
