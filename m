Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A95234347B
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Mar 2021 21:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhCUUBh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Mar 2021 16:01:37 -0400
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:1537
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230230AbhCUUBR (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Mar 2021 16:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIBGyGhWm7S4dlOaaret5QqGjLgG+1r10AKe49Z1bRngq3n7KZ03Zt4uCvi1kaX72Wmbd3JqyCZSEy3IgLrHqkCZ9GJ8R2uQZjv6SPaMM1vx6vwsaJ4Wng77A+P1BoV7OgaSZj8X5jM27VQCvELH8mOB9pQ8Z3MXAAbXu6v5Ze7eYazPLvKRjSFBrdS0T0jC+uPUOcVoEdlQNSqfMXaIp71A+c5a5sCuFcYQW79saHhfVwaxEGqs3KONOUdkaoinAUTsZUstnS1bnWqcgAEcDHoTdncGLv9KgBzXboFwy51XcBFIQ4ZKDfHGDdS7i5B9V4ftEgBZFGAZCpuiCll6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=918lbDEYYd3CVFLKnVhPhULf57sVUOuucxWaLxOZRQM=;
 b=XRkFGQpBjM3vzBqyIIKeXhZK0qeDuZ7uCCnE6Xj67F1uSuzqu0n7XocOOiO70n4Cd9V59w04krsZYpKlcYiVbo8Xqub47BfuCusW/nz/sYACkPVsdzcZzhpHDq9mEemDBF3/75RugG+dviMaqJ+e3bRjVIrtnDCKyd7if660kSI3UjAL1lqzhCnWW+P9Fxq2dpE7Djf8zdiTUjaWSOsX6J+3krSH0l35id9sQFV1AhSg0QKNIXzDR369E7BWHe79EdsDynADyJRFhJCS/xr/uBUM68MTgZ/3BwVG882WjBmansWcsTrn6MurcZ9vjhhC0WzFun/BWIjzT+uzUYG3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=918lbDEYYd3CVFLKnVhPhULf57sVUOuucxWaLxOZRQM=;
 b=PPoYT43cQDZ5VUBM+2IoR7R2VuidkpfSebeztdwnae9l9xzoL31itgvvkZq58y6q4eM9Nps+xeek/fQknbXqfkxkfi9U51S2QWCNyVp7o1DH4Xl4PX1+189i2rN1olhgM7RIy4/43IcQXqHRbY2VHABYguMSjbOteYRlUwvvHtM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com (2603:10a6:209:44::24)
 by AM6PR04MB5287.eurprd04.prod.outlook.com (2603:10a6:20b:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sun, 21 Mar
 2021 20:01:14 +0000
Received: from AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742]) by AM6PR04MB4038.eurprd04.prod.outlook.com
 ([fe80::ec5b:262e:8c27:c742%3]) with mapi id 15.20.3955.024; Sun, 21 Mar 2021
 20:01:13 +0000
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@penutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
From:   =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>
Message-ID: <f0f43b30-3dfb-c2a0-7f69-6e5488f871cd@nxp.com>
Date:   Sun, 21 Mar 2021 22:01:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.97.206.147]
X-ClientProxiedBy: AM6P191CA0094.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8a::35) To AM6PR04MB4038.eurprd04.prod.outlook.com
 (2603:10a6:209:44::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.213] (78.97.206.147) by AM6P191CA0094.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8a::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Sun, 21 Mar 2021 20:01:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a19e744-eab6-42b2-6076-08d8eca41469
