Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F064DDB01
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Mar 2022 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbiCRN4p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Mar 2022 09:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbiCRN4o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Mar 2022 09:56:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02152BC0A;
        Fri, 18 Mar 2022 06:55:25 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ICo0ba017692;
        Fri, 18 Mar 2022 13:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CmuugitCsiIoZdFvs0YMKZjL7JFiE8ieqimDY88vAAM=;
 b=f2H8e374dB1qrQ6+GMLWOu48Nr5hWvUDc5IvFZ3iEl6HXqqJbdEKz21//jv9v9npdBRU
 CH7i3oJWuuu/7D37uJL2KYPYPXJ6g13bXWINZysF8bftBXz5g7KCFjIydSS5qS4bC79Z
 HJG7rNaZsIC8D40iHkup3seBv6Ma7Ic/ECBheXi839YeK4yjstRKtmEG2GJ2TuyfH7k6
 uUArpOaCdyylb0m5WGgFTivYyM7RO/S9jMeea0DMaPud4zylR+ZM4Tq0/C/j6odZG71X
 cYxSPkan9Cic8aqVgs3ypc0twEe82E30IcNM/R3ibeTLxhqC3vH61I0CJ1VGx9WAibU1 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3evqgxcm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 13:54:49 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22IDsnAR030450;
        Fri, 18 Mar 2022 13:54:49 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3evqgxcm1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 13:54:49 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22IDs6CV014469;
        Fri, 18 Mar 2022 13:54:48 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02dal.us.ibm.com with ESMTP id 3etaj7haw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 13:54:47 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22IDskWX11796948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 13:54:46 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C3CF124058;
        Fri, 18 Mar 2022 13:54:46 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3ACE8124053;
        Fri, 18 Mar 2022 13:54:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 18 Mar 2022 13:54:46 +0000 (GMT)
Message-ID: <977ccc4b-3b30-f301-aa1c-ef2aaa32cacd@linux.ibm.com>
Date:   Fri, 18 Mar 2022 09:54:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH -next] tpm: ibmvtpm: Correct the return value in
 tpm_ibmvtpm_probe()
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, nayna@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220318060201.50488-1-xiujianfeng@huawei.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220318060201.50488-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YiSw2qE04a9iCtSMHbiVD-QtmStzjS0a
X-Proofpoint-GUID: 7roJ80YeYJkjO4nawRHHPK0oX9wDvdyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_10,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 3/18/22 02:02, Xiu Jianfeng wrote:
> Currently it returns zero when CRQ response timed out, it should return
> an error code instead.
> 
> Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index 3af4c07a9342..d3989b257f42 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -681,6 +681,7 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
>   				ibmvtpm->rtce_buf != NULL,
>   				HZ)) {
> +		rc = -ENODEV;
>   		dev_err(dev, "CRQ response timed out\n");
>   		goto init_irq_cleanup;
>   	}
