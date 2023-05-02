Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA86F4788
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 17:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjEBPnw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 11:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjEBPnu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 11:43:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E5E1FEA;
        Tue,  2 May 2023 08:43:47 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342Ff8sI010979;
        Tue, 2 May 2023 15:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zbVb7OSPkjyMOYXATIAVAjLHnP/0e1gZSb08zT869Uk=;
 b=cGY81GRZ/GFbiFjyvxCw9acKOH8FOnHM3+oEGMWkh3WyBDlTffvpteJQvwlBoW0IYrLG
 U1YFg3vmsLOd05VOCPUPrO6/9kea8hb/v9xj3x0YES+1e6ifPcaVDqJNSXx/32pvJf++
 l6/+0BcAItlMLIjt9SCkGDifBfybQ2Njimud176t5PlpXhjirxxE0jtYqiwnTTJMLYl3
 GSxu7ShHEFQnEiHhsVHDlA02KUyEYbJlcPyQKuL1i6DQtsniN8xXQPnnlhdLHDLuQ3D9
 rYgSndRce8TPXV5gThRLiR9WSyXd/QlBWtE9fn68jiPf2UyKQU+iLf4YNmhi3KpLBmEA Ow== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb5660aj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 15:43:43 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342Emsw3004359;
        Tue, 2 May 2023 15:43:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv8833g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 15:43:41 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342Fhehm17039670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 15:43:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83DD15805C;
        Tue,  2 May 2023 15:43:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2162D5805A;
        Tue,  2 May 2023 15:43:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 15:43:40 +0000 (GMT)
