Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F95ED467
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 07:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiI1F7S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Sep 2022 01:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiI1F7Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Sep 2022 01:59:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402AC113B74;
        Tue, 27 Sep 2022 22:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlLhznoXkJU8/8UN91RPZQQGPWtn+v7gE030qEPKFvjk6U9qNlodef8AmFKY8m2Km6DqIpSHUqNJ0EjjslZf+A5Owu27PhVVEBGw4bDhdZOTXwqJ6cG6GZn7A60ylaw39/UKuTK4sEZc+pDNLU2i8KsfROWIiXtV3kSvdeG83wzQHvZbDbjyctBIZ7iKH/UqqTKdh2GbTgHHrvx3G6tAAh6V7eZrjFs+787hd2r5Y12Ihws32IhKEuCLk4zhd8pqzNVTrPXvB2npkd7/RmSFIIGfa/SHlJEf+tgh+7qKEI3/YiGfsIS7h+heByfaPzDdO/DqfKWGDUZ6FRzCC5jPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rmFbMBtfdQj9Nm0QlL/RassIu4Hzvjx9MZUaIyJeOc=;
 b=L1CExN+5k3aRzbRNR6uGsZCsgOhXiMOO1L3wOQCR95j54ZuNRWFrV0zdZPap+1sT4mV+kYflqk3h8wlVjuYHL+Eh6vwmdhF3yGFZ8h2vM/YAFfrhYGGl2XsB5fEO2kEEawGaqXI3k3c+PJO1Oy8wpJ3MRVDZEGW7E9uSvFo86A65qU1CTC8NIrGa+WRM9X//3cRem6Wyqvsae7KPQm7SfjrZ6gVgwvUFn76gwTTT3542c2apzxUdFhGN78dpx4zatp+AW/ZJ3R3SGxivvQ6FbozNBJRRQhx5taRA9JKDhGcNOsdpWVEbwaLvsKDQeVnmV6JZ1lhjvtFvgSFlscIdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rmFbMBtfdQj9Nm0QlL/RassIu4Hzvjx9MZUaIyJeOc=;
 b=nSiOlvTHsC45mUv/ztiwPiILGcneiXRRA4wZb4MjrLTi1JzeR8wHuLwmzWRYVJVtmv6ui4vQj38FO0FuTR2zZUrihlhS2hxKOzZqy8z9LT2UyI1RXyJlnfqOepjJZBnczAHk7W7ZB9Jkcrf0+asDvbxNZv0qId+jlQXd4sUDXoe34ATiWvRnCOslyKwGRzynzxi2Cn9efui2emGg5VT+KWtJS+F7jT1HJi/Akr6bZvEZqNEtrDdcJIdsrX3H/ij587tmXK1fZdp8zhbJQumgQZMXaeIzkX6TqmS3ujmU961o2t4ADMEmyBpEj8VCzNwrm+VV4bNUUuLmKaxoVTDHSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23)
 by PA4PR04MB7871.eurprd04.prod.outlook.com (2603:10a6:102:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 05:59:12 +0000
Received: from DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::998a:9a03:3d38:3560]) by DB8PR04MB7164.eurprd04.prod.outlook.com
 ([fe80::998a:9a03:3d38:3560%4]) with mapi id 15.20.5654.025; Wed, 28 Sep 2022
 05:59:12 +0000
