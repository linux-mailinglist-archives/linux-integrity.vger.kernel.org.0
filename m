Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1C2305F61
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Jan 2021 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbhA0PTM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Jan 2021 10:19:12 -0500
Received: from mail-db8eur05on2050.outbound.protection.outlook.com ([40.107.20.50]:56631
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235662AbhA0PPY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Jan 2021 10:15:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvPZxpzV5GdI7+Ry7We4kDKDZFvI4cFLJIlDlfe/hmi66cht324y5lHb09eKhWEXZL4ywDSrlIXe9LXCkAc8+3BD4QXq2taH6JnLDAAAQjtkgorqo8MCdlihQ4546off9Fjd4kA0n7I3i9ddFqc+0Q8MhinvGjrnemRByUyjv4fG/0cGlWLEFT2kz4NWPk/O250XtjS9ge/6c6DdwHGeIA+tMheql1J4ObO3GljsOJfJkeP18CyQtx1ErlALSraBwlnmwJkwYHeJFdkSF9JW1Hcm2PLtbLIkT79J+0afer5AFGAJX+kyAIgEE9T7Gf5yfmdU5ihIkoZgcTAWKZmImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFnlbcMcJmmTd0Wpxlgrkg9+r9v63ndBuX4/xp81ZsE=;
 b=X/5jB6PdjYoE0g97Y+n9lkXAw0Xy3wFoX4ubSKqBoqI01zZPOfaBYmBziIqLSCnvnrjLvmeCpLMLoyIBXEunQx87cCie2dm/eEyV4NiuFZ4ph+Yk7kalHK/dwaUg3LpzD+H2dNb0r7MVw+adurDY59u2wKDyJYDTXbTl/J8sO+OXly6mcFfDA4bLZzqx4qrJLBxjxNvpBS3o7sA8iXCopieq+HIroBW1/QT4SpN8WR/RQeqN9pclBQoIfnguX6MF4gUksBwhMrs4JZOSZo00Ctwl2eTqf4aARyKi+Bsb7lU1DBDtGdFhvFFZEdkjE0zZFoRqujFaV6sXxOM+k4Ns9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFnlbcMcJmmTd0Wpxlgrkg9+r9v63ndBuX4/xp81ZsE=;
 b=KPNytehcd4ER/JxkNXT0zY/JnQq2XuPBewIw7UieOOnh8OZQlZwmc+rAgAMB9Fwtw4wAM3o3l6yRTNMGYAd5BfHsjSDQlrSEFBEOILEGNFhlIJKymhcG8EduQrLh6gFbkEVz5ZvpvCX3mtaXO7j8QNLTftdy5J8J81uteYhfTmo=
Authentication-Results: kunbus.com; dkim=none (message not signed)
 header.d=none;kunbus.com; dmarc=none action=none header.from=kunbus.com;
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a0::11)
 by PR3P193MB0619.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 15:14:33 +0000
