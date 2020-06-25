Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2F320A798
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407280AbgFYViN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:38:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403961AbgFYViM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:38:12 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PLY8Tr176894;
        Thu, 25 Jun 2020 17:38:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a395a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:38:06 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PLYEGt177555;
        Thu, 25 Jun 2020 17:38:05 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31w3a3959p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:38:05 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PLPi7O005601;
        Thu, 25 Jun 2020 21:38:04 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 31uurtb0bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:38:04 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLc3lR41222630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:38:03 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8124E112067;
        Thu, 25 Jun 2020 21:38:03 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57362112063;
        Thu, 25 Jun 2020 21:38:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:38:03 +0000 (GMT)
Subject: Re: [PATCH v2] tpm: tpm2-space: Resize session and context buffers
 dynamically
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Alexey Klimov <aklimov@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <a6444592-234b-d77e-7403-812e19691e72@linux.ibm.com>
Date:   Thu, 25 Jun 2020 17:38:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625043819.376693-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_16:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 cotscore=-2147483648 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250124
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/20 12:38 AM, Jarkko Sakkinen wrote:
> Re-allocate context and session buffers when needed. Scale them in page
> increments so that the reallocation is only seldomly required, and thus
> causes minimal stress to the system. Add a static maximum limit of four
> pages for buffer sizes.
>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> Tested only for compilation.
> v2: TPM2_SPACE_DEFAULT_BUFFER_SIZE
>   drivers/char/tpm/tpm2-space.c | 87 ++++++++++++++++++++++++-----------
>   include/linux/tpm.h           |  6 ++-
>   2 files changed, 64 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 982d341d8837..b8ece01d6afb 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -15,6 +15,9 @@
>   #include <asm/unaligned.h>
>   #include "tpm.h"
>   
> +#define TPM2_SPACE_DEFAULT_BUFFER_SIZE	PAGE_SIZE
> +#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)
> +
>   enum tpm2_handle_types {
>   	TPM2_HT_HMAC_SESSION	= 0x02000000,
>   	TPM2_HT_POLICY_SESSION	= 0x03000000,
> @@ -557,8 +588,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>   	       sizeof(space->context_tbl));
>   	memcpy(&space->session_tbl, &chip->work_space.session_tbl,
>   	       sizeof(space->session_tbl));
> -	memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
> -	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
> +	memcpy(space->context_buf, chip->work_space.context_buf,
> +	       space->context_size);


You have to allocate the max size the in tpm_chip_alloc (tpm-chip.c):

    chip->work_space.context_buf = kzalloc(TPM2_SPACE_MAX_BUFFER_SIZE, 
GFP_KERNEL);


> +	memcpy(space->session_buf, chip->work_space.session_buf,
> +	       space->session_size);
>   


same for this


>   	return 0;
>   out:
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 03e9b184411b..9ea39e8f7162 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -92,10 +92,12 @@ enum tpm_duration {
>   #define TPM_PPI_VERSION_LEN		3
>   
>   struct tpm_space {
> +	u8  *context_buf;
> +	u8  *session_buf;
> +	u32 context_size;
> +	u32 session_size;
>   	u32 context_tbl[3];
> -	u8 *context_buf;
>   	u32 session_tbl[3];
> -	u8 *session_buf;
>   };
>   
>   struct tpm_bios_log {