Date:   Wed, 28 Sep 2022 13:59:00 +0800
From:   joeyli <jlee@suse.com>
To:     Elaine Palmer <erpalmerny@gmail.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Dimitri Ledkov <dimitri.ledkov@canonical.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: keyrings, key usage, and trust models
Message-ID: <20220928055900.GT4909@linux-l9pv.suse>
References: <e3c62f26-861b-57c9-4d86-6af68c3433b0@gmail.com>
 <de0b6e61-2f6e-c215-65a9-428c3bf1bfb8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de0b6e61-2f6e-c215-65a9-428c3bf1bfb8@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: TY2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:404:56::24) To DB8PR04MB7164.eurprd04.prod.outlook.com
 (2603:10a6:10:129::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR04MB7164:EE_|PA4PR04MB7871:EE_
X-MS-Office365-Filtering-Correlation-Id: f4280812-a237-4669-3f8e-08daa1169107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: krxT/y0/H1CjXQyq+oUF25YJ3VEOlJ2dolrBuxCy/JE8cc6Ex5OZmFWMjL0LYeZeB3DExfyqY9pvI13gJyQ5vG0OZJji/bLyVNkky36g/gw84uKdHqwksANz50Zp+LxMyqkPnzaXTnys92xSSiMXvMezODvf0vxQufAiLBmx3nZr/D1cwyvC4Rk3++AYwV/f5vr4Tpd10g/Rfc6yF4phBgRK2e5L8a356IWvyks+lKav502Pl//+ApewLtTrMz6qGom0jHoyv6B6IEKVEe1+5geji0oSwwJL/5KuWdvAxhJ7YdJ7wBb8p3RiIM5UVQHhUqyDEThq/vdTEenqo2rrW1q4HKYcvVnTEMxy6HmfqwKngHpCwLhFVd1xEWteId5EBi7+VAcFl0939Lm//as+RVrY9rR1wREJePjyZNl0wSYMJQARUH/myQmOYchZN2LruQGu9cEXS635OJ1aW9w0WsDzVUElbGDCSUTFwO9z0b2T3S2WpfmW2kbFJMu7vyQsgr9JRDHmr40G2PqqdiETnIwJSY+ORkhTSZ86ZqjWSt8mfYNG2W86z1D59mCz9Kho/zCQjbiPc8gXUa8UHAjspfX0MkTzeqy7O4SNTEiJ6iIRzVufEQHiXryJmRHVTR55F1WtLBe4jPD7Cm4e8LsZB8eTstxhLC092DGHB/x7nDSan5DkqtV7LJQ7Zs2eNHD8f94AwIxP0og0O4MobrwQF0SU5ZavsULpXGJXS5zWAOZN8slKsib025YMhpUSeyessHXNJsav3axC54mZLniN/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7164.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(316002)(86362001)(33656002)(36756003)(8676002)(38100700002)(66946007)(66556008)(66476007)(54906003)(6916009)(4326008)(8936002)(6486002)(41300700001)(2906002)(5660300002)(1076003)(478600001)(6666004)(186003)(9686003)(6506007)(6512007)(26005)(170073001)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTMwSEQ3MmFPanEvUld5NXFEV3ZNMm1KNE8wK0M4eUpmS1F4bHFNSERzbTlZ?=
 =?utf-8?B?T0hkaG5xYUFPT0RyWDJBTS9BREZZRXBhcWJwQUloajN2YS85SjdLaGNiUEY1?=
 =?utf-8?B?cXhlTDRDR2ZvVUtITjIzeWxYQVZIM05Da2xNQnVzTVVSUjkzb1BLYlNpQ00w?=
 =?utf-8?B?azFkYUZuNWlPaWRZajk3endCOElsVDV6OHJseEt5TTRuMm9LdGc3eU1jVUVY?=
 =?utf-8?B?MUE4NW81Vk5aOUFGckxaVEQ2eUkvb3lnSTJ6TE1DSkI3S2JMT1hSc3VIUWhj?=
 =?utf-8?B?UlBNZWJxQlVSSW9vU25iejg4RXlzbG1hWGgyS3BFV3RHRzd6VS9yOTUrdGpR?=
 =?utf-8?B?TjgwTFd5KzF3a2V4RWdwMUdIcW91aWMwaDM0ODZ3MGg3ZWdWeGcwdmtDSVNV?=
 =?utf-8?B?UFBDalFUMkhzRmhSMWhUMmVaQzN6S0Z3Nnprd3F4TG03dC9lR29ET25oRVM1?=
 =?utf-8?B?ci9RY3ZMZmRLVkMwWkJqMmR5dFNHdjVJS3VNVEJMWkJkMDVsQjlkSnJCWW1O?=
 =?utf-8?B?QkYwT3ZZVXprRDE4aEhYTTYzVmZrSFhLOWtKcVF4Z3pYaHpHcGNlZC9GQ281?=
 =?utf-8?B?b2VWYm9yaTBhbkZPM2dXaXFKcHhYbURnOHpVc1NtMlZNSVlvVTRMQ1gxaHMx?=
 =?utf-8?B?aWdLajZPTXZuOG92d2ZIOGh6c0tHS2RqbVZ4QWRPazRzZGVQVEx1ZXZwcjJK?=
 =?utf-8?B?N2ZlZ2dTc2wyZGk4K2prVzErM3dBTmY0MnBVa0Q0ZHg5NGR2MEZrclRRNnVw?=
 =?utf-8?B?VFpYU2JqNG1IcFZXbEdvWjJDbzcwRFNlSWJDQmhqWnkydDloZE1wcHlVdThH?=
 =?utf-8?B?M09HTFFlL1JmTzNTaHdCNXF1NWhJVXdYV0tMUlhhNmg2WUxaWEc5TTZ1eUVR?=
 =?utf-8?B?REtrN1lwcWhLb0JRNUppMWtFWnF5NkhBQXNVZzZsTUpqd3dveWsrL2kxeE11?=
 =?utf-8?B?QytBQjJnVjFReVNNV2IwN0N4THFUSElsT0RxSnZ0TkNBRHRJa1kyUVdCZXdK?=
 =?utf-8?B?NjN0V3pPZWl1Mk1pUVBlRkZaY1YyWlhRMUIvTmFBRndFSUpuZmE2OVBJM1R0?=
 =?utf-8?B?dkhaeXEzM2R2cEhWQXlNRzB5OTJoOGZiOHQzRm1SaFRmV0twQVRabkRUaFds?=
 =?utf-8?B?aXR4ZjZaSzM1RjV0MjdpQ2R0czhWU253TEtET1lDSEpkNjZOOXJZVkN6Z1Rt?=
 =?utf-8?B?a09WSG5WY0VjQjBsb0FPSHQ0TmhkTld2eXR3RkVsSWYzL1dkV0srL3g2UGkr?=
 =?utf-8?B?NHM3U09vOXozaENweENKdk1JcElySUF6QlA0QnM1UDJTZlpNbkc1VVdMRkJE?=
 =?utf-8?B?Z2JqVXlBOTF1elpYNjhScG1YV2JNMSt2Qnlyd1NYNjV6ZG9LVXEvSGlIT0dU?=
 =?utf-8?B?MEdzVDBZZUJLa001RnBLK2F5dGV1dXVKQ2NnOXBmNmU3TitCazM3ZnQ0dERk?=
 =?utf-8?B?cVJYTTMzbURhYWNQMGlJSlU4RlZoWWF4RnJ6TkpaNWZwVEJnVnRBc0ZkR011?=
 =?utf-8?B?Z0haVml1bkFNT3N1YU45MUFYVENSYjJVbGlaTi9BaGtJbDAwVDl4dEV5M0sw?=
 =?utf-8?B?U1VmYlkvblVQczkwc1ZqdHU0djdYU21ITGpIajlGTmkyYUcvTGNGU29qa0hn?=
 =?utf-8?B?VlowZXROVmFXVU5kQWZqdHREZWNIWUlvUnlwbERnSlVRRWFyeEVkMzVUbUF1?=
 =?utf-8?B?VlJZenVNUUpDOW4wZnVzUVBsaWQ1VzVlNFQyRTEzQXpKMEk2Y2JERVdGQmNp?=
 =?utf-8?B?Rjl1d0JOeGVWODZvaDAzaTFTaUdKajNyZVRHQ3VuajVTMDlUcVZSR0pTSmhm?=
 =?utf-8?B?SHJnU0pIakltdHZOV08ybVc4VGVaK3pwNjZwRDhMSFNxZkZDY0xsSnVPb1ky?=
 =?utf-8?B?NVpjL1dYTmM1cXhTYzFWQjJVQ21lSVF3MUwzOHlsSmtYaHdYSmFKSXQzNy9n?=
 =?utf-8?B?Sk85OU5jV05ML0YwNDdyRWRFZDVNZm1uaUx2OEhpVzJrUTN0ejdpQzlIVERk?=
 =?utf-8?B?ZXhaOXYvcERmR0NMYWpMQ3N6dXlwR3NiTEJLTW1XU2NPUjJSMUhRSFBWWGJF?=
 =?utf-8?B?WitiRnJaNW5Yb25lVDJHclpxYm50K1BNa29SSGRSNXlkMktwaGh1Y1hqTUtU?=
 =?utf-8?Q?I+LI=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4280812-a237-4669-3f8e-08daa1169107
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7164.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 05:59:12.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ubfoA9pK2iHedcS4487c5jEAVMl/T06XexVE1psq/7HHhrPKLDI2pWwaa0Gn9XK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7871
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi, 

On Wed, Jul 20, 2022 at 02:43:54PM -0400, Elaine Palmer wrote:
> 
> At LSS 2022 NA, a recent talk titled, "Establishing Trust
> in Linux Keyrings – Is trust built-in, imputed, or transitive?"[1]
> triggered some discussion, which is best continued here.
> 
> Background and current state as of Linux 5.18
> ---------------------------------------------
> To save space, some terms are abbreviated:
>  
>   Official name           abbreviated  Origin of trust / who vouches
>   -------------           -----------  ----------------------------- 
>   secure boot keys        SB keys      hardware keys (if present)
>   bootloader              bootloader   SB keys
>   kernel signer           signer       bootloader
>   .builtin_trusted_keys   builtin      kernel signer  
>   .secondary_trusted_keys secondary    builtin & (new in 5.18) machine
>   .ima                    ima          builtin & secondary
>   .platform               platform     firmware, SB, MOK
>   .machine                machine      MOK, management system
>      
> In simplified story form, hardware keys authorize secure boot keys,
> which authorize the bootloader, which authorizes whoever signs
> the kernel, who authorizes the builtin keys, which (along with
> the machine keys) authorize the secondary keys, which
> (along with builtin) authorize the ima keys.
> 
> The firmware, secure boot keys, or machine owner keys (MOK)
> authorize the platform keys. MOK or a management system
> authorizes the machine keys.
>

There is a case where the platform manufacturer is also the machine
ower. Is it possible that they use keys in db as mok? 

On the other hand, why kernel only allows keys in db for kexec? Is it
because UEFI spec says db is the signature store only for secure boot?

Thanks a lot!
Joey Lee
