Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCCE36F0BB
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhD2UBw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 16:01:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49826 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236976AbhD2T7c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:59:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13TJYML2051623;
        Thu, 29 Apr 2021 15:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cTHSn9mcm/ljEngRcaJew6E8VNjq2HkqQCMZFWsUQww=;
 b=nKJHopUIWU7bcSb8DpsN8rySAFAsh2nZWRlY7wpgOnV/ZLUJmFxrP0G0GV8Uj76Fay9Q
 0FfSwoyA0wf2sBZ3I/M+IWEgo6xFgb9P+QyfGMzcWWCQ64wHzC3UNPlN59v1qnmOxvp6
 wmWFCvtmoID8LxxnOT5h+1lSxTPR/JsTe3nwr0zh4FJyWQ2jCNZB9NL0x+s0F+cLMNDh
 vNkU/dte5OdbQw5mF3XkxVIdCCUQpU/lecijSaiHRn1OxBM9BS4q8Bz6cBHsyMxUg9XU
 55edpPAFCl57EJlCJGIzc7Cy4HBABZZoGEzkLf1tDw+kyNPkThurDdvAE/6e5b+xG4T8 lA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3882h49e3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 15:58:44 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13TJrOQg027037;
        Thu, 29 Apr 2021 19:58:43 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 384aya8ajg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 19:58:43 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13TJwgJp48824736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 19:58:42 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754DE12405B;
        Thu, 29 Apr 2021 19:58:42 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63FBA124053;
        Thu, 29 Apr 2021 19:58:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 29 Apr 2021 19:58:42 +0000 (GMT)
Subject: Re: [PATCH] evm: fix writing <securityfs>/evm overflow
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210429195332.310697-1-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <74b7bec9-0c88-0b33-5f9f-b4d2a08105c8@linux.ibm.com>
Date:   Thu, 29 Apr 2021 15:58:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429195332.310697-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tK3glq9cmSUnESqODDv8aaVOpz143JOC
X-Proofpoint-ORIG-GUID: tK3glq9cmSUnESqODDv8aaVOpz143JOC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_10:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/29/21 3:53 PM, Mimi Zohar wrote:
> EVM_SETUP_COMPLETE is defined as 0x80000000, which is larger than INT_MAX.
> The "-fno-strict-overflow" compiler option properly prevents signaling
> EVM that the EVM policy setup is complete.  Define and read an unsigned
> int.
>
> Fixes: f00d79750712 ("EVM: Allow userspace to signal an RSA key has been
> loaded")
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>


Tested-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/integrity/evm/evm_secfs.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index bbc85637e18b..0007d3362754 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -66,12 +66,13 @@ static ssize_t evm_read_key(struct file *filp, char __user *buf,
>   static ssize_t evm_write_key(struct file *file, const char __user *buf,
>   			     size_t count, loff_t *ppos)
>   {
> -	int i, ret;
> +	unsigned int i;
> +	int ret;
>   
>   	if (!capable(CAP_SYS_ADMIN) || (evm_initialized & EVM_SETUP_COMPLETE))
>   		return -EPERM;
>   
> -	ret = kstrtoint_from_user(buf, count, 0, &i);
> +	ret = kstrtouint_from_user(buf, count, 0, &i);
>   
>   	if (ret)
>   		return ret;
