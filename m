Return-Path: <linux-integrity+bounces-2720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DD8D5702
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 02:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A741F24D03
	for <lists+linux-integrity@lfdr.de>; Fri, 31 May 2024 00:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2604405;
	Fri, 31 May 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JuZAqMGj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D126134AB;
	Fri, 31 May 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717115764; cv=none; b=Lcoq0kUoxa03vTA+GB+nPmc7IAKepTO7sWqO5qNnb8pQTqjZjVRvA8Jijot50wL6PNsERpefCXvWlw962/3UlJwoqLwmJYqbek3KOUE7+rDXBli3FExRCSp1R+ZMjo7SQO5RHaqr7gIgUMDsCO25jLd1o0YJGi9VRr3Ux6/RSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717115764; c=relaxed/simple;
	bh=9jMbF4EvO2HoOup8CkZuyhS+D9sSQeQlp+iSl94nf50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdlONU7s6OJLGzwZeeuBER95vq1sbh7WUjuJPvbvvKXxYMLryzkO0DqJhTodX2/pTCDVaZdYL47cdUDrriLOGd0iVacD/yp6PUGPA41WMrS/kETfdPegVl9ZJBxXnBG5fAfB6lTBVNaqGgl67luQ7XQtfeg99bz4u3Gapc08Ahw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JuZAqMGj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UNkPol006819;
	Fri, 31 May 2024 00:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Q6pjVGzrPHHTVu9KRNWWYX/lLVJpjXE3+mIUz4VfgLA=;
 b=JuZAqMGjwsBvODRrYlGUN2JTqcuhJHSn2arGgOnLOhdu6kkl6Pzzg2bbSreFL3MACL2+
 9xl1N6/WfD3gHvZNsDajpJy34CQ7TUE0PVadEqdbWDrHWU/ljHdboQLsUd8rUhmloUaw
 ek2yBT4EaaIWDk+HfBEsRjhh9Sa4qNLG3BKRpVDfNFLBOcVSs1EEtz07uIqALreXjGKM
 132YPajVwyX0Nr+XADjZBlWSjiLmmDPojXGq4I8QLKvkNrLuG4njzjqTB4UGp2qFDmy+
 qTs4V+VPYML1L+7QiTINfVxKVDcOSt4gSBuiwzXVdl+d4oedh28Bv1sAQ3lcr//x/+6P SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yf30g860q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 00:35:29 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V0ZTwV016185;
	Fri, 31 May 2024 00:35:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yf30g860j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 00:35:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44ULjBB7029537;
	Fri, 31 May 2024 00:35:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpayvyyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 00:35:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44V0ZP8B35521062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 00:35:28 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCAD458058;
	Fri, 31 May 2024 00:35:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A768558061;
	Fri, 31 May 2024 00:35:23 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 May 2024 00:35:23 +0000 (GMT)
Message-ID: <97dd7485-51bf-4e47-83ab-957710fc2182@linux.ibm.com>
Date: Thu, 30 May 2024 20:35:22 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] crypto: tpm2_key: Introduce a TPM2 key type
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-4-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240528210823.28798-4-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2oUTOSqJRONevSoQUit8x_Yyj3YB--14
X-Proofpoint-GUID: Y7GxRg9p7jkfs27DlUvao_oMuYInduYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310002



