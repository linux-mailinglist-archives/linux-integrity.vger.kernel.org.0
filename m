Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADB373B8E5
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 15:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFWNmP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jun 2023 09:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWNmO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jun 2023 09:42:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E610D2;
        Fri, 23 Jun 2023 06:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVip/B6NWm7NRuup6rHvR9JYOLBFXnLNCnScU8RKdzfGx8CRovN/sE2kFNcbBZZeTIXZGxsSGueO/0hmkuXXGJpZ6kg9/j1osCPy72YCtTa2CXE9XZanEvu+EcFK779AjsBTHdTinrxec8hNjIFbhsyer6G8qCwX0q60UtGqsK+BueS+/DYG5wf9/cjPo6HeKPI5pkBOrQSwl6rlK2Pw/ceYEtf9HFtvPBBszwixxiwZMkVwaKEcKffjIS6kcwWhDLkBgVWvq0A4XKdu4gIO+T+vpoeB4ZUvx4M2fPkFynB/E8MbZGxh8liT7yHhCbQB955veGfw5PkpAVGmNR5Uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoTJBKZuHoGB+do7JTOHF2q4MyHxHFAuDubC64jYohY=;
 b=AMU3J4BWtg89EAU8LiGz+Ngo1oBu23IwFdQ+BiriXJa7d4KYDL1q0ePsr7gtVbp1Z05Pcu+8UX0URjSWuNPBRUmSOZH65rlLG9ai0AKwIFdCF3HQVtYujO+k3/lA8QfCbAFX34J5XtDSRDQ6q8kqBziVzp1XBQ5wNMI2Ud8UDy0fCoWuMZX2e9CjjTXNjkX3CstnGlhqqftZZO3dYUJZWCNEjsCsmYXOClTU99xnbi8kjvywyXcqjkFd4+guGf+loollaM73uouDngdBEMpR/I31fxHxejOyawrSvtLy6h6n3yT0T05unEUJ4P5mKjdNRP00dEMgeFWsARptxAWkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoTJBKZuHoGB+do7JTOHF2q4MyHxHFAuDubC64jYohY=;
 b=E2LjYeySYXt4fFxRfnF1WzTwYIsL+UnS4R/59YGU099xeQRBmi6/5CvrN2vma1j71UFeumUrrDSpGaFgvyJOHFmlD3vG5cgubE+AvPsClRtEF3g+Cm+Rjw55fBHOKxQX0Va3b20LJpAxD8Z6RLaYg+6Ikkyd5JuYPWqnSdVinzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 13:42:10 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 13:42:10 +0000
Message-ID: <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
Date:   Fri, 23 Jun 2023 08:42:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
References: <20230623030427.908-1-mario.limonciello@amd.com>
 <2023062317-daytime-angles-3c5a@gregkh>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <2023062317-daytime-angles-3c5a@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0044.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::19) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: d8cf1b89-34aa-49f8-6ddc-08db73efa4d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fz23oZ5RuqJDqZ9BbCXH/YwBJGDQBFI7EMZJZSWZpG4fvRrHGG5RqI2ouexNT8Noas2dypx/DZSYWoqJGc6s/azBPdRLzA6m52SdTzZjUTcFF4aZ8++nRPTbPIjjr+j7YjVkAkL6/A5O6/J0CurwA4Oujj8b8jL+sq2vwmBWYeJFYdzniOHQ8Ohu8GSb2xqMXWS96ZwUliUeJjDAMfu86CYtmykLtJ+dzfZaMlsujrfiwfSeZIXjtLthNgPGx0A54P3uvTS9JXMIML5+5rcavwnXvtU+ftG0uhdBqQke4MgWDK/7xuiGjef47pGGsc3pck+lJ2Gnvp3jN2JgDEbU/pc4rGCL7k0lUHXc/ir1v+NUTUJn7zJP5aarY5ccplGO7un03pRqL1M3Y1Bwdn47UDKGlckTUp7msBTJzoceuLbQJJTALDvUDqZK0Y72kg4X2UbAoxRcB5jmDTDtNvRDNX/ceW1/qgfjjrYKVtej6CHCA/YPZN65kxfkLhTSn8oKLw79Ykp5UtNSAxfZns8jyliq674JhkzCfDwEfTJh4hMt/1FiFCmQLbq8dVmvVlsY2KIR5yLk3gKzA3hQulXPTRcfNLEotuoXpQ/JnaRjHJpEvarZXEDo98/o0/EFbN1iTp1momCm2Td8QJmzMuv1Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199021)(186003)(31686004)(966005)(6512007)(8676002)(6506007)(53546011)(2616005)(6486002)(2906002)(478600001)(36756003)(316002)(54906003)(38100700002)(86362001)(66476007)(31696002)(4326008)(66946007)(6916009)(5660300002)(41300700001)(66556008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJUNXFIaDFBUjQ4aW1lN2k2SVh0ZHN3dUxOMEdiTWZQU3VBOWRsZnRBMG1M?=
 =?utf-8?B?QXdNSzhMRFN1azJnQ0YyMmo0VlpsaUkrWUg4dGFrRFZDcmd3TkdIaDBOaHp1?=
 =?utf-8?B?REg5VzhIekowYVIxNlV1OUVYdzBPZ1BTYlNNd3c3NDJLcGJEMnRTWlRpeUhn?=
 =?utf-8?B?MGR3VlJVU1B1M0o5RU1mdStxU3hnZjVOZmMvOFU4UmhsVXVybzlaOE4wWWNo?=
 =?utf-8?B?ZVFzRlJSZ2VISWoyREhBQlNuZXdXbHpIYWVGdE1zWEs0dTNyaC9tbWVHdEw0?=
 =?utf-8?B?NHc4TUxqdWxlRkwvVFZhMkRCZE9HL0xLOVRlVXgxOFZ5aEVuNmFZeUZLdEhE?=
 =?utf-8?B?aEU4Ymd1Ti90TFNJamFESVVpRDdTT25lZTljMW5BNjQ2ekxYTkFKY3pEMnRl?=
 =?utf-8?B?S1dkWFpDblJRaVk1MUxSTnNaeHBuVjNpTzN6Z3pxSTIxN0Zub2UzWlZXUCtH?=
 =?utf-8?B?dWs2Q1ZyL1lhSW13U0FIc04xSUVJbTE0bDVwR09BalduTi90MytHQll4SW9G?=
 =?utf-8?B?TFZ2b3dXcVQ1ZmxPN2I5bkU1c2pHOTJ5RTAzenBSczVuZGMxTmNBbEV0aFlT?=
 =?utf-8?B?YmdDd01NbThITnRROHo0TjdMMjJqcGJGVnVrU1B1TDZYbFZ5T0RTYUFWOW1O?=
 =?utf-8?B?ZXg3aHRsVklWTWh3M1dmWHhiYk1Fa0dEL1NxcUdZeEtLSkpkMS82NkpDQm9Y?=
 =?utf-8?B?aTlGMU9rZ1VwV2RzdTd0aDloc3dDUHlhaUtZRGE1UmRyRVlFZ2pqdnVuaml5?=
 =?utf-8?B?VlAvOGQ2ZXBYME04b3FlZDJpeFdVdXhzclZScmZ2S3pVSUw0REVhTlZUWE5w?=
 =?utf-8?B?b3psUFpnUElyZCtXaUdWeHZtdWgzNkYwc3hxcjZLUnhMN0U3cnhpQkgyaUF3?=
 =?utf-8?B?b2hYYWw4SndnRldQcFpRM0hDRVR6WkpKZ2hxL2NLd0p5NUVZZ09NTDFuQkN6?=
 =?utf-8?B?RDAvc0NIZ0RUMEd6SWRPSFpreTd1OXpNYW1zUW5DZ3ZhR1NoQm9rK0pCcit2?=
 =?utf-8?B?enlKNFRzUm83c1I3Z2FHYlo3ejhGMU12NW5MUHBvbVM1UXVKM1ZjaU5vNWQ1?=
 =?utf-8?B?MnVVdWZCTmY0eEtFWUwyUXRzejhCVEI0VkRIODJGT0RGakFMaXBEY1pwUUJt?=
 =?utf-8?B?cmlLTm1Od294Qit4RHhMclBjQ3NzWWRCWDlBQmtpalozR0NtWXkrTWJ4NnZ5?=
 =?utf-8?B?NUNaZGh6VHpoT3c1YkVwdVM4UURrSkk2KzFDczAvVDhna2hZMkpreS9FV3JW?=
 =?utf-8?B?R0xyU01lOGY5TzIvb3FGY1RNbW5oaW5uUjRuQ0xValdkVGZmOWtZU01wS0FG?=
 =?utf-8?B?RDFvc3BPakNMT2lXOUVNV2NMV3dzcmNIQWwyWEdkZmloMkNyRi9Za1FHdWE3?=
 =?utf-8?B?RFNJdkJFdkpIWklKNGNPVjU3bmZxTDd0UjVDRU96d1cyclRIS0FwTUg1SUVX?=
 =?utf-8?B?R0UvWEJtV3l1TC9mNkt3T0hXUkRUMytrR1lIZjFaNEZ6Z3VGNGhBbklQYTFn?=
 =?utf-8?B?VmM1eDZJZm85L3FmZkxOOHJYS1g0eU10cWs1NHE1NjE2TVE4ZDlDVEpqeTJI?=
 =?utf-8?B?Snc3T2RCTG9tUmJFdEFpdEtVN3dWRnZVallFQ3owNzM2UG5kRXN3VldwQUNG?=
 =?utf-8?B?MWNnQ1YvakVPR096QkxKOFN5b2tMQXZvL0ZPemdzM3BZKy96RkJ1Zlh4a0pw?=
 =?utf-8?B?VTlnQmdleDN6QmZIYjFsMjJpcVVIbWJuMXc5aityWm5iam85bzZyUUl3QVNB?=
 =?utf-8?B?cisxdm9wNmpHZU1qZ2JoalhjQlVSdEdrTjlRWVRxV3MrOEUvMU9UbU1lalZ0?=
 =?utf-8?B?NlpXZjN3bnZ3YlJ0SVNVSXJxQUxGZ0wrMVE4WWNsNXF3RldaM1VmeWtPbTda?=
 =?utf-8?B?dU5sbTlVay92WnZnTlR0NWhrd3Z3ZGsycG40QzZVc3dmbm1xVXlpQ3FJS1Vr?=
 =?utf-8?B?R3BpRTBucmdxb1MwcCt4UFdLQXYram9ndXoySXpwWUFBZXNPWDV2RnhUa2pp?=
 =?utf-8?B?N1FXYUJkSzVCdDI3c2xwL3YxV0hjK2FVdnNxWnpxaDRDeVN2L2FFbi83a1lQ?=
 =?utf-8?B?OURFSGpBaElSdkh0MUV3S0ptUS9JdmdQR3dzakticjdZVHhuZVhBQ2g1ZnNq?=
 =?utf-8?B?VWFMMWVmbTZhZGJyWUtOMHZQSzU3ellnc1Z0OHhqako4c1VNbDlqeVRYeFNT?=
 =?utf-8?Q?0tjtFzn9Tun+5BSxDG8nYMeHE7aQ4wgXOjnJ9hz25C17?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8cf1b89-34aa-49f8-6ddc-08db73efa4d2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:42:10.4156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3zLLDwLFQO2Eo27+C/EAMWR94L9SfT0+yA/U6V8mJa4Ruy+oy0kl3a9EK017eAIlFAUSgDdmJFhhYGaeXQmLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/23/2023 1:08 AM, Greg KH wrote:
> On Thu, Jun 22, 2023 at 10:04:27PM -0500, Mario Limonciello wrote:
>> The ibmvtpm doesn't have `chip->ops` set, and so trying to check
>> if it's a defective AMD fTPM doesn't work.
>>
>> Add an extra check to tpm_amd_is_rng_defective() to ensure the
>> TPM being checked has `chip->ops`.
>>
>> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
>> Reported-by: Aneesh Kumar K. V <aneesh.kumar@linux.ibm.com>
>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>> Link: https://lore.kernel.org/lkml/99B81401-DB46-49B9-B321-CF832B50CAC3@linux.ibm.com/
>> Tested-by: Sachin Sant <sachinp@linux.ibm.com>
>> Fixes: bd8621ca1510 ("tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site")
>> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c | 3 +++
>>   1 file changed, 3 insertions(+)
> No cc: stable on that list above?

Good point, my mistake on that miss.

If Jarkko agrees with the direction of this patch, I think
it can be added while committing.

Thanks!

