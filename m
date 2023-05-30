Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B396716B35
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjE3RhK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 13:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjE3RhK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 13:37:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B6AB2;
        Tue, 30 May 2023 10:37:08 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UHQGdc032423;
        Tue, 30 May 2023 17:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MTOGZ1p9JAjBEqJLoc8Qo7BmBr6wNxBkGhsoviMFLzs=;
 b=o+tLJQjvV+dTl+nV4vzuBmkPcRsnrBfvvatpK3lieZwD5jsJk3vs8bcsvcZgH4zQgvzD
 /K5lwKzUh+9KOI6wheryuuNak82gw4IfPvPGwcfJ7Wad1trLd9PCqs8A4PVsvAtxsylr
 9rOwf2ZEpn9DXdFgo6vpY+rSb96+reoXFE7MtkewPzIQGl8Ciba1cxu0MBXKniZBmiUx
 Qajsvwkj0oECpmzSvonE+ayWcV/g5SdiLmqtwT5a53Sqtcf0EUfQ8+bRrzKsOHuJAnYo
 /nxI4CiwjceWXH4myLCzPczKw09k24GqLf09lwaCbjmgWIOJg/oma5fv21MF2e8cuhZI KQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwnhwg7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 17:36:58 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDsIRc009908;
        Tue, 30 May 2023 17:36:57 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5qvh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 17:36:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UHauAI787192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 17:36:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C21E58055;
        Tue, 30 May 2023 17:36:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C02358062;
        Tue, 30 May 2023 17:36:55 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 17:36:55 +0000 (GMT)
Message-ID: <9c498e15-9de1-ce52-61a8-414a4cf7195f@linux.ibm.com>
Date:   Tue, 30 May 2023 13:36:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20230530020133.235765-1-jarkko@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230530020133.235765-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kT3Zjf72aQ8yNBskKSlH6QnO1D5IcIBX
X-Proofpoint-ORIG-GUID: kT3Zjf72aQ8yNBskKSlH6QnO1D5IcIBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 mlxscore=0 clxscore=1011 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/29/23 22:01, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> 
> The driver has two issues (in priority order) in the locality change:
> 
> 1. The driver uses __user pointer and copy_to_user() and
>     copy_from_user() with a kernel address during the locality change.

This can lead to ... bad things ?

> 2. For invalid locality change request from user space, the driver
>     sets errno to EFAULT, while for invalid input data EINVAL should
>     be used.
> 
> Address this by:
> 
> 1. Introduce __vtpm_proxy_read_unlocked(),  __vtpm_proxy_write_unlocked()
>     and __vtpm_proxy_read_write_locked().
> 2. Make locality change atomic by calling __vtpm_proxy_read_write_locked(),
>     instead of tpm_transmit_cmd().

2. sounds like it should be addressable by changing -EFAULT to -EINVAL but there's more to it?


