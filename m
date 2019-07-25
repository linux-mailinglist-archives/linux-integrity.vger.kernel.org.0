Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6597526E
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 17:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388899AbfGYPTl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 11:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbfGYPTl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 11:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28A1EC06511B;
        Thu, 25 Jul 2019 15:19:40 +0000 (UTC)
Received: from localhost (ovpn-116-52.gru2.redhat.com [10.97.116.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5AAD31018A0D;
        Thu, 25 Jul 2019 15:19:39 +0000 (UTC)
Date:   Thu, 25 Jul 2019 12:19:38 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2] ima-evm-utils: Namespace some too generic object names
Message-ID: <20190725151938.GD6134@rhlt>
References: <20190725141114.28415-1-vt@altlinux.org>
 <1564065263.4245.122.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <1564065263.4245.122.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 25 Jul 2019 15:19:40 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2019 at 10:34:23AM -0400, Mimi Zohar wrote:
> On Thu, 2019-07-25 at 17:11 +0300, Vitaly Chikunov wrote:
> > Prefix `dump', `do_dump', and `params' with `imaevm_' to avoid colliding
> > with other global symbols.
> > Also, rename `libevm_' to `libimaevm_`, only used with `params'.
> > Additionally, rename `dump' into `hexdump'.
> > Finally, rename `get_hash_algo' to `imaevm_get_hash_algo' as suggested =
by
> > Mimi Zohar.
> >=20
> > Lines that became too long are splitted, indent corrected. No code chan=
ges.
> >=20
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>=20
> Looks good, thanks! =A0At this point all 3 patches are applied, in the
> order you indicated. =A0Just waiting to see if Bruno or Petr want to add
> their tag to this version, before pushing it out.
>=20
> thanks!
>=20
> Mimi
>=20

Yep! Seems pretty good to me :)

Reviewed-by: Bruno E. O. Meneguele <bmeneg@redhat.com>

