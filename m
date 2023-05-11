Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4A66FF079
	for <lists+linux-integrity@lfdr.de>; Thu, 11 May 2023 13:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbjEKLW2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 May 2023 07:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237655AbjEKLW1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 May 2023 07:22:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9A6E87;
        Thu, 11 May 2023 04:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ue4RcT/D0PFJSOtZgnmPSjFx8Zp3XuB+35S1Y/2Fu4vaiAaks9CwGjc1jnL1wFGrAkjG6R9zChwSK7yZl3phAlRbHoBNeiP360L4kck1IaKAOVg0tQNpnKItut5YkyYaOQWMFVBKCxYx55YQmPBo55CNFqjVufRptFB8q973CS+pQTi+joZqVaHdt8s7IYK3SOfyIf7N3SVUQh8lZ7WWm03gy5hShYxj7Zr7Vz+i1qiEl5PVISMo+Nk/T+v621UoOMntHf94oKjvzAtJ93sNeALSWhIqVXYoL7VEUnIyBzaTyKejIVke0JFGC3zJMZUfdmKW3oQJ4zhpIK18dxLkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDB1PymMVQQBzymG9Ua0rZdfpUT185DSllut3qheXJg=;
 b=HHFzPPFGFefsfg7JAUnf2uSpoWwVtGjDk9GZp/8LW4jF+Yu6fullVgREqBbJU2C/kh5Hydl2GlvoxP63tnlOpa+/diQXQCU+QpVXHO86D4tfE3eoqUWV04k3ODaxoxUNB12yJ/rerLjhDRvwjIixwUP7z/TRQau4me3CkNspY92oJGUyPZ2+fRAoOxKblKTer8smTRHRHrCIUh5Aaz3vE39NTG+Za7MsMss51nSJZlWVyZwgksStA0J4C+2BxwQuxtCkbr+sMKUG9Cc7NH2g8qzajVuUw05fRtUqqwXN0UOfe7oamnlvR4xgMSt1u7EY9AaSn+MgZ6AFL6qsY6R6mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDB1PymMVQQBzymG9Ua0rZdfpUT185DSllut3qheXJg=;
 b=toMeQVdHo0/443UFYhN3RwlwJntRlVCi4kRh3gmGLMyd3hdZy5cBtzE0GbQKFOUTP9jh01c3Y/LFQBS4YYsfakeb3lrmvAcx+1V9XhODA3621nlUEgmqlFOArzLPKrETaZe80QX7cP6od4crMMMc2BZ7aXrtImepwIGJgUjcAcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by VI1P193MB0733.EURP193.PROD.OUTLOOK.COM (2603:10a6:800:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.22; Thu, 11 May
 2023 11:22:21 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%6]) with mapi id 15.20.6387.019; Thu, 11 May 2023
 11:22:21 +0000
Message-ID: <42ea93a1-3186-b8ff-c317-d51f3e13856e@kunbus.com>
Date:   Thu, 11 May 2023 13:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [linus:master] [tpm, tpm_tis] e644b2f498: RIP:acpi_safe_halt
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        linux-integrity@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        jsnitsel@redhat.com, peterz@infradead.org
References: <202305041325.ae8b0c43-yujie.liu@intel.com>
 <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <d80b180a569a9f068d3a2614f062cfa3a78af5a6.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|VI1P193MB0733:EE_
