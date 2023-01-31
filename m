Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285DE6832DD
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 17:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjAaQi6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 11:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjAaQi5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 11:38:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D03134322;
        Tue, 31 Jan 2023 08:38:51 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VG07jq010844;
        Tue, 31 Jan 2023 16:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zvf+deCVx5QD9KjpIZetTtXafbdIx2dRn6YvQA0CD4k=;
 b=PaQfgQM0SWR9a9u2zV3vUmTj4vDkCQRgTwPYQJIpyEIR03U1b0LFdYh+L2RSTJhDPvoo
 s/tm80VJKSF1NUp37NBhlUVoGKWBXOWpvJCW0Nl8znISRbn0dPjtMCTvzSaL28bgSeDi
 BOdu+x5b4D1bv9c7krspSDqBKsy8ONeej7uUZDlvL9U5I5H2ONSBP4NuC+kdLzncH1j4
 lCaGFVemxrHFXKIGTLr+sTq2rQhW3yCk3P0PnJ5Wjtc5/Rk9aWFjTyNhEoZR4+J2Y8Zj
 5BdWkduDU6k2UufasbVmtu/33sWPJ9uwcpYyKCy9pdQVXir+Mhmv0SdIFpIlkjLOuRaI GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf5q6hw30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:38:41 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VGROmq011537;
        Tue, 31 Jan 2023 16:38:41 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf5q6hw2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:38:41 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VGPSf4008520;
        Tue, 31 Jan 2023 16:38:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([9.208.129.118])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3ncvw2n70d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 16:38:40 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VGcc6K54657330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 16:38:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D8F65805D;
        Tue, 31 Jan 2023 16:38:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 295645804C;
        Tue, 31 Jan 2023 16:38:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 16:38:37 +0000 (GMT)
Message-ID: <5c335c29-ecb6-70eb-ab8e-caadde774434@linux.ibm.com>
Date:   Tue, 31 Jan 2023 11:38:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 19/25] powerpc/pseries: Make caller pass buffer to
 plpks_read_var()
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-20-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-20-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n_MWN_nJpP-qAGLohHSUPG9fXBJ8ewas
X-Proofpoint-GUID: TpVGCzz5S1xPWjZ55-fm_uSuX62TOBt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1011 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> Currently, plpks_read_var() allocates a buffer to pass to the
> H_PKS_READ_OBJECT hcall, then allocates another buffer, of the caller's


-> buffer of the (no comma)

> preferred size if necessary, into which the data is copied, and returns
> that buffer to the caller.
> 
> This is a bit over the top - while we probably still want to allocate a
> separate buffer to pass to the hypervisor in the hcall, we can let the
> caller allocate the final buffer and specify the size.
> 
> Don't allocate var->data in plpks_read_var(), instead expect the caller to
> allocate it. If the caller needs to discover the size, it can set
> var->data to NULL and var->datalen will be populated. Update header file
> to document this.

It looks like there are no callers yet that would need to be adapted...

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> ---
> 
> v3: New patch (mpe)
> ---
>   arch/powerpc/include/asm/plpks.h       | 12 ++++++++++++
>   arch/powerpc/platforms/pseries/plpks.c | 11 ++++-------
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
> index e7204e6c0ca4..0c49969b0864 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -88,16 +88,28 @@ int plpks_remove_var(char *component, u8 varos,
>   
>   /**
>    * Returns the data for the specified os variable.
> + *
> + * Caller must allocate a buffer in var->data with length in var->datalen.
> + * If no buffer is provided, var->datalen will be populated with the object's
> + * size.
>    */
>   int plpks_read_os_var(struct plpks_var *var);
>   
>   /**
>    * Returns the data for the specified firmware variable.
> + *
> + * Caller must allocate a buffer in var->data with length in var->datalen.
> + * If no buffer is provided, var->datalen will be populated with the object's
> + * size.
>    */
>   int plpks_read_fw_var(struct plpks_var *var);
>   
>   /**
>    * Returns the data for the specified bootloader variable.
> + *
> + * Caller must allocate a buffer in var->data with length in var->datalen.
> + * If no buffer is provided, var->datalen will be populated with the object's
> + * size.
>    */
>   int plpks_read_bootloader_var(struct plpks_var *var);
>   
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index e5755443d4a4..926b6a927326 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -581,17 +581,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   		goto out_free_output;
>   	}
>   
> -	if (var->datalen == 0 || var->datalen > retbuf[0])
> +	if (!var->data || var->datalen > retbuf[0])
>   		var->datalen = retbuf[0];
>   
> -	var->data = kzalloc(var->datalen, GFP_KERNEL);
> -	if (!var->data) {
> -		rc = -ENOMEM;
> -		goto out_free_output;
> -	}
>   	var->policy = retbuf[1];
>   
> -	memcpy(var->data, output, var->datalen);
> +	if (var->data)
> +		memcpy(var->data, output, var->datalen);
> +
>   	rc = 0;
>   
>   out_free_output:
