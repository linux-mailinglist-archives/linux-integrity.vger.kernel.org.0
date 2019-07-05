Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837876079B
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 16:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfGEOPT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jul 2019 10:15:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33148 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727841AbfGEOPT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jul 2019 10:15:19 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x65EClo5011417;
        Fri, 5 Jul 2019 10:14:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tj5bhf26p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 10:14:01 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x65EDkYp014399;
        Fri, 5 Jul 2019 10:14:00 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tj5bhf262-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 10:14:00 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x65EDt6k024551;
        Fri, 5 Jul 2019 14:13:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 2tdym7mhvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jul 2019 14:13:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x65EDvvm52560328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jul 2019 14:13:57 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1E816A063;
        Fri,  5 Jul 2019 14:13:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0CAB6A04F;
        Fri,  5 Jul 2019 14:13:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jul 2019 14:13:56 +0000 (GMT)
Subject: Re: [PATCH] tpm: fixes uninitialized allocated banks for IBM vtpm
 driver
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Michal Suchanek <msuchanek@suse.de>
References: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <1998ebcf-1521-778f-2c80-55ad2c855023@linux.ibm.com>
Date:   Fri, 5 Jul 2019 10:13:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1562211121-2188-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-05_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907050173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/3/19 11:32 PM, Nayna Jain wrote:
> The nr_allocated_banks and allocated banks are initialized as part of
> tpm_chip_register. Currently, this is done as part of auto startup
> function. However, some drivers, like the ibm vtpm driver, do not run
> auto startup during initialization. This results in uninitialized memory
> issue and causes a kernel panic during boot.
>
> This patch moves the pcr allocation outside the auto startup function
> into tpm_chip_register. This ensures that allocated banks are initialized
> in any case.
>
> Fixes: 879b589210a9 ("tpm: retrieve digest size of unknown algorithms with
> PCR read")
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>   drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
>   drivers/char/tpm/tpm.h      |  1 +
>   drivers/char/tpm/tpm1-cmd.c | 12 ------------
>   drivers/char/tpm/tpm2-cmd.c |  6 +-----
>   4 files changed, 39 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 8804c9e916fd..958508bb8379 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -550,6 +550,39 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>   	return hwrng_register(&chip->hwrng);
>   }
>
> +/*
> + * tpm_pcr_allocation() - initializes the chip allocated banks for PCRs
> + */
> +static int tpm_pcr_allocation(struct tpm_chip *chip)
> +{
> +	int rc = 0;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +		rc = tpm2_get_pcr_allocation(chip);
> +		if (rc)
> +			goto out;
> +	}
> +
> +	/* Initialize TPM 1.2 */
> +	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> +			GFP_KERNEL);
> +	if (!chip->allocated_banks) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +
> +	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> +	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> +	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> +	chip->nr_allocated_banks = 1;
> +
> +	return 0;
> +out:
> +	if (rc < 0)
> +		rc = -ENODEV;


The old code where you lifted this from said:

out:
     if (rc > 0)
         rc = -ENODEV;
     return rc;

It would not overwrite -ENOMEM with -ENODEV but yours does.

I think the correct fix would be to use:

if (rc > 0)

     rc = -ENODEV;





> +	return rc;
> +}
> +
>   /*
>    * tpm_chip_register() - create a character device for the TPM chip
>    * @chip: TPM chip to use.
> @@ -573,6 +606,10 @@ int tpm_chip_register(struct tpm_chip *chip)
>   	if (rc)
>   		return rc;

Above this is tpm_chip_stop(chip) because (afaik) none of the following 
function calls in tpm_chip_register() needed the TPM, but now with 
tpm_pcr_allocation() you will need to send a command to the TPM. So I 
would say you should move the tpm_chip_stop() into the error branch 
visible above and also after the tpm_pcr_allocation().


> +	rc = tpm_pcr_allocation(chip);
tpm_chip_stop(chip);
> +	if (rc)
> +		return rc;
> +
>   	tpm_sysfs_add_device(chip);
>
>   	rc = tpm_bios_log_setup(chip);


   Stefan