X-MS-Office365-Filtering-Correlation-Id: ae1f24af-796a-433c-1d95-08db5211fc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQC8sIN28ph6kDOg72k4ZYTlqFQRlnnmW1VFaLNbyBQrHpAhhqk1APK3nqYX9G3RS1zSmBu6pqKJPLLMzY2stFtjoRlrjXd6BJLoKbj3QVO9ztTUjKDfX+GQ5shnI9F+ZO/ANEuXDMJB0jjCu9eWbqzx5nQrM9UijbtvEUMrz2YYxBAs3/ZuWscpEQpDtOnBMVVaK/CWcV0tb1PW51EGkSvtqk9YJlxgqA/7xcdzEUXJF8Qf0cgKNOhHMMC95RPObCwKxFWSpxpo5TA5iLd5IVFDpHP2+YIKAuUslA/zAHIvGxbsCPn7oBmU2BW4LbhXYEtKZKAqlnE3Gt9I6+GSBn8vp8qtH+KfZILVaEHhI+WbCHY0LWNQuyywL9uOtg7c4FtKTz1avHFP2J7ZOoJiwg/rqIZVKd8Crsm44ZYX24Wlc+soMp/BoEEEoz+kPGRBxRE7f7kI/SkeebFOC8ak/bROj9HIQwmF0he0RMOYroJfzHyk/s1s31GQhQdH8NqtisCI6tBexDDyzz1v/uNQypvgXZUq1DBFJTYOCuMn4+UsYXsimcu4KZBi9CZ1wh6tHjUpszHKR+AzPpmewv4NPawVgeYjWR6Lq8pM5vcAtXEZI1sCoKSOOO7B4apG5iz3J+ogo31uKDBrsl5e2ZZgHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39830400003)(366004)(136003)(346002)(396003)(376002)(451199021)(186003)(31696002)(478600001)(86362001)(54906003)(36756003)(6486002)(52116002)(966005)(38100700002)(8936002)(41300700001)(8676002)(2906002)(5660300002)(316002)(66476007)(6916009)(66946007)(66556008)(6506007)(4326008)(6512007)(53546011)(31686004)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0wycDRxaWg0Ynl1TUZGbFRVcUtnZERsQUZvUWx5cFlNTUwxbEhGK3lhMDNn?=
 =?utf-8?B?MU1sb2ZVYy8rcitwWGtORHNrZWFNSzZkMnNpdjZ4RUhNeEJMR0VGWDNGeXJY?=
 =?utf-8?B?bUNYWVpoNDUxTHlkTXdsMUVvMnhwNEw2NU1EWHFvS3pERnlGTE9za2tTbzJh?=
 =?utf-8?B?WVhQU21YbFJOOXFDRStmZDhNaURpVi9yU0FmM0dQcCtwaGMwVjdqM3Q2QzhC?=
 =?utf-8?B?WXYzckEwdjlMSkQ5QXFKNzh5WWwyUjJBQ2twQnM1UzNVeTdVRnY1RlBtM3px?=
 =?utf-8?B?Vk84bHR4WnJQenJNWE5na005bU9uN3Z3emlTdllibTJwM2p3VUFVK2JFMkRT?=
 =?utf-8?B?NnJhMDhYSUZRcUhtZ0tMNE9GSlpCcm1NS3dBV3dnU1B4VEdLWERDdnZPMDNZ?=
 =?utf-8?B?RVRIQkV5V1JWSDZFejVOZ3hqZTRQaWdDOGtWQldRa3Vrb3ROUVhSZlBlUUhp?=
 =?utf-8?B?OWJJV0Vka0UycTd2cXNJejhXVTlmdjJRdDBGdGN6ZVpTSzZKbDFhaHF5cE9i?=
 =?utf-8?B?NEJ1cVNOS1FQektlblEvRWVNK3I3cUZ5VEI4cVpGclcya3ZQR080ZFJjeFYz?=
 =?utf-8?B?eXIvRXFTbGVyaU52a3NBWmFhTEIwZkQrOFRZWTBmaDBNWm56M3NZajBHV3B6?=
 =?utf-8?B?ejdZWHZxQXNlUlhtSmJwVzJWcThDOVgvbHVMckxuS0lyT1E2blZFcGJqU3dl?=
 =?utf-8?B?MWllOTFxMlQyOG9XT3FUMkZsQ0llcWxXZHNxS3VLcXF1RnZTajRxRTlhRlhi?=
 =?utf-8?B?ZzVFRUtocDJCNXVkRjZFN1ZZZGFNVllNQ2JYZHlEWGgvdFplRkhhTlNQZ2pS?=
 =?utf-8?B?d1NLcm9lTzU3TnJxNEFoN3lMT09TdmkwVTRQRUE4aGlSUkFkYWtYWjZGeHZQ?=
 =?utf-8?B?ZFpVbkhIbjVrMjRqL0hSdnJWLzlJdUM5M1lhZjVZTHA3ZzAwOG5ab0lxWXpD?=
 =?utf-8?B?V1l1VzNnYUg1ZndOTThlTmU3eHgzU1NFaUE2aGJSSUlEQ1A1bVZ5S01RcU9i?=
 =?utf-8?B?bHVWV29Bb2xYaTdxUXc4ekpqaVNZaFcrNEpSSklqNElEWXIyUDZpQVhJMDZu?=
 =?utf-8?B?cm9zRktNVStOYW9lT29WN1lnUXhoWFhvZVdUT1pLUWd2b2hlcDk4a2ZOY09w?=
 =?utf-8?B?bENrYjRGa2E5YzNSRW4xVmp6NERUb1hoUTd2SUFSd2I2d3plaUk1Vk9PWjVN?=
 =?utf-8?B?L04yZUszNGtjU1V0MTNwVEprZEZBc3ZwcCt6VU1mcVdRRVA4ZGZtSmE3TzBq?=
 =?utf-8?B?SnlkWmJYSGJtRTZWTy81SW9sU1h3Z0w5Vm9kL1NHaWMzaHRpL3VKUktHV2NN?=
 =?utf-8?B?NlR2cFBWTnp2SEVxbkxaSS91U1JBU3U5NlU0Snc5dTlzc2JwcVRVYnpPcHAw?=
 =?utf-8?B?Vm1kL3V6V0szanFrMjV2aWxLNEZQcnJPQTVLaFdOUjhkVEpHd0tZd1RMMzJQ?=
 =?utf-8?B?WmpKU2VnRHlUQXVCLzhDOVZZNUF2UUovNHVDZ25PeENCVU83a3ZLTEQxNG5l?=
 =?utf-8?B?QXlmS2dUSXpkTFNVckRoMmVHYjlRRUtyQXJKLzhCUnFsWGRtb1F5aWRySERj?=
 =?utf-8?B?ZnMxVVF0eWxKREIzekpBa0piTEFERXBqUWszalh4OFo0czBsU2dWYi9rYjdx?=
 =?utf-8?B?UXkrdkp2bWY5WTBmRTVPcGhHdkszWFlnZTJGMDc1WHVRc2cvM0VDQXhuWG03?=
 =?utf-8?B?MGdqa0lqOFM5RVZkUEd1aEJXQ2Z3d2tCUlR1SXVnRTlRaDYwekRNTHFpRjFN?=
 =?utf-8?B?YmZwbDBLL284OEhpd29JUEtMWTRmRFQvanJWaGpBQ3hzbkFQd2VyVGdJUXRj?=
 =?utf-8?B?RWE2UW5pSXZESHJ6WEkxZk1mbGJETDhhZWRqYkhMbGhqbk52TTRSQS9yOTVB?=
 =?utf-8?B?amhIT0NxUUw4TVRydXBBZU5Cakx3MjA0QVhNZFFpK2x6c1Y1UUZyV29kb2Ju?=
 =?utf-8?B?dHF3LytnMlNFRUxDVmx4MkJtd0hKdXlOZFI0UFBsZlVpbnE5WUhpbGgzS3hs?=
 =?utf-8?B?blZBUjZDWTFiNkVLbGRJQndmUTlNL2ZKZlJBUUUyc3pLUDcvN0Zza09LZFZm?=
 =?utf-8?B?b2kvdUNCQnZUa29ZU0VHbVdTUHRFemFWeHVwYThtVkZPdnVVc1dPVjJUakx3?=
 =?utf-8?B?S2hpYUpESk9QSjc1d3FVVk1ySnVBdkRwMkd4SDVIMk4wczlJRXFxakYrM0ZJ?=
 =?utf-8?B?Rm5hRFljeEhkQjVPdFVxKzdDQy92WWRZSFhidnhyemtsUUhRbWU3UmhMZEhq?=
 =?utf-8?B?Q3RnNUVDN1k5dUg1UlFlRGppZ2R3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f24af-796a-433c-1d95-08db5211fc8f
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 11:22:21.0149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhTYRYm1EmYTSjLsJyX8WPkFNbAYvNr9pT8qMLjOAXHyh7amMWFjGKM05FjBuovMgU27nLGoXspF149YYwc6UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P193MB0733
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 11.05.23 00:00, Jarkko Sakkinen wrote:

