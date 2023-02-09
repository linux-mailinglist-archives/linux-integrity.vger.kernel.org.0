Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA9690D39
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Feb 2023 16:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjBIPlv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Feb 2023 10:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjBIPlt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Feb 2023 10:41:49 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CA11705;
        Thu,  9 Feb 2023 07:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/kREO+w++CGIryAXXRWD0YGF5Ze9rlVjwgO30+zgfro/LxnM0ToH6AqQFipOO0lGF/g/4mgUOU0y5U7aPtaTA/cTOUvMnJS/GftcENu4sExs3kJBQuEYbBOLZIfb2QfsbM4l00EUBhxGU08zssw12TQRiNIznONNSwXE74/tQR1/i0YiPa+CQcLN4+4K2WgKZE2XZP4wJPXCFVjtPR/JaqWdyBtMT2PBPKSQylixmeukm7QaHROVv26IoEFgIvTCCOl/Ce9WjO2OrMXZVhhgliAzFJT7VY3PEEI0TVxoIXpwmf9Ih1qjfZhXIBf6wMBpv8ilCpepbGEYhjnvt1RYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyhskwD3TT/SGBdL8wqEqY8p68+eZXYetRcjdYDc0lQ=;
 b=MzezQoY7aScNqh0MbRpqJNsemeyQ2E/bU0xQA/iNVzZonpF3xpQSvK5QNtEAmSRnHh0x+C1Tg0B8GMK7RiRbq/a8jg11VS/4vIImPqzIrTDR2n4MlKB8vNKJ1o/9GrteMIS1HMUSBRzfCJ0JR6f9nr0Jr2kt6I+QiQIPPkK7n4tcumoHqZOI6FLSohGUa1ryZBYSRwH3Zkn5bMEldG+V6RtfqvC8wlDt7UIX8KhD4SfzTJOTAUZjQcyE4Bu79aD3Px/0DjKDa27fkz1lyUnOtHt41o9iGcNkANTGSAhR/VqePse4rCRZW7I+A371FCMoGVrMtSzsSfpGZCqQ+b2gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyhskwD3TT/SGBdL8wqEqY8p68+eZXYetRcjdYDc0lQ=;
 b=0iSZzuj3LpocYBVgiXXiJOtbFLP4zvnhfcG27+v9Pg/aEd46fpCsLBhD8sMz/2c6WC4VPl+YakRbLHaUQIBXVT4M6BJRoZU5+QmsTjPePpEcN6FGCpE5Cc3b0+ZAQ+GXO4EVyWNAHvgV1SDSVDciH7QaJjqgSNaUfmfHUA9Cyt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 15:41:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%6]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 15:41:43 +0000