Message-ID: <ebfdf8fc-2253-b8a7-b403-29a5916db2f2@linux.ibm.com>
Date:   Tue, 2 May 2023 11:43:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 04/13] tpm: add buffer handling for TPM2B types
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230403214003.32093-5-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UhHTgfuT3UHV8_AFUE7b_Dh4BdbEgF1R
X-Proofpoint-ORIG-GUID: UhHTgfuT3UHV8_AFUE7b_Dh4BdbEgF1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_10,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=681 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020133
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
> Most complex TPM commands require appending TPM2B buffers to the
> command body.  TPM2B types are variable size arrays, making it
> difficult to represent them as structures.  Introduce primitives to
> build them up using in place buffer append operations.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> v4: add kernel doc
> ---
>   drivers/char/tpm/tpm-buf.c | 109 ++++++++++++++++++++++++++++++++-----
>   include/linux/tpm.h        |   3 +
>   2 files changed, 97 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index 3351db515e6b..b7e42fb6266c 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -6,27 +6,16 @@
>   #include <linux/module.h>
>   #include <linux/tpm.h>
>   
> -/**
> - * tpm_buf_init - initialize a TPM command buffer
> - * @buf: pointer to a tpm_buf structure (usually on stack)
> - * @tag: command tag
> - * @ordinal: command ordinal
> - *
> - * Allocates a 4k buffer to hold the command structure.
> - *
> - * @return: 0 on success or -ENOMEM
> - */
> -int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +static int __tpm_buf_init(struct tpm_buf *buf)
>   {
>   	buf->data = (u8 *)__get_free_page(GFP_KERNEL);
>   	if (!buf->data)
>   		return -ENOMEM;
>   
>   	buf->flags = 0;
> -	tpm_buf_reset(buf, tag, ordinal);
> +
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(tpm_buf_init);
>   
>   /**
>    * tpm_buf_reset - reset an initialized TPM command buffer
> @@ -48,6 +37,58 @@ void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal)
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_reset);
>   
> +/**
> + * tpm_buf_init - initialize a TPM command buffer
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + * @tag: command tag
> + * @ordinal: command ordinal
> + *
> + * Allocates a 4k buffer to hold the command structure.
> + *
> + * @return: 0 on success or -ENOMEM
> + */
> +int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal)
> +{
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	tpm_buf_reset(buf, tag, ordinal);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init);
> +
> +/**
> + * tpm_buf_init_2b - initialize a TPM command buffer for 2B data
> + * @buf: pointer to a tpm_buf structure (usually on stack)
> + *
> + * TPM commands are often composed of sets of TPM2B data.  This
> + * function initializes a tpm_buf (@buf) as a holder of TPM2B data,
> + * which allows all the current tpm2_buf_appendX functions to work on it.
> + *
> + * @return: 0 on success or -ENOMEM
> + */
> +int tpm_buf_init_2b(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head;
> +	int rc;
> +
> +	rc = __tpm_buf_init(buf);
> +	if (rc)
> +		return rc;
> +
> +	head = (struct tpm_header *) buf->data;
> +
> +	head->length = cpu_to_be32(sizeof(*head));


just tpm_buf_init(buf) and then set the flag below?


> +
> +	buf->flags = TPM_BUF_2B;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_init_2b);
> +
>   /**
>    * tpm_buf_destroy - destroy an initialized TPM command buffer
>    * @buf: pointer to a tpm_buf structure (usually on stack)
> @@ -60,6 +101,13 @@ void tpm_buf_destroy(struct tpm_buf *buf)
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>   
> +static void *tpm_buf_data(struct tpm_buf *buf)
> +{
> +	if (buf->flags & TPM_BUF_2B)
> +		return buf->data + TPM_HEADER_SIZE;
> +	return buf->data;
> +}
> +
>   /**
>    * tpm_buf_length - get the current length of a TPM command
>    * @buf: pointer to a tpm_buf structure (usually on stack)
> @@ -69,8 +117,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_destroy);
>   u32 tpm_buf_length(struct tpm_buf *buf)
>   {
>   	struct tpm_header *head = (struct tpm_header *)buf->data;
> +	u32 len;
>   
> -	return be32_to_cpu(head->length);
> +	len = be32_to_cpu(head->length);
> +	if (buf->flags & TPM_BUF_2B)
> +		len -= sizeof(*head);
> +	return len;
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_length);
>   
> @@ -88,7 +140,7 @@ void tpm_buf_append(struct tpm_buf *buf,
>   		    unsigned int new_len)
>   {
>   	struct tpm_header *head = (struct tpm_header *) buf->data;
> -	u32 len = tpm_buf_length(buf);
> +	u32 len = be32_to_cpu(head->length);
>   
>   	/* Return silently if overflow has already happened. */
>   	if (buf->flags & TPM_BUF_OVERFLOW)
> @@ -150,3 +202,30 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value)
>   	tpm_buf_append(buf, (u8 *) &value2, 4);
>   }
>   EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> +
> +static void tpm_buf_reset_int(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head;
> +
> +	head = (struct tpm_header *)buf->data;
> +	head->length = cpu_to_be32(sizeof(*head));

tpm_buf_reset(buf, 0, 0);

in tpm_buf_reset() it seem there should be this:

buf->flags &= ~TPM_BUF_OVERFLOW;

> +}
> +
> +/**
> + * tpm_buf_append_2b - append TPM2B data to an initialized TPM command buffer
> + * @tpm2b: pointer to a tpm_buf structure containing the TPM2B data.
> + *
> + * Appends @tpm2b as a correct TPM2B structure (big endian short
> + * length) followed by data of that length.  @tpm2b is then emptied to
> + * allow reuse.
> + */
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b)
> +{
> +	u16 len = tpm_buf_length(tpm2b);
> +

if (tpm2b->flags & TPM_BUF_OVERFLOW) {
     buf->flags |= TPM_BUF_OVERFLOW;
     return;
}

> +	tpm_buf_append_u16(buf, len);
> +	tpm_buf_append(buf, tpm_buf_data(tpm2b), len);


> +	/* clear the buf for reuse */
> +	tpm_buf_reset_int(tpm2b);
> +}
> +EXPORT_SYMBOL_GPL(tpm_buf_append_2b);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 9c9b5760b412..76d495cb5b08 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -301,6 +301,7 @@ struct tpm_header {
>   
>   enum tpm_buf_flags {
>   	TPM_BUF_OVERFLOW	= BIT(0),
> +	TPM_BUF_2B		= BIT(1),
>   };
>   
>   struct tpm_buf {
> @@ -325,6 +326,7 @@ struct tpm2_hash {
>   
>   
>   int tpm_buf_init(struct tpm_buf *buf, u16 tag, u32 ordinal);
> +int tpm_buf_init_2b(struct tpm_buf *buf);
>   void tpm_buf_reset(struct tpm_buf *buf, u16 tag, u32 ordinal);
>   void tpm_buf_destroy(struct tpm_buf *buf);
>   u32 tpm_buf_length(struct tpm_buf *buf);
> @@ -333,6 +335,7 @@ void tpm_buf_append(struct tpm_buf *buf, const unsigned char *new_data,
>   void tpm_buf_append_u8(struct tpm_buf *buf, const u8 value);
>   void tpm_buf_append_u16(struct tpm_buf *buf, const u16 value);
>   void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
> +void tpm_buf_append_2b(struct tpm_buf *buf, struct tpm_buf *tpm2b);
>   
>   /*
>    * Check if TPM device is in the firmware upgrade mode.
