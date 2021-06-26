Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7733B4BA6
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jun 2021 02:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFZApE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Jun 2021 20:45:04 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:53138 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZApE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Jun 2021 20:45:04 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B17C572C8B4;
        Sat, 26 Jun 2021 03:42:41 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 871AF4A46EC;
        Sat, 26 Jun 2021 03:42:41 +0300 (MSK)
Date:   Sat, 26 Jun 2021 03:42:41 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v6 1/3] ima-evm-utils: Allow manual setting keyid for
 signing
Message-ID: <20210626004241.wkkjsbbesakszfkj@altlinux.org>
References: <20210511115630.795208-1-vt@altlinux.org>
 <20210511115630.795208-2-vt@altlinux.org>
 <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <004b55594ab1d944e42dd7fd0d87df47b3c09114.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Fri, Jun 25, 2021 at 08:21:46AM -0400, Mimi Zohar wrote:
> On Tue, 2021-05-11 at 14:56 +0300, Vitaly Chikunov wrote:
> > Allow user to set signature's keyid using `--keyid' option. Keyid should
> > correspond to SKID in certificate, when keyid is calculated using SHA-1
> > in libimaevm it may mismatch keyid extracted by the kernel from SKID of
> > certificate (the way public key is presented to the kernel), thus making
> > signatures not verifiable. This may happen when certificate is using non
> > SHA-1 SKID (see rfc7093) or just 'unique number' (see rfc5280 4.2.1.2).
> > As a last resort user may specify arbitrary keyid using the new option.
> > 
> > This commit creates ABI change for libimaevm, because of adding
> > additional parameter to imaevm_params - newer libimaevm cannot work
> > with older clients.
> 
> Thank you for highlighting the ABI change.
> 
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > Reported-by: Elvira Khabirova <lineprinter0@gmail.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >  README                 |  1 +
> >  src/evmctl.c           | 15 +++++++++++++++
> >  src/imaevm.h           |  1 +
> >  src/libimaevm.c        |  8 +++++---
> >  tests/sign_verify.test |  1 +
> >  5 files changed, 23 insertions(+), 3 deletions(-)
> > 
> > diff --git a/README b/README
> > index 321045d..8cd66e0 100644
> > --- a/README
> > +++ b/README
> > @@ -48,6 +48,7 @@ OPTIONS
> >        --xattr-user   store xattrs in user namespace (for testing purposes)
> >        --rsa          use RSA key type and signing scheme v1
> >    -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)
> > +      --keyid val    overwrite signature keyid with a value (for signing)
> >    -o, --portable     generate portable EVM signatures
> >    -p, --pass         password for encrypted signing key
> >    -r, --recursive    recurse into directories (sign)
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 7a6f202..d853d34 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2514,6 +2514,7 @@ static void usage(void)
> >  		"      --xattr-user   store xattrs in user namespace (for testing purposes)\n"
> >  		"      --rsa          use RSA key type and signing scheme v1\n"
> >  		"  -k, --key          path to signing key (default: /etc/keys/{privkey,pubkey}_evm.pem)\n"
> > +		"      --keyid val    overwrite signature keyid with a value (for signing)\n"
> >  		"  -o, --portable     generate portable EVM signatures\n"
> >  		"  -p, --pass         password for encrypted signing key\n"
> >  		"  -r, --recursive    recurse into directories (sign)\n"
> > @@ -2594,6 +2595,7 @@ static struct option opts[] = {
> >  	{"ignore-violations", 0, 0, 141},
> >  	{"pcrs", 1, 0, 142},
> >  	{"verify-bank", 2, 0, 143},
> > +	{"keyid", 1, 0, 144},
> >  	{}
> > 
> >  };
> > @@ -2638,6 +2640,8 @@ int main(int argc, char *argv[])
> >  {
> >  	int err = 0, c, lind;
> >  	ENGINE *eng = NULL;
> > +	unsigned long keyid;
> > +	char *eptr;
> > 
> >  #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
> >  	OPENSSL_init_crypto(
> > @@ -2785,6 +2789,17 @@ int main(int argc, char *argv[])
> >  		case 143:
> >  			verify_bank = optarg;
> >  			break;
> > +		case 144:
> > +			errno = 0;
> > +			keyid = strtoul(optarg, &eptr, 16);
> > +			if (errno || eptr - optarg != strlen(optarg) ||
> 
> Before using eptr, shouldn't there be a null test?

AFAIK, strtoul() should never return NULL there. strtoul(3):

  If endptr is not NULL, strtoul() stores the address of the first
  invalid character in *endptr.  If there were no digits at all,
  strtoul() stores the original value of nptr in *endptr (and returns
  0). In particular, if *nptr is not '\0' but **endptr is '\0' on
  return, the entire string is valid.

> It's unclear what
> verifying the resulting string length against the user provided length
> provides.

It shows that whole string is parsed by strtoul, otherwise there is some
unparsed garbage, which mean this was not valid number.

> Requiring the optarg value to be prefixed with "0x" would
> simplify the strlen test.  The length would be 2 * sizeof uint + 2.  
> (The subsequent patch wouldn't need a contrived prefix.)

(I do not understand this remark at the moment.)

Base 16 will let user pass keyid just as a string, copy-pasting from
somewhere else.

> 
> > +			    keyid == ULONG_MAX || keyid > UINT_MAX ||
> 
> Why are both of these tests required?  When ULONG_MAX and UINT_MAX
> aren't the same, wouldn't ULONG_MAX always be bigger than UINT_MAX?

ULONG_MAX is special return value of strtoul. UINT_MAX is a maximum
capacity of our keyid variable. So, in the case they are different there
is two tests. This also shows that both conditions are checked, without
need to solve them in the head.

> 
> > +			    keyid == 0) {
> > +				log_err("Invalid keyid value.\n");
> > +				exit(1);
> > +			}
> > +			imaevm_params.keyid = keyid;
> > +			break;
> >  		case '?':
> >  			exit(1);
> >  			break;
> > diff --git a/src/imaevm.h b/src/imaevm.h
> > index 4503919..9f38059 100644
> > --- a/src/imaevm.h
> > +++ b/src/imaevm.h
> > @@ -196,6 +196,7 @@ struct libimaevm_params {
> >  	const char *hash_algo;
> >  	const char *keyfile;
> >  	const char *keypass;
> > +	uint32_t keyid;		/* keyid overriding value, unless 0. */
> 
> If keyid is suppose to be big endiran format, please annotate it in the
> comment.

It isn't.

> 
> >  };
> > 
> >  struct RSA_ASN1_template {
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index fa6c278..481d29d 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -45,6 +45,7 @@
> >  #include <sys/param.h>
> >  #include <sys/stat.h>
> >  #include <asm/byteorder.h>
> > +#include <arpa/inet.h>
> >  #include <unistd.h>
> >  #include <dirent.h>
> >  #include <string.h>
> > @@ -894,7 +895,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >  	const EVP_MD *md;
> >  	size_t sigsize;
> >  	const char *st;
> > -	uint32_t keyid;
> > 
> >  	if (!hash) {
> >  		log_err("sign_hash_v2: hash is null\n");
> > @@ -932,8 +932,10 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
> >  		return -1;
> >  	}
> > 
> > -	calc_keyid_v2(&keyid, name, pkey);
> > -	hdr->keyid = keyid;
> > +	if (imaevm_params.keyid)
> > +		hdr->keyid = htonl(imaevm_params.keyid);
> > +	else
> > +		calc_keyid_v2(&hdr->keyid, name, pkey);
> > 
> At what point should imaevm_params.keyid be converted to big endian -
> on usage or setting it?

On usage (when storing into header).

Thanks,

> 
> Mimi
> 
> >  	st = "EVP_PKEY_CTX_new";
> >  	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
> > diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> > index 3d7aa51..eccf5fa 100755
> > --- a/tests/sign_verify.test
> > +++ b/tests/sign_verify.test
> > @@ -365,6 +365,7 @@ sign_verify  rsa1024  sha256  0x0301 --rsa
> >  sign_verify  rsa1024  md5     0x030201:K:0080
> >  sign_verify  rsa1024  sha1    0x030202:K:0080
> >  sign_verify  rsa1024  sha224  0x030207:K:0080
> > +expect_pass check_sign TYPE=ima KEY=rsa1024 ALG=sha256 PREFIX=0x030204aabbccdd0080 OPTS=--keyid=aabbccdd
> >  sign_verify  rsa1024  sha256  0x030204:K:0080
> >    try_different_keys
> >    try_different_sigs
> 
