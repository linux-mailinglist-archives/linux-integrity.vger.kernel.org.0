Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45EC475CA4
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Dec 2021 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhLOQEB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 11:04:01 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:53231 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244388AbhLOQEA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 11:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639584239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eeWeQ0eatQxxYTWxiy5pYibcUHIPCSvDnWM6tKK/gEI=;
        b=IwKP6UsNVRZY8Ira4UxYy+ds7QXfGbiVzDKgGS7x3DieN2587l8AwsCtacwq/a2TnKF3F2
        PZNZ07egT7R18wgQPSpatwWNzNb9ajyDsvaAh5MZ81x5k1khSAiFVtHXO04spo69zVntRE
        HJ2SUdwJDB09Mdwg5KrVs9S8cwXVrQ4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-kFKdFdsHN8C9WSqJG0F-KQ-1; Wed, 15 Dec 2021 17:03:57 +0100
X-MC-Unique: kFKdFdsHN8C9WSqJG0F-KQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yp9Jp+nx+OdvWcgkcHUXDa7wR+uNbNhXie1sY3F/dqEy4YV1wYzspjV/+gXkuqEiJaJtGbCyUmblUH9djTF2kdwhLWtLbOCBBxyMOlppMj8vzPUuB5H5S/QtFOi/VtGs24db8OYY7IgqD/JWBArMSZBHDivOViq1+53CNslx5yr2aXtMGb6gnRD8AC9R9gUWm2tjjXKQf/xPIWeEN28qiot0HKEKENUN4KGdY3/ywuBnvO4M5f8KYmDOkpHeCn3hNhT1UTsg1+ZmCDKS8NpXMID830hCgkvRngNa94gH0sXZb6BbzHL3yrf5FNs9XubvCsYBmLsryBGIqS5u2FwLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeWeQ0eatQxxYTWxiy5pYibcUHIPCSvDnWM6tKK/gEI=;
 b=ORTIjwpBbRFsYZsTK0pheYBkQNrxcnxw8k98ZdDebEdo/3H8lpZSuOXIVaw7t0uOM+aWXH5Lq1NnScnSTraNjylky4AMd50qZiX/Cob+5otbTKbPUWdykCBgxgwe2fiD+NhzqGqsmeurooS+k4ak8TWL6dUnUT2BW11Txv4cVdn8CB0UhE0IUGAGq7hI3rhQun4z03EnCVVE/wtTJogr++e6fg9Qh+v11CQ+AhwEUW98BZtuEOGxAjIFBFzlcH60bxVvtsICFgAIBMIjERGbO0oXXovJ3FElKryD/KVricasCQglYRUzaa84zHqYEpZFTmBhtIlDmirzKKddiYK/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB5727.eurprd04.prod.outlook.com (2603:10a6:803:e4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 15 Dec
 2021 16:03:56 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891%9]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 16:03:55 +0000
Date:   Thu, 16 Dec 2021 00:03:45 +0800
From:   joeyli <jlee@suse.com>
To:     Takashi Iwai <tiwai@suse.de>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
Message-ID: <20211215160345.GF3786@linux-l9pv.suse>
References: <20211213161145.3447-1-tiwai@suse.de>
 <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
 <s5hpmpz9o08.wl-tiwai@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpmpz9o08.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:202:17::16) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c6e8c7-b8bc-4638-8336-08d9bfe47eec