> 
> Hi Lino,
> 
> Have you had time to peek into this? I just noticed the email, just
> asking if some findings have been already made or not.
> 
> BR, Jarkko
> 


Since beside the one reported by Peter Zijlstra 
(https://lore.kernel.org/linux-integrity/CSJ0AD1CFYQP.T6T68M6ZVK49@suppilovahvero/T/#t)
we have another interrupt storm here, it is probably the best to handle those in general
and to disable interrupts in this case to fall back to polling (this is also what Jerry
suggested in the thread above).

I will try to provide a patch for this.

Regards,
Lino

 
> On Thu, 2023-05-04 at 14:12 +0800, kernel test robot wrote:
>> Hello,
>>
>> kernel test robot noticed "RIP:acpi_safe_halt" on:
>>
>> commit: e644b2f498d297a928efcb7ff6f900c27f8b788e ("tpm, tpm_tis: Enable interrupt test")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linux-next/master 84e2893b4573da3bc0c9f24e2005442e420e3831]
>>
>> in testcase: stress-ng
>> version: stress-ng-x86_64-0.15.04-1_20230427
>> with following parameters:
>>
>>       nr_threads: 100%
>>       disk: 1HDD
>>       testtime: 60s
>>       class: interrupt
>>       test: signest
>>       cpufreq_governor: performance
>>
>> compiler: gcc-11
>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <yujie.liu@intel.com>
>>> Link: https://lore.kernel.org/oe-lkp/202305041325.ae8b0c43-yujie.liu@intel.com
>>
>>
>> kern  :warn  : [   26.609994] CPU: 21 PID: 0 Comm: swapper/21 Not tainted 6.3.0-00022-ge644b2f498d2 #1
>> kern  :warn  : [   26.609994] Hardware name: Inspur NF5180M6/NF5180M6, BIOS 06.00.04 04/12/2022
>> kern  :warn  : [   26.609994] Call Trace:
>> kern  :warn  : [   26.609994]  <IRQ>
>> kern :warn : [   26.609994] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
>> kern :warn : [   26.609994] __report_bad_irq (kernel/irq/spurious.c:214)
>> kern :warn : [   26.609994] note_interrupt (kernel/irq/spurious.c:423)
>> kern :warn : [   26.609994] handle_irq_event (kernel/irq/handle.c:198 kernel/irq/handle.c:210)
>> kern :warn : [   26.609994] handle_fasteoi_irq (kernel/irq/chip.c:661 kernel/irq/chip.c:716)
>> kern :warn : [   26.609994] __common_interrupt (include/linux/irqdesc.h:158 arch/x86/kernel/irq.c:231 arch/x86/kernel/irq.c:250)
>> kern :warn : [   26.609994] common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14))
>> kern  :warn  : [   26.609994]  </IRQ>
>> kern  :warn  : [   26.713811]  <TASK>
>> kern :warn : [   26.713811] asm_common_interrupt (arch/x86/include/asm/idtentry.h:636)
>> kern :warn : [   26.713811] RIP: 0010:acpi_safe_halt (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:72 drivers/acpi/processor_idle.c:113)
>> kern :warn : [ 26.713811] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 80 ce 02 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d f1 dc 38 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90
>> All code
>> ========
>>    0:   90                      nop
>>    1:   90                      nop
>>    2:   90                      nop
>>    3:   90                      nop
>>    4:   90                      nop
>>    5:   90                      nop
>>    6:   90                      nop
>>    7:   90                      nop
>>    8:   90                      nop
>>    9:   90                      nop
>>    a:   90                      nop
>>    b:   90                      nop
>>    c:   90                      nop
>>    d:   90                      nop
>>    e:   90                      nop
>>    f:   65 48 8b 04 25 80 ce    mov    %gs:0x2ce80,%rax
>>   16:   02 00
>>   18:   48 8b 00                mov    (%rax),%rax
>>   1b:   a8 08                   test   $0x8,%al
>>   1d:   75 0c                   jne    0x2b
>>   1f:   66 90                   xchg   %ax,%ax
>>   21:   0f 00 2d f1 dc 38 00    verw   0x38dcf1(%rip)        # 0x38dd19
>>   28:   fb                      sti
>>   29:   f4                      hlt
>>   2a:*  fa                      cli             <-- trapping instruction
>>   2b:   c3                      ret
>>   2c:   cc                      int3
>>   2d:   cc                      int3
>>   2e:   cc                      int3
>>   2f:   cc                      int3
>>   30:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>>   37:   00 00 00 00
>>   3b:   0f 1f 40 00             nopl   0x0(%rax)
>>   3f:   90                      nop
>>
>> Code starting with the faulting instruction
>> ===========================================
>>    0:   fa                      cli
>>    1:   c3                      ret
>>    2:   cc                      int3
>>    3:   cc                      int3
>>    4:   cc                      int3
>>    5:   cc                      int3
>>    6:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
>>    d:   00 00 00 00
>>   11:   0f 1f 40 00             nopl   0x0(%rax)
>>   15:   90                      nop
>> kern  :warn  : [   26.713811] RSP: 0000:ffa00000003cfe68 EFLAGS: 00000246
>> kern  :warn  : [   26.713811] RAX: 0000000000004000 RBX: ff11002088776400 RCX: 00000000000000a0
>> kern  :warn  : [   26.713811] RDX: ff11003fc2d40000 RSI: ff110020896fbc00 RDI: ff110020896fbc64
>> kern  :warn  : [   26.713811] RBP: 0000000000000001 R08: ffffffff82cc6620 R09: 0000000000000008
>> kern  :warn  : [   26.713811] R10: 0000000000000006 R11: 0000000000000006 R12: 0000000000000001
>> kern  :warn  : [   26.713811] R13: ffffffff82cc66a0 R14: 0000000000000001 R15: 0000000000000000
>> kern  :warn  : [   26.713811] ? ct_kernel_exit+0x6b/0xb0
>> kern :warn : [   26.713811] acpi_idle_enter (drivers/acpi/processor_idle.c:713 (discriminator 3))
>> kern :warn : [   26.713811] cpuidle_enter_state (drivers/cpuidle/cpuidle.c:267)
>> kern :warn : [   26.713811] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
>> kern :warn : [   26.713811] cpuidle_idle_call (kernel/sched/idle.c:219)
>> kern :warn : [   26.713811] do_idle (kernel/sched/idle.c:284)
>> kern :warn : [   26.713811] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1))
>> kern :warn : [   26.713811] start_secondary (arch/x86/kernel/smpboot.c:198 arch/x86/kernel/smpboot.c:232)
>> kern :warn : [   26.713811] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:358)
>> kern  :warn  : [   26.713811]  </TASK>
>> kern  :err   : [   26.713811] handlers:
>> kern :err : [   26.713811] irq_default_primary_handler (kernel/irq/manage.c:1027)
>> kern :warn : [   26.713811] threaded tis_int_handler (drivers/char/tpm/tpm_tis_core.c:756)
>>
>>
>> To reproduce:
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         sudo bin/lkp install job.yaml           # job file is attached in this email
>>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>         sudo bin/lkp run generated-yaml-file
>>
>>         # if come across any failure that blocks the test,
>>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>>
> 
