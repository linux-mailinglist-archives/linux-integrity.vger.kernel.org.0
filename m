Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245BB522FD2
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 11:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiEKJst (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiEKJsr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 05:48:47 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150073.outbound.protection.outlook.com [40.107.15.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4A4FC42;
        Wed, 11 May 2022 02:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azxxE1W80zBehU7Eu+497rc9VUVvmV8nlQbKUDgIsIp96ZRpNIOnOzJwXy6FDRoXGKUTSnxW5ts0upm7uKdDO9e2/eCaOzL1SNavjvgx8Iorzq/NCt77LvRvsfryNmtae6GjjIHh72404E1R6hg9eotV7Hvc29+jbA0Xc0zNIM0Udc8yyeCEM5t9SKz3KhcG4/GYwoDeuhdr/DeQ6Gb01i3pCUk+Xwv98vOQdPmxrmBhOs9XIRX8vx2L7p99KhNg8Ed28lgxp0X4QlxiFBJPAZPCiFYAABxKk8Q6twsa4Z4tIDC7Jmpi4KJWPOusUuyuVcEHPdAuq8g8SZZv6KRGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVGoeaKvZFmGKI+7VVijHlcxnVPtIiLi5exON6jSJSI=;
 b=dtbZ+KiupybdOr179qtiSbQAheDTeu2WrTHFBXh9s5D//zFLPnGaFWSQ4adVUzNFsF/i36J53OpUso4wf5PCVCwo10a5iwfQCunchuauA6+5QtFYtqnFFqIqJZB9sdRkuO4MVzDFxHJ79DYoWP1FB2yP0xJQCX3j3nN36dbDmKNd+qaREIPxD4IR7Xpmj4uGxTv1cQM3fJV+tmCmkJOD6jHdxNZVCHhjSV0TsqQ1nDY3ZGvp+8rmnAKVKbTlD3//0br6bEbDOdw4dXyW97wh636Cvfyk14E5T6LiBoEThStQ7EGDGKNsaZr+OSe3YsXjOLVj/MXwjgobWL2xCaGhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVGoeaKvZFmGKI+7VVijHlcxnVPtIiLi5exON6jSJSI=;
 b=W1kLCMaXvS3H9QL+WxX33p9YLnLAVGnRG2+jiV5tV886p9Fp9TL9gBf/7jcgenLEHE3Ieuzj1bFnRFzu47yiImiBuPlDdfwO3QWt8INrE/XSVb0LNQ45a09FjLEOpoYXywdroSxZRi9qkzy5sVLvSrStYMWWwgfYG4YYFEg+A4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9514.eurprd04.prod.outlook.com (2603:10a6:150:20::17)
 by VI1PR0402MB3789.eurprd04.prod.outlook.com (2603:10a6:803:1f::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 11 May
 2022 09:48:34 +0000
Received: from GV1PR04MB9514.eurprd04.prod.outlook.com
 ([fe80::974:442b:8b4e:d69e]) by GV1PR04MB9514.eurprd04.prod.outlook.com
 ([fe80::974:442b:8b4e:d69e%6]) with mapi id 15.20.5164.025; Wed, 11 May 2022
 09:48:34 +0000
Message-ID: <c3c1fbf2-c73a-02ec-d2cb-354880a84d5f@nxp.com>
Date:   Wed, 11 May 2022 12:48:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <232eb799dbbd341c305e911f85341409@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:208:1::44) To GV1PR04MB9514.eurprd04.prod.outlook.com
 (2603:10a6:150:20::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 361ebe75-4247-49e7-ead9-08da33336950
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3789:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB378956E51B3438797B5B003998C89@VI1PR0402MB3789.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NRxlq34YgNcuKfjlMJnSN3ZUUYI8rYFrtnpQIuX3HJT0M0A3hr5LxzV4/4zGA2wrv1/zixhS/J7+IqocrDBOu9K4E7Rtp3trGtzfvOp06wZoamsWEpOci103pHJMg7w6KGWYAM35A4Rn73nqXE5n1LcVgc39he0afGt303lM3mNB5st02GslCdMBfuHlnHNKWBLIWqhE/RqN2R2r0DNqvYyYYtidLaze5HpMvjJhyslVDCO3ZGqbfaC2e9ProC+gutwI3S1bIKkCRUqCdlySghZnuu11/zyFrPEnV5840Ry96PwwnBYMgNu+/Rbc/jVXR8nn30rhPoA2VWIxknCxDn7CjR3FjFx5pvZpQEHrxxlGSEjEX+/pJFG0UI6UG07Ly8UW4ijYyngIx9DDnvoyC4hYv3+eNwT0SABDnLwPUnOTxe1IKUo36g3cpgLuByCbcVAbyRxL3GeleeTwvNWs5GXT34sqwffhqnzi9iT7chffGCArDvABmZOaFlAO9aBALod3O08FHUqhUjpyQvGDzrCN0q7ciG9XwHqQsiLNDOe5P+V5LmvjsqPVzfCcxRbPlIxhvCU1FMZXs82p2Ziwhdco51Ja08IkkFsX5dSEkyPOYo44sXBKLVcdZGlY/SLkShmWfa3OHUK0kpoYDnGHTXLvdm8v31YBfzili4ODmL+DfWnyZQmWs5I9rpmLfwezfNf4Yfe6lbucLHJRvmFl79FHuB3fjP6Ou0bPEUBZhQ4HeXjGfDy2XekVk9SukPTQsTy1s2vdGzC8L2EnjxmCY3XspABOjhhmeGvpof7YCC7ELsSHvZpvbcMZYhM4Ri3gYX9Nfc/jM4xSI7ZIqBbKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9514.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(7416002)(55236004)(53546011)(6512007)(6666004)(6506007)(52116002)(2906002)(508600001)(31686004)(36756003)(31696002)(26005)(186003)(2616005)(54906003)(966005)(6486002)(110136005)(86362001)(38350700002)(38100700002)(4326008)(5660300002)(8676002)(66476007)(316002)(66946007)(66556008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WllNbWRERzhPUGkzNjJiOU5jMzJuYmlDSVVCRFFuRTJhSC9MTzNnZnJGZjBj?=
 =?utf-8?B?YnpRcjY4dzQvQVV2WWZPUnJaLzhNbFZoVXNsMXp2OWpGSjNYWmtYQjVDRFRI?=
 =?utf-8?B?TitacEhrNEUyR1pLcHY2SVhGRE95R2ZXWlhyZWpVOEVIN2d5OUtKRmU1ZDRD?=
 =?utf-8?B?KzYrSVlxL042SWJwS0lsbG44WWJVU2xZbUlIVExGemR2QWk1VGdGRVRaSm9Q?=
 =?utf-8?B?TThyQ0dLM3h0eE5LUDF3aDc0ekNid2w1RVdxYS83VmpXM0hMa0ZvTDY3RXpv?=
 =?utf-8?B?ZC9ZNjZrVEpDNlNRYy9JSHgyNDM2T1JjdFZhNFlIQ2xtWGFIa0tUbzR2TE1V?=
 =?utf-8?B?YXlKYmFrUW4xZUMybHBWSmxjYkdPWUZSM29uQng1Q2xqS00zOVl1MTQ3c2dO?=
 =?utf-8?B?TmJ6aTRPcWJNbWh3LzU2NDVydTczWGxQcmlKZ1U5am9KTS9xUkhPVE5nVjdZ?=
 =?utf-8?B?M2JXeitzRUhJTUFZdzJ3SHRnRi9FK1V3R3lFYVpuVnZCVENVYkx2N0FLVjN4?=
 =?utf-8?B?ZGRoVDdCOGJmUjRTaHFvUFRUY2U4cGt3VGRWMjZUSjJHUDc0TVdPV1EwZy9B?=
 =?utf-8?B?WVRKQndnR000UTRhVmtJMkN3L2xmdit3RGdsRGhTeW02dWxVY3dTOEhkc0Ni?=
 =?utf-8?B?V3VuUTFqUnpiWmpLYU5tSmk4MXorc0J5NnErOVp0OEhIUE5JVUJEZE5DZ1Fn?=
 =?utf-8?B?a3NXeUFSankxUHRoN0h2dkNqa0swYmlUOXZIS25vMC94VitxMHMzNm9hVU1C?=
 =?utf-8?B?VXpSMDFwZ2NhYVE5SldxMUZXL1N2QzUzd0VSQndEYkxGamMvOEVmTUh2djNJ?=
 =?utf-8?B?WEwrYkxBb0N5N1YvKzJzSUx2cEtoUzFLMW1hZ1MzWkdxckplWnMwZG1qb3Jy?=
 =?utf-8?B?UnN0bWJEQTJhQXJRek9yQmh4VFZZNUIvVkkxSWdSMWxnSlpobmhYaXlNNnpI?=
 =?utf-8?B?c1B3cjA3aU9BV1RTZENSeGJqUER1dWI3UGNzZGNPVExERGpZQ0lRRExxUml4?=
 =?utf-8?B?UXdxcEpFWExLTGxlcHJKVVJiK0FYT1NmcFB2UU5USmdTNzhjVllGSlJtblhC?=
 =?utf-8?B?UnowNndUY2MvYnRLRTlSSG5SS0ZxUjNScU9YVU1wV3QyaXNsWU1RcGdSUjNu?=
 =?utf-8?B?WklUWGZWRTV6bHVtYWpHUi9wbnlQSU9RWkxub29nZkI0U1FRYzdYdisrMEZ5?=
 =?utf-8?B?OVVLaFA5d1JHS2tBV21oVEVYMTBoZmdvZFhrTm03Z2hSaWF6blgxTmh6YThR?=
 =?utf-8?B?WGxrNWdvSXJRWC9Kb3N4Y2t6eW8yY0JmTGtoWlVJM2RKcGpkdS9xU3VvVmJW?=
 =?utf-8?B?bGYxc2NZRVBHS3k3R3ZBUzZxZmlEZ3JBK0VrUzRldlJ1UktXazIwODFLdkg0?=
 =?utf-8?B?MWJhWnF3N0piUEtsbGFvSzRrT1ZGbmhuK3lacCtvSlhZV3lJSmUwMGVscUdu?=
 =?utf-8?B?Z0R6bDBkYWwxclJGN0ZLTWczVzZNVzVlMFBJUk5BMGhBNHFYRGpVQVBUSEx3?=
 =?utf-8?B?SlpmMDVWOXMwVEx5V2pzaDVxTUt6b1c3WENLSmV1d3pkMm13eHNEdlJTeDNy?=
 =?utf-8?B?aE8xRXA5OEdtajNZRGtlaXR1cTI2QnFqdlNBNzQ4WlNFS3Y2WlY2ZGFsQ3dG?=
 =?utf-8?B?SlRldnJObEIzWkRFa1FXZWVudk9Ca0VQU2w1dUpubm9JZmszbzJneHlqdnky?=
 =?utf-8?B?aUUreUVOZVkzSmtoRG94MnlNZFFaMlpKUExQd2JhTkE3VWEvNUswbCtOUU1N?=
 =?utf-8?B?cEpxZ2lIczk2b0dZTEk2RTR6S1p3U0hqbnN1UWFFVDZmUE5SOXY5QU5FRllU?=
 =?utf-8?B?NlkweW5QRWhaTXo3NS9KbXhLck5YM0dJNHliR1Yrb2tGRjdMYnZQRktkVy8r?=
 =?utf-8?B?clZ2QnRFN29sMUpweTFpeGdsS1M5RUhLU2szYlh2eno5UVljM2pseVhmMmdI?=
 =?utf-8?B?UzRTL3ZQRjlqQUhLdnV2RDlLSlFQYk9pRHN0QjBheXZLaVBmMXFhQlQvVnBY?=
 =?utf-8?B?QnRlbWNwdmZYbUFHSnZBQTZqaVZ6a1hLRm1IaHEzeWx0WCtuMU91NERHc014?=
 =?utf-8?B?QUtUajE5ZUhUbGcxR0tHN3RvSW0wOW95QWJmM2VqTVNuT2FZUy8xaFAydXdw?=
 =?utf-8?B?MkFUWC9CMTQyaFV1ejhlbUY1N1p0NnhoVUNUeVZ4K1ZwYjY4R0d4MVdROFFY?=
 =?utf-8?B?NFNFcldSZWJvalNNZTVaV1pZUTI0VFhYYWNXVmtmSE9tUER6NVg1TXRteTNz?=
 =?utf-8?B?ZVBWOWVoU1Rma3RRZFpBK3JnaDRFd0xpUTFKRTdjVm5McWQ2Mk1uSmhkT0VS?=
 =?utf-8?B?S2dGTUtIZzltZEtMS20waDRWbThlK3JkNnU0Z0x4YktXQ0J1SHpiMUtncGZ4?=
 =?utf-8?Q?yzyAjN5AgJ8C5QPg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361ebe75-4247-49e7-ead9-08da33336950
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9514.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 09:48:33.8837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZCfpsJSi5D/1+d0bwMxHBGDnMwJ5PBnlmSalLkkr3ZvyTw6mdR1bNgT38DpsHGbhs7n0BacxnJPEqTHpgNGUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3789
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/11/2022 12:21 PM, Michael Walle wrote:
> Hi,
> 
> Am 2022-05-11 11:16, schrieb Pankaj Gupta:
>>> -----Original Message-----
>>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>> Sent: Monday, May 9, 2022 6:34 PM
>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
>>> <horia.geanta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>; 
>>> David S.
>>> Miller <davem@davemloft.net>
>>> Cc: kernel@pengutronix.de; Michael Walle <michael@walle.cc>; James
>>> Bottomley <jejb@linux.ibm.com>; Jarkko Sakkinen <jarkko@kernel.org>; 
>>> Mimi
>>> Zohar <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>; 
>>> James
>>> Morris <jmorris@namei.org>; Eric Biggers <ebiggers@kernel.org>; Serge 
>>> E.
>>> Hallyn <serge@hallyn.com>; Jan Luebbe <j.luebbe@pengutronix.de>; David 
>>> Gstir
>>> <david@sigma-star.at>; Richard Weinberger <richard@nod.at>; Franck
>>> Lenormand <franck.lenormand@nxp.com>; Matthias Schiffer
>>> <matthias.schiffer@ew.tq-group.com>; Sumit Garg 
>>> <sumit.garg@linaro.org>;
>>> linux-integrity@vger.kernel.org; keyrings@vger.kernel.org; linux-
>>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; linux-security-
>>> module@vger.kernel.org
>>> Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether 
>>> CAAM
>>> supports blob encap/decap
>>>
>>> Caution: EXT Email
>>>
>>> Hello Pankaj,
>>>
>>> On Mon, 2022-05-09 at 12:39 +0000, Pankaj Gupta wrote:
>>>>> -       if (ctrlpriv->era < 10)
>>>>> +       comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
>>>>> +       ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
>>>>> +
>>>>> +       if (ctrlpriv->era < 10) {
>>>>>                 rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
>>>>>                            CHA_ID_LS_RNG_MASK) >>
>>>>> CHA_ID_LS_RNG_SHIFT;
>>>>
>>>> Check for AES CHAs for Era < 10, should be added.
>>>
>>> Do I need this? I only do this check for Era >= 10, because apparently 
>>> there are
>>> Layerscape non-E processors that indicate BLOB support via 
>>> CTPR_LS_BLOB, but
>>> fail at runtime. Are there any Era < 10 SoCs that are similarly 
>>> broken?
>>>
>>
>> For non-E variants, it might happen that Blob protocol is enabled, but
>> number of AES CHA are zero.
>> If the output of below expression is > 0, then only blob_present
>> should be marked present or true.
>> For era > 10, you handled. But for era < 10, please add the below code.
> 
> Are there any CAAMs which can be just enabled partially for era < 10?
> I didn't found anything. To me it looks like the non-export controlled
> CAAM is only available for era >= 10. For era < 10, the CAAM is either
> fully featured there or it is not available at all and thus the node
> is removed in the bootloader (at least that is the case for layerscape).
> 
Qouting from our previous discussion in U-boot:
https://patchwork.ozlabs.org/project/uboot/patch/20200602150904.1997-1-michael@walle.cc/#2457448

"
Based on previous (NXP-internal) discussions, non-E crypto module is:
-fully disabled on: LS1021A (ARMv7), LS1043A, LS1088A, LS2088A
(and their personalities)
-partially [*] disabled on: LS1012A, LS1028A, LS1046A, LX2160A
(and their personalities)
"

From the partially disabled list, LS1028A and LX2160A have CAAM Era 10,
while LS1012A and LS1046A integrate CAAM Era 8.

Horia
