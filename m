Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D7619CE1
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiKDQSc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDQSb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 12:18:31 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD28225D0;
        Fri,  4 Nov 2022 09:18:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZf5vyEOUIM9f/x3Y2a7zD+/LGV75hFttzZs35Js38h83kdLJV2K/Tm2lRtAg0TUv6WsfAwZEJKkGX53zu9j9zDBLcSpvFAnW1wB9GdIkdaAptdMSryJO0rujDRW3JEuZvXCva3e2+wdNzYpHi+exNPxxoo+nFoNg5jq2nGfNWZ2adbjOPJ+eIE0CkmX2wvmiBhVgz8ZIEeIZVSMQU7nDrJp4wzod6U8Fcmqi9vEaKln326EIX27id6jrF7vI+8xy8n86WtgeR5RWaEK+0DSbnKAR/c5HVcDx8Kf8QdofEnDbO5T8wQILm6iPnjbVVhnwwDGR+BkBrpABs9a/t+7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKcPwQGLxsjt8DNgSsKT3rKoO9yWb+3XJO6VRO1gSAs=;
 b=ExphBW9XeEY500wp5m5LRhkawvznUICNPdKPgUQIunxans7N42zOqH8+7nH/1Pp7vnRA55U4/6EKfzzmUu8gN6K/uDNPMopb/MDAffVDx4fnZl6tML4a9m2S48xxKIe1hC7WfMwWxJ6oxIWImTOWLlXpBwRZXtPhf2SeZxx7BWiYjTuPqjjnbov2vGtr2MaEbvO660lzry5Fts1EKkX30S6VPBJynhWbUaHy5LKL/f3OqNNp0MFf3VgF7sgiq5yNvKyIpVUhx9uwX27RjYpMJunXMMRrVEtSMDc1oDRiI/+bf8Y33XUBHKXhsAwExGyWsbI99XPO+aYEWvu6stA2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKcPwQGLxsjt8DNgSsKT3rKoO9yWb+3XJO6VRO1gSAs=;
 b=hg3tZ3xmq2iYPLTNVvZw9CewBuTPoFfBVKmyOPZ0jhL1tT02pSdYLTwz8ESAfKxbmqr5GIr9lbCWNnSAOYqXl0890dZiC1oJg5BQIQ0sOG4uSsVjPvdBHtK4/ZfwsdIczJgiZTfkJPJP8ijxSxRG5QynnDkvVGJqq31mnK/hGq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DBAP193MB0908.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:1c3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:18:24 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::e189:5d14:9bbc:da4d]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::e189:5d14:9bbc:da4d%6]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 16:18:24 +0000
