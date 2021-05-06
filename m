Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A772D374C85
	for <lists+linux-integrity@lfdr.de>; Thu,  6 May 2021 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhEFAyQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 May 2021 20:54:16 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:55830 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEFAyQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 May 2021 20:54:16 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 95C2372C8B5;
        Thu,  6 May 2021 03:53:17 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 527044A46E8;
        Thu,  6 May 2021 03:53:17 +0300 (MSK)
Date:   Thu, 6 May 2021 03:53:17 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ima-evm-utils: Read keyid from the cert appended
 to the key file
Message-ID: <20210506005317.olcsehs4ou26gwjg@altlinux.org>
References: <20210505064843.111900-1-vt@altlinux.org>
 <20210505064843.111900-4-vt@altlinux.org>
 <2209bd5d-9255-4954-2a61-2d2e7f23a433@linux.ibm.com>
 <20210506002932.zt4mcihtl4v2yfxo@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506002932.zt4mcihtl4v2yfxo@altlinux.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Thu, May 06, 2021 at 03:29:32AM +0300, Vitaly Chikunov wrote:
> On Wed, May 05, 2021 at 07:29:17PM -0400, Stefan Berger wrote:
> > 
> > On 5/5/21 2:48 AM, Vitaly Chikunov wrote:
> > > Allow to have certificate appended to the private key of `--key'
> > > specified (PEM) file (for v2 signing) to facilitate reading of keyid
> > > from the associated cert. This will allow users to have private and
> > > public key as a single file. There is no check that public key form the
> > > cert matches associated private key.
> > > 
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >   README          | 3 +++
> > >   src/libimaevm.c | 8 +++++---
> > >   2 files changed, 8 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/README b/README
> > > index 0e1f6ba..ea11bde 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -127,6 +127,9 @@ for signing and importing the key.
> > >   Second key format uses X509 DER encoded public key certificates and uses asymmetric key support
> > >   in the kernel (since kernel 3.9). CONFIG_INTEGRITY_ASYMMETRIC_KEYS must be enabled (default).
> > > +For v2 signatures x509 certificate with the public key could be appended to the private
> > > +key (both are in PEM format) to properly determine its Subject Key Identifier (SKID).
> > > +
> > >   Integrity keyrings
> > >   ----------------
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index a22d9bb..ac4bb46 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -1017,10 +1017,12 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> > >   		return -1;
> > >   	}
> > > -	if (imaevm_params.keyid)
> > > +	if (imaevm_params.keyid) {
> > >   		hdr->keyid = htonl(imaevm_params.keyid);
> > > -	else
> > > -		calc_keyid_v2(&hdr->keyid, name, pkey);
> > > +	} else {
> > > +		if (_ima_read_keyid(keyfile, &hdr->keyid, KEYID_FILE_PEM_KEY) == ULONG_MAX)
> > > +			calc_keyid_v2(&hdr->keyid, name, pkey);
> > > +	}
> > 
> > It might be convenient here to just write the result in network byte order
> > into the header but for a library API I find it not so nice, but then
> > there's calc_keyid_v2 that does that already... I just wouldn't expect that
> > these parameter are in big endian order already, I would expect them in
> > native order. 
> 
> I expect them in network order, similar to how calc_keyid_v2() already
> writes it one line below. So, why should we mix orders? Both functions
> write keyids, so it's not like completely different parts of API. Also,
> it's documented that ima_read_keyid() writes to the pointer in network
> order (and returns integer in host order), so I don't see the
> problem. Thus, I would prefer not to follow this suggestion.
> 
> Thanks,
> 
> > So maybe ima_read_keyid should just return ULONG_MAX or the
> > keyid in host order and it call _ima_read_keyid() with a NULL pointer or a
> > dummy variable as keyid that the library API caller doesn't see.

So there will be exported
   uint32_t ima_read_keyid(char *certfile);
and internal
   static bool _read_keyid(char *certfile, uint32_t *keyid)

ima_read_keyid will wrap read_keyid and return keyid via intermediate
variable. Right?


> > 
> > šš Stefan
> > 
> > 
> > >   	st = "EVP_PKEY_CTX_new";
> > >   	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
