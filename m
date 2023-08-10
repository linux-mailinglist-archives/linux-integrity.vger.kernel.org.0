Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D68A777BB5
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 17:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjHJPI6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbjHJPI6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 11:08:58 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F21E26B6
        for <linux-integrity@vger.kernel.org>; Thu, 10 Aug 2023 08:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIdPXE4zSLjy2JtLix3N1trW3VIDzLNscWEhxuEBFEg39NRmSYQRkwp2fapUqmHQAPR3ZwmonQlAxQJzq6IdI5g/bR4dkyA2dt4t+aoO5LLDLCGiK/iFa0qOnlWFj8TNN0j3D9aPMtLYRfW4bwuYav5XFYm4bnxstf5QF4vPtnb3bB17bqUUjKHRWrnDAfcRvyYH0JOUXHAiDr2HQ7IY7neLHJPynK1k/ut6Gk30Z3SWB/ITwJeSx48+t2SneRxYD63OsTCmzDgqTc/w+ZJ//Dpe4tXcplx1YpKOpS0BXbv4dMRhulK3YV+mkabw/8RyCE1+RlIo9LLNDFGu5PIGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiFFsNjMqEPU+sxGjU4f+duEkkVHKnvveudMJWKv1Mk=;
 b=h1hYXayr6J8fiaG7haw2qVZQWlVN9Qo/fJBb45MseXFTcHqlfIRAcVrDZPZ1gi9xmSbHQSpGV57MbiyhSrLZCBHmkDJilpR8mhNGnqKBLMYOubT54NQXaCs/tmwUYyBBERZLVGPFlnnA/ohrJZBkj1JBcXnoBitKBbJdJJfefAG1VUnY3hALbTnubU80jjmWjaMY5oMKv8JeXP6srtrstebTk2/9pBI7c8U/4WJ8oMCIJrqA2FfNTvrn88vwhdl6JVwvSz+6aT9zZc7tzdU5orTAg2MW1ev9z8CISiEZ0dyYAxEOeEnpVXz4jqK4e+5RSsiTjROPJ6JnYjuWcLO2JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiFFsNjMqEPU+sxGjU4f+duEkkVHKnvveudMJWKv1Mk=;
 b=OMKyRkUu141rDWHuBurXeDvsyZFWhrg7s1LEWdgpm120ByG/lJS6GW3oz0qmYK/LpQmM7kOEfemFkwv2IYCfg5rJtppaXGxbfU3zfTN4vkAB0mpLBNNFtyPXgpzM89Ak0zMLxUVQU4pIX/BPzj5TUbmeCn2M1lqbQZ2H/D6UM/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:08:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:08:55 +0000
Message-ID: <17b312c5-d8e7-4f3c-9b38-ba82233eb003@amd.com>
Date:   Thu, 10 Aug 2023 10:08:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: Add a helper for checking hwrng enabled
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     jgg@ziepe.ca, linux@dominikbrodowski.net,
        linux-integrity@vger.kernel.org, daniil.stas@posteo.net,
        peterhuewe@gmx.de
