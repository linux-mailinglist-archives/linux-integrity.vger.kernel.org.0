Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042B832FE19
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Mar 2021 01:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhCGAD3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Mar 2021 19:03:29 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:35862 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhCGADN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Mar 2021 19:03:13 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C418D72C8B8;
        Sun,  7 Mar 2021 03:03:10 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A896C4A4736;
        Sun,  7 Mar 2021 03:03:10 +0300 (MSK)
Date:   Sun, 7 Mar 2021 03:03:10 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
Subject: Re: [PATCH v10 3/9] crypto: Add math to support fast NIST P384
Message-ID: <20210307000310.ytes6la73x5bkori@altlinux.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-4-stefanb@linux.vnet.ibm.com>
 <20210306192553.lxy5w262g2vs2hvv@altlinux.org>
 <9ac456d7-a5e1-9e42-5d34-7dc1c70082e0@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ac456d7-a5e1-9e42-5d34-7dc1c70082e0@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Sat, Mar 06, 2021 at 06:29:18PM -0500, Stefan Berger wrote:
> On 3/6/21 2:25 PM, Vitaly Chikunov wrote:
> > 
> > On Thu, Mar 04, 2021 at 07:51:57PM -0500, Stefan Berger wrote:
> > > From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> > > 
> > > * crypto/ecc.c
> > >    - add vli_mmod_fast_384
> > >    - change some routines to pass ecc_curve forward until vli_mmod_fast
> > > 
> > > * crypto/ecc.h
> > >    - add ECC_CURVE_NIST_P384_DIGITS
> > >    - change ECC_MAX_DIGITS to P384 size
> > > 
> > > Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> > > Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >   crypto/ecc.c | 266 +++++++++++++++++++++++++++++++++++++--------------
> > >   crypto/ecc.h |   3 +-
> > >   2 files changed, 194 insertions(+), 75 deletions(-)
> > > 
> > > diff --git a/crypto/ecc.c b/crypto/ecc.c
> > > index f6cef5a7942d..c125576cda6b 100644
> > > --- a/crypto/ecc.c
> > > +++ b/crypto/ecc.c
> > > @@ -778,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
> > >   ...
> > >   /* Computes result = product % curve_prime for different curve_primes.
> > >    *
> > >    * Note that curve_primes are distinguished just by heuristic check and
> > >    * not by complete conformance check.
> > >    */
> > >   static bool vli_mmod_fast(u64 *result, u64 *product,
> > > -			  const u64 *curve_prime, unsigned int ndigits)
> > > +			  const struct ecc_curve *curve)
> > >   {
> > >   	u64 tmp[2 * ECC_MAX_DIGITS];
> > > +	const u64 *curve_prime = curve->p;
> > > +	const unsigned int ndigits = curve->g.ndigits;
> > > -	/* Currently, both NIST primes have -1 in lowest qword. */
> > > -	if (curve_prime[0] != -1ull) {
> > > +	/* Currently, all NIST have name nist_.* */
> > > +	if (strncmp(curve->name, "nist_", 5) != 0) {
> > I am not sure, but maybe this strncmp should not be optimized somehow,
> > since vli_mmod_fast could be called quite frequently. Perhaps by integer
> > algo id or even callback?
> 
> Should be optimized or should not be? You seem to say both.

Excuse me for the typo. I meant "should be optimized". I think, maybe
it's time to add algo selector id (for the case statement, for example
instead of `switch (ndigits)') or just callback for a low level mmod
function.

If you think this would not impact performance then nevermind.

Thanks,

> 
> The code code here is shared with ecrdsa. The comparison won't go beyond a
> single letter considering the naming of the curves define here:
> 
> "cp256a":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecrdsa_defs.h#L49
> 
> "cp256b":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecrdsa_defs.h#L82
> 
> "cp256c":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecrdsa_defs.h#L119
> 
> "tc512a":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecrdsa_defs.h#L168
> 
> and here:
> 
> "nist_192":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecc_curve_defs.h#L18
> 
> "nist_256":
> https://elixir.bootlin.com/linux/v5.11.3/source/crypto/ecc_curve_defs.h#L45
> 
> 
> All the ecrdsa curves were previously evaluating 'curve_prime[0] != -1ull',
> so it doesn't change anything.
> 
> š Stefan
> 