Message-ID: <57b193a6-8340-c883-04bc-6cfbc3c638cd@kunbus.com>
Date:   Fri, 4 Nov 2022 17:18:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v8 08/11] tpm, tpm: Implement usage counter for locality
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, lukas@wunner.de, p.rosenberger@kunbus.com
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-9-LinoSanfilippo@gmx.de> <Y1TFzO1CBY8d4rfa@kernel.org>
 <fcf53b02-a505-46ac-006e-0e317f00bbe3@gmx.de> <Y2Bw/yhTs258Iiew@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <Y2Bw/yhTs258Iiew@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DBAP193MB0908:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e458df-5008-4b9d-66be-08dabe803278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIg3L4De2W6GJnRg2LMxlpyewIF8lvjNarkCQGW74g5Qkv/wBT7WsxSq9A1B0nK1mf3fUQcEOnHdWxxyPBJvdLi7VQWX/4fP7m0k85n95FIV2uo80TW1DedSfFZpEaap2Bt6Yn0pgDbyOmUbzqFsC+dkmSMGHZ8sxj+6Z1QrbE+oOI+jhZiYg6cIPy4gw5IUuIRO96aTpnGbxCEdla5QKTGfYDF5Nj/IhPQC7GRMB6ihifQOPUkvNzfXCXS4pepNNCbuK9sETVSbnIK6UmpuF0cnpJbuAvMQmccOzrBHsWNGU3GXRJMSJr0ZICn3hQ5Dc9FH7CRz0LqgjmJuFAvZa4bTUrfN1kxJS57yQ4uVvAVLijE4RRgrHJAbEsHhMvaCL/s5B+YU+FXhQMU/d85mFxwFuUoem4kHsCrmsDiZ45p9OledeZdDQILWGJ702EWjsS1PdlrAHSzuc48xSkYXHAKeRrISHLTSSrOxwepJsp/EGLPUli7J+SnVSj7oZ5JskDlEtaUMwl2Vt82SKMULpFXUYn4kF5zaFSxroMIOhpLbrsN5cJzxXRI6aTDNFv7xJyJiN17+EpZ+WY8d0naSdC20G11VUZHodMg8x2/I5Q7RtdyJEFWvZmoBFZG8dT2V/SCazKtHC1R925U8GfCBHcbSWRi/QXnFRcNKYASkV6Mm+mHA5XIi/Wjsu/0o+c0qENLCJ5EFUIj1xyN2O2gcou5gZcHg+IfWbChCV8q2mCsPIOaigVr2W5vzdBfGHwXNFdMSgdjnOq5maoBgFjKoh5IaEFFD8xUNkOaDwKkBSpiWI/vl6KiiyN8I5Qtgo9nA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39830400003)(376002)(396003)(136003)(346002)(366004)(451199015)(186003)(2616005)(83380400001)(107886003)(6506007)(26005)(53546011)(6512007)(6666004)(52116002)(2906002)(7416002)(478600001)(5660300002)(110136005)(41300700001)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(316002)(38100700002)(6486002)(36756003)(38350700002)(86362001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlZaSWY4bGE3T1ZNTHVlYXVNb2d6MWc0WEZ0SmZ4UTVKZG16YlNLb2VRZUxR?=
 =?utf-8?B?bG9RVC84MzlFMGpNcmRFeVFOWEhXdkc1WllNSzFFbVE1bXBGbi9WdjhZR0Rx?=
 =?utf-8?B?SHhJamV3T0RRQ2RpcXozOGEwMGdSUjFSQ1FhVkYyWHVEMURkZmhmTStPbkRk?=
 =?utf-8?B?ckFBWFllbG9DdVluOGJSb2U4UzdrSFNVV3M3TCsrL21lT3cyWHNsTStkU0lp?=
 =?utf-8?B?dlhNRUZUUmpSRW13WVNBSDZMSGk5VnZYZXJVaWVmMThNUFFxOElHdVYxbUht?=
 =?utf-8?B?aGZyZjhHdklVb1E0VGJRM2ZJRzVQRFVXcG02QWF0QVQvZ2s3QUxpdjNjcmJX?=
 =?utf-8?B?QjlxYWpKWlRuWmNuUFRUWkNDT3I5NjJxOElYbElUazFLNURKdXFyaHp3N3Fa?=
 =?utf-8?B?TWQxK3hwamg1MlZUbWw2WWdMck5oWlRNc3dLWXE2ckk5TDlhcTF1RUx2MERE?=
 =?utf-8?B?VDZrdHJzZEduTmpid3UwdlNtc3YzcEtoMExMdm1pYXB3QURCOVVTekxielpa?=
 =?utf-8?B?aFJjb244NTNHU1hpZWE4dlZ0YWtMcE9CU0ROYXQwK0R1RXUxRVBvMmJHZlVJ?=
 =?utf-8?B?cTNDMHp5dkN1cE1kcEJGSmMyNHNjRm1laWJST2VCczQ2UjRIM2I3MXlrb2RP?=
 =?utf-8?B?ZGNPOHltb2pRaTZ3ZWRLaVltUVpUMkRYRy9KV09NM3NoNk93RUZ0VE56TDhy?=
 =?utf-8?B?R0gyTHVtbndkZnpLK2ZkRVVmRGVWTXVTWHVwWVBBMkM3YjdsUEJkU0Y1STl3?=
 =?utf-8?B?TW5JVnc5TlpJSWxqd01mNmNBbHBneitKNUY2Z2U0QmRtd2dJcE5aSG8ycUVz?=
 =?utf-8?B?UlNsYkpzcFlySGZtbnZRajlydnRTRG4zekNoMkJCemdWRFNCSUlSLzZIcmEv?=
 =?utf-8?B?SWtsNVNlVGFQaVBRcTdBa014UFBpbDNMbmFqb0YyNlVUQy9nUUp2Z08xckdZ?=
 =?utf-8?B?TWU4OFNPejdubnVTeFJYNDd5bnNBZWNicDUrUEttN29oQzRzblc1SEY4WnhL?=
 =?utf-8?B?ZzRlN2pnT2pkVW85WWFqZVdhb1hNU1ZBamFqK0ZXSCs5Ujh4bnJPcndjMlMx?=
 =?utf-8?B?NVh5dE14S1l4U3ZOakpNU0t5ZHVPNnJiYUJlS0lVT2p4RVBhUEIrSGx0ZGlT?=
 =?utf-8?B?cnREYUw0VllKdTkwNVdkTlhwM0FvV2I5U1llZzNPczM0d0ZLWHplMjdoZmNZ?=
 =?utf-8?B?SnhKaVVtVlhqMTdDbHBDZ0EvdlJqUWV1UnZNRzAwUUQzaTc0N0pwRjFUUGRU?=
 =?utf-8?B?Y1hYajM2UStGKy9ac01DWFFXMTYzLzErWU1XQm5OUldzTlZPeEpRMDZBQTl3?=
 =?utf-8?B?WTlMWGVtK3ZpSEFORWhRV053NDBGZGVXZjJORU1ESGxnSWp1MVp1MnB4NWRM?=
 =?utf-8?B?M0diWG05eTdrTElnN2NKMXZFRm5TZnFvSzdZZjQyU3V1ZWoveVI0YmtOemsz?=
 =?utf-8?B?NzJMUEhjbmJTL2xMWDd1NkZMbkdqaWxsczFQN09BV1BMMEtmbW9RUDU4WDJN?=
 =?utf-8?B?VGQrSlFpWVRFRG5rOFRPYUhsZHFyd3BRWm1YMy93ckxseVg3aUI2TWU4VEZ1?=
 =?utf-8?B?UHA3QVVLRTZVcm0zbFNqcldGNG9rUUloZUtIN1BFR0xoM1JqaXlOa2pvNVZa?=
 =?utf-8?B?YlNQT1ZrZ0k4UngvWlo1TXVoUTF1UGs4d2FVbDQrYmg1RTI1NzVnNVoyLytC?=
 =?utf-8?B?OHk5bXQ4RitYM1RIU2d2SkFSbU5rTmtXV1E1UDg4a3d5UTlGMXpqYUtJNFA3?=
 =?utf-8?B?VGJZKzFTL3NScWtzZW5aZm03KzFBV2ljbEhMM290U2RhaXRCanNqRVNLamlE?=
 =?utf-8?B?RXA5RTVIRmVMMU1XWHFSSDBZRU1SWTM0aitZb3NobWE2TWUxM0ZDT2IxSjZK?=
 =?utf-8?B?ZlB5VFJlZXlaVmNOU2hnanREVzJxaWdTZDlwRm5VUDV3dVNIdHpkQ2VFZkVm?=
 =?utf-8?B?cjhPMVE5WGF4czNSaHJJT0FlaGlhb2MvblFENldWYVR6QW9YK2pDbGMraUJG?=
 =?utf-8?B?N1lhWVd2MFFVaWVYelhOdXlHQ1dnaVVZK2w5dmpWMG84S0JoMGFhTjBtcWxO?=
 =?utf-8?B?c1dEeG9QQlNTTElvZTVkL1FQVEFIbEk4bENVTCtjN3FnTkRSRU8yQ0ZJNW5L?=
 =?utf-8?Q?TNrRs2UtS26tjxxDQbZwUizYL?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e458df-5008-4b9d-66be-08dabe803278
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 16:18:24.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUSqu05sCqF/M5bbavB3bqDE2nlqBnYJCgD1bDOBFkgVJ/XSfRiy+AS9R6an15g1810n1Qe8ZnuSGdzyRHEOSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP193MB0908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 01.11.22 02:06, Jarkko Sakkinen wrote:
> On Tue, Oct 25, 2022 at 02:15:51AM +0200, Lino Sanfilippo wrote:

>> Actually thats on me, since it took me much too long to send the v8 after the v7 review.
>>
>> However the reason that we need a mutex here is that we not only increase or decrease
>> the locality_counter under the mutex, but also do the locality request and release by
>> writing to the ACCESS register. Since in the SPI case each communication over the spi bus
>> is protected by the bus_lock_mutex of the SPI device we must not hold a spinlock when doing
>> the register accesses.
>>
>> Concerning covering the whole tpm_tis_data struct:
>> Most structure elements are set once at driver startup but never changed at driver
>> runtime. So no locking needed for these. The only exception is "flags" and "locality_count"
>> whereby "flags" is accessed by atomic bit manipulating functions and thus
>> does not need extra locking. So "locality_count" is AFAICS the only element that needs to be
>> protected by the mutex.
> 
> OK, but you should should still address this in commit message, e.g.
> by mentioning that in the case of SPI bus mutex is required because
> the bus itself needs to be locked in the mutex.
> 
> I.e. this a claim, definitely not an argument: "Ensure thread-safety by
> protecting the counter with a mutex."
> 

Ok, I will rephrase the commit message accordingly. 
Thanks for the review!

Regards,
Lino 
