Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B498F4BD2B8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 00:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiBTX3B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Feb 2022 18:29:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiBTX27 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Feb 2022 18:28:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE0496B2;
        Sun, 20 Feb 2022 15:28:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4384E60FD9;
        Sun, 20 Feb 2022 23:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C1FC340E8;
        Sun, 20 Feb 2022 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645399715;
        bh=NGzxvchR/XKS/H11TfbsETpwYH20C/eVSWJ+/54LLcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsOi5JdyZDnGJDVngTr0zD0ykmEPcO255ZCthkaf8SmNJAyCOfB63wyYsKNni09t0
         t7A+4M9jYS1cIeHOClgcASuMjla3EC/nYDU/g+Rn8bMhfcYGQuEDKeCgR9DN3gMViq
         WF4Se1mpgsyPxUlLoIRakMteQTB2RABkUEvO38EhzNaDi3s2RlumowOnq4cRpxJkX0
         Ti7Fth0ey2Q5c5DkxJHa4qFZcdrj7pGlzlveJMPS7JkU5vGgNSG3a6CkH5u67bDbeO
         lDC1ek14Fl1c4mh+OtKd9pRR6lUzQOCIW/UCvk+SHl3tgXMX3EQlawQ5xhi/l6Sv62
         CoamFtn2CZMXg==
Date:   Mon, 21 Feb 2022 00:29:13 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>, keyrings@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [RFC PATCH] KEYS: Double max_size to make keyctl pkey_verify work
Message-ID: <YhLOyUgSihcdoNJc@iki.fi>
References: <20220202065906.2598366-1-vt@altlinux.org>
 <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9d973f-847e-e8bc-95fb-6c98a98a02e6@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Thank you for the trouble of providing this great explanation. This
reasoning should be included to the commit message for future reference.

It would be also nice to encapsulate this calculation to an inline
function.

/Jarkko
