Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7381F151B62
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2020 14:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBDNhf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Feb 2020 08:37:35 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2363 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727174AbgBDNhe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Feb 2020 08:37:34 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id AD56E374ACE0C262B18F;
        Tue,  4 Feb 2020 13:37:32 +0000 (GMT)
Received: from fraeml702-chm.china.huawei.com (10.206.15.51) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 4 Feb 2020 13:37:32 +0000
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Tue, 4 Feb 2020 14:37:31 +0100
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.1713.004;
 Tue, 4 Feb 2020 14:37:31 +0100
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>
Subject: RE: [PATCH v3 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
Thread-Topic: [PATCH v3 2/2] ima: support calculating the boot_aggregate based
 on different TPM banks
Thread-Index: AQHV14mgGDRCXCHq1UG77eo7NcEnk6gLEMcg
Date:   Tue, 4 Feb 2020 13:37:31 +0000
Message-ID: <01986ba728014571a3907fef9c69ff2c@huawei.com>
References: <1580401363-5593-1-git-send-email-zohar@linux.ibm.com>
 <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
In-Reply-To: <1580401363-5593-2-git-send-email-zohar@linux.ibm.com>
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
> Sent: Thursday, January 30, 2020 5:23 PM
> To: linux-integrity@vger.kernel.org
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>; James Bottomley
> <James.Bottomley@HansenPartnership.com>; linux-
> kernel@vger.kernel.org; Mimi Zohar <zohar@linux.ibm.com>
> Subject: [PATCH v3 2/2] ima: support calculating the boot_aggregate based
> on different TPM banks
> 
> Calculating the boot_aggregate attempts to read the TPM SHA1 bank,
> assuming it is always enabled.  With TPM 2.0 hash agility, TPM chips
> could support multiple TPM PCR banks, allowing firmware to configure and
> enable different banks.
> 
> Instead of hard coding the TPM 2.0 bank hash algorithm used for calculating
> the boot-aggregate, use the same hash algorithm for reading the TPM PCRs
> as
> for calculating the boot aggregate digest.  Preference is given to the
> configured IMA default hash algorithm.
> 
> For TPM 1.2 SHA1 is the only supported hash algorithm.
> 
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_crypto.c | 45
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_crypto.c
> b/security/integrity/ima/ima_crypto.c
> index 7967a6904851..a020aaefdea8 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -656,13 +656,34 @@ static void __init ima_pcrread(u32 idx, struct
> tpm_digest *d)
>  		pr_err("Error Communicating to TPM chip\n");
>  }
> 
> +static enum hash_algo get_hash_algo(const char *algname)
> +{
> +	int i;
> +
> +	for (i = 0; i < HASH_ALGO__LAST; i++) {
> +		if (strcmp(algname, hash_algo_name[i]) == 0)
> +			break;
> +	}
> +
> +	return i;
> +}
> +
>  /*
> - * Calculate the boot aggregate hash
> + * The boot_aggregate is a cumulative hash over TPM registers 0 - 7.  With
> + * TPM 1.2 the boot_aggregate was based on reading the SHA1 PCRs, but
> with
> + * TPM 2.0 hash agility, TPM chips could support multiple TPM PCR banks,
> + * allowing firmware to configure and enable different banks.
> + *
> + * Knowing which TPM bank is read to calculate the boot_aggregate digest
> + * needs to be conveyed to a verifier.  For this reason, use the same
> + * hash algorithm for reading the TPM PCRs as for calculating the boot
> + * aggregate digest as stored in the measurement list.
>   */
>  static int __init ima_calc_boot_aggregate_tfm(char *digest,
>  					      struct crypto_shash *tfm)
>  {
>  	struct tpm_digest d = { .alg_id = TPM_ALG_SHA1, .digest = {0} };
> +	enum hash_algo crypto_id;
>  	int rc;
>  	u32 i;
>  	SHASH_DESC_ON_STACK(shash, tfm);
> @@ -673,6 +694,28 @@ static int __init ima_calc_boot_aggregate_tfm(char
> *digest,
>  	if (rc != 0)
>  		return rc;
> 
> +	crypto_id = get_hash_algo(crypto_shash_alg_name(tfm));
> +	if (crypto_id == HASH_ALGO__LAST) {
> +		pr_devel("unknown hash algorithm (%s), failing to read
> PCRs.\n",
> +			 crypto_shash_alg_name(tfm));
> +		return 0;
> +	}
> +
> +	for (i = 0; i < ima_tpm_chip->nr_allocated_banks; i++) {
> +		if (ima_tpm_chip->allocated_banks[i].crypto_id ==
> crypto_id) {
> +			d.alg_id = ima_tpm_chip->allocated_banks[i].alg_id;
> +			break;
> +		}
> +	}
> +	if (i == ima_tpm_chip->nr_allocated_banks) {
> +		pr_devel("TPM %s bank not allocated, failing to read
> PCRs.\n",
> +			 crypto_shash_alg_name(tfm));
> +		return 0;
> +	}
> +
> +	pr_devel("calculating the boot-aggregregate based on TPM
> bank: %04x\n",
> +		  d.alg_id);
> +
>  	/* cumulative sha1 over tpm registers 0-7 */
>  	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
>  		ima_pcrread(i, &d);

The third argument of crypto_shash_update() should be
crypto_shash_digestsize(tfm).

Roberto

HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Li Peng, Li Jian, Shi Yanli
