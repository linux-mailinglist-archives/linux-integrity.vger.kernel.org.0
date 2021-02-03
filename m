Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BF030DC3E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 15:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhBCOHp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 09:07:45 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:54917
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232569AbhBCOHb (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 09:07:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbQJVkeeb9x6qbA30NENOKxo2DXavtnwMJ3b3CNfsaskKTwH0YvZt4YcTEju4ozlFdGX7Odmn2cpD+fHrliII3CPTv7T9+Ub8+rpBXyhCdJDDz1w1yV7oYhzHKuqpu4qfdt8dCBnmDoc6kJPUjzU27gItBA/F/zAwaNiiqqgZrrzgV/dSvzqUWCFjRhvdSlkppej1Q/FnsZV/BrbgqoTGAScNDORTPPYEYySsv7foRMFWlrJ5V5FfF1zUH0/YwnsGsHahJYApFeNUWIaOdP5dYanydP0g3PFEVmlcTBqGEacJLpiCTHy411TUIZaQIVvzISP6z0QLK8L6NMaDxNxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfXG3yeTuuu1KN/e0nWK8zBZcsz92iVUmh2Ggs51D8A=;
 b=aOVVU9e3FUEhfpa6gMb50/OCQAiuboKQ2FOljcleS1v7v8m8k9OvSYh41U3hwFCv9qo1sbo8IHj/YYCnSEGGOVH2yDFmfXi+eTcITl1Qw5TnkLDyOFOgpkKn30ZIUy1Vs/Zm6L9N879C9zM6FcH47vJ7cxHA34cqBjsuReV/YaVWG1cTuB/2rl1vaqAnlri8pOCPIaSd8zQwxsf364v9reVV+mgPDg2cQ0GvlN2F0cfWHflHj6LWecER/BDmSO+FaGGtkSHF3lBi7olZmRMbnLJigvdbFQ8+iAMznMpZSDzo1x+CnGjdfopCujN94jAUa21BgKQ76yCj4JqJMG/p5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfXG3yeTuuu1KN/e0nWK8zBZcsz92iVUmh2Ggs51D8A=;
 b=Sf3CRiydI87EMiyzneIq5jQiVaZB1XZrasyoj/Epv8oGVN03712LTY2s/DD+9sYsDpqCog//s2GaTk0JBkv802aQswUF7m/ElOWqmJPRI28V3ISiGsdPuILNhmMKRkDbY+Cgg+TKhFVv44S02TJMF+d0E4cLcxrX2ANHJNzIqLU=
Authentication-Results: hansenpartnership.com; dkim=none (message not signed)
 header.d=none;hansenpartnership.com; dmarc=none action=none
 header.from=kunbus.com;
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a0::11)
 by PR3P193MB0944.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 14:06:31 +0000
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73]) by PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73%5]) with mapi id 15.20.3784.022; Wed, 3 Feb 2021
 14:06:31 +0000
Subject: Re: [PATCH v2 1/3] tpm: fix reference counting for struct tpm_chip
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        James.Bottomley@hansenpartnership.com
References: <1612303743-29017-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612303743-29017-2-git-send-email-LinoSanfilippo@gmx.de>
 <YBn3rdErdKNAUdgZ@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
