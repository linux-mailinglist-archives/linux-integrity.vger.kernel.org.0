Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932686F45D3
	for <lists+linux-integrity@lfdr.de>; Tue,  2 May 2023 16:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjEBOMo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 May 2023 10:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjEBOMn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 May 2023 10:12:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1411F;
        Tue,  2 May 2023 07:12:42 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342EAECv032013;
        Tue, 2 May 2023 14:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=8w0vL0uk3hny/UoO0YDKJJ3w0q+hKqHe7u8aUZFyTaA=;
 b=cQv9+1sMRJJzrJXcZY5EJDNE+I5P2U9J01otq8AqwQnIExC44PKh1i5Snynnaizmv+Vt
 hU7XjB4RfK60OYpZdh1GrEwgd1d4j1ofAMcaXfwAO+YPeY/sFkFzuXJDjMEALMwwoc+X
 NQ2Wege192ur++A6VI3Z7j40b2FboAK0F3G792KHojJMuRfRl7+Bw12jlwmd1Yckwj5N
 GBbkjwUVe/eqVoKsV9Ms5dDe8dQOojAxVz5hwOT+XWkH+AWPVBiFybe/H3HdT1qBQaWI
 PndVMhiaXicvLsTrljGHoP+kPhAGGlW9ROEICEbLStU3BFZzXZbxiVmxTbJ5RfzSf6dl 4g== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qb2gpuatd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:12:38 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 342ApniP011874;
        Tue, 2 May 2023 14:12:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3q8tv7qnwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 14:12:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 342ECaSP9503402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 May 2023 14:12:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E46058057;
        Tue,  2 May 2023 14:12:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1375458058;
        Tue,  2 May 2023 14:12:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  2 May 2023 14:12:35 +0000 (GMT)
Message-ID: <3c0aa078-82e2-ce06-31aa-5eb4a5e8aac9@linux.ibm.com>
Date:   Tue, 2 May 2023 10:12:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 07/13] tpm: export the context save and load commands
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <20230403214003.32093-8-James.Bottomley@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230403214003.32093-8-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SBOE_Z3QIr7AVf1EWgxf6tbJtGzTOU71
X-Proofpoint-ORIG-GUID: SBOE_Z3QIr7AVf1EWgxf6tbJtGzTOU71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
> The TPM2 session HMAC and encryption handling code needs to save and
> restore a single volatile context for the elliptic curve version of
> the NULL seed, so export the APIs which do this for internal use.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   drivers/char/tpm/tpm.h        | 4 ++++
>   drivers/char/tpm/tpm2-space.c | 8 ++++----
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 830014a26609..00a06e3ba892 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -310,6 +310,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
>   		      size_t *bufsiz);
>   int tpm_devs_add(struct tpm_chip *chip);
>   void tpm_devs_remove(struct tpm_chip *chip);
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset);
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle);
>   
>   void tpm_bios_log_setup(struct tpm_chip *chip);
>   void tpm_bios_log_teardown(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
> index ffb35f0154c1..d77ee4af9d65 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>   	kfree(space->session_buf);
>   }
>   
> -static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> -			     unsigned int *offset, u32 *handle)
> +int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
> +		      unsigned int *offset, u32 *handle)
>   {
>   	struct tpm_buf tbuf;
>   	struct tpm2_context *ctx;
> @@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
>   	return 0;
>   }
>   
> -static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> -			     unsigned int buf_size, unsigned int *offset)
> +int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
> +		      unsigned int buf_size, unsigned int *offset)
>   {
>   	struct tpm_buf tbuf;
>   	unsigned int body_size;
