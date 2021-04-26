Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8736B53B
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDZOu1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 10:50:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232575AbhDZOu1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 10:50:27 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QEZTZL045614;
        Mon, 26 Apr 2021 10:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zGhj9JvKd5x3VAGxIpu9PRHarCg8WLgKtWmiBWMu0aI=;
 b=Mj92BqtQGnpENud/nDwOnOw0dPh1dmwDkQmoJyT+PKwmVhdnKk/hrEOly1YjPv9Q6wkG
 XEhAHkvbHTFfq+Mrlh3GnVoVZ75zpgUtL3Uz3SJ7bVF+3Lq8MgrzwMLkoZ9PMtODZrcW
 v9h4AjedJ7NUmUJEe8aGbEFmWGnu07HbXEzts4sg7U4KZERBSiCYM1SxYUMjPUPHyHww
 gBT9zg0NrdYp763SQq99GChcmuiPJT19fUpLNZ5+TdhEeYNAh23BqhwMeKQgYEKNcnjm
 Xv+8nN5FJia/5qxVFxAHT8LRrhnoZ1NLavJDsmdyN4gc7aavUsSsycXQMVlzAIvgkKGQ Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 385xfbjta9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:49:39 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QEb7HF054945;
        Mon, 26 Apr 2021 10:49:39 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 385xfbjt9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:49:39 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QEl91A032425;
        Mon, 26 Apr 2021 14:49:38 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 384ay9ahsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 14:49:38 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QEnb6M26542538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 14:49:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4A32124054;
        Mon, 26 Apr 2021 14:49:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFA75124053;
        Mon, 26 Apr 2021 14:49:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 14:49:37 +0000 (GMT)
