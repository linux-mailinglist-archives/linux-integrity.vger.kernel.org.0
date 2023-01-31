Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFE6831F1
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjAaP5R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 10:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjAaP5P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 10:57:15 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD344523E;
        Tue, 31 Jan 2023 07:57:14 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VFlOFx014490;
        Tue, 31 Jan 2023 15:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JzOiYBYnTi4utjlO+k5Y6EiOHkGkFIufn8I3QJSouAg=;
 b=DqiUdnYzwtBwNm6AFXte5T4ozexfjK1OgMbxfyAXgczp2gMYet6aWKEOcenRH47cDvKL
 mAoJsxiHMDDpzRXLKD8U1P1PPFGpy9IONC0CReJS7XRFpIU77M52OV80ACQnwlFTH/hM
 LegIPyfKK85Gm8t45dKnKDbVqnf+t9WTWujreBf2tkTCUkaO6MSvCvF6YlUkG5f4R+su
 R+CuiUEMrlMdDTl37yM1JiTq7xw6VWNHz8chLDlKqiletitPH8mMpk+9Ma6q3JfuB4JG
 yrbx7AoiQeEhm3B8sU6UL0NbVspgKLUm9tFBoPZTo4yRorjKGQlv4ga+dBYaEL9Fi4/g 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf5x686uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:57:06 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VFo6Yk024556;
        Tue, 31 Jan 2023 15:57:05 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf5x686tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:57:05 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VEo9iZ008305;
        Tue, 31 Jan 2023 15:57:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3ncvtertx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 15:57:04 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VFv3cT10093160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 15:57:03 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB84C5803F;
        Tue, 31 Jan 2023 15:57:02 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57B2958054;
        Tue, 31 Jan 2023 15:57:01 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 15:57:01 +0000 (GMT)
Message-ID: <bb580e9e-80bc-dca4-33b7-a68b04bd2e65@linux.ibm.com>
Date:   Tue, 31 Jan 2023 10:57:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 12/25] powerpc/secvar: Warn when PAGE_SIZE is smaller
 than max object size
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230131063928.388035-1-ajd@linux.ibm.com>
 <20230131063928.388035-13-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230131063928.388035-13-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XfXMZQCx1pEu-qW2HkXMQAzZH6yumG1M
X-Proofpoint-ORIG-GUID: 9MWw3Z_t3iWZAJBl4WSFHKgI276e4f8x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/31/23 01:39, Andrew Donnellan wrote:
> Due to sysfs constraints, when writing to a variable, we can only handle
> writes of up to PAGE_SIZE.
> 
> It's possible that the maximum object size is larger than PAGE_SIZE, in
> which case, print a warning on boot so that the user is aware.
> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> 
> ---
> 
> v3: New patch (ajd)
> ---
>   arch/powerpc/kernel/secvar-sysfs.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/secvar-sysfs.c b/arch/powerpc/kernel/secvar-sysfs.c
> index 2cbc60b37e4e..9b6be63b7b36 100644
> --- a/arch/powerpc/kernel/secvar-sysfs.c
> +++ b/arch/powerpc/kernel/secvar-sysfs.c
> @@ -223,6 +223,7 @@ static int secvar_sysfs_load_static(void)
>   
>   static int secvar_sysfs_init(void)
>   {
> +	u64 max_size;
>   	int rc;
>   
>   	if (!secvar_ops) {
> @@ -272,6 +273,14 @@ static int secvar_sysfs_init(void)
>   		goto err;
>   	}
>   
> +	// Due to sysfs limitations, we will only ever get a write buffer of
> +	// up to 1 page in size. Print a warning if this is potentially going
> +	// to cause problems, so that the user is aware.
> +	secvar_ops->max_size(&max_size);
> +	if (max_size > PAGE_SIZE)
> +		pr_warn_ratelimited("PAGE_SIZE (%lu) is smaller than maximum object size (%llu), writes are limited to PAGE_SIZE\n",
> +				    PAGE_SIZE, max_size);
> +
>   	return 0;
>   err:
>   	kobject_put(secvar_kobj);

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
