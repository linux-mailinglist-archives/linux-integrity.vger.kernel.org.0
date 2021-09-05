Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94529400EA9
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Sep 2021 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhIEIMm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Sep 2021 04:12:42 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:50558 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbhIEIMm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Sep 2021 04:12:42 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EBA1B72C8B0;
        Sun,  5 Sep 2021 11:11:37 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id C17354A46FC;
        Sun,  5 Sep 2021 11:11:37 +0300 (MSK)
Date:   Sun, 5 Sep 2021 11:11:37 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private
 keys and passwords
Message-ID: <20210905081137.nsslgto7mqsfxn2b@altlinux.org>
References: <20210904105054.3388329-1-vt@altlinux.org>
 <cee7b810-e9fd-9924-a8dd-9cc1e3211bd7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cee7b810-e9fd-9924-a8dd-9cc1e3211bd7@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Sat, Sep 04, 2021 at 09:10:50PM -0400, Stefan Berger wrote:
> 
> On 9/4/21 6:50 AM, Vitaly Chikunov wrote:
> > After CRYPTO_secure_malloc_init OpenSSL will automatically store private
> > keys in secure heap. OPENSSL_secure_malloc(3):
> > 
> >    If a secure heap is used, then private key BIGNUM values are stored
> >    there. This protects long-term storage of private keys, but will not
> >    necessarily put all intermediate values and computations there.
> > 
> > Additionally, we try to keep user passwords in secure heap too.
> > This facility is only available since OpenSSL_1_1_0-pre1.
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> > Cc: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> > Change since v3:
> > - Undo secure heap handling from (file2bin and) calc_evm_hmac since this
> >    is debugging tool only. Add comment about this.
> > - Since there is only code removals and new comments I keep Reviewed-by
> >    tag.
> > 
> >   src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 85 insertions(+), 12 deletions(-)
> > 
> > @@ -2596,15 +2616,41 @@ static struct option opts[] = {
> >   };
> > +/*
> > + * Copy password from optarg into secure heap, so it could be
> > + * freed in the same way as a result of get_password().
> > + */
> > +static char *optarg_password(char *optarg)
> > +{
> 
> 
> Mimi applied my patch that takes the password from an environment variable
> to the next-testing branch. The code there (imaevm_params.keypassš =
> getenv("..."))would have to change as well calling this function here. Even
> though the man page of getenv says that 'The caller must take care not to
> modify this string, since that would change the environment of the process'
> we should be able to overwrite the env variable's password value just like
> here. Maybe for this purpose rename this function to dup_password() ?

`/proc/<pid>/environ' is never world readable (unlike `cmdline'), so we
don't even need to overwrite it there. But, we can.

(Btw, I found the 'EVMCTL_KEY_PASSWORD' patch.)

> > @@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
> >   	ENGINE *eng = NULL;
> >   	unsigned long keyid;
> >   	char *eptr;
> > +	char *keypass = NULL; /* @secure heap */
> >   #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
> >   	OPENSSL_init_crypto(
> > @@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
> >   #endif
> >   			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
> >   #endif
> > +#if OPENSSL_VERSION_NUMBER > 0x10100000
> > +	/*
> > +	 * This facility is available since OpenSSL_1_1_0-pre1.
> 
> 
> Shouldn't the comparison then not include 0x10100000?
> 
> #if OPENSSL_VERSION_NUMBER >= 0x10100000

The number is from `include/openssl/opensslv.h' from the time when
relevant commit is already applied. So, I use `>'. It seems good match
for OpenSSL_1_1_0-pre1 too:

  $ git grep OPENSSL_VERSION_NUMBER OpenSSL_1_1_0-pre1:include/openssl/opensslv.h
  OpenSSL_1_1_0-pre1:include/openssl/opensslv.h:# define OPENSSL_VERSION_NUMBER  0x10100001L

Thanks,

