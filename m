Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858C3A164D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Jun 2021 15:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhFIOAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Jun 2021 10:00:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19438 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236026AbhFIOAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Jun 2021 10:00:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 159DWtOc099230;
        Wed, 9 Jun 2021 09:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7F5XgpdHg7PoJdEGJ6D1VJ40MLEN6ga0JvV+w+cmZ3E=;
 b=ocr1IO9fmK0WDD/DvEx439MH85WPVRW+2SGH7qipeCFAR+YSnNiA3BDIJdhBRsPEh0t5
 slctQ2ifOhnhrLCcrDG4IUpODQHNkxhl69wfjDQzhduvwhqTtOQKY2S8O/EywjidcgST
 6wg0zC7HA/9p9dZBjtQ2KO2Gs/YvzXed5C9Cqi8/ZuR3axe4/eVAsLEqCqE95j9+ysMD
 eIMikHSBwLVywiHHsWhe2RXVrd527im0RBwusmmBiYuyUNRW/u0QV0cZA+ybtaECwjTL
 wyuhSqDA1PAsOb0+1oLsfn8kHBM40miBqNxWbDbZpP9RCXmtDtxXakhhCql6PeApFYsa 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 392wf7kc1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 09:58:31 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 159DX6UY100477;
        Wed, 9 Jun 2021 09:58:31 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 392wf7kc18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 09:58:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 159DphYv026922;
        Wed, 9 Jun 2021 13:58:30 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3900w9qyhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Jun 2021 13:58:30 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 159DwTsu24576392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Jun 2021 13:58:29 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45EFC28060;
        Wed,  9 Jun 2021 13:58:29 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 333142805E;
        Wed,  9 Jun 2021 13:58:29 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jun 2021 13:58:29 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
 <20210603064738.pwfq3n7erzmncdmw@kernel.org>
 <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
 <20210609124412.engcrbo3fezuzyoq@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <f22e7ae1-8779-e995-091c-8a899fd7fd76@linux.ibm.com>
Date:   Wed, 9 Jun 2021 09:58:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609124412.engcrbo3fezuzyoq@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5LgGjKuEW1do5COhv5EcCp6l-WHyolUt
X-Proofpoint-GUID: Q4hJBdoqGgL2vbL4T3nGMiDlzJ5_oW3c
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-09_04:2021-06-04,2021-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090067
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/9/21 8:44 AM, Jarkko Sakkinen wrote:
> On Thu, Jun 03, 2021 at 08:32:59AM -0400, Stefan Berger wrote:
>> On 6/3/21 2:47 AM, Jarkko Sakkinen wrote:
>>>> -- 
>>>> 2.29.2
>>>>
>>>>
>>> Please instead send a fix.
>> We have a Fixes tag in 1/2, so we want this to propagate to older kernels
>> and need the fix in 1/2 for that reason.
>>
>>     Stefan
> So please do an additional fix and send it.

1/2 is supposed to propagate to older kernels and needs to change as 
posted here in v5 (assuming that this does indeed fix what the build bot 
was complaining about). 2/2 also changes. A fix on top of v4 would fix 
2/2 but won't apply cleanly to 1/2 as cannot easily propagate to older 
kernels. Is that what we want? Why can you not remove v4 from your queue 
and replace it with v5?

    Stefan


