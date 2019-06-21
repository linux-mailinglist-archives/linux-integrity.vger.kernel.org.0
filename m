Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176564E70D
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2019 13:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfFULW3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Jun 2019 07:22:29 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51742 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFULW3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Jun 2019 07:22:29 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1F41B72CC6C;
        Fri, 21 Jun 2019 14:22:26 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 09E094A4A29;
        Fri, 21 Jun 2019 14:22:26 +0300 (MSK)
Date:   Fri, 21 Jun 2019 14:22:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 01/11] ima-evm-utils: Make sure sig buffer is always
 MAX_SIGNATURE_SIZE
Message-ID: <20190621112225.sf6rtxzc2pu4oyfh@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
 <20190618135623.6861-2-vt@altlinux.org>
 <1561066938.4057.18.camel@linux.ibm.com>
 <20190621065913.a3plltlinylkdkeb@altlinux.org>
 <1561115292.4057.70.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561115292.4057.70.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Jun 21, 2019 at 07:08:12AM -0400, Mimi Zohar wrote:
> On Fri, 2019-06-21 at 09:59 +0300, Vitaly Chikunov wrote:
> > On Thu, Jun 20, 2019 at 05:42:18PM -0400, Mimi Zohar wrote:
> > > On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> > > > Fix off-by-one error of the output buffer passed to sign_hash().
> > > > 
> > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > > ---
> > > >  src/evmctl.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > > index 15a7226..03f41fe 100644
> > > > --- a/src/evmctl.c
> > > > +++ b/src/evmctl.c
> > > > @@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> > > >  static int sign_evm(const char *file, const char *key)
> > > >  {
> > > >  	unsigned char hash[MAX_DIGEST_SIZE];
> > > > -	unsigned char sig[MAX_SIGNATURE_SIZE];
> > > > +	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
> > > >  	int len, err;
> > > > 
> > > >  	len = calc_evm_hash(file, hash);
> > > > @@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
> > > >  		return len;
> > > > 
> > > >  	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> > > > -	assert(len < sizeof(sig));
> > > > +	assert(len <= MAX_SIGNATURE_SIZE);
> > > >  	if (len <= 1)
> > > >  		return len;
> > > > 
> > > 
> > > A similar problem occurs in sign_ima. šWithout these changes
> > > sign_hash() succeeds, returning a length of 520 for
> > > sha256/streebog256. 
> > 
> > I will add it. Also, I found more similar errors and will fix them together.
> 
> The first byte of sig is reserved for the type of signature. šThe
> remaining buffer is for the signature itself. šThe existing
> "assert(len < sizeof(sig))" is therefore correct. šThe sig size being
> returned is less than 1023, so why is this change needed?

Well, it looked more straightforward to check explicit
MAX_SIGNATURE_SIZE instead of relying on that '<' accounts for
that additional byte.

Main fix is of course this:

> > > > -       unsigned char sig[MAX_SIGNATURE_SIZE];
> > > > +       unsigned char sig[MAX_SIGNATURE_SIZE + 1];

I will revert all that `assert(len <= MAX_SIGNATURE_SIZE)` back to
`assert(len < sizeof(sig))`.

Thanks,

