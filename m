Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB25205417
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbgFWODs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 10:03:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732727AbgFWODs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 10:03:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NE21rl132386;
        Tue, 23 Jun 2020 10:03:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ue3dtgsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 10:03:38 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05NE2Cws133248;
        Tue, 23 Jun 2020 10:03:37 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31ue3dtgqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 10:03:37 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05NE0qW5022671;
        Tue, 23 Jun 2020 14:03:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31uk4mg031-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 14:03:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05NE3WJe34865156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 14:03:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3525E42049;
        Tue, 23 Jun 2020 14:03:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D34242056;
        Tue, 23 Jun 2020 14:03:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.212.185])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Jun 2020 14:03:11 +0000 (GMT)
Message-ID: <1592920990.5437.15.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: extend boot_aggregate with kernel measurements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com
Date:   Tue, 23 Jun 2020 10:03:10 -0400
In-Reply-To: <20200622045019.1636-1-maurizio.drocco@ibm.com>
References: <1592856871.4987.21.camel@linux.ibm.com>
         <20200622045019.1636-1-maurizio.drocco@ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_06:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 cotscore=-2147483648 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006230108
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Maurizio,

When re-posting patches, please include the version number (e.g.
[PATCH v4] ima: ... ).

On Mon, 2020-06-22 at 00:50 -0400, Maurizio Drocco wrote:
> IMA is not considering TPM registers 8-9 when calculating the boot
> aggregate.

This line is unnecessary with the following change.

> When registers 8-9 are used to store measurements of the
> kernel and its command line (e.g., grub2 bootloader with tpm module
> enabled), IMA should include them in the boot aggregate.

The "When" clause makes this sound like PCRs 8 & 9 are not always
included.  I would split this into two sentences.

>  Registers
> 8-9 are only included in non-SHA1 boot_aggregate digests to avoid
> ambiguity.
> 
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---

Missing "Changelog:".

Changelog:
v2: 
- Limit including PCRs 8 & 9 to non-sha1 hashes
v1:
- Include non zero PCRs 8 & 9 in the boot_aggregate

>  security/integrity/ima/ima.h        |  2 +-
>  security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
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
> index 220b14920c37..d02917d85033 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -823,13 +823,26 @@ static int ima_calc_boot_aggregate_tfm(char *digest, u16 alg_id,
>  	if (rc != 0)
>  		return rc;
>  
> -	/* cumulative sha1 over tpm registers 0-7 */
> +	/* cumulative digest over tpm registers 0-7 */

Please uppercase "tpm" here and below.

>  	for (i = TPM_PCR0; i < TPM_PCR8; i++) {
>  		ima_pcrread(i, &d);
>  		/* now accumulate with current aggregate */
>  		rc = crypto_shash_update(shash, d.digest,
>  					 crypto_shash_digestsize(tfm));
>  	}
> +	/*
> +	 * extend cumulative digest over tpm registers 8-9, which contain
> +	 * measurement for the kernel command line (reg. 8) and image (reg. 9)
> +	 * in a typical PCR allocation. Registers 8-9 are only included in
> +	 * non-SHA1 boot_aggregate digests to avoid ambiguity.
> +	 */

Comments that are full sentences should start with an uppercase letter
and end with a period (e.g. Extend).

thanks,

Mimi

> +	if (alg_id != TPM_ALG_SHA1) {
> +		for (i = TPM_PCR8; i < TPM_PCR10; i++) {
> +			ima_pcrread(i, &d);
> +			rc = crypto_shash_update(shash, d.digest,
> +						crypto_shash_digestsize(tfm));
> +		}
> +	}
>  	if (!rc)
>  		crypto_shash_final(shash, digest);
>  	return rc;

