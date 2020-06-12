Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3EA1F715E
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Jun 2020 02:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLAaH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jun 2020 20:30:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgFLAaH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 20:30:07 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BMWr86077654;
        Thu, 11 Jun 2020 20:30:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ktm4eyv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 20:30:01 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05C0TDLd069624;
        Thu, 11 Jun 2020 20:30:01 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ktm4eyuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 20:30:01 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05C0FDhA019144;
        Fri, 12 Jun 2020 00:29:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s82et8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 00:29:58 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05C0Tugi63832342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 00:29:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C362E11C04A;
        Fri, 12 Jun 2020 00:29:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A50F911C04C;
        Fri, 12 Jun 2020 00:29:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.183.79])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jun 2020 00:29:55 +0000 (GMT)
Message-ID: <1591921795.11061.12.camel@linux.ibm.com>
Subject: Re: [PATCH] extend IMA boot_aggregate with kernel measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     jejb@linux.ibm.com, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 20:29:55 -0400
In-Reply-To: <20200611195422.2117-1-maurizio.drocco@ibm.com>
References: <20200611195422.2117-1-maurizio.drocco@ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 cotscore=-2147483648
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maurizo,

On Thu, 2020-06-11 at 15:54 -0400, Maurizio Drocco wrote:
> IMA is not considering TPM registers 8-9 when calculating the boot
> aggregate. When registers 8-9 are used to store measurements of the
> kernel and its command line (e.g., grub2 bootloader with tpm module
> enabled), IMA should include them in the boot aggregate.
> 
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>

Looks good.  Just a minor comment below.  Could you be a bit more
specific as to what is being measured into which PCR.  Perhaps include
a reference to some doc or spec.

In order to test, ima-evm-utils needs to be updated as well.  Could
you post the corresponding evmctl change?  Please post the patch
against the ima-evm-utils next-testing branch.

> ---
>  security/integrity/ima/ima.h        |  2 +-
>  security/integrity/ima/ima_crypto.c | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..9d94080bdad8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -30,7 +30,7 @@
>  
>  enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>  		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
> -enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8 };
> +enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
>  
>  /* digest size for IMA, fits SHA1 or MD5 */
>  #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
> index 220b14920c37..6f0137bdaf61 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -809,7 +809,7 @@ static void ima_pcrread(u32 idx, struct tpm_digest *d)
>  static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
>  				       struct crypto_shash *tfm)
>  {
> -	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} };
> +	struct tpm_digest d = { .alg_id = alg_id, .digest = {0} }, d0 = d;
>  	int rc;
>  	u32 i;
>  	SHASH_DESC_ON_STACK(shash, tfm);
> @@ -830,6 +830,15 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
>  		rc = crypto_shash_update(shash, d.digest,
>  					 crypto_shash_digestsize(tfm));
>  	}
> +	/* extend cumulative sha1 over tpm registers 8-9 */
> +	for (i = TPM_PCR8; i < TPM_PCR10; i++) {
> +		ima_pcrread(i, &d);
> +		/* if not zero, accumulate with current aggregate */
> +		if (memcmp(d.digest, d0.digest,
> +					crypto_shash_digestsize(tfm) != 0))

The formatting here is a bit off.

thanks,

Mimi

> +			rc = crypto_shash_update(shash, d.digest,
> +					crypto_shash_digestsize(tfm));
> +	}
>  	if (!rc)
>  		crypto_shash_final(shash, digest);
>  	return rc;

