Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DF06F086E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 17:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbjD0Pdg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0Pdf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 11:33:35 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2049.outbound.protection.outlook.com [40.107.105.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B98FF;
        Thu, 27 Apr 2023 08:33:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF6XqJQhBEi0GJiddnRIi04RRBMFDxJ7GJfK9vSAOSKhgbPlBVnoMNEM3xZ5q/VN4ZJ6BVfcKFO3c9mnGpttTKAdiKojsmE4hNLnfS5U7DaxMy1Bo5cwurDKJjcwG/9FG3vGBK9vxOidjKm8fEzACSg4vwZigMZl1THbJTebBdEEIITbltqk+vNzBzeVlHdnz3wX65R1vhdneED3r+PIA1bFt+wCXW9XRyeYB0GXVq/lVYLAr90c35kM2J7V+l3yhOstPw/KQntYBNT0lymqD0r1aUu6pn6pW50A9C4UnoF4cZ4F9ovGPgrm4HJVtcUhYOhLJXCqxbdo5Vw7dA1O+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVM2bTzcqRoE6iAeXHwcZJ3CIF6dYdQoZFQVstuGto4=;
 b=LluBnbZHpnPbDqacXnX5ORMgJ+xHfMecNSzHP8LF+9lKv70g4T1jJNrhcVPuWqee7ofKMDwkFggy81B+tjVdO2N3EpqBCXCa/qeP+5Bfq8sf0YB1FuFS4vzUlGOtdnsHIdm9thgAA/dVK0DBADc0sfw5yG9Z+sWqnuoJp5towSqhN7pjJRM8znQwTnKVeUvrI9zcIEKwMnOHnt76ULsk53o8IZvXz4ix0N/4DrMD74f2lq8e1nX5/BqRUTF3BOx5gxTTBuMCMjFk13WFtYeqd7N18OhwxuiaxSoe6gN3MFMspWPMR3iBCcLZX6oLpU0b3ChXvBNRWhLbkEjRkA3ylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVM2bTzcqRoE6iAeXHwcZJ3CIF6dYdQoZFQVstuGto4=;
 b=KUVcgCTyd9tbmMxJz4JmeObp895upzv/HoDbWDt6xjh80xJac9rWpDYXi+yADEKaRIpDASTlddYzcD/xijsBU2Gx7L8GVjx6NEzskfmrFE4t4E4s0JSl0/mvbfmbQM5Fe06L7lF2pc64+SkUqIBywu9p40CZ0Oc/k4ogVzJTSRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB1024.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.9; Thu, 27 Apr
 2023 15:33:31 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::f35b:e991:434f:b628]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::f35b:e991:434f:b628%2]) with mapi id 15.20.6363.007; Thu, 27 Apr 2023
 15:33:30 +0000
Message-ID: <27e8289e-21a4-7d7a-231f-4a27334dd1f9@kunbus.com>
Date:   Thu, 27 Apr 2023 17:33:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM
 drivers
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        heng.su@intel.com
References: <20230426185833.289868-1-jarkko@kernel.org>
 <ZEnWykDF6kbZ8nVi@xpf.sh.intel.com>
 <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <a258fcd353d67e918a0c86a59e27bf1332764a7b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::11) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB1024:EE_
