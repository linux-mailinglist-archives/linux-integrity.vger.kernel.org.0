Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0F13B8063
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhF3JxP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 05:53:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43354 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhF3JxO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 05:53:14 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9kqik008746;
        Wed, 30 Jun 2021 09:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Z6HSfD0A/U5It2umTSol8i5rt1uWyK0aoN5QPST7Rzw=;
 b=trrzfrDa/2u0cR4r8DP1ZBENCz2FgFIR71qD1ddi57tB55UN8lt6Y0prlaI7PBqmLGsM
 Hl+PO9pG9Dk8hAE0akHCgaWgp31db69H5BARTSnq9Q+U5twO3N/fCpde7HT7l6BFvjh3
 edOO2sZD48hiMasCbJvSBzFzS81G5Uba8hyLUySfAAT2taBG8bD3OSeWyTZ0d7FoHPKw
 XA3HAjCQ0Do+Xv9uaDh6HYGgmH+jPE8AwN/HTAeOAzg1vPfvcYUYPvkVIYKV/TFgfPT6
 Qwu5NTd9GqcTsfYYy26iXsPwJTg05Hrl+Q7n+6Fsbp/VwvBStSSxLF1ucXbj5SCAVP9/ Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gguq0kxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:50:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9o65a152249;
        Wed, 30 Jun 2021 09:50:27 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by aserp3030.oracle.com with ESMTP id 39dt9grmkv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDx2fNxZmh7/CmiEAAHxI2UmKmzBXbr1aLud0hCjhj6n4kPDe7nswdjZ62xbre9I/2vgwFasMBKW5uE/xDQetQlCJV7Sg5u8pr4t33J9DB+nuiX0FPxBk+4Wqf+hifUMfUcZtmVhtS6ZoyY5/G1AdgS/bXU82D19HYp3do/0YejKQIAkiVkhFcC0L5dSsT3S3QbGjaHqLTpUMJH8ucyeDS4hs7RQUy/EwbkKhIQfOXrpzojEwLKcv2eQf8IQDgJ0+rUN52GrpTPh8odjuXwbBQgtI+3m5o4fXOhilpVGN5/jRBlQqEGohQic0tQQ2Im6egKEw60S4JYnHjH+P4XFtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6HSfD0A/U5It2umTSol8i5rt1uWyK0aoN5QPST7Rzw=;
 b=oJpL3d3Ymq4oF1UuC1tdaU3p2MzRtLKiTjzcVv/Z9emEmFMaEq7v0XHKEX2MRdaL/3Le3EAo3Xj7/jZ5FguYO4BP/TkgnU2Dw94oOtOGctU//PsL35comw2QxhI6m7SABYFiz/ua3hHtqT3m7W3em/23FugZRBPE3F5u9I7DUhQp5na2TAr97Tbg6LBdUBZBBtkSa0TSOO+TokHxXecywUMVEpeKTcImqb/MEk6ie6l3j/ujhH2PmkgjkIHo088E1OgRO6lhv8e1NOBVekffM4Ca+bCtiJG2K/mDnCUaPYEtFpXo2ilLqM77nufUwz4/pRGLkcdIwRcFlrzO6EI5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6HSfD0A/U5It2umTSol8i5rt1uWyK0aoN5QPST7Rzw=;
 b=q0InlIKpmBHSonzHICABOwkvQhNvPkSmlZrqYltZFc8hPHWAIngZQ7BJMb+Mp2dgZa1p5HrLKleOJC39b+oHqdLUuECjtD9f2hVHeZpz6+6ZmEZ3Yk76KU4v6mbEG7JXFptvg4NHNMRmE8L0ul8VUkEetklMDqoVTIz694bejK0=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 09:50:25 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 09:50:24 +0000
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To:     Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
 <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <61f383bc-d582-418f-8d6b-4838bd0d912c@oracle.com>
