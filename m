Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5A4E0B2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Jun 2019 08:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfFUG7T (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Jun 2019 02:59:19 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:37250 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFUG7T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Jun 2019 02:59:19 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 189D172CC68;
        Fri, 21 Jun 2019 09:59:16 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id F16064A4A29;
        Fri, 21 Jun 2019 09:59:15 +0300 (MSK)
Date:   Fri, 21 Jun 2019 09:59:15 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 01/11] ima-evm-utils: Make sure sig buffer is always
 MAX_SIGNATURE_SIZE
Message-ID: <20190621065913.a3plltlinylkdkeb@altlinux.org>
References: <20190618135623.6861-1-vt@altlinux.org>
 <20190618135623.6861-2-vt@altlinux.org>
 <1561066938.4057.18.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561066938.4057.18.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 20, 2019 at 05:42:18PM -0400, Mimi Zohar wrote:
> On Tue, 2019-06-18 at 16:56 +0300, Vitaly Chikunov wrote:
> > Fix off-by-one error of the output buffer passed to sign_hash().
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> >  src/evmctl.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 15a7226..03f41fe 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -510,7 +510,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
> >  static int sign_evm(const char *file, const char *key)
> >  {
> >  	unsigned char hash[MAX_DIGEST_SIZE];
> > -	unsigned char sig[MAX_SIGNATURE_SIZE];
> > +	unsigned char sig[MAX_SIGNATURE_SIZE + 1];
> >  	int len, err;
> > 
> >  	len = calc_evm_hash(file, hash);
> > @@ -519,7 +519,7 @@ static int sign_evm(const char *file, const char *key)
> >  		return len;
> > 
> >  	len = sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> > -	assert(len < sizeof(sig));
> > +	assert(len <= MAX_SIGNATURE_SIZE);
> >  	if (len <= 1)
> >  		return len;
> > 
> 
> A similar problem occurs in sign_ima. šWithout these changes
> sign_hash() succeeds, returning a length of 520 for
> sha256/streebog256. 

I will add it. Also, I found more similar errors and will fix them together.

>šWith these patches, for streebog256
> EVP_PKEY_CTX_set_signature_md is failing, returning -1,
> but works for sha256.

Probably your openssl does not support streebog256.

>šWith a similar change as this patch, it also works, returning
> 520.

This is above level than this change so it can not be related.

When I try streebog256 with similar change to sign_ima() I get error
like this:

  $ evmctl ima_sign --key privkey_rsa.pem -a streebog256 --xattr-user test.txt
  sign_hash_v2: signing failed: (invalid digest)
  error:0408C09D:rsa routines:check_padding_md:invalid digest

Which is correct.

Thanks,
