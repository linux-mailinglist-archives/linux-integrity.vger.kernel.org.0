Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703EF6F4597
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 15:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjEBNy2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbjEBNy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 09:54:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738BC10F;
        Tue,  2 May 2023 06:54:25 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342DoHtt021609;
        Tue, 2 May 2023 13:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cvllQzMcvyVdB1748SPJ132a8/52kJKqiRNKcVs79TI=;
 b=BvBylGU4sV1RSXNZrpc3CWgx+A0pspv5ERZuGzBYKndPYo+8yeqO88UQvrbm0KSAI7r5
 nz4lfwVfFNWOoaWSCHP52IOKsCDJw7l290m45cqJt6nFJ8hjeJBx5WJMJkFEGF6mBKW7
 4ILQWSvT5znxZXry02Y9Dr090u2AbLIUS8waCPtCggw/lSlLlvCeoLkV2USbrBOoNWNf
 3XSJndp+ukjEo2OVp9NZk1IKnApt4FcBBV0ibrAf4bTg8yJ/ujkzIHVcMidgHp0wqJw8
 lP1ddCEw4sBGe7yTO57wwYQ+mvoDFrRJcpzN6vzJf+xpWMzM0ympMsbq5NnKg/U8Sv0a vw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb2s3ajn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:54:20 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342DBvK2009972;
        Tue, 2 May 2023 13:54:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3q8tv7ufv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:54:19 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342DsHnl9044704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 13:54:18 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE3435805F;
        Tue,  2 May 2023 13:54:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FBCC58053;
        Tue,  2 May 2023 13:54:17 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 13:54:17 +0000 (GMT)
Message-ID: <0b84259f-627d-c5b3-45ec-8eac8c877a54@linux.ibm.com>
Date:   Tue, 2 May 2023 09:54:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 05/13] tpm: add cursor based buffer functions for
 response parsing
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230403214003.32093-6-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F9yaZTNvsVVgNpqIwvqzGw09-qojjFA5
X-Proofpoint-GUID: F9yaZTNvsVVgNpqIwvqzGw09-qojjFA5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2305020115
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 4/3/23 17:39, James Bottomley wrote:
> Extracting values from returned TPM buffers can be hard.  Add cursor
> based (moving poiner) functions that make it easier to extract TPM

s/poiner/pointer

> returned values from a buffer.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> ---
> v4: add kernel doc and reword commit
> ---
>   drivers/char/tpm/tpm-buf.c | 48 ++++++++++++++++++++++++++++++++++++++
>   include/linux/tpm.h        |  3 +++
>   2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index b7e42fb6266c..da0f6e725c3f 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -6,6 +6,8 @@
>   #include <linux/module.h>
>   #include <linux/tpm.h>
>   
> +#include <asm/unaligned.h>
> +
>   static int __tpm_buf_init(struct tpm_buf *buf)
>   {
>   	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
> @@ -229,3 +231,49 @@ void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
>   	tpm_buf_reset_int(tpm2b);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> +
> +/* functions for unmarshalling data and moving the cursor */
> +
> +/**
> + * tpm_get_inc_u8 - read a u8 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read
> + */
> +u8 tpm_get_inc_u8(const u8 **ptr)
> +{
> +	return *((*ptr)++);
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u8);
> +
> +/**
> + * tpm_get_inc_u16 - read a u16 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read (converted from big endian)
> + */
> +u16 tpm_get_inc_u16(const u8 **ptr)
> +{
> +	u16 val;
> +
> +	val = get_unaligned_be16(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u16);
> +
> +/**
> + * tpm_get_inc_u32 - read a u32 and move pointer beyond it
> + * @ptr: pointer to pointer
> + *
> + * @return: value read (converted from big endian)
> + */
> +u32 tpm_get_inc_u32(const u8 **ptr)
> +{
> +	u32 val;
> +
> +	val = get_unaligned_be32(*ptr);
> +	*ptr += sizeof(val);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 76d495cb5b08..845eadfed715 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -336,6 +336,9 @@ void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>   void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>   void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
>   void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
> +u8 tpm_get_inc_u8(const u8 **ptr);
> +u16 tpm_get_inc_u16(const u8 **ptr);
> +u32 tpm_get_inc_u32(const u8 **ptr);
>   
>   /*
>    * Check if TPM device is in the firmware upgrade mode.