Message-ID: <543c2e9b-6d82-7ee0-9a1f-e3176aba16e2@amd.com>
Date:   Thu, 9 Feb 2023 09:41:48 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH RFC] tpm: disable hwrng for known-defective AMD RNGs
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        regressions@lists.linux.dev, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <20230209153120.261904-1-Jason@zx2c4.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230209153120.261904-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4547:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b932383-9734-4c27-7459-08db0ab4252f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alDokiIyReKxhfJYHkGBOy1oGBqEWAK8uQy2Wx2PjoqOHomw6uU9Jm2Jr3eDtIHCN5Add9rhblUjvqxDDr1rc7J1ndCQ2HN6KUxJNGT9jUd4/kwaeaZxECPPL8d6SzJ7ZvalRCc/SZHK5WPLwiRC4fOTOG2AgJVMkBJ7MdUxh/VQ+Gvb4LtmRQhR52szPOpbXZKLqtg06A8lv88xM/vR+t/udYvVp7MunvwjOixYRuCkS+NYJ02vLj6OJD9ZYAkKGi2Faq76OvsVy3GdAQZNo9ajcUBqT47H1kR3FHbaK5z4/0kjMdRZf7WFB3PXu1cfoCpZfy7VXn6/zC2QqWn/SLohc917vO0OxCDnhq2sW4gumsqhjfxRLbXGxNnu6g39nEbKUGiYc/kspNC4GKueJcz6xoVqTL0jFKKeT2u9wOHStpkZJRrbpMmHGaZn5n+waxUCGvO3KABmosFHFKiTxtgC4DC3dHVkyhm3odaIyGf9rFbhsG2BASXkmNmFn4tQZ7WO3bbuIehmVIGOhGrJ2nEL7iq+uVVto3O4RZ8SvTcFMf9x9JGOTktzS9uSrLNW/8eH1CtM2knf7baOZEaPVbQwZRXpTrsknyJNzn5S2wivl/0gNY8n5YSh0E0qG993uxNaeWE060CgBxdWON4LklWmpG9v/ZyqT3zznSUHdVXzOhLeahf+PWLY5/ukZnp87cRkcBPYpBC0gep6w2VIu33+n+o5aNPr79R3WKTKP4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199018)(66476007)(4326008)(66946007)(8676002)(316002)(38100700002)(66556008)(83380400001)(31696002)(54906003)(86362001)(5660300002)(6486002)(31686004)(478600001)(6506007)(53546011)(26005)(2906002)(6512007)(186003)(36756003)(41300700001)(8936002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk14cHd3d2t5dXBrSjFraWRWY1p4anpieWhMS3R5VHNDY3daMi9uSFBJd1Vj?=
 =?utf-8?B?T0w1a2l3WFpDVmFvbSt0dDh3Z3FCdGJQRERQeFpLL2trQkIrdlRXTTM3MUoy?=
 =?utf-8?B?dkxuR3NBNllEc2RndlFuRmtOOWRzNU1TL2ZVdmZ6RUNXQjEyak5iM1J5YklF?=
 =?utf-8?B?WHFBL0ZmMHppeG9DQkx5R1JXTXlFaitiaU1mUkJHaXhaSFdsbEhpYVB3ZDlR?=
 =?utf-8?B?SnlMWWdYVnc3U3ZWY1dYaEdyaU9YeGV4SXp3ZkF5NTNjS1RiTTZURUdObVp2?=
 =?utf-8?B?Mkp4SzRQbENrVVZkYWxmRlBFdDAwYzU1S21scFIrNXZSU3RNdlVnaWNGT25o?=
 =?utf-8?B?MldscnI4ZGxoWWVSTG5pTVd4VjVjWDVTeVdqbEZZRTlIV29pWnFscTVaSmxj?=
 =?utf-8?B?MGUvdkpKMDlzeTlIcGZydVJTVnBHM3BPSFVDdnJHWUNNZzFua29YR0MvOUlz?=
 =?utf-8?B?bzl6T3RvVVh0TUVIcWxsVXYxZWl5Y3ZtREVmblIyQmV4OU51Uk9EMlF0Mm81?=
 =?utf-8?B?aDdZNUpJZ0xuelBpMTk4MGswREFudUVKMzJSZHpxMFhiTlZoSWd5dTFVTjdP?=
 =?utf-8?B?Q1dSWHREY1BEQ1dPQkY1T1Y1RnhaT2dzTDM4L25wTzNpNDk2eUZ5UEFzMmY2?=
 =?utf-8?B?c3pQa21XSFZDU0xMQ1pSRjJQY2VSR25yZFlmbDVWekJhOGFnNGM1UGRZMGg0?=
 =?utf-8?B?MjZyQ0NHbUdQR2xCNFBVUnU4cDlXdWI0S1Z5UENRVXlxYzUveFFSMU1EZTdv?=
 =?utf-8?B?TC9vaEVabVlEeklxK2U5d1F4SlJzNldlVnMrSm9vM1QvcktoM1ZxczhUd2pL?=
 =?utf-8?B?SDIvNmRBTldzQkJldDd6L2pMMjFvRCtoRGorWWNMMFIyaFltSGxVVGxJemdu?=
 =?utf-8?B?K3EzY0pvdk05bW5uZnRxcXQyQXdMTmpRQ250aGd5MVQwL21TQy8yRDlFSGdU?=
 =?utf-8?B?Mm5sYWxFZnFvNTg5c3BRVS9BeGdwZHJvNWcwK1g3NDBmSEdJQkhDN2h1ZHIz?=
 =?utf-8?B?TWd5NSs1eDkzN2xPWWgrdWFHYUxOSkVKZVF3cnV6c1JxUVlZT1FFT29CN00z?=
 =?utf-8?B?Qk5RRmEvRFFuTi8rL3FmQzg5Mm1sbmpBR3pXbFZLSUt5VHIzWmRPa0VmbjZh?=
 =?utf-8?B?YlJ2T3FyQVNtWEM4R3BFa29yNVZZSzRaL1BpQmthVUhRQmR2TlRqbXBLTGlu?=
 =?utf-8?B?NExJSjVZOGNISmlXK1pWNlMxMFAvRWZqSnFFYkNjR2RXc0tSNVNwREd3eVBi?=
 =?utf-8?B?bFNaMUJGWVFjek9wRzk5TEFFWlIvamtIYXRzZjhST0RGTjZxRmh0enUrbEVP?=
 =?utf-8?B?WUczM0FVNCs3b29DM1hBbWVkbWIzOUplUWk1NVhvZCtld2grL3h4N1NQMXpw?=
 =?utf-8?B?eCt2TkdnQzREY2JLTFZJRzg4MFdUUHZzRTVIa09ETW9UZDIzNkZQWVhqNTN6?=
 =?utf-8?B?QzY0UmVNV09MbHlpeFlqbk4wUVlpeTZkTHJaWURkeU54eDNYYnVzWnh5OVN4?=
 =?utf-8?B?ZHMxZjkybmQ0OXl2cC9LNlBEK1NBTmZ1LzFDdWE1TTFWSVBSd2ZvTDEwWTBj?=
 =?utf-8?B?V3UzaW5qNWM1VlBvRTlGMG9kS3JrbEpvaWYyaDZmK1EvWVdsN0NITnh2eE9S?=
 =?utf-8?B?c0pzSFIvMG1BT0hhYlNzTlFkNytraU5zNDNQMTBPRm56ZExxT3hHak8yR1pr?=
 =?utf-8?B?NWhmcjY5cDJCYUNlUnpSVkNoaFU4M2xnV2wvaTgxbWIwY244Y1dqQnZzSTRq?=
 =?utf-8?B?STl4bnJKd2RsQ0pqOHJaOVJmckFlM0lPV1VwVGxlNWUwZ2t3TXlBM0U0Q2tL?=
 =?utf-8?B?T1FHdlMxY0J2K0RpWDFJa3hTVHBEeFF0YkxxNGNSWHFVKzNxOTNPRTZWTWxN?=
 =?utf-8?B?THp1dURMS1kyVkx6aEFHM1dWb3FOaWp0Si9aNVZZeFROVXNEN1h1ZE1MQnhL?=
 =?utf-8?B?WkcrUVVMdUdsL0t4c3BOTnNVOTlnZDU0Qlh4SmVUaGNtMXIwQ0pXZGNlTHZR?=
 =?utf-8?B?VG11S1NFcGRyVDREWFZlZitpY0xtY1hFWG90TmxEMEkrdWpMUEp1V2VpUVRC?=
 =?utf-8?B?TjArWjJTQ3JXWVlZeDFDaUsvTlRsQ2U1WVYvaXljK2ZqZnVRY0ZLMVRMR1k5?=
 =?utf-8?Q?89RQKiQ+lcwl48o+bPu9athx6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b932383-9734-4c27-7459-08db0ab4252f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 15:41:43.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zYzPOqADFeRfXFDdzSSNvVUAxw7g5RFAdlbTBCZG2QfQDl8AOvloGM5BQRx3BYn7MeKSX1PR0OhsH/RIocCgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/9/2023 09:31, Jason A. Donenfeld wrote:
> Do not register a hwrng for certain AMD TPMs that are running an old
> known-buggy revision. Do this by probing the TPM2_PT_MANUFACTURER,
> TPM2_PT_FIRMWARE_VERSION_1, and TPM2_PT_FIRMWARE_VERSION_2 properties,
> and failing when an "AMD"-manufactured TPM2 chip is below a threshold.
> 
> BROKEN BROKEN BROKEN - I just made the version numbers up and haven't
> tested this because I don't actually have hardware for it. I'm posting
> this so that Mario can take over its development and submit a v2 himself
> once he has confirmed the versioning info from inside AMD.

Thanks, happy to do that.  As I'll take over some comments are inline 
mostly for my future self when this is resubmitted.

Perhaps one of the people who can reproduce this right now can confirm 
this works?  The version number string should at least trigger one of 
the reported systems to avoid doing this.

> 
> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

At least as a note for myself this needs:
1. 'Link' tag to the public advisory for this fTPM issue
2. A 'Fixes' tag to the commit that enabled fTPM as a hwrng source by 
default and exposed the issue.
3. A 'Link' tag to the bugzilla.

> ---
>   drivers/char/tpm/tpm-chip.c | 34 ++++++++++++++++-
>   drivers/char/tpm/tpm.h      | 73 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 106 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 741d8f3e8fb3..e0f8134d31a3 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -512,6 +512,37 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip)
>   	return 0;
>   }
>   
> +static bool tpm_is_rng_defective(struct tpm_chip *chip)
> +{
> +	int ret;
> +	u32 val1, val2;
> +	u64 version;
> +
> +	/* No known-broken TPM1 chips. */
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
> +		return false;
> +
> +	/* Only known-broken are AMD. */
> +	ret = tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
> +	if (ret < 0 || val1 != 0x414D4400U /* AMD */)
> +		return false;
> +
> +	/* Grab and concat the version values. */
> +	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
> +	if (ret < 0)
> +		return false;
> +	ret = tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
> +	if (ret < 0)
> +		return false;
> +	version = ((u64)val1 << 32) | val2;
> +
> +	/* Versions below 3.4e.2.9 are broken. */
> +	if (version < 0x0003004E0002009ULL)
> +		return true;

We probably want to also do a 'dev_info_once' or 'dev_warn_once' here to 
let people know that they're not getting a fTPM RNG so it's not a surprise.

> +
> +	return false;
> +}
> +
>   static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>   {
>   	struct tpm_chip *chip = container_of(rng, struct tpm_chip, hwrng);
> @@ -521,7 +552,8 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
>   
>   static int tpm_add_hwrng(struct tpm_chip *chip)
>   {
> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip))
> +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
> +	    tpm_is_rng_defective(chip))
>   		return 0;
>   
>   	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452..830014a26609 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -150,6 +150,79 @@ enum tpm_sub_capabilities {
>   	TPM_CAP_PROP_TIS_DURATION = 0x120,
>   };
>   
> +enum tpm2_pt_props {
> +	TPM2_PT_NONE = 0x00000000,
> +	TPM2_PT_GROUP = 0x00000100,
> +	TPM2_PT_FIXED = TPM2_PT_GROUP * 1,
> +	TPM2_PT_FAMILY_INDICATOR = TPM2_PT_FIXED + 0,
> +	TPM2_PT_LEVEL = TPM2_PT_FIXED + 1,
> +	TPM2_PT_REVISION = TPM2_PT_FIXED + 2,
> +	TPM2_PT_DAY_OF_YEAR = TPM2_PT_FIXED + 3,
> +	TPM2_PT_YEAR = TPM2_PT_FIXED + 4,
> +	TPM2_PT_MANUFACTURER = TPM2_PT_FIXED + 5,
> +	TPM2_PT_VENDOR_STRING_1 = TPM2_PT_FIXED + 6,
> +	TPM2_PT_VENDOR_STRING_2 = TPM2_PT_FIXED + 7,
> +	TPM2_PT_VENDOR_STRING_3 = TPM2_PT_FIXED + 8,
> +	TPM2_PT_VENDOR_STRING_4 = TPM2_PT_FIXED + 9,
> +	TPM2_PT_VENDOR_TPM_TYPE = TPM2_PT_FIXED + 10,
> +	TPM2_PT_FIRMWARE_VERSION_1 = TPM2_PT_FIXED + 11,
> +	TPM2_PT_FIRMWARE_VERSION_2 = TPM2_PT_FIXED + 12,
> +	TPM2_PT_INPUT_BUFFER = TPM2_PT_FIXED + 13,
> +	TPM2_PT_HR_TRANSIENT_MIN = TPM2_PT_FIXED + 14,
> +	TPM2_PT_HR_PERSISTENT_MIN = TPM2_PT_FIXED + 15,
> +	TPM2_PT_HR_LOADED_MIN = TPM2_PT_FIXED + 16,
> +	TPM2_PT_ACTIVE_SESSIONS_MAX = TPM2_PT_FIXED + 17,
> +	TPM2_PT_PCR_COUNT = TPM2_PT_FIXED + 18,
> +	TPM2_PT_PCR_SELECT_MIN = TPM2_PT_FIXED + 19,
> +	TPM2_PT_CONTEXT_GAP_MAX = TPM2_PT_FIXED + 20,
> +	TPM2_PT_NV_COUNTERS_MAX = TPM2_PT_FIXED + 22,
> +	TPM2_PT_NV_INDEX_MAX = TPM2_PT_FIXED + 23,
> +	TPM2_PT_MEMORY = TPM2_PT_FIXED + 24,
> +	TPM2_PT_CLOCK_UPDATE = TPM2_PT_FIXED + 25,
> +	TPM2_PT_CONTEXT_HASH = TPM2_PT_FIXED + 26,
> +	TPM2_PT_CONTEXT_SYM = TPM2_PT_FIXED + 27,
> +	TPM2_PT_CONTEXT_SYM_SIZE = TPM2_PT_FIXED + 28,
> +	TPM2_PT_ORDERLY_COUNT = TPM2_PT_FIXED + 29,
> +	TPM2_PT_MAX_COMMAND_SIZE = TPM2_PT_FIXED + 30,
> +	TPM2_PT_MAX_RESPONSE_SIZE = TPM2_PT_FIXED + 31,
> +	TPM2_PT_MAX_DIGEST = TPM2_PT_FIXED + 32,
> +	TPM2_PT_MAX_OBJECT_CONTEXT = TPM2_PT_FIXED + 33,
> +	TPM2_PT_MAX_SESSION_CONTEXT = TPM2_PT_FIXED + 34,
> +	TPM2_PT_PS_FAMILY_INDICATOR = TPM2_PT_FIXED + 35,
> +	TPM2_PT_PS_LEVEL = TPM2_PT_FIXED + 36,
> +	TPM2_PT_PS_REVISION = TPM2_PT_FIXED + 37,
> +	TPM2_PT_PS_DAY_OF_YEAR = TPM2_PT_FIXED + 38,
> +	TPM2_PT_PS_YEAR = TPM2_PT_FIXED + 39,
> +	TPM2_PT_SPLIT_MAX = TPM2_PT_FIXED + 40,
> +	TPM2_PT_TOTAL_COMMANDS = TPM2_PT_FIXED + 41,
> +	TPM2_PT_LIBRARY_COMMANDS = TPM2_PT_FIXED + 42,
> +	TPM2_PT_VENDOR_COMMANDS = TPM2_PT_FIXED + 43,
> +	TPM2_PT_NV_BUFFER_MAX = TPM2_PT_FIXED + 44,
> +	TPM2_PT_MODES = TPM2_PT_FIXED + 45,
> +	TPM2_PT_MAX_CAP_BUFFER = TPM2_PT_FIXED + 46,
> +	TPM2_PT_VAR = TPM2_PT_GROUP * 2,
> +	TPM2_PT_PERMANENT = TPM2_PT_VAR + 0,
> +	TPM2_PT_STARTUP_CLEAR = TPM2_PT_VAR + 1,
> +	TPM2_PT_HR_NV_INDEX = TPM2_PT_VAR + 2,
> +	TPM2_PT_HR_LOADED = TPM2_PT_VAR + 3,
> +	TPM2_PT_HR_LOADED_AVAIL = TPM2_PT_VAR + 4,
> +	TPM2_PT_HR_ACTIVE = TPM2_PT_VAR + 5,
> +	TPM2_PT_HR_ACTIVE_AVAIL = TPM2_PT_VAR + 6,
> +	TPM2_PT_HR_TRANSIENT_AVAIL = TPM2_PT_VAR + 7,
> +	TPM2_PT_HR_PERSISTENT = TPM2_PT_VAR + 8,
> +	TPM2_PT_HR_PERSISTENT_AVAIL = TPM2_PT_VAR + 9,
> +	TPM2_PT_NV_COUNTERS = TPM2_PT_VAR + 10,
> +	TPM2_PT_NV_COUNTERS_AVAIL = TPM2_PT_VAR + 11,
> +	TPM2_PT_ALGORITHM_SET = TPM2_PT_VAR + 12,
> +	TPM2_PT_LOADED_CURVES = TPM2_PT_VAR + 13,
> +	TPM2_PT_LOCKOUT_COUNTER = TPM2_PT_VAR + 14,
> +	TPM2_PT_MAX_AUTH_FAIL = TPM2_PT_VAR + 15,
> +	TPM2_PT_LOCKOUT_INTERVAL = TPM2_PT_VAR + 16,
> +	TPM2_PT_LOCKOUT_RECOVERY = TPM2_PT_VAR + 17,
> +	TPM2_PT_NV_WRITE_RECOVERY = TPM2_PT_VAR + 18,
> +	TPM2_PT_AUDIT_COUNTER_0 = TPM2_PT_VAR + 19,
> +	TPM2_PT_AUDIT_COUNTER_1 = TPM2_PT_VAR + 20,
> +};
>   

I guess these properties should be split out to a separate patch in a 
series.

>   /* 128 bytes is an arbitrary cap. This could be as large as TPM_BUFSIZE - 18
>    * bytes, but 128 is still a relatively large number of random bytes and

