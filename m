Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5A5540073
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jun 2022 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244936AbiFGNuS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jun 2022 09:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244926AbiFGNuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jun 2022 09:50:17 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (mail-lo2gbr01on2118.outbound.protection.outlook.com [40.107.10.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E49ABC6EB;
        Tue,  7 Jun 2022 06:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9GZ4xc76LkEtKkruQQs4YskrmHms4Aeux3YdBndxazpeg8qEiGIRY79rH7ZGFmHm5cUgmFrJyUag8M2zMbHP7JLmkzClCJBFlERojvAOub56bPs19GxB3Z2haI4D+UAULFnvrduDkuijOg8fxR7KQaM74L69pxaYEHlZYQ4L+jgQLAs42Sbe5bLTEYypDFiZAZZvfKMY4gaBqo5YJzkgtxFLX2Mc/ILL8XdOJjSXFtd4wQxKaAAucjpFq7Z2fgu4OcjxLeS2jGAeXvlg5ZKnSVtd0bjn3GJK4Q6FiQ3LDLcLNIRXzM2r6YxYuIHPd0ovlqX33xgMcYNzfxzIdFEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRm0chFEuTifBw0yBxF4rCn/wtmJkuMOP61beyX++74=;
 b=JieRUQxraFa8Guf1QmJsB7KBzSNu88kscAqHH7mccT4WWtD55lv5Ywm0p0Ua9zOjLFDJvuXMRdzEn8Wa8tvzcXvF1Q6Q0guuMUiAOOB6BUaCq+nD2GuaVWqmbM9p9TGbOKBuNYSP9cxT1QfGSijmkyl/EozQ7n69x0RqEneiTWJzUfQnZCORgOTW36FqNTsJT1vYQerMLHJdV5jzqQJLrGTkbUggH0lTeVB3m796sTtbPGUqd5g7SuzIzRjOvZ+cbfAy9+kKTua1iRxdPvsU1eM6gznCNPt4YmYVRSUCRoiL6H980kNNgdMtodKx3F3nYM5EqdzVkj9TOPDFd6JB3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sancloud.com; dmarc=pass action=none header.from=sancloud.com;
 dkim=pass header.d=sancloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sancloud.onmicrosoft.com; s=selector2-sancloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRm0chFEuTifBw0yBxF4rCn/wtmJkuMOP61beyX++74=;
 b=KcIT+lL4mEvsU6hZp1GnPgQ52ptqWYhu8WHmBsXFzf3rvXXPXr5pQkR2Q5yV2rZqnkiyEh9IGCYNXUJwxyH4WyqcfWzRjP8AY82L99QMYFUm0fd7M/AkqUbbaXvX34NuecV0QscUZVOrMarBD10YGb2WAAGyQCVS89PFMV6RiT4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sancloud.com;
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:61::19)
 by LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 13:50:10 +0000
Received: from CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6514:8bae:5874:5bc9]) by CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 ([fe80::6514:8bae:5874:5bc9%4]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 13:50:10 +0000
Message-ID: <0fc9040b-4e4a-e907-8940-d9470aec92a8@sancloud.com>
Date:   Tue, 7 Jun 2022 14:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From:   Paul Barker <paul.barker@sancloud.com>
To:     Michael Walle <michael@walle.cc>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Stuart Rubin <stuart.rubin@trustiphi.com>
References: <416958ee-c2df-0981-8c77-298561d09381@sancloud.com>
 <418e465f5156adb340976bac209539f8@walle.cc>
 <821b7140-abb0-17d2-4aab-07247a250e9c@sancloud.com>
 <9b85e0336f11fc6d4aa66f991ce9b9a9@walle.cc>
Subject: Re: Sending vendor specific commands to spi-nor flash
In-Reply-To: <9b85e0336f11fc6d4aa66f991ce9b9a9@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:61::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa705400-237e-404d-cfb8-08da488ca3b3
X-MS-TrafficTypeDiagnostic: LOYP123MB2701:EE_
X-Microsoft-Antispam-PRVS: <LOYP123MB2701491C0637C2AFAF335E8993A59@LOYP123MB2701.GBRP123.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blw4F/I+DHKqBzeby/CKISQfbFedopMhfsmlUvwK7kTSLBknvg6sYKt8hdEepu8N08X80cUOIelSZntOhw4DB98GoZQl8Rq0OJ/HtbAvNtM4O0cANyZ8zUBsMticl5Bd+lUA+p84rtbBQ542obWV9QNgqcid3XIs7GZ9SPFpN2lKtzu2fpatd30nWudI9ikfjh6SPwd9ZGuHdT7t1SxpBTtfWrSvh5vGw1err3VfvMJwxOB2dHqAmduFAXNj8haEpALCCF/ejSjBDZdXnipbGAcUeZCvvT4nsZqY7u0+Hvnm4rqLJIDwuhGT7zAuEcj7hSsiC9uYF26mQl21tDp+aeGxMr5WKOTiYx+SDfTiZB46fg5SKIzqNXPTI/92pR7SG+90SSLanTJr8dpymvDB00K6LNiyjqkFQedgywxTFfXeoixXbgUpHa/BaNxidAkCqZae2lw4Epb0x8ebc4x63w2XfxA+6zNSseLatNiDHoX6D7sGqTljO6WxekDBn4lwPUQEcDxdRabKBEE2EuVJvnqWyqOKoY1ob3xMVrF5mvWcK+XvYZUX0p92PZrkgsTAt3sd9MyxFH/zF5jSWZUjbwAYl43z5CeIkhJMCtllNiYD1Ua453Kb3d8hugF2Q/Vp/Mxq7SM/hRKagz5T+tnDm/XpmN9vkmpF4gaz4epuMI4tUiverBAQGeLCemMj3X7SL8oWGugc9anF8h4Ga8IdsUq76IoI1cNQM9Ywl5kYPV8fDgAekc0OLMrX0NpjxDH5tN/DgCObX/ChGm721JZUQVr7Z7j/k3K+q963y68Ss7JQO1NHNJmfZG2h0FfooSgiFVFnMdDXRjfaPShe91rZjzYUvzVWNdL2X4Aao6LtOr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(396003)(39830400003)(366004)(376002)(5660300002)(53546011)(6506007)(31696002)(2906002)(36756003)(44832011)(38350700002)(38100700002)(966005)(52116002)(6486002)(4326008)(86362001)(8676002)(508600001)(7416002)(2616005)(41300700001)(8936002)(186003)(66556008)(66946007)(83380400001)(31686004)(66476007)(6512007)(54906003)(316002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG5jL21ZY2NaeGh4Z3J5QXFJUVJtYkFpOEJRRFRFUXZFVGpiM041cG1nQ2Fv?=
 =?utf-8?B?RmYxRkR5eGU5WVRVb1lPMDdGYTN2WGpXazIydCtLaDlOOFM3WFc4OHJNV0cw?=
 =?utf-8?B?eFlIbXZKSUNwNXB4VzBVRlNkUHZkMnY2bzllNlVFUmY2NGEwaVIrUmJOR3NL?=
 =?utf-8?B?d1lKWnRROXB6Q2VNWmh6dmxJL0laaCtSaVJLeE40Q1A2dGprQWZTQmhxK1ZV?=
 =?utf-8?B?WDk4cVd2cmJWdGhNR2xVaWNaSGpjY21YNDU1S0lORWVLL2RCVGE0aGhBRHkw?=
 =?utf-8?B?Qks1WjR5OWRPbml0cEovMkZpdk5EQyt5Q3owU05wV3B0VEtZdlFGYTR2ZlJH?=
 =?utf-8?B?WVdJUFpSMFF3cjlUcm5xUHY4WkFrTmRZdHpZOWhhTTA4SnNuL1U3VlJMZDQx?=
 =?utf-8?B?dWxtM0xjNkRPdndKdFlNSXcyYlVISi9MY2MyS1Q5bnUwOEIvbk1CRW80aThJ?=
 =?utf-8?B?aUFRQ21oMTA5QkszS3Y3T0MxMXpnS1NGbmVldEUrNnlPMU5nWG5ubmsyS1hw?=
 =?utf-8?B?TVc1b1hCeE4rL3FSejIranBtdEhPMWR1SjNLWXVTZkR1ZUg5bTJjY3I1bTV2?=
 =?utf-8?B?a1IyandPMTdxQis5cFE5cm1OZmVXcDBDMmtDbWxoZk9jdjMzNjlJMkdUSmZy?=
 =?utf-8?B?MlVUUVIzZVY5ZXBYbFZ6REJTNHZ6YmJIZlREaXVpQTdRQ1c3d0gxMkNIcnNB?=
 =?utf-8?B?STVzZll4SHdESmo2aWMrYkZPS0RmUVJsNWVEWFU3YTlrSFNSWkU3WkhxN0dG?=
 =?utf-8?B?b1pRdmNWQW1jRkxJSndKTFQrSFN4aXJoQ0UzdDRITVBzQUxtajYwd2RIMk9P?=
 =?utf-8?B?WWg0UTE2N0ZTUjdXZWtGejUyQ0tqd09mMzRoQUtwQUhyWjVrZWVrTTYxYzN5?=
 =?utf-8?B?aHFzbjRoVnBhd2xXOFpTdUozZDByR3VCQUVLNXZVVUpBR3g0NkFZODcwZm9I?=
 =?utf-8?B?amlvWUpnSThyblR3NWNJTS9VWk1UNndaRlVjdS9hU09XaHBCdVlmb0hEcmx1?=
 =?utf-8?B?dDFSZnNDSXAwYjRkbEpQTGUvbGwvUUxhRXkvbWovRkk4V0JDMkYrL3ZBTi8x?=
 =?utf-8?B?YUR0ZGdiYlphU09qR1JmWE1PZmZFNzlIbG83UzRRNnRhakt3QUptTzFLVTBM?=
 =?utf-8?B?aXNhRWFoNDZCZmRNaER1MGJWTnJOL0t1L2JZbDh0VzBrWm9lK0FsR0ZVbUlr?=
 =?utf-8?B?V0wwQll2RTg5OW10NjV3S2xYRXN5bFJUWWpwekNZMlZsZjU1ck5VNWc2UDha?=
 =?utf-8?B?NlMzWXhEL0x1bEhNTFo3MXFBaFcxaE1laHV0ODkxRGUvOU92dGw2WkthWmpC?=
 =?utf-8?B?Vmg1M3dWTWFiNEYwUmdDUGRwWkE0UmliQ2dEL0JtcEsrRU5tV0psMk53TThQ?=
 =?utf-8?B?VjZRaXBYY3lQUmh4SzBZdElDdVMyaGU2b0ZEUUV3UTE0Ym4yZjZkNG43a1lK?=
 =?utf-8?B?dXduMWl3RmFjVnBJSllvVmxrSnVoVzY0MnNtVzY1TDNJZXp2cEpCRGtRbC9Y?=
 =?utf-8?B?RlVnajU0UGZubzVUSE5WTVJRd3F1RDFnYnpTZnJCL0hmazJDV2JUT1NpTk15?=
 =?utf-8?B?aGI3eXg5aFlOM1JDK1FMdlIxbFNaMzZVNW5LSlNDMG9hZ0tNTjYxdDRnekk1?=
 =?utf-8?B?Y1NzWkJOd2J4UFl0cUZHZVRVQzRoOUk2a00rbklRcjdCNzg1dm9EL244amxM?=
 =?utf-8?B?Nk13aDFzYzNZc0hKNlBuaWhsVkFoekVXU2Z5emZhNFR0QTFSdExseWtRYWNE?=
 =?utf-8?B?T0R6bUlSZTViNjNZdzMyR0cvdDFQU1pkeGNXOGw0bU9WY3g5ZGo5UzJjaGxu?=
 =?utf-8?B?a2xsYndONXhDSXE2V29CZUppVFFKV291Q0NZUnRiWWc4dUZpQmg2czVIMWdB?=
 =?utf-8?B?a1lubjBLU01GSEM5alNDWStjWDdzcGhNbDBWM0ZmanJKWUYyczUzRGZ1NU5n?=
 =?utf-8?B?K1BST01vMGhna2JBanJrbHc4TVNyUkwrcFpQM25qSDRYWW9mcUpLTSs4UXB5?=
 =?utf-8?B?M0lvVVhGdmNzYmdxUStRaXc5aHJuamtpZ1FoMnZOR0UvUHZaZTBQMDVFYUcz?=
 =?utf-8?B?MjZvbVUvZWtHMWdvNjJIdXhBaDI2VFlvRFVoZWx2Y0JWQVBRd2EyVHEyVGk1?=
 =?utf-8?B?MHhCK1dJTlo5c3VEcWYrdDJqaENmaXcwdHJzb2tGMFhnc1JXQjNBRldXME92?=
 =?utf-8?B?OXNiMFVJNTg1OG9aK2NFVkR1WVZiL0l1cUN5OFkyclFhaWl6b2lUSEJLSVlj?=
 =?utf-8?B?a2UrUUpnSy9XOGErTlR3N1JOWXNmSWwwQmc0QUloZ3h4ckRsRVdPY2x0R1VU?=
 =?utf-8?B?bjBzc2dNWENuRUlCSXFtL011aVdXU1hBbGtvYlJUNDh0S29yZkpoUT09?=
X-OriginatorOrg: sancloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa705400-237e-404d-cfb8-08da488ca3b3
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB2241.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 13:50:10.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 840be37c-244a-450e-9bcc-2064862de1f4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjMUNb8imGoUWIrPT6H2x5NN/5pTa/GaSk646nD/FOkqJPRvlhinMqCA5u9wBQkLfHZ/ZkzMGJVaMpNdG/TtOby/ZV8Dk6h1wJ3/GFZlEq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2701
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Michael, folks,

Apologies for the slow follow-up, I was ill over the last week of May & 
start of June.

On 23/05/2022 12:25, Michael Walle wrote:
> [+ linux-security-module, linux-integrity, sorry if these are the
> wrong MLs, but I don't have any experiences with crypto]
> 
> Am 2022-05-23 12:02, schrieb Paul Barker:
>> On 23/05/2022 09:31, Michael Walle wrote:
>>> Am 2022-05-18 14:32, schrieb Paul Barker:
>>>> We're looking to add support for sending vendor specific commands to
>>>> Micron Authenta flash devices over the SPI bus.
>>>
>>> Please elaborate a bit more on the use case. Is this something specific
>>> to the flash or is it more of a general feature?
>>
>> The Authenta flash devices support two groups of vendor-specific 
>> commands:
>>
>> 1) "Advanced Sector Protection" commands, common to several Micron
>> parts. These include volatile & non-volatile lock bits, password
>> protection and a global freeze bit.
> 
> Parts of that isn't really specific to Micron, is it? Sounds like
> a per sector locking. AFAIR Tudor was working on advanced sector
> protection.

I see your point here. The implementation may be Micron specific but 
there are probably ways to improve the generic locking APIs to cover 
these features.

I'm happy to look at what Tudor was working on, have any patches been 
posted for this? I've searched the mailing list history for the past few 
months but can't find any.

> 
>> 2) "Authenticated Core Root of Trust for Measurement (A-CRTM)"
>> commands, specific to Authenta flash devices. These include
>> authenticated write operations where the data to be written must be
>> signed with a cryptographic key and measurement operations which allow
>> remote attestation of the contents of the flash. These features
>> interact with the cloud-based Authenta Key Management Service (KMS)
>> provided by Micron and user-controlled cryptographic keys can also be
>> supported for these devices.
>>
>> To make use of these features vendor-specific commands are sent to the
>> flash device. We expect to send these commands during the boot process
>> and during the process of securely deploying a new software image to
>> the flash device.
>>
>> Brief information on the Authenta features is available as a PDF [1].
>>
>> [1]:
>> https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/mt25q_a_crtm_rpmc_addendum_rev_1_6_brief.pdf 
>>
>>
>>
>>>
>>>> Since we're using the
>>>> MTD block interface to support a filesystem on the SPI flash we need
>>>> to send these vendor specific commands via some sort of IOCTL.
>>>>
>>>> I can see a couple of ways to achieve this (as follows) and would like
>>>> to get some feedback from the MTD & spi-nor maintainers on which
>>>> approach is preferred:
>>>>
>>>> 1) Add new IOCTLs to the mtdchar device to support these vendor
>>>> specific operations. An initial set of patches was sent back in
>>>> October 2021 which took this route [1], but no further progress was
>>>> made. The new IOCTLs would exist for all mtdchar devices (regardless
>>>> of vendor) if we go this route and we'd need to ensure -EINVAL or
>>>> -ENOTSUPP is returned as appropriate if these IOCTLs are called on a
>>>> device which does not implement them.
>>>>
>>>> 2) Add a vendor-specific IOCTL layer to the mtdchar device interface.
>>>> When the mtdchar IOCTL handler is called with a command not defined in
>>>> mtdchar.c, pass the call on to a device-specific IOCTL handler which
>>>> can potentially handle vendor specific commands.
>>>>
>>>> 3) Add a generic SPI transfer IOCTL for spi-nor MTD devices. This
>>>> would avoid the need to define IOCTLs for every vendor specific
>>>> command supported by SPI flash devices. Instead, knowledge of the
>>>> vendor specific commands would be kept in userspace and the kernel
>>>> would simply provide an API for sending & receiving arbitrary bytes
>>>> over the SPI bus. This is similar to the MMC_IOC_CMD IOCTL supported
>>>> by the MMC driver.
>>>>
>>>> My preference would be for option (3) since it minimizes the scope of
>>>> the changes we need to make in the kernel. We're not tied to this
>>>> though, so let us know if a different option is preferred.
>>>
>>> I'm not sure we should allow a generic "issue anything to the spi
>>> flash". It it is just a one time thing, like for example, program
>>> a password during production, or program non-volatile memory during
>>> production of the board, I'm fine with it. Most probably, calling
>>> that ioctl will also call add_taint(). This will also need to go
>>> with proper userspace util support.
>>>
>>> But if it is something for general use, please provide a proper API
>>> and don't write userspace drivers.
>>
>> I've been looking at how the eMMC/SD and NVMe drivers support passing
>> through vendor specific commands using MMC_IOC_CMD for eMMC/SD and
>> NVME_IOCTL_ADMIN_CMD/NVME_IOCTL_IO_CMD for NVMe. Neither of these
>> ioctl handlers appear to call add_taint().
> 
> I don't know the use case for MMC/NVMe, but until you convince me
> otherwise, I see "sending raw commands to the SPI flash" as something
> exceptional, and thus you'd taint the kernel.

