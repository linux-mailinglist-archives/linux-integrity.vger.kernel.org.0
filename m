Return-Path: <linux-integrity+bounces-7022-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8CEB47B1C
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416AF17B113
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 11:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3A25D540;
	Sun,  7 Sep 2025 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lZJ9Zdt4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DF258EC3;
	Sun,  7 Sep 2025 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757245934; cv=none; b=G6gIGapiRn2Wu7Z9oq+upWPXQAFFao3pOGTuX5x5jJ6pvvAIbIi4yjT1prbgy+kpUamUYHRLYNfuKGrX4HX2hnGRW7t7yKti8yvP1337d7fYrNpTLE4OTx+jFr+0VfPuMugiJycE0KAUWFHQAHDtHA23l8hkjx1bEAraKnrZCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757245934; c=relaxed/simple;
	bh=FuS492IWtRlzgeCDKXwwXovLPB2YaHTzcyK3rbaCATQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ix7UeKDUDzL6OYKZ2WGgitmQ6QV5ViEVNlY4WzvyW7JR92PaZYPDHq7mpNZW9ls180ThTzZXUWncGbraD2y9m3cY8UBnpFlX61e/y/znBo8oMs/v9JisJ5KjVgepe4OHx3ROgjGHnCOxfkBnJ1Mag2LcAe14k6ApAXiL2icwJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lZJ9Zdt4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5878fKYx026934;
	Sun, 7 Sep 2025 11:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FsVALi
	RRAllNFGirPGtkrvOmCUeOWcqA9YceqJMGQaE=; b=lZJ9Zdt4ZLYkuPrbu7FQ25
	WI76Cj1C5QT38p/Y65ruEvIZlmujZA2jhvRvU6Ek+phEJVS+eYKNZ81UyoZDq+M5
	upWKURyMIzC2I/FOZjOvXGKsECGb4OruSQxLZFnY/BGxP2TO9ISoylRmVpb32ed8
	aoxVnxmqKcYvCCAnL8BninITbxNo2bJ+ae7HI+ok677d/cxgIG65E2x+dCmdPaZ+
	ME3QfxPx7jlE+wmBI/W8vmasjrkLxgpyIdj28xxsgWfUvme0oSI1Ncp9fzXczAbp
	YvKNIXlOBiJYZZU6YyF9pamSCpEc5fFRfQ4XwYRKmbetyau03QxOsH2/9Votr83Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwck84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 11:51:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5878rr04001177;
	Sun, 7 Sep 2025 11:51:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49120318yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 11:51:56 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 587BptN052953582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Sep 2025 11:51:55 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1EE458065;
	Sun,  7 Sep 2025 11:51:55 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC705804B;
	Sun,  7 Sep 2025 11:51:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.73])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Sep 2025 11:51:55 +0000 (GMT)
Message-ID: <e38f203a4bd95c9728cc04745a82d174e18fa208.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: Use SHA-256 library instead of
 crypto_shash
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        David
 Howells	 <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250731184747.12335-1-ebiggers@kernel.org>
References: <20250731184747.12335-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Sep 2025 07:51:54 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QAzx-Pck9uJgk_peDD6_6Mz6rQNYUflT
X-Proofpoint-ORIG-GUID: QAzx-Pck9uJgk_peDD6_6Mz6rQNYUflT
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bd71dd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8Xp7l_ZNKlO8CDZGx5MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfXzmuLCisRhC+M
 E1tkEPdpjRH2qAee5MN79m9sjh/1npUVvigBEyaX5ZTuQtiK144ak0T2/y1XNLEOv7Bpih6IJfp
 O00NurX0WDpJlRowJInSgH/gQuFgZlDITQJE329fO9woL0D5IBtaC0So4UWc9jMOmrgEExmaZX7
 kViFjOiHUcnqfR5I4nikV/SFpVjgN7w6Pea2DnFvJz0OAhq+CRJykxsfuGhL8EH1Za8wW0ozp+t
 x+fCQw8q7GqWrKXaC5wFdJXHUTGW7eJ2SHpzsp8BKgQAtHLYp/Y1tihIeedp/9VBxYVEx4jI0R5
 hVYsMOWO2KOh1t20HQbZrKASvpIL1wh4oI44Jp0uah5mu0GK+eVPcUVsYZK8FFxRuf4gw8iEvjg
 nBVSimG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

