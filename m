Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23C552467B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiELHH5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 03:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350757AbiELHHu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 03:07:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3D4C7BC;
        Thu, 12 May 2022 00:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1kqNGNCKpAi4xkYkaa3pjaXW4XfLK42VvZAB+0lkyMFglmgkLOlN2SkVIAsUKEsDeWqY4TZbesVJUXhKnyl4VV4cFYg3yCf6nWqbVOlYn9nudIUCGLAbZ9alMnZjhVpPQ84J3RBvCvaIa/WZm7N2IDH0oj6Utp1S3U1PEP72MV9O6W83CTrqLTsn9Cl29lhJskTCj31yVb4AlF5+X7P5Q/LjlhHn5E5/OxvaaG1DiAOOwyAZYxGOewWDYDk8DCHv0U9mt1mY8EdnncFItKwrpPl2awYtxFbWI67DJ1AI6L6yrdzCovmtF2xRj41ZAMkIHMyiS4MLvGMUx8DKasJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YZhSoZPBdEgKHQsl+m++M5RckVsJddiQphftPaoMQs=;
 b=XUaDnuQRrkYIdd7gnzB6urfzOA1ht76YZL9d7DVxB+I+edBZ5UQ7gIGXRiTDEdGZY9LzOJiZRAEXkksEAxWgGs0kvWEMMFLjkXGzMVRihCc3oFjUX+ofzWOUxXqpC6LluBzjM+aby90Z4KkGMhoDnqxKltLWZkAZv+bb4pOD0bs5Ll8VTl2roDJzWg/V1Sjh4U9+38OSczXYsjeLSN4vhE5iUhLXUbVb/LmGs+2G+JWla3SLAbnnBWpa6mXuUUgA6elD1xjMQBFCPW/nbO1XM7BlB726Rau9UBNq0uAAg+k43UW0cGFJg2pLuKxoa3TEk/1W+DNgk3uFfeQkSyiSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YZhSoZPBdEgKHQsl+m++M5RckVsJddiQphftPaoMQs=;
 b=UrNm2+xOgmtPOUjnNIchtOXB9GbDeo743h578/WESIGC/DmpQj1TIm/UQeQZmXysHLVMWE6HoQuOuCbMo7MMg/kNiq7YqOfdb4eTgymCg/WCtbLF+wAa4IbP7x4sEJ3X1t6hzrkxf4tR20uyMmsPNZVpzZxxhJt5CKlwcnOuCRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20)
 by AS8PR04MB8104.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 07:07:40 +0000
Received: from PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f]) by PAXPR04MB9517.eurprd04.prod.outlook.com
 ([fe80::ecbc:8286:8006:fb5f%6]) with mapi id 15.20.5164.025; Thu, 12 May 2022
 07:07:40 +0000
