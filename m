Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8528C70E6DD
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 22:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjEWUwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 16:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjEWUwx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 16:52:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5238E;
        Tue, 23 May 2023 13:52:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGAvupkCssWGNxCuaMPR9eRw5hMiYriCHhKC4iFSQ5bOBfzswUuuNp60NaW+dImegGsUijtRCL5hHGi+uAUcOacQ5vIl0X07+qg5iEEyDOf67SgpDJrQ1p/zlvS9szXyMnVH9cywr9FTdsfqoA63tH/K4X1cU/73gx4vAmGTZ7ZcmhwQ+sCAOti8752IaYRMWNQ6MladTQagxnkuPQHjvjUe7u7j5qj/LrYTOF+cnOtqGjBP1pmpKBh7jKJkkwPstuogCTqNNqLRW+fx4kImk1eSbNBrJP3HBzz1JHNFyVR2oFSDJgHGdL6r9XZAZi2oH1Jt0QB8lBaWjWJmK9LQQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHNDGbOkf4c3ZyvUpDp+qpdrdNrWQ6OdAGC3+t/Zdgw=;
 b=Wa0Y5PRGL8mlWiOxWzjZn3ZbDF9s3ringDzPfmJFPpwpj5IStwedUD+I1nY0bO5a4EdQhexAA/Iqw9xgrg10FkI5fACYh1ti5brQ3MLaOZhwXXsc/cF8wL1UudV0rjJzWZTPP93GExoBxex0meXChIT4xXlLVlh04sTJ1MV+QBbBWZ7A8GPslZUrAKl1c0m5OnbKUGZHbzfZ0Us+MKfVG5j38SfCKMpBmf/kOHRXyx6BkMY7E+YbUCALg7hO+4w2AlI4/gFI3znsPNGuEvcWd57TEVx2hVoQmk2kTrflQKGsPfF5KOnWxrzXCbAqHWceyArZXLskxJBa0R3koNYOVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHNDGbOkf4c3ZyvUpDp+qpdrdNrWQ6OdAGC3+t/Zdgw=;
 b=dCv0Rh1NBv59L5s4DtCPmmo3wvkNBMgkxFvO12WUylFCs/DeHAlp5IlMhliZRhMt71QG7NbQwaRhfEE1oN4opR51aEf+//A5tKAnSgHcFaBI3vlZV3ckTAcoKRfynJO0xnSk5nKAjC3Vtg4cNDijcgroqItkuVFtvEzPyGTWIEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB2192.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:444::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Tue, 23 May
 2023 20:52:50 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 20:52:50 +0000
Message-ID: <f22d2c28-5934-a989-3aea-4ff4d20b6326@kunbus.com>
Date:   Tue, 23 May 2023 22:52:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] tpm, tpm_tis: reuse code in disable_interrupts()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     jsnitsel@redhat.com, hdegoede@redhat.com, oe-lkp@lists.linux.dev,
        lkp@intel.com, peter.ujfalusi@linux.intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <20230522143105.8617-2-LinoSanfilippo@gmx.de>
 <CSTW5YGZ50O1.16RYO14HOQRH2@suppilovahvero>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CSTW5YGZ50O1.16RYO14HOQRH2@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::10) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB2192:EE_
