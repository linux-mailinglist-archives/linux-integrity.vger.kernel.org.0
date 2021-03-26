Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185934A470
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Mar 2021 10:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCZJbT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Mar 2021 05:31:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35362 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhCZJbF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Mar 2021 05:31:05 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPinv-0003Uk-Sm; Fri, 26 Mar 2021 20:30:57 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:30:55 +1100
Date:   Fri, 26 Mar 2021 20:30:55 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org
Subject: Re: [PATCH v12 00/10] Add support for x509 certs with NIST
 P384/256/192 keys
Message-ID: <20210326093054.GE12658@gondor.apana.org.au>
References: <20210316210740.1592994-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316210740.1592994-1-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 16, 2021 at 05:07:30PM -0400, Stefan Berger wrote:
> This series of patches adds support for x509 certificates signed by a CA
> that uses NIST P384, P256 or P192 keys for signing. It also adds support for
> certificates where the public key is one of this type of a key. The math
> for ECDSA signature verification is also added as well as the math for fast
> mmod operation for NIST P384.
> 
> Since self-signed certificates are verified upon loading, the following
> script can be used for testing of NIST P256 keys:
> 
> k=$(keyctl newring test @u)
> 
> while :; do
> 	for hash in sha1 sha224 sha256 sha384 sha512; do
> 		openssl req \
> 			-x509 \
> 			-${hash} \
> 			-newkey ec \
> 			-pkeyopt ec_paramgen_curve:prime256v1 \
> 			-keyout key.pem \
> 			-days 365 \
> 			-subj '/CN=test' \
> 			-nodes \
> 			-outform der \
> 			-out cert.der
> 		keyctl padd asymmetric testkey $k < cert.der
> 		if [ $? -ne 0 ]; then
> 			echo "ERROR"
> 			exit 1
> 		fi
> 	done
> done
> 
> Ecdsa support also works with restricted keyrings where an RSA key is used
> to sign a NIST P384/256/192 key. Scripts for testing are here:
> 
> https://github.com/stefanberger/eckey-testing
> 
> The ECDSA signature verification will be used by IMA Appraisal where ECDSA
> file signatures stored in RPM packages will use substantially less space
> than if RSA signatures were to be used.
> 
> Further, a patch is added that allows kernel modules to be signed with a NIST
> P384 key.
> 
> Testing was also done with a Pkcs11 device using an ECC key for module
> signing:
>   https://github.com/stefanberger/eckey-testing/wiki/Using-Pkcs11-Device-(SoftHSM)-for-Signing-Linux-Kernel-Modules
> 
>    Stefan and Saulo
> 
> v11->v12:
>   - Added Jarkko's Acked-by's
> 
> v10->v11:
>   - Addressed Jarkko's comments
>   - Split off OID definitions from first patch into own patch
>   - Renamed OID_id_secp384r1 to OID_id_ansip384r1 (spec name) in 09/10
> 
> v9->v10:
>   - rearranged order of patches to have crypto patches first
>   - moved hunk from patch 3 to patch 2 to avoid compilation warning due to
>     unused symbol
> 
> v8->v9:
>   - Appended Saulo's patches
>   - Appended patch to support kernel modules signed with NIST p384 key. This
>     patch requires Nayna's series here: https://lkml.org/lkml/2021/2/18/856
> 
> v7->v8:
>   - patch 3/4: Do not determine key algo using parse_OID in public_key.c
>     but do this when parsing the certificate. This addresses an issue
>     with certain build configurations where OID_REGISTRY is not available
>     as 'Reported-by: kernel test robot <lkp@intel.com>'.
> 
> v6->v7:
>   - Moved some OID defintions to patch 1 for bisectability
>   - Applied R-b's
>   
> v5->v6:
>   - moved ecdsa code into its own module ecdsa_generic built from ecdsa.c
>   - added script-generated test vectors for NIST P256 & P192 and all hashes
>   - parsing of OID that contain header with new parse_oid()
> 
> v4->v5:
>   - registering crypto support under names ecdsa-nist-p256/p192 following
>     Hubert Xu's suggestion in other thread
>   - appended IMA ECDSA support patch
> 
> v3->v4:
>   - split off of ecdsa crypto part; registering akcipher as "ecdsa" and
>     deriving used curve from digits in parsed key
> 
> v2->v3:
>   - patch 2 now includes linux/scatterlist.h
> 
> v1->v2:
>   - using faster vli_sub rather than newly added vli_mod_fast to 'reduce'
>     result
>   - rearranged switch statements to follow after RSA
>   - 3rd patch from 1st posting is now 1st patch
> 
> 
> Saulo Alessandre (4):
>   crypto: Add NIST P384 curve parameters
>   crypto: Add math to support fast NIST P384
>   ecdsa: Register NIST P384 and extend test suite
>   x509: Add OID for NIST P384 and extend parser for it
> 
> Stefan Berger (6):
>   oid_registry: Add OIDs for ECDSA with SHA224/256/384/512
>   crypto: Add support for ECDSA signature verification
>   x509: Detect sm2 keys by their parameters OID
>   x509: Add support for parsing x509 certs with ECDSA keys
>   ima: Support EC keys for signature verification
>   certs: Add support for using elliptic curve keys for signing modules
> 
>  certs/Kconfig                             |  22 ++
>  certs/Makefile                            |  14 +
>  crypto/Kconfig                            |  10 +
>  crypto/Makefile                           |   6 +
>  crypto/asymmetric_keys/pkcs7_parser.c     |   4 +
>  crypto/asymmetric_keys/public_key.c       |   4 +-
>  crypto/asymmetric_keys/x509_cert_parser.c |  49 ++-
>  crypto/asymmetric_keys/x509_public_key.c  |   4 +-
>  crypto/ecc.c                              | 281 +++++++++-----
>  crypto/ecc.h                              |  28 +-
>  crypto/ecc_curve_defs.h                   |  32 ++
>  crypto/ecdsa.c                            | 376 +++++++++++++++++++
>  crypto/ecdsasignature.asn1                |   4 +
>  crypto/testmgr.c                          |  18 +
>  crypto/testmgr.h                          | 424 ++++++++++++++++++++++
>  include/crypto/ecdh.h                     |   1 +
>  include/keys/asymmetric-type.h            |   6 +
>  include/linux/oid_registry.h              |  10 +-
>  lib/oid_registry.c                        |  24 ++
>  security/integrity/digsig_asymmetric.c    |  30 +-
>  20 files changed, 1240 insertions(+), 107 deletions(-)
>  create mode 100644 crypto/ecdsa.c
>  create mode 100644 crypto/ecdsasignature.asn1

Patches 1-9 applied to branch ecc.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
