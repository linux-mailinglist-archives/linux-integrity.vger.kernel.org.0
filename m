Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F137E726501
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jun 2023 17:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjFGPsI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jun 2023 11:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbjFGPsH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jun 2023 11:48:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482531BC5;
        Wed,  7 Jun 2023 08:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUPfUkNwDqJyFBbH8Tsp/ZVJe3mMWOntyfOGoLSPXfu1Z72QH4OHpM8+ZAg8xwCo9zEWmX3CevDDvqwWGrVvzM8LOfLnCx84PCIEaRW1BhQH0xH1uNEf1NleMbT+fbAEEsDkfrmrnQZUYD5q7WiGsH0EPGbwl2KVoBcI0qWSvaT9v6jGUc4gF8ifwHTNbu2C65ySrm3Aa28/eb2p1lKK85Uhiu3bdyj3S3LUGx+p4SbG2rGN+yfpalxagNMWy0K9bqDJCCyjKQWeNBxf1nI5YeoPmiEJsWeD/b2hMOc8ZgbqF0gUk4K3OEMD/wqknQ09rSOP+jKD0ISd5ULc21U66w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IznpFSPcai9ohoG+loOLpCBsg+fCrTw9we5gjVHtPVQ=;
 b=CzxX4hqy4yfoQobgta063AcievnXfosx1/pCw4kIUcXL7u2UXf2Y6skMb19E6lMFiim1Mug/9CY+YvzdBZTeV0yi3IH49dl42Q8Ck1mRGqRJ0IhMgfd3U+rVdP2S2DN/u9DJvb5MSaL/8ZAMIoJa3JReV/RkcPwZcwvSH3rV144dXdQ3rlSr1WqDvuIlZxCTn9xfFrfw7Oa+jr+er9J8IFp65K7YuRPnLhxmHelvXrdciDin3WeqHV/EmlhL8BYDKxrAnOHM+IShVxMgphJcebphezvwVvrsLZyabZEKgIKlQsVBcbt4JStcc963ame7dsEKOt1KtWQCGxBrWKr0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IznpFSPcai9ohoG+loOLpCBsg+fCrTw9we5gjVHtPVQ=;
 b=Br12ml++s+gIQJ934W3djzyMfT+kLhwNNMDVhlPIvkLA31VG5gUUkT0V7WB65QN4ZU0aRHqh7qfWOhFggxOdu/5kwOpEYx1XiP8Sq8NeZuQ67OH2xD/kvTl3Z9BsZXcuAbDcMH/1CRkyRgPEJ8kOP0Y0SvwUPd0bQ3cVFDLEVig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PAXP193MB2137.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18; Wed, 7 Jun
 2023 15:48:01 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 15:47:59 +0000
Message-ID: <ac5b76af-87dc-b04d-6035-8eda8ba5ed12@kunbus.com>
Date:   Wed, 7 Jun 2023 17:47:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: New kernel warning after updating from LTS 5.15.110 to 5.15.112
 (and 5.15.113)
