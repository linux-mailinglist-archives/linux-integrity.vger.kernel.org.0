Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835283B8054
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbhF3JuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 05:50:09 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25732 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233983AbhF3JuI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 05:50:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U9l9lw016678;
        Wed, 30 Jun 2021 09:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=IwebSOLhjxrO7/poD4DJQws9XKYKfo9qRIi4XgFSg4OZ2kP8w9cKslZxc3xsYJ/54SIs
 VWlawFF9vtzFnr0nV6HspfDAULkypONK/ek2GQ7gRiZZvy1jpg0Izo1VFr65PGlSo6nN
 2J6i6Px1/jGR3uU3mn/l5N7Rl4e7wWxHqb9DmOQJnfg6HRZXRM+vh35Ydx9KgwHYkw9Z
 kcm6AQkDBb+Jh1hpH7qzDtrewp6cAMo9Lc6Muuf71bHdlJTEUekkec68SC94mNE3K2Jt
 UkgWrr8YtrY0jTwA3f2G75651rqyqCCb0ObFPzi9u1w95Q8Qs8QAi5Is6Rf6gAfnWWqn 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f6y3nkjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:47:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15U9kOMU143389;
        Wed, 30 Jun 2021 09:47:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3030.oracle.com with ESMTP id 39dt9grfpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 09:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXKGUS7yQEqBwKQ0hAKA85cl0M9F9XN1N/CgT8puh2x0a5+TjbqsaDg41gJS7KDaCEKU/XME9bms6wTa0DCS/IayRHfRiF5kEN+scBaHCG8p9GYdibVL9QE8rmexsBKmvfV9tiYJP/cDhprvOAvid3iw2jGcoVTxHVrhhGvVi0FN1zgy+Lni9vLeclrXAadwhZW168sbonnz4KCK5s6xJswNkBDcIVAsqEZ7fBNJWT2PXCNr9mLK8gpMU3Gd3xyYP6mMg+idS4NIQK4ntFRD8Uxw1kxm1xwXKbKO6FhfiH1JJIdcWs61+lYKeyEs8KaV+qqTcezvj5TImBrrZU4QvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=WTclpzddbzLf+XoNwQinOCoYSP9Yk+TxiBH4V926ef5DAC4Ic+XtjDHZD+gqm+EovFdrQDwv2n/iWYiGVG6kNNQPnUStAG3JSxYDLBbitPZc4W8VifvtkAflKNWlkk7TqDUfHxHu9JlZQBhFoP8q/ZIb4WY7dEJinhAIdP+y34TaI05w3QTg24OvWQ1pqfNFYigvkou9NuaUp+YZ4pyOF1WYCd6YW8GEliS9Lww7l/3nsYY6y65FBN/HfG27grHjRrufas9Bgoy7c7Sadvb4I/Ruo4Kcy0dNHsatKR0ZuxXnYNfc5N0GiNxEFa0HJtg66szMxDwHVyXTmWnpH7ZhsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dT03i8scFTSa0UNwFfb5i8xwsLZ+UhjA+Ma/qTmmONk=;
 b=Ey7G5BQ0Dqqy24dJX/mEhKGjuuHenmeB/MLxzjfTmMRcolGeWeUftlDY2igWLJmR5gZtAHXv2YRj6DLYuUm5lUZTM86264ys+hCV9fMH2yScZSrVrkR7O13QHeffYCjjJrUEEho0OAxGHzOIClrLcOacTi3F1NHSnAdXVeE39Tc=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB3430.namprd10.prod.outlook.com (2603:10b6:a03:8f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 09:47:11 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6%7]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 09:47:11 +0000
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, luto@amacapital.net,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
        trenchboot-devel@googlegroups.com
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
 <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <d97164e4-b776-0efe-d243-8a71b085d897@oracle.com>