> 
> Cc: stable@vger.kernel.org
> Fixes: be4c9acfe297 ("tpm: vtpm_proxy: Implement request_locality function.")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
> ---
> v2:
> * Acquiring and releasing mutex in-between should not be an issue
>    because they are executed with the chip locked.
> ---
>   drivers/char/tpm/tpm_vtpm_proxy.c | 162 ++++++++++++++----------------
>   1 file changed, 73 insertions(+), 89 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 30e953988cab..8f43a82e5590 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -38,7 +38,6 @@ struct proxy_dev {
>   #define STATE_OPENED_FLAG        BIT(0)
>   #define STATE_WAIT_RESPONSE_FLAG BIT(1)  /* waiting for emulator response */
>   #define STATE_REGISTERED_FLAG	 BIT(2)
> -#define STATE_DRIVER_COMMAND     BIT(3)  /* sending a driver specific command */
>   
>   	size_t req_len;              /* length of queued TPM request */
>   	size_t resp_len;             /* length of queued TPM response */
> @@ -58,106 +57,112 @@ static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
>    * Functions related to 'server side'
>    */
>   
> -/**
> - * vtpm_proxy_fops_read - Read TPM commands on 'server side'
> - *
> - * @filp: file pointer
> - * @buf: read buffer
> - * @count: number of bytes to read
> - * @off: offset
> - *
> - * Return:
> - *	Number of bytes read or negative error code
> - */
> -static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
> -				    size_t count, loff_t *off)
> +static ssize_t __vtpm_proxy_read_unlocked(struct proxy_dev *proxy_dev, char __user *buf,
> +					  size_t count)
>   {
> -	struct proxy_dev *proxy_dev = filp->private_data;
>   	size_t len;
> -	int sig, rc;
> -
> -	sig = wait_event_interruptible(proxy_dev->wq,
> -		proxy_dev->req_len != 0 ||
> -		!(proxy_dev->state & STATE_OPENED_FLAG));
> -	if (sig)
> -		return -EINTR;
> -
> -	mutex_lock(&proxy_dev->buf_lock);
> +	int rc;
>   
> -	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> +	if (!(proxy_dev->state & STATE_OPENED_FLAG))
>   		return -EPIPE;
> -	}
>   
>   	len = proxy_dev->req_len;
>   
>   	if (count < len || len > sizeof(proxy_dev->buffer)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
>   		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
>   			 count, len);
>   		return -EIO;
>   	}
>   
> -	rc = copy_to_user(buf, proxy_dev->buffer, len);
> +	if (buf)
> +		rc = copy_to_user(buf, proxy_dev->buffer, len);
> +
>   	memset(proxy_dev->buffer, 0, len);
>   	proxy_dev->req_len = 0;
>   
>   	if (!rc)
>   		proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
>   
> -	mutex_unlock(&proxy_dev->buf_lock);
> -
>   	if (rc)
>   		return -EFAULT;
>   
>   	return len;
>   }
>   
> -/**
> - * vtpm_proxy_fops_write - Write TPM responses on 'server side'
> - *
> - * @filp: file pointer
> - * @buf: write buffer
> - * @count: number of bytes to write
> - * @off: offset
> - *
> - * Return:
> - *	Number of bytes read or negative error value
> - */
> -static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
> -				     size_t count, loff_t *off)
> +static ssize_t __vtpm_proxy_write_unlocked(struct proxy_dev *proxy_dev, const char __user *buf,
> +					   size_t count)
>   {
> -	struct proxy_dev *proxy_dev = filp->private_data;
> -
> -	mutex_lock(&proxy_dev->buf_lock);
> -
> -	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> +	if (!(proxy_dev->state & STATE_OPENED_FLAG))
>   		return -EPIPE;
> -	}
>   
>   	if (count > sizeof(proxy_dev->buffer) ||
> -	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> +	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG))
>   		return -EIO;
> -	}
>   
>   	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
>   
>   	proxy_dev->req_len = 0;
>   
> -	if (copy_from_user(proxy_dev->buffer, buf, count)) {
> -		mutex_unlock(&proxy_dev->buf_lock);
> +	if (buf && copy_from_user(proxy_dev->buffer, buf, count))
>   		return -EFAULT;
> -	}
>   
>   	proxy_dev->resp_len = count;
> +	return count;
> +}
>   
> +static ssize_t __vtpm_proxy_read_write_unlocked(struct proxy_dev *proxy_dev, char __user *buf,
> +						size_t count)
> +{
> +	ssize_t rc;
> +
> +	do {
> +		rc = __vtpm_proxy_write_unlocked(proxy_dev, buf, count);
> +		if (rc < 0)
> +			break;
> +		rc = __vtpm_proxy_read_unlocked(proxy_dev, buf, rc);
> +	} while (0);
> +
> +	return rc;
> +}
> +
> +/*
> + * See struct file_operations.
> + */
> +static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
> +				    size_t count, loff_t *off)
> +{
> +	struct proxy_dev *proxy_dev = filp->private_data;
> +	ssize_t rc;
> +	int sig;
> +
> +	sig = wait_event_interruptible(proxy_dev->wq,
> +		proxy_dev->req_len != 0 ||
> +		!(proxy_dev->state & STATE_OPENED_FLAG));
> +	if (sig)
> +		return -EINTR;
> +
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_read_unlocked(proxy_dev, buf, count);
>   	mutex_unlock(&proxy_dev->buf_lock);
>   
> +	return rc;
> +}
> +
> +/*
> + * See struct file_operations.
> + */
> +static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
> +				     size_t count, loff_t *off)
> +{
> +	struct proxy_dev *proxy_dev = filp->private_data;
> +	int rc;

ssize_t rc;

> +
> +	mutex_lock(&proxy_dev->buf_lock);
> +	rc = __vtpm_proxy_write_unlocked(proxy_dev, buf, count);
> +	mutex_unlock(&proxy_dev->buf_lock);
>   	wake_up_interruptible(&proxy_dev->wq);
>   
> -	return count;
> +	return rc;
>   }
>   
>   /*
> @@ -295,28 +300,6 @@ static int vtpm_proxy_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>   	return len;
>   }
>   
> -static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
> -					u8 *buf, size_t count)
> -{
> -	struct tpm_header *hdr = (struct tpm_header *)buf;
> -
> -	if (count < sizeof(struct tpm_header))
> -		return 0;
> -
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> -		switch (be32_to_cpu(hdr->ordinal)) {
> -		case TPM2_CC_SET_LOCALITY:
> -			return 1;
> -		}
> -	} else {
> -		switch (be32_to_cpu(hdr->ordinal)) {
> -		case TPM_ORD_SET_LOCALITY:
> -			return 1;
> -		}
> -	}
> -	return 0;
> -}
> -
>   /*
>    * Called when core TPM driver forwards TPM requests to 'server side'.
>    *
> @@ -330,6 +313,7 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
>   static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   {
>   	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
> +	unsigned int ord = ((struct tpm_header *)buf)->ordinal;

'u32 ordinal' like in tpm_try_transmit ?

you need this here in some form: be32_to_cpu(hdr->ordinal)

>   
>   	if (count > sizeof(proxy_dev->buffer)) {
>   		dev_err(&chip->dev,(chip->flags & TPM_CHIP_FLAG_TPM2)
> @@ -338,9 +322,11 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
>   		return -EIO;
>   	}
>   
> -	if (!(proxy_dev->state & STATE_DRIVER_COMMAND) &&
> -	    vtpm_proxy_is_driver_command(chip, buf, count))
> -		return -EFAULT;
> +	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord == TPM2_CC_SET_LOCALITY)
> +		return -EINVAL;
> +
> +	if (ord == TPM_ORD_SET_LOCALITY)
> +		return -EINVAL;
if ((chip->flags & TPM_CHIP_FLAG_TPM2)) {
     if (ord == )
        return -EINVAL;
} else if (ord == ) {
     return -EINVAL;
}

>   
>   	mutex_lock(&proxy_dev->buf_lock);
>   
> @@ -409,12 +395,10 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
>   		return rc;
>   	tpm_buf_append_u8(&buf, locality);
>   
> -	proxy_dev->state |= STATE_DRIVER_COMMAND;
> -
> -	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
> -
> -	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
> -
> +	mutex_lock(&proxy_dev->buf_lock);
> +	memcpy(proxy_dev->buffer, buf.data, tpm_buf_length(&buf));
> +	rc = __vtpm_proxy_read_write_unlocked(proxy_dev, NULL, tpm_buf_length(&buf));
> +	mutex_unlock(&proxy_dev->buf_lock);
>   	if (rc < 0) {
>   		locality = rc;
>   		goto out;


    Stefan
