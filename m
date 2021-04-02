Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A373352A3A
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Apr 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbhDBL1i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Apr 2021 07:27:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235170AbhDBL1h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Apr 2021 07:27:37 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 132B4K7S176199;
        Fri, 2 Apr 2021 07:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GXI532RUtUF0I/TkqNc22FCXRKltQLqudGyKbkMAYuI=;
 b=iYAOLNbz8MADkV7F0/6GAMDhzuNki/WllObrXA6OJhiGDG9y84oAxIlpN/1q2V6AQtB1
 O7lAMrwI9lTWL6kJBDTvSgSWRv33lK1U614TolSUSAAY+8/pe+RRdnTGTrObDxI7cOZd
 NcSjoIWn+dRhJBE+N8UGn8LsBxVZ2gSbsoCexOy2bQYMsKPrTLzY7ks1R0BebpA/DAro
 4wR8qGszobtNVt8ZJ0L/mp30+x/KDhV7hF4G9Dq/Ut5KeCr5K0zrjQZpyWbNEdCSkgwS
 oBSUq5jCH32YbBlfjU/zIEK/qEIsaT+XLQHjfxELLAN72XElCrRUP5OJZ8XIvM0a/7tC hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37nbtcj459-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 07:27:27 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 132B4mvu177316;
        Fri, 2 Apr 2021 07:27:27 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37nbtcj43y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 07:27:27 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 132BLpFJ030833;
        Fri, 2 Apr 2021 11:27:21 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 37n2942qt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Apr 2021 11:27:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 132BRKxk10093148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Apr 2021 11:27:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB4AFC6059;
        Fri,  2 Apr 2021 11:27:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 326BBC6055;
        Fri,  2 Apr 2021 11:27:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  2 Apr 2021 11:27:18 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] ima: enable signing of modules with build time
 generated key
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20210330131636.21711-1-nayna@linux.ibm.com>
 <20210330131636.21711-3-nayna@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <c0df8b07-79de-80cb-9eaa-ed70fbf8414b@linux.ibm.com>
Date:   Fri, 2 Apr 2021 07:27:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330131636.21711-3-nayna@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bB_Cg1RSifXY98ku04wXcNMmgrKSnXr7
X-Proofpoint-GUID: NGAkoLW4r8Gt0EZTS08vedNqU9BIE09U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_07:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104020080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 3/30/21 9:16 AM, Nayna Jain wrote:
> The kernel build process currently only signs kernel modules when
> MODULE_SIG is enabled. Also, sign the kernel modules at build time when
> IMA_APPRAISE_MODSIG is enabled.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
Acked-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   certs/Kconfig  | 2 +-
>   certs/Makefile | 8 ++++++++
>   init/Kconfig   | 6 +++---
>   3 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/certs/Kconfig b/certs/Kconfig
> index c94e93d8bccf..48675ad319db 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -4,7 +4,7 @@ menu "Certificates for signature checking"
>   config MODULE_SIG_KEY
>   	string "File name or PKCS#11 URI of module signing key"
>   	default "certs/signing_key.pem"
> -	depends on MODULE_SIG
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>   	help
>            Provide the file name of a private key/certificate in PEM format,
>            or a PKCS#11 URI according to RFC7512. The file should contain, or
> diff --git a/certs/Makefile b/certs/Makefile
> index f4c25b67aad9..e3185c57fbd8 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -32,6 +32,14 @@ endif # CONFIG_SYSTEM_TRUSTED_KEYRING
>   clean-files := x509_certificate_list .x509.list
>   
>   ifeq ($(CONFIG_MODULE_SIG),y)
> +	SIGN_KEY = y
> +endif
> +
> +ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
> +	SIGN_KEY = y
> +endif
> +
> +ifdef SIGN_KEY
>   ###############################################################################
>   #
>   # If module signing is requested, say by allyesconfig, but a key has not been
> diff --git a/init/Kconfig b/init/Kconfig
> index 5f5c776ef192..85e48a578f90 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2164,7 +2164,7 @@ config MODULE_SIG_FORCE
>   config MODULE_SIG_ALL
>   	bool "Automatically sign all modules"
>   	default y
> -	depends on MODULE_SIG
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>   	help
>   	  Sign all modules during make modules_install. Without this option,
>   	  modules must be signed manually, using the scripts/sign-file tool.
> @@ -2174,7 +2174,7 @@ comment "Do not forget to sign required modules with scripts/sign-file"
>   
>   choice
>   	prompt "Which hash algorithm should modules be signed with?"
> -	depends on MODULE_SIG
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>   	help
>   	  This determines which sort of hashing algorithm will be used during
>   	  signature generation.  This algorithm _must_ be built into the kernel
> @@ -2206,7 +2206,7 @@ endchoice
>   
>   config MODULE_SIG_HASH
>   	string
> -	depends on MODULE_SIG
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>   	default "sha1" if MODULE_SIG_SHA1
>   	default "sha224" if MODULE_SIG_SHA224
>   	default "sha256" if MODULE_SIG_SHA256
