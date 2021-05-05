Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17B37337F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhEEBP7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 21:15:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48474 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEEBP7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 21:15:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1155172C8B5;
        Wed,  5 May 2021 04:15:02 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id F3E6B4A46E8;
        Wed,  5 May 2021 04:15:01 +0300 (MSK)
Date:   Wed, 5 May 2021 04:15:01 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210505011501.vdgfkrparxwop6xc@altlinux.org>
References: <20210504043357.4093409-1-vt@altlinux.org>
 <20210504043357.4093409-4-vt@altlinux.org>
 <1b5d6c49-c080-76e9-66e1-2db19bfee2c9@linux.ibm.com>
 <20210504222723.wirqlwsz2xtnfqz7@altlinux.org>
 <fbe258e3-5cd4-5d67-7622-431a6434d64f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbe258e3-5cd4-5d67-7622-431a6434d64f@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Tue, May 04, 2021 at 09:04:44PM -0400, Stefan Berger wrote:
> On 5/4/21 6:27 PM, Vitaly Chikunov wrote:
> > On Tue, May 04, 2021 at 09:38:06AM -0400, Stefan Berger wrote:
> > > On 5/4/21 12:33 AM, Vitaly Chikunov wrote:
> > > > Allow to have certificate appended to the private key of `--key'
> > > > specified (PEM) file (for v2 signing) to facilitate reading of keyid
> > > > from the associated cert. This will allow users to have private and
> > > > public key as a single file. There is no check that public key form the
> > > > cert matches associated private key.
> > > > 
> > > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > > ---
> > > >    README          |  2 ++
> > > >    src/libimaevm.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
> > > >    2 files changed, 49 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/README b/README
> > > > index 0e1f6ba..2c21ba6 100644
> > > > --- a/README
> > > > +++ b/README
> > > > @@ -127,6 +127,8 @@ for signing and importing the key.
> > > >    Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
> > > >    in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
> > > > +For v2 signatures x509 certificate with the public key could be appended to the private
> > > > +key (both are in PEM format) to properly determine its Subject Key Identifier SKID.
> > > >    Integrity keyrings
> > > >    ----------------
> > > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > > index 481d29d..3607a76 100644
> > > > --- a/src/libimaevm.c
> > > > +++ b/src/libimaevm.c
> > > > @@ -57,6 +57,7 @@
> > > >    #include <openssl/pem.h>
> > > >    #include <openssl/evp.h>
> > > >    #include <openssl/x509.h>
> > > > +#include <openssl/x509v3.h>
> > > >    #include <openssl/err.h>
> > > >    #include "imaevm.h"
> > > > @@ -748,6 +749,47 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_PKEY *pkey)
> > > >    	X509_PUBKEY_free(pk);
> > > >    }
> > > > +/* Try to read keyid from key file (in case it have appended cert). */
> > > > +static int read_keyid(const char *keyfile, uint32_t *keyid)
> > > > +{
> > > So the private key is assumed to be in PEM format.
> > Yes, even though README says something different.
> > 
> > > I suppose if there's an
> > > appended X509 in the private key file as well then only one function should
> > > be necessary to extract the x509 cert from the files. That function should
> > > be able to handle PEM and DER format at the same time. Have you tried
> > > extracting the x509 cert from the private key file using that other function
> > > in 2/3 yet?
> > Excuse me, I don't understand what you talking about in this note.
> > 2/3 does not read private keys. Where and why should be one function?
> > And what other function?
> 
> It should be possible to combine yourš functions extract_keyid (2/3) and
> read_keyid (3/3) into a single function that can handle PEM files containing
> X509 certs as well as DER files. It's two times very similar code and the
> function that can handle DER and PEM should be able to handle PEM files with
> private keys + X509 certs.

I see. There should be very generic function that can read fd, FILE,
bio, and memory region, also can parse DER, PEM, and combined PEMs.

Thanks,