X-MS-Office365-Filtering-Correlation-Id: 61cab317-bc67-4116-e850-08db5bcfabaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QYcGOQHgJJprLE+5i/4dswhviXZb+eDW+ry66Qs4TbsM6UO/6vQfPAJmWQNFaf8uqw9SAJPv37SXmYNBOBm9n/DpDXD14GQREeKg8hIeKSlTjs73ES+uVzT/E0CBY98GkEanUMBEYs0LcAW+DLRokjziqS1MrjGqBS5ANvf2lVRC4QXKli4cObKIanpO3jEOGfIXRZ3Pcs0QE9jCPhO/f9V8MEqxQS7Ms+pt1mZ+95hb5aH6Zye4deV1jeoRXg0XKdRTCDtqmYK9UVe2hgp3sSb5yz+670btXdJ2yqBnC39H9LHMgq0fZrrrpECfwJ0kAQV5Nw+CxuofvLKur6ZFe4hd0+qJXsFxWmiqW4fk2ZL+K1xl85QszwCke1S1v2LwlPaqwkypTQXJsdwnuaEJJB7vfHwicf8XsbTnFrH6oLq7zdUwvqKWeOA6nfSdUs/8b9ldN1gafNuCJpGeD9qasHeETHmYF2U+PK6rzVfzGyVkq4d5gZgtMEgFOmQ6kWIJr2VsC7/VUPb6bjXfxEc7WGRtQKBsLx/ozO5zaWs0oqu5UXQ93a1Is2zRYWbqA6c8ReZ3BO82B90O+N9Kv/pqDQ6bnqvqCn3OspC99ZhaoPg4DSRdPqt3nPkidDtClv/ti8Bu1MtQqTrDd6DSq778g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39840400004)(136003)(376002)(346002)(451199021)(6506007)(6512007)(31696002)(478600001)(86362001)(107886003)(53546011)(2616005)(186003)(2906002)(36756003)(38100700002)(8676002)(8936002)(4744005)(7416002)(5660300002)(6486002)(110136005)(4326008)(52116002)(316002)(41300700001)(66476007)(66556008)(66946007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJJYVJhdUtxYXJucU8ycVBGN3YxTlJBclBheU9uUHFteldxVzh3SU15cmNm?=
 =?utf-8?B?bmM2R2tWM244UmEzeVFzTitYWGZmQzBmTHB1V1FtcHFDb1JDZDZwRUMyTUNt?=
 =?utf-8?B?L3B3ZFJWNEV0OUlCOUxUSHg1R1hyc0hvRXc2QncyeE5PRUg1MTJvRlBvUjdK?=
 =?utf-8?B?dlBoS3dMUDA0cC84ay9oeURNc2oySWdHUHI3UmdhOVVlWWxtd1l2YWdMNUsx?=
 =?utf-8?B?NlZTWTlWcTh0Zlh2VXR6U2xYYkJ4RmdUdDVmWkZ3TEY5a0hraU5yMmxDOFZY?=
 =?utf-8?B?bzA1Zm1RcDJaWmNrZFVIb091SHlISUVDQnVFUGV6U2htcXpHTVhmVWwrWi9P?=
 =?utf-8?B?NEhJNkRUQklBMTk3N2JkQ0xmUFFqdW5QcmI3dzI2QVhVOEVUWXNhV0s2QTJG?=
 =?utf-8?B?cCtuMjBSQysxWUQ2K1lUWmdIaERuQWI2VndWZ0RIRHY3Qk5qZ2FaUW5hSGVv?=
 =?utf-8?B?d2FNcitnYmtiTEh4dEcwek5JTVJnc052WW5CUm5ocWc5RXNIaUU4bjFHTkU2?=
 =?utf-8?B?SFd0T2o2R0lCR1FCL1ExN0xEQTdUdkh4NDRXNEE4RnRMUmxIcndrM1BxK2VZ?=
 =?utf-8?B?ejh0bml5dHFrUEZqK3hSSE4zcXlReFhIclBNbENPVFZ0UUtkcWxjUVg5Y0JC?=
 =?utf-8?B?bzdmUGFEM3pQVjRWSWNrSEI4MXFjdVNUc0huUnJ5T2V3UFVYcGU0cXlmVGo2?=
 =?utf-8?B?eVF5Vy9wWUoveGtzajlzN0UyNUxnQzNCU2Q3MTMwSTc3MS9DV2s3ZTZwN0NF?=
 =?utf-8?B?ZWNyWnBFcHVEY3gzV1dqU2s0YjJJSnh0NkVhOFFVYUpIS1Z3S2g2eHN4S043?=
 =?utf-8?B?U0tQMlBwaloxOW0reWlZRnIyZGllSCtXUFdyTEdsbDRWcnp5bUtMVDN0RXNh?=
 =?utf-8?B?aWhOZDBrbVA4NmtNNWdSc1Fjajdwd1pnU2o4VTNVd3I4MlRtQXJCNEZsM2xH?=
 =?utf-8?B?cFpLZEhJTXVQM24rNi9EeitNcWl2Q3JWU2V2dGhsSGV4ZEFTajBsaGdobytF?=
 =?utf-8?B?UXdab1pYdy9NL0VsQ3VKcGVubnladHV1ZHZSbUc5SUpFbnRjMDFWY241blJJ?=
 =?utf-8?B?TDR1RHhONVp3QzBMVlVzUEhpMGhzWHZ4TFRTZFdCVk55NVlWeExLSC9uVmhx?=
 =?utf-8?B?Q1pMWFJIVWMreTJ2eWpMUGl5ZmRyS0pQQTNRRU5KYkR4MStrZ05ObUZvWEVY?=
 =?utf-8?B?dExoVDZYaFNIRXkyQWFNYXU3OWhFSWNtam9mZHhEdERHcFd4K0ZGdXR0SWJr?=
 =?utf-8?B?di9wZ3p3WTRHN0EweEZRTXl4SkNSa2xrSU9oaUNIQWRHdXNKOGRKd0RIY1gr?=
 =?utf-8?B?Z1FFbVVWNWpOSW83RlF6cFdYT3ZHZTNZSko4dEdnTnFmQ3NMVmFZdEpUNTUw?=
 =?utf-8?B?enFZS04yRVE1Q1BWTDNualhDMktMZ0FtRmtxeHZRL2o1Z0ZMR0toTWc3Z3Y1?=
 =?utf-8?B?Q2x4bzdsRGppZE1mUHdsREFnWUwzY2o3RnFIekNrc0UyZzRDc3AydzFXajRB?=
 =?utf-8?B?R1ZXdTBMemU1RXkzOTZCWlR5QUZxSmczdHBsWWt2RnRhbnR6aTRLd05aZmNT?=
 =?utf-8?B?MnFPY1k3eEd1YkJ2SmFETEFHTitpSXQzaXdlMFJ5cFYyeXhjYW1WMDljQzVK?=
 =?utf-8?B?aWZod0JEQVVNNTlWTm84KzAyTk1vNmlBeko0eDlkZFRmNnhOQ242SFFXT0w0?=
 =?utf-8?B?YWFZeTZITUlaaHl4dkxSWjJkWk1zSnluYk1wT05uWGdEUDFIcDVFQnpUcmxl?=
 =?utf-8?B?c05QQkdpSEo2TklrZmV3ak5TREFnRVUxRW0wYldlQzExNTIwa0kwMjJYbXIy?=
 =?utf-8?B?bmMxdTM1Um5YK1M3QU5mL1lIMUZLckQrdzBIMVpkVEFmdDN2U0FydnNPWnNz?=
 =?utf-8?B?WUx5bjBSU2Jjd3JVRFU2NSttOXNQUVliZkpCVzZwcHZwUEx1ZnBPLy95RUw1?=
 =?utf-8?B?Q1lJNmdNSkZHellnai9XTEhlRm13SngxRnlqRkFWWEduOGVRZWFtdWxwKzVo?=
 =?utf-8?B?SUFmNjVWQXJ6YlNUbW8vUHRpRFhNTENKZG15bjlBNi9TTXZuQVp2VzkvQ01J?=
 =?utf-8?B?VzNhSm4rSCtPYlR2M1RXbkw4ZEI5VkxHa3E5RU5yOGNMVFZQYnl1aFRlNmVz?=
 =?utf-8?B?Mm91VThJamRRNnhYTldUeTVyaUkxR2FCcVRlV0ltWWlqaVc3WitESFRnVVlJ?=
 =?utf-8?Q?AJb5hMhBMatVLpbKosSqMrLpvsq0G9+LZItNjRGhCVgo?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61cab317-bc67-4116-e850-08db5bcfabaf
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 20:52:50.4494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvHOSgFjTM5nSboXF3xIoA/5T7nF8lO8ms4cMO40nRzFFoQ9twYOf3AvV++lD/y/jd8xGha7Z4XY9RddM5WXSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB2192
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 23.05.23 21:07, Jarkko Sakkinen wrote:

> 
> NAK as invidual change w/o further discussion.
> 
> Would need to be seen in context. This does not change kernel for
> better.
> 
> If you want to wrap, please do it in 1/2 and then we can evaluate
> whether it makes sense or not.
> 

Ok, will do so.

Regards,
Lino
