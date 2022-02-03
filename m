Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A17F4A7E5B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Feb 2022 04:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbiBCDez (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 22:34:55 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:43476 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiBCDey (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 22:34:54 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 12D9A72C8FA;
        Thu,  3 Feb 2022 06:34:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id CE9174A46F0;
        Thu,  3 Feb 2022 06:34:52 +0300 (MSK)
Date:   Thu, 3 Feb 2022 06:34:52 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <20220203033452.ft57ma5gj6cb7zhm@altlinux.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Feb 02, 2022 at 10:15:24PM -0500, Stefan Berger wrote:
> 
> On 2/2/22 01:59, Vitaly Chikunov wrote:
> > Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> > failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> > does not pass in/out sizes check in keyctl_pkey_params_get_2.
> > This in turn because these values cannot be distinguished by a single
> > `max_size' callback return value.
> > Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> > algorithms.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >   crypto/asymmetric_keys/public_key.c | 15 +++++++++++++--
> >   1 file changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> > index 4fefb219bfdc..3ffbab07ed2a 100644
> > --- a/crypto/asymmetric_keys/public_key.c
> > +++ b/crypto/asymmetric_keys/public_key.c
> > @@ -143,8 +143,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
> >   	len = crypto_akcipher_maxsize(tfm);
> >   	info->key_size = len * 8;
> > -	info->max_data_size = len;
> > -	info->max_sig_size = len;
> > +	if (strcmp(alg_name, "ecrdsa") == 0 ||
> > +	    strncmp(alg_name, "ecdsa-", 6) == 0) {
> > +		/*
> > +		 * For these algos sig size is twice key size.
> > +		 * keyctl uses max_sig_size as minimum input size, and
> > +		 * max_data_size as minimum output size for a signature.
> > +		 */
> > +		info->max_data_size = len * 2;
> > +		info->max_sig_size = len * 2;
> I don't know about the data size but following my tests this is not enough
> for ECDSA signature size. In ECDSA case the r and s components of the
> signature are encode in asn.1, not 'raw'. So there are 2 bytes at the
> beginning for sequence identifier , 2 bytes asn.1 for the r component, 1
> additional 0-byte to make the r component always a positive number, then the
> r component, then 2 bytes asn.1 for the s component, 1 addition 0-byte to
> make the s component a positive number, then the s component. Phew.
> 
> info->max_sig_size = 2 + (2 + 1 + len) * 2;
> 
> so for NIST P384 it's: 2 + (2+1+48) * 2 = 104
> 
> Then it works for me as well.

Well, another solution, without changing API, is that max_size() should
return bigger size (to fit encoded signature), but in that case keyctl
will think wrongly about key_size.

Just for reference, keyctl_pkey_params_get_2 check that needs to be
passed:

        case KEYCTL_PKEY_VERIFY:
                if (uparams.in_len  > info.max_sig_size ||
                    uparams.out_len > info.max_data_size)
                        return -EINVAL;

So we can return arbitrarily big value, in theory.

Thanks,

> 
> 
> > +	} else {
> > +		info->max_data_size = len;
> > +		info->max_sig_size = len;
> > +	}
> >   	info->max_enc_size = len;
> >   	info->max_dec_size = len;
> >   	info->supported_ops = (KEYCTL_SUPPORTS_ENCRYPT |