X-MS-TrafficTypeDiagnostic: VI1PR04MB5727:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB572797298D353D81138D7E04A3769@VI1PR04MB5727.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iB4RK4e7yKqT0+vQNSNKZ3VFfCiNa9U3oiWuXGHAt7YDdHp6PO0/5ZHOIoolwPofQM8PpS/TF5Q03aDFvzYijT/fjNPkcB25s7yvaPug8QOWxlFOk+w9+TCSkWfjLvhKF4NtdMUDcsRIG7mqYe4nkdu51DTzhVCbIn1gaTYfGxWbIx7LbiAMy3OtkILjh2p1jWqtE7SUw0X3n/2CS0yft6KCWAYznf+q1958HY5lBCS/U0c39A/66DflOZXySAM8qxPdj333bAKIkKHeZfK/hGkq/2BeMbfQktDGmiXqvNtbEkmBPj/sZ9PhCS3hROskJRSI076e/lHlOtZwLMtSsTxazxnDy+YSDaMF3m0ak9mkXV7NEaBeZ0dN4Pi8oqN78MQt3WPPYjzKoSPybVMeekkp4Ondff7RQCKcUBI6ac61DZA1YPEuLvgCZqTbeS7bTPS/3asctcDNnLJIngdj7ZTZ+1AA2E6X4COpc+hxUF0SMVwmyEMp5IpmrH5I/OOZdpZ7UhlIkkcEtAk+mgr9x1yaagSHJTZKgLY+RfRHBtP+lxxzkrG5kZcU64T5OvePFfqTCiW1k8RzQmGE7eZPyDcMnQmlidFkVkfXev1Q8iISy/mlk77uoJnvR9SbG6WpCZlu7AXjmJXbDwVoldQ61ciVu+IRR3oLAvS1SjJfaGWqqJiWAi9L3wRMbovnu3laZ/ajw6SYp/3JAYUHCe5+hQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(8936002)(110136005)(1076003)(33656002)(86362001)(83380400001)(508600001)(4001150100001)(5660300002)(9686003)(54906003)(6512007)(26005)(316002)(6666004)(4326008)(38100700002)(6506007)(66476007)(6486002)(36756003)(66946007)(2906002)(66556008)(8676002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vMxPimkowEWEm/oX6SOz6khteVBWu+Yn1yORBHoMWCxqbXtKzlMy74FGB2hX?=
 =?us-ascii?Q?cgksaV1METEgRKlBFoETWIZdqpk5CmaqAvO795Ugppea4n6yKz60cEH53Gqg?=
 =?us-ascii?Q?BmMg5ct2P45OIT559hVbFsuf4JjeVe2VvwJF3GEtI/JOkgorEcnYW/yaOL04?=
 =?us-ascii?Q?VdtKG2mWogdRCjB+jdk2JRg3m9V9sR82W9VKzRr7Hun+hnlRvmWf74BPKmuC?=
 =?us-ascii?Q?Vd7UFJhicKoI2mszAIA3JV7vC6aZGEMuz56NB7S8RKo7rFm4Khw94BpNBnY/?=
 =?us-ascii?Q?7eFF5K+xsTLVe3WiwBglhN0C81t3b+vKEhQIj1HT3B4K3nsaroIuqdAroJj7?=
 =?us-ascii?Q?QV7L+YJCItAwtdnP/ye0Xpsk7qCskJ9YW+I7RUwS/hzSffbJL+pYlW+JthIf?=
 =?us-ascii?Q?26qy1gFdIt/GymCXynEpDy67YgcHNGZyULIX8d8SkPegJkqzjcJgIWmhlEU7?=
 =?us-ascii?Q?AJGHA5D5sJDXUzAWcOiMeei8kM6njOS7f8WPXN45FDkCqRLiTGcJqMkAIPrm?=
 =?us-ascii?Q?/6U638wBmgrVbl2nEC2F0dao1SInKTQVWDX2RsQX5ilFPDecBuOzRvPeSyZo?=
 =?us-ascii?Q?X9FL6fG5dLUNKq1lFn3Lerxp/q5Iu7NSCZ0/ImkTf+bO3L0vmBiRs1R9IvX4?=
 =?us-ascii?Q?4JV6qe3CLOKEVLH1W11qdmyRxnn46r97c3yfhHeprNcy/YKPqwYg5c9Bro++?=
 =?us-ascii?Q?iT2OvCtdKWiZfPhFtM+5HukBri1h1QTTDrrL2xp9mJYfNUuNKrdhT7Y5EIFa?=
 =?us-ascii?Q?G9rzg5v22O5GUgwmhUogITRzWJ1IE0rAUT3kUr5MhakfPsh8uk+An8qfDOVN?=
 =?us-ascii?Q?MSx8rjWWfdkcHMTdL00QD6tnyl9K4yfvR+vfEYGaaL12dU1C3MSEreMr6BZy?=
 =?us-ascii?Q?tyj2qH1BEO9G0rLmcISslDa2GhShncefgy+CFQd1GV1skd1RqjYpmZ4r+VK2?=
 =?us-ascii?Q?vh9qYzvx3ETwQamqRNBNjR0q6PU7nQYu9Cs3N2+YSgN5uiciJT3bjeFtoDpk?=
 =?us-ascii?Q?jpOeXp0DWQLQI8up3JtmGlbm5I5wh7uDEX3XD0Y2B3tF1rdvi2s3mL94NHJ9?=
 =?us-ascii?Q?oK3DBR9YiT+WeH31YGVeLli6eKntGQ9Z17gOwctHcYuVl93aDj8JnvMAG/Cp?=
 =?us-ascii?Q?Ah3UVpID8YeUnxMWtvXScnDlXSBSrXjslhupW8Ra+kDYhlc6GWyWO2IJahcx?=
 =?us-ascii?Q?lUMYnpLbC5yNC13OsJhXHob3zYEDVdH6WDXBdAqcXffZRbHrShhqAW/UynRE?=
 =?us-ascii?Q?Jtr0uTumpF2X2d3dgUzDkb4TUhZXp/DatD0EUOdTgnaZKTgSM6sQOkAfT55O?=
 =?us-ascii?Q?CgWkeaYC8yi05DXJU0O5NTzGNTuo9xl32Z1ak2/cAo+QPiOrqwQVOeFiGCLB?=
 =?us-ascii?Q?iE8+KLkogtVVoztjQQ4t2fFOT4bN9tR2CAVYdd6rhB98Z6ymwWmSPGujev8p?=
 =?us-ascii?Q?WRvJ+RXlU5Kc9BAOjn1uE7eQ7al6+sPsJAETX13EAFD+1jmiIUki+ryzXcYt?=
 =?us-ascii?Q?d1fmyBc+z6+iKCtqBlcBtNUTM6swgKIvPwsOvHX8SpKMoXVsgLNA84duZu3p?=
 =?us-ascii?Q?Szw3rEFwDXo11ANHp/o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c6e8c7-b8bc-4638-8336-08d9bfe47eec
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 16:03:55.7880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNC5dHFJZwLx61ViYNqSwXHsn+cbTU2BS5JF6FZv66OE8TEWCtxTBzKmnia2mxBq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5727
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Takashi, Mimi,

On Tue, Dec 14, 2021 at 04:58:47PM +0100, Takashi Iwai wrote:
> On Tue, 14 Dec 2021 16:31:21 +0100,
> Mimi Zohar wrote:
> > 
> > Hi Takashi,
> > 
> > On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> > > Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> > > defined only when CONFIG_IMA is set, and this makes the code calling
> > > those functions without CONFIG_IMA failing.  Although there is no such
> > > in-tree users, but the out-of-tree users already hit it.
> > > 
> > > Move the declaration and the dummy definition of those functions
> > > outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> > > 
> > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > 
> > Before lockdown was upstreamed, we made sure that IMA and lockdown
> > could co-exist.  This patch makes the stub functions available even
> > when IMA is not configured.  Do the remaining downstream patches
> > require IMA to be disabled or can IMA co-exist?
> 
> I guess Joey (Cc'ed) can explain this better.  AFAIK, currently it's
> used in a part of MODSIGN stuff in SUSE kernels, and it's calling
> unconditionally this function for checking whether the system is with
> the Secure Boot or not.
>

Actually in downstream code, I used arch_ima_get_secureboot() in
load_uefi_certs() to prevent the mok be loaded when secure boot is
disabled. Because the security of MOK relies on secure boot.

The downstream code likes this:

/* the MOK and MOKx can not be trusted when secure boot is disabled */
-      if (!efi_enabled(EFI_SECURE_BOOT))
+      if (!arch_ima_get_secureboot())
		return 0;

The old EFI_SECURE_BOOT bit can only be available on x86_64, so I switch
the code to to arch_ima_get_secureboot() for cross-architectures and sync
with upstream api.

The load_uefi.c depends on CONFIG_INTEGRITY but not CONFIG_IMA. So
load_uefi.c still be built when CONFIG_INTEGRITY=y and CONFIG_IMA=n.
Then "implicit declaration of function 'arch_ima_get_secureboot'" is
happened.

Thanks a lot!
Joey Lee