References: <20230808041229.22514-1-mario.limonciello@amd.com>
 <CUOYJ45WR5I0.3JFE0U1387QC8@wks-101042-mac.ad.tuni.fi>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CUOYJ45WR5I0.3JFE0U1387QC8@wks-101042-mac.ad.tuni.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: de25ec94-16a6-4b9f-ae36-08db99b3b6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9wexa+qi6OjdOk6HJ9+Jdlanttat5c+8JqZrFy0R704Y8/CYby1KY3/FHozBThYXs5nJADff+rXf8QC/jXRkleaE/ldiq/LVQ8vU64qkSgsSBDdcFME7hHwkC971knFLm3ZZt/FAkSa1iPsDFCLUN3oXsy62Zi6d3r6a1Q+1x4Bk1LOCNmQb9h66sZbUqGv9IDimJuhr9dPV7tMm3nbfJ+NbZyLKT/GOfkwHa3mCq6jAwZVKuiZdHu/odxxGz4IApSkvufngVaeUUnkGGI/RvqIUO7tJ26GwhB7R8uFMgFX8PSeGd9iay8FDNiv8WRpjb1tVuA0gMvBgFP0oU+56zx4LQdD+rXBKd9MwA/mKMYxoliy8del101QwnUKtT0LEJ6StWH6wPW49t+qfH3TpAoOu8HpFrOUOFt3Mib1UsH4rPQKseyZsQvLHxtEER50tdj1aNe6ZmS0gFE48w3kt/1IyRVvSt7+2BFERrRVNqoKGu+LyGK3VQ3TJrOprzx66ci17mbGwfaVbKcPB9o4ZBGi84SEu8KdCAFrpLDJPJ+Dq8k1l2lq/QR8mi6rb0aJbI0A3hAUq9q1TNuL/noUyB3b6ywm+gyS7qg79hoaMkTaLIpHWtHAKdUb6OitAqujbv1OE383Z8Z5FUBPillKIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(1800799006)(186006)(26005)(6506007)(8936002)(8676002)(53546011)(41300700001)(36756003)(2906002)(83380400001)(38100700002)(2616005)(86362001)(31696002)(66946007)(66476007)(66556008)(110136005)(4326008)(6512007)(478600001)(6486002)(5660300002)(6666004)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdPNkxZVXNBajVyM2xxc2hoY3lxQ3RGN3hoSm9WWUM4REZJbjlLYjc2dlFV?=
 =?utf-8?B?cFRZYzdqanlMQldnWDRpR3g2R1NhRGxnNFdSN3R3TWVzQ0NNNDRySXVKYzMr?=
 =?utf-8?B?YklwZ0RvRllDWUs1MEo4QmFkUDhMMDZXa3Z4NGlHUGFGdVEvY1lUN2NsRnJP?=
 =?utf-8?B?ZytYZzl5cHI4ajdMZkpXM25RbmJ0QlduZ3FhemZRU1d6dmlnbW9BazZDR2RM?=
 =?utf-8?B?T3BsNXRhSE1kWlVBRlUvSWxoZGs0aUhRU0lCNCtiZU9kZlNubllRVnZVeDRU?=
 =?utf-8?B?Tjk5RUlCZWwvQ3ZESFgvVUwxRk5oV0V2blViQjd6cUM1RCtnVGN6MkM0dm9m?=
 =?utf-8?B?OVBHbXF1dzk1OWhacE9NRWVHZUVNd0ZNUnpHR04vNVJjR2d3Wjd0TlBGM01w?=
 =?utf-8?B?eU0zVTY2SWN1bkFEc09TbEFlN3VKSFFpTUZFSVdMdzJIZlJWTU1XRTJ6YUxM?=
 =?utf-8?B?VnQ0VWpzcGszQU5qTGtpTGRFZVhJNjl6U3ZDejBTRTR2MkUyRDMvaDZDcWRF?=
 =?utf-8?B?d0ZrVksrZnBoS09OUW9Na1pMVmd3dURlYW9ub3VzS2t6UFA4UGdadnFoMCtn?=
 =?utf-8?B?Ri9OSGg0aE9Ba1ZZNHQzYk5hUDExKzUwVlFaa0NGOHpVK2NPR2w5YlJhdXlW?=
 =?utf-8?B?M2Uvc3F6cytJb1ZzUElWU1YvNTU5TzA2R3IvZFZrMW42dHZ6NE5mVGhQSjFi?=
 =?utf-8?B?UElrQVlQdHFHMFpQdlIyR3ptaDF5Sm5LT2Q1VEhYWVFSbmVRVVUwSnR4MUNw?=
 =?utf-8?B?Tngya0JFZkp2QS9pVS94Skxia3ZtMVRldE96RGw0eEJHbU9sdU0zYWZNUUlu?=
 =?utf-8?B?WmkwNVF4YjdvRXJCNnlnYVloVFdPWkd6K0VHb3JMd0VCdWtaaXRxNVlqM2Mw?=
 =?utf-8?B?dUc2Z2I3bSsyTjdvU1pQb0JMQVMrTmR6MWkwTFRjTFROekduOW1FV0hRa3Zx?=
 =?utf-8?B?Syt5b0VDM09yS1BsQWNTWDdvVGNwL1l2VkZwYVk3ZWJPblA2VG9Ublp1NWxy?=
 =?utf-8?B?NU0yRXJFNGJPUlVWTFM0M2MxRDROZXdVQXhnejQzcTdmQS9sbXBLbk4vWUxJ?=
 =?utf-8?B?OFl2Q3c1R0o2UFJMYnZDbHlQY2ZhVk91VnFCaWlHdlEwSXFnSnZ6S0ZhejlI?=
 =?utf-8?B?MDQxVGo0SXpiblZ2eG9tYTR6dmhXUFdJYVd3U3lUV3RkQmlvVTF2R01PNU5J?=
 =?utf-8?B?MURhbzQwVWp3Y1NjMDdDZldJTllFeWNWQVczN1NTSTU5VnhSQUhpOUFqRXRj?=
 =?utf-8?B?MEUxa1pJVS9RcThpUnpxSVNERDRheFpZdVo4NXluZjFNTnN3T0svc2diTGJ3?=
 =?utf-8?B?dC8vbnhCTmJvNEZGNFh3RERsMDN5R04xcXYrT05aV0FZeVlrTEFYRmlETFVt?=
 =?utf-8?B?SEJnWHR4a2Y1UDBvMm80WWlvclZwRkx6cXVuTzczWUl4QUdFVXduc2dWZVgr?=
 =?utf-8?B?SHNFckdSZWlveHhic2lPNHVDNFRjaUhlTWc4Q1ExcWtpQlZ1ejRYeTVSZERV?=
 =?utf-8?B?RHVEcWtOaFpmZDZyako5ZDdTMFVkQXBxSzJ1c3RYUDVVeDhNYjhkdThKUHYv?=
 =?utf-8?B?TjNoTWhBV2o0TUFYUllIaHp3LzliUk1tanpjcnE0TXBSOEZkSFVKVkpRMzBC?=
 =?utf-8?B?S2pJOUliRlN6eWZHSGhuY2I1Z3BFZUhuU1hBVVNPRGdsdzd2dFpLelB0Yms5?=
 =?utf-8?B?NGgwSU9vZHBlRDBtclU3c25QT0VMR3NsSHVDSnV3eWdVTFRneFdUdWNPVisz?=
 =?utf-8?B?eVZnT2tSSU9rVFpwdnJ5eWRGWVlYY1pXeGt6TXoyYzFJSms5amlUMWphZ2Nx?=
 =?utf-8?B?TGg4L3N5WmZGUWlTclZJaVJhSFlxcEI3SFlZQU54WS8xRHJTRFduWTBUcjAz?=
 =?utf-8?B?ajV6UFN2MmdlRm9rRi9UaWlSdHF0Z1hKamQxR3psSzBJWjNvYmZwUDVYNEh3?=
 =?utf-8?B?N2Rib0xmQS9qRlpSZU8yRTVWQzRRMG90RFlsZU5VNzNrdWk3QzIwV0cyWWVa?=
 =?utf-8?B?REl5Y1lVRDB5S3BhSllObjZPbHVuVEo1MTFUeVNCNHMvYWFXcVFpaGNTVXUx?=
 =?utf-8?B?TE9HT0xIT2VWUXpvR0UweStnS1p5VTUweHh1ZHR3eFVLMDRoNDY5SWtqU2N0?=
 =?utf-8?Q?TRaNDuX13Q4wiZ//+5O1zuLzl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de25ec94-16a6-4b9f-ae36-08db99b3b6eb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:08:55.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hxNaN3WZbHDGKBe+PNQkRTZ/PdeQ1+YVAv6fe5DNydWCnwV+UwVzXTXN/aQEdAJZPajkwmJusbHvfyCs+XSKYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/10/2023 10:07 AM, Jarkko Sakkinen wrote:
