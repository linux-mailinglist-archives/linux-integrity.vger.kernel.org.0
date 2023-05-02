Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924276F45CB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 16:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjEBOK3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbjEBOK2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 10:10:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706241BF0;
        Tue,  2 May 2023 07:10:27 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342E9PoS018355;
        Tue, 2 May 2023 14:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TB6cVXstdljYXyG7MEDWRgwi+KustyI0Tahzmz0P07g=;
 b=JIVSqsbCgtQh/X3axB4fNZeyY+DIi02TpL6pqGxKx4e5spMqVG4oW6UICVIDFA2OetZg
 Leit8GOAuabpDgCZRRmqMeXIk5XfHxDE2huJBOeLuLKMCbog0qKGSFYqbCWdsVfvWs1b
 d2qhtgbZ3P5uepNn4FcNCjz0GVWouzML3ASbz4oLyrEDuc46MFICuTFQneVa17DJWbMy
 lIFyoMViEXO2S7xVux5dQwM5fGu4BTRE7Ru5pPueiTxggOJd34yB8ohMt9j5xJJTWxP3
 q6zVHiQ9kOkqp1IBuD7ALlSQ40o1z5nNctI4gBfDAtQf8hK3MPZqc6stH1RDI42BAsTx oQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb3us87x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:10:20 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342BAY5Z025448;
        Tue, 2 May 2023 14:09:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv7fq2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:09:59 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342E9whj15598316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 14:09:58 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5995805D;
        Tue,  2 May 2023 14:09:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD84A58058;
        Tue,  2 May 2023 14:09:57 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 14:09:57 +0000 (GMT)
Message-ID: <d5c86f6f-6854-c649-d2a9-8090cc7d74cd@linux.ibm.com>
Date:   Tue, 2 May 2023 10:09:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 06/13] tpm: add buffer function to point to returned
 parameters
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230403214003.32093-7-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6gDkX6Bgbcxt90pX5W3GNl__Rnxupwv0
X-Proofpoint-ORIG-GUID: 6gDkX6Bgbcxt90pX5W3GNl__Rnxupwv0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020119
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
> Introducing encryption sessions changes where the return parameters
> are located in the buffer because if a return session is present
> they're 4 bytes beyond the header with those 4 bytes showing the
> parameter length.  If there is no return session, then they're in the
> usual place immediately after the header.  The tpm_buf_parameters()
> encapsulates this calculation and should be used everywhere
> &buf.data[TPM_HEADER_SIZE] is used now.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> ---
> v4: add kdoc
> ---
>   drivers/char/tpm/tpm-buf.c | 27 +++++++++++++++++++++++++++
>   include/linux/tpm.h        |  2 ++
>   2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index da0f6e725c3f..d107321bcdff 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -277,3 +277,30 @@ u32 tpm_get_inc_u32(const u8 **ptr)
>   	return val;
>   }
>   EXPORT_SYMBOL_GPL(tpm_get_inc_u32);
> +
> +static u16 tpm_buf_tag(struct tpm_buf *buf)
> +{
> +	struct tpm_header *head = (struct tpm_header *)buf->data;
> +
> +	return be16_to_cpu(head->tag);
> +}
> +
> +/**
> + * tpm_buf_parameters - return the parameters area of the tpm_buf

in a TPM response


> + * @buf: tpm_buf to use
> + *
> + * Where the parameters are located depends on the tag of a TPM
> + * command. Evaluate this and return a pointer to the first byte of
> + * the parameters area.

I would also describe here what the non-obvious 4 bytes are that you are skipping over in case of TPM2_ST_SESSIONS.

With this:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> + *
> + * @return: pointer to parameters area
> + */
> +u8 *tpm_buf_parameters(struct tpm_buf *buf)
> +{
> +	int offset = TPM_HEADER_SIZE;
> +
> +	if (tpm_buf_tag(buf) == TPM2_ST_SESSIONS)
> +		offset += 4;
> +
> +	return &buf->data[offset];
> +}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 845eadfed715..d2fea2afd37c 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -340,6 +340,8 @@ u8 tpm_get_inc_u8(const u8 **ptr);
>   u16 tpm_get_inc_u16(const u8 **ptr);
>   u32 tpm_get_inc_u32(const u8 **ptr);
>   
> +u8 *tpm_buf_parameters(struct tpm_buf *buf);
> +
>   /*
>    * Check if TPM device is in the firmware upgrade mode.
>    */
