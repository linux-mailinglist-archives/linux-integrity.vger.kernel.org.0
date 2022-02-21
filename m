Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40B4BD3E9
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 03:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbiBUCoX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 21:44:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343789AbiBUCoW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 21:44:22 -0500
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 535DD27169;
        Sun, 20 Feb 2022 18:43:59 -0800 (PST)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E557672C905;
        Mon, 21 Feb 2022 05:43:57 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B29824A46EA;
        Mon, 21 Feb 2022 05:43:57 +0300 (MSK)
Date:   Mon, 21 Feb 2022 05:43:57 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <20220221024357.uilp5y77zpgktl6c@altlinux.org>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
 <YhLOyUgSihcdoNJc@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <YhLOyUgSihcdoNJc@iki.fi>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 21, 2022 at 12:29:13AM +0100, Jarkko Sakkinen wrote:
> On Wed, Feb 02, 2022 at 10:15:24PM -0500, Stefan Berger wrote:
> > 
> > On 2/2/22 01:59, Vitaly Chikunov wrote:
> > > Rarely used `keyctl pkey_verify' can verify raw signatures, but was
> > > failing, because ECDSA/EC-RDSA signature sizes are twice key sizes which
> > > does not pass in/out sizes check in keyctl_pkey_params_get_2.
> > > This in turn because these values cannot be distinguished by a single
> > > `max_size' callback return value.
> > > Also, `keyctl pkey_query` displays incorrect `max_sig_size' about these
> > > algorithms.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >   crypto/asymmetric_keys/public_key.c | 15 +++++++++++++--
> > >   1 file changed, 13 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> > > index 4fefb219bfdc..3ffbab07ed2a 100644
> > > --- a/crypto/asymmetric_keys/public_key.c
> > > +++ b/crypto/asymmetric_keys/public_key.c
> > > @@ -143,8 +143,19 @@ static int software_key_query(const struct kernel_pkey_params *params,
> > >   	len = crypto_akcipher_maxsize(tfm);
> > >   	info->key_size = len * 8;
> > > -	info->max_data_size = len;
> > > -	info->max_sig_size = len;
> > > +	if (strcmp(alg_name, "ecrdsa") == 0 ||
> > > +	    strncmp(alg_name, "ecdsa-", 6) == 0) {
> > > +		/*
> > > +		 * For these algos sig size is twice key size.
> > > +		 * keyctl uses max_sig_size as minimum input size, and
> > > +		 * max_data_size as minimum output size for a signature.
> > > +		 */
> > > +		info->max_data_size = len * 2;
> > > +		info->max_sig_size = len * 2;
> > I don't know about the data size but following my tests this is not enough
> > for ECDSA signature size. In ECDSA case the r and s components of the
> > signature are encode in asn.1, not 'raw'. So there are 2 bytes at the
> > beginning for sequence identifier , 2 bytes asn.1 for the r component, 1
> > additional 0-byte to make the r component always a positive number, then the
> > r component, then 2 bytes asn.1 for the s component, 1 addition 0-byte to
> > make the s component a positive number, then the s component. Phew.
> > 
> > info->max_sig_size = 2 + (2 + 1 + len) * 2;
> > 
> > so for NIST P384 it's: 2 + (2+1+48) * 2 = 104
> > 
> > Then it works for me as well.
> 
> Thank you for the trouble of providing this great explanation. This
> reasoning should be included to the commit message for future reference.
> 
> It would be also nice to encapsulate this calculation to an inline
> function.

I wanted to discuss if there's a better way to do it. For example,
instead of calculating algorithm specific information in
software_key_query maybe we should extend akcipher_alg API with a
pkey_params request (just for keyctl)?

Also, there possible other solution - instead of setting info in
software_key_query depending on algo (as in this patch), it's possible
(in a hackish way) just to return larger value from
akcipher_alg::max_size. But this will possible somewhat confuse keyctl
users, as, for example, they will see arbitrary value for a key_size.

Currently, this patch is the simplest non-confusing solution, and it's
in accord with how we calculate algorithm specific things all around
the code base (outside of algorithm implementation itself).

Thanks,

> 
> /Jarkko