Received: from PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73]) by PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 ([fe80::2839:56c8:759b:73%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 15:14:33 +0000
Subject: Re: [PATCH 3/4] tpm: in tpm2_del_space check if ops pointer is still
 valid
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com
References: <1610760161-21982-1-git-send-email-LinoSanfilippo@gmx.de>
 <1610760161-21982-4-git-send-email-LinoSanfilippo@gmx.de>
 <YAR+R0c8HYsVUhZQ@kernel.org> <9bb612ef-75be-f8d4-10a6-7ab5869da18f@gmx.de>
 <a4ecfaf99f322c752d6422056d4ea94f9b3d962b.camel@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
Message-ID: <75ff3804-7fe5-4eb8-77d3-4400718b3f9d@kunbus.com>
Date:   Wed, 27 Jan 2021 16:14:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a4ecfaf99f322c752d6422056d4ea94f9b3d962b.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [87.130.101.138]
X-ClientProxiedBy: AM9P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::16) To PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:a0::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.23.16.111] (87.130.101.138) by AM9P191CA0011.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 15:14:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62441546-c17f-4545-2556-08d8c2d64095
X-MS-TrafficTypeDiagnostic: PR3P193MB0619:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3P193MB06198D6EB919ED41F9092337FABB0@PR3P193MB0619.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNI2J9FQvejY886/ZaGdIzKIGteorrTQAEjhuElh4CliJMatwsHN+OyybxYo4XOVtta0Jk+TiPMd2ysnEpkRJSWjmYsc/1o28PRkwrN4/NxuRoTxkkjEDLvPE1BIkkfmnVipbnLlwOL2Dr2APj+J1zECxcS2o93/dh3KbPeXA0KTcuMB9jTHmth8N3L2CNh+BK/AiGwb07oPwBV1/rtlfBw99DN2s0l9sowVHp1iGEDFvRDyt4doIqB1vc0tJnQMkqeAJk+Ux7K56vmB4wEXJZFeHvX3GEdshdJSa0DhWdgvXozQbRX6H/EmD2274iY/BALZyIKVUexCLYI+UuaSeMcQraqjVABC9aeFFIERgvAUq6/QAvVx0fQIia2wHhrRW98WabtE0/VbmjB0LICZByCkydLswviJZVjNv9jwo2A1811GuCs5tQSPOHK9FtprbooMDrrwit0i6EorXa7U2G1YaoWiEZdiIPfeFOgrt3e5hrTy6U0FHzlCwHDMDOKlk7LCBrHbH+8M+qTtAMx5vT5qlr4EJKdaJ4JGoIS97ha4CeI+aR24DWqViQ5PoBul/2RqXbnQpZ103H4LnwoSPLSq2nHpj/t2MkuKCB8zmYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P193MB0894.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(366004)(396003)(136003)(376002)(86362001)(316002)(4744005)(16576012)(8676002)(36756003)(66946007)(8936002)(110136005)(31696002)(66476007)(66556008)(53546011)(4326008)(2616005)(5660300002)(107886003)(31686004)(956004)(83380400001)(26005)(478600001)(52116002)(16526019)(2906002)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NHZTUHV0Uk04S0VBcnVJWE95eDg0MEVxUVNuMjUvOUVGU21ZTWhFUjVYZnkv?=
 =?utf-8?B?TzJOZnNVNlE1YVNzZzlrQkR2cjBkV041eWR4Y2lJc1A4dFU3RWhQcXNvN2R5?=
 =?utf-8?B?S0QrVXc4Si9FVE43UURTMHVNR3hPcnhuTWp2V2tPWktLdytpaDVOTno1WmRH?=
 =?utf-8?B?bTJPbHZjZ3ZKOXRxb0tsQksvckRnakZ4T0RFUThIejEwcUxFbjlvWTFCTG9M?=
 =?utf-8?B?aVkwMWpQV1FuWjZ3THE5TDBmV2x2bDdPOFJrNXZUbWJnSDBXMDRtZDhoRG5v?=
 =?utf-8?B?Z2d6Vnc0V1Q4MXRLL2xNdDBWRmtodVlROWdjZTVEaDVZelI1Tmx5dmFrN1BS?=
 =?utf-8?B?WTZhZ3V0SnROOW9rOVNjUmZHZG1Hci9YdzcvQ0RxMHBuNEJuR0w3RTNSZjIx?=
 =?utf-8?B?MGErcHFUalN4RFhXZ202WnBEcDFUS2puYnExSkFmdFNWSStUQm5VUWxMQ2tr?=
 =?utf-8?B?UzE5dnpkQWZMS3ZTOFNFdXRiNEN3bWt2VlJraGdKaVNPVis5cnkyYTdUN295?=
 =?utf-8?B?R3pjejNYSUh2UC8zRUpQMHlhbndhOTVWQ0pneWdVWUtGL0ZRYzRwVms1TUs2?=
 =?utf-8?B?aXgxdlB6ZFFySFVwelJZQkVKdFkwK0N0QmZyOTE5bzE4cjkzWm1DRVZjSyt1?=
 =?utf-8?B?R09oalByc2hGMGprd3JYL05wWjhQdG9GVmJUZnVxR2tPOWZQM3BHZUE1SHRD?=
 =?utf-8?B?UUZCSjRyUURXdnpjclh4ekJaaGc4UWtSREVPRkpkQTh4S1dYbUlHaEFqWW1W?=
 =?utf-8?B?TnI5ZS92dFZScXNDMVA5NGRyaTgxLy8vNk82UkFTMzdlWS8vcmdXemZhdndp?=
 =?utf-8?B?c2VOcGwrV3pxN09WT1RkeW9qZ0l5R01lcDRYTVhEL2dsYnpKenovOENvd0xM?=
 =?utf-8?B?bmp2Qkxaa3VYaHE4TmtXaWFRbVlVSWZFdkYyNjdkeTVVUytIdlJKMVkvQXpC?=
 =?utf-8?B?ak9sMmpnUFV3b1dUQ2JUYWFkRENwc2cxTDl1NElpTVpmNmJaNUFvRi9ROHN5?=
 =?utf-8?B?QkJ2WnZmZTZ5dSt2a2xMdU1Cc3hkOE1ZREhGRUFETGVzdDlWL1puRmxDcmVz?=
 =?utf-8?B?cTJvR3NsUzdKUXNnRk1CVmZIRFRSNHJDTjBxSkZVU2dPK3p2N01yN2J0REVU?=
 =?utf-8?B?RUhlS2JhKzRDUmNOVkxKYi9TTnNIMDRJK0hMdVh0QVoyVVRzeUJ4WEN1TS9Y?=
 =?utf-8?B?cG84TXVOTzNuQmRoZTZSUDdhQWNvZ2duNitFckNjN3lXQlZKTE52TGdpdGlv?=
 =?utf-8?B?OGZRUnY1aGlQYVc5TVc3OU00VjN3UndHNFVua29hZmExZkQ5TDFBdkpXOE1R?=
 =?utf-8?B?UHlVNXVuZHhTeTJmQ3l6eEQ2MTJLRUd2czM3b1ZaK1grYmxZSnRlRG5DSlY4?=
 =?utf-8?B?bzd0WUIwd2VJdHpyeFo2ZCtEQWFKK1ZKb2lNeG9FU0kvNU9XMjMrNjViSG8r?=
 =?utf-8?Q?p2NDz3Rl?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62441546-c17f-4545-2556-08d8c2d64095
