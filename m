Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6780F309EDE
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhAaUYx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 31 Jan 2021 15:24:53 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:54712 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhAaUWe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 31 Jan 2021 15:22:34 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A5F3472C8B4;
        Sun, 31 Jan 2021 20:56:23 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 8EA5C4A4712;
        Sun, 31 Jan 2021 20:56:23 +0300 (MSK)
Date:   Sun, 31 Jan 2021 20:56:23 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils] ima-evm-utils: ima_sign supports SM2 and
 SM3 algorithm combination
Message-ID: <20210131175623.pbtdmeyvyeoenk3j@altlinux.org>
References: <20210131032721.79050-1-tianjia.zhang@linux.alibaba.com>
 <20210131174845.gbvqd5l5o2tibpbf@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210131174845.gbvqd5l5o2tibpbf@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Jan 31, 2021 at 08:48:46PM +0300, Vitaly Chikunov wrote:
> Tianjia,
> 
> On Sun, Jan 31, 2021 at 11:27:21AM +0800, Tianjia Zhang wrote:
> > The combination of SM2 and SM3 algorithms has been implemented in the
> > kernel. At present, the ima-evm-utils signature tool does not support
> > this combination of algorithms. This is because SM2 sign require a
> > USERID, which requires the use of a higher-level sign functions of
> > OpenSSL. this patch use the EVP_DigestSign series of functions to
> > sign to support various signature algorithm combinations.
> > 
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> >  src/libimaevm.c | 37 +++++++++++++++++++++++++++++++------
> >  1 file changed, 31 insertions(+), 6 deletions(-)
> > 
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index fa6c278..89b9b88 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -891,6 +891,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >  	EVP_PKEY *pkey;
> >  	char name[20];
> >  	EVP_PKEY_CTX *ctx = NULL;
> > +	EVP_MD_CTX *mctx = NULL;
> >  	const EVP_MD *md;
> >  	size_t sigsize;
> >  	const char *st;
> > @@ -932,24 +933,47 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >  		return -1;
> >  	}
> >  
> > +#if OPENSSL_VERSION_NUMBER < 0x30000000
> 
> Perhaps, this check is not needed at all if it isn't enabled for new
> openssl?
> 
> 
> > +	/*
> > +	 * SM2 and SM3 should go together. If SM3 hash algorithm and EC private
> > +	 * key are used at the same time, check whether it is SM2 private key.
> > +	 */
> > +	if (hdr->hash_algo == PKEY_HASH_SM3_256 && EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
> > +		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
> > +		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
> > +		if (curve == NID_sm2)
> > +			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
> > +	}
> > +#endif
> > +
> >  	calc_keyid_v2(&keyid, name, pkey);
> >  	hdr->keyid = keyid;
> >  
> >  	st = "EVP_PKEY_CTX_new";
> >  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> >  		goto err;
> > -	st = "EVP_PKEY_sign_init";
> > -	if (!EVP_PKEY_sign_init(ctx))
> > +	st = "EVP_MD_CTX_new";
> > +	if (!(mctx = EVP_MD_CTX_new()))
> >  		goto err;
> > +	if (EVP_PKEY_id(pkey) == EVP_PKEY_SM2) {
> > +		st = "EVP_PKEY_CTX_set1_id";
> > +		/* Set SM2 default userid */
> > +		if (!EVP_PKEY_CTX_set1_id(ctx, "1234567812345678", 16))
> 
> You cannot call EVP_PKEY_CTX_set1_id for EVP_PKEY_sign's ctx?
> I don't really get the API change. Can you explain more this
> requirement?

EVP_PKEY_sign should be able to sign with any algo, unless there is
openssl bug. Is there bug preventing SM2 signing with EVP_PKEY_sign?

> 
> Thanks,
> 
> > +			goto err;
> > +	}
> > +	EVP_MD_CTX_set_pkey_ctx(mctx, ctx);
> >  	st = "EVP_get_digestbyname";
> >  	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
> >  		goto err;
> > -	st = "EVP_PKEY_CTX_set_signature_md";
> > -	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> > +	st = "EVP_DigestSignInit";
> > +	if (!EVP_DigestSignInit(mctx, NULL, md, NULL, pkey))
> > +		goto err;
> > +	st = "EVP_DigestSignUpdate";
> > +	if (!EVP_DigestSignUpdate(mctx, hash, size))
> >  		goto err;
> > -	st = "EVP_PKEY_sign";
> > +	st = "EVP_DigestSignFinal";
> >  	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
> > -	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
> > +	if (!EVP_DigestSignFinal(mctx, hdr->sig, &sigsize))
> >  		goto err;
> >  	len = (int)sigsize;
> >  
> > @@ -964,6 +988,7 @@ err:
> >  			ERR_reason_error_string(ERR_peek_error()), st);
> >  		output_openssl_errors();
> >  	}
> > +	EVP_MD_CTX_free(mctx);
> >  	EVP_PKEY_CTX_free(ctx);
> >  	EVP_PKEY_free(pkey);
> >  	return len;
> > -- 
> > 2.19.1.3.ge56e4f7