> On Tue Aug 8, 2023 at 7:12 AM EEST, Mario Limonciello wrote:
>> The same checks are repeated in 3 places to decide whether to use
>> hwrng.  Consolidate these into a helper.
>>
>> Also this fixes a case that one of them was missing a check in the
>> cleanup path.
>>
>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index e904aae9771be..ea6b4013bc38f 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -521,10 +521,20 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>>   	return tpm_get_random(chip, data, max);
>>   }
>>   
>> +static bool tpm_is_hwrng_enabled(struct tpm_chip *chip)
>> +{
>> +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
>> +		return false;
>> +	if (tpm_is_firmware_upgrade(chip))
>> +		return false;
>> +	if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>> +		return false;
>> +	return true;
>> +}
>> +
>>   static int tpm_add_hwrng(struct tpm_chip *chip)
>>   {
>> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
>> -	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>> +	if (!tpm_is_hwrng_enabled(chip))
>>   		return 0;
>>   
>>   	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
>> @@ -629,7 +639,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>>   	return 0;
>>   
>>   out_hwrng:
>> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
>> +	if (tpm_is_hwrng_enabled(chip))
>>   		hwrng_unregister(&chip->hwrng);
>>   out_ppi:
>>   	tpm_bios_log_teardown(chip);
>> @@ -654,8 +664,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>>   void tpm_chip_unregister(struct tpm_chip *chip)
>>   {
>>   	tpm_del_legacy_sysfs(chip);
>> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
>> -	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>> +	if (tpm_is_hwrng_enabled(chip))
>>   		hwrng_unregister(&chip->hwrng);
>>   	tpm_bios_log_teardown(chip);
>>   	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
> 
> Given my previous queries: should I apply this or revert and apply v3?
> 
> BR, Jarkko

Linus picked it up already directly.
