Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5D75230AA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 12:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237778AbiEKK2r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 06:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiEKK2q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 06:28:46 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50084.outbound.protection.outlook.com [40.107.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C15C346;
        Wed, 11 May 2022 03:28:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i67QDyNFhvzQcwAG+xcYe+PbLeYJqiqe5QJAbi6Uepq9ZYT+lhfwoOQS9nU1ouagR2GPQFTUBNVU/quFqBEsAMDmgt3O5V9Ai4Umyhs/Q+3vLzmo8zy406LfCFY0V/KAepAjSuEsa5yBiPezdDESSIwjhkWic+YmPbuoF/9oL7je9C27mm5S5HctSoa63SxWilobK8LaGOpURkY2tFmCFOCg6fRTIetmTcWiM1L3s6aTuD0MthplyGgKuHvNz8AduIKgO9GXGV6mSCoGPUY1XHc3aXRyt+seYBygUC280YgGVYjME6VGucN5WRIJ5WZL6iJK1VnScXlc/ynVIqKgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRp2MD1yZekmBRUp5k+BKetuFdcMgfcF92jL9reF9cY=;
 b=YAiOHnEmaB0MfYkLr9/prrbi6eGcOSCN1IF75DQ+dKsHHyYC79MgzZjboZ6XnT2tJlfy5vHxKrVne5MYomwFE5XOsTc0mjCmDZ9VLCJRy4m4VQTSr71FbVdXQlha0VxvzWh73Kd74V3wzLFCtBscm4iakfgT47+/puHfLW8J3qyCtg1M5hJw6PNDIUPf8G3iV402opHvLQiV4ocLu/XfwSW/yFWf9xG4ArRXR2+KG2dy8dF4kzkAdwGM83SCBqwSl+vKrW5bJJV+VfrG7wGEbTcRqHLtIb85ZYgWqlLrrs+P8gcCiGm7g5n6Aj5KP59/KsRYSFwKEnuPhrM9LhmL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRp2MD1yZekmBRUp5k+BKetuFdcMgfcF92jL9reF9cY=;
 b=pACZqUujHFu4iuE1mtxZRFRnhaAgwDevi+jc0SeRUeQ9yDZUHDdlCZpkZlCX3RE8bgJVE/I9JO26fvDJ4eti89CuzELFuhqgFCULvSU3sfFdUwS50WbH7Ye8sLtgPFDlZ21YbVtfoBbKseR9kmkXBzsq6uzmVaaGvFoWEST4/1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9514.eurprd04.prod.outlook.com (2603:10a6:150:20::17)
 by VI1PR04MB5040.eurprd04.prod.outlook.com (2603:10a6:803:60::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 10:28:40 +0000
Received: from GV1PR04MB9514.eurprd04.prod.outlook.com
 ([fe80::974:442b:8b4e:d69e]) by GV1PR04MB9514.eurprd04.prod.outlook.com
 ([fe80::974:442b:8b4e:d69e%6]) with mapi id 15.20.5164.025; Wed, 11 May 2022
 10:28:40 +0000
Message-ID: <cf88010c-e141-76cb-1acb-d768209bfc0f@nxp.com>
Date:   Wed, 11 May 2022 13:28:36 +0300
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
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
In-Reply-To: <a3b290ee4367309739948c06c11964f4@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0144.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::49) To GV1PR04MB9514.eurprd04.prod.outlook.com
 (2603:10a6:150:20::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e406cff-06d2-45e7-fa1e-08da333903fa
X-MS-TrafficTypeDiagnostic: VI1PR04MB5040:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5040BFCC52F91662B6877AD998C89@VI1PR04MB5040.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LkzgdN2kj9qhKeybjz0/jpMUp3FgAz9UxRRiDpjn+VnXTPcoWc8AguWornuOpSyP6Y/Rgk+j0DSdCzEEHICtI5BpTK+rtaehMoBCGa6M6u1zLJvHb6++1DRekAFWJgqXsgmAtuYJVoY+JRP0cm+6z1KC4xMs2VFHF0x74Nc1bXI/Zkq3fnzxiR4oV88suJGQmPV6zyrMhS6Ai349Bx9/iVGeAW/LdrgiuIZfrtEZntfqGMKRwTP83+xPjxWWRGsN/btPVTDBjicKJgOij97QKgBXkN52fQZN95kU4nNGvR3pDFSzvw/qRg9fVREd54yxK9TfaRdYd6S3yURKTnG5OOdG4AmD3I80iX8/5xtc+IZav3OzXtSPCiFN8aEl4UDqiPpT2yz6ZV9BUIdgbZBvMA/TXz9H7LLSjGV9YGHFN6rnzdoXrtPCpEgZsOLAp4K5ybg3M1R2Z70rGVH/UwJf23KiFVGnG8ZOfmmbqrGk3oo8J/zuNa+nDsJ0mSOIeSDYrTcgDMuncreT1s0ou/0ujxIoY4PthDGnA+zfiBEnY1ds23jJZFibHlNYyBa9ywZ9qO57jAak+rkS8LGtp8b+3f9zEKso1yg+aJUthU9qm1P+Nc439CBeTtNvmtG6Ugd/DRPuJXRbW3V1omG+fjk4kpoHYXL/J8PPO3cQkMIKsRji05kYKkYwLSAX2D98Le+h5EY6FXGb+H8u0Za6lghjMeHgZjDVKDW8gWmRsqRNn7mApvlX0SUr5YdnlPGqPScJoE1lbuXg68nGNZSqttJAMFo0ayK4ynsnPNYl/TC4w4g7IqrATeo485AIomW/FcIeWv4V865nUWb9l5hGsS17udpWi0w6RFW4yviEx/Oiged6VLlquL2LeSgsgkL2tr3lxvedpxHMmlC0dwfSc8V25A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9514.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(53546011)(55236004)(38350700002)(31686004)(8676002)(66476007)(66556008)(66946007)(26005)(6916009)(6512007)(4326008)(54906003)(6506007)(2616005)(966005)(36756003)(6486002)(186003)(52116002)(316002)(31696002)(86362001)(38100700002)(2906002)(6666004)(8936002)(5660300002)(83380400001)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NsZjRZZ2NNdW1BelN2dzZoZ2dHRjNmN3BQSi9FYmhQc21BUWRvVnVwNFZy?=
 =?utf-8?B?QVIwTXJONDBtVk0zMnM0dGk2dGtvQmp0aGVydzJCRG5TaVF1b2lCSTNIeEln?=
 =?utf-8?B?RzZQanpqSzVQQ3VDVHJVdjU4MHd2MTh3amtUTVFHdE1SQlZqc2FKNThTRnlV?=
 =?utf-8?B?V2RhMXBRbk9HVFVUZXIwM3ppUjZ5Y1p3amlKQ3JXSzVZak94THBwQmJIajNT?=
 =?utf-8?B?WC9sOU9hUVUzbExra1VqclhOWll5enNCMG50NzFoS3NaSDRsOGpkNS81VEU2?=
 =?utf-8?B?YkhYRmk5d2Q0WkFld25sSm5YNkg3UUMyaVZQcno3dyt1YkI4UlYxZjNXY0ZL?=
 =?utf-8?B?NlFxYndqYUhBNjIxNGZUT0Zjd0RWbm1IQlE2b1MwZFhnNDVvMUd2MEpzMHo1?=
 =?utf-8?B?SExBV01Bb2ttc3JYMDkwOFh0MysyWm11L2JSTFlJeVBNa0xqQ213bzhkU2Ez?=
 =?utf-8?B?bEFlNjIwTDNoNytva3ZwVzJLcDJpVngvVUxqcVBXQ0tjQml3a2FyYWdXWFYr?=
 =?utf-8?B?V2g5cm43ajRWRURkMmh2Y254elFrVllIMFRlNW42eUIxRmsvaG8rbGtiL2VP?=
 =?utf-8?B?YU10OWJ0ZEZHeHlRbXFubTgvRnpOZ09JMklYL2RFeVkwcXk0d2o5a2dJTXh1?=
 =?utf-8?B?UktWRVNxcHFWSTRHUi9GMFk0b1FnaFNFUjFOVEZFdkdncktLbURBUEZoUmQx?=
 =?utf-8?B?YUVBR2NONldkWlIxRVhqK1JXSjB1aXJaS2tTTVFMcHpGa1BVOU9USTlQeFFu?=
 =?utf-8?B?M00xd3pnUTVhVFY2dzRCYzRnRlN5ZHB6TDFXc05hSlo1RUgxcnRUdkdZTWFU?=
 =?utf-8?B?QUpBMTRodC9XekNNUTJEVkNDSzRWaUFVaGtLOWRNaE9lVFA1djVNM2kwYTEz?=
 =?utf-8?B?cWk4eHJPUnZFbEhHcncveEpmMHhJNG9ad0dFMFhwNUFMVE5VZURES0UydmZP?=
 =?utf-8?B?Vk9NRnpFS3pZQ2ZnVTFRVUpLbmVLZVJoRVNkdWFKSTNPU1dwK3V4YW9saWR6?=
 =?utf-8?B?OEpLSHhBQTVvK3psUjZFcTFaL0RtaitYT2FwQW16VkMzQ21GYVB5QlZicjhP?=
 =?utf-8?B?ZzlDL1l2aG1IWDBGK0ZUSjNiMk5pNUd2SVFyNHlCMDdqMUtKZTN5b2hYRlVG?=
 =?utf-8?B?U0RSb3hlOXlDVkNJVW5FTmlpb0czWGtDZ2QwRUp3VjFRTTNUMkVYWTNuaWFt?=
 =?utf-8?B?cTBKbm81cGk2cWFvTmNpZXZJa1BWVE55b3IwK1FVYmlsSWJBb0w1ZWVmMVhT?=
 =?utf-8?B?TnA0eFBOWEVzYTE2WFFpNFc4S0VPYVBFVHA3ajRRNGgyM2xQQ0Y4WmZjMkpy?=
 =?utf-8?B?b3NWeERqWjBrOWxVWEVFdXJ1Y0pNeTFaL2dnUWJGelJnQlRDQzB0QmdkMWwy?=
 =?utf-8?B?bFhBdktNcjZsV1lEaXliaTFTTEJKRDhNMDdZdEVHaWFJU2FMQ1k1TE1EYTJj?=
 =?utf-8?B?enY0UjYvTE5uT2JXSy9QWnNLUkFxcUV4d0RUU1Qvdzh6eXp6b0FLWVRrZnh1?=
 =?utf-8?B?cUk5Q21lSzRnUGhZZklRV0N2ZVN0RTJtMVFUdmF2d3lpSnpvYXFwRVJYd3dN?=
 =?utf-8?B?Mnk2dXRra1h5ZWNlK2NCYk4xaGlhYzVUVUNZQmlEZnZWUitKNk9RMHlkWFls?=
 =?utf-8?B?MUxjTEJOM0hZZHZoSEN2cHJmYXNpdjduaXBwL2dYWXlsOWpHeWM2Y0M3OVFi?=
 =?utf-8?B?MkVwSUlLZE9WR2xKQnNMRjRTRG1rWGxHemxRaU8yRjZMd3lvb0lFNUxwVkpu?=
 =?utf-8?B?R1ZmNmpqSGJNYStJRDZUOUNhUHZpUFc4cnpFbXk0RVgrM0I3ZnhNelhERjc0?=
 =?utf-8?B?OERpMFN2WFFRZm1UWWcvb3Q5QzgyWStPcnl2VlpOZ2xGU3UwR0I1TkV6VnFU?=
 =?utf-8?B?R3UzUnRmUDNsTGh1QVdNbzB5eG5mOWM2ZC9NL09IeVNiNGIwcVpUbHlOeEhC?=
 =?utf-8?B?YjFIcVNwZy9Nb2V3QzB0M0lYZzdVa3hVZ2pCTnUzelF6alMrRzV3TENtenJB?=
 =?utf-8?B?czBrUjV3b2JaNHExLy95SlRNTE5sZWpub3BKOUxraHcrYzNyYmM2QjZYaGR3?=
 =?utf-8?B?cTAwSlppUFUwYk1BeEtqN0VPUk83TDZKU0ZXczBIUGV1dFBnN2ZKaTBFRjNM?=
 =?utf-8?B?R1IzSmt5SStXRk12eGhOUG54NzB5RGpBTStMV0VUdDFYVE5ZS0tiRWV6VG0x?=
 =?utf-8?B?VU9Mb0V2cHozbUFKL0NUelhlVndCNVJ6N1ppa3RmM0dMNzMrZXNmUnl1VnJl?=
 =?utf-8?B?M1ZTN0pqYjdjTzBOR1B5aVZQcTdmL1JIOHNTMTl6M1ZOQno4bDZPL3FNV1cv?=
 =?utf-8?B?ajNUK1pnL1p2TW1xM1Q3QXFLSUg4WlJBQm1BWkR1dUN4R0VxWTh2NnJyZ1B4?=
 =?utf-8?Q?29kVO0jAWv5xSiHY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e406cff-06d2-45e7-fa1e-08da333903fa
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9514.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 10:28:40.4433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YH6aMfRKlSRdmJ1O/rl0PXbMpMRaH6gL/xK2UmAzhK4EVa88bKJUe2weqNPrau9WCbjceHriaTxWTAKt+yNsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5040
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/11/2022 12:59 PM, Michael Walle wrote:
> Am 2022-05-11 11:48, schrieb Horia Geantă:
>> On 5/11/2022 12:21 PM, Michael Walle wrote:
>>> Hi,
>>>
>>> Am 2022-05-11 11:16, schrieb Pankaj Gupta:
>>>>> -----Original Message-----
>>>>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>>> Sent: Monday, May 9, 2022 6:34 PM
>>>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
>>>>> <horia.geanta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>;
>>>>> David S.
>>>>> Miller <davem@davemloft.net>
>>>>> Cc: kernel@pengutronix.de; Michael Walle <michael@walle.cc>; James
>>>>> Bottomley <jejb@linux.ibm.com>; Jarkko Sakkinen <jarkko@kernel.org>;
>>>>> Mimi
>>>>> Zohar <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>;
>>>>> James
>>>>> Morris <jmorris@namei.org>; Eric Biggers <ebiggers@kernel.org>; 
>>>>> Serge
>>>>> E.
>>>>> Hallyn <serge@hallyn.com>; Jan Luebbe <j.luebbe@pengutronix.de>; 
>>>>> David
>>>>> Gstir
>>>>> <david@sigma-star.at>; Richard Weinberger <richard@nod.at>; Franck
>>>>> Lenormand <franck.lenormand@nxp.com>; Matthias Schiffer
>>>>> <matthias.schiffer@ew.tq-group.com>; Sumit Garg
>>>>> <sumit.garg@linaro.org>;
>>>>> linux-integrity@vger.kernel.org; keyrings@vger.kernel.org; linux-
>>>>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>>>> linux-security-
>>>>> module@vger.kernel.org
>>>>> Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether
>>>>> CAAM
>>>>> supports blob encap/decap
>>>>>
>>>>> Caution: EXT Email
>>>>>
>>>>> Hello Pankaj,
>>>>>
>>>>> On Mon, 2022-05-09 at 12:39 +0000, Pankaj Gupta wrote:
>>>>>>> -       if (ctrlpriv->era < 10)
>>>>>>> +       comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
>>>>>>> +       ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
>>>>>>> +
>>>>>>> +       if (ctrlpriv->era < 10) {
>>>>>>>                 rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
>>>>>>>                            CHA_ID_LS_RNG_MASK) >>
>>>>>>> CHA_ID_LS_RNG_SHIFT;
>>>>>>
>>>>>> Check for AES CHAs for Era < 10, should be added.
>>>>>
>>>>> Do I need this? I only do this check for Era >= 10, because 
>>>>> apparently
>>>>> there are
>>>>> Layerscape non-E processors that indicate BLOB support via
>>>>> CTPR_LS_BLOB, but
>>>>> fail at runtime. Are there any Era < 10 SoCs that are similarly
>>>>> broken?
>>>>>
>>>>
>>>> For non-E variants, it might happen that Blob protocol is enabled, 
>>>> but
>>>> number of AES CHA are zero.
>>>> If the output of below expression is > 0, then only blob_present
>>>> should be marked present or true.
>>>> For era > 10, you handled. But for era < 10, please add the below 
>>>> code.
>>>
>>> Are there any CAAMs which can be just enabled partially for era < 10?
>>> I didn't found anything. To me it looks like the non-export controlled
>>> CAAM is only available for era >= 10. For era < 10, the CAAM is either
>>> fully featured there or it is not available at all and thus the node
>>> is removed in the bootloader (at least that is the case for 
>>> layerscape).
>>>
>> Qouting from our previous discussion in U-boot:
>> https://patchwork.ozlabs.org/project/uboot/patch/20200602150904.1997-1-michael@walle.cc/#2457448
>>
>> "
>> Based on previous (NXP-internal) discussions, non-E crypto module is:
>> -fully disabled on: LS1021A (ARMv7), LS1043A, LS1088A, LS2088A
>> (and their personalities)
>> -partially [*] disabled on: LS1012A, LS1028A, LS1046A, LX2160A
>> (and their personalities)
>> "
>>
>> From the partially disabled list, LS1028A and LX2160A have CAAM Era 10,
>> while LS1012A and LS1046A integrate CAAM Era 8.
> 
> Thanks for clarification. Do you know it that is a layerscape feature?
> I had a look at the imx8mn which have a era 9 and it doesn't have the
> PKHA_VERSION register which indicates the partially disabled PKHA
> block. Thus I concluded that there is no partially disabled feature
> on era < 10.
> 
Unfortunately when moving from Era 9 to Era 10, the register map
is not 100% backwards-compatible.
This is why you're not seeing PKHA_VERSION register for i.MX8MN.

For Era >= 10, the CHA version and CHA number fields are conveniently found
found in the same *_VERSION register, e.g. PKHA_VID and PKHA_NUM are both
located in PKHA_VERSION.

For Era < 10, these fields are scattered:
CHAVID_LS[PKVID]
CHANUM_LS[PKNUM]

> Unfortunately, I don't have a security manual for the LS1012A and
> LS1046A so I cannot check there.
> 
Looks like for LS1046A the manual is public:
https://www.nxp.com/docs/en/reference-manual/LS1046ASECRM.pdf

while for LS1012A you need to have an account on nxp.com:
https://www.nxp.com/webapp/Download?colCode=LS1012ASECRM&location=null

Horia