X-MS-Office365-Filtering-Correlation-Id: 613b5baf-df9b-401f-fed0-08db4734c0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FhX4Wgjze6B74HPSgHipfd8pbu3lyymk6hDJ+gNztsaUMnZdrZB8tRz/mn5jlPOfIt2ZzcP8FK9l5ffnJW+vg/lzPeGU6aaYqyQF9HWukyq61mlPfi0oYXO1Kv+F3PRcB2QcLYO0HpiKUolE3s6NyJOxVoFQW8DOvU20sdyXQp19QMKXz+oS/zQu+hHKNZw4yAICklyh98HEbuOa7IWOWuI7MMBSYEyrSCd/9w0RRGjSvdZ3vnSGSMxQe5Rkv375rVEGqfqNqFcO2WUcLTWfSGtv/fFdgirxt8JuW3gvmzFRICY7QECtvUF1cnJTuHUBXUZlvj2BVP9YOiUKmPvRjtPfFDslhyS61aFpMVFOStmlj9cSq3qM9ymvPrABgmn5W0b7OU49rvjYRHGBBpYrqC3531ZUdunvSGAlUaLITVEl0404cy1QC935l4YMygR0nNvR1N/e7HFfCM7MX3IsGOcVj6McgHmvPW7qKaiPL16st+RacEgCbtc32w5xXj/hRqtF8SMmiPC3GJfNnUy2bj+aanFFHyU7By7pMXbe5h4C6IqmZA4NiA2j9hhwpQ+2pLG+Q99KiAYg2WCMnMkgf6W97v8T9U3ugp9mAG9cQ090pRtITaB5I6NAyaTsVq4H8eARriV/mV4kuW7VMvT7PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39840400004)(396003)(366004)(451199021)(31696002)(86362001)(36756003)(2906002)(31686004)(6486002)(53546011)(52116002)(186003)(2616005)(6512007)(6506007)(4326008)(66556008)(66946007)(110136005)(478600001)(316002)(54906003)(66476007)(38100700002)(41300700001)(8676002)(5660300002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pYY1BlQ0lBWHR5eXpsNTAyM2VXRTZtZXdILy8rVFJkT1ZrMEhIMm1lRWRz?=
 =?utf-8?B?N09SdnlZbkNObHBrRW9jMDdvdksyVmRTY2VIby9sS1hZS2pjSmE5czBPSzBo?=
 =?utf-8?B?MGZ1QS9mQ3YxdWZzWVgyOUM4Tk9GNXR1YWdmRGVvS0lGaThybGVTOTFyRE4z?=
 =?utf-8?B?aEtVRHBDQnJ5ZmZCaTN0V1dRS3BvSk5LUVM3MzNuOWdOczdGejUvQzZiWWEr?=
 =?utf-8?B?eVE3eUJhZGt5dXMxZDQzTWZmYzlZMkpBNzA5RDAvaUk4VFhFajVEcXRXOGFs?=
 =?utf-8?B?d0JhS1hSbWpabXBwTGZOdzNaZThaYVZDOWg3eks4M0pxdWxGUVVzd3pReFpT?=
 =?utf-8?B?dnpUdUdtdkgyUnB0SDc5N1ZHZ1d0QWl4c1Y2VUhBWC9lMkZVNUFXYmdMY0lh?=
 =?utf-8?B?UERvU2VCTGs1NFhGRmhMTlk2S2VFSVpNVHluK1BsTjRNL0pDZ1QvVSttSzN2?=
 =?utf-8?B?TEVaUWJ0Y05lOHBWdmd1L1FRYTdMZjMrdzZJVllxQWpaMFg0UDd4empsUVBZ?=
 =?utf-8?B?VGw0K1dmR2tTMUlUSWhjanEwZ0pXT0V3cklqL2ZubzEzNEZzQnQzUUFteFZ5?=
 =?utf-8?B?Y3JWMGlSTzdaSWU3OVlOMDRKWEluUTdJdWdxZ3FaQ0xtTUt3dm02VG5RTUxF?=
 =?utf-8?B?dnlkTWE4d1N2bEplL0ZOZ2YwOFE0SzFOS1NRRHRwMHdUWVdwMUpaK29JNjd6?=
 =?utf-8?B?dEJVQ2JFaFZYanFyOVM3VDA3czJuSnJSc1hZQmNidk56VEtqeVAyRDlzUWNO?=
 =?utf-8?B?VkFjRnFYaWlEK3hEUzRwR2E3UmFPOGVnUVBjc0FJYzJSbWlDTmZXTkhmeUtw?=
 =?utf-8?B?bVI0MmhXeUdqUUxOZ0VWRldwT2hybG5XS2ZPOEZqRXJTT0haUUhsTFIzWVF6?=
 =?utf-8?B?OWtZUW5ZTmZRdnQ5RjM5VTZKbm1xYjN5cU4xNjZlUHBWZnRyUXY2N2srWktx?=
 =?utf-8?B?SjNPNGRwNS9xZnhETGVSZWo0TUlFR1FxSnNtUHhyblN1UW00Z3dueXo2MXZ4?=
 =?utf-8?B?TERFV25iWTBNMFUwM0JjNkZmQ3Uwd0hDa3g4WVROUGh1amJUdENqY2xURVkz?=
 =?utf-8?B?MDZObUhRYjFPVzNtVE1CRk1TQ2dGWVR0Vnc1eC9JcGtBL2dWbk5PZEtGOFRo?=
 =?utf-8?B?cWZpVkVhVjNrL0g0VFpWcWNzYlM2SEdYQ1Z2NTBTNVpvaStzNWRnZVJhSFhv?=
 =?utf-8?B?VGVybTZxUnBUYzk4QnVOTGIwdjF4aW9aZDBPQWNXRExSWlBzTG5haWpWMTVa?=
 =?utf-8?B?d1pXa0RwV2c4aEFINmlGdWVGME9sVUFLb1FqTnJPcGpCU0lkN1BOSzdSeXE0?=
 =?utf-8?B?L1YxTWtVNVhtL2pCcEZWUCtia1ExSG91NnJmaWxzdEtKTVVlRnR6RnhmcXEw?=
 =?utf-8?B?aHR4Mk15UEhNYTdzNWg2OEpsVHBpcW5iVDgzV2wrTnJmdExLblVUZFl1UGhi?=
 =?utf-8?B?S2J1OXA5R2N3b0tjMXl1THgzL2Z3Ymc1cTlITjlRM1ZLZW1xTUlodWpuWG0z?=
 =?utf-8?B?d1ZwMlZXT3RObUlaRGdhb3VxRFhXMmZIMVBVZTJIWkM3Tk9lQk9IcWxoaWp4?=
 =?utf-8?B?aW0vcjVFa2M2N3ByVGVvc09RRCs1ZUN2SGVmTG0xUDVLTERVQ24zZDhwU2Vt?=
 =?utf-8?B?U0srZlBqTGFIYkpSemo1ME1hN0JwSXpITUZqVmd3ODd2Qm9ucDQvOThRUTB4?=
 =?utf-8?B?M3lndEYwVUxuYjg2YmVNVncwZGpqWFpYRlB2Qlc0bDBUM1c0a1A5dHNQaFR5?=
 =?utf-8?B?TklIbmkzdVdFVkt0RXVrYUdnK2RhY2NhR2NpaE5XWFk2dGJ5d3djOWtwcnZZ?=
 =?utf-8?B?bU9SQmtPNDlNdndwb1dhSTdJVDcvWlg5ZUVxaXRlQjRNMjZFK0REWVFFYlY2?=
 =?utf-8?B?WFIzN2Q4RlpJY25MUk5GaHBmOWFWSXV0dU1TeTM4bHA0ZWlhZ3QvQnVHV1lz?=
 =?utf-8?B?T3dydEY5cWQydGRJUzZqSS8yRFozVGswVEtiQlRIcVBwOVdiZWtYaTNKaGdU?=
 =?utf-8?B?Ni9Ec3ZyL3N1Z05UNFE1NWhsbnYyeHl3Qkk5Y2s5Qm1lb2FkeDVzZkZHQXZI?=
 =?utf-8?B?WVlkbWtWOHFNaWRXaUl3T0R2TXhramhIRjlYUlVoUWVNV1FVSGV6OTVGbmdQ?=
 =?utf-8?B?ZHhPUHBjaWxvajlXMm9jUWtTUkhvYWRMZW5kM21aTHF0aUdnZXkvMGFhWkFC?=
 =?utf-8?Q?CCkobXqs0V/ivJMbrYTzGyBUdCEmho4v9GBd4qmAQKVw?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613b5baf-df9b-401f-fed0-08db4734c0ff
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 15:33:30.6539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AwaY+K6KvrB1FbHL8LjVDhqQLeqtBREQ7n69k0Ow6KT5lY/IoISSLlJbMLp5o1U36Ac5BPpk/4WDiQp60OYIyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1024
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Jarkko,

On 27.04.23 12:52, Jarkko Sakkinen wrote:
> ATTENTION: This e-mail is from an external sender. Please check attachments and links before opening e.g. with mouseover.
> 
> 
> On Thu, 2023-04-27 at 09:58 +0800, Pengfei Xu wrote:
>> On 2023-04-26 at 21:58:33 +0300, Jarkko Sakkinen wrote:
>>> TPM chip bootstrapping was removed from tpm_chip_register(), and it
>>> was relocated to tpm_tis_core. This breaks all drivers which are not
>>> based on tpm_tis because the chip will not get properly initialized.
>>>
>>> Take the corrective steps:
>>> 1. Rename tpm_chip_startup() as tpm_chip_bootstrap() and make it one-shot.
>>> 2. Call tpm_chip_bootstrap() in tpm_chip_register(), which reverts the
>>>    things  as tehy used to be.
>>            ^ two space and one typo "they"
>>          Thanks for your fixed patch in short time!
>>
>>   And I tested this patch, it could not be reproduced in 155s, and the patch
>>   fixed this issue.
>>   Fixed dmesg is in attached.
>>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> 
> Thanks a lot! I'll take immediate action to send PR to Linus.
> 
> Lino: no worries. It was expected that such a large refactorization
> could break a thing or two. You did a good job in any case.
> 
> BR, Jarkko

I guess you are right, there will probably be more issues showing up
in the next time. I will try my best to help fixing them.
Thank you very much (also for fixing this issue)!

Best regards,
Lino
