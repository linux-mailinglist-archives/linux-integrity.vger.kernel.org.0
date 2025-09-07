Return-Path: <linux-integrity+bounces-7023-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790EFB47B22
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0B43B7B81
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5327261591;
	Sun,  7 Sep 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MDh6vUk7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5FF1F542E;
	Sun,  7 Sep 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757246242; cv=none; b=nhAPwsKp11PvuA4ak2GA4CoSDamj7qB6vjcKvSC88wRYIQt1CS+JCRas2ZJNh4Z4HRwVLx4Ly2Z/mSS6bQ0tA1RcVcJ5anZrjZgFRo8Py8w7ie3NME1E24Jzl5AEimod/y0DZIuFYpudvadZYeA7XqwkIVDShwyWMPNLs8V5qS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757246242; c=relaxed/simple;
	bh=RG4N7ZNEOSqERs6QrVwciW8Tyk7wLboDLnI6C/rRAkM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=E9Y5UGsrqaalYqfn1fWfbsmX1M2rc1Ffdjaj2izUp+A511vrIK0H/T6o6Pqilr7HHq0GVeTpXc680AVg3vw0ufBCDz6ruOCyHSR9rJSYncYp2v/laabmcXvGPycdNoTloMAZUlFhaGRH4XVooxP/6SP4tqFo0mp9CPERAKeYzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MDh6vUk7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5879UMFu015272;
	Sun, 7 Sep 2025 11:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MCULcl
	s5f8rxSp+Pf5xY5CUPcGY2H23aBtUdgGNoalc=; b=MDh6vUk7RqsZtbaJq6xtwJ
	86W0zz7wvAkZUV86U7l0yGht8fjpmWrnk+s+t1RQWVwGSBJtcAaffq4gnyJrFY/7
	Vku8D89L48wfrtJVS6P40973H83DZ4G3aHLYE4LI6zhtlOYY+/0nn7XVKMMITsRO
	32cdap5lJQtKTarW2YOyb0kFfTFKPfxogre5c7nJykmDaJX0obBVFg7QoPvZu0hb
	0oc3PzOpX5xWDWfuSXHafRuQyMTgsx/1qaNt5Y0Apa7+n2oVUZpPSdvRmO3RM/Z9
	4yn6m10/pfnEZyx0DSzw3mTyeVSOy6z9tdsPmEgyXgjnruaEAEJp7wLwnw8ovHTQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwckrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 11:57:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5877AeXF007912;
	Sun, 7 Sep 2025 11:57:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109p9kar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 11:57:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 587BvEcH19006132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Sep 2025 11:57:14 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 390A958050;
	Sun,  7 Sep 2025 11:57:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6514158045;
	Sun,  7 Sep 2025 11:57:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.73])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Sep 2025 11:57:13 +0000 (GMT)
Message-ID: <e8fff5a1607ce2d98c5999d522202e1104f0a12d.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: Use SHA-256 library instead of
 crypto_shash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <aJIKH3-fRizRV8fi@kernel.org>
References: <20250731184747.12335-1-ebiggers@kernel.org>
	 <aJIKH3-fRizRV8fi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Sep 2025 07:57:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s3QEORdrf-hAXNA_0bQrG8LWJQIqUBJe
X-Proofpoint-ORIG-GUID: s3QEORdrf-hAXNA_0bQrG8LWJQIqUBJe
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bd731c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=kwrG7CGN9jUrtrt_hGMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXy8BvwuByCj2+
 OJDPxQwR+YN/uXvL6hLV0IeehbcJFagEiVLyh3HMh9IiwaxUn0pqTIKpr5TXRpSz/wTR/4V6Ebp
 cj8ObFblYq3tpDMOhFfWKmAawKmqgSP8tQqY2MEMaOMjhZszOx4lzz8qKWG2wwHIzPBen8qKANg
 TLnsE/Omvz6sI6oIqK/E601qZNLnejy8Kic7ar+86/OTd9v/L/V5U1CETTqDCvr5hMb2PiL4B0+
 i/Oxj3BCDh8r+ub+by5vlnmhJqljXJnfZ+JLW5t+ejFtANsOrr344O0CIxuhDo2cbhjrQ/lBayH
 66E37t+ousMda+R1bgLT5kvkOaSNCYJR4r7qYTDQudZ7W9x/5SaeRjcsgRIzadG375aSfI2lUuH
 LjZZ4MSI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Tue, 2025-08-05 at 16:41 +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 31, 2025 at 11:47:47AM -0700, Eric Biggers wrote:
