Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909E93269AE
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Feb 2021 22:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhBZVsM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Feb 2021 16:48:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229550AbhBZVsM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Feb 2021 16:48:12 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QLXbw6190173;
        Fri, 26 Feb 2021 16:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4ulHDvcv+OQOxiMGRBMD2DqJomSRG7h0QLHFf2Wu6VM=;
 b=pbDCuW4k6WsMbuG02bjXLGoRt44LLLfapfPx+7q/kVal8yj4l56wvbllH1htOmGUYxwz
 H/w1m1jDO0guHZAG0uw4zR312OPItEMh+5ru3DiZnezgVfSYrNJQVQNMe+j4aTvGTNp+
 puP2fgSYeEIqVE52w0XSOwxCEqyW3jOn1QK/rMyLOCQws+t+WPoHwxd5Y2Dxf2t7egEW
 fWdIcdxwxlFa11oooZHhaklTS+LlHE2tlhvsVhzJgjGDahfuV5A6CJLBrS1LwOTN3+2k
 9Etl6tFRgUxFUQxLlMrrxGAO1ttAWYLOMb4OnoqNDcgb+r2PXKZPDK4tr8nIEpzsiRZ3 Aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y8he14nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:47:27 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11QLaTa4009239;
        Fri, 26 Feb 2021 16:47:27 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36y8he14nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 16:47:27 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11QLh0FY010492;
        Fri, 26 Feb 2021 21:47:26 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 36tt2ax5hd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 21:47:26 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11QLlPhe30933456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 21:47:25 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDF4BAC062;
        Fri, 26 Feb 2021 21:47:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCA06AC060;
        Fri, 26 Feb 2021 21:47:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Feb 2021 21:47:25 +0000 (GMT)
Subject: Re: [PATCH 3/3] integrity: Load keys from TPM NV onto IMA keyring
To:     Patrick Uiterwijk <patrick@puiterwijk.org>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, kgold@linux.ibm.com
References: <20210225203229.363302-1-patrick@puiterwijk.org>
 <20210225203229.363302-4-patrick@puiterwijk.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <4dcd8fe8-632a-a60b-e502-2185f61529f3@linux.ibm.com>
Date:   Fri, 26 Feb 2021 16:47:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210225203229.363302-4-patrick@puiterwijk.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_09:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260159
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/25/21 3:32 PM, Patrick Uiterwijk wrote:
> Allows users to enroll their own public key stored in a specific TPM2
> NV Index, requiring the absence of the Platform Create and Platform
> Write attributes on the NV Index, to be loaded on the IMA keyring.
>
> Provides a method for users to load keys without the need to recompile
> the kernel or change the kernel binary, which would require a resign of
> the kernel image.
>
> Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
> ---
>   security/integrity/ima/Kconfig    | 22 +++++++++++++
>   security/integrity/ima/ima_init.c | 53 +++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)
>
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 12e9250c1bec..28424b930c81 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -291,6 +291,28 @@ config IMA_BLACKLIST_KEYRING
>   	   the search is successful the requested operation is rejected and
>   	   an error is returned to the caller.
>   
> +config IMA_LOAD_CERT_NVINDEX
> +	bool "Load certificate from TPM nvindex into '.ima' trusted keyring"
> +	depends on IMA_TRUSTED_KEYRING && TCG_TPM
> +	default n
> +	help
> +	   File signature verification is based on the public keys
> +	   loaded on the .ima trusted keyring. These public keys are
> +	   X509 certificates signed by a trusted key on the
> +	   .system keyring.  This option enables X509 certificate
> +	   loading by the kernel onto the '.ima' trusted keyring
> +	   from a TPM nvindex, bypassing the builtin keyring check.
> +
> +config IMA_LOAD_CERT_NVINDEX_INDEX
> +	hex "The TPM NV Index to load into the '.ima' trusted keyring"
> +	depends on IMA_LOAD_CERT_NVINDEX
> +	default 0x184b520
> +	help
> +	   Defines the index of the NV Index that gets loaded into the
> +	   '.ima' keyring.
> +	   The default is the "0x18" prefix for a non-TCG specified NV Index,
> +	   suffixed with ASCII for "KR" (keyring) and then 0
> +
>   config IMA_LOAD_X509
>   	bool "Load X509 certificate onto the '.ima' trusted keyring"
>   	depends on IMA_TRUSTED_KEYRING
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 6e8742916d1d..ea0949e8df12 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -112,6 +112,55 @@ void __init ima_load_x509(void)
>   }
>   #endif
>   
> +#ifndef CONFIG_IMA_LOAD_CERT_NVINDEX
> +int __init ima_load_key_nvindex(void)
> +{
> +	return 0;
> +}
> +#else
> +int __init ima_load_key_nvindex(void)
> +{
> +	void *cert_buffer;
> +	int rc;
> +	key_perm_t perm;
> +	u32 nvindex_attributes = 0;
> +
> +	rc = tpm_nv_read(tpm_default_chip(),


You should do chip = tpm_default_chip() so that later on you can do 
put_device(&chip->dev).


> +				CONFIG_IMA_LOAD_CERT_NVINDEX_INDEX,
> +				&nvindex_attributes, &cert_buffer);
> +	if (rc < 0) {
> +		if (rc == -ENODEV)  /* No TPM2 */
> +			rc = 0;
> +		if (rc == -ENOENT)  /* No certificate in NV Index */
> +			rc = 0;
> +		goto out;
> +	}
> +
> +	pr_info("Loading IMA key from TPM NV Index 0x%x", CONFIG_IMA_LOAD_CERT_NVINDEX_INDEX);
> +
> +	if (nvindex_attributes & TPM2_ATTR_NV_PLATFORMCREATE) {
> +		pr_err("NV Index has the Platform Create attribute");
> +		rc = -EACCES;
> +		goto out_free;
> +	}
> +	if (nvindex_attributes & TPM2_ATTR_NV_PPWRITE) {
> +		pr_err("NV Index has the Platform Write attribute");
> +		rc = -EACCES;
> +		goto out_free;
> +	}
> +
> +	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
> +	rc = integrity_load_cert(INTEGRITY_KEYRING_IMA, "TPM NV Index",
> +				 cert_buffer, rc, perm,
> +				 KEY_ALLOC_BYPASS_RESTRICTION);
> +
> +out_free:
> +	kvfree(cert_buffer);


kfree?


> +out:
> +	return rc;
> +}
> +#endif
> +
>   int __init ima_init(void)
>   {
>   	int rc;
> @@ -124,6 +173,10 @@ int __init ima_init(void)
>   	if (rc)
>   		return rc;
>   
> +	rc = ima_load_key_nvindex();
> +	if (rc)
> +		pr_info("Failed to load IMA key from TPM NV Index (%d)", rc);
> +
>   	rc = ima_init_crypto();
>   	if (rc)
>   		return rc;
