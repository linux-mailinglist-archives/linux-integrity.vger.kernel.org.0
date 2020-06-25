Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB70A209E37
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 14:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgFYMNS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 08:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404397AbgFYMNS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 08:13:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PC2mwq097887;
        Thu, 25 Jun 2020 08:13:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyt608h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:13:12 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PC2ukP098698;
        Thu, 25 Jun 2020 08:13:12 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyt607t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 08:13:12 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PC6BFa014586;
        Thu, 25 Jun 2020 12:13:10 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 31uus1btg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 12:13:10 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PCDAKr46465370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 12:13:10 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B8B112063;
        Thu, 25 Jun 2020 12:13:10 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25B75112061;
        Thu, 25 Jun 2020 12:13:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 12:13:10 +0000 (GMT)
Subject: Re: [PATCH] tpm: tpm2-space: Resize session and context buffers
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
References: <20200625042424.370072-1-jarkko.sakkinen@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2f8a0127-d2ba-21aa-75b3-2dfccfb52eab@linux.ibm.com>
Date:   Thu, 25 Jun 2020 08:13:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625042424.370072-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_05:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 cotscore=-2147483648 mlxscore=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250078
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/25/20 12:24 AM, Jarkko Sakkinen wrote:
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
>   drivers/char/tpm/tpm2-space.c | 80 ++++++++++++++++++++++++-----------
>   include/linux/tpm.h           |  6 ++-
>   2 files changed, 59 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index 982d341d8837..acb9e82bf9e8 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -15,6 +15,8 @@
>   #include <asm/unaligned.h>
>   #include "tpm.h"
>   
> +#define TPM2_SPACE_MAX_BUFFER_SIZE	(4 * PAGE_SIZE)

PAGE_SIZE is 64k on ppc64. Rather use 4 * 4096?


Rest looks good.


> +
>   enum tpm2_handle_types {
>   	TPM2_HT_HMAC_SESSION	= 0x02000000,
>   	TPM2_HT_POLICY_SESSION	= 0x03000000,
> @@ -47,9 +49,12 @@ int tpm2_init_space(struct tpm_space *space)
>   	space->session_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
>   	if (space->session_buf == NULL) {
>   		kfree(space->context_buf);
> +		space->context_buf = NULL;
>   		return -ENOMEM;
>   	}
>   
> +	space->context_size = PAGE_SIZE;
> +	space->session_size = PAGE_SIZE;
>   	return 0;
>   }
>   
> @@ -116,11 +121,13 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>   	return 0;
>   }
>   
> -static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> -			     unsigned int buf_size, unsigned int *offset)
> +static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 **buf,
> +			     unsigned int *buf_size, unsigned int *offset)
>   {
> -	struct tpm_buf tbuf;
> +	unsigned int new_buf_size;
>   	unsigned int body_size;
> +	struct tpm_buf tbuf;
> +	void *new_buf;
>   	int rc;
>   
>   	rc = tpm_buf_init(&tbuf, TPM2_ST_NO_SESSIONS, TPM2_CC_CONTEXT_SAVE);
> @@ -131,31 +138,48 @@ static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
>   
>   	rc = tpm_transmit_cmd(chip, &tbuf, 0, NULL);
>   	if (rc < 0) {
> -		dev_warn(&chip->dev, "%s: failed with a system error %d\n",
> -			 __func__, rc);
> -		tpm_buf_destroy(&tbuf);
> -		return -EFAULT;
> +		rc = -EFAULT;
> +		goto err;
>   	} else if (tpm2_rc_value(rc) == TPM2_RC_REFERENCE_H0) {
> -		tpm_buf_destroy(&tbuf);
> -		return -ENOENT;
> +		rc = -ENOENT;
> +		goto out;
>   	} else if (rc) {
> -		dev_warn(&chip->dev, "%s: failed with a TPM error 0x%04X\n",
> -			 __func__, rc);
> -		tpm_buf_destroy(&tbuf);
> -		return -EFAULT;
> +		rc = -EFAULT;
> +		goto err;
>   	}
>   
>   	body_size = tpm_buf_length(&tbuf) - TPM_HEADER_SIZE;
> -	if ((*offset + body_size) > buf_size) {
> -		dev_warn(&chip->dev, "%s: out of backing storage\n", __func__);
> -		tpm_buf_destroy(&tbuf);
> -		return -ENOMEM;
> +	/* We grow the buffer in page increments. */
> +	new_buf_size = PFN_UP(*offset + body_size);
> +
> +	if (new_buf_size > TPM2_SPACE_MAX_BUFFER_SIZE) {
> +		rc = -ENOMEM;
> +		goto err;
>   	}
>   
> -	memcpy(&buf[*offset], &tbuf.data[TPM_HEADER_SIZE], body_size);
> +	if (new_buf_size > *buf_size) {
> +		new_buf = krealloc(*buf, new_buf_size, GFP_KERNEL);
> +		if (!new_buf) {
> +			rc = -ENOMEM;
> +			goto err;
> +		}
> +
> +		*buf = new_buf;
> +		*buf_size = new_buf_size;
> +	}
> +
> +	memcpy(*buf + *offset, &tbuf.data[TPM_HEADER_SIZE], body_size);
>   	*offset += body_size;
> +
> +out:
>   	tpm_buf_destroy(&tbuf);
> -	return 0;
> +	return rc;
> +
> +err:
> +	dev_warn(&chip->dev, "%s: ret=%d\n", __func__, rc);
> +
> +	tpm_buf_destroy(&tbuf);
> +	return rc;
>   }
>   
>   void tpm2_flush_space(struct tpm_chip *chip)
> @@ -311,8 +335,10 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
>   	       sizeof(space->context_tbl));
>   	memcpy(&chip->work_space.session_tbl, &space->session_tbl,
>   	       sizeof(space->session_tbl));
> -	memcpy(chip->work_space.context_buf, space->context_buf, PAGE_SIZE);
> -	memcpy(chip->work_space.session_buf, space->session_buf, PAGE_SIZE);
> +	memcpy(chip->work_space.context_buf, space->context_buf,
> +	       space->context_size);
> +	memcpy(chip->work_space.session_buf, space->session_buf,
> +	       space->session_size);
>   
>   	rc = tpm2_load_space(chip);
>   	if (rc) {
> @@ -492,7 +518,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
>   			continue;
>   
>   		rc = tpm2_save_context(chip, space->context_tbl[i],
> -				       space->context_buf, PAGE_SIZE,
> +				       &space->context_buf,
> +				       &space->context_size,
>   				       &offset);
>   		if (rc == -ENOENT) {
>   			space->context_tbl[i] = 0;
> @@ -509,7 +536,8 @@ static int tpm2_save_space(struct tpm_chip *chip)
>   			continue;
>   
>   		rc = tpm2_save_context(chip, space->session_tbl[i],
> -				       space->session_buf, PAGE_SIZE,
> +				       &space->session_buf,
> +				       &space->session_size,
>   				       &offset);
>   
>   		if (rc == -ENOENT) {
> @@ -557,8 +585,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space,
>   	       sizeof(space->context_tbl));
>   	memcpy(&space->session_tbl, &chip->work_space.session_tbl,
>   	       sizeof(space->session_tbl));
> -	memcpy(space->context_buf, chip->work_space.context_buf, PAGE_SIZE);
> -	memcpy(space->session_buf, chip->work_space.session_buf, PAGE_SIZE);
> +	memcpy(space->context_buf, chip->work_space.context_buf,
> +	       space->context_size);
> +	memcpy(space->session_buf, chip->work_space.session_buf,
> +	       space->session_size);
>   
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


