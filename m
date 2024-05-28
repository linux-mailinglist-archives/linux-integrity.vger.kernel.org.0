Return-Path: <linux-integrity+bounces-2689-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A2B8D28A0
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025081C23A1D
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD12F13EFFB;
	Tue, 28 May 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rzdCzKHi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5013D88B;
	Tue, 28 May 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938167; cv=none; b=DIQyDYBbzjI5G8sxpKALW7zPKMOa8HUrXLEEBbQW79vETOoHeavvRIMXbU49xkY8x17uR2Wwba2cd9Skl/cEFtfooLchb6EnDfc81jddEOmoBWaF3e2YaLtBdtupJ+qm1LGP/1wPgRXDryWscWSv7ixASVT5TSiHkAF11ywIi7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938167; c=relaxed/simple;
	bh=NJvN2os/eSTdnSwTQAlcmvzO1kk2mWn/Kuw6bpb2T3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNGvR570pqMIcRTh7953KAa+XNzmxY8Q4st0Q7Rk/twDCkBYR5dMx9yodbufrCydle/6sDthHuJGNcU2nuD3FIHa1G6e5Rqy9KFQiSpEcQ18HCCw/dJpjI+B93Uep9WBF/wwruIvVU7qSRCZbxbTYsc2AFi5OkdXhxQbsCjJcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rzdCzKHi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44SMwJ1v003386;
	Tue, 28 May 2024 23:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=bfHOSuq9lj+bRqOXKhPLNPxdtVsXTjW5tabNx0zKrT0=;
 b=rzdCzKHi2mVDoLtgBG2FbRQRDtptvs/wA5s6aJ0vhAzANa+abCVhEOCvJOWLnl0J+0m9
 1wRyhco3233H2k9WVSFAJ22E7V5HID4ruaUeVpmSb2MoiBRROu66VcAQfzxnQJRSmzJ3
 xTFv3nqvwQzgUNTY7bxkGE5zEVg7XHCmFUoTAO6WqTESlqYhTym4KMHz1EXNWMmge+P+
 ncJzD4kaspsrk+7ZuvedAZWPpOCKX8AIYyf48wBdWn3tcsg+fKDYQS8qd1mjDtudNJGS
 5XSOZ/blJWsQI+h9bO3hsm+rum39EbdoBmcQHcAiFIcLdkgRfiMVpGPdDaWA+zzJOp74 yw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydr2t02wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:15:44 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44SNFhV8027768;
	Tue, 28 May 2024 23:15:43 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydr2t02wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:15:43 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44SKRp4c002364;
	Tue, 28 May 2024 23:15:42 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpb0gna4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 May 2024 23:15:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44SNFdZN30081352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 23:15:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4BAE58067;
	Tue, 28 May 2024 23:15:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44FC15805B;
	Tue, 28 May 2024 23:15:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 May 2024 23:15:38 +0000 (GMT)
Message-ID: <ce1d3188-046d-42c1-b8a7-17325d791ec5@linux.ibm.com>
Date: Tue, 28 May 2024 19:15:37 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] keys: asymmetric: Add tpm2_key_ecdsa
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
        David Howells
 <dhowells@redhat.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ard Biesheuvel <ardb@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-6-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240528210823.28798-6-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KnIsXn6F84IouzTxgsW5fXZ04P0_hbkH
X-Proofpoint-GUID: SdHgyK24q7evp5TVwNqIkF2g9_9iujvs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280172



