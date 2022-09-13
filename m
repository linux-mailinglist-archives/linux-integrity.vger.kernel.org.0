Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACE5B7885
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiIMRoo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiIMRoT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:44:19 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDAD4B0FA
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 09:39:49 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DFgnCJ024676;
        Tue, 13 Sep 2022 16:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=br7ggBZXnEK8/Kdm/9g71knwG0rMLFiNTJb9+ud4DvY=;
 b=fWWYlmb4nLZvWE8Wtz//pAGIlbWajM8tj1SqRGBzvdrxZ8ioO7vV7saqU9RdvLGMmwS1
 vE6J93DehKy4N03O94yai/YgJNAJOWEKYvZvdF0DJN1fsE8uteFLMi5xwiCxuqd5T3Xl
 RK5cXk9En70wLwFhavmxuUKJy5GDM937L/H+GZ7JI9I2aLtZCLXvm3QiLw0LARcGUoG8
 B6bSI/B9RqAUvycJgJBA8ae54PCz/6tFnGTu3MdJrEz3yEFCPmTnnGps/HiEOmKRHG2H
 WhRdfbNBEfunl494XtgkRxm8UC2aMolrbNEeOLr+4BhDhBELTnldbS6/o4iDf/naWxXI Iw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjvarkhuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:39:44 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DGageq003542;
        Tue, 13 Sep 2022 16:39:43 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 3jgj79tfgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:39:43 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DGdgbr11797450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:39:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80425B2064;
        Tue, 13 Sep 2022 16:39:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BDF8B205F;
        Tue, 13 Sep 2022 16:39:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 16:39:42 +0000 (GMT)
Message-ID: <220ce9c4-2f3a-215d-024a-b5ef332e2bdb@linux.ibm.com>
Date:   Tue, 13 Sep 2022 12:39:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 02/12] travis: update dist=focal
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-3-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 76gGn_G4hRc5BkC8TWNm-V9mMSH3DX_G
X-Proofpoint-ORIG-GUID: 76gGn_G4hRc5BkC8TWNm-V9mMSH3DX_G
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209130075
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 9/6/22 15:50, Mimi Zohar wrote:
> Although Github Actions is available on Github Enterprise Server 3.x
> single server edition, as well as the unpaid version, it is not
> available in Github Enterprise Server 3.x cluster edition[1].
> 
> Continue updating travis.yml.
> 
> [1] https://docs.github.com/en/enterprise-server@3.0/admin/release-notes#github-packages
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
