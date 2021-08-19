Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154993F22A6
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 00:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhHSWFY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 18:05:24 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:36966 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhHSWFY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 18:05:24 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 23A2372C8F8;
        Fri, 20 Aug 2021 01:04:46 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A4BCC4A46F1;
        Fri, 20 Aug 2021 01:04:45 +0300 (MSK)
Date:   Fri, 20 Aug 2021 01:04:45 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <20210819220445.vbytidpcm7tiou5l@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
 <YR6iwRZ9GCK272Me@glitch>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <YR6iwRZ9GCK272Me@glitch>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Bruno,

On Thu, Aug 19, 2021 at 03:28:17PM -0300, Bruno Meneguele wrote:
> On Thu, Aug 19, 2021 at 05:11:36AM +0300, Vitaly Chikunov wrote:
> > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> > Change from v1:
> > - Do not use setfbuf to disable buffering as this is not proven to be
> >   meaningful.
> > - Use secure heap for passwords too as suggested by Mimi Zohar.
> > - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
> > - Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
> >   OpenSSL init.)
> > - Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
> >   get_password" patch v2.
> > 
> >  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 118 insertions(+), 25 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 5f7c2b8..a27e0b9 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -59,6 +59,7 @@
> >  #include <assert.h>
> >  
> >  #include <openssl/asn1.h>
> > +#include <openssl/crypto.h>
> >  #include <openssl/sha.h>
> >  #include <openssl/pem.h>
> >  #include <openssl/hmac.h>
> > @@ -165,6 +166,24 @@ struct tpm_bank_info {
> >  static char *pcrfile[MAX_PCRFILE];
> >  static unsigned npcrfile;
> >  
> > +#if OPENSSL_VERSION_NUMBER <= 0x10100000
> > +#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
> > +	falling back to use plain OPENSSL_malloc.
> > +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> > +#define OPENSSL_secure_free	  OPENSSL_free
> > +/*
> > + * Secure heap memory automatically cleared on free, but
> > + * OPENSSL_secure_clear_free will be used in case of fallback
> 
> Shouldn't it be OPENSSL_clear_free instead of OPENSLL_secure_clear_free
> in the setence above?

No. I meant our code will use OPENSSL_secure_clear_free, so when there
is no secure heap it will fallback to OPENSSL_clear_free (and not just
to OPENSSL_free if we used OPENSSL_secure_free).

Thanks,

> 
> -- 
> bmeneg 
> PGP Key: http://bmeneg.com/pubkey.txt


