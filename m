Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4C96928A3
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 21:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjBJUsM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 15:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjBJUsL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 15:48:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C082D7E8FE;
        Fri, 10 Feb 2023 12:48:10 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AKfscG011674;
        Fri, 10 Feb 2023 20:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OpJ4BQf1QshNW5ZwMAsFPoYyCV4Jhxu7bKMqBOdChGc=;
 b=UNq5827zOEuFEOQLIqIM8SmiDM65QmOZLhSOWBBhMm13LWbYYFD0sJqTXaCaIgV3M7nW
 X3GpBM/KEbSryrHFD2BHnsaGQ2S3UW2RMJZObXhjr/fcQekpxiGk8ZfTLZNNN5LH8H3P
 gYvcGfJ6kQ/TI4pyOenvo4vXOaoUHrI82A8GKloujSOwXI6oT38jEFEhpTiq/QkMpVSI
 xbUfqkJZkzpbn25+4y3LnZKr2CFYtUkTwIkmQdLBsvBPySnaauxsos1RT3SJsvSNTrJI
 U6bAtWqcoj5eoSrp/R6M1ATwb3FchiOztX3VP5leahIg7hPema8W+3RwHsyQFrxVGjpr PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnw6e03c3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:48:00 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31AKhUiC015039;
        Fri, 10 Feb 2023 20:47:59 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnw6e03br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:47:59 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31AJZYJB003972;
        Fri, 10 Feb 2023 20:47:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([9.208.130.98])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07rr6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 20:47:58 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31AKlvlu5636842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 20:47:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418E858058;
        Fri, 10 Feb 2023 20:47:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18FD358057;
        Fri, 10 Feb 2023 20:47:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 20:47:56 +0000 (GMT)
Message-ID: <0e5f3dcd-ac0a-902e-f9fb-b2178cd17a99@linux.ibm.com>
Date:   Fri, 10 Feb 2023 15:47:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 21/26] powerpc/pseries: Clarify warning when PLPKS
 password already set
Content-Language: en-US
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     ruscur@russell.cc, bgray@linux.ibm.com, nayna@linux.ibm.com,
        gcwilson@linux.ibm.com, gjoyce@linux.ibm.com, brking@linux.ibm.com,
        sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        zohar@linux.ibm.com, joel@jms.id.au, npiggin@gmail.com
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-22-ajd@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230210080401.345462-22-ajd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aKWAZVtu02eUiAsbMMi8xnf6-giGWNAv
X-Proofpoint-ORIG-GUID: 9T8D2ZYHTamA-tajnW6YfTrHshQzkkz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100175
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/10/23 03:03, Andrew Donnellan wrote:
> When the H_PKS_GEN_PASSWORD hcall returns H_IN_USE, operations that require
> authentication (i.e. anything other than reading a world-readable variable)
> will not work.
> 
> The current error message doesn't explain this clearly enough. Reword it
> to emphasise that authenticated operations will fail.

typo: -> emphasize

> 
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> 
> ---
> 
> v6: New patch
> ---
>   arch/powerpc/platforms/pseries/plpks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 926b6a927326..01ae919b4497 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -146,7 +146,7 @@ static int plpks_gen_password(void)
>   		memcpy(ospassword, password, ospasswordlength);
>   	} else {
>   		if (rc == H_IN_USE) {
> -			pr_warn("Password is already set for POWER LPAR Platform KeyStore\n");
> +			pr_warn("Password already set - authenticated operations will fail\n");
>   			rc = 0;
>   		} else {
>   			goto out;

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
