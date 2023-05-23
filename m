Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE370DABC
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjEWKlc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 06:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbjEWKla (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 06:41:30 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0772DFE;
        Tue, 23 May 2023 03:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq+PeVxiDECPxIReYO6gWPplKnlzxPJ3o9KP1AYsbHBYLutOzkdMTVUs99VdrijNctQ2OtYYI1ZSMHLZwtjA0kcvcfKaXHJh4/Pv/ie7aR5IwCr0I4ZhO+IV76lS/L5eG1i+l7jZPmDVoJM58lDRbajDZ7IOJH+aYqh8BYf1bbvGmtDoqsC6bHAYLb+7PjEw5PxIjA+zh9qWq6kO6BA3onK9Kj2VIEbmkHWBtGww5Xi5v9kO1sJTvAM690jmY75L+o+ImCffUS2rcThg+f2CKZQ4/Q30UmqGEUtZgQRfsoR++xkuLmz56rNe8cgoiDvApDd5TEGHzkxaL/BefUcmQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axwN53VPRj6j6STVG7ERvow1taDJ5u8qTdK/gKJOaj8=;
 b=ksb4bY+Lt0Wb0zYYQs2FCo976v9PqClifAkiNtr4U+mBUfTqZtGqXLFN9SNoD29axXZtJIcZ0byYY4zo5mUNTHzLa4mcgcAnDF6jAG2A0Ktt1ia5FvSMdzvqDaYKvgvb8F077GpbmUaBVtcrBjR13JmmEneotrCS0v986VErH48sPgEArnlhs4uMn5dv+T+ByY+3iRWmUW5K0Tgc6AITC20+eDGxjaPwsUlztDASdMnOaACS+pnDpYu+/8mrbturJAiscEBjBX68jkwBd99twENgMP4ook/AtktV/oJCel8xrplsLX92jy576pM7dRtojX6zkpQaPKxNpIqXkJIg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axwN53VPRj6j6STVG7ERvow1taDJ5u8qTdK/gKJOaj8=;
 b=ZSihbQ5KmCXrY1o2Ubp4+/67Ytj1kz916dgljHFNLyGJR4l6deBye9IA5vPYPKJmRvhZHWyMefuA5WR9kjvBCdEe99QXy+xzGd7UfJ/mXlyrH8Du7YEZJYpndYpNecRzFSEqwRLxzOcDTNv+ZUP24O1CZAH8hCLz0mYSqO2xoys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB1007.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 10:41:25 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::6727:e3fb:8fec:72a6%7]) with mapi id 15.20.6433.013; Tue, 23 May 2023
 10:41:25 +0000
Message-ID: <984d3ec6-fe30-d662-5cee-9eb4323c305e@kunbus.com>
Date:   Tue, 23 May 2023 12:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
Content-Language: en-US
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, jsnitsel@redhat.com,
        hdegoede@redhat.com, oe-lkp@lists.linux.dev, lkp@intel.com,
        peterz@infradead.org, linux@mniewoehner.de,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.rosenberger@kunbus.com
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
 <20230523074443.GA21236@wunner.de>
 <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <98f7dc1a-6bed-a66f-650e-10caeb7d0bca@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::6) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB1007:EE_
