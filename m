Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D39C562A6A
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 22:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404981AbfGHUfM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 16:35:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731973AbfGHUfL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 16:35:11 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68KWx4E088164;
        Mon, 8 Jul 2019 16:35:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmbrstc21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 16:35:05 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x68KYIkn091227;
        Mon, 8 Jul 2019 16:35:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tmbrstc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 16:35:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x68KTa9c006946;
        Mon, 8 Jul 2019 20:35:03 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2tjk970jbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jul 2019 20:35:03 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68KZ3nc38666656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 20:35:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCE7E112063;
        Mon,  8 Jul 2019 20:35:02 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 622D2112061;
        Mon,  8 Jul 2019 20:35:00 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.176.217])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 20:35:00 +0000 (GMT)
Message-ID: <1562618099.20748.13.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
From:   James Bottomley <jejb@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        tyhicks@canonical.com, nayna@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com
Date:   Mon, 08 Jul 2019 13:34:59 -0700
In-Reply-To: <20190705163735.11539-1-roberto.sassu@huawei.com>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080256
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-07-05 at 18:37 +0200, Roberto Sassu wrote:
> Commit c78719203fc6 ("KEYS: trusted: allow trusted.ko to initialize
> w/o a
> TPM") allows the trusted module to be loaded even a TPM is not found
> to
> avoid module dependency problems.
> 
> Unfortunately, this does not completely solve the issue, as there
> could be
> a case where a TPM is found but is not functional (the TPM commands
> return
> an error). Specifically, after the tpm_chip structure is returned by
> tpm_default_chip() in init_trusted(), the execution terminates after
> init_digests() returns -EFAULT (due to the fact that tpm_get_random()
> returns a positive value, but less than TPM_MAX_DIGEST_SIZE).
> 
> This patch fixes the issue by ignoring the TPM_ERR_DEACTIVATED and
> TPM_ERR_DISABLED errors.
> 
> Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip
> structure...")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  drivers/char/tpm/tpm.h  | 2 --
>  include/linux/tpm.h     | 3 +++
>  security/keys/trusted.c | 6 +++++-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index e503ffc3aa39..a216ac396711 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -54,8 +54,6 @@ enum tpm_addr {
>  
>  #define TPM_WARN_RETRY          0x800
>  #define TPM_WARN_DOING_SELFTEST 0x802
> -#define TPM_ERR_DEACTIVATED     0x6
> -#define TPM_ERR_DISABLED        0x7
>  #define TPM_ERR_INVALID_POSTINIT 38
>  
>  #define TPM_HEADER_SIZE		10
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 53c0ea9ec9df..efd3ccbb6aee 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -26,6 +26,9 @@
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
>  #define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
>  
> +#define TPM_ERR_DEACTIVATED     0x6
> +#define TPM_ERR_DISABLED        0x7
> +
>  struct tpm_chip;
>  struct trusted_key_payload;
>  struct trusted_key_options;
> diff --git a/security/keys/trusted.c b/security/keys/trusted.c
> index 9a94672e7adc..430d85090b3b 100644
> --- a/security/keys/trusted.c
> +++ b/security/keys/trusted.c
> @@ -389,6 +389,10 @@ static int pcrlock(const int pcrnum)
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> +	/* This can happen if the TPM is inactive. */
> +	if (!digests)
> +		return -EINVAL;
> +
>  	return tpm_pcr_extend(chip, pcrnum, digests) ? -EINVAL : 0;
>  }
>  
> @@ -1233,7 +1237,7 @@ static int __init init_digests(void)
>  	int i;
>  
>  	ret = tpm_get_random(chip, digest, TPM_MAX_DIGEST_SIZE);

Not a criticism of your patch, but can we please stop doing this. 
Single random number sources are horrendously bad practice because it
gives an attacker a single target to subvert.  We should ensure the TPM
is plugged into the kernel RNG as a source and then take randomness
from the mixed pool so it's harder for an attacker because they have to
subvert all our sources to predict what came out.

James