X-MS-Exchange-CrossTenant-AuthSource: PR3P193MB0894.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 15:14:33.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAVLhlUSMeOIQnyqqTl07jepaSbJFPEE0t/NDZsgkvuJQTx/t3vB6eNs6EKRXyRwLA6PkVcXIEdwmAHO4uGazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0619
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 26.01.21 16:29, Jarkko Sakkinen wrote:
> On Sun, 2021-01-24 at 17:47 +0100, Lino Sanfilippo wrote:
>> Hi Jarkko,
>>
>> On 17.01.21 at 19:13, Jarkko Sakkinen wrote:
>>> I have hard time to believe that any of these patches are based on
>>> actual regressions.
>>>
>>> /Jarko
>>>
>> patch 1 is indeed wrong (I oversaw the action call in case of error),
>> so please ignore it.
>>
>> However patches 2 and 3 are based on bugs I encountered while working with
>> TPM. I am sorry if I did not make the issues clear enough in the patches
>> commit messages. Let me try to explain it in more detail:
>>
>> The bugs showed up after unloading the TPM chip driver module while one
>> process still had the /dev/tpmrm device open.
> Please refine the patch set, and we will look into that then.
>
> Put fixes tags and logs where appropriate. Thanks.
>
> /Jarkko

Ok, will do so.

Regards,
Lino
