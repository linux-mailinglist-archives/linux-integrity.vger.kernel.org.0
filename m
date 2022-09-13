Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28C85B788B
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Sep 2022 19:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbiIMRob (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiIMRoG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 13:44:06 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23037E317
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 09:38:53 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DGZxgU020447;
        Tue, 13 Sep 2022 16:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MUDduiZ2a7pbDqRAivUSUEu5aX947jXd5zYF8kGX+r8=;
 b=pBV+ZNlHR6w1Ko0a8qWFmlIpGj8oR6isHqcGIry2gENSATXI+cKQr+0lIDG6OsSEHboN
 jytx2wfncX3kpBaO8r8JPlnHP21KCUPsvjuC1Kt+uziQFfVRyXSeajm3XYQZWzwkhjhv
 Ru/PT9BxbPsr9dGmG6FQUFXBdibrkYf+JD5mZ8Ljh/ra5vEnZhRO3GVjbWTs+jfT3Ilh
 QcTNRTwQsulAdL3CrBRW4hawCRzDQQX/QCeVWPfYuz7q/KNmJ+WDhzKXdbEDNDdUi8op
 bwmy357VHfoGm2INo696ys049eL14uWj6cHjISiBULHb8D2NwiaJ/zhwq5eQE1T34Lv0 AQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jjvw8hfhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:38:48 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28DGZ7HV000625;
        Tue, 13 Sep 2022 16:38:47 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 3jgj79w6m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 16:38:47 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28DGck8d14353036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 16:38:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4503B2064;
        Tue, 13 Sep 2022 16:38:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C245B205F;
        Tue, 13 Sep 2022 16:38:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Sep 2022 16:38:46 +0000 (GMT)
Message-ID: <c7c0e63d-8c7f-2c75-9247-cc93758ce946@linux.ibm.com>
Date:   Tue, 13 Sep 2022 12:38:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v2 09/12] Fix potential use after free in
 read_tpm_banks()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
 <20220906195021.854090-10-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220906195021.854090-10-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BOwoS_K8pPra9agsvAiGxUK2Q5NCmVnk
X-Proofpoint-GUID: BOwoS_K8pPra9agsvAiGxUK2Q5NCmVnk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130075
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
> On failure to read TPM 2.0 bank PCRs 'errmsg' is not properly set to
> NULL after being freed.  Fix potential use after free.
> 
> Fixes: 3472f9ba9c05 ("ima-evm-utils: read the PCRs for the requested TPM banks")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   src/evmctl.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> index fa588e0caba2..a497b1a468d6 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -2075,6 +2075,7 @@ static int read_tpm_banks(int num_banks, struct tpm_bank_info *bank)
>   				log_debug("Failed to read %s PCRs: (%s)\n",
>   					  bank[i].algo_name, errmsg);
>   				free(errmsg);
> +				errmsg = NULL;
>   				bank[i].supported = 0;
>   			}
>   		}
