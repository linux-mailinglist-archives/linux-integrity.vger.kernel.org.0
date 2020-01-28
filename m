Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE314B7F6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2020 15:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbgA1OTM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Jan 2020 09:19:12 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730828AbgA1OTL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:11 -0500
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id B52AA4558B5B07A8D235;
        Tue, 28 Jan 2020 14:19:08 +0000 (GMT)
Received: from fraeml706-chm.china.huawei.com (10.206.15.55) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 14:19:07 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 28 Jan 2020 15:19:07 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 28 Jan 2020 15:19:07 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
Thread-Topic: [PATCH 2/2] ima: support calculating the boot_aggregate based on
 different TPM banks
Thread-Index: AQHV1SsuUuwpXjLewk6D/BEn4qmmH6gAHIeg
Date:   Tue, 28 Jan 2020 14:19:07 +0000
Message-ID: <465015d0c9ca4e278ed32f78eb3eb4a4@huawei.com>
References: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
 <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1580140919-6127-2-git-send-email-zohar@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.220.96.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: linux-integrity-owner@vger.kernel.org [mailto:linux-integrity-
> owner@vger.kernel.org] On Behalf Of Mimi Zohar
> Sent: Monday, January 27, 2020 5:02 PM
> To: linux-integrity@vger.kernel.org
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> <James.Bottomley@HansenPartnership.com>; linux-
> kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> Subject: [PATCH 2/2] ima: support calculating the boot_aggregate based on
> different TPM banks
> 
> Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
> assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
> could support multiple TPM PCR banks, allowing firmware to configure and
> enable different banks.
> 
> Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
> the boot-aggregate, see if the configured IMA_DEFAULT_HASH algorithm is
> an allocated TPM bank, otherwise use the first allocated TPM bank.
> 
> For TPM 1.2 SHA1 is the only supported hash algorithm.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_crypto.c | 37
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 7967a6904851..b1b26d61f174 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -656,8 +656,25 @@ static void __init ima_pcrread(u32 idx, struct
> tpm_digest *d)
>  		pr_err("Error Communicating to TPM chip\n");
>  }
> 
> +/* tpm2_hash_map is the same as defined in tpm2-cmd.c and
> trusted_tpm2.c */
> +static struct tpm2_hash tpm2_hash_map[] = {
> +	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> +	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> +	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
> +	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
> +	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
> +};
> +
>  /*
> - * Calculate the boot aggregate hash
> + * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
> + * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
> + * allowing firmware to configure and enable different banks.
> + *
> + * Instead of hard coding the TPM bank hash algorithm used for calculating
> + * the boot-aggregate, see if the configured IMA_DEFAULT_HASH
> algorithm is
> + * an allocated TPM bank, otherwise use the first allocated TPM bank.
> + *
> + * For TPM 1.2 SHA1 is the only hash algorithm.
>   */
>  static int __init ima_calc_boot_aggregate_tfm(char *digest,
>  					      struct crypto_shash *tfm)
> @@ -673,6 +690,24 @@ static int __init ima_calc_boot_aggregate_tfm(char
> *digest,
>  	if (rc != 0)
>  		return rc;
> 
> +	for (i = 0; i < ARRAY_SIZE(tpm2_hash_map); i++) {
> +		if (tpm2_hash_map[i].crypto_id == ima_hash_algo) {

It is not necessary to define a new map. ima_tpm_chip->allocated_banks
has a crypto_id field.

> +			d.alg_id = tpm2_hash_map[i].tpm_id;
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> +		if (ima_tpm_chip->allocated_banks[i].alg_id == d.alg_id)
> +			break;
> +	}
> +
> +	if (i == ima_tpm_chip->nr_allocated_banks)
> +		d.alg_id = ima_tpm_chip->allocated_banks[0].alg_id;

This code assumes that the algorithm used to calculate boot_aggregate and
the algorithm of the PCR bank can be different. I don't know if it is possible to
communicate to the verifier which bank has been selected (it depends on
the local configuration).

In my opinion the safest approach would be to use the same algorithm for the
digest and the PCR bank. If you agree to this, then the code above must be
moved to ima_calc_boot_aggregate() so that the algorithm of the selected
PCR bank can be passed to ima_alloc_tfm().

The selected PCR bank might be not the first, if the algorithm is unknown to
the crypto subsystem.

> +	pr_info("Calculating the boot-aggregregate, reading TPM PCR

Typo.

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