X-MS-TrafficTypeDiagnostic: AM6PR04MB5287:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5287668AB752313F2F7DF8A098669@AM6PR04MB5287.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxLqQvfcYKtPpWfiq1mI/sI60dxueR72MWUJG0ypfOvgdYEK/CI/pi+W296ngcvV2p5KYxR8AV3tF5TFXFRNz7k6ZwQsSUbGVl5SdxLicz7qUVhm5yWo0cys9HVWgRxU4sHsaqs6ubdQ7lgYDAUQMuih4Rbpfik9Lsln85cNHLZYRGVGbhKU60+UPyNG30AJxBPTUvkSCYuaEZxrB000xzPGuTf3ZbLKJks/ojGRE5qwnC6H8DyXP7G3etca5sUS0UG07nfilDlHRDL7wpum0wk98AaKgDAu9bsKyeheRExIqcw6o4WaKXdwXJroBGgBKxsJIp4YcsNkp/Nwig/CWPljX3nwdCMKmbiYaez+OHXXYHy8SyQnUfmyO1tXNru9obmxqiyEAnEQoZE95/STCGYzLIsPN/l7Gj+PSr8yilDY0VeB/j+N5S7hvPmJgc9oBWEEj/M0nkje9y+HoKaaxCEQiY1ipVxopAxe/1tja+ruU1PnYwM6OuapEQ0/vRlm2ht4O6xdapW6pnxT0JTiCPx5Au2cTwW0AU2sdOpNSQ9SguUxwls8CahKCtcAVmJSftNPVw7mc2ZqF05KtImaBhOrQYBUHr51sTiwnF/7WmGTUS6zm0yVTo6t/Ac3L48QmkXFfbkoD/VzppmWs/BO0ax3+EarEcIsNBY/w6qyHfk9OVptkbUG1IKrEbh+7XigEAmhwzWrgGIj9ty/jV1x8EO99EDt0lls7DQg9BLZ7qc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(4326008)(83380400001)(52116002)(5660300002)(53546011)(31696002)(26005)(86362001)(31686004)(36756003)(66476007)(54906003)(66556008)(66946007)(186003)(8676002)(16526019)(956004)(316002)(16576012)(478600001)(8936002)(110136005)(2616005)(6486002)(38100700001)(7416002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NnVaMXRVcmN6OG9HZEpxUUV6MjFwTTIzOXRQSGM0L3k3UG9Yc1pYNkdud28w?=
 =?utf-8?B?TkhNM0RSa1hvSVNmejRsZVhDcmQ2YlJqR3lJanZmV3VMTWtRZnhjT3R2WU1v?=
 =?utf-8?B?ZlVWUC8vYTFyNC8yQUF2UU5EQTh4aGp5N3NPVGtwcktlSnI0Y1ZuWC9jYjd5?=
 =?utf-8?B?b3dIcHgvanhxWmtnZER3V0NrK0pINU5SUWNFNFI4MUZtMXkzMkdXanE1a3ox?=
 =?utf-8?B?T1dzNjExeDhQZGJMeFYyYXY3MkloNTNNRUpsaWV0N2RBTlZXSEsvRlNiblpi?=
 =?utf-8?B?bk9kU1dEM1hkT28xTGFBMVI0cFc5S00zUE5WNlBycmRTVVRSckExcGZLTFdn?=
 =?utf-8?B?OFR0TGJPT2pZL2c1MUZjSk4rOFp0UHVxbzhXRlBSeVdOTnhiKzFlQWVzNldv?=
 =?utf-8?B?UjlUc3A5ZEdJWE1XNm1MckNMZFJOS1lVWDNTZE1iTGxaWVREYmdUSFlmT3Ex?=
 =?utf-8?B?V1p4Vm01V0JUQ3dESmloREthTVN0WVRjUlc5RFJkZTV2YTdDa2FZNnEvamRP?=
 =?utf-8?B?NnBMZDF0QUw5aW83Z0RwV0N6T0pjaFBZbGxuODFESjFEcXZJZzN1WENaMFJ0?=
 =?utf-8?B?UGNCNU90cVA5NktVNWQxOFRMSXR1a2hSeDZxR2NCNCtYSWpZNXp3T3Ntdk9Z?=
 =?utf-8?B?Y3k3TG5mek5GWE1VQ3RSY1RyM1VoUnBHZkhFL0RETU1URVYzdm02b2dEbmFw?=
 =?utf-8?B?dWMydnE2QTI3SGVPSzlNbnpreVlCZkU3bUZWOHUxSkdUTmdFQjJVd0RhN2dm?=
 =?utf-8?B?RDZWby9nbmJxbzN6a25HL0NNZSs5dlFHWWhYd0UzVGVEc3IyUzRtaWxBeVVV?=
 =?utf-8?B?VHFlODA4WnA5OXVQSGovS2hnRElpVlJ4ak1OODNaRTlXemNvZFhxRlhmMFp3?=
 =?utf-8?B?SVl5NWRGWG9OaWdFOEg5ek9FR3h1WmZHTTI4RGZDenhweHpDdWFHT05pTjc5?=
 =?utf-8?B?djNmQVRMQStuamZxWDY0emMzazI2WVpRaENWTU0yL3IrSXR5czhLbUozbS9I?=
 =?utf-8?B?VTE5M3dRVzVWSTRwcGVNWngwVFJEeGJpNmgzb3JaclpYZXlSVkJLeFg5eUhE?=
 =?utf-8?B?WWJFWHV2VnBpM2pJSmJMbUVQTzdpWE5Eb3dFZWlobVlDSllITWVubmxsOUxu?=
 =?utf-8?B?Rm9pN25XTU9lNTNBRm1xS0hQN3dtM2UxOWFYUkRZN2hua3dmYnpoaEdWNkR5?=
 =?utf-8?B?ZnVUNlByaVBIdjdONnhicjVjS0dOM0F2b3dTNVZMU3lvdDZuYmpzYnpGWnRn?=
 =?utf-8?B?VlRaczR2czlNUnd4TWFLbWd6aU1XSk1BenNTcmxtMVRkOWRPV3NWUUFJQitO?=
 =?utf-8?B?dFlLNjZXc0lFV2d0YllSTDRaV3ZEellxQlo2MnFVVTFIQzVNbC91Ym1jL0wy?=
 =?utf-8?B?Nk83MEwrcGN3Y1dIQlhrbjg5UklCcEgwTHBnY3oyWGRHOEZBMzVRRHo1aS9o?=
 =?utf-8?B?NUZhSllwdjl5bnZwVk5jRHBpZ3dQbW9hT3FUZU0ycVRoTGF5T291R2RNLzZN?=
 =?utf-8?B?M01MWFNZQnQ2WTFDWVJ6NnRZeWhqeGU3dndtTGl6RU93cm5VallSVnJwU2VJ?=
 =?utf-8?B?VFdyWEF2SW82dm95MWx3a1JqWCtQMEd6TC9yNXlDTDBzNDhRck11by9uejFX?=
 =?utf-8?B?TjhNUVJzU21JNTFBTXpHb1pGMkZLYjl0NGwxM1BXV1Z5RGRURTlhVWZKeFhI?=
 =?utf-8?B?ZGI1ak9reU1yM2daa0tLMW1kbFlJcHRYQ1c5d21YUlp0TVVZL1R2MnlvRWVV?=
 =?utf-8?Q?UOBaWIJD0SkGBaiSVlyioaCoir6nDcLfxWHa0GE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a19e744-eab6-42b2-6076-08d8eca41469
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2021 20:01:13.8984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRfpKsiEhiyjXNrhNHznfl7IbIhjj+n0ZRRtBYEn/1zDWEfAoxdHQYhK/6gOMheSwhr95FBp+EqKL3urP2sqCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5287
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/2021 7:02 PM, Ahmad Fatoum wrote:
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key. There has been multiple
> discussions on how to represent this within the kernel:
> 
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
> 
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit added[2] a new "secure" key type with the CAAM as backend. The key
>    material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not specific
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>    basis for TEE-backed keys.
> 
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. The key
>    material stays within the kernel only, but can optionally be user-set
>    instead of coming from RNG. James voiced the opinion that there should
>    be just one user-facing generic wrap/unwrap key type with multiple
>    possible handlers. David suggested trusted keys.
> 
The whole point was to use caam "black blobs", with the main advantage of
keys being kept encrypted in memory after "unsealing" the blobs.
(Keys in blobs are encrypted with a persistent BKEK - blob KEK, derived from
fuse-based OTPMK. OTOH black keys are keys encrypted with an ephemeral, random
KEK that is stored in an internal caam register. When a black blob is unsealed,
the key is practically rekeyed, the random key replacing the BKEK; key is never
exposed in plaintext, rekeying happens in caam).

Current implementation uses "red blobs", which means keys are left unprotected
in memory after blobs are unsealed.

>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends with
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
> 
> This patch series builds on top of Sumit's rework to have the CAAM as yet another
> trusted key backend.
> 
Shouldn't the description under TRUSTED_KEYS (in security/keys/Kconfig)
be updated to reflect the availability of multiple backends?

Thanks,
Horia
