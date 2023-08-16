Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A077E3ED
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Aug 2023 16:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbjHPOl6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Aug 2023 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343735AbjHPOlj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Aug 2023 10:41:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1640526BD;
        Wed, 16 Aug 2023 07:41:38 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GEdUBS020303;
        Wed, 16 Aug 2023 14:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d10kSWhL6a8/trSLqSkrLJS5o8PzuKnPfUHn1MnoOJY=;
 b=WOkWZe9c9ob2AOrf65/qQW4KGZfPTD9N9bc03NvEcePyDdgRaoaAqCRvaJIYpuW2GHnm
 dQoqjYUNJOUHrCByjec4WG6MUx3PZpM2626LHmxrMRdYvrfL/MTji3HY7i4qr6Jk5cIZ
 xNbgIyUnL1bA0HusKX94T0PZrkuO1W/mT702xagrWxqIeJ/IAolgidz9lyCar455czti
 HwWwnbSyj5QC2NZ0EgQTNYm7eUXrk/bg/vTtD1b+T0HF42HWFHGrS3ARCFgKhJ1b8eWR
 FCn/rhRPc0SuJCLigeqF0giWNSOGbaWS2iErOXSxO6Mwrcp5OPQFwDeF3fQe5S0NU5H/ Sw== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sgy4utdb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:41:27 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37GDebFG013323;
        Wed, 16 Aug 2023 14:41:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sepmjvwn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 14:41:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37GEfLV732834032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Aug 2023 14:41:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 106D52004E;
        Wed, 16 Aug 2023 14:41:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 567DB20040;
        Wed, 16 Aug 2023 14:41:19 +0000 (GMT)
Received: from [9.43.32.205] (unknown [9.43.32.205])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Aug 2023 14:41:19 +0000 (GMT)
Message-ID: <f72a385f-b7aa-9c73-057d-0bfb8cd413dc@linux.ibm.com>
Date:   Wed, 16 Aug 2023 20:11:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 3/6] integrity: remove global variable from
 machine_keyring.c
Content-Language: en-US
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-security-module@vger.kernel.org, inux-kernel@vger.kernel.org
References: <20230815112722.1591829-1-nayna@linux.ibm.com>
 <20230815112722.1591829-4-nayna@linux.ibm.com>
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230815112722.1591829-4-nayna@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6pV1pdOXkdp4yJhRbFFCWp3uGonO3NqD
X-Proofpoint-ORIG-GUID: 6pV1pdOXkdp4yJhRbFFCWp3uGonO3NqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_14,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 mlxscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160125
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 15/08/23 4:57 pm, Nayna Jain wrote:
> trust_mok variable is accessed within a single function locally.
> 
> Change trust_mok from global to local static variable.
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-and-tested-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


Tested with trustedcadb, moduledb scenarios
Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

> ---
>   security/integrity/platform_certs/machine_keyring.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/platform_certs/machine_keyring.c b/security/integrity/platform_certs/machine_keyring.c
> index 389a6e7c9245..9482e16cb2ca 100644
> --- a/security/integrity/platform_certs/machine_keyring.c
> +++ b/security/integrity/platform_certs/machine_keyring.c
> @@ -8,8 +8,6 @@
>   #include <linux/efi.h>
>   #include "../integrity.h"
>   
> -static bool trust_mok;
> -
>   static __init int machine_keyring_init(void)
>   {
>   	int rc;
> @@ -65,9 +63,11 @@ static __init bool uefi_check_trust_mok_keys(void)
>   bool __init trust_moklist(void)
>   {
>   	static bool initialized;
> +	static bool trust_mok;
>   
>   	if (!initialized) {
>   		initialized = true;
> +		trust_mok = false;
>   
>   		if (uefi_check_trust_mok_keys())
>   			trust_mok = true;

-- 
Thanks and Regards
R.Nageswara Sastry
