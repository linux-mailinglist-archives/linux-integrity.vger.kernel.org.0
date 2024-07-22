Return-Path: <linux-integrity+bounces-3224-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC34938FDA
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2024 15:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7851D28191B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2024 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABB516D32D;
	Mon, 22 Jul 2024 13:24:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB816A38B;
	Mon, 22 Jul 2024 13:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654694; cv=none; b=tOhKFym4tbClfS96cWtIpq+c+YwCapg/3UGjB0j4hakQAUkJHSuuNLD5t18oxQMqS6sYS+RhNFAKaR5F4pAcrED8CLEoIae6cYBcio2tvQZyceEik+1oPQxjndw8xCRheYQlGIYVkkfx/CaugpRNfTRn+U6R0CHkTybcZiJpNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654694; c=relaxed/simple;
	bh=2BpJsPdlxUMrpsvgLLfigFUTFaZc7fnvSQoalYgm214=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUcvrrMzSVVNdh1arPXLYqvkJybmA4dNNENs2a93Fu8M7RQHCp/j4whJTA0GGV4IPBAcxzVsrF7mmXalreaWUDNgrjkSysgJu8Tgty+LyMPyam9UCYBF8bfAJ2wT2WEHoEdTUIwSYXI2z/1FmLCxWk/C16TjL4YkIiIqydptj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 39FF8100DA1C4;
	Mon, 22 Jul 2024 15:17:34 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E785A9F86C; Mon, 22 Jul 2024 15:17:33 +0200 (CEST)
Date: Mon, 22 Jul 2024 15:17:33 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	dhowells@redhat.com, zohar@linux.ibm.com, jarkko@kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	patrick@puiterwijk.org
Subject: Re: [PATCH v12 02/10] crypto: Add support for ECDSA signature
 verification
Message-ID: <Zp5b7ZQaXfGbkCVC@wunner.de>
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
 <20210316210740.1592994-3-stefanb@linux.ibm.com>
 <ZpfuqeSVC47jqme2@wunner.de>
 <6eee0c55-40cd-4e7b-8819-1a4c9596062a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eee0c55-40cd-4e7b-8819-1a4c9596062a@linux.ibm.com>

On Mon, Jul 22, 2024 at 08:19:41AM -0400, Stefan Berger wrote:
> On 7/17/24 12:17, Lukas Wunner wrote:
> > On Tue, Mar 16, 2021 at 05:07:32PM -0400, Stefan Berger wrote:
> > > +/*
> > > + * Get the r and s components of a signature from the X509 certificate.
> > > + */
> > > +static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
> > > +				  const void *value, size_t vlen, unsigned int ndigits)
> > > +{
> > > +	size_t keylen = ndigits * sizeof(u64);
> > > +	ssize_t diff = vlen - keylen;
> > > +	const char *d = value;
> > > +	u8 rs[ECC_MAX_BYTES];
> > > +
> > > +	if (!value || !vlen)
> > > +		return -EINVAL;
> > > +
> > > +	/* diff = 0: 'value' has exacly the right size
> > > +	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
> > > +	 *           makes the value a positive integer; error on more
> > > +	 * diff < 0: 'value' is missing leading zeros, which we add
> > > +	 */
> > > +	if (diff > 0) {
> > > +		/* skip over leading zeros that make 'value' a positive int */
> > > +		if (*d == 0) {
> > > +			vlen -= 1;
> > > +			diff--;
> > > +			d++;
> > > +		}
> > > +		if (diff)
> > > +			return -EINVAL;
> > > +	}
> > > +	if (-diff >= keylen)
> > > +		return -EINVAL;
> > 
> > There's an oddity in the above-quoted function.  The check ...
> > 
> > +	if (-diff >= keylen)
> > +		return -EINVAL;
> > 
> > ... seems superfluous.
> 
> You're right, this check is not necessary.

After staring at the code a little longer I've realized that
the purpose of this if-clause is likely to check for a signed
integer overflow.  So it *does* seem to have a purpose,
but it's quite subtle and not very obvious.

I've provisionally added the (untested) commit below to my
development branch to make it more obvious what's going on.
Using check_sub_overflow() might be an alternative.

I want to ask mips maintainers first whether signed integer
overflows can really cause an exception on their arch
as commit 36ccf1c0e391 suggests, despite -fno-strict-overflow...

-- >8 --

Subject: [PATCH] crypto: ecdsa - Avoid signed integer overflow on signature
 decoding

When extracting a signature component R or S from an ASN.1-encoded
integer, ecdsa_get_signature_rs() subtracts the expected length
"bufsize" from the ASN.1 length "vlen" (both of unsigned type size_t)
and stores the result in "diff" (of signed type ssize_t).

This results in a signed integer overflow if vlen > SSIZE_MAX + bufsize.

The kernel is compiled with -fno-strict-overflow, which implies -fwrapv,
meaning signed integer overflow is not undefined behavior.  And the
function does check for overflow:

       if (-diff >= bufsize)
               return -EINVAL;

However that's not very readable and may trigger a false-positive with
CONFIG_UBSAN_SIGNED_WRAP=y.  It also seems that certain Mips CPUs may
raise an exception regardless of -fno-strict-overflow (see do_ov() in
arch/mips/kernel/traps.c).

Avoid by comparing the two unsigned variables directly and erroring out
if "vlen" is too large.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/ecdsa.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 08c2c76..0cead9b 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -36,29 +36,20 @@ static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
 				  const void *value, size_t vlen, unsigned int ndigits)
 {
 	size_t bufsize = ndigits * sizeof(u64);
-	ssize_t diff = vlen - bufsize;
 	const char *d = value;
 
-	if (!value || !vlen)
+	if (!value || !vlen || vlen > bufsize + 1)
 		return -EINVAL;
 
-	/* diff = 0: 'value' has exacly the right size
-	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
-	 *           makes the value a positive integer; error on more
-	 * diff < 0: 'value' is missing leading zeros
-	 */
-	if (diff > 0) {
+	if (vlen > bufsize) {
 		/* skip over leading zeros that make 'value' a positive int */
 		if (*d == 0) {
 			vlen -= 1;
-			diff--;
 			d++;
-		}
-		if (diff)
+		} else {
 			return -EINVAL;
+		}
 	}
-	if (-diff >= bufsize)
-		return -EINVAL;
 
 	ecc_digits_from_bytes(d, vlen, dest, ndigits);
 
-- 
2.43.0