Looking at https://docs.kernel.org/admin-guide/tainted-kernels.html, I 
can't see any taint flag (tainted state bit) that would apply for the 
case when raw commands are sent to a hardware device. I may be 
misunderstanding something though - which tainted state bit would be set 
by this operation?

> 
>> For A-CRTM operations, in our current use case the command bytes to be
>> sent over the SPI bus to the flash device are sent from a cloud-based
>> service to a userspace agent on the device. The agent simply needs a
>> way to pass these command bytes over the SPI bus to the device and
>> retrieve the sequence of response bytes to send back to the
>> cloud-based service. For this we could use either a generic SPI
>> transfer IOCTL or a Micron specific A-CRTM command IOCTL.
>>
>> For the Advanced Sector Protection commands we can add IOCTLs for each
>> command if that's the preferred approach. The command list can be seen
>> on page 35 of the datasheet for the MT25QL02GCBB spi-nor flash device
>> [2] and on other Micron flash device datasheets.
> 
> This doesn't sound like a proper abstraction to me. Again, the per
> sector lock protection should be integrated into the current locking
> ioctls. Regarding the security commands, I'm afraid I can't help
> you on that point, but it sounds like bypassing the kernel is the
> wrong thing to do.

For the Advanced Sector Protection commands I can look into extending 
the existing IOCTLs if that's the preferred approach.