Subject: Re: [PATCH v2 3/4] tpm: Fix test for interrupts
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-4-git-send-email-LinoSanfilippo@gmx.de>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e0b34384-d286-2251-bc43-0ee3083672b3@linux.ibm.com>
Date:   Mon, 26 Apr 2021 10:49:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619394440-30646-4-git-send-email-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kGLv7o2Db2JHJ7TvS7XF93e-18ese7uH
X-Proofpoint-ORIG-GUID: 6KDvDYERFntmjYuYNF7OYh5I_d2O0vOl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104260114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/25/21 7:47 PM, Lino Sanfilippo wrote:
> The current test for functional interrupts is broken in multiple ways:
> 1. The needed flag TPM_CHIP_FLAG_IRQ is never set, so the test is never
> executed.
> 2. The test includes the check for two variables and the check is done for
> each transmission which is unnecessarily complicated.
> 3. Part of the test is setting a bool variable in an interrupt handler and
> then check the value in the main thread. However there is nothing that
> guarantees the visibility of the value set in the interrupt handler for
> any other thread. Some kind of synchronization primitive is required for
> this purpose.
>
> Fix all these issues by a reimplementation:
> Instead of doing the test in tpm_tis_send() which is called for each
> transmission do it only once in tpm_tis_probe_irq_single(). Furthermore
> use proper accessor functions like get_bit()/set_bit() which include the
> required synchronization primitives to guarantee visibility between the
> interrupt handler and threads.
> Finally remove one function which is no longer needed.
>
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
> ---
>   drivers/char/tpm/tpm_tis_core.c | 61 +++++++++++++----------------------------
>   drivers/char/tpm/tpm_tis_core.h |  1 -
>   include/linux/tpm.h             |  2 +-
>   3 files changed, 20 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index a95daf8..e8ab218 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -464,7 +464,7 @@ static void disable_interrupts(struct tpm_chip *chip)
>    * tpm.c can skip polling for the data to be available as the interrupt is
>    * waited for here
>    */
> -static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>   {
>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>   	int rc;
> @@ -497,29 +497,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>   	return rc;
>   }
>   
> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> -{
> -	int rc, irq;
> -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> -		return tpm_tis_send_main(chip, buf, len);
> -
> -	/* Verify receipt of the expected IRQ */
> -	irq = priv->irq;
> -	priv->irq = 0;
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> -	rc = tpm_tis_send_main(chip, buf, len);
> -	priv->irq = irq;
> -	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!priv->irq_tested)
> -		tpm_msleep(1);
> -	if (!priv->irq_tested)
> -		disable_interrupts(chip);
> -	priv->irq_tested = true;
> -	return rc;
> -}
> -
>   struct tis_vendor_durations_override {
>   	u32 did_vid;
>   	struct tpm1_version version;
> @@ -721,7 +698,8 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>   	if (interrupt == 0)
>   		return IRQ_NONE;
>   
> -	priv->irq_tested = true;
> +	set_bit(TPM_CHIP_FLAG_IRQ, &chip->flags);
> +
>   	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>   		wake_up_interruptible(&priv->read_queue);
>   	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> @@ -778,45 +756,44 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>   	}
>   	priv->irq = irq;
>   
> +	clear_bit(TPM_CHIP_FLAG_IRQ, &chip->flags);
> +
>   	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>   			   &original_int_vec);
>   	if (rc < 0)
> -		return rc;
> +		goto out;
>   
>   	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>   	if (rc < 0)
> -		return rc;
> +		goto out;
>   
>   	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
>   	if (rc < 0)
> -		return rc;
> +		goto out;
>   
>   	/* Clear all existing */
>   	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
>   	if (rc < 0)
> -		return rc;
> +		goto out;
>   
>   	/* Turn on */
>   	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>   			     intmask | TPM_GLOBAL_INT_ENABLE);
>   	if (rc < 0)
> -		return rc;
> -
> -	priv->irq_tested = false;
> +		goto out;
>   
> -	/* Generate an interrupt by having the core call through to
> -	 * tpm_tis_send
> -	 */
> +	/* Generate an interrupt by transmitting a command to the chip */
>   	rc = tpm_tis_gen_interrupt(chip);
>   	if (rc < 0)
> -		return rc;
> +		goto out;
> +
> +	tpm_msleep(1);
> +out:
> +	if (!test_bit(TPM_CHIP_FLAG_IRQ, &chip->flags)) {
> +		disable_interrupts(chip);
>   
> -	/* tpm_tis_send will either confirm the interrupt is working or it
> -	 * will call disable_irq which undoes all of the above.
> -	 */
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>   		rc = tpm_tis_write8(priv, original_int_vec,
> -				TPM_INT_VECTOR(priv->locality));
> +				    TPM_INT_VECTOR(priv->locality));
>   		if (rc < 0)
>   			return rc;
>   
> @@ -1083,7 +1060,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>   		if (irq) {
>   			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>   						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +			if (!test_bit(TPM_CHIP_FLAG_IRQ, &chip->flags)) {
>   				dev_err(&chip->dev, FW_BUG
>   					"TPM interrupt not working, polling instead\n");
>   
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 9b2d32a..dc5f92b 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,7 +89,6 @@ struct tpm_tis_data {
>   	u16 manufacturer_id;
>   	int locality;
>   	int irq;
> -	bool irq_tested;
>   	unsigned int flags;
>   	void __iomem *ilb_base_addr;
>   	u16 clkrun_enabled;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 55debe6..e9882acf 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -126,7 +126,7 @@ struct tpm_chip {
>   	struct tpm_chip_seqops bin_log_seqops;
>   	struct tpm_chip_seqops ascii_log_seqops;
>   
> -	unsigned int flags;
> +	unsigned long flags;


This doesn't seem to be necessary.

The rest looks good to me. I remember that last time I had tried to 
activate it some laptop didn't cooperate and we ended up reverting some 
code, but maybe your changes fixed all of that now. Though you may want 
to 'prepare for unforseen consequences' :-).


>   
>   	int dev_num;		/* /dev/tpm# */
>   	unsigned long is_open;	/* only one allowed */
