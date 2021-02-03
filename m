Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F5930DC4A
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 15:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhBCOKn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 09:10:43 -0500
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:34625
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232344AbhBCOKk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 09:10:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1rd6BMnShj6vY5YFS63roXZ4/WgDpNlC3UAnc3rljIQk6ZZAmlhB6t2WcraUjQ9kefmV/FeMoVrvgALEv6ILkjAGP4o0vjHzekb7+vd7wCQGY83cUazGxIg1jvfDM8N2eQWAVnbEkJ+Lgk8Aj7XyRbA/S6KlOQ34s+Il5wOdQ982O6M/xwdVv0kJm+ht1ly1CPkDY9rgPFOnPRvHB0PskChTj1/NftSN8rO3bNdKy1wo97pKwMDEr7xOxxPObgsRs4ycRUuvpRblKx0sdsmCQ5g6LuXrPBvba/EJ8UsdQZqrsdJqmarfEqw4A9NoJwWrNu0e2E41C8STQlcmrLVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNiAbmBa/SdX8AA81fqZzOevSXaf8mELpEZxw2qrKC4=;
 b=lOpiBXWwDZi+3j8eOid0RDrpzzqoWtOWC/y7kMwT8Aatg5wRGIAF6LtH4uILa8+2q3Vno4DjwVvnIarWKhzw53kyw3vSNHNjTbFwb8bcwmf/wE3TkPBeyvYJsdDtfJ/CKVT6f5xXKEbs6QcKkKtz2qo9IaNoE3QYfNaMSy6ShLayFjPHLPPDVubZD0k7ttSsu441TU1gsh94fG4aZS82vCtmDKvf1MG94o3BbJN5a7B7WmCNK79XJx0q+U9QJpyO90Zhd9Bv10gXpizVHSXjL/Gz9ZqcP2aFluXVsHCBSqGzkSY4BcWYYKzT4Eocc7sWF/7SybWDfi7ev/D+7cUdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNiAbmBa/SdX8AA81fqZzOevSXaf8mELpEZxw2qrKC4=;
 b=FWUh3QbMq/Isp62F1Fqkh7hTyZgBc8ahzn25PLcHKY65V2Ki/+D9gJtAK/GgeH9QF5QHmalYPHsth5b8uUbXm4CII9pexqf3SZvrBd0bCGK/ezz5lN9oTzBvFvVctXT/P194uHL3HdwDDSk/iT5BuRT/LY1vSgJ4D4CzilCK8kg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a0::11)
 by PR3P193MB0700.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 14:09:51 +0000
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73]) by PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73%5]) with mapi id 15.20.3784.022; Wed, 3 Feb 2021
 14:09:51 +0000
Subject: Re: [PATCH v2 2/3] tpm: Provide a function tpm_chip_free() to free
 tpm chips
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-3-git-send-email-LinoSanfilippo@gmx.de>
 <YBn8S8rY2wvv9A8A@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
