Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA23F1FA5
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 20:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhHSSND (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 14:13:03 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58476 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhHSSND (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 14:13:03 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6322472C8F8;
        Thu, 19 Aug 2021 21:12:25 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 498C54A46F1;
        Thu, 19 Aug 2021 21:12:25 +0300 (MSK)
Date:   Thu, 19 Aug 2021 21:12:25 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
 <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Thu, Aug 19, 2021 at 02:06:03PM -0400, Mimi Zohar wrote:
> On Thu, 2021-08-19 at 05:11 +0300, Vitaly Chikunov wrote:
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
> 
> Not sure why it isn't applying with/without Bruno's v2 patch.

It should be over next-testing + (manually git am'ed) Bruno's patch:

  db25fcd 2021-08-19 03:20:48 +0300 Use secure heap for private keys and passwords (Vitaly Chikunov)
  d37ea6d 2021-08-16 12:15:59 -0300 evmctl: fix memory leak in get_password (Bruno Meneguele)
  b1818c1 2021-08-03 16:40:08 -0400 Create alternative tpm2_pcr_read() that uses IBM TSS (Ken Goldman) (origin/next-testing)

> 
> > 
> >  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 118 insertions(+), 25 deletions(-)
> > 
> > diff --git a/src/evmctl.c b/src/evmctl.c
> 
> > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
> >  	return err;
> >  }
> > 
> > -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> > +/* Return data in OpenSSL secure heap if 'secure' is true. */
> > +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> > +			       int secure)
> >  {
> >  	FILE *fp;
> >  	size_t len;
> > @@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
> >  	}
> >  	len = stats.st_size;
> > 
> > -	data = malloc(len);
> > +	if (secure)
> > +		data = OPENSSL_secure_malloc(len);
> > +	else
> > +		data = malloc(len);
> 
> Without being able to apply the patch, it's hard to tell if there
> should be a preparatory patch that first replaces malloc() with
> OPENSSL_malloc(), and other similar changes.

There is no OPENSSL_malloc use and I don't see why it should be.

Thanks,

> 
> thanks,
> 
> Mimi
> 
> >  	if (!data) {
> >  		log_err("Failed to malloc %zu bytes: %s\n", len, name);
> >  		fclose(fp);