On 5/28/24 17:08, Jarkko Sakkinen wrote:
> TPM2 ASN.1 format is required for trusted keys and asymmetric keys. Move it
> to crypto in order to make it available for both. Implement validation with
> coverage of all TPMT_PUBLIC shared fields. Key type specific fields must be
> covered by the different subsystems using this.
> 
> A Kconfig option CRYPTO_TPM2_KEY can be used to select the feature, which
> depends only crypto subsystem itself and ASN.1 parser.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v6:
> * Relocate to crypto. Validate the shared part and provide
>    accessor functions. Use a fixed buffer size.
> v2:
> * Do not allocate blob twice. Use the one inside struct tpm2_key.
> ---
>   crypto/Kconfig                            |   7 ++
>   crypto/Makefile                           |   6 +
>   crypto/tpm2_key.asn1                      |  11 ++
>   crypto/tpm2_key.c                         | 134 ++++++++++++++++++++
>   include/crypto/tpm2_key.h                 |  46 +++++++
>   security/keys/trusted-keys/Kconfig        |   2 +-
>   security/keys/trusted-keys/Makefile       |   2 -
>   security/keys/trusted-keys/tpm2key.asn1   |  11 --
>   security/keys/trusted-keys/trusted_tpm2.c | 141 +++++-----------------
>   9 files changed, 235 insertions(+), 125 deletions(-)
>   create mode 100644 crypto/tpm2_key.asn1
>   create mode 100644 crypto/tpm2_key.c
>   create mode 100644 include/crypto/tpm2_key.h
>   delete mode 100644 security/keys/trusted-keys/tpm2key.asn1
> 
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 5688d42a59c2..c8989bc71f57 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -5,6 +5,13 @@
>   config XOR_BLOCKS
>   	tristate
>   
> +config CRYPTO_TPM2_KEY
> +	bool
> +	depends on CRYPTO
> +	select ASN1
> +	select OID_REGISTRY
> +	default n
> +
>   #
>   # async_tx api: hardware offloaded memory transfer/transform support
>   #
> diff --git a/crypto/Makefile b/crypto/Makefile
> index edbbaa3ffef5..d932fdb72319 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -216,3 +216,9 @@ obj-$(CONFIG_CRYPTO_SIMD) += crypto_simd.o
>   # Key derivation function
>   #
>   obj-$(CONFIG_CRYPTO_KDF800108_CTR) += kdf_sp800108.o
> +
> +ifdef CONFIG_CRYPTO_TPM2_KEY
> +$(obj)/tpm2_key.asn1.o: $(obj)/tpm2_key.asn1.h $(obj)/tpm2_key.asn1.c
> +$(obj)/tpm2_key.o: $(obj)/tpm2_key.asn1.h
> +obj-y += tpm2_key.o tpm2_key.asn1.o
> +endif
> diff --git a/crypto/tpm2_key.asn1 b/crypto/tpm2_key.asn1
> new file mode 100644
> index 000000000000..b235d02ab78e
> --- /dev/null
> +++ b/crypto/tpm2_key.asn1
> @@ -0,0 +1,11 @@
> +---
> +--- ASN.1 for TPM 2.0 keys
> +---
> +
> +TPMKey ::= SEQUENCE {
> +	type		OBJECT IDENTIFIER ({tpm2_key_get_type}),
> +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> +	parent		INTEGER ({tpm2_key_get_parent}),
> +	pubkey		OCTET STRING ({tpm2_get_public}),
> +	privkey		OCTET STRING ({tpm2_get_private})
> +	}
> diff --git a/crypto/tpm2_key.c b/crypto/tpm2_key.c
> new file mode 100644
> index 000000000000..78f55478d046
> --- /dev/null
> +++ b/crypto/tpm2_key.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <crypto/tpm2_key.h>
> +#include <linux/oid_registry.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <asm/unaligned.h>
> +#include "tpm2_key.asn1.h"
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "tpm2_key: "fmt
> +
> +struct tpm2_key_decoder_context {
> +	u32 parent;
> +	const u8 *pub;
> +	u32 pub_len;
> +	const u8 *priv;
> +	u32 priv_len;
> +	enum OID oid;
> +};
> +
> +int tpm2_key_get_parent(void *context, size_t hdrlen,
> +			unsigned char tag,
> +			const void *value, size_t vlen)
> +{
> +	struct tpm2_key_decoder_context *decoder = context;
> +	const u8 *v = value;
> +	int i;
> +
> +	decoder->parent = 0;
> +	for (i = 0; i < vlen; i++) {
> +		decoder->parent <<= 8;
> +		decoder->parent |= v[i];
> +	}
> +
> +	return 0;
> +}
> +
> +int tpm2_key_get_type(void *context, size_t hdrlen,
> +		      unsigned char tag,
> +		      const void *value, size_t vlen)
> +{
> +	struct tpm2_key_decoder_context *decoder = context;
> +
> +	decoder->oid = look_up_OID(value, vlen);
> +	return 0;
> +}
> +
> +static inline bool tpm2_key_is_valid(const void *value, size_t vlen)
> +{
> +	if (vlen < 2 || vlen > TPM2_KEY_BYTES_MAX)
> +		return false;
> +
> +	if (get_unaligned_be16(value) != vlen - 2)
> +		return false;
> +
> +	return true;
> +}
> +
> +int tpm2_get_public(void *context, size_t hdrlen, unsigned char tag,
> +		    const void *value, size_t vlen)
> +{
> +	struct tpm2_key_decoder_context *decoder = context;
> +
> +	if (!tpm2_key_is_valid(value, vlen))
> +		return -EBADMSG;
> +
> +	if (sizeof(struct tpm2_key_desc) > vlen - 2)
> +		return -EBADMSG;
> +
> +	decoder->pub = value;
> +	decoder->pub_len = vlen;
> +	return 0;
> +}
> +
> +int tpm2_get_private(void *context, size_t hdrlen, unsigned char tag,
> +		     const void *value, size_t vlen)
> +{
> +	struct tpm2_key_decoder_context *decoder = context;
> +
> +	if (!tpm2_key_is_valid(value, vlen))
> +		return -EBADMSG;
> +
> +	decoder->priv = value;
> +	decoder->priv_len = vlen;
> +	return 0;
> +}
> +
> +/**
> + * tpm_key_decode() - Decode TPM2 ASN.1 key
> + * @src:	ASN.1 source.
> + * @src_len:	ASN.1 source length.
> + *
> + * Decodes the TPM2 ASN.1 key and validates that the public key data has all
> + * the shared fields of TPMT_PUBLIC. This is full coverage of the memory that
> + * can be validated before doing any key type specific validation.

I am not sure what the last sentence means.

> + *
> + * Return:
> + * - TPM2 ASN.1 key on success.
> + * - -EBADMSG when decoding fails.
> + * - -ENOMEM when OOM while allocating struct tpm2_key.
> + */
> +struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len)
> +{
> +	struct tpm2_key_decoder_context decoder;
> +	struct tpm2_key *key;
> +	u8 *data;
> +	int ret;
> +
> +	memset(&decoder, 0, sizeof(decoder));
> +	ret = asn1_ber_decoder(&tpm2_key_decoder, &decoder, src, src_len);
> +	if (ret < 0) {
> +		if (ret != -EBADMSG)
> +			pr_info("Decoder error %d\n", ret);
> +
> +		return ERR_PTR(-EBADMSG);
> +	}
> +
> +	key = kzalloc(sizeof(*key), GFP_KERNEL);
> +	if (!key)
> +		return ERR_PTR(-ENOMEM);
> +
> +	data = &key->data[0];
> +	memcpy(&data[0], decoder.priv, decoder.priv_len);
> +	memcpy(&data[decoder.priv_len], decoder.pub, decoder.pub_len);
> +
> +	key->oid = decoder.oid;
> +	key->priv_len = decoder.priv_len;
> +	key->pub_len = decoder.pub_len;
> +	key->parent = decoder.parent;
> +	key->desc = (struct tpm2_key_desc *)&data[decoder.priv_len + 2];
> +	return key;
> +}
> +EXPORT_SYMBOL_GPL(tpm2_key_decode);
> diff --git a/include/crypto/tpm2_key.h b/include/crypto/tpm2_key.h
> new file mode 100644
> index 000000000000..74debaf707bf
> --- /dev/null
> +++ b/include/crypto/tpm2_key.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef __LINUX_TPM2_KEY_H__
> +#define __LINUX_TPM2_KEY_H__
> +
> +#include <linux/oid_registry.h>
> +#include <linux/slab.h>
> +
> +#define TPM2_KEY_BYTES_MAX 1024
> +
> +/*  TPM2 Structures 12.2.4: TPMT_PUBLIC */
> +struct tpm2_key_desc {
> +	__be16 type;
> +	__be16 name_alg;
> +	__be32 object_attributes;
> +	__be16 policy_size;
> +} __packed;
> +
> +/* Decoded TPM2 ASN.1 key. */
> +struct tpm2_key {
> +	u8 data[2 * TPM2_KEY_BYTES_MAX];
> +	struct tpm2_key_desc *desc;
> +	u16 priv_len;
> +	u16 pub_len;
> +	u32 parent;
> +	enum OID oid;
> +	char oid_str[64];
> +};
> +
> +struct tpm2_key *tpm2_key_decode(const u8 *src, u32 src_len);
> +
> +static inline const void *tpm2_key_data(const struct tpm2_key *key)
> +{
> +	return &key->data[0];
> +}
> +
> +static inline u16 tpm2_key_type(const struct tpm2_key *key)
> +{
> +	return be16_to_cpu(key->desc->type);
> +}
> +
> +static inline int tpm2_key_policy_size(const struct tpm2_key *key)
> +{
> +	return be16_to_cpu(key->desc->policy_size);
> +}
> +
> +#endif /* __LINUX_TPM2_KEY_H__ */
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
> index 1fb8aa001995..00d9489384ac 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -9,9 +9,9 @@ config TRUSTED_KEYS_TPM
>   	select CRYPTO_HMAC
>   	select CRYPTO_SHA1
>   	select CRYPTO_HASH_INFO
> +	select CRYPTO_TPM2_KEY
>   	select ASN1_ENCODER
>   	select OID_REGISTRY
> -	select ASN1
>   	select HAVE_TRUSTED_KEYS
>   	help
>   	  Enable use of the Trusted Platform Module (TPM) as trusted key
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> index f0f3b27f688b..2674d5c10fc9 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -7,9 +7,7 @@ obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
>   trusted-y += trusted_core.o
>   trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
>   
> -$(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
>   trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
> -trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
>   
>   trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
>   
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trusted-keys/tpm2key.asn1
> deleted file mode 100644
> index f57f869ad600..000000000000
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ /dev/null
> @@ -1,11 +0,0 @@
> ----
> ---- ASN.1 for TPM 2.0 keys
> ----
> -
> -TPMKey ::= SEQUENCE {
> -	type		OBJECT IDENTIFIER ({tpm2_key_type}),
> -	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> -	parent		INTEGER ({tpm2_key_parent}),
> -	pubkey		OCTET STRING ({tpm2_key_pub}),
> -	privkey		OCTET STRING ({tpm2_key_priv})
> -	}
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 06c8fa7b21ae..b9e505e99e8c 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -13,11 +13,10 @@
>   
>   #include <keys/trusted-type.h>
>   #include <keys/trusted_tpm.h>
> +#include <crypto/tpm2_key.h>
>   
>   #include <asm/unaligned.h>
>   
> -#include "tpm2key.asn1.h"
> -
>   static struct tpm2_hash tpm2_hash_map[] = {
>   	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>   	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> @@ -98,106 +97,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>   	return ret;
>   }
>   
> -struct tpm2_key_context {
> -	u32 parent;
> -	const u8 *pub;
> -	u32 pub_len;
> -	const u8 *priv;
> -	u32 priv_len;
> -};
> -
> -static int tpm2_key_decode(struct trusted_key_payload *payload,
> -			   struct trusted_key_options *options,
> -			   u8 **buf)
> -{
> -	int ret;
> -	struct tpm2_key_context ctx;
> -	u8 *blob;
> -
> -	memset(&ctx, 0, sizeof(ctx));
> -
> -	ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
> -			       payload->blob_len);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> -		return -E2BIG;
> -
> -	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> -	if (!blob)
> -		return -ENOMEM;
> -
> -	*buf = blob;
> -	options->keyhandle = ctx.parent;
> -
> -	memcpy(blob, ctx.priv, ctx.priv_len);
> -	blob += ctx.priv_len;
> -
> -	memcpy(blob, ctx.pub, ctx.pub_len);
> -
> -	return 0;
> -}
> -
> -int tpm2_key_parent(void *context, size_t hdrlen,
> -		  unsigned char tag,
> -		  const void *value, size_t vlen)
> -{
> -	struct tpm2_key_context *ctx = context;
> -	const u8 *v = value;
> -	int i;
> -
> -	ctx->parent = 0;
> -	for (i = 0; i < vlen; i++) {
> -		ctx->parent <<= 8;
> -		ctx->parent |= v[i];
> -	}
> -
> -	return 0;
> -}
> -
> -int tpm2_key_type(void *context, size_t hdrlen,
> -		unsigned char tag,
> -		const void *value, size_t vlen)
> -{
> -	enum OID oid = look_up_OID(value, vlen);
> -
> -	if (oid != OID_TPMSealedData) {
> -		char buffer[50];
> -
> -		sprint_oid(value, vlen, buffer, sizeof(buffer));
> -		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
> -			 buffer);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
> -int tpm2_key_pub(void *context, size_t hdrlen,
> -	       unsigned char tag,
> -	       const void *value, size_t vlen)
> -{
> -	struct tpm2_key_context *ctx = context;
> -
> -	ctx->pub = value;
> -	ctx->pub_len = vlen;
> -
> -	return 0;
> -}
> -
> -int tpm2_key_priv(void *context, size_t hdrlen,
> -		unsigned char tag,
> -		const void *value, size_t vlen)
> -{
> -	struct tpm2_key_context *ctx = context;
> -
> -	ctx->priv = value;
> -	ctx->priv_len = vlen;
> -
> -	return 0;
> -}
> -
>   /**
>    * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
>    *
> @@ -387,22 +286,43 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>   			 struct trusted_key_options *options,
>   			 u32 *blob_handle)
>   {
> -	struct tpm_buf buf;
>   	unsigned int private_len;
>   	unsigned int public_len;
>   	unsigned int blob_len;
> -	u8 *blob, *pub;
> -	int rc;
> +	struct tpm2_key *key;
> +	const u8 *blob, *pub;
> +	struct tpm_buf buf;
>   	u32 attrs;
> +	int rc;
>   
> -	rc = tpm2_key_decode(payload, options, &blob);
> -	if (rc) {
> -		/* old form */
> +	key = tpm2_key_decode(payload->blob, payload->blob_len);
> +	if (IS_ERR(key)) {
> +		/* Get the error code and reset the pointer to the key: */
> +		rc = PTR_ERR(key);
> +		key = NULL;
> +
> +		if (rc == -ENOMEM)
> +			return -ENOMEM;
> +
> +		/* A sanity check, as only -EBADMSG or -ENOMEM are expected: */
> +		if (rc != -EBADMSG)
> +			pr_err("tpm2_key_decode(): spurious error code %d\n", rc);

tpm2_key_decode seems simple enough that it only returns key, -ENOMEM or 
EBADMSG.

> +
> +		/* Fallback to the legacy format: */
>   		blob = payload->blob;
>   		payload->old_format = 1;
> +	} else {
> +		blob = tpm2_key_data(key);
> +		if (key->oid != OID_TPMSealedData) {
> +			kfree(key);
> +			return -EBADMSG;
> +		}
>   	}
>   
> -	/* new format carries keyhandle but old format doesn't */
> +	/*
> +	 * Must be non-zero here, either extracted from the ASN.1 for the new
> +	 * format or specified on the command line for the old.

sentence seems incomplete: ... for the old one.  OR  ... for the old format.

> +	 */
>   	if (!options->keyhandle)
>   		return -EINVAL;
>   
> @@ -464,8 +384,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>   			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
>   
>   out:
> -	if (blob != payload->blob)
> -		kfree(blob);
> +	kfree(key);
>   	tpm_buf_destroy(&buf);
>   
>   	if (rc > 0)

