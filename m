Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81F05AB972
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 22:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIBUYr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 16:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiIBUYc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 16:24:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177966561
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 13:24:28 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282IKuEO029984;
        Fri, 2 Sep 2022 20:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2mwhaQBCYlKoJgdSLJOv8dPK5ZYIpGNZnjKoE7HuI18=;
 b=l7rGbsy6t+9mhYfzcaYtnrPuD/EGvFTsK/V50eab36GrmpfBJfXNsh8V9hLeArZ3EqQq
 JwI2jKz8KUS3bjHPWFe7r2cWGVY2IZ+17/ks1RaVwHtwaySuB0JxXqrAlR1joZWM+xKO
 gKk8pS+tGK1T2c1D0eCYr9IRUOGWBy4zKTtx/0loTReot6f89h3VNAunEM9gVbZ1wbDR
 U0hPRLO6hVp2jNKSqHZC2TK8HTo9Yc8gSQWzIhmDBbC2HPgEeiPVKfopBkL05cHwqGRr
 mdsn3RQ6h5BV/ZuYLY/NTy6xIxhLr9Ow8/3c0jqYMLEgssrFRyYn2CR/MfeyykSbM6eH cA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbq1hjr8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 20:24:23 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282KL89I021685;
        Fri, 2 Sep 2022 20:24:22 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 3j7awamjxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 20:24:22 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282KOL0S4588104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 20:24:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36884B2064;
        Fri,  2 Sep 2022 20:24:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 170ADB205F;
        Fri,  2 Sep 2022 20:24:21 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  2 Sep 2022 20:24:21 +0000 (GMT)
Message-ID: <4e531d80-0df0-8f1a-6897-7e82a899ad9f@linux.ibm.com>
Date:   Fri, 2 Sep 2022 16:24:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils 02/11] travis: update dist=focal
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
 <20220902162836.554839-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220902162836.554839-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3-RW06dW9RP4H3VUQedxzhFn1Pzy7fB2
X-Proofpoint-GUID: 3-RW06dW9RP4H3VUQedxzhFn1Pzy7fB2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_04,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209020089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/2/22 12:28, Mimi Zohar wrote:
> Although Github Actions is available on Github Enterprise Server 3.x
> single server edition, as well as the unpaid version, it is not
> available in Github Enterprise Server 3.x cluster edition[1].  Continue
> to support travis.

This text really has nothing obvious to do with the upgrade to focal...

> 
> [1] https://docs.github.com/en/enterprise-server@3.0/admin/release-notes#github-packages
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   .travis.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index b18c871be200..cc76c0adb312 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -1,6 +1,6 @@
>   # Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
>   
> -dist: bionic
> +dist: focal
>   language: C
>   services:
>       - docker