Content-Language: en-US
To:     Greg KH <greg@kroah.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Integrity <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        stable@vger.kernel.org
References: <fe6f7aa0-56c2-3729-ce8c-0f2d943b33f4@alliedtelesis.co.nz>
 <ZHQIFLWvrWUNMVxb@debian.me>
 <6e470461-1a9b-ec51-bac5-f2beb1dc11c9@alliedtelesis.co.nz>
 <2b09d2ed-0852-bbc9-b792-aad92235c7fa@gmail.com>
 <03daca5c-e468-8889-4dc2-e625a664d571@alliedtelesis.co.nz>
 <ec5245bd-3103-f0c7-d3ef-85aabb4d4712@alliedtelesis.co.nz>
 <ZH6TIjXeXJVMvSKa@debian.me> <2023060606-unlatch-yiddish-a45f@gregkh>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <2023060606-unlatch-yiddish-a45f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::11)
 To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PAXP193MB2137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b2cc59f-cd7c-4f49-4960-08db676e91a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zzu6ODjGwhHx/kFIVjmYp7Wn7aByieY9IQKi4qVgMC2LvuVjBwurTmnoEeZz1m9AQk8ywYUTeH0IceGqPs/H/ge6stV21TDY199xnLywRaNFAbLqq9JtThgK57rRYJdNHvypDdrc8RR6Biqvzr61ZKQ5DC/qkJrN5lley1mOLaiWpPp8p1m83w/1YgwR1iz7zIhla9eG1gV+G8WYdFzZl9AtMWj49ImOsw8HD6ubvJ6Rc5sDOhqFWSXmbEUGdBkERX1hCNFxL6ixnKAMomEUWDJRHEz2ipjkVp0SpiJSSAeq4ngJMkQMwtpEb/kZvdGsICz2y20q1qzgyWOUeLoJqLpG63QRB8OWqxDoqvjtDJWV8ywIQYOcHuqWRuJUzhqV+lQsWte8DLn/wG7o6kJPez8Nro28ScRlNRSfaDKC5lvkAe9Uqn8L16UHhhLcvNWVdwsWZpnyX+Q7wJVUIE939Api5MjaxjC3QVMrUGF4fPWH67+OnLOxYLrFH2szPPNsfxv72sjlRM4F9NmUwYahDv2eh+R1Ud+xnDEyJICGrDxT8lmsuOnuxYVCM1aRk/NQMYgTstCtGofxEsU0i6QTRuLJerAoujhCqOgPsVhfpVCl/gnNYESwnKaObyjiR/fWaqXI8mSFRWTCcjxta/Zs2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39840400004)(451199021)(53546011)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(52116002)(31686004)(186003)(83380400001)(478600001)(110136005)(4744005)(54906003)(66556008)(66476007)(66946007)(316002)(7416002)(31696002)(2906002)(8676002)(8936002)(5660300002)(4326008)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0dZa2JzbHhnQ0xZM0xsNDRRcmJveHdoZUhYdE0zTm5sNEQxR3UzSnEwbWsx?=
 =?utf-8?B?TU1MbXpmSkpDQ2pDNDR3Y3hVSG5rbWJDUXhhUEgyVXM2T3ZwS2gwUUhDclM2?=
 =?utf-8?B?MlBpZkVxMWxVLzIyWHlTbUd0WlV0M0tPcmp0OU45TW9LUW54L2NPTzFBOWRB?=
 =?utf-8?B?cXBVTFZ2dWF2TzE4ZFZ6bCtqUC9WSU40K2RoaUo3ZGhWV1MxMUptaEc5UXQ2?=
 =?utf-8?B?bEFyZXdBOHBxNzZuTWV3ODdFNmZ6R3BudElGREZ0cUsrVUV6KzNuQnByeUNI?=
 =?utf-8?B?cGRPd1Q0dXMrOGlEZTlJdzNtOUJSMVBhTiszUnFCSUxzSFBxRzlZeEhwTDZq?=
 =?utf-8?B?Q21XM1pBWlRYOEpmR01qcnF2WXArdGFnK1VMaXhqVEpLbXlwaWN5ZldJVHFp?=
 =?utf-8?B?dGRyaFVPTVBRNjFaT3NXN2RCR2ttRzZEYTBoci9xMFlIbzhiT1NpUXNKUDJq?=
 =?utf-8?B?dVFrMjRhajBjY0hiNXRucWNPY2dBNXd0VmxyMFhTMGJLTlM0cXQxSVJ6bVpy?=
 =?utf-8?B?RURWYWVZT3dVTE1yWmZqZEhUa0N5SWRmMkJtdDRsWkdYbkZBWEprS21rbnVV?=
 =?utf-8?B?aW1pNHVnWHVLbmQxNnpTVXYrR256USs4amp5aDdianRtaDJ3Qjk1cEVUb2ln?=
 =?utf-8?B?S1NYelRKdDhhS2MyRWFNUFBNdkdodGkwWnA3bkNCWFdIWlR4b0JzKzJVNU1t?=
 =?utf-8?B?cjM2RGIwSnkyaWZFZU96c3pXZEZaOGR6YXpJN3NxWXRyTWJ3QzhvTEdiR2ds?=
 =?utf-8?B?YTVWWk5yVlNLMG1oNFZTa0cvSUNCdzYweGVTQ0VCSTdjUjdOK2hLeFVZVjRG?=
 =?utf-8?B?MXB0UTNNZjJkZ0d5cHR3QUIwRHZKUnFUbHo4Ri9rTSsrZC9RamJKdEFyTnZr?=
 =?utf-8?B?QWRWaVpFTjV2S3RhTUZGSGs5RGNCdnNLT1BkbEozVUxrOExkUVhjVTc3U2RB?=
 =?utf-8?B?MXM1Q1lFTTFIbzJ0QlVIa0Q3b3RBU3dZV0lyMzA2UGRYZEFnNm56YjBMQm1I?=
 =?utf-8?B?ME1qSC9WYzhQQjhjTFI4bVh3bHFCWmpWM0NnbUJxL0NOMFRwUWlUM0U0NUgz?=
 =?utf-8?B?OE1FRnN4QlZCSllvc09TdmNxY3JmUlBxeHlqRVl5NGRrUEdUeE0xTk9JNnBw?=
 =?utf-8?B?ek81Z2xIN25ibjFRYmxFWHY1NzFmTGJjNFVwcUU0eUVrUDNBbWJZS0Q3RGdt?=
 =?utf-8?B?SzhoTFdKZ2pWQ0I2czNGdEM0dDN3RkV5a2hvWXBvajduT1lOZTk1ZFY5ME83?=
 =?utf-8?B?TjZuNjBlTU1jSTNLTUd3ZldZRmpnS1dDQmV6ODFPV2tMODBNK0xzdGtIMU5w?=
 =?utf-8?B?ZytBbk02bmxFck5SbXRTM0p0ZGdmbDVmQldUd1FUakJwcCtEdXduaFk1UFYv?=
 =?utf-8?B?SGsrbm5qV1ZIVWxtQWZGUEwvdS9MK1NSMTRMZU8rc1dLTHJWcG9PY3M0MElG?=
 =?utf-8?B?UFFIU0J2eUU3YVN1VXR6VWcvWjQzYjNJZTlncUVBYlhGeWtUbGtTdXFLTWNk?=
 =?utf-8?B?RVhxYURNNHRHLzRxSVgySGpoNTVMc2xxcnFSeXVaekZReGFMM21iV1F2SG82?=
 =?utf-8?B?Q2x5OGdVT1VJczlXcFBHeERjWU1oajkwL21zV0NzKy9PMUJDL1l5K3p0c3pW?=
 =?utf-8?B?cDJNekhxcXJrOFhWU2ZpWnl6OXErN2lyeE9KRDZFZWxNRm1wU3RYb3NZMUxx?=
 =?utf-8?B?cFRoNEJnZXliWm9icXFjTWJtS25iWnlsY09WSzU5c095RTJQbzdNUWZsTExN?=
 =?utf-8?B?ZTZvS3FORTZxdUFFYnVBMVBZZ2NqaUhOZnZTalA4NFFzT1NESEF2eWZ1OHUv?=
 =?utf-8?B?WXlMeTliWWtma3J4S3pWdENDaHFZcXE2d0tEdmlzRzRKYVVhaEpTRXhJcjBZ?=
 =?utf-8?B?ck9VUXFDck4yWU40dDlMTDdBNGJxMHdEUjg4eGh4Q0FFdkMxelhIeHNVa1NE?=
 =?utf-8?B?R3hOVTV1RGc5TTVqbW9lT3dwU0FVclZGdHQ0c2dndnR5dmc4UmNnbGtBbERF?=
 =?utf-8?B?eDhTSHhrZE5nd0VhcXlOcUErL1ViaUJkOTNsWDduRytWQjNyRUZyVTFuTWVC?=
 =?utf-8?B?MXdUNDU4RkNJUXAvb1l3WGFWK3VwTnd1cTlnRVpvdHhRbVluYThTZWtOVDZa?=
 =?utf-8?B?NDN4a3A1U3J3NjNnQk91WlVCS2c5TzZzWW1jNnFsdTRRRW1UZXRUSXJsdGdp?=
 =?utf-8?Q?WhZnIadK5OKtF39xOWmBN3z9IGxY354mzgiyDSksPWmO?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2cc59f-cd7c-4f49-4960-08db676e91a6
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 15:47:59.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tCVga1qnQeLdTcWHZZQDQENF4Z9CKeLMGOcQ1SdUSETBXuTplz5jSHwrTR+ylLTNRd+k3P+Ps2dY+F3RpjO8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2137
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Greg,

On 06.06.23 08:45, Greg KH wrote:
>>
>> Lino, it looks like this regression is caused by (backported) commit of yours.
>> Would you like to take a look on it?
>>
>> Anyway, telling regzbot:
>>
>> #regzbot introduced: 51162b05a44cb5
> 
> There's some tpm backports to 5.15.y that were suspect and I'll look
> into reverting them and see if this was one of the ones that was on that
> list.  Give me a few days...
> 

Could you please consider to apply (mainline) commit 0c7e66e5fd69 ("tpm, tpm_tis: Request threaded
interrupt handler") to 5.15.y?

As Chris confirmed it fixes the regression caused by 51162b05a44cb5 ("tpm, tpm_tis: Claim locality
before writing interrupt registers").

Commit 0c7e66e5fd69 is also needed for 5.10.y, 6.1.y and 6.3.y.

Best regards,
Lino