> > Instead of the "sha256" crypto_shash, just use sha256().  Similarly,
> > instead of the "hmac(sha256)" crypto_shash, just use
> > hmac_sha256_usingrawkey().  This is simpler and faster.
> >=20
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>=20
> Yeah, fully agree.
>=20
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> David, will you pick this?
>=20

Do you want this patch being upstreamed with "[PATCH 0/2] Convert lib/digsi=
g.c
to SHA-1 library" patch set?

thanks,

Mimi

>=20
> > ---
> >  security/keys/Kconfig                    |  3 +-
> >  security/keys/encrypted-keys/encrypted.c | 63 ++++--------------------
> >  2 files changed, 11 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> > index d4f5fc1e72638..64477e2c4a212 100644
> > --- a/security/keys/Kconfig
> > +++ b/security/keys/Kconfig
> > @@ -85,14 +85,13 @@ endif
> > =20
> >  config ENCRYPTED_KEYS
> >  	tristate "ENCRYPTED KEYS"
> >  	depends on KEYS
> >  	select CRYPTO
> > -	select CRYPTO_HMAC
> >  	select CRYPTO_AES
> >  	select CRYPTO_CBC
> > -	select CRYPTO_SHA256
> > +	select CRYPTO_LIB_SHA256
> >  	select CRYPTO_RNG
> >  	help
> >  	  This option provides support for create/encrypting/decrypting keys
> >  	  in the kernel.  Encrypted keys are instantiated using kernel
> >  	  generated random numbers or provided decrypted data, and are
> > diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/e=
ncrypted-keys/encrypted.c
> > index 831cb84fd75a1..513c09e2b01cf 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -25,22 +25,19 @@
> >  #include <linux/random.h>
> >  #include <linux/rcupdate.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/ctype.h>
> >  #include <crypto/aes.h>
> > -#include <crypto/hash.h>
> >  #include <crypto/sha2.h>
> >  #include <crypto/skcipher.h>
> >  #include <crypto/utils.h>
> > =20
> >  #include "encrypted.h"
> >  #include "ecryptfs_format.h"
> > =20
> >  static const char KEY_TRUSTED_PREFIX[] =3D "trusted:";
> >  static const char KEY_USER_PREFIX[] =3D "user:";
> > -static const char hash_alg[] =3D "sha256";
> > -static const char hmac_alg[] =3D "hmac(sha256)";
> >  static const char blkcipher_alg[] =3D "cbc(aes)";
> >  static const char key_format_default[] =3D "default";
> >  static const char key_format_ecryptfs[] =3D "ecryptfs";
> >  static const char key_format_enc32[] =3D "enc32";
> >  static unsigned int ivsize;
> > @@ -52,12 +49,10 @@ static int blksize;
> >  #define HASH_SIZE SHA256_DIGEST_SIZE
> >  #define MAX_DATA_SIZE 4096
> >  #define MIN_DATA_SIZE  20
> >  #define KEY_ENC32_PAYLOAD_LEN 32
> > =20
> > -static struct crypto_shash *hash_tfm;
> > -
> >  enum {
> >  	Opt_new, Opt_load, Opt_update, Opt_err
> >  };
> > =20
> >  enum {
> > @@ -327,39 +322,18 @@ static struct key *request_user_key(const char *m=
aster_desc, const u8 **master_k
> >  	*master_keylen =3D upayload->datalen;
> >  error:
> >  	return ukey;
> >  }
> > =20
> > -static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
> > -		     const u8 *buf, unsigned int buflen)
> > -{
> > -	struct crypto_shash *tfm;
> > -	int err;
> > -
> > -	tfm =3D crypto_alloc_shash(hmac_alg, 0, 0);
> > -	if (IS_ERR(tfm)) {
> > -		pr_err("encrypted_key: can't alloc %s transform: %ld\n",
> > -		       hmac_alg, PTR_ERR(tfm));
> > -		return PTR_ERR(tfm);
> > -	}
> > -
> > -	err =3D crypto_shash_setkey(tfm, key, keylen);
> > -	if (!err)
> > -		err =3D crypto_shash_tfm_digest(tfm, buf, buflen, digest);
> > -	crypto_free_shash(tfm);
> > -	return err;
> > -}
> > -
> >  enum derived_key_type { ENC_KEY, AUTH_KEY };
> > =20
> >  /* Derive authentication/encryption key from trusted key */
> >  static int get_derived_key(u8 *derived_key, enum derived_key_type key_=
type,
> >  			   const u8 *master_key, size_t master_keylen)
> >  {
> >  	u8 *derived_buf;
> >  	unsigned int derived_buf_len;
> > -	int ret;
> > =20
> >  	derived_buf_len =3D strlen("AUTH_KEY") + 1 + master_keylen;
> >  	if (derived_buf_len < HASH_SIZE)
> >  		derived_buf_len =3D HASH_SIZE;
> > =20
> > @@ -372,14 +346,13 @@ static int get_derived_key(u8 *derived_key, enum =
derived_key_type key_type,
> >  	else
> >  		strcpy(derived_buf, "ENC_KEY");
> > =20
> >  	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
> >  	       master_keylen);
> > -	ret =3D crypto_shash_tfm_digest(hash_tfm, derived_buf, derived_buf_le=
n,
> > -				      derived_key);
> > +	sha256(derived_buf, derived_buf_len, derived_key);
> >  	kfree_sensitive(derived_buf);
> > -	return ret;
> > +	return 0;
> >  }
> > =20
> >  static struct skcipher_request *init_skcipher_req(const u8 *key,
> >  						  unsigned int key_len)
> >  {
> > @@ -501,14 +474,14 @@ static int datablob_hmac_append(struct encrypted_=
key_payload *epayload,
> >  	ret =3D get_derived_key(derived_key, AUTH_KEY, master_key, master_key=
len);
> >  	if (ret < 0)
> >  		goto out;
> > =20
> >  	digest =3D epayload->format + epayload->datablob_len;
> > -	ret =3D calc_hmac(digest, derived_key, sizeof derived_key,
> > -			epayload->format, epayload->datablob_len);
> > -	if (!ret)
> > -		dump_hmac(NULL, digest, HASH_SIZE);
> > +	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key),
> > +				epayload->format, epayload->datablob_len,
> > +				digest);
> > +	dump_hmac(NULL, digest, HASH_SIZE);
> >  out:
> >  	memzero_explicit(derived_key, sizeof(derived_key));
> >  	return ret;
> >  }
> > =20
> > @@ -532,13 +505,12 @@ static int datablob_hmac_verify(struct encrypted_=
key_payload *epayload,
> >  		p =3D epayload->master_desc;
> >  		len -=3D strlen(epayload->format) + 1;
> >  	} else
> >  		p =3D epayload->format;
> > =20
> > -	ret =3D calc_hmac(digest, derived_key, sizeof derived_key, p, len);
> > -	if (ret < 0)
> > -		goto out;
> > +	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key), p, len,
> > +				digest);
> >  	ret =3D crypto_memneq(digest, epayload->format + epayload->datablob_l=
en,
> >  			    sizeof(digest));
> >  	if (ret) {
> >  		ret =3D -EINVAL;
> >  		dump_hmac("datablob",
> > @@ -1009,33 +981,18 @@ EXPORT_SYMBOL_GPL(key_type_encrypted);
> > =20
> >  static int __init init_encrypted(void)
> >  {
> >  	int ret;
> > =20
> > -	hash_tfm =3D crypto_alloc_shash(hash_alg, 0, 0);
> > -	if (IS_ERR(hash_tfm)) {
> > -		pr_err("encrypted_key: can't allocate %s transform: %ld\n",
> > -		       hash_alg, PTR_ERR(hash_tfm));
> > -		return PTR_ERR(hash_tfm);
> > -	}
> > -
> >  	ret =3D aes_get_sizes();
> >  	if (ret < 0)
> > -		goto out;
> > -	ret =3D register_key_type(&key_type_encrypted);
> > -	if (ret < 0)
> > -		goto out;
> > -	return 0;
> > -out:
> > -	crypto_free_shash(hash_tfm);
> > -	return ret;
> > -
> > +		return ret;
> > +	return register_key_type(&key_type_encrypted);
> >  }
> > =20
> >  static void __exit cleanup_encrypted(void)
> >  {
> > -	crypto_free_shash(hash_tfm);
> >  	unregister_key_type(&key_type_encrypted);
> >  }
> > =20
> >  late_initcall(init_encrypted);
> >  module_exit(cleanup_encrypted);
> >=20
> > base-commit: d6084bb815c453de27af8071a23163a711586a6c
> > --=20
> > 2.50.1
> >=20
>=20