Message-ID: <c22218d5-e6d0-8bb8-f129-427c69bdb1f3@nxp.com>
Date:   Thu, 12 May 2022 10:07:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630501008F661C596C0106295C69@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5e7c0b3c9bc285f1cf9f7b20f055aa376e1688cc.camel@pengutronix.de>
 <DU2PR04MB8630A6F925454E5C007FA3EA95C89@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <232eb799dbbd341c305e911f85341409@walle.cc>
 <c3c1fbf2-c73a-02ec-d2cb-354880a84d5f@nxp.com>
 <a3b290ee4367309739948c06c11964f4@walle.cc>
 <cf88010c-e141-76cb-1acb-d768209bfc0f@nxp.com>
 <6fb4414da896cbac68332ae34eab5081@walle.cc>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <6fb4414da896cbac68332ae34eab5081@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P250CA0022.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::27) To PAXPR04MB9517.eurprd04.prod.outlook.com
 (2603:10a6:102:229::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba03253b-f766-4c19-d608-08da33e619ef
X-MS-TrafficTypeDiagnostic: AS8PR04MB8104:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8104095B6851F24D57137EE098CB9@AS8PR04MB8104.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLEafAzEj/TtwUn8r2PLWLR3KxtUhqygXT2hSac07NPZ0wok9cd5PRnX9Q7r/4rRFSeI0HGL6ONoG+Okj6DdqIiGaUxhN4Lg63hch76xzb3Y1DAljgUlBxU9jT5Kus03580KFcmggblB0X2saQWjh5vzD0nzSEB19PMkENQSRnTDW8w5BWjU1WbFxskT16sZQ+tZnfr9wc/xxbV4Eur6JYLG26xoLsawAZHs8/bgcj8sltPcwEa46M1Phn+rnnd0Mo9xhRtaIDnTHvXo5D21ONBRc9ktAj/+0jTd7P3G1zUKhIajKAqbwrJjaR1my92oLtZ9LaqoFccFXVJ2Nda0Xa90HozXF97LDPcc5DVywIq6bp4SLCE5+ieaDYXw533/HrY9DwvVJj3xmgVWznIwGvPkbrtGMayLlqwtuL284/1Cq+RJnP0SqZ4KBq9x84JJIstBCg3DpiRHwPWmR92PJfO+OgrLGNmzWA0KjJuqVB81pnnwpqD8HB5NgsgYSytot15288dVC++Fqaubuj3eAFqyxWkQ41BZ6qKXcwTDitSUFYd8qQkecul58ubisxbZK8Xu3daWBK1x3dl7bFAcbaSxEYgKSFN9ABq/CwcdP7JylAvxj0JCsSDIw0AzpDesCqnNsWsRKFsIsM+akNzw2lv9vxDSbtR2p36/gAdJH4MBQheGoOd9cDWmbZRyGCu1dO+CgVb3IbCAaq5Q+qMggy3xYiPmCS9F0HTvZ9UGlDb0X5FjXS1Tm8eAZ3/bCzMkIcWRX1/uCx6vYHGo21EQhwtginNLKUN3k66sKRlBzLLns1kvEJ1GZ/qAlcDy3ya4clA5YItufwaxjdSeBdCaZi/zLEiWoEr5AjqaWvRAmw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9517.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(86362001)(31696002)(2616005)(7416002)(8936002)(5660300002)(52116002)(4326008)(6506007)(26005)(6486002)(6666004)(966005)(6916009)(54906003)(38100700002)(66946007)(55236004)(66476007)(8676002)(66556008)(508600001)(53546011)(38350700002)(316002)(83380400001)(2906002)(36756003)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzVBUHNUYWpYcW9oTEZVOENiWmVRaEd6c2ZlcFVocURONnFXZk1NU2U3UW84?=
 =?utf-8?B?QTl0UGF5N0xrVjJiVWdmQUVOVC8rVS9FUmc0TUFEMnlKQ2pWRkF1aVc5ZFlu?=
 =?utf-8?B?ZThWdTducFVBSlhTaDZxM3NDWjVXOTY1ckoycXhrSVhleUhkaERpWHorZm9V?=
 =?utf-8?B?eUh6NjBaNm1LNCtRcmV4OVV4MUVMb1hHeEhuWXBaYUtuSVdlVW9xUFFzcC9n?=
 =?utf-8?B?UkNwUUVDRHFjNDBpT1NlVGxlQ3BCUXFuYUs5eUVYT0xvM3FYUGlsN1YxN3ll?=
 =?utf-8?B?V3pjRjRid1YyS2J6ckxmWUpYQkt0LzVpOFpxSnlYNXlNeExhVlVWTUtyRkU1?=
 =?utf-8?B?OXQzbk90cVcrTXV2Qlc3S0t1MUhZNVp1cDBwbTVWMnI5NGkyQVlxNkFHOGll?=
 =?utf-8?B?Z1k0Q2VqYUpvTHdNdERwaDlETEtmS2ZvSDJmWjJNallIRkcxNTdNVHBjYmU0?=
 =?utf-8?B?L1AxOFZ1SUdtWTFSZm5tZVQxUlh1Y1c0MEo4L0dpSno0TkNoZFhML0Z2YTBZ?=
 =?utf-8?B?SjFVaUF0Ym1RL3UwcDcwdzl4RFAvWE1PQ2hIUlhzOUsrSkFjQUhVWWpOdFRT?=
 =?utf-8?B?cnhrRmN6L1hMaVhKQTQ3Mi9Tb0hjVGtjWnhpTHV6eE1jK1BHZTZBZmF5UDFZ?=
 =?utf-8?B?VWVnZHBsV0VJVzQ5b2YrSWY5L05FTlZMbm5ybU02Umxmb0s3U3h0eit2M1Vj?=
 =?utf-8?B?L0p0OERKL2VxTmxPN2JRZEt1UTFHVU13T2JOcWhuaWtqZXlGM0hPUWRJbTFX?=
 =?utf-8?B?RXFleWlQUEdrOWE1TndwQUtWamUxMTFTM2tQS2M4ZXJGbWRiRjllY2U2M3pM?=
 =?utf-8?B?K1JnTGp4ZGtLWXhubnJaUHBxQlhpQjNjTXEzTDBuM0NUV1U4eHFINzR5K2ZI?=
 =?utf-8?B?WjNUMlFWOTZuK3Z2NFlsRC9kNDhoWDRBdVA3aGVKcSt6T2plZjF4R3dFYzd0?=
 =?utf-8?B?YW1ZNmNBdnZnVHF3Sk1VTFpHd2c2YktBQzRBcTdxWWFJUHFSSURNS05YWWdu?=
 =?utf-8?B?RVlWRVU1Rk8rbnkzY3lITDVXVjFwSko2S1BWZ0pxLzV4QTRiOU1PeVdid0Fl?=
 =?utf-8?B?S2plQ0NrYUlaWDBlQ0VlSW5ScXZZTm5RSWRPelVTaVRKK3U5MUZKMXhKZ29p?=
 =?utf-8?B?Y2R3U3UxUGlBWW0wZzgxV0hjdkVmWGwwTnNRSnllQ0pQRlU0T3JocStyK3Vs?=
 =?utf-8?B?eG9tcVltRWc2c3ZDeWRERCtiRWxWdEVEMStaSGgrc0VkM28xK3huclB3ZlR0?=
 =?utf-8?B?OWhoY05MYm1BSUZvSWxRaHI4eGtVcDhheVp5THhoTW9BLzRCYk5odk9CQURv?=
 =?utf-8?B?K1FkTlhPRkNuYytZdHk1KzhHYldHZHBack8rRjRpSWV4VlFjZ1NYVHlrMWJ6?=
 =?utf-8?B?WTM4V2tTb3lqaFl0UEJWSEtOczk1QVp3RktPSURhS0IxRUFJRksyQUdjNTRi?=
 =?utf-8?B?QUcxSzZaYmhyeXB2VjM0QW5pQXlNTDRZYzd2T3NlTjlQSHVicmZ5RE1PaitJ?=
 =?utf-8?B?Z2J5dXRFMXZjeFJBOTNFdWU1YVVMelZ0NFROcitFc0pXaWpSU0dtWWtudjlG?=
 =?utf-8?B?RWZ6RFRYYUgyWGtTenpJQm5GWXNJZU9BaTJCcFQrSVVMUHZKckJUZW1BUUhG?=
 =?utf-8?B?VlZCZnVhY0N2RUVBc1g4N2pucUQydzMxNHdEc2FGYTR1NkErbE92aUs0S3I5?=
 =?utf-8?B?cjRsRzBrNGNOTlFQOEZFYStQU3kxWU5kK1NueHZrL05xUUtwY0hPK2Y1eDlT?=
 =?utf-8?B?dU5QV2d1TEpHM1Q0TFVDY1pOUUpiSW1keHRZMWE5RU15azgweDhscmtoNzI4?=
 =?utf-8?B?bkZ4blVCQWN3c1BNYk9WV0VxZjlIWDhFSk9GdHltMzlidTBLbjdsc0JPbks1?=
 =?utf-8?B?Mjh0dEFXMm92T3dUL1V5c0VlQ242cnlWek9jTnNuMVdzbFlzVFdIZ3hGZlBi?=
 =?utf-8?B?MlB0dWFUaUFLeTNUZ1VxOTRJWDVSbEw4czRsc043Vk5lSytqendTL29KR2lV?=
 =?utf-8?B?ZytmNStWVEVpYTRYdlc2eENidXFQVk43YS9ENStFQk5jQVZSdHJLSmtXcDlS?=
 =?utf-8?B?a0hyR29Ra1dFM252UXpOcjhNcHN0ejZzbGxHU01rdlg5blZLSzgxSXljYlky?=
 =?utf-8?B?cW8zajc1RjJpOUJabktYV1RKL25mWDBzZUFhS1FmWGdGZWVwUXdJL2ZFMzk4?=
 =?utf-8?B?RGQxbnNGNFJrNm5kQXBBVFpqelNrbEY1V1d6dGhENERIRm9qY2JMbUxtOGZ2?=
 =?utf-8?B?SDR5MGtLZS81c1VTQk9oSm13dkU4MHQ0RkRIRU50TWlTTXhWT3gzVHJTMWY5?=
 =?utf-8?B?UDhOMytxZzh0cVBBK1hJckpUUkp5VzFNcGxGTkRNZ3BpYzRLcDhzSWJNelBk?=
 =?utf-8?Q?qX3Yj7OPJXjf/xrw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba03253b-f766-4c19-d608-08da33e619ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9517.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 07:07:40.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P36KS4aR7MiUeknB9GIqGz0QEaOall9KD9I/LfrLDVeX02CFLJbQwe1jz+TgdCqDsLVvbQjlaNKOBUouVzpJXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8104
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/11/2022 2:54 PM, Michael Walle wrote:
> Am 2022-05-11 12:28, schrieb Horia Geantă:
> 
>>>>>> For non-E variants, it might happen that Blob protocol is enabled,
>>>>>> but
>>>>>> number of AES CHA are zero.
>>>>>> If the output of below expression is > 0, then only blob_present
>>>>>> should be marked present or true.
>>>>>> For era > 10, you handled. But for era < 10, please add the below
>>>>>> code.
>>>>>
>>>>> Are there any CAAMs which can be just enabled partially for era < 
>>>>> 10?
>>>>> I didn't found anything. To me it looks like the non-export 
>>>>> controlled
>>>>> CAAM is only available for era >= 10. For era < 10, the CAAM is 
>>>>> either
>>>>> fully featured there or it is not available at all and thus the node
>>>>> is removed in the bootloader (at least that is the case for
>>>>> layerscape).
>>>>>
>>>> Qouting from our previous discussion in U-boot:
>>>> https://patchwork.ozlabs.org/project/uboot/patch/20200602150904.1997-1-michael@walle.cc/#2457448
>>>>
>>>> "
>>>> Based on previous (NXP-internal) discussions, non-E crypto module is:
>>>> -fully disabled on: LS1021A (ARMv7), LS1043A, LS1088A, LS2088A
>>>> (and their personalities)
>>>> -partially [*] disabled on: LS1012A, LS1028A, LS1046A, LX2160A
>>>> (and their personalities)
>>>> "
>>>>
>>>> From the partially disabled list, LS1028A and LX2160A have CAAM Era 
>>>> 10,
>>>> while LS1012A and LS1046A integrate CAAM Era 8.
>>>
>>> Thanks for clarification. Do you know it that is a layerscape feature?
>>> I had a look at the imx8mn which have a era 9 and it doesn't have the
>>> PKHA_VERSION register which indicates the partially disabled PKHA
>>> block. Thus I concluded that there is no partially disabled feature
>>> on era < 10.
>>>
>> Unfortunately when moving from Era 9 to Era 10, the register map
>> is not 100% backwards-compatible.
>> This is why you're not seeing PKHA_VERSION register for i.MX8MN.
>>
>> For Era >= 10, the CHA version and CHA number fields are conveniently 
>> found
>> found in the same *_VERSION register, e.g. PKHA_VID and PKHA_NUM are 
>> both
>> located in PKHA_VERSION.
>>
>> For Era < 10, these fields are scattered:
>> CHAVID_LS[PKVID]
>> CHANUM_LS[PKNUM]
> 
> Ok, but there is only the number of instances. I couldn't find a
> similar bit to the PKHA_VERSION[PKHA_MISC[7]] bit, which indicates
> PKHA decryption/encryption capability is disabled. That seems to
> be only for era >= 10, right? That was what caused my confusion,
Yes, there's no corresponding information for PKHA_MISC on CAAM versions
earlier than Era 10.
Only starting with Era 10 PKHA can be _partially_ disabled on non-E CAAM.

> because until now I was under the impression that non-E variants
> will always have that bit.
> 
> Rereading your comment, you don't mention PKHA at all. So for
> era <10 if you blow the EXPORT_CONTROL fuse, you'll have zero
> in any *NUM except for MDNUM, RNGNUM and CRCNUM. Is that correct?
> 
Partially true.
For some SoCs, CAAM does not support CRCA at all, irrespective of the state
of the fuse.

> In that case, I agree, we should also check CHANUM_LS[AESNUM] for
> era < 10.
> 
Btw, newer manuals have the subsection
"SEC/ CAAM implementation" -> "SEC/CAAM Versions with Encryption Disabled"
which details what happens in case encryption is disabled.

Horia