Message-ID: <01cb09f4-2ed7-2101-24c2-17390b0d3b39@kunbus.com>
Date:   Wed, 3 Feb 2021 15:06:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YBn3rdErdKNAUdgZ@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [87.130.101.138]
X-ClientProxiedBy: AM0PR05CA0073.eurprd05.prod.outlook.com
 (2603:10a6:208:136::13) To PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:a0::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.23.16.111] (87.130.101.138) by AM0PR05CA0073.eurprd05.prod.outlook.com (2603:10a6:208:136::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Wed, 3 Feb 2021 14:06:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a86cb7-4903-4eb0-1dc0-08d8c84ce874
X-MS-TrafficTypeDiagnostic: PR3P193MB0944:
X-Microsoft-Antispam-PRVS: <PR3P193MB094435B1913106FCA4AEDBF2FAB49@PR3P193MB0944.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/CP2AvMySH8hTzgkInvYU8vd7n58Jlz4zRmwoSPRAG28FionKGS4Ii7MbPCejuUe/tXftaPqFZfo2tY/NrOwqbs+3gUFC90MEIhovJLG4+U33oqeo5SPIjCg51hhEMQM8rv14IjGYnCvSoDRW9a+cBz2UrWQlLS0MZiRD+xkjPb+1qm9fTgs2Zpkm8Wnl6lAflVBnYCSTcISXfKVozriHWhs3F10+PqPYCecKQi49OE+c0Gw2rqVKSvbBx4VletmSmntxsX9qnXBcthhUWxQhofUvSUFQgcIxcI/mOKAUH0hhgDGP6STsT55H0Cfsw8svrxcSfPxkb63QeXj7TpdrkZQFs66hUrFDwfbzyGyDUgC8Z2sArUhcxy+dQRX4bLyUIb0dLdBk8fvcgscwY4Puvut8ITXDKc4DFnJsOlE3YJvFOun3FWa8mSedAaZez4BKI+ZvUFEHDwbNtvY6Ip/FRiytCTYwuxEtthwj6OTKmJOzJp9NAv4IBtJxzCIapGZd79O1mUX3QN5jk0IMOg1IwShT1wsUrmg8XJgSUj/4qSIL23kSY78E/USxHXbRW2ptkmJfCnnqps8DnB4I/5HZ4K1TzLjeGh8Fo9CBevf74=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0894.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39830400003)(396003)(376002)(346002)(5660300002)(16526019)(2616005)(956004)(316002)(110136005)(45080400002)(8936002)(16576012)(31686004)(26005)(8676002)(186003)(66556008)(2906002)(31696002)(86362001)(66476007)(478600001)(83380400001)(52116002)(4326008)(53546011)(66946007)(36756003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R3FNdFkxTE1UbDNwZFpKYWR1czMzWUxEd2dFazMvM3MwcG0vbWtJeTBMQkdZ?=
 =?utf-8?B?TWtLWG5ldDVGbk1qVjVIbkpkWTZMa0xGMVgxdkxJZmtTUDB6RFlrRXFXN2dR?=
 =?utf-8?B?NERacm1taW9IdGs5ZjhuRjI1eG5EeU83SHFmQTBMM3l2dUlXbnJCbUY1aTdW?=
 =?utf-8?B?VUxMM1YwK3BZa2dKcERwWVkvdU1FVXRpN01MZXlDUlFhUGlZemZNMlBiRFJT?=
 =?utf-8?B?cWtSMGoxV1VQbzlVY2VMaGYzcTdqNHhVUmo5YTNvUzFwazRTYThEdHJqdTZk?=
 =?utf-8?B?NnJaMElGditxSFk5UFpXcWk3YkJ2VDdVRjREb0gyNS9RMFh0RTd4NlpRRzVL?=
 =?utf-8?B?NzRqVi9zWmI4ekczOTRZa3pwcGRHMVFoSmdjTW5zTE5kK3FsaWN1YnB6WTE2?=
 =?utf-8?B?Ymg2UnpiNDdOV2M0Nm9wWXUwbEdVNCtMQk9OYjhoTHpTeDBOTlN4ZW96NGln?=
 =?utf-8?B?anRvQ2ltYmN6MW8wQjFiK1MvU2o2bEJtUE1ENHhYR1ZUSmIwVkl2ZldrNU9l?=
 =?utf-8?B?L2pvUGFwUi9xZnF3eHhSMjFUSE0vaWh6dHExVUJxSjA1aGE4cmc4ZWFmNnQ0?=
 =?utf-8?B?cS8rQnZHczdFdCtUSGdNUTNKZk1nN0xRUk83Z1NReEVYMmNFSUhubGNQa1hv?=
 =?utf-8?B?bU5Pa2N1ZzQ0NC92K29Sbkc1czBRcTRNUGF5TlM0YzVlb3cySGZoYWtmUWhC?=
 =?utf-8?B?dWpVQzVvcE1BdEFlalhkN1d0YnpXbDdsVFFRTXJTNkZuUlRGMnhZRitUbHZJ?=
 =?utf-8?B?cWhaY2sxMEJRNlRRaEZjamlFQ1oxRWM3LzFPc29TdXZ5T3EzaVRoblpoRVdY?=
 =?utf-8?B?M2NMVktrRGNiMDJYellxWGJyTXhTV1ZQeDFHVzdkSllmZGs0TUhHcERWSllF?=
 =?utf-8?B?WHF6L3Q4RHIxcVBMRDNDL1RTTUlORGhPcUtOdUtUVmRpeWwwOEtPR25KMlRx?=
 =?utf-8?B?cVoxbVZKM0JGTGpKMmViaXpLUktscGZ0d3JRRFFvV3BndkxYSDQ3WGpVTjdX?=
 =?utf-8?B?OWdJZFhSTHhXamRnWElYeGMvY1hPOWM3YnZZRmtuRGtvbFNiWXduMmZuTEhm?=
 =?utf-8?B?emVibDZiWkJvSmVmandwTW9ybUxRSHgwdWUxWjMwWWpqSHB1YjNlM2NWSk1v?=
 =?utf-8?B?NzA4K210Z2w0NUVyQmhlR3Q0dTN3UFB4Ump1aTVyQzF0U0VXbE1UWE1oR3E5?=
 =?utf-8?B?TEswa3owaDFUWkhmWGc5WndMMzNJazQwOWdHUlNDek5hcjhVc1JxOXJpUFRs?=
 =?utf-8?B?MXJ3aDhHL0YxTks3NEtoZjdOYjJEMjZrTVhNNTI3VStHcndQV2VVTjRhUEl2?=
 =?utf-8?B?eTZDUGVBUGF4ZllKc2hZcmVLVTBxU0Rqd25rRmo2bHJyUjE0T3doQzRyQ3FW?=
 =?utf-8?B?dXJaNUVTVXBIUXkzM0VlUU4yR25DUWNsdnErV3FJV2sxNlhpdEVmWWNYREt0?=
 =?utf-8?Q?DCcXAl4o?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a86cb7-4903-4eb0-1dc0-08d8c84ce874
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 14:06:31.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peVFZLbwqysN4S5wYPBXi5eFG2uKu0Rowl7BsbDXqE5lvmeJZ+RKB3gbgt0XBWEJbmjydK8hGXjAoDDy8JoP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0944
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,


On 03.02.21 02:09, Jarkko Sakkinen wrote:
> On Tue, Feb 02, 2021 at 11:09:01PM +0100, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> The following sequence of operations
>>
>> 1. open device /dev/tpmrm
>> 2. remove the registered tpm chip driver
> 
> What is "tpm chip driver"? Please just refer to the exact thing
> (e.g. tpm_tis_spi is the one you should refer to in your case).
> 

I did not explicitly refer to tpm_tis_spi because the refcount issue is in the TPM
chip driver core code and thus any TPM chip driver that creates the tpmrm device is
concerned. 

But if it helps to make the problem clearer I will only mention the tpm_tis_spi 
case in the next patch version.

>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 3 PID: 1161 at lib/refcount.c:25 kobject_get+0xa0/0xa4
>> refcount_t: addition on 0; use-after-free.
>> Modules linked in: tpm_tis_spi tpm_tis_core tpm mdio_bcm_unimac brcmfmac
>> sha256_generic libsha256 sha256_arm hci_uart btbcm bluetooth cfg80211 vc4
>> brcmutil ecdh_generic ecc snd_soc_core crc32_arm_ce libaes
>> raspberrypi_hwmon ac97_bus snd_pcm_dmaengine bcm2711_thermal snd_pcm
>> snd_timer genet snd phy_generic soundcore [last unloaded: spi_bcm2835]
>> CPU: 3 PID: 1161 Comm: hold_open Not tainted 5.10.0ls-main-dirty #2
>> Hardware name: BCM2711
>> [<c0410c3c>] (unwind_backtrace) from [<c040b580>] (show_stack+0x10/0x14)
>> [<c040b580>] (show_stack) from [<c1092174>] (dump_stack+0xc4/0xd8)
>> [<c1092174>] (dump_stack) from [<c0445a30>] (__warn+0x104/0x108)
>> [<c0445a30>] (__warn) from [<c0445aa8>] (warn_slowpath_fmt+0x74/0xb8)
>> [<c0445aa8>] (warn_slowpath_fmt) from [<c08435d0>] (kobject_get+0xa0/0xa4)
>> [<c08435d0>] (kobject_get) from [<bf0a715c>] (tpm_try_get_ops+0x14/0x54 [tpm])
>> [<bf0a715c>] (tpm_try_get_ops [tpm]) from [<bf0a7d6c>] (tpm_common_write+0x38/0x60 [tpm])
>> [<bf0a7d6c>] (tpm_common_write [tpm]) from [<c05a7ac0>] (vfs_write+0xc4/0x3c0)
>> [<c05a7ac0>] (vfs_write) from [<c05a7ee4>] (ksys_write+0x58/0xcc)
>> [<c05a7ee4>] (ksys_write) from [<c04001a0>] (ret_fast_syscall+0x0/0x4c)
>> Exception stack(0xc226bfa8 to 0xc226bff0)
>> bfa0:                   00000000 000105b4 00000003 beafe664 00000014 00000000
>> bfc0: 00000000 000105b4 000103f8 00000004 00000000 00000000 b6f9c000 beafe684
>> bfe0: 0000006c beafe648 0001056c b6eb6944
>> ---[ end trace d4b8409def9b8b1f ]---
> 
> I guess this is happening with tpm_tis_spi. Unfortunately I don't have
> anything available that would use it.
> 
> I did testing with tpm_tis but so far no success reproducing.

With tpm_tis_spi this can be reproduced constantly. I haven't tried it with tpm_tis but 
I would expect it here to happen, too. However to trigger this bug you need something 
(in my case its an iotedge daemon) that opens /dev/tpmrm and keeps it open and writes 
occasionally commands to the TPM device even after you have unloaded the tpm_tis_spi module.

In your case you could try:

1. open /dev/tpmrm with a small test program and sleep for a few seconds
2. do 'rmmod tpm_tis' from another console while the test program sleeps
3. write to the opened /dev/tpmrm in your test program after the sleep. 
The data to write should be chosen in a way that it passes the sanity checks in 
tpm_common_write (alternatively just comment these checks out and write 
some random data). As soon as tpm_try_get_ops() in tpm_common_write() is called
the bug should trigger.

> 
> Hope this feedback helps to improve. You really need to rewrite the whole
> commit message. I wonder who could try to reproduce this. With a quick
> skim I get the issue.

Thanks for the thorough review. I will try to address all of the points you
mentioned in the next patch version. 

> Also you don't have James Bottomley in the CC list of the patch who is
> the author of the original commit. Please sort that out too...

Ok, will do so.

> /Jarkko
> 

Regards,
Lino