> > ---
> > Changes from 1:
> > - Change prefix from ima_ to imaevm_.
> > - Add prefix to get_hash_algo.
> > - This should be applied over "[PATCH 2/2] ima-evm-utils: Show used has=
h algo
> >   in verbose mode".
> >=20
> >  src/evmctl.c    | 109 +++++++++++++++++++++++++++++-------------------=
--------
> >  src/imaevm.h    |  16 +++++----
> >  src/libimaevm.c |  46 ++++++++++++------------
> >  3 files changed, 89 insertions(+), 82 deletions(-)
> >=20
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 75dd163..b02be8b 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -403,9 +403,10 @@ static int calc_evm_hash(const char *file, unsigne=
d char *hash)
> >  		return -1;
> >  	}
> >=20
> > -	md =3D EVP_get_digestbyname(params.hash_algo);
> > +	md =3D EVP_get_digestbyname(imaevm_params.hash_algo);
> >  	if (!md) {
> > -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> > +		log_err("EVP_get_digestbyname(%s) failed\n",
> > +			imaevm_params.hash_algo);
> >  		return 1;
> >  	}
> >=20
> > @@ -549,7 +550,7 @@ static int sign_evm(const char *file, const char *k=
ey)
> >  		return len;
> >  	assert(len <=3D sizeof(hash));
> >=20
> > -	len =3D sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> > +	len =3D sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig =
+ 1);
> >  	if (len <=3D 1)
> >  		return len;
> >  	assert(len < sizeof(sig));
> > @@ -564,8 +565,8 @@ static int sign_evm(const char *file, const char *k=
ey)
> >  	if (evm_immutable)
> >  		sig[1] =3D 3; /* immutable signature version */
> >=20
> > -	if (sigdump || params.verbose >=3D LOG_INFO)
> > -		dump(sig, len);
> > +	if (sigdump || imaevm_params.verbose >=3D LOG_INFO)
> > +		imaevm_hexdump(sig, len);
> >=20
> >  	if (xattr) {
> >  		err =3D lsetxattr(file, xattr_evm, sig, len, 0);
> > @@ -582,10 +583,10 @@ static int hash_ima(const char *file)
> >  {
> >  	unsigned char hash[MAX_DIGEST_SIZE + 2]; /* +2 byte xattr header */
> >  	int len, err, offset;
> > -	int algo =3D get_hash_algo(params.hash_algo);
> > +	int algo =3D imaevm_get_hash_algo(imaevm_params.hash_algo);
> >=20
> >  	if (algo < 0) {
> > -		log_err("Unknown hash algo: %s\n", params.hash_algo);
> > +		log_err("Unknown hash algo: %s\n", imaevm_params.hash_algo);
> >  		return -1;
> >  	}
> >  	if (algo > PKEY_HASH_SHA1) {
> > @@ -604,11 +605,11 @@ static int hash_ima(const char *file)
> >=20
> >  	len +=3D offset;
> >=20
> > -	if (params.verbose >=3D LOG_INFO)
> > -		log_info("hash(%s): ", params.hash_algo);
> > +	if (imaevm_params.verbose >=3D LOG_INFO)
> > +		log_info("hash(%s): ", imaevm_params.hash_algo);
> >=20
> > -	if (sigdump || params.verbose >=3D LOG_INFO)
> > -		dump(hash, len);
> > +	if (sigdump || imaevm_params.verbose >=3D LOG_INFO)
> > +		imaevm_hexdump(hash, len);
> >=20
> >  	if (xattr) {
> >  		err =3D lsetxattr(file, xattr_ima, hash, len, 0);
> > @@ -632,7 +633,7 @@ static int sign_ima(const char *file, const char *k=
ey)
> >  		return len;
> >  	assert(len <=3D sizeof(hash));
> >=20
> > -	len =3D sign_hash(params.hash_algo, hash, len, key, NULL, sig + 1);
> > +	len =3D sign_hash(imaevm_params.hash_algo, hash, len, key, NULL, sig =
+ 1);
> >  	if (len <=3D 1)
> >  		return len;
> >  	assert(len < sizeof(sig));
> > @@ -641,8 +642,8 @@ static int sign_ima(const char *file, const char *k=
ey)
> >  	len++;
> >  	sig[0] =3D EVM_IMA_XATTR_DIGSIG;
> >=20
> > -	if (sigdump || params.verbose >=3D LOG_INFO)
> > -		dump(sig, len);
> > +	if (sigdump || imaevm_params.verbose >=3D LOG_INFO)
> > +		imaevm_hexdump(sig, len);
> >=20
> >  	if (sigfile)
> >  		bin2file(file, "sig", sig, len);
> > @@ -722,7 +723,7 @@ static int sign_ima_file(const char *file)
> >  {
> >  	const char *key;
> >=20
> > -	key =3D params.keyfile ? : "/etc/keys/privkey_evm.pem";
> > +	key =3D imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> >=20
> >  	return sign_ima(file, key);
> >  }
> > @@ -743,7 +744,7 @@ static int cmd_sign_hash(struct command *cmd)
> >  	unsigned char sig[MAX_SIGNATURE_SIZE] =3D "\x03";
> >  	int siglen;
> >=20
> > -	key =3D params.keyfile ? : "/etc/keys/privkey_evm.pem";
> > +	key =3D imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> >=20
> >  	/* support reading hash (eg. output of shasum) */
> >  	while ((len =3D getline(&line, &line_len, stdin)) > 0) {
> > @@ -757,7 +758,7 @@ static int cmd_sign_hash(struct command *cmd)
> >=20
> >  		assert(hashlen / 2 <=3D sizeof(hash));
> >  		hex2bin(hash, line, hashlen / 2);
> > -		siglen =3D sign_hash(params.hash_algo, hash, hashlen/2,
> > +		siglen =3D sign_hash(imaevm_params.hash_algo, hash, hashlen / 2,
> >  				 key, NULL, sig + 1);
> >  		if (siglen <=3D 1)
> >  			return siglen;
> > @@ -783,7 +784,7 @@ static int sign_evm_path(const char *file)
> >  	const char *key;
> >  	int err;
> >=20
> > -	key =3D params.keyfile ? : "/etc/keys/privkey_evm.pem";
> > +	key =3D imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> >=20
> >  	if (digsig) {
> >  		err =3D sign_ima(file, key);
> > @@ -842,13 +843,13 @@ static int cmd_verify_evm(struct command *cmd)
> >  		return -1;
> >  	}
> >=20
> > -	if (params.keyfile)	/* Support multiple public keys */
> > -		init_public_keys(params.keyfile);
> > -	else			/* assume read pubkey from x509 cert */
> > +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> > +		init_public_keys(imaevm_params.keyfile);
> > +	else				/* assume read pubkey from x509 cert */
> >  		init_public_keys("/etc/keys/x509_evm.der");
> >=20
> >  	err =3D verify_evm(file);
> > -	if (!err && params.verbose >=3D LOG_INFO)
> > +	if (!err && imaevm_params.verbose >=3D LOG_INFO)
> >  		log_info("%s: verification is OK\n", file);
> >  	return err;
> >  }
> > @@ -888,9 +889,9 @@ static int cmd_verify_ima(struct command *cmd)
> >  	char *file =3D g_argv[optind++];
> >  	int err;
> >=20
> > -	if (params.keyfile)	/* Support multiple public keys */
> > -		init_public_keys(params.keyfile);
> > -	else			/* assume read pubkey from x509 cert */
> > +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> > +		init_public_keys(imaevm_params.keyfile);
> > +	else				/* assume read pubkey from x509 cert */
> >  		init_public_keys("/etc/keys/x509_evm.der");
> >=20
> >  	errno =3D 0;
> > @@ -902,7 +903,7 @@ static int cmd_verify_ima(struct command *cmd)
> >=20
> >  	do {
> >  		err =3D verify_ima(file);
> > -		if (!err && params.verbose >=3D LOG_INFO)
> > +		if (!err && imaevm_params.verbose >=3D LOG_INFO)
> >  			log_info("%s: verification is OK\n", file);
> >  	} while ((file =3D g_argv[optind++]));
> >  	return err;
> > @@ -917,15 +918,15 @@ static int cmd_convert(struct command *cmd)
> >  	uint8_t keyid[8];
> >  	RSA *key;
> >=20
> > -	params.x509 =3D 0;
> > +	imaevm_params.x509 =3D 0;
> >=20
> >  	inkey =3D g_argv[optind++];
> >  	if (!inkey) {
> > -		inkey =3D params.x509 ? "/etc/keys/x509_evm.der" :
> > -				      "/etc/keys/pubkey_evm.pem";
> > +		inkey =3D imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
> > +					     "/etc/keys/pubkey_evm.pem";
> >  	}
> >=20
> > -	key =3D read_pub_key(inkey, params.x509);
> > +	key =3D read_pub_key(inkey, imaevm_params.x509);
> >  	if (!key)
> >  		return 1;
> >=20
> > @@ -949,8 +950,8 @@ static int cmd_import(struct command *cmd)
> >=20
> >  	inkey =3D g_argv[optind++];
> >  	if (!inkey) {
> > -		inkey =3D params.x509 ? "/etc/keys/x509_evm.der" :
> > -				      "/etc/keys/pubkey_evm.pem";
> > +		inkey =3D imaevm_params.x509 ? "/etc/keys/x509_evm.der" :
> > +					     "/etc/keys/pubkey_evm.pem";
> >  	} else
> >  		ring =3D g_argv[optind++];
> >=20
> > @@ -979,8 +980,8 @@ static int cmd_import(struct command *cmd)
> >  		}
> >  	}
> >=20
> > -	if (params.x509) {
> > -		EVP_PKEY *pkey =3D read_pub_pkey(inkey, params.x509);
> > +	if (imaevm_params.x509) {
> > +		EVP_PKEY *pkey =3D read_pub_pkey(inkey, imaevm_params.x509);
> >=20
> >  		if (!pkey)
> >  			return 1;
> > @@ -992,7 +993,7 @@ static int cmd_import(struct command *cmd)
> >  		calc_keyid_v2((uint32_t *)keyid, name, pkey);
> >  		EVP_PKEY_free(pkey);
> >  	} else {
> > -		RSA *key =3D read_pub_key(inkey, params.x509);
> > +		RSA *key =3D read_pub_key(inkey, imaevm_params.x509);
> >=20
> >  		if (!key)
> >  			return 1;
> > @@ -1003,7 +1004,8 @@ static int cmd_import(struct command *cmd)
> >=20
> >  	log_info("Importing public key %s from file %s into keyring %d\n", na=
me, inkey, id);
> >=20
> > -	id =3D add_key(params.x509 ? "asymmetric" : "user", params.x509 ? NUL=
L : name, pub, len, id);
> > +	id =3D add_key(imaevm_params.x509 ? "asymmetric" : "user",
> > +		     imaevm_params.x509 ? NULL : name, pub, len, id);
> >  	if (id < 0) {
> >  		log_err("add_key failed\n");
> >  		err =3D id;
> > @@ -1011,7 +1013,7 @@ static int cmd_import(struct command *cmd)
> >  		log_info("keyid: %d\n", id);
> >  		printf("%d\n", id);
> >  	}
> > -	if (params.x509)
> > +	if (imaevm_params.x509)
> >  		free(pub);
> >  	return err;
> >  }
> > @@ -1123,9 +1125,10 @@ static int calc_evm_hmac(const char *file, const=
 char *keyfile, unsigned char *h
> >  		goto out;
> >  	}
> >=20
> > -	md =3D EVP_get_digestbyname(params.hash_algo);
> > +	md =3D EVP_get_digestbyname(imaevm_params.hash_algo);
> >  	if (!md) {
> > -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> > +		log_err("EVP_get_digestbyname(%s) failed\n",
> > +			imaevm_params.hash_algo);
> >  		goto out;
> >  	}
> >=20
> > @@ -1247,7 +1250,7 @@ static int cmd_hmac_evm(struct command *cmd)
> >  		return -1;
> >  	}
> >=20
> > -	key =3D params.keyfile ? : "/etc/keys/privkey_evm.pem";
> > +	key =3D imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
> >=20
> >  	if (digsig) {
> >  		err =3D sign_ima(file, key);
> > @@ -1588,7 +1591,7 @@ void ima_ng_show(struct template_entry *entry)
> >  	}
> >=20
> >  	/* ascii_runtime_measurements */
> > -	if (params.verbose > LOG_INFO) {
> > +	if (imaevm_params.verbose > LOG_INFO) {
> >  		log_info("%d ", entry->header.pcr);
> >  		log_dump_n(entry->header.digest, sizeof(entry->header.digest));
> >  		log_info(" %s %s", entry->name, algo);
> > @@ -1601,7 +1604,7 @@ void ima_ng_show(struct template_entry *entry)
> >  	}
> >=20
> >  	if (sig) {
> > -		if (params.verbose > LOG_INFO) {
> > +		if (imaevm_params.verbose > LOG_INFO) {
> >  			log_info(" ");
> >  			log_dump(sig, sig_len);
> >  		}
> > @@ -1610,10 +1613,10 @@ void ima_ng_show(struct template_entry *entry)
> >  						   digest, digest_len);
> >  		else
> >  			err =3D ima_verify_signature(path, sig, sig_len, NULL, 0);
> > -		if (!err && params.verbose > LOG_INFO)
> > +		if (!err && imaevm_params.verbose > LOG_INFO)
> >  			log_info("%s: verification is OK\n", path);
> >  	} else {
> > -		if (params.verbose > LOG_INFO)
> > +		if (imaevm_params.verbose > LOG_INFO)
> >  			log_info("\n");
> >  	}
> >=20
> > @@ -1648,9 +1651,9 @@ static int ima_measurement(const char *file)
> >  		return -1;
> >  	}
> >=20
> > -	if (params.keyfile)	/* Support multiple public keys */
> > -		init_public_keys(params.keyfile);
> > -	else			/* assume read pubkey from x509 cert */
> > +	if (imaevm_params.keyfile)	/* Support multiple public keys */
> > +		init_public_keys(imaevm_params.keyfile);
> > +	else				/* assume read pubkey from x509 cert */
> >  		init_public_keys("/etc/keys/x509_evm.der");
> >=20
> >  	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
> > @@ -1959,7 +1962,7 @@ int main(int argc, char *argv[])
> >  			exit(0);
> >  			break;
> >  		case 'v':
> > -			params.verbose++;
> > +			imaevm_params.verbose++;
> >  			break;
> >  		case 'd':
> >  			digest =3D 1;
> > @@ -1973,13 +1976,13 @@ int main(int argc, char *argv[])
> >  			sigdump =3D 1;
> >  			break;
> >  		case 'a':
> > -			params.hash_algo =3D optarg;
> > +			imaevm_params.hash_algo =3D optarg;
> >  			break;
> >  		case 'p':
> >  			if (optarg)
> > -				params.keypass =3D optarg;
> > +				imaevm_params.keypass =3D optarg;
> >  			else
> > -				params.keypass =3D get_password();
> > +				imaevm_params.keypass =3D get_password();
> >  			break;
> >  		case 'f':
> >  			sigfile =3D 1;
> > @@ -1990,10 +1993,10 @@ int main(int argc, char *argv[])
> >  				hmac_flags |=3D HMAC_FLAG_NO_UUID;
> >  			break;
> >  		case '1':
> > -			params.x509 =3D 0;
> > +			imaevm_params.x509 =3D 0;
> >  			break;
> >  		case 'k':
> > -			params.keyfile =3D optarg;
> > +			imaevm_params.keyfile =3D optarg;
> >  			break;
> >  		case 'i':
> >  			if (evm_portable)
> > diff --git a/src/imaevm.h b/src/imaevm.h
> > index 0414433..b881d92 100644
> > --- a/src/imaevm.h
> > +++ b/src/imaevm.h
> > @@ -50,8 +50,10 @@
> >  #include <openssl/rsa.h>
> >=20
> >  #ifdef USE_FPRINTF
> > -#define do_log(level, fmt, args...)	({ if (level <=3D params.verbose) =
fprintf(stderr, fmt, ##args); })
> > -#define do_log_dump(level, p, len, cr)	({ if (level <=3D params.verbos=
e) do_dump(stderr, p, len, cr); })
> > +#define do_log(level, fmt, args...)	\
> > +	({ if (level <=3D imaevm_params.verbose) fprintf(stderr, fmt, ##args)=
; })
> > +#define do_log_dump(level, p, len, cr)	\
> > +	({ if (level <=3D imaevm_params.verbose) imaevm_do_hexdump(stderr, p,=
 len, cr); })
> >  #else
> >  #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
> >  #define do_log_dump(level, p, len, cr)
> > @@ -188,7 +190,7 @@ struct signature_v2_hdr {
> >  	uint8_t sig[0];		/* signature payload */
> >  } __packed;
> >=20
> > -struct libevm_params {
> > +struct libimaevm_params {
> >  	int verbose;
> >  	int x509;
> >  	const char *hash_algo;
> > @@ -204,12 +206,12 @@ struct RSA_ASN1_template {
> >  #define	NUM_PCRS 20
> >  #define DEFAULT_PCR 10
> >=20
> > -extern struct libevm_params params;
> > +extern struct libimaevm_params imaevm_params;
> >=20
> > -void do_dump(FILE *fp, const void *ptr, int len, bool cr);
> > -void dump(const void *ptr, int len);
> > +void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr);
> > +void imaevm_hexdump(const void *ptr, int len);
> >  int ima_calc_hash(const char *file, uint8_t *hash);
> > -int get_hash_algo(const char *algo);
> > +int imaevm_get_hash_algo(const char *algo);
> >  RSA *read_pub_key(const char *keyfile, int x509);
> >  EVP_PKEY *read_pub_pkey(const char *keyfile, int x509);
> >=20
> > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > index 11dbf11..a582872 100644
> > --- a/src/libimaevm.c
> > +++ b/src/libimaevm.c
> > @@ -81,7 +81,7 @@ const char *const pkey_hash_algo_kern[PKEY_HASH__LAST=
] =3D {
> >  	[PKEY_HASH_STREEBOG_512] =3D "streebog512",
> >  };
> >=20
> > -struct libevm_params params =3D {
> > +struct libimaevm_params imaevm_params =3D {
> >  	.verbose =3D LOG_INFO - 1,
> >  	.x509 =3D 1,
> >  	.hash_algo =3D "sha1",
> > @@ -89,7 +89,7 @@ struct libevm_params params =3D {
> >=20
> >  static void __attribute__ ((constructor)) libinit(void);
> >=20
> > -void do_dump(FILE *fp, const void *ptr, int len, bool cr)
> > +void imaevm_do_hexdump(FILE *fp, const void *ptr, int len, bool cr)
> >  {
> >  	int i;
> >  	uint8_t *data =3D (uint8_t *) ptr;
> > @@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bo=
ol cr)
> >  		fprintf(fp, "\n");
> >  }
> >=20
> > -void dump(const void *ptr, int len)
> > +void imaevm_hexdump(const void *ptr, int len)
> >  {
> > -	do_dump(stdout, ptr, len, true);
> > +	imaevm_do_hexdump(stdout, ptr, len, true);
> >  }
> >=20
> >  const char *get_hash_algo_by_id(int algo)
> > @@ -258,9 +258,10 @@ int ima_calc_hash(const char *file, uint8_t *hash)
> >  		goto err;
> >  	}
> >=20
> > -	md =3D EVP_get_digestbyname(params.hash_algo);
> > +	md =3D EVP_get_digestbyname(imaevm_params.hash_algo);
> >  	if (!md) {
> > -		log_err("EVP_get_digestbyname(%s) failed\n", params.hash_algo);
> > +		log_err("EVP_get_digestbyname(%s) failed\n",
> > +			imaevm_params.hash_algo);
> >  		err =3D 1;
> >  		goto err;
> >  	}
> > @@ -500,8 +501,8 @@ static int verify_hash_v2(const char *file, const u=
nsigned char *hash, int size,
> >  	const EVP_MD *md;
> >  	const char *st;
> >=20
> > -	if (params.verbose > LOG_INFO) {
> > -		log_info("hash(%s): ", params.hash_algo);
> > +	if (imaevm_params.verbose > LOG_INFO) {
> > +		log_info("hash(%s): ", imaevm_params.hash_algo);
> >  		log_dump(hash, size);
> >  	}
> >=20
> > @@ -521,7 +522,7 @@ static int verify_hash_v2(const char *file, const u=
nsigned char *hash, int size,
> >  	if (!EVP_PKEY_verify_init(ctx))
> >  		goto err;
> >  	st =3D "EVP_get_digestbyname";
> > -	if (!(md =3D EVP_get_digestbyname(params.hash_algo)))
> > +	if (!(md =3D EVP_get_digestbyname(imaevm_params.hash_algo)))
> >  		goto err;
> >  	st =3D "EVP_PKEY_CTX_set_signature_md";
> >  	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> > @@ -550,7 +551,7 @@ err:
> >  	return ret;
> >  }
> >=20
> > -int get_hash_algo(const char *algo)
> > +int imaevm_get_hash_algo(const char *algo)
> >  {
> >  	int i;
> >=20
> > @@ -609,7 +610,7 @@ int verify_hash(const char *file, const unsigned ch=
ar *hash, int size, unsigned
> >  		const char *key =3D NULL;
> >=20
> >  		/* Read pubkey from RSA key */
> > -		if (!params.keyfile)
> > +		if (!imaevm_params.keyfile)
> >  			key =3D "/etc/keys/pubkey_evm.pem";
> >  		return verify_hash_v1(file, hash, size, sig, siglen, key);
> >  	} else if (sig[0] =3D=3D DIGSIG_VERSION_2) {
> > @@ -635,7 +636,7 @@ int ima_verify_signature(const char *file, unsigned=
 char *sig, int siglen,
> >  		return -1;
> >  	}
> >  	/* Use hash algorithm as retrieved from signature */
> > -	params.hash_algo =3D get_hash_algo_by_id(sig_hash_algo);
> > +	imaevm_params.hash_algo =3D get_hash_algo_by_id(sig_hash_algo);
> >=20
> >  	/*
> >  	 * Validate the signature based on the digest included in the
> > @@ -707,7 +708,7 @@ void calc_keyid_v1(uint8_t *keyid, char *str, const=
 unsigned char *pkey, int len
> >  	id =3D __be64_to_cpup((__be64 *) keyid);
> >  	sprintf(str, "%llX", (unsigned long long)id);
> >=20
> > -	if (params.verbose > LOG_INFO)
> > +	if (imaevm_params.verbose > LOG_INFO)
> >  		log_info("keyid-v1: %s\n", str);
> >  }
> >=20
> > @@ -735,7 +736,7 @@ void calc_keyid_v2(uint32_t *keyid, char *str, EVP_=
PKEY *pkey)
> >  	log_debug_dump(keyid, 4);
> >  	sprintf(str, "%x", __be32_to_cpup(keyid));
> >=20
> > -	if (params.verbose > LOG_INFO)
> > +	if (imaevm_params.verbose > LOG_INFO)
> >  		log_info("keyid: %s\n", str);
> >=20
> >  	X509_PUBKEY_free(pk);
> > @@ -825,7 +826,7 @@ int sign_hash_v1(const char *hashalgo, const unsign=
ed char *hash, int size, cons
> >  	log_info("hash(%s): ", hashalgo);
> >  	log_dump(hash, size);
> >=20
> > -	key =3D read_priv_key(keyfile, params.keypass);
> > +	key =3D read_priv_key(keyfile, imaevm_params.keypass);
> >  	if (!key)
> >  		return -1;
> >=20
> > @@ -908,17 +909,17 @@ int sign_hash_v2(const char *algo, const unsigned=
 char *hash, int size, const ch
> >  		return -1;
> >  	}
> >=20
> > -	log_info("hash(%s): ", params.hash_algo);
> > +	log_info("hash(%s): ", imaevm_params.hash_algo);
> >  	log_dump(hash, size);
> >=20
> > -	pkey =3D read_priv_pkey(keyfile, params.keypass);
> > +	pkey =3D read_priv_pkey(keyfile, imaevm_params.keypass);
> >  	if (!pkey)
> >  		return -1;
> >=20
> >  	hdr =3D (struct signature_v2_hdr *)sig;
> >  	hdr->version =3D (uint8_t) DIGSIG_VERSION_2;
> >=20
> > -	hdr->hash_algo =3D get_hash_algo(algo);
> > +	hdr->hash_algo =3D imaevm_get_hash_algo(algo);
> >  	if (hdr->hash_algo =3D=3D -1) {
> >  		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
> >  		return -1;
> > @@ -934,7 +935,7 @@ int sign_hash_v2(const char *algo, const unsigned c=
har *hash, int size, const ch
> >  	if (!EVP_PKEY_sign_init(ctx))
> >  		goto err;
> >  	st =3D "EVP_get_digestbyname";
> > -	if (!(md =3D EVP_get_digestbyname(params.hash_algo)))
> > +	if (!(md =3D EVP_get_digestbyname(imaevm_params.hash_algo)))
> >  		goto err;
> >  	st =3D "EVP_PKEY_CTX_set_signature_md";
> >  	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
> > @@ -965,10 +966,11 @@ err:
> >  int sign_hash(const char *hashalgo, const unsigned char *hash, int siz=
e, const char *keyfile, const char *keypass, unsigned char *sig)
> >  {
> >  	if (keypass)
> > -		params.keypass =3D keypass;
> > +		imaevm_params.keypass =3D keypass;
> >=20
> > -	return params.x509 ? sign_hash_v2(hashalgo, hash, size, keyfile, sig)=
 :
> > -			     sign_hash_v1(hashalgo, hash, size, keyfile, sig);
> > +	return imaevm_params.x509 ?
> > +		sign_hash_v2(hashalgo, hash, size, keyfile, sig) :
> > +		sign_hash_v1(hashalgo, hash, size, keyfile, sig);
> >  }
> >=20
> >  static void libinit()
>=20

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl05yIoACgkQYdRkFR+R
okNiNQgAhyppoeJh5E1ihK7OJ5Cs+d/8vVB3McjPtPKqmIwAHj0devtiTRgJ0yTh
MIFlghSMX9UidW3vTy0f70ljaTRRn0WfiFi0vdClzgwPnOdlzfDA1/GO75Kl8rBj
HgBV1naS7BL1Ga5v4R8AUtXiUn60d3e4N8sYXen2novp0rqTOatWntKvS6oD3fyJ
FTlwF4Vv/6JD9gkW5tmuPbaz3epdtH/UZP8dPfinNnJRoUsnIRKyvqWCJBhibkDI
v0TrhorIp0dfozdMqNbC8AYHavy9IDmBnk9Wo3hNxamIT78IFMOLtrsyQKo9BKok
akgx8imJ3ReA4QOV2pXuvqm39nydaw==
=KIf7
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