On 5/28/24 17:08, Jarkko Sakkinen wrote:
> * Asymmetric TPM2 ECDSA key with signing and verification.
> * Enabled with CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE.
> 
> Cc: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v7:
> * Rewrote the signature encoder.
> * Added the missing sha256() call to the signature verifier.
> v6:
> * The very first version.
> * Stefan: any idea why the signature give -EKEYREJECTED?
> ---
>   crypto/asymmetric_keys/Kconfig          |  15 +
>   crypto/asymmetric_keys/Makefile         |   1 +
>   crypto/asymmetric_keys/tpm2_key_ecdsa.c | 462 ++++++++++++++++++++++++
>   crypto/ecdsa.c                          |   1 -
>   drivers/char/tpm/tpm-buf.c              |   2 +-
>   include/linux/tpm.h                     |   7 +
>   6 files changed, 486 insertions(+), 2 deletions(-)
>   create mode 100644 crypto/asymmetric_keys/tpm2_key_ecdsa.c
> 
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 9d88c1190621..c97f11e0340c 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -24,6 +24,21 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>   	  appropriate hash algorithms (such as SHA-1) must be available.
>   	  ENOPKG will be reported if the requisite algorithm is unavailable.
>   
> +config ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE
> +	tristate "Asymmetric TPM2 ECDSA crypto algorithm subtype"
> +	depends on TCG_TPM
> +	select CRYPTO_ECDSA
> +	select CRYPTO_SHA256
> +	select CRYPTO_HASH_INFO
> +	select CRYPTO_TPM2_KEY
> +	select ASN1
> +	select ASN1_ENCODER
> +	help
> +	  This option provides support for asymmetric TPM2 key type handling.
> +	  If signature generation and/or verification are to be used,
> +	  appropriate hash algorithms (such as SHA-256) must be available.
> +	  ENOPKG will be reported if the requisite algorithm is unavailable.
> +
>   config ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE
>   	tristate "Asymmetric TPM2 RSA crypto algorithm subtype"
>   	depends on TCG_TPM
> diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
> index c6da84607824..0843d2268a69 100644
> --- a/crypto/asymmetric_keys/Makefile
> +++ b/crypto/asymmetric_keys/Makefile
> @@ -11,6 +11,7 @@ asymmetric_keys-y := \
>   	signature.o
>   
>   obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
> +obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_ECDSA_SUBTYPE) += tpm2_key_ecdsa.o
>   obj-$(CONFIG_ASYMMETRIC_TPM2_KEY_RSA_SUBTYPE) += tpm2_key_rsa.o
>   
>   #
> diff --git a/crypto/asymmetric_keys/tpm2_key_ecdsa.c b/crypto/asymmetric_keys/tpm2_key_ecdsa.c
> new file mode 100644
> index 000000000000..e2f599a0ffe0
> --- /dev/null
> +++ b/crypto/asymmetric_keys/tpm2_key_ecdsa.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Asymmetric TPM2 ECDSA key subtype.
> + *
> + * See Documentation/crypto/asymmetric-keys.rst
> + */
> +
> +#include <asm/unaligned.h>
> +#include <crypto/internal/ecc.h>
> +#include <crypto/akcipher.h>
> +#include <crypto/sha2.h>
> +#include <crypto/public_key.h>
> +#include <crypto/tpm2_key.h>
> +#include <keys/asymmetric-parser.h>
> +#include <keys/asymmetric-subtype.h>
> +#include <linux/asn1_encoder.h>
> +#include <linux/keyctl.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/tpm.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "tpm2_key_ecdsa: "fmt
> +
> +struct tpm2_ecc_parms {
> +	__be16 symmetric;
> +	__be16 scheme;
> +	__be16 ecc;
> +	__be16 kdf;
> +};
> +
> +static const u8 *tpm2_key_ecdsa_ecc_x(const struct tpm2_key *key)
> +{
> +	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
> +
> +	return &key->data[o + sizeof(struct tpm2_ecc_parms)];
> +}
> +
> +static const u8 *tpm2_key_ecdsa_ecc_y(const struct tpm2_key *key)
> +{
> +	const u8 *x = tpm2_key_ecdsa_ecc_x(key);
> +	u16 x_size = get_unaligned_be16(&x[0]);
> +
> +	/* +2 from the size field: */
> +	return &x[2 + x_size];
> +}
> +
> +static void tpm2_key_ecdsa_describe(const struct key *asymmetric_key,
> +				    struct seq_file *m)
> +{
> +	struct tpm2_key *key = asymmetric_key->payload.data[asym_crypto];
> +
> +	if (!key) {
> +		pr_err("key missing");
> +		return;
> +	}
> +
> +	seq_puts(m, "TPM2/ECDSA");
> +}
> +
> +static void tpm2_key_ecdsa_destroy(void *payload0, void *payload3)
> +{
> +	struct tpm2_key *key = payload0;
> +
> +	if (!key)
> +		return;
> +
> +	kfree(key);
> +}
> +
> +static const char *tpm2_ecc_name(u16 ecc)
> +{
> +	const char *name;
> +
> +	switch (ecc) {
> +	case TPM2_ECC_NIST_P521:
> +		name = "ecdsa-nist-p521";
> +		break;
> +	case TPM2_ECC_NIST_P384:
> +		name = "ecdsa-nist-p384";
> +		break;
> +	default:
> +		name = "ecdsa-nist-p256";
> +		break;
> +	}
> +
> +	return name;
> +}
> +
> +static int tpm2_key_ecdsa_query(const struct kernel_pkey_params *params,
> +				struct kernel_pkey_query *info)
> +{
> +	const struct tpm2_key *key = params->key->payload.data[asym_crypto];
> +	const off_t o = key->priv_len + 2 + sizeof(*key->desc);
> +	const struct tpm2_ecc_parms *p =
> +		(const struct tpm2_ecc_parms *)&key->data[o];
> +	u16 ecc = be16_to_cpu(p->ecc);
> +	const char *ecc_name = tpm2_ecc_name(ecc);
> +	const u8 *x = tpm2_key_ecdsa_ecc_x(key);
> +	u16 x_size = get_unaligned_be16(&x[0]);
> +	struct crypto_akcipher *tfm;
> +	char data[256];

Due to NIST p521   1 + 2 * 66 = 133 should be enough.

If x_size exceeeds 66 then something is wrong.

> +	u8 *ptr;
> +	int ret;
> +
> +	memset(data, 0, sizeof(data));
> +
> +	tfm = crypto_alloc_akcipher(ecc_name, 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	/* Probe for ecdsa_set_pub_key(): */
> +	ptr = &data[0];
> +	*ptr++ = 0x04; /* uncompressed */
> +	memcpy(&ptr[0], &x[2], x_size);
> +	memcpy(&ptr[x_size], &x[2 + x_size + 2], x_size);
> +	ret = crypto_akcipher_set_pub_key(tfm, data, 2 * x_size + 1);
> +	crypto_free_akcipher(tfm);
> +	if (ret < 0)
> +		return ret;
> +
> +	info->max_sig_size = 256;
> +	info->key_size = 256;
> +	info->max_data_size = 256;
> +	info->supported_ops = KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS_VERIFY;
> +	return ret;
> +}
> +
> +static int tpm2_key_ecdsa_sign(struct tpm_chip *chip, struct tpm2_key *key,
> +			       struct kernel_pkey_params *params,
> +			       const void *in, void *out)
> +{
> +	u8 r[SHA256_DIGEST_SIZE], s[SHA256_DIGEST_SIZE];
> +	u32 in_len = params->in_len;
> +	bool r_0, s_0;
> +	struct tpm_header *head;
> +	struct tpm_buf buf;
> +	u32 key_handle;
> +	u8 *ptr = out;
> +	off_t offset;
> +	int ret;
> +
> +
> +	/* Require explicit hash algorithm: */
> +	if (!params->hash_algo)
> +		return -EINVAL;
> +
> +	/* Currently only support SHA256: */
> +	if (!!strcmp(params->hash_algo, "sha256"))
> +		return -EINVAL;
> +
> +	ret = tpm_try_get_ops(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = tpm2_start_auth_session(chip);
> +	if (ret)
> +		goto err_ops;
> +
> +	ret = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
> +	if (ret < 0) {
> +		tpm2_end_auth_session(chip);
> +		goto err_ops;
> +	}
> +
> +	tpm_buf_append_name(chip, &buf, key->parent, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_CONTINUE_SESSION |
> +				    TPM2_SA_ENCRYPT, NULL, 0);
> +	tpm_buf_append(&buf, &key->data[0], key->priv_len + key->pub_len);
> +	if (buf.flags & TPM_BUF_OVERFLOW) {
> +		tpm2_end_auth_session(chip);
> +		ret = -E2BIG;
> +		goto err_buf;
> +	}
> +	tpm_buf_fill_hmac_session(chip, &buf);
> +	ret = tpm_transmit_cmd(chip, &buf, 4, "ECDSA loading");
> +	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
> +	if (ret) {
> +		tpm2_end_auth_session(chip);
> +		ret = -EIO;
> +		goto err_buf;
> +	}
> +
> +	key_handle = be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE]);
> +
> +	tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_SIGN);
> +	tpm_buf_append_name(chip, &buf, key_handle, NULL);
> +	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT, NULL, 0);
> +
> +	sha256(in, in_len, r);
> +	tpm_buf_append_u16(&buf, SHA256_DIGEST_SIZE);
> +	tpm_buf_append(&buf, r, SHA256_DIGEST_SIZE);
> +	tpm_buf_append_u16(&buf, TPM_ALG_ECDSA);
> +	tpm_buf_append_u16(&buf, TPM_ALG_SHA256);
> +
> +	/* 10.7.2 A NULL Ticket */
> +	tpm_buf_append_u16(&buf, TPM2_ST_HASHCHECK);
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +	tpm_buf_append_u16(&buf, 0);
> +
> +	tpm_buf_fill_hmac_session(chip, &buf);
> +	ret = tpm_transmit_cmd(chip, &buf, 4, "ECDSA signing");
> +	ret = tpm_buf_check_hmac_response(chip, &buf, ret);
> +	if (ret) {
> +		tpm2_end_auth_session(chip);
> +		ret = -EIO;
> +		goto err_key_handle;
> +	}
> +
> +	/* Move to parameters: */
> +	head = (struct tpm_header *)buf.data;
> +	offset = sizeof(*head);
> +	if (be16_to_cpu(head->tag) == TPM2_ST_SESSIONS)
> +		offset += 4;
> +
> +	ret = -EIO;
> +
> +	/* Copy R: */
> +	if (tpm_buf_read_u16(&buf, &offset) != TPM_ALG_ECDSA ||
> +	    tpm_buf_read_u16(&buf, &offset) != TPM_ALG_SHA256 ||
> +	    tpm_buf_read_u16(&buf, &offset) != SHA256_DIGEST_SIZE) {
> +		pr_warn("offset=%u\n", offset);
> +		goto err_key_handle;
> +	}
> +
> +	tpm_buf_read(&buf, &offset, SHA256_DIGEST_SIZE, r);
> +	r_0 = (r[0] & 0x80) != 0;
> +	pr_info("r_0=%d\n", r_0);
> +
> +	/* Copy S: */
> +	if (tpm_buf_read_u16(&buf, &offset) != SHA256_DIGEST_SIZE) {
> +		pr_warn("offset=%u\n", offset);
> +		goto err_key_handle;
> +	}
> +
> +	tpm_buf_read(&buf, &offset, SHA256_DIGEST_SIZE, s);
> +	s_0 = (r[0] & 0x80) != 0;
> +	pr_info("s_0=%d\n", r_0);
> +
> +	/* Encode the ASN.1 signature: */
> +#define TPM2_KEY_ECDSA_SIG_SIZE		(2 + 2 * (2 + SHA256_DIGEST_SIZE) + r_0 + s_0)
> +	pr_info("sig_size=%d\n", TPM2_KEY_ECDSA_SIG_SIZE);
> +	ptr[0] = 0x30; /* SEQUENCE */
> +	ptr[1] = TPM2_KEY_ECDSA_SIG_SIZE - 2;
> +#define TPM2_KEY_ECDSA_SIG_R_TAG	2
> +#define TPM2_KEY_ECDSA_SIG_R_SIZE	3
> +#define TPM2_KEY_ECDSA_SIG_R_BODY	4
> +	ptr[TPM2_KEY_ECDSA_SIG_R_TAG] = 0x02; /* INTEGER */
> +	ptr[TPM2_KEY_ECDSA_SIG_R_SIZE] = SHA256_DIGEST_SIZE + r_0;

