Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375DC777B32
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjHJOpz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 10:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjHJOpy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 10:45:54 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B5211C
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 07:45:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvsUcOdRESzklOld0I3uUUw9L/PSdnbsabGOp3E/jmD1kZgGxVEoIVeB3FHIu6GvvJ5rYBUxAdLcGAdSiB920BYlD3fVzmyWK+hdv1rX1tJuQdXnP1QIb6+mLyZWVsSrA4Cu6qIgfbwF9zYH2/Rz58/v0BJ/fXj+BH6C9pwAahHCtR4r2yFJt6widV1erSf46AV4lTOwhyqO5XypnPpb9YRg5ioqTdLmKUYZOXq3SUQZCDcBTybY1zvsn2yJuSPAo4R01G3l1YzD3+OxhhaQVQOaYWpYKMgbLswa0bzlvB0bIDoumkdKWQDIEacqyI10GjRzSVpTjo0lD/oSScu94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC1Ie29lQMCAOscrOhWhDEFSXb+Pw6IGqvfGJXaxgvA=;
 b=co8rtY1jlYV/oQZjt05tr950rFnG8pVJ5Opa2WjS0OKjcA/x8MK3jNnozptUwo1RU+LPYA5Tw+73bwaQRrTU6EEpOs1JjaRP3CSIFF1BYWPuOAuVX20lGQ3RBvFhS2URykq5UjvJVERUPCX/4h/JpoEMMfdhDX7uy5s+Ucpeqq0s7Usszgz5u0Xs0i+ycStMNJMqIa1BlyGNUV74hmMkAffor5BWWDVbLp10RMdarwrXTeFJ4dG66kvH0velH7qsTpxNpWQyQip3miAAC4eeN2M0q4TKVMIbpWSWgseQTEs7YB7bNRrsK61Xs88Z2XstoIaB4wGot53xJxAcjbouMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC1Ie29lQMCAOscrOhWhDEFSXb+Pw6IGqvfGJXaxgvA=;
 b=W+UgNS/vbtWXV8WG3sgzNJgz7AZHlA3nt7p9G23YVQYkTR1lipxVWUlkJe/FZBPu3unXTlWW1f6/9RRrFCZbRKuCBoY5oyQqbLD+BFjf645CIOMb7z1LJOP1ExXi1rg6WGnhxMpv2+6mA+KD4u3aKyMfjv8daZshzyizRvyWccw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6990.namprd12.prod.outlook.com (2603:10b6:a03:449::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 14:45:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:45:50 +0000
Message-ID: <b4ffd629-07f4-413a-9edb-f7e76395225e@amd.com>
Date:   Thu, 10 Aug 2023 09:45:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tpm: Disable RNG for all AMD fTPMs
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     jgg@ziepe.ca, linux@dominikbrodowski.net,
        linux-integrity@vger.kernel.org, daniil.stas@posteo.net,
        peterhuewe@gmx.de
References: <20230803182428.25753-1-mario.limonciello@amd.com>
 <CUK4PB8J51W8.2NQ3CSI1HNLDR@wks-101042-mac.ad.tuni.fi>
 <6bfc61fb-6432-cb17-3312-53c6268e2a46@amd.com>
 <CUK5NKQKDAWO.2RCNF768IKZ9Q@wks-101042-mac.ad.tuni.fi>
 <ZNFv8f3r86zq3JSh@zx2c4.com>
 <CUOXZKF7DMRC.2R0HUQYKOKLA6@wks-101042-mac.ad.tuni.fi>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUOXZKF7DMRC.2R0HUQYKOKLA6@wks-101042-mac.ad.tuni.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: ccad11a5-d08e-460d-040e-08db99b07d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PskwUUrlN9SygHBwS8tyBAxxFnLhD1Lq4UD6+zT1l/Q6an8FN7lrYe0ph8vZH1L+/wg2AkqUsO53+h0SuOT7VqUAdrRL+5OaMsdpEGBkl4cZ4GQCm3uS8PZko3rhxT4ZagXh/bI3WVwFlzpRMsOpxOkc9KfuBFNYWS7ft/u9naH9UKZpE9ygEARNdqEaq8U7lz2bbqqNoyNrrk4liFYx6am4Z0+GxPTXShZvuQ75HkQYq0Wmzu1zquVt60LTUxbwPGQwWE2ORWk+k9fhWISGZszadcsnYMdmWvzEk/Kvz7//elth7WrSMxIBylj8sK6kTBpWWY2cCIqxv5AGljW8h02m2hbmTQDWDgAW0x17qmjUPmbK++CteakgKZVzk3PVbyeQHgb4ZtSyBPrp2TS1uez55ea0MsW7PHD3Sc4NtlVFjL2xLnIJyIoR9maY2UYfnOTfQdSUfkqNlh81YfF9RH+VNAu4yJXz31/gUW9Fr1nbT9Vp86p2QT3fcHnKGaBB9trvwNuPP8I4qygAUg4yjuZIVeCGVFvaouJ015PAHSJ8M8SVKYmN3OZhKdkPDIIVm0OwcBF6rtdCLh4qTjA+Mx5E6PyzJZhjy7ApUE3XX41pf/r+kdYJmpQn7P/FdBJt97tlMxoGhenLbPkvulHyi5csrnhMQ2u0si7oAbgKHu5QpEBH0hK5egw3psqBeZzB+0cWuvvAGtZcjezeDtclA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(346002)(136003)(186006)(1800799006)(451199021)(6512007)(6486002)(966005)(478600001)(66946007)(66476007)(66556008)(4326008)(316002)(6666004)(5660300002)(110136005)(31686004)(8936002)(8676002)(26005)(6506007)(53546011)(41300700001)(31696002)(86362001)(36756003)(38100700002)(2906002)(83380400001)(2616005)(17423001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Um5CM0g2WWRtNGpQcGtjR0JnMjZDQVFLVzBmQklBK2NwaVp4d3lOdDFZQ09X?=
 =?utf-8?B?MmpGMEpQREYzYWZQd0FnQXdxeUo3NkRtRWFGOER3NG84WkNoc0xOUVhIZGQw?=
 =?utf-8?B?YzZOWlB2ZWtQa0hNTWlPa0NUSGhZUFBzT0dmUjRsRkdtNkx3VkJxQ0o3cnRZ?=
 =?utf-8?B?VmdrWThocmFqVmNYSFMzM3Z4RnpBaCt4enozNWZ3SDZDK1UyRS9tek83QjlT?=
 =?utf-8?B?VnZJMHN1Kzl6eVlhVDBXeFRHMHIvZ3VYT1RSMS91dk0zcWxENnVON1lid0JR?=
 =?utf-8?B?dWc2OUxIRi9vZUNXTG5DV1lsZEo4Z0JIWjlWQk1CS004enJLdHVSTHg2aVVT?=
 =?utf-8?B?NlVaVk5TZWpGcUtUa3F1N3JVRjFQN3AxdXliM1JwdWlpdXAySjFnWjZXUkJ3?=
 =?utf-8?B?VHkzMjIvYmczWWNuWnFGbldxS0VCV1Z5TDVwNzRlc1VpWW5WdUNvaVdvaDNY?=
 =?utf-8?B?WEE4N2wwdWwwYTk2TzJzRU8veHFZUnlONTU5djYxc1NyZitGRkJ0bWM0YkFE?=
 =?utf-8?B?Sk5RbjRLajM4anJSZS9XVUQ1TTRIcFdhU1BlUEJjZUY5YnI0OVp4Z1hEV2Np?=
 =?utf-8?B?SmxvY1A5RklZRmpTMGVYMDRBVVhDOUFNZ3ZvS2xXQ1U3dnJyQlB2NkZPMFc3?=
 =?utf-8?B?UUxzb3ZzT0YwT2t0K0xvcS85RmFaSko3dEtVWWgvNWpnaVFWYnA5VVgyWEZw?=
 =?utf-8?B?dFJLUS8rbTNPN3p5eFRUSko2eDhrcUVUWCtCUk13S1BSek94dUo3Vko5enlw?=
 =?utf-8?B?eUNDWlBGS0tOOW4vd3NqUnc0cFJOcTdmaTBtRFZsUi9hNjJEN0l2Tk1PaXFx?=
 =?utf-8?B?UUxQZ1M1SUs2blRoeGE5NGtlMWRTMlBSV2N5Mzk4dWNRS0ZhNklCUlZzazBD?=
 =?utf-8?B?aUVhZEJMd3FONGg4T084cDREYlV3S1RENDc3OWxlVnRPUFlwUTQrNTNFWDJJ?=
 =?utf-8?B?dUNZM1FyeDY2R0ovMkp5eUxncElCOEt1TENSVDNjV2RGMTZrZkpaSXFPeExu?=
 =?utf-8?B?RGo0VkdJMTF6Qk01RU15aVNtZWFWSzVzU0JQcnN0OS90YmVDczRxMnVIQlNt?=
 =?utf-8?B?K0tvM0lVMm0rUDBiT2U5MTluYjJDWWlFQ0dEZ0x3UVdvcTVIUld6QnR3a0FG?=
 =?utf-8?B?RmlPelNQbE1sVDlXSzZPb2pRZ1lCYjNid292cW9oTmpJQjQ4UTUzUC96dGJL?=
 =?utf-8?B?dTc3V0tYeEJ4MWYxNWN6QlpEakxUcyt2NFJNYlJkdjBXVmxtemU0dDVQbWIr?=
 =?utf-8?B?RWJEMmJqNHFmM1pidVQ5dUZneWU1MUhMZzRqVmJOZ1gvajBHbDExclBndVIy?=
 =?utf-8?B?VkVHbWFCSTNtRnA4ZC9VL0VSWmVVOEp4T25KWmZ4Wm1vVDNPZlk4SWQ0V1cx?=
 =?utf-8?B?Y2tCQWFiVm5kM3BJQStHd2dveGZlQi9PMWpZQUV4ZDhZUlN6bGFjRS9CY2N2?=
 =?utf-8?B?SUo0MUZyQTdpeEQxL3ZnR3U3cDFNTnAybTFkMk1HcE05UWx6bHJuTHo4SE0z?=
 =?utf-8?B?YjRwRjFyUDV6Rlc5aHlGZ2Jma1NuRGtURVNleG9aU3hNMEJDM2FPcWtkK0Fo?=
 =?utf-8?B?TEllUmRIZmdXUjlPamMyVDZmbUJsWDExdTJ2ZzhIcDNpS1ZOV1IyZ2xMbG9G?=
 =?utf-8?B?bGF2TllNYkZYT0JiaDJYekxFR1pVL3BvSGFPYy9CZGdXNkRZYy8xd0x5ZjJD?=
 =?utf-8?B?NFpDeU1lbnNMTU4rSTR3cS9tR2JpeCszcDY3Mi9nS0UvVXJTRjBVY2JOdm1y?=
 =?utf-8?B?ajZQK0R3RDl0R3VuTXFTYm5RZTh0UlRjL2FUL0tRdnljSzM5QjNMYStIZUkw?=
 =?utf-8?B?TUR3bEprV3dDL1NVWTNJNFpnYVB5MjJFSVFyOGg3TWVuY3FHWlNGNVA5ajMw?=
 =?utf-8?B?VlFiWStuQlB3Mi94NGtNcUVRR2pmcC9nZzV0Q25pZHBmV3VxT1pYYm5oRFdD?=
 =?utf-8?B?UWY4RHhRRWt0RVphaHF4QmwrTExjcFBQbXlZWnZGSkNtSUZLek51VHhDWHk0?=
 =?utf-8?B?Z2w3Ny9jY1h4dVpFR2psNTZUdVkzcmUwa1A4K0NqaEJja3VCQ1IvcGdEd09k?=
 =?utf-8?B?M2hLME5OdmQzb2VoWmF1RVFuOC9rUWFUeEZkeDNMUGsvR1dPb0NiaG5aajRt?=
 =?utf-8?Q?T5JPdFk40nd/ih2dUGYYoKhUE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccad11a5-d08e-460d-040e-08db99b07d7b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:45:50.3416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11vbttxWbcXxd11ajsMt4hMUMUOEc10L8d63211Uf4n7fECAD0RJnNdwVLz4JVlSBhJdmwLj0Am7iMymCCPAtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6990
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/10/2023 9:42 AM, Jarkko Sakkinen wrote:
> On Tue Aug 8, 2023 at 1:28 AM EEST, Jason A. Donenfeld wrote:
>> On Sat, Aug 05, 2023 at 02:39:11AM +0300, Jarkko Sakkinen wrote:
>>> On Sat Aug 5, 2023 at 2:21 AM EEST, Mario Limonciello wrote:
>>>> On 8/4/23 17:54, Jarkko Sakkinen wrote:
>>>>> On Thu Aug 3, 2023 at 9:24 PM EEST, Mario Limonciello wrote:
>>>>>> The TPM RNG functionality is not necessary for entropy when the CPU
>>>>>> already supports the RDRAND instruction. The TPM RNG functionality
>>>>>> was previously disabled on a subset of AMD fTPM series, but reports
>>>>>> continue to show problems on some systems causing stutter root caused
>>>>>> to TPM RNG functionality.
>>>>>>
>>>>>> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
>>>>>> that claim to have fixed or not. To accomplish this, move the detection
>>>>>> into part of the TPM CRB registration and add a flag indicating that
>>>>>> the TPM should opt-out of registration to hwrng.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org # 5.5+
>>>>>> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untrusted sources")
>>>>>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>>>>>> Fixes: 3ef193822b25 ("tpm_crb: fix fTPM on AMD Zen+ CPUs")
>>>>>> Reported-by: daniil.stas@posteo.net
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217719
>>>>>> Reported-by: bitlord0xff@gmail.com
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217212
>>>>>> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> I will skip rc5 and send this for rc6 on Monday.
>>>>>
>>>>> Has anyone with suitable AMD system tested this?
>>>>
>>>> Probably obvious; but I tested with a system that can support both dTPM
>>>> and fTPM and swapped between the two before I sent it.
>>>
>>> Ok, great. I've tested that with non-AMD system things continue to
>>> work so I guess that is sufficient enough for:
>>>
>>> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>> BR, Jarkko
>>
>> Why is
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=554b841d470338a3b1d6335b14ee1cd0c8f5d754
>> in Linus' tree? After we told you on several email threads to take the
>> v3, and you said you would, you still took the v2? What are you doing?
>> I'm frustrated because this is not the first time you've been out
>> to lunch about this stuff. Now there's the wrong stable metadata and the
>> fix is incomplete. Shame.
> 
> At least part of it must be transitioning from mutt to aerc but point
> taken [1].
> 
> Should I revert the commit and send a PR with revert and the correct
> patch?
> 

It's all sorted in Linus' tree now, no need to do anything at this point.

> [1] https://social.kernel.org/notice/AYOm9K4QULTHJMCN5E
> 
> BR, Jarkko