Date:   Wed, 30 Jun 2021 05:47:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2601:191:8500:cff0::722e]
X-ClientProxiedBy: BLAPR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:208:32e::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:191:8500:cff0::722e] (2601:191:8500:cff0::722e) by BLAPR03CA0133.namprd03.prod.outlook.com (2603:10b6:208:32e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 09:47:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a82440f-7ff6-45f8-ade0-08d93bac0879
X-MS-TrafficTypeDiagnostic: BYAPR10MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR10MB34302BA53A92617A595DB04CE6019@BYAPR10MB3430.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xCjxrnc0Dm0aVXfdCOnYVNajK3bd7KmpWECD9dU9bgCrkKSkYVjFhbzj5JrQzvAIkshR/PNy3q2lr4oBAS+sRm75lSIe5hJYO16Gu7/IgeoxZ1T5xtlPkwfaoQRsfXfNfgJCeB9gJaeG3iGpwbniNBxOOQuamsquCrqz4YnwFtB0vM2x0powb1wOVXdMBESSyNjfZl/kt0gc/MtIkm10yVLVpI0aoLugyvrfWW3g2FWnQIDUoRA/skLAnpzoilOyh+zn+jkc3svLdhTql2W6iBSZTIVz7zytvd4SEuaFKkqbIWGZfhNYaq60IFya4mnvTKHNLmyUTYK+Be7UKKuXtIcOUnamAsUAo8fcfHOpHIttcRybl6gd3TVKyzTLN+rvgjHV0oko+DeIDdZkbqrfT8V7zmWrgrEN3UiUsuuke6LWecf7T5J6r5hz2S1npAxgV5qCKss9Spj7DO5NbPiAZqe0P+WnoxLnfX/4nxCtG+Vti7nWGYSm6wXgvfLohGE3gT2oKfop877htSpz8utgT8uaThmTFjpcf6VKaO2f4utMa/aoR7x+ZnWdEdw35DpSZmY1xImhAIaUAKgIqOD8HMEv7ko0aRi8BDtJYiZsVJm30/dTLU/tyPKTsPRqT9tyrHjGpc72NjOtf7C9pujqzGRcdBZ3ib1DvCKSf/NSA05xhNgSX0v5lSoIrXtNb1auivmVEw3uzakyiStNhqJtd5pSfAFkz2SxxTXVj0MjE08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(53546011)(186003)(16526019)(38100700002)(7416002)(86362001)(83380400001)(4326008)(31696002)(66556008)(66476007)(66946007)(44832011)(36756003)(316002)(31686004)(5660300002)(2616005)(6486002)(478600001)(8676002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QldsNWJZbHFQRXB1MlFPWnZTR3o4aXNTOXJDY0EwbkJTOW9jeXRwdVRCSEJx?=
 =?utf-8?B?dzJmL0JpMXZsRmJyMGNZSndZWEFBYXdUMkdlNkxoTzFXRldSb1BYajFnUnk2?=
 =?utf-8?B?Nm9WS3dQUzZpZVNIdUxzNzUxM0p3Qm5QV1hGb29lQUhndWFTMjRWQnlEWVhq?=
 =?utf-8?B?ellBWXhjVi9pZERkZUZHL0I4dkZGamkwc2tpckZDZUVtbjN0TDRoeDFDeXc1?=
 =?utf-8?B?TFhhUTlVbklJdSt0YnRZL2YzdE9nOXlnaDQ2MVltVU83akhrUmN1RUhqcUlF?=
 =?utf-8?B?VDIwR2x3WEExNmVMWmdIQkYvM2JNeUtWMC9IUGZDbWNXUld5bHdZYW1ucGti?=
 =?utf-8?B?cjlBR0NaR29BVTJJd0RBTXFwK3R5ZmJLNXE2cXdkb0VCMDBXWjlwZHV2UE9L?=
 =?utf-8?B?VFV1aGdScDYzRXBObGZPL3JNUDRYejVTNWwyYVg0TjlIWEtpOHFaSEd3UUtF?=
 =?utf-8?B?UFZhQzRtRzE1ZklPVTVDUTlsWXZsNE13TTVRZDJnMW5xdXlsWHN6QThzZUdt?=
 =?utf-8?B?ZDlzY3VQZ0tMb2I5MTFXd1JIVWNPZXMvMnhLMlMwUXZuR0F4TDYvTSsvekdk?=
 =?utf-8?B?bUNTc202QzJCNTJIN3RlaTJSTFExNUJvREJZRlZlUlFmY1pjNkZuZ1JOSDRX?=
 =?utf-8?B?M0Zkc2VjaE5WWXFKbzFJdEFTVEhlTXowNm1CR3NsdHRKbThWWVFjRHdISVlT?=
 =?utf-8?B?RC9iazB3d3BRYXB4YXlzY1lvbzdiYWcrMFhJZHd1Zm5Ra0JTYWhwampVZzMv?=
 =?utf-8?B?eFRXcUwzYTRhRlRnOEFTSXhRb0ptSnV5d21LZnBMVzhYR0I5UUFFbW5rTDJV?=
 =?utf-8?B?SS8zWEFoeEdpL1ZTUTVQbTJOSVZrV3dQaFhZL0JjRDZYVnZ5d3JBODNDMUs3?=
 =?utf-8?B?dHhJWXBOMXZrYzczbEVPM051NFRudkVZN2dhUkRlbmVjK2dnbTlaMkVlVnlF?=
 =?utf-8?B?NTlTZjJQQUlhczFjQ1BhVW4wc0hnRGUydUNCN1VIM0hkUkgxQnovUXYvdEVN?=
 =?utf-8?B?QXFhUVArSlRHblBKcU1YMWc2Q0JwdmFVUWFLRm41bHZIRHZPWW1PR2c5VEQ0?=
 =?utf-8?B?ZnpUNHh0UWNtUTF1U3NzYnlJZEtTZ1QvSEQxSStUdXFYaFE1TGZhcmxTMjI2?=
 =?utf-8?B?V2hxeHR1TWZrWlBjcUVsZTJaN0FUWTRNQ1RUS21kajJua3hMc0dhbm9LSlp3?=
 =?utf-8?B?a2JGZUVXVTYwekN0T0FTdk5SN2E0OUlXd3Rwa2Rjd1pxMlNoZVF2QStnMHU0?=
 =?utf-8?B?MGg5K2lQd1pXOUl4SUZCODRWN1VxTDBQQVBBeHNCOWNSVkEybEVxUm5TYnNM?=
 =?utf-8?B?dFhvQkdvc285ZWtxUWlLTklKS1R2MlBjTTFMMlNuQnQ1TW5qU2c3emNsSnJl?=
 =?utf-8?B?M3ZXRkdqeG5RZEcyRWw5QzNKNXZVclJ1MnliUGFYR0MzRncvK2VGbVBmY2tC?=
 =?utf-8?B?bkNYQjZVNlJMT0VRTUhQOTRzU3VSOEhtaHNSejExMmZpL1lDR1VZWHBxNDc0?=
 =?utf-8?B?bDhWNlhIU1Y0SC9iYzFNSnN1MFllYjdQNXFWempoRmRjWXhNYWJZM1Uxaktv?=
 =?utf-8?B?U3NHeWs2MGNTaUdwMEFSdlMySDFMcG1IcWZ6eGhlVHNwMTJrMU1WTEY5NGRZ?=
 =?utf-8?B?cDE5M0ViK1pwNWVoUk1mK0VnZzZJTFEvTm1qdUF1THRXUGZCNlN1ajdVdHNW?=
 =?utf-8?B?NVFic2xxbGg2QjU3MWVuaHYzTTZoR1dGc0p6ZmJodTdKR0YrY1dudVRJa3VX?=
 =?utf-8?B?L25OUnQzWU9hMlI5QWF2cko5TDZNU3VDTHJPZ3FES1d4cU1rNVRoNXJ2VkY5?=
 =?utf-8?B?K2ZjTFFLN2dLSXIyMHVndz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a82440f-7ff6-45f8-ade0-08d93bac0879
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 09:47:11.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN8dKYNi9pTLLWg5M+aTYQj8rsp/Vvt3niXvpzGe6YbQCJFqYIDJHFW8WE2bgIWDOVK4gC1J1naMQ3vyjT2Tul31PCifD1NxHAQgKAkX5ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3430
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10030 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300063
X-Proofpoint-GUID: lWlbXib7r8eQ2zn5B1Wj7izu56EIquq7
X-Proofpoint-ORIG-GUID: lWlbXib7r8eQ2zn5B1Wj7izu56EIquq7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/22/21 7:06 AM, Robin Murphy wrote:
> On 2021-06-21 18:51, Ross Philipson wrote:
>> On 6/18/21 2:32 PM, Robin Murphy wrote:
>>> On 2021-06-18 17:12, Ross Philipson wrote:
>>>> The IOMMU should always be set to default translated type after
>>>> the PMRs are disabled to protect the MLE from DMA.
>>>>
>>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 5 +++++
>>>>    drivers/iommu/iommu.c       | 6 +++++-
>>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index be35284..4f0256d 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -41,6 +41,7 @@
>>>>    #include <linux/dma-direct.h>
>>>>    #include <linux/crash_dump.h>
>>>>    #include <linux/numa.h>
>>>> +#include <linux/slaunch.h>
>>>>    #include <asm/irq_remapping.h>
>>>>    #include <asm/cacheflush.h>
>>>>    #include <asm/iommu.h>
>>>> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device
>>>> *dev)
>>>>     */
>>>>    static int device_def_domain_type(struct device *dev)
>>>>    {
>>>> +    /* Do not allow identity domain when Secure Launch is 
>>>> configured */
>>>> +    if (slaunch_get_flags() & SL_FLAG_ACTIVE)
>>>> +        return IOMMU_DOMAIN_DMA;
>>>
>>> Is this specific to Intel? It seems like it could easily be done
>>> commonly like the check for untrusted external devices.
>>
>> It is currently Intel only but that will change. I will look into what
>> you suggest.
> 
> Yeah, it's simple and unobtrusive enough that I reckon it's worth going 
> straight to the common version if it's worth doing at all.
> 
>>>> +
>>>>        if (dev_is_pci(dev)) {
>>>>            struct pci_dev *pdev = to_pci_dev(dev);
>>>>    diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 808ab70d..d49b7dd 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -23,6 +23,7 @@
>>>>    #include <linux/property.h>
>>>>    #include <linux/fsl/mc.h>
>>>>    #include <linux/module.h>
>>>> +#include <linux/slaunch.h>
>>>>    #include <trace/events/iommu.h>
>>>>      static struct kset *iommu_group_kset;
>>>> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool 
>>>> cmd_line)
>>>>    {
>>>>        if (cmd_line)
>>>>            iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>>>> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>> +
>>>> +    /* Do not allow identity domain when Secure Launch is 
>>>> configured */
>>>> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
>>>> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>>
>>> Quietly ignoring the setting and possibly leaving iommu_def_domain_type
>>> uninitialised (note that 0 is not actually a usable type) doesn't seem
>>> great. AFAICS this probably warrants similar treatment to the
>>
>> Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
>> though passthrough was requested. Or perhaps something more is needed 
>> here?
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
> 
> On second thoughts this is overkill anyway - if you do hook 
> iommu_get_def_domain_type(), you're done (in terms of the kernel-managed 
> setting, at least); it doesn't matter what iommu_def_domain_type gets 
> set to if will never get used. However, since this isn't really a 
> per-device thing, it might be more semantically appropriate to leave 
> that alone and instead only massage the default type in 
> iommu_subsys_init(), as for memory encryption.
> 
> When you say "secure the environment", what's the actual threat model 
> here, i.e. who's securing what against whom? If it's a device lockdown 
> type thing where the system owner wants to defend against the end user 
> trying to mess with the software stack or gain access to parts they 
> shouldn't, then possibly you can trust the command line, but there are 
> definitely other places which need consideration. If on the other hand 
> it's more about giving the end user confidence that their choice of 
> software stack isn't being interfered with by a malicious host or 
> external third parties, then it probably leans towards the opposite 
> being true...
> 
> If the command line *is* within the threat model, consider "iommu=off" 
> and/or "intel_iommu=off" for example: I don't know how PMRs work, but I 
> can only imagine that that's liable to leave things either wide open, or 
> blocked to the point of no DMA working at all, neither of which seems to 
> be what you want. I'm guessing "intel_iommu=tboot_noforce" might have 
> some relevant implications too.


Thank you for you suggestions and feedback. Sorry we did not get back 
sooner. After the comments from you and Andy Lutomirski we decided we 
needed to re-imagine what we are trying to accomplish here and how else 
we might approach it.

Ross

> 
>>> It might be reasonable to make IOMMU_DEFAULT_PASSTHROUGH depend on
>>> !SECURE_LAUNCH for clarity though.
>>
>> This came from a specific request to not make disabling IOMMU modes
>> build time dependent. This is because a secure launch enabled kernel can
>> also be booted as a general purpose kernel in cases where this is 
>> desired.
> 
> Ah, thanks for clarifying - I was wondering about that aspect. FWIW, 
> note that that wouldn't actually change any functionality - it's a 
> non-default config option anyway, and users could still override it 
> either way in a non-secure-launch setup - but it sounds like it might be 
> effectively superfluous if you do need to make a more active runtime 
> decision anyway.
> 
> Cheers,
> Robin.