X-MS-Office365-Filtering-Correlation-Id: d23163f9-425b-4a56-7a28-08db5b7a41f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/PsFjUgUiIfvHBJE5wew/WfxJJJ+dt75kFj7a1W2xBRicOcBHmuLMIOoZztTfge6YQlMHaplV/0eMZTnU+CRKqLpNhHk6crR8ervN+YRKaBj1LIvGVqp0Q/Rv8D1gGie2omQobpe+qjf4nCaOidgLkiKbHUzp8FfOlI3zRsm+P/pYrJHhctayoEWDH5TrH6KuLCAKBVR0je3vRMIUKrjhQx1PLPQ40z3giL8KgamIOwer09PnmkgjvcVJv4hJGNN8N3CcfThUIIJuMlu866ebXCZueo7ArS//5AqRsEcwCpVlNq4PfUUpBJzYvZwweYDIz5aRBQE4AoVZazkv25rIbgUmeQNem1Nbw+eiibu7RiVVKpUylgofGIZsT5pZUgaeoOHu1K/H7V6RE6imJielIoMY4a5uUed/XCtEkPxBw6Lqqu3CmQeKnD8d45E/Fc5Uq/m58//ckczgZEIr5Xo8YUNKvHUNPlSj7QeizB96lNI7kdl8vQgh+DjThYkYqCyrSyqVmksbAaU1nXJaDFhAwE9gXzC2wmAvNOTR+KoRE7B26jKmvCShnXEi+iPSFoVauctQeHfyTN8Z4gZE3gj2das9srP8Bkd2mH1jDXE9Nu1XI8DzdHNt29TvFjvCPwP+lNyqJn+bzE/YPPJt1Ldg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(136003)(346002)(39840400004)(451199021)(66574015)(53546011)(6512007)(38100700002)(7416002)(36756003)(6506007)(107886003)(2616005)(186003)(2906002)(4744005)(478600001)(316002)(66556008)(66946007)(4326008)(66476007)(52116002)(6486002)(86362001)(41300700001)(5660300002)(31686004)(31696002)(8676002)(8936002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3g1MmVMUHRaMDd4a1hiMXQwU1BOUFFyOUZ1amRnQzUrVGFlNVhqSCs3cDFu?=
 =?utf-8?B?SlNHQlF5VE9iMy9pSWZiblMrNFoxK1hGTW5aRUR4OW8yVGhYOG9jRU9iN0c2?=
 =?utf-8?B?cUZZeEJteUd0cXN1L1Q0TnlIQ0Y4MTBZQjd0VnZsTnc2QlAzd2JaMTcxM2to?=
 =?utf-8?B?Wk1kSy9jSWtZdVVCM0JJSFk1VEI4Q0tuV21sOHVTNXlzck1HNzZTTDRYaHcy?=
 =?utf-8?B?TWNlaXo3TitOK2dLK1YzallPM3NlQ3daRkY1VTU4Z1VuOFZBYnVzSVgvLzRi?=
 =?utf-8?B?TElVcnpWNVo0RHN5bG1Cc2J0ZnRKVGFYZmpJcFNRYldpVXo0Q3dOZnpmQytP?=
 =?utf-8?B?VFRIZzBzQkJWNUppN2htSEpYRTREZzJBeWxUWkFQZFE5OUFXeEF2N0VNeG5W?=
 =?utf-8?B?b0hxQldsTUdpV1VPbDh6TTFQK1puZ09rUXBhZ1pWNjRqNWNYZThmUUVjVzlu?=
 =?utf-8?B?V2J2SFc2Y3FuYXFtUTZEVThkKytXTFhZcGIvYTdzdVpVVEYzQUhOTUhnYldv?=
 =?utf-8?B?ZVljSFBleEJmOXJlK0ZXVnJWZlMzMTRaaFZrdW1lcDQ2MVdaTDhYb3MzS01H?=
 =?utf-8?B?NUxqLzQrWkl3b2hYNCtKaXJtRnM2N3ZISk1uMERFMDhlTjJUaGErTGxqcU1u?=
 =?utf-8?B?N3pDYWlzYVBkam8yS0hjY3F6eFQwTjB6c003TWJvRHU0QTdicEFTVjQyRFJZ?=
 =?utf-8?B?RHVzVHkwamVlQUw2SDlaWW9SYTI5QXFzeVNyNG0xeE1MeVN3dU1sNU5PR1U5?=
 =?utf-8?B?RmFNVDNOM3JVZW5XSmtzRmFiSGtLelYxTzBXR2JpMkdlYk55RnFTd3V5V0dH?=
 =?utf-8?B?QmNoVEd5WlkyZDk4MmdtUHVEYTBINm94STdLc2lxWkJ2SjAvZUN3Yllnd3lF?=
 =?utf-8?B?Lzl5UjR5NlcxY3BHWjg0dUtmV0F5NkUxam5IVlNnMThndENYLzA0SWxHYzl2?=
 =?utf-8?B?YlhUL09aSm55WitkVU90VnBiZllNTDlMRXNic09tNENZM3N6aytqcExtVUtT?=
 =?utf-8?B?WkRVd2VxZU1oc3E4Yk5vbFFqU2NYdEYyWVgxVGRyaGl5THBIeTJKdC9pSkpU?=
 =?utf-8?B?Mkw1dmxmT05OWVlHSHVlb2pFZUdMOTRMbnkwdERGNE9aTzc4TFp0bDFBYlRO?=
 =?utf-8?B?aU1Dcy9MRDhxQXVxc0VETDZvR2phUklUVWlqcDhSS0tRaitHUFQ3MkllRmtt?=
 =?utf-8?B?dGw5S1FFeWRuWG5STklqYUNOdHJQYzh6cjlJczNzV1ZKeE4zZ25YOXNBMzB5?=
 =?utf-8?B?cmlkLzdRN3BLblJjY2VENm5SU1Z0Q1RIcEdQT2Q0UE95eGp1MzRrNnYydUFa?=
 =?utf-8?B?K3krQm9DdTZWUGhiMnEwMTRYSUJxWVVTOVg2YmRTT1FBS1lxQXg1ZjhVWCs5?=
 =?utf-8?B?R1JNTHZ5ZExBR0M4MmdHZXJuci96cU8rNXcwUkZHdk5vaGJKVWR2R2tJdlIr?=
 =?utf-8?B?OUhYb1hqVE1oc0JTZS82Y2Vna3FIYzdLMHN1K1d4azdudUEwYXE4dnNZSmls?=
 =?utf-8?B?TVM4TFg1eGdhOFFKSk1qZ2dDR0NVTW5FcHlKMUpBSVZYQy9iM3V6b1pVYllJ?=
 =?utf-8?B?YUo5cGNYYldJeWQ1K3BLaW82T1I1eXp5VjJqNTBmcHhLRVI2T3R6UTBnVEVj?=
 =?utf-8?B?VnJHWWtGWW4vOW13VVhSYVlrMEFIRnBVL1l2OUs0ZVYrdWRDWUtjWnBJVDlU?=
 =?utf-8?B?WGlVVjAwWkZNdE14RDR4NVp3bWhOckt2NUJCSkRsdlJ4MUwveC9zVVlJelJK?=
 =?utf-8?B?RVMyNDRKMmlOZHNhdmJRbzVpVzJ0RnBodnJYT1VSWFJZM3BmQ3lrbkRaOTBN?=
 =?utf-8?B?MzNZNWhNQjE0TjhwZGpRK2NiYk9iS1BEdHNkUnhVdVdHdm56SGN5eWc0dmx2?=
 =?utf-8?B?Z1pBVStTSS9vUHZ6M3BDYlorOEczcGRGMlRuVVg1UUhUUkNrUTJreDU3Vlly?=
 =?utf-8?B?M0ZrWTZvVUQydVo0eXE0N01zQ1ZsVHhhR2M4RC9KSG9kWHRpSms2eHg5MFpq?=
 =?utf-8?B?Z1hrY0JKakcwMjhpekFaaXprNFB1WXAwODJYNkM5c3RBb0kzaHJBeHNRbGFM?=
 =?utf-8?B?NHhlanlReFd6azNaM2lZNTIwUDlqZWIvWlZ5THNSR3dtY3gyT1U3VlhwMEdY?=
 =?utf-8?B?MTBkdjFTSWVrRzVsT2YxTTBoc0RxSVh1QXN3WXNWL0c2Rmdjd2o1MkUvU0l0?=
 =?utf-8?Q?EjtmsAVxAiBLsZfoiHAmzCuayx+EaTvIvv0RsWbdO+H+?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23163f9-425b-4a56-7a28-08db5b7a41f8
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:41:25.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epGWICKXCtXgTWXKuSaKAc3CRGo/scvFdAgSilsg/7cN/XQ9/r9kvbUc/wnv54p93/bSgdxTzEYzyHvKoy8P7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB1007
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 23.05.23 11:14, Péter Ujfalusi wrote:

>>
>>>>     rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
>>>>     tpm_tis_relinquish_locality(chip, 0);
>>>>     if (rc < 0)
>>>> -           return IRQ_NONE;
>>>> +           goto unhandled;
>>>
>>> This is more like an error than just unhandled IRQ. Yes, it was ignored,
>>> probably because it is common?
>>
>> The interrupt may be shared and then it's not an error.
> 
> but this is tpm_tis_write32() failing, no? If it is shared interrupt and
> we return IRQ_HANDLED unconditionally then I think the core will think
> that the interrupt was for this device and it was handled.
> 

At this point we already know the interrupt was for our device. Otherwise we would
have already bailed out at

	if (interrupt == 0)
	

Regards,
Lino



> --
> Péter