On Thu, 2025-07-31 at 11:47 -0700, Eric Biggers wrote:
> Instead of the "sha256" crypto_shash, just use sha256().  Similarly,
> instead of the "hmac(sha256)" crypto_shash, just use
> hmac_sha256_usingrawkey().  This is simpler and faster.
>=20
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/keys/Kconfig                    |  3 +-
>  security/keys/encrypted-keys/encrypted.c | 63 ++++--------------------
>  2 files changed, 11 insertions(+), 55 deletions(-)
>=20
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index d4f5fc1e72638..64477e2c4a212 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -85,14 +85,13 @@ endif
> =20
>  config ENCRYPTED_KEYS
>  	tristate "ENCRYPTED KEYS"
>  	depends on KEYS
>  	select CRYPTO
> -	select CRYPTO_HMAC
>  	select CRYPTO_AES
>  	select CRYPTO_CBC
> -	select CRYPTO_SHA256
> +	select CRYPTO_LIB_SHA256
>  	select CRYPTO_RNG
>  	help
>  	  This option provides support for create/encrypting/decrypting keys
>  	  in the kernel.  Encrypted keys are instantiated using kernel
>  	  generated random numbers or provided decrypted data, and are
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/enc=
rypted-keys/encrypted.c
> index 831cb84fd75a1..513c09e2b01cf 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -25,22 +25,19 @@
>  #include <linux/random.h>
>  #include <linux/rcupdate.h>
>  #include <linux/scatterlist.h>
>  #include <linux/ctype.h>
>  #include <crypto/aes.h>
> -#include <crypto/hash.h>
>  #include <crypto/sha2.h>
>  #include <crypto/skcipher.h>
>  #include <crypto/utils.h>
> =20
>  #include "encrypted.h"
>  #include "ecryptfs_format.h"
> =20
>  static const char KEY_TRUSTED_PREFIX[] =3D "trusted:";
>  static const char KEY_USER_PREFIX[] =3D "user:";
> -static const char hash_alg[] =3D "sha256";
> -static const char hmac_alg[] =3D "hmac(sha256)";
>  static const char blkcipher_alg[] =3D "cbc(aes)";
>  static const char key_format_default[] =3D "default";
>  static const char key_format_ecryptfs[] =3D "ecryptfs";
>  static const char key_format_enc32[] =3D "enc32";
>  static unsigned int ivsize;
> @@ -52,12 +49,10 @@ static int blksize;
>  #define HASH_SIZE SHA256_DIGEST_SIZE
>  #define MAX_DATA_SIZE 4096
>  #define MIN_DATA_SIZE  20
>  #define KEY_ENC32_PAYLOAD_LEN 32
> =20
> -static struct crypto_shash *hash_tfm;
> -
>  enum {
>  	Opt_new, Opt_load, Opt_update, Opt_err
>  };
> =20
>  enum {
> @@ -327,39 +322,18 @@ static struct key *request_user_key(const char *mas=
ter_desc, const u8 **master_k
>  	*master_keylen =3D upayload->datalen;
>  error:
>  	return ukey;
>  }
> =20
> -static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
> -		     const u8 *buf, unsigned int buflen)
> -{
> -	struct crypto_shash *tfm;
> -	int err;
> -
> -	tfm =3D crypto_alloc_shash(hmac_alg, 0, 0);
> -	if (IS_ERR(tfm)) {
> -		pr_err("encrypted_key: can't alloc %s transform: %ld\n",
> -		       hmac_alg, PTR_ERR(tfm));
> -		return PTR_ERR(tfm);
> -	}
> -
> -	err =3D crypto_shash_setkey(tfm, key, keylen);
> -	if (!err)
> -		err =3D crypto_shash_tfm_digest(tfm, buf, buflen, digest);
> -	crypto_free_shash(tfm);
> -	return err;
> -}
> -
>  enum derived_key_type { ENC_KEY, AUTH_KEY };
> =20
>  /* Derive authentication/encryption key from trusted key */
>  static int get_derived_key(u8 *derived_key, enum derived_key_type key_ty=
pe,
>  			   const u8 *master_key, size_t master_keylen)
>  {
>  	u8 *derived_buf;
>  	unsigned int derived_buf_len;
> -	int ret;
> =20
>  	derived_buf_len =3D strlen("AUTH_KEY") + 1 + master_keylen;
>  	if (derived_buf_len < HASH_SIZE)
>  		derived_buf_len =3D HASH_SIZE;
> =20
> @@ -372,14 +346,13 @@ static int get_derived_key(u8 *derived_key, enum de=
rived_key_type key_type,
>  	else
>  		strcpy(derived_buf, "ENC_KEY");
> =20
>  	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
>  	       master_keylen);
> -	ret =3D crypto_shash_tfm_digest(hash_tfm, derived_buf, derived_buf_len,
> -				      derived_key);
> +	sha256(derived_buf, derived_buf_len, derived_key);
>  	kfree_sensitive(derived_buf);
> -	return ret;
> +	return 0;
>  }
> =20
>  static struct skcipher_request *init_skcipher_req(const u8 *key,
>  						  unsigned int key_len)
>  {
> @@ -501,14 +474,14 @@ static int datablob_hmac_append(struct encrypted_ke=
y_payload *epayload,
>  	ret =3D get_derived_key(derived_key, AUTH_KEY, master_key, master_keyle=
n);
>  	if (ret < 0)
>  		goto out;
> =20
>  	digest =3D epayload->format + epayload->datablob_len;
> -	ret =3D calc_hmac(digest, derived_key, sizeof derived_key,
> -			epayload->format, epayload->datablob_len);
> -	if (!ret)
> -		dump_hmac(NULL, digest, HASH_SIZE);
> +	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key),
> +				epayload->format, epayload->datablob_len,
> +				digest);
> +	dump_hmac(NULL, digest, HASH_SIZE);
>  out:
>  	memzero_explicit(derived_key, sizeof(derived_key));
>  	return ret;
>  }
> =20
> @@ -532,13 +505,12 @@ static int datablob_hmac_verify(struct encrypted_ke=
y_payload *epayload,
>  		p =3D epayload->master_desc;
>  		len -=3D strlen(epayload->format) + 1;
>  	} else
>  		p =3D epayload->format;
> =20
> -	ret =3D calc_hmac(digest, derived_key, sizeof derived_key, p, len);
> -	if (ret < 0)
> -		goto out;
> +	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key), p, len,
> +				digest);
>  	ret =3D crypto_memneq(digest, epayload->format + epayload->datablob_len=
,
>  			    sizeof(digest));
>  	if (ret) {
>  		ret =3D -EINVAL;
>  		dump_hmac("datablob",
> @@ -1009,33 +981,18 @@ EXPORT_SYMBOL_GPL(key_type_encrypted);
> =20
>  static int __init init_encrypted(void)
>  {
>  	int ret;
> =20
> -	hash_tfm =3D crypto_alloc_shash(hash_alg, 0, 0);
> -	if (IS_ERR(hash_tfm)) {
> -		pr_err("encrypted_key: can't allocate %s transform: %ld\n",
> -		       hash_alg, PTR_ERR(hash_tfm));
> -		return PTR_ERR(hash_tfm);
> -	}
> -
>  	ret =3D aes_get_sizes();
>  	if (ret < 0)
> -		goto out;
> -	ret =3D register_key_type(&key_type_encrypted);
> -	if (ret < 0)
> -		goto out;
> -	return 0;
> -out:
> -	crypto_free_shash(hash_tfm);
> -	return ret;
> -
> +		return ret;
> +	return register_key_type(&key_type_encrypted);
>  }
> =20
>  static void __exit cleanup_encrypted(void)
>  {
> -	crypto_free_shash(hash_tfm);
>  	unregister_key_type(&key_type_encrypted);
>  }
> =20
>  late_initcall(init_encrypted);
>  module_exit(cleanup_encrypted);
>=20
> base-commit: d6084bb815c453de27af8071a23163a711586a6c