The size of the signature has nothing to do with the size of the hash. 
SHA256_DIGEST_SIZE (32) happens to match the number of bytes of a 
coordinate of prime256v1 / NIST p256 but should fail when you use 
secp521r1 / NIST p521 since then r or s may then be 66 or 67 bytes (if 
most sign. bit is set) long.

> +	ptr[TPM2_KEY_ECDSA_SIG_R_BODY] = 0x00; /* maybe dummy write */
> +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_R_BODY + r_0], r, SHA256_DIGEST_SIZE);
> +#define TPM2_KEY_ECDSA_SIG_S_TAG	(4 + r_0 + SHA256_DIGEST_SIZE)
> +#define TPM2_KEY_ECDSA_SIG_S_SIZE	(5 + r_0 + SHA256_DIGEST_SIZE)
> +#define TPM2_KEY_ECDSA_SIG_S_BODY	(6 + r_0 + SHA256_DIGEST_SIZE)
> +	ptr[TPM2_KEY_ECDSA_SIG_S_TAG] = 0x02; /* INTEGER */
> +	ptr[TPM2_KEY_ECDSA_SIG_S_SIZE] = SHA256_DIGEST_SIZE + s_0;
> +	ptr[TPM2_KEY_ECDSA_SIG_S_BODY] = 0x00; /* maybe dummy write */
> +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_S_BODY + s_0], s, SHA256_DIGEST_SIZE);
> +	ret = TPM2_KEY_ECDSA_SIG_SIZE;
> +
> +err_key_handle:
> +	tpm2_flush_context(chip, key_handle);
> +
> +err_buf:
> +	tpm_buf_destroy(&buf);
> +
> +err_ops:
> +	tpm_put_ops(chip);
> +	return ret;
> +}
> +