Date:   Wed, 30 Jun 2021 05:50:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CALCETrUdEvLFKuvU7z_ut6cEfAgJogNp3oBXL-EdDLU=W+VeKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2601:191:8500:cff0::722e]
X-ClientProxiedBy: BLAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:208:32b::17) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:191:8500:cff0::722e] (2601:191:8500:cff0::722e) by BLAPR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:32b::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend Transport; Wed, 30 Jun 2021 09:50:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2229d28c-8836-4c97-5582-08d93bac7bbc
X-MS-TrafficTypeDiagnostic: BY5PR10MB3794:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3794064B434F6D02FF0CE78EE6019@BY5PR10MB3794.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUrfNEbRchC75Lvws9napwxnEVusscMxkCY5ZLOfKjm+21KV1mDVJh9FfXLWyFDa/l4sdnlEjiaIRjZdJzfdUOOaVfphUD8Yy2hhALg6Uv1PQHCd4AtySDwaUbyHmJ89E/nSeLBUdJyhXHLyuDexGpx+QsVwUSUTEquJhp2U+qONXlbRhETre882rs0rwE+/w/G3q6VgHHWpgIqR8ScK4yrnPQUIQEkeyko/nyzIQiLVXduhnfZ/i7aJzLhTVSiHpvzO5Hc78Vu0xtfhfeymNxzdIv2anwgz2T+5ZR5uW7Vx1ILQrn5F4QCIuKco1joKjJyrQdkPRR3uFDCWOyt0YWbWQVL4k17JC1jD1XIi74/CksaAtQ/aK1emW2KVHB3f05LLuHMegWAK+/RNSAlioyy+zezUMCrvWHdR/J4m5xj0YnR+EbY2dDxqqHtRQDhDCPt1A0PaYMME4jLR/Xs+GXN0kIhpjhM1f12bkXMz/AqvJs6UWNHFLZiyDCabw2pmJNThOlzJiE32AIv//nwcXgzIDyamaf39ZHxD71bdIVO1wVnDEGuXTWrToTHAgvLf+OYTuourCMSQ6PzkZ5eSX9/aWaAFPlc5R+GPxnHvKiHkif5NHNFOCqjcOs66zc4M4Uc2N+ZRmzsZjyeWGr3LSmUMdlLsv9qnV7NjSQPpBc9mC+I+wMtu+VMzEAKJH1xXNLNlnMc3zd8OrsQ6wIHRit+Kp/8jWu0fbR6Q5yFm5MU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(366004)(39860400002)(136003)(346002)(316002)(31686004)(110136005)(54906003)(44832011)(36756003)(8676002)(2906002)(6486002)(478600001)(8936002)(5660300002)(2616005)(86362001)(83380400001)(38100700002)(7416002)(4326008)(53546011)(16526019)(186003)(66476007)(66946007)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9qbit5STdEYzhnZDJnejh5Mm1rTXVjc1VjKzc3MVF5ejlnNEgzUUJpUGxL?=
 =?utf-8?B?WnhOTDMxTFRxNDcwaUtGdzNXTnJNRzhOYXpuOVZUaXJJKzhQUnNHY05Pa3Nr?=
 =?utf-8?B?NjI0NFN5bm5tdG9MdzRJQ0VFMjdPeTVYaVhncm96RCtlRDQ3Y3drc0ZHRWFX?=
 =?utf-8?B?b0t3ZkMvVEFCL2ZBMGNQOHVnSTFFQ2JtU1k4dDVGa3pYS2JaL2N0RXpDRktu?=
 =?utf-8?B?RDNtdHh1L0lYUitLV0xia1J1Sm4xbG11Wmk0cXVPZ3kyTElqNzJZdjNrSlNN?=
 =?utf-8?B?Snkydy9MUS90Z3dJc2t5UlhUbHJIREVmV1cyYml1VFJGTUN0bEN6UkJnc2po?=
 =?utf-8?B?RHNaTXlyMDNuOWJPV092M2NhekpLdS9DUkpTTkFHam9aV243Y2R6TEw1TUVa?=
 =?utf-8?B?eXk0Mk85eWtPTDA1YjZORkhhOFVleVR1MlhKTUtxRGlOTDBHRDM1OEgraDY3?=
 =?utf-8?B?NVpFZVNxM0tqQ2JrRDhoZ21jZytwdGcxcjV5MmNDc0N6eDU0K2pZYU1CMVcr?=
 =?utf-8?B?YkFaazZ1Ylloa0dyNmxZdGFJYTIyVXFyRU1tZldKenlvZ0dDZ0M5WC8yMHEy?=
 =?utf-8?B?UVBaQnF0TlJLZUpuSVNZb1dyTWNucHlIdzdwdldvM3pEa25ibXl6QUdtUjRq?=
 =?utf-8?B?cVhEVXg2MjNGeldBcFVNSzlkdUsrMkI1bTh2bTZkUm8xVTlIMDcrUm5UWEhK?=
 =?utf-8?B?R1c0czFHQmJxcmNpaTNTWkl2T2ZhMElweHVMNThaVW12S3JCVWJXRzY3YTls?=
 =?utf-8?B?OVRJTm5TR1NwUGhubEVnRVRFQWtnZHlCQWVUTFYwR3JHQzI1R20zR1hwQzJ6?=
 =?utf-8?B?QnBuOC9HcWNUR0hBY1BBb00wdnhmUlA1TFlrVUU4Vjlta1VwbExaZFpseTBV?=
 =?utf-8?B?TE8wWVhIazVCdHJHMEkweGc5VDlaeHlTeWQxTHpKeEwwclBST0cya3EwWFZF?=
 =?utf-8?B?bkxsYXdWUFM2aWJQL1BoVFVmVmg5WUwrN3NUczZaSGNlY01HSzJFUG90SENJ?=
 =?utf-8?B?cEUrMjl2eW5tb0hBSy9rbFJtbXZlSEdRanVjOG1uaTQvVXVGTUR1aG5meTUy?=
 =?utf-8?B?aDVJeEFMTHlZaTJoVGlhNnk2cE94TlFOcEVCTW1NdFE2RTZlc2RUNklEa3Zu?=
 =?utf-8?B?ZjJqT2g3OHpmM3RBNUlxYXZKY1dQVWUvU3czV0I4aUx0UG56RlBRT0puVnNp?=
 =?utf-8?B?SGJSSkJWa3BnQWdpd2N3RFNqR2RoeXl2RWdoSGpLMnNmRHRxUnhPQzJLUGxt?=
 =?utf-8?B?YzVOWVN4blVRb21LYlltb2R1dUx0RGc2UWwzb3RBMUJFblprU0Q4NGtzd1ht?=
 =?utf-8?B?NWIxbGRrUzBEc1QxVTMvVk4rNUVmdFA2cC9aMVp2NE5JREE5NmRnek81Zzkz?=
 =?utf-8?B?UFRYWTNJZFg4c2pkR29jcm1hWDlRRFEraWNaY3ZMQVZjTkJwUXkrUTI0SElp?=
 =?utf-8?B?Rm03MXdlLytYSkdVUzh3enB4eHVIbTdCa0EyR2x0UEVJbXpNVEwrZHZGd3Rp?=
 =?utf-8?B?aDRtTGg2MGNKK1F4dHFoMDFiOWdTS3NLK1B6NHR6UXJuZGZNV2dlNWtRc3h1?=
 =?utf-8?B?aGVJcUZ2Z3RpOU5WRGh3enFEaTRDdVlySTE4N0ZWbVo1d3Z3QWJsUXNsWUZN?=
 =?utf-8?B?NzhsVXB0Rk1FUkVkVVRCcG1Sc21YajRSS0NRNjJwYWR3WUtyLzQ2Y05vN0VI?=
 =?utf-8?B?VUN1MGdxeEFQaDI0WFpTN3lYc2IyZ2ozZy9MaEZkWE45cHBqdGViWUEvckhT?=
 =?utf-8?B?TmZ0WWxyTldDOFFMVUJ0TmJXOGl5ZGttbXJOcWx2dDBHVE5hOGdPaHhwd3VN?=
 =?utf-8?B?VERYcUNYT2JpT3FtWk9GQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229d28c-8836-4c97-5582-08d93bac7bbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:50:24.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8Ev7RzlroGdsln7PL1A/38iltGKaTrLykKxSjitF4siOqezYpsu8M5hA5jgBSb0hUnWwBFOKtHGeEwNWoj+t/+jSxbAz4y/0ugjFemq4Fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3794
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300064
X-Proofpoint-ORIG-GUID: KH2SzMP7zZtJ2U8HkmLfpauFfm9neNiE
X-Proofpoint-GUID: KH2SzMP7zZtJ2U8HkmLfpauFfm9neNiE
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/21/21 5:15 PM, Andy Lutomirski wrote:
> On Mon, Jun 21, 2021 at 10:51 AM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>>
>> On 6/18/21 2:32 PM, Robin Murphy wrote:
>>> On 2021-06-18 17:12, Ross Philipson wrote:
>>>> The IOMMU should always be set to default translated type after
>>>> the PMRs are disabled to protect the MLE from DMA.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 5 +++++
>>>>    drivers/iommu/iommu.c       | 6 +++++-
>>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index be35284..4f0256d 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -41,6 +41,7 @@
>>>>    #include <linux/dma-direct.h>
>>>>    #include <linux/crash_dump.h>
>>>>    #include <linux/numa.h>
>>>> +#include <linux/slaunch.h>
>>>>    #include <asm/irq_remapping.h>
>>>>    #include <asm/cacheflush.h>
>>>>    #include <asm/iommu.h>
>>>> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device
>>>> *dev)
>>>>     */
>>>>    static int device_def_domain_type(struct device *dev)
>>>>    {
>>>> +    /* Do not allow identity domain when Secure Launch is configured */
>>>> +    if (slaunch_get_flags() & SL_FLAG_ACTIVE)
>>>> +        return IOMMU_DOMAIN_DMA;
>>>
>>> Is this specific to Intel? It seems like it could easily be done
>>> commonly like the check for untrusted external devices.
>>
>> It is currently Intel only but that will change. I will look into what
>> you suggest.
>>
>>>
>>>> +
>>>>        if (dev_is_pci(dev)) {
>>>>            struct pci_dev *pdev = to_pci_dev(dev);
>>>>    diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 808ab70d..d49b7dd 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -23,6 +23,7 @@
>>>>    #include <linux/property.h>
>>>>    #include <linux/fsl/mc.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/slaunch.h>
>>>>    #include <trace/events/iommu.h>
>>>>      static struct kset *iommu_group_kset;
>>>> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>>>>    {
>>>>        if (cmd_line)
>>>>            iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>>>> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>> +
>>>> +    /* Do not allow identity domain when Secure Launch is configured */
>>>> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
>>>> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>
>>> Quietly ignoring the setting and possibly leaving iommu_def_domain_type
>>> uninitialised (note that 0 is not actually a usable type) doesn't seem
>>> great. AFAICS this probably warrants similar treatment to the
>>
>> Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
>> though passthrough was requested. Or perhaps something more is needed here?
>>
>>> mem_encrypt_active() case - there doesn't seem a great deal of value in
>>> trying to save users from themselves if they care about measured boot
>>> yet explicitly pass options which may compromise measured boot. If you
>>> really want to go down that route there's at least the sysfs interface
>>> you'd need to nobble as well, not to mention the various ways of
>>> completely disabling IOMMUs...
>>
>> Doing a secure launch with the kernel is not a general purpose user use
>> case. A lot of work is done to secure the environment. Allowing
>> passthrough mode would leave the secure launch kernel exposed to DMA. I
>> think what we are trying to do here is what we intend though there may
>> be a better way or perhaps it is incomplete as you suggest.
>>
> 
> I don't really like all these special cases.  Generically, what you're
> trying to do is (AFAICT) to get the kernel to run in a mode in which
> it does its best not to trust attached devices.  Nothing about this is
> specific to Secure Launch.  There are plenty of scenarios in which
> this the case:
> 
>   - Virtual devices in a VM host outside the TCB, e.g. VDUSE, Xen
> device domains (did I get the name right), whatever tricks QEMU has,
> etc.
>   - SRTM / DRTM technologies (including but not limited to Secure
> Launch -- plain old Secure Boot can work like this too).
>   - Secure guest technologies, including but not limited to TDX and SEV.
>   - Any computer with a USB-C port or other external DMA-capable port.
>   - Regular computers in which the admin wants to enable this mode for
> whatever reason.
> 
> Can you folks all please agree on a coordinated way for a Linux kernel
> to configure itself appropriately?  Or to be configured via initramfs,
> boot option, or some other trusted source of configuration supplied at
> boot time?  We don't need a whole bunch of if (TDX), if (SEV), if
> (secure launch), if (I have a USB-C port with PCIe exposed), if
> (running on Xen), and similar checks all over the place.
> 

I replied to Robin Murphy in another thread. As far as the IOMMU is 
concerned, I think we need to rethink our approach. As to the other 
technologies you mention here, we have not considered special casing 
anything at this point.

Thanks
Ross
