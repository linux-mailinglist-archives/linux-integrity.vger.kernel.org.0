Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035953F7C59
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbhHYSm1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 14:42:27 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:49284 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbhHYSm0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 14:42:26 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 93C8672C8F8;
        Wed, 25 Aug 2021 21:41:38 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 57B444A46F1;
        Wed, 25 Aug 2021 21:41:38 +0300 (MSK)
Date:   Wed, 25 Aug 2021 21:41:37 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v3] Use secure heap for private keys and
 passwords
Message-ID: <20210825184137.rv2pb2zieekvvlyd@altlinux.org>
References: <20210822001055.1772873-1-vt@altlinux.org>
 <0c5c0851cd07f861ebf79bc0ac90e57d71317985.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <0c5c0851cd07f861ebf79bc0ac90e57d71317985.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Aug 25, 2021 at 07:39:30AM -0400, Mimi Zohar wrote:
> Hi Vitaly,
> 
> On Sun, 2021-08-22 at 03:10 +0300, Vitaly Chikunov wrote:
> > After CRYPTO_secure_malloc_init OpenSSL will store private keys 
> 
> ^and passwords

No, it meant openssl automatically will handle private keys (and other
internal private data) in secure heap.

Handling of passwords in openssl's secure heap we do ourselves. I can
extend commit message about this.

> > in
> > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Initially we started out discussing ways of protecting passwords, which
> this patch does.  Thank you!  I'm not sure, however, it is protecting
> the private keys.  Does read_priv_pkey()  also use the secure heap or
> is PEM_read_PrivateKey() already safe?

After CRYPTO_secure_malloc_init call all openssl API functions that
handle private keys and passwords should use secure heap. So, in that
regard we don't need to add anything.

> 
> > ---
> >  src/evmctl.c | 148 +++++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 121 insertions(+), 27 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > 
> > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
> >  	return err;
> >  }
> > 
> > -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > +/* Return data in OpenSSL secure heap if 'secure' is true. */
> > +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> > +			       int secure)
> >  {
> 
> The only caller of file2bin() that sets "secure" is evm_calc_hmac(),
> but evm_calc_hmac() is a debugging tool, not meant for setting the real
> security.evm xattr.

I can undo file2bin change if you wish, but for uniformity I would have
it changed. We can add comment that it is handling only test & debugging
data, thus not using security measures. May also output some warning at
runtime.

> The kernel EVM HMAC key is an "encrypted" key type, which should be
> based on a "trusted" key.  Neither of which are exposed to userspace
> unencrypted. 
> 
> Enabling DEBUG by default was suppose to be temporary.  At this point,
> should it be disabled?  As evm_calc_hmac() is only meant for debugging,
> do we really care whether evm_calc_hmac() uses a secure heap or stack
> for private keys or passwords?


Thanks,


> 
> thanks,
> 
> Mimi
> 
> >  	FILE *fp;
> >  	size_t len;