Message-ID: <f8163810-baad-e224-57c2-e61fb1fe7cc7@kunbus.com>
Date:   Wed, 3 Feb 2021 15:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBn8S8rY2wvv9A8A@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.130.101.138]
X-ClientProxiedBy: AM8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::10) To PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:a0::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.23.16.111] (87.130.101.138) by AM8P189CA0005.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 14:09:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7e80822-9a13-4061-8d0e-08d8c84d5f79
X-MS-TrafficTypeDiagnostic: PR3P193MB0700:
X-Microsoft-Antispam-PRVS: <PR3P193MB07003675F555B65A13E06D45FAB49@PR3P193MB0700.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAiyAL7s3/+d01EVHxjizI5nffsgtkHEl123LyZaxV4wKhS5iJRaRWR+FCYrPaSHDGF0Cc+c4M+qAxGXj4e2A7lL8WlDOzj8oDoKgIkQBOlmciv97IZFi4uKD0b1jSV1LXtjglDsucSGJyDpS8EbBBUaHE1ishMLs0LQPinatoTtWDDUkpuvVVRARKX/ep6Aa9cijh+/zF+F5efrvGFy8PDq3rMEMm3iy3nNN34swvwqX3GQzY3JsKGB+IMO8sRJp4uhstStkWUgEXY4z0kThtOJPKgg7BGVeh/p4kJ0KAz/3esggua5yRl6deIGvuKkXH4rxJPfJcUHOjkt1Z7JP+mALqtl+8ScbYty20XXFmxV4C/w+kyzKCgcY8hA7wjy2GvC4GETu5VY8uDfkZaLEgzjUU0j/iQD93vooKD2d2Qh/8QklWwZcSDeD9mg53VaNrb6p44kjKmftmVFVeyuJJhmibit0I+gFfDGaIKBSIdIA98VntBzUVmkdVWFV9575218ZVzu8GVfCphlG2nPKLXhwcFbVFUJcFBQvWwrqmc6kl5jaNrqPkcdq3qGAjUNLF4WxbUw0LapNPQR8VCBtYntoZyBnwqfpJ/c9IoBkE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0894.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39830400003)(396003)(2906002)(53546011)(4744005)(66946007)(26005)(8676002)(31686004)(66556008)(110136005)(5660300002)(66476007)(8936002)(4326008)(956004)(36756003)(316002)(86362001)(52116002)(16576012)(478600001)(6486002)(31696002)(2616005)(16526019)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGdCc05vakQ4Q25FR2VHRXBxcmtaQ0w5MnJldTAvUVJiazc0UzNWeWNBVW5P?=
 =?utf-8?B?TXBFcWMwd29tYW15ZFY5OTdpTG8vVEJoUUY2bzhuNmNqdXJ6Um1Uc3U0aEp5?=
 =?utf-8?B?QWNzZ2ZzbC8yWnNwTDFRcFQ2ankwd3hoVE9lZGFKZm9VbkhtTlBjRlA5cVJL?=
 =?utf-8?B?a3VnNldGZHFSczRIVjFqSG1aejZRZEQ5cUJRcDBpLzRaNmJkL0xmbWVvNWtP?=
 =?utf-8?B?VC9XeVRrRUVzZWRJQVFOblg2L1JHdkQ0NFMwU2hRakZ3TjduYWh0UTR2OGlV?=
 =?utf-8?B?bTdZU0FXaTRJS2xCV2lJS0tFQjBoT3hhaHJ2NU5RT2lnL3NIZjIvczRDUC9M?=
 =?utf-8?B?NmxJSm9HR0htN3BpNWF4UnRqM3haby81aVQ3MW1UN3YxQkF6bms0b25UYjc0?=
 =?utf-8?B?ZXc1MFZ1dkw2Yll3YkxyZjhhV1FWbi9OV3BkUEVrWWF1OGJxWnFUbjVleHJV?=
 =?utf-8?B?RkI1U0QyS2F5OTJjMUt2cVVQbStzWmNmejhhbGozKzR1ZzFpV3ArT1VzOXh5?=
 =?utf-8?B?ZGsrVU9reVFRbDZhN1JvRTJwZEVHRk50MWZKRUJsV1VSNFhKMXpDY3Y3M0FJ?=
 =?utf-8?B?MXJQbWpodTVUT1c4Z1lrNVpoZnJGODA0SmRlTy94MURjTHhEZXBCMERnalRU?=
 =?utf-8?B?Y0c5bjI0ajJsbmdYZUdtYVQ2dzk1U0dGT01RWktzTE9xdW80YXhGTGw1WFc3?=
 =?utf-8?B?dVA3Y3hTckt2L0VUUnltbFRDUjlMRUl3SytsUVNhZWE1MjNVU0xZdjF2WGp2?=
 =?utf-8?B?Z0FwdUdYZVFmT1grZmlsaEFDZnY0a2xTbUtWbEFwTFJ5TWFvZk16dWNwc2dq?=
 =?utf-8?B?VGpyVXBOSkZnLy9NZFFEU1B3OE53SXVaaTd6L0NJQ1JhaTRHMGU4YS81emVt?=
 =?utf-8?B?RTdvbGp3V3NDakFPelFoMjRiTWJjbWVMaDF6YmJ3NndOaEl3OTEzdFpvOC9z?=
 =?utf-8?B?TnB0a0lPR2lzQW1UdXRyZDd6Zi8xbFl2MStraFd2OFhmYUNLT1hnVHRtQjhq?=
 =?utf-8?B?MkpvaHExNDg4TE1Sc2FRMXZNVUIrZzQ2SlJtOUtvMWUxQTYvZDUvb2xBdDVJ?=
 =?utf-8?B?ZzVVTDR3aUtsSHJaejYrUDJ4RlFIUCtTeHFzbTRiZ0hwSVZBT1NLR2lkNHVP?=
 =?utf-8?B?QnB0VHRFMzFqVnNCMy9HSkpxK3BSNk8yVWdIa1pzNVVnMmZiTlhZeUJBb2FM?=
 =?utf-8?B?K1RhRG1OK0REQXU1dGFIOTRXVm1odmhFQmVLaVE1MmNOZXpDczNySE9xS2w3?=
 =?utf-8?B?U0pzZTdLR0s4K1BKR2FqUkcrY3MzbnhnNnczRmdpam9zbldISFBRYWZST205?=
 =?utf-8?B?dWNOMW5JRTFYc3lGSy8xcFRoRjJSd3R4STl6dVhQdkwxNUdVRXFUQmw5Nzli?=
 =?utf-8?B?cVU2amNOVE9RSnBCbEFmWE9Mb2gzSVM5REk0NVorWGlWVnZmcWhHbmNuMkhq?=
 =?utf-8?Q?sqXMFRcK?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e80822-9a13-4061-8d0e-08d8c84d5f79
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 14:09:51.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /kBWMts4kRu03w4HlSFndAoakSQOFRacpNtQzQVuy+FfLbJK6GLSKdtE993Gu8n1XFBahQsYaIF6eBRWLkBpJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0700
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi

On 03.02.21 02:28, Jarkko Sakkinen wrote:
> On Tue, Feb 02, 2021 at 11:09:02PM +0100, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Provide a function tpm_chip_free() as a counterpart to tpm_chip_alloc().
>> The function hides the internals of freeing a struct tpm_chip instance
>> by putting the device references which are part of this structure.
>>
>> Use the new function at the appropriate places.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> I prefer open coding here.
> 
> /Jarkko
> 

Ok, then I will drop this patch in the next series version.

Regards,
Lino
