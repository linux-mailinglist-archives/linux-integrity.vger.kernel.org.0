Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03A728011E
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Oct 2020 16:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgJAORa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Oct 2020 10:17:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732104AbgJAOR3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Oct 2020 10:17:29 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 091ECtf5074912;
        Thu, 1 Oct 2020 10:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uCjLx3JAn4oDf/Z/P4KtHa7R5B9aUB7Skx7uMNNrCUo=;
 b=O4iH48NByl2pkIqx+pnBX1kgwo8OXUo01npbtvPhKoOYctZzIt9Yh/1J3TJgJ8QpQN2w
 TJSuJ+UsktIbxdEG7xqA4B+jnMSH5PNCq2Qm+3xr6dR0g1imZfRHuu5mMtTu2F2v6Kwq
 5pTKXMpjJuRuNlZIz68ujVo+K2cyAMerSNPgAkCXYluk7HMxnoJ//lv+rkXEeSwRP5Ci
 10fKuLsbOh7pMWbxR5fHO5fXwwNtRWD8nVBHF3yoYCn10tOs4KQzfer/+vmiM5OsePY6
 ITj78i0TZyTzNEQDANZ+cvOx0MLXrV9vANusVePmpg/RJMQ/FsnhJWjt6IW/O6yJBLG6 Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33wgp10579-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 10:17:10 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 091EFKEq087179;
        Thu, 1 Oct 2020 10:17:09 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33wgp1055s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 10:17:09 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 091E8IFk029765;
        Thu, 1 Oct 2020 14:17:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgt5mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 14:17:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 091EH4JH29098268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Oct 2020 14:17:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE79FAE051;
        Thu,  1 Oct 2020 14:17:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31051AE055;
        Thu,  1 Oct 2020 14:17:01 +0000 (GMT)
Received: from sig-9-65-202-121.ibm.com (unknown [9.65.202.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Oct 2020 14:17:01 +0000 (GMT)
Message-ID: <71c7773f1393fb3bec3851f0869952c308dc2149.camel@linux.ibm.com>
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Hao Wu <hao.wu@rubrik.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Nayna Jain <nayna@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        Hamza Attak <hamza@hpe.com>, why2jjj.linux@gmail.com,
        zohar@linux.vnet.ibm.com, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>
Date:   Thu, 01 Oct 2020 10:16:59 -0400
In-Reply-To: <EA1EE8F8-F054-4E1B-B830-231398D33CB8@rubrik.com>
References: <20200926223150.109645-1-hao.wu@rubrik.com>
         <73405d14d7665e8a4e3e9defde7fb12aeae7784c.camel@HansenPartnership.com>
         <DFD7629C-05BF-46C1-B3D7-92FBBC176D9E@rubrik.com>
         <cf5c8035b7183522fb8a5df4baa95bd24288e61f.camel@HansenPartnership.com>
         <20200928010835.GD6704@linux.intel.com>
         <1F6A3D58-6B60-4FCB-A629-34CE8813E04C@rubrik.com>
         <20200928141613.GB70098@linux.intel.com>
         <E0629B0C-E49F-4FA1-8DBA-E8CB1EDEFD1A@rubrik.com>
         <20200928194745.GB125819@linux.intel.com>
         <18048BE4-2700-4BF9-8959-D024ECF0B704@rubrik.com>
         <20200930021136.GD808399@linux.intel.com>
         <5B6A7DBB-C06B-467E-9BA4-C0F9E241F5A6@rubrik.com>
         <EA1EE8F8-F054-4E1B-B830-231398D33CB8@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_04:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Hao,

When posting to the mailing list, please respond using plain text and
inline/bottom post.

On Wed, 2020-09-30 at 22:26 -0700, Hao Wu wrote:
> 7.1
> 
> - Jarkko’s proposal: Using msleep(TPM_TIMEOUT) for wait_for_tpm_stat(), resolve
>   the Atmel crash as we expect.  
> 
> ---
>  drivers/char/tpm/tpm_tis_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 65ab1b027949..7dd9bcff542d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,8 +80,9 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +            msleep(TPM_TIMEOUT);
> +			// usleep_range(TPM_TIMEOUT_USECS_MIN,
> +			//	     TPM_TIMEOUT_USECS_MAX);
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> --
> 2.17.1
> 
> But I think tpm_msleep(15) is still the right way to go.

Using msleep is definitely not the right way of going.   Please refer
to commit a233a0289cf9 ("tpm: msleep() delays - replace with
usleep_range() in i2c nuvoton driver") for a detailed explanation.

thanks,

Mimi

