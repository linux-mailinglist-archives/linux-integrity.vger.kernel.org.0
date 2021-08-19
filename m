Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82F63F230B
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 00:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhHSWWf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 18:22:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44604 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhHSWWe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 18:22:34 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E53C272C8F8;
        Fri, 20 Aug 2021 01:21:56 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id BAC734A46F1;
        Fri, 20 Aug 2021 01:21:56 +0300 (MSK)
Date:   Fri, 20 Aug 2021 01:21:56 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <20210819222156.u6dinavobe5o6in7@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
 <20210819214226.k6emm5cviu5rks3m@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210819214226.k6emm5cviu5rks3m@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 20, 2021 at 12:42:26AM +0300, Vitaly Chikunov wrote:
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
> > @@ -2596,15 +2637,41 @@ static struct option opts[] = {
> >  
> >  };
> >  
> > +/*
> > + * Copy password from optarg into secure heap, so it could be
> > + * freed in the same way as a result of get_password().
> > + */
> > +static char *optarg_password(char *optarg)
> > +{
> > +	size_t len;
> > +	char *keypass;
> > +
> > +	if (!optarg)
> > +		return NULL;
> > +	len = strlen(optarg);
> > +	keypass = OPENSSL_secure_malloc(len + 1);
> > +	if (keypass)
> > +		memcpy(keypass, optarg, len + 1);
> > +	else
> > +		perror("OPENSSL_secure_malloc");
> 
> I also realized that OPENSSL_secure_malloc does not (intentionally)
> set errno, so using perror is perhaps wrong. Better method should be
> thanked out.

After some more thinking I think all this perror usage should be
replaced with log_err like in all other places. (perror is used only in
get_password). Log_err hypothetically could log to stdout or to syslog
depending on USE_FPRINTF(*), but perror will always log to stderr.

  (*) Which is _always_ defined though. This is obscure.

Thanks,

