Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF933AF255
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhFURyT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 13:54:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8302 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhFURyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 13:54:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LHgAmi026542;
        Mon, 21 Jun 2021 17:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=pixXMVv4KIjwcOh+D7GXH6oBxZnVMBa3UWQJcfwT6Y9v9w5rUCZH7cTO+BjgHPkrUhQV
 fWk4JtM7pJsBeCi4t/D+zdCNW3R6J1c9uX77dj2xjdK+R01S7E8YRcSOEM26UOkf0nbw
 SQgC5V/6wukKM6FUQLzaC7Lkio8Z6kjnPnIqiKvVWgOjQPrAzvQqr0HITdj3pYsu+SMc
 7vlLVc1WOWDe7ZZTJZ0pn2/fOLzn2M6OvLAadPm2KpVuw8ESgQqE3ZF4MUN3FOLIoDnk
 3Cn4FV/7AAPQzCcGaya0QS/XRjPxTxbpIMOEt1LKvlYMz8vIcOkKD+3ButlUArHZHJFA tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyqa05a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 17:51:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15LHpCpQ135172;
        Mon, 21 Jun 2021 17:51:41 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by userp3030.oracle.com with ESMTP id 3995puxn2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 17:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2L9omrTetO/Ndqwo2zzVkmfruWGoJtl7gwBWbkTTHaGQOctO78sWsqpew6PAR+6Uj/LI42aT6QlJg7aZQd2TMh1hax15i2RrrsE1L99PA1/dEC/aF+0JmgbI4ciGdo4reCgn46WEoAlBzQt34IXVBYZOteRjz/vYkh0TZpP2OVOdw+NMmP68wsdUM/LRU1g0bWvF5kuTz/MSrgeQjcyTaSseDY6otSFowRi582qafopWR9EjxXHhfo8uDq8pd4bqtJmxK4eudnXdSikMpwE+S5gPwZVscXN2udlSayEE1gD+08Ug2QI2BbuYFoBMdrdNUlPlQlyZedvAwSDJriNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=Gy7YKmqcSyoWKLtt9o+e+jOyKQ+8SmjRhiANfiBglMWCbX8e3Pko9wETrAWQ4vI82u8NmoeiHGo41vwF0vWxotF3dU6N/At5/p6BWe47kP3Vazq15iyRwpheUZo7DLVNFYYIqHGjlqN7gmAjdBaFsDDW/WCjVcDGcw43gtpUU8gaslBBaykMADMOU6y1ALxLVhbP3v8dsGX0L1r3hDQOnILOgAlbPcjtfQKUadVi4gyEGfD5jjGN2bimwoUiR5be+LyUmOGtFUGwRjsboeVsXYfL41PTxAez7Ml6rtO+6QxYQ28+TMAl0O0zvR7PjsMA9pvmFAD/LKHehSY+qfSPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ1Z/8zt6zlP4m1heqj9ye3ufMZxAzpzycnpIFKLSdw=;
 b=cpexIIlh2AfAe9BjlATjsi68DElGwthTQfmrQxXmvhqJzX2KEyGUzx56PGkdrKqCgNqCZHhp7YLxiXd4s5jNWURDkDK5IS7sqicCBKCOjzGIF36AmwZ8f5EpfQU0MEoBEy5eIrqqJhyQ5oMJ6SrFGrSpiTZQDtX0eB9hNlA7nP8=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2839.namprd10.prod.outlook.com (2603:10b6:a03:85::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:51:39 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e859:fa81:bf13:66b6%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:51:38 +0000
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
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
Date:   Mon, 21 Jun 2021 13:51:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [209.17.40.46]
X-ClientProxiedBy: MN2PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:208:e8::32) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.106] (209.17.40.46) by MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 17:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f32813-648d-41d1-3656-08d934dd3852
X-MS-TrafficTypeDiagnostic: BYAPR10MB2839:
X-Microsoft-Antispam-PRVS: <BYAPR10MB28396C416F8B81AACB353DECE60A9@BYAPR10MB2839.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lArACPSUAWgRT45DSUjNMd95no7OgsDxJ7IXZH3s5wMRwtr7HNFEkpJxOAyTlZXAD/vUNHut2jbQbcMi6XZynrlbynXweZzhyfRuRQY6GZUJQaEM3K39bat6JylG5GyAysbKgz7Dn/FEnA6Xxq0UEjEgE7eXcUKcTFKBWaoxrN/5Stlan8YMb8WGqYbyH8UceheqDIPlY4i4yNI+fwT1qYKkIfkvsVOwyEA8Tigl4mxu8bmyvvDec3llcwGCZvEnIZ5qcPElB41ksGc+k9r7oIZhaQFqbQOgbIGOlVgKyXkz7vVjWzaSTVEFkCNwYggXrhG2HXoX2v/fRTe5dB7r0XSliFuEQS/o+goEIqQC4Ktuj9jbvdIEQb4FJ9ulfh6urpQikFK+/1XzV2dR878D61kEuLMXhKsvvBJ8kK60WT8P1HuS0/nlVFvCtSkABgGdHfh4Xfmb4xuDTchQ7vbiTGIL734IstBFKvoMnR7PcB8AjDXVesrh1c4wolBD+mvJwZAH7xHbRCFGK2VgpsrMYWdf8XXuDeaZM1zjMc7fwWPewPZefjD62sMMtgvJPVp/fMprS6e27JASkRlSVNSD4uNz78CA4qdT+fQ1pdhiF+yDM90uHe2LL4Un/BqiLL8vcRUFIF57og7hL0g3nPjHrBWkrYMR/HAgeCiaZsnhpA+8kZYp2MPOrW8RyUmTINfR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(39860400002)(376002)(366004)(316002)(83380400001)(16576012)(26005)(53546011)(8936002)(4326008)(6486002)(2906002)(86362001)(478600001)(956004)(66946007)(66556008)(8676002)(66476007)(36756003)(31696002)(38100700002)(2616005)(7416002)(16526019)(186003)(5660300002)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpOYnMzM0UvSU1jL3pUN1lML0xqdnRJWWpBbVdPT3BTY0R1Y1lwRm9iNmFy?=
 =?utf-8?B?RVlaQ2dLZkgrTUhiQnI3NTlielNTUlUvZWhVcGdhSStvRnI0WUpTU3NCMmpQ?=
 =?utf-8?B?L2hINUpiRnU0MG5GelBZQ0JkUC9KdnR2cHhZU2F3T3NMYVBIMThjcHZUV0E5?=
 =?utf-8?B?VWhzMmZ5S2xUY0Z0LzZsZmFUSVdHZ0YwREJlUFJWT2hWcGVBemRCTklBME1I?=
 =?utf-8?B?emZmSzVtRGVWQXVsdWxsOUVmMlF2djdwZnFHc1pHd01pUFlFa3BMTVpSdFB0?=
 =?utf-8?B?VmhZdXA3SDM5QThCeGxDV1RDMkRvNVZxZmRJL2NiUTFMZDdzUld5dWg4L0c0?=
 =?utf-8?B?QzRDSnM3U0swdFo2bm50bzZZdlhKeG4wTG83MGhoaERhKzBicDFoNlBTc09x?=
 =?utf-8?B?Rmk1Q3VpT2l5OHltTkpZNDNHZ3FXY1JZN0lENTZENVI5MDZTaGJwZzBMMHR6?=
 =?utf-8?B?TUE3SXhtb3hmQWM5V1o5SWwwOXFMWW81SDJkaWpCeHhYWnZzSmJYQjRjUWZk?=
 =?utf-8?B?UGRzQkRZd09jVmpoQVFKRklTQ1QxcnhaSm1VWDdkeVpiNTJ1NVhucjNwWjZF?=
 =?utf-8?B?VVpVN2pyOTBJQ3hvUUlMME83S0N4RjEzdjVld1RVNFQwYndURDVoKzZLRUt2?=
 =?utf-8?B?SlZQdHQ0S0RNM0dKLzJkSXRwemVMdDFnMGs5a2QrSW1EYmlzT0IzTFIxb2Za?=
 =?utf-8?B?eGFvUkRsZ29GSzFIdzNKME5yd3EwUHpkbjRndXAvVTJMb21OQkZydUR4cmdk?=
 =?utf-8?B?UXJRYnp5VTM4VWhFcmxiM3grTXJrMUVUc1hjM0xHNlhSK3VEMVlSdERjZmhK?=
 =?utf-8?B?dXJzVkJVWENDM01BdHVKZDMwd1NlYy9RRGxDZGVUekxxbWx6Kzc5L1ZxeE5J?=
 =?utf-8?B?cDQ2clRyaVNpdlZPTmUrQzhscG9Fc3VnanZkVGM3OTYzMURMZXBKc1FENjhx?=
 =?utf-8?B?NnVON0RyL2dCV2N3V3FEa0xKQ3ZDTUF1VXU4VlhGRmxUb1k4K3IreStjZjhk?=
 =?utf-8?B?dTdDVEM4a1pPZVJ2SzRRQlhHNmg3NUFRUVhUYjhhTktiRmkwMFdmRFVSRTRU?=
 =?utf-8?B?VFZHYTFIWVdpZ0JkWFptejFpN2pSZ2MrNVp4RUN2N2xLN3dMUlh2NnY0TUJL?=
 =?utf-8?B?N2VRNnRleGszWE11ZE1YMHdUUlNIUW5kanFCdG5WVkoyem5jM1Jqd3BUc3dB?=
 =?utf-8?B?Ulc5ZUZlZEhpSEwwMWZUNDk0MTRnenJpMVdBdm1yN1Z2eEtHMTZkWGdKdmNE?=
 =?utf-8?B?a1VVTHlTeVAyZDlpeHVicWlKMXYwd05HS0FQeVV5VCtQL2VIRTh5eExlU2c5?=
 =?utf-8?B?UWo1MkFNMWxCbVVEdUQxR2FWWUpFMWRCYmw3ZHdENHY3QzI4T3ZEVkdHbjBT?=
 =?utf-8?B?WkNBTjNkRGpjek01S0VIa1JnQW9NQi90MVlnZHJJOUZxSzdRUjdMODRNS0Fx?=
 =?utf-8?B?YlJ2MXVlWnpubnB5eWtuS0hqRzJ2QkxHT3hiQ0FzeHdGSnZSaEVuSW9IT1FD?=
 =?utf-8?B?cVUxS2VOYWUzQ0hMSjF1TmFxQlNmc1RLcjJ1M09EZDJYZXJWTTgrQkFNc3ox?=
 =?utf-8?B?dFN3RzlxZUJUYlJrNmtSMllmbm0xZDFzRzd3aUFkcGdtK1cxSFpRNlZLalU0?=
 =?utf-8?B?T0VNUGdZMERWUTdjd1VCakdQUTY1OU8yRUZrOUI4TXJ4WkdRR2t6Mjg5TEsw?=
 =?utf-8?B?em8rU1ZabWFabHdkdHdjN0ZEMEVES1FOOWxpN0x0RHhCSWJwMzRWanExaVlZ?=
 =?utf-8?Q?tw0DGj7SySINiK9k/zj4lpjPrqTQ5yqdwfmjQpa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f32813-648d-41d1-3656-08d934dd3852
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:51:38.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4oskz+NUr2UiML0IMm5LY36HRq9O6qUtmfw+LQsE53jedqSUBYai/9xIXCE+gnLtKJl87Maad3/SY1ChJ94YNgqgqNF7lhVYDJcNaaiwa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2839
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106210105
X-Proofpoint-GUID: dqtMx429LrGN5JBmBnFm9dBgIfUE1rT8
X-Proofpoint-ORIG-GUID: dqtMx429LrGN5JBmBnFm9dBgIfUE1rT8
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/18/21 2:32 PM, Robin Murphy wrote:
> On 2021-06-18 17:12, Ross Philipson wrote:
>> The IOMMU should always be set to default translated type after
>> the PMRs are disabled to protect the MLE from DMA.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 5 +++++
>>   drivers/iommu/iommu.c       | 6 +++++-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index be35284..4f0256d 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/dma-direct.h>
>>   #include <linux/crash_dump.h>
>>   #include <linux/numa.h>
>> +#include <linux/slaunch.h>
>>   #include <asm/irq_remapping.h>
>>   #include <asm/cacheflush.h>
>>   #include <asm/iommu.h>
>> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device
>> *dev)
>>    */
>>   static int device_def_domain_type(struct device *dev)
>>   {
>> +    /* Do not allow identity domain when Secure Launch is configured */
>> +    if (slaunch_get_flags() & SL_FLAG_ACTIVE)
>> +        return IOMMU_DOMAIN_DMA;
> 
> Is this specific to Intel? It seems like it could easily be done
> commonly like the check for untrusted external devices.

It is currently Intel only but that will change. I will look into what
you suggest.

> 
>> +
>>       if (dev_is_pci(dev)) {
>>           struct pci_dev *pdev = to_pci_dev(dev);
>>   diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 808ab70d..d49b7dd 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -23,6 +23,7 @@
>>   #include <linux/property.h>
>>   #include <linux/fsl/mc.h>
>>   #include <linux/module.h>
>> +#include <linux/slaunch.h>
>>   #include <trace/events/iommu.h>
>>     static struct kset *iommu_group_kset;
>> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>>   {
>>       if (cmd_line)
>>           iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>> +
>> +    /* Do not allow identity domain when Secure Launch is configured */
>> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
>> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> 
> Quietly ignoring the setting and possibly leaving iommu_def_domain_type
> uninitialised (note that 0 is not actually a usable type) doesn't seem
> great. AFAICS this probably warrants similar treatment to the

Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
though passthrough was requested. Or perhaps something more is needed here?

> mem_encrypt_active() case - there doesn't seem a great deal of value in
> trying to save users from themselves if they care about measured boot
> yet explicitly pass options which may compromise measured boot. If you
> really want to go down that route there's at least the sysfs interface
> you'd need to nobble as well, not to mention the various ways of
> completely disabling IOMMUs...

Doing a secure launch with the kernel is not a general purpose user use
case. A lot of work is done to secure the environment. Allowing
passthrough mode would leave the secure launch kernel exposed to DMA. I
think what we are trying to do here is what we intend though there may
be a better way or perhaps it is incomplete as you suggest.

> 
> It might be reasonable to make IOMMU_DEFAULT_PASSTHROUGH depend on
> !SECURE_LAUNCH for clarity though.

This came from a specific request to not make disabling IOMMU modes
build time dependent. This is because a secure launch enabled kernel can
also be booted as a general purpose kernel in cases where this is desired.

Thank you,
Ross

> 
> Robin.
> 
>>   }
>>     void iommu_set_default_translated(bool cmd_line)
>>

