Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C63A32F0DF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhCERLl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231136AbhCERLO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:11:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134C36509D;
        Fri,  5 Mar 2021 17:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964274;
        bh=wnRteZJyLN0eCszrJdSSP4aqdtrVBKBR6XvMOfXKma0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldWjCHRxjF1AOpHG+kKj13DbZ7pGQpA0hyGT6vH+Zc4C/vt/Es8nEd3lpFONiAqQE
         c3g2Bfln3jdIsVozdFpc2OJE3mJT+d6NYgBu3Vrg8V2bCTuprSJY2sq74I5r/HiFVk
         B4PZMHMx09iIKgKKd+m2Uz753rVlGSlXq8ooNOBWvE+TPT8pj0E77Xjup7uAiIpJdo
         N/XsUay5yJJu49yHZT7OwkEjSGWhyXzhaUSt84PDyHFpzPmHI7YYPmffKt8VFbxmRL
         GIPGnRRD8F5pKkUVHhR3lhNj3GpKunB8xr56dgLQN8QSHphmXDMmgXa8JjoNJ/oxu8
         qNOBIj+UpEfFA==
Date:   Fri, 5 Mar 2021 19:10:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v10 0/9] Add support for x509 certs with NIST
 P384/256/192 keys
Message-ID: <YEJmHvfJoN4+IQEI@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <11bd603d-56ca-b974-98e1-bc51238ea4af@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11bd603d-56ca-b974-98e1-bc51238ea4af@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:53:48PM -0500, Stefan Berger wrote:
> Herbert,
> 
>    you can take patches 1-8. 9 will not apply without Nayna's series as
> mentioned in the patch.
> 
> Regards,
>    Stefan

IMHO, these patches are not yet in finished state.

/Jarkko

> 
> 
> On 3/4/21 7:51 PM, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > This series of patches adds support for x509 certificates signed by a CA
> > that uses NIST P384, P256 or P192 keys for signing. It also adds support for
> > certificates where the public key is one of this type of a key. The math
> > for ECDSA signature verification is also added as well as the math for fast
> > mmod operation for NIST P384.
> > 
> > Since self-signed certificates are verified upon loading, the following
> > script can be used for testing of NIST P256 keys:
> > 
> > k=$(keyctl newring test @u)
> > 
> > while :; do
> > 	for hash in sha1 sha224 sha256 sha384 sha512; do
> > 		openssl req \
> > 			-x509 \
> > 			-${hash} \
> > 			-newkey ec \
> > 			-pkeyopt ec_paramgen_curve:prime256v1 \
> > 			-keyout key.pem \
> > 			-days 365 \
> > 			-subj '/CN=test' \
> > 			-nodes \
> > 			-outform der \
> > 			-out cert.der
> > 		keyctl padd asymmetric testkey $k < cert.der
> > 		if [ $? -ne 0 ]; then
> > 			echo "ERROR"
> > 			exit 1
> > 		fi
> > 	done
> > done
> > 
> > Ecdsa support also works with restricted keyrings where an RSA key is used
> > to sign a NIST P384/256/192 key. Scripts for testing are here:
> > 
> > https://github.com/stefanberger/eckey-testing
> > 
> > The ECDSA signature verification will be used by IMA Appraisal where ECDSA
> > file signatures stored in RPM packages will use substantially less space
> > than if RSA signatures were to be used.
> > 
> > Further, a patch is added that allows kernel modules to be signed with a NIST
> > p384 key.
> > 
> >     Stefan and Saulo
> > 
> > v9->v10:
> >    - rearranged order of patches to have crypto patches first
> >    - moved hunk from patch 3 to patch 2 to avoid compilation warning due to
> >      unused symbol
> > 
> > v8->v9:
> >    - Appended Saulo's patches
> >    - Appended patch to support kernel modules signed with NIST p384 key. This
> >      patch requires Nayna's series here: https://lkml.org/lkml/2021/2/18/856
> > 
> > v7->v8:
> >    - patch 3/4: Do not determine key algo using parse_OID in public_key.c
> >      but do this when parsing the certificate. This addresses an issue
> >      with certain build configurations where OID_REGISTRY is not available
> >      as 'Reported-by: kernel test robot <lkp@intel.com>'.
> > 
> > v6->v7:
> >    - Moved some OID defintions to patch 1 for bisectability
> >    - Applied R-b's
> > v5->v6:
> >    - moved ecdsa code into its own module ecdsa_generic built from ecdsa.c
> >    - added script-generated test vectors for NIST P256 & P192 and all hashes
> >    - parsing of OID that contain header with new parse_oid()
> > 
> > v4->v5:
> >    - registering crypto support under names ecdsa-nist-p256/p192 following
> >      Hubert Xu's suggestion in other thread
> >    - appended IMA ECDSA support patch
> > 
> > v3->v4:
> >    - split off of ecdsa crypto part; registering akcipher as "ecdsa" and
> >      deriving used curve from digits in parsed key
> > 
> > v2->v3:
> >    - patch 2 now includes linux/scatterlist.h
> > 
> > v1->v2:
> >    - using faster vli_sub rather than newly added vli_mod_fast to 'reduce'
> >      result
> >    - rearranged switch statements to follow after RSA
> >    - 3rd patch from 1st posting is now 1st patch
> > 
> > 
> > Saulo Alessandre (4):
> >    crypto: Add NIST P384 curve parameters
> >    crypto: Add math to support fast NIST P384
> >    ecdsa: Register NIST P384 and extend test suite
> >    x509: Add OID for NIST P384 and extend parser for it
> > 
> > Stefan Berger (5):
> >    crypto: Add support for ECDSA signature verification
> >    x509: Detect sm2 keys by their parameters OID
> >    x509: Add support for parsing x509 certs with ECDSA keys
> >    ima: Support EC keys for signature verification
> >    certs: Add support for using elliptic curve keys for signing modules
> > 
> >   certs/Kconfig                             |  22 ++
> >   certs/Makefile                            |  14 +
> >   crypto/Kconfig                            |  10 +
> >   crypto/Makefile                           |   6 +
> >   crypto/asymmetric_keys/pkcs7_parser.c     |   4 +
> >   crypto/asymmetric_keys/public_key.c       |   4 +-
> >   crypto/asymmetric_keys/x509_cert_parser.c |  49 ++-
> >   crypto/asymmetric_keys/x509_public_key.c  |   4 +-
> >   crypto/ecc.c                              | 281 +++++++++-----
> >   crypto/ecc.h                              |  31 +-
> >   crypto/ecc_curve_defs.h                   |  32 ++
> >   crypto/ecdsa.c                            | 400 ++++++++++++++++++++
> >   crypto/ecdsasignature.asn1                |   4 +
> >   crypto/testmgr.c                          |  18 +
> >   crypto/testmgr.h                          | 424 ++++++++++++++++++++++
> >   include/crypto/ecdh.h                     |   1 +
> >   include/keys/asymmetric-type.h            |   6 +
> >   include/linux/oid_registry.h              |  10 +-
> >   lib/oid_registry.c                        |  13 +
> >   security/integrity/digsig_asymmetric.c    |  30 +-
> >   20 files changed, 1256 insertions(+), 107 deletions(-)
> >   create mode 100644 crypto/ecdsa.c
> >   create mode 100644 crypto/ecdsasignature.asn1
> > 
> 
> 