For the A-CRTM operations, these don't fit well into the existing APIs. 
Furthermore, for several of these operations the bytes sent over the SPI 
bus consist of a message block (including an opcode/sub-opcode and any 
arguments) followed by a HMAC signature of the message block. The 
signing key for this HMAC is typically kept off the device itself (e.g. 
in an on-site server or a cloud-based Key Management System). This means 
that the sequence of bytes to be sent over the SPI bus is typically 
produced by a system which has access to the signing key and is then 
sent to the target device to be relayed over the SPI bus to the Authenta 
flash device. The kernel running on a system with an Authenta flash 
device is typically not in a position to construct and sign the sequence 
of bytes to be sent over the SPI bus for A-CRTM commands.

So, I think the best API for A-CRTM operations would be a pair of 
vendor-specific IOCTLs, WR_CRTM_CMD and RD_CRTM_CMD, which each take an 
array of bytes, including any HMAC signature, to be sent over the SPI 
bus to the Authenta flash device. These would check the 
opcode/sub-opcode to ensure that they represent a valid A-CRTM command 
and for RD_CRTM_CMD to also check that this is an A-CRTM command that 
does not modify the device state or flash contents. Thus WR_CRTM_CMD 
requires the device to be opened for writing, RD_CRTM_CMD only requires 
the device to be opened for reading. Once the opcode/sub-opcode has been 
checked the command would be sent to the Authenta flash device and the 
response sent back to userspace.

Thanks,

-- 
Paul Barker
Principal Software Engineer
SanCloud Ltd

e: paul.barker@sancloud.com
w: https://sancloud.com/
