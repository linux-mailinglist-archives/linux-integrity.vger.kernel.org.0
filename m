Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BF647690E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 05:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhLPEcZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Dec 2021 23:32:25 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:30358 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhLPEcY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Dec 2021 23:32:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639629143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fAY0JEVJBsJuYnvLpmLnGS+mxX2JSr6z02/eKUaiHkw=;
        b=ffpRBaQ5pXBVuR/Jom2S6g0ilmKyA8e7oQTnJO+TBArGWRLILW/jNpbx9xjAyQ3VrCl+Hs
        bz0Ja8ANG3DL4ru838AYemVIoDiIbOCb+y0BA6uF1VyW+TFMK0vOl3sq0ZhnuV+/OefLsM
        NyDanCDn6MH7FZ4zU7TmTQ/5rFpLNDQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-29-S2ZpvAv6PYiU2nuDKBFCsQ-1; Thu, 16 Dec 2021 05:32:22 +0100
X-MC-Unique: S2ZpvAv6PYiU2nuDKBFCsQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoD7EGU9mtaXpAMO1PYjF+lC4TQNsuTnml09KN0D7aayT5b1Ao6D38nIo7nXUGYnWVUhd4w2PkltA2P8G6lp6BTP9F7+aZeJBXRt3JqyxCOAw/xc0nNQpxwJR6H08k2mvgT4K5QPquQrouNHsb9Aoj6UyxUZx0qxD21zEDmU/9LvEAEO7lHyt5ANYT1i/5pGoQdxYRUQ6HLPkjXpkpoU4fQKdQb/hUWLP+riggWU+0ibIaVlwR66jSPR2PQELHo4eqty0fgxtZnUm96Dc9As13m5TrU9Wawn+Zrtsh6ge5it3Tyx7mCvXF+t0QP3tzVD3oee5MYJ9JRhPNCws+fNSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAY0JEVJBsJuYnvLpmLnGS+mxX2JSr6z02/eKUaiHkw=;
 b=A3AivxM4t4dvsLSBQ0Y6ZzQU62/50cKPze5FDgLAe/uxdA4HdPmTwDCp0L7XLGQkw3ywr4/Ed70WsdSDUZJbJN56FvCj2fLe6HOYuG0TFbNeTBiMQuHdAca50z/l8n2Q6VIW9kK1A1r6utqXebsfpMjn2TmyJxFG09Vm6H+ifgvTcKa3RO7Q8BEY3tBVpp2l0a+1YZIRSjskr+/FTfZH4jMq5HpEyzdoiv9C2s4/rTi1n2+kbjPqNbDA4T7gfWZQv4ezCI/0MplHzzUxJUsyvPDAvwCHIYGeN6qQ1yhZYem/Et3pCDYibrLxCmQJc9aop71XdJ3wZX2ccXlqYEO0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR0401MB2592.eurprd04.prod.outlook.com (2603:10a6:800:57::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 04:32:20 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891%9]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 04:32:20 +0000
Date:   Thu, 16 Dec 2021 12:32:12 +0800
From:   joeyli <jlee@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
Message-ID: <20211216043212.GG3786@linux-l9pv.suse>
References: <20211213161145.3447-1-tiwai@suse.de>
 <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
 <s5hpmpz9o08.wl-tiwai@suse.de>
 <20211215160345.GF3786@linux-l9pv.suse>
 <a54f7de463853f9c3b7404739793d2f690aa317e.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54f7de463853f9c3b7404739793d2f690aa317e.camel@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b165b2-9839-4efb-1177-08d9c04d0c86
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2592:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0401MB259246086B5AA8B8924FD6B6A3779@VI1PR0401MB2592.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2qw7FVxoTOdxtfwmN22Da7OzaqUV3Am+AtsC/q3BeOGv0vGGaBJ/bo8gqR5mOwnqj1My1ni3+VzbT0zCJwMt0IodSr2fDJ/C6pBnYTDmH/C/9xGn7SBa/i5PgbPuzUxdvoDhzpxQBehDc8vCUCA4qq7XeER+7UlAnV+MjNRHqfRgdeN4zEZrwSbin867byAvt3VTeiV1XKmUiqHTL4LxUxv8mH7e+qsVp9MSmyHLLgtGrnyAJ28975/mrxINkktJhfZd/HMfIdBbSqzH4WCK0RwDfH7v6WZZe1cbiChHQDUhNG2o2KuzS/XtQZhmEpS2eEnwvCxnOvd9mfI9JMJEsy3EvvHe9bJH2+7TBahYGCTy5wKCCpA8keBkcCxggSYT424Angcnj5DKLWqyCkU1bctO7Yis4x8mbOu74jUoZvjRoZGsFTlMIrOn/FfAnu3py4Uu2MSLAuLfo1p8p/jexZDIkxwxNZUbvcOEFzVx1OetnmHW+A0BzaBDAG2OcWCM/NUk+hp5J85zyk9h/04H+SmlZ/fgSBsauE3RP9syKsV6PEOURQWYzE161WhwEqeUA/bloCVitD5FnE2YD14L64H/MMnfxp6cUqYngDelOCTHB7DX4Nw1u3eimKR6AlN8//DpLblJ5gw/kgxJUmOZNz3kv5c0SKnpi3UrvMVX/lRqTcX0haH47Ocqpz29ldahmqpztJQS3d5xFDhjMv9+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33656002)(9686003)(6916009)(86362001)(4001150100001)(1076003)(316002)(8936002)(26005)(54906003)(186003)(6486002)(66556008)(66476007)(66946007)(38100700002)(36756003)(4326008)(8676002)(6512007)(6666004)(83380400001)(6506007)(508600001)(5660300002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t4epRf0mesc51PkF6EbqKCm8A5IEGdhmXCuGCpmSVNuqEQgSs2tHzaab2/gt?=
 =?us-ascii?Q?wNSvbB3vVG1prq0OuYZMm5REuWOf3RC/LPwh6zP3WckQ9zhyDBcfOw7i4/nM?=
 =?us-ascii?Q?RPKpHUWrY6ZOitA9WVr5b9dcwzPIqLJO2e+Jja0UDyRWkWSYdUgr6PpXYaNS?=
 =?us-ascii?Q?CSZdNpNhLQoLZgOxxkLKVlCoaowuvjDJ7cPjohlIfdO+UNOGpiott2oNUXqS?=
 =?us-ascii?Q?lH+8xpgGD1f29FQ4GUjYgwnjOm1ZtQMpW/u/0PtTVPrq48MBEG0kMLnO2Qfy?=
 =?us-ascii?Q?jJ2zhcmLU+ZAKMw9iCoWm09ll9mg4KVy7z29EOtChZm/ACvoX6BGKzp9cF13?=
 =?us-ascii?Q?lW871wzOTlRMNTWZdKGr+RIQkLSK5An70TSTGExAF9vuCQ1ZfaL8F7u4GNXi?=
 =?us-ascii?Q?45KygU18OSfQtDQPyw9uFZ/toWVqnkgwKsyFM5XlvdmUuEAH0NQWyWwbScr7?=
 =?us-ascii?Q?eNP1XRhgw+IN9H206iFeeap5RdQ9F39crfJAqJSBr+VLVYuIue6pfuIFh5/t?=
 =?us-ascii?Q?J8paZWUHelJwiWmeR74ffQ4Mgo9MqS4Uld7jSMiBJglEhTstyLwiTSN5wfNv?=
 =?us-ascii?Q?bpb6nReUW65fanYy6DAUN9S5pOwK9C6/B9KbawKWB1lY522xuuDBO4LS5atM?=
 =?us-ascii?Q?RY5vJyRJN/m2vA74A/UBUeFOnvHERzF6Iit3gXybxh7KlSkc7CBsEA1xZfP0?=
 =?us-ascii?Q?2WUWzga7WPnG8q+eEYqcx+caAqcz4qqlGMrtVHvYD+NJ9o4bToJjud0B67IS?=
 =?us-ascii?Q?uOxslNGGRP8o60JifhqORNuGWn+yxeQNK6kCh4IZwhY4KuPZOtTFj1Fr1jCw?=
 =?us-ascii?Q?/BS3upGkR+OOD2HCNPMkO5q+xK8bE1rl/OjQLe/bJRhDMD4oDaJaO7TLUVeP?=
 =?us-ascii?Q?I7kZy068ZaBBTS2n2eqvXASbaY8y/VMlmdwvWOG8Xu+godz7qtdlSt03YZIb?=
 =?us-ascii?Q?qCLWztii3qFr/nQQwyHdBF37G+v0kfh66YA9Ssf4IQbMG4yBYu35SlG10wfX?=
 =?us-ascii?Q?NBfSGSnGswTzuxxBeXvcccCU0aIefzHW1c6ypeOc/xE4iwHRwRtJ8oH+JSaL?=
 =?us-ascii?Q?NUHEwPh//vnQ4p834qXmTjjDjXajWHa4KKNAYbuTH222xLrRQH+/Fd0S/QWe?=
 =?us-ascii?Q?TXepSFBYgdiPqXeQNPFEq7iSzWMWeqk5VDTZXKcCE9z7ICUpJS9y1vJFKcWh?=
 =?us-ascii?Q?j+o6M53qc/5+QrmUaHRT0Eox9DzCSiWhvJJz3bKFoVsisyivNNKS0017wiP5?=
 =?us-ascii?Q?/oesvrWgMh7G0RarS8dyL1YCWVDyak4nzjw4KTY8l/1qTi6Nspe7zhoihGj8?=
 =?us-ascii?Q?MfnTbeouZ05zkCdg0svegO+rLkJuueP5iOdpQ+XyD86ZRNmwioPlHHhKQELI?=
 =?us-ascii?Q?Uy4WtmGg/+GXyWgQIhYy+jYfSlUmsYMSv8uAPLKHE7QR797ctAVHdkkcdFRz?=
 =?us-ascii?Q?z96gtBgzWECxOFKGXd/8cg0MzhboE38jguSmf6zFQKVSU785gB/PYlYj/zo7?=
 =?us-ascii?Q?8jx6QVpNe91LOljLP5yLKM7YRaTogD4+8lbR64+iM4rOkZOQ8QM0Dmieb4+l?=
 =?us-ascii?Q?VF49VmI9+zh/dT8+rcw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b165b2-9839-4efb-1177-08d9c04d0c86
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 04:32:20.6237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2v4u8ghOj5P2GASmCzXTwMTpGmosW3xibrRgTKKQM6AKOtxAVZkghWdD7xGSzMP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2592
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 15, 2021 at 01:16:48PM -0500, Mimi Zohar wrote:
> [Cc'ing Eric Snowberg, Jarkko]
> 
> Hi Joey,
> 
> On Thu, 2021-12-16 at 00:03 +0800, joeyli wrote:
> > Hi Takashi, Mimi,
> > 
> > On Tue, Dec 14, 2021 at 04:58:47PM +0100, Takashi Iwai wrote:
> > > On Tue, 14 Dec 2021 16:31:21 +0100,
> > > Mimi Zohar wrote:
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> > > > > Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> > > > > defined only when CONFIG_IMA is set, and this makes the code calling
> > > > > those functions without CONFIG_IMA failing.  Although there is no such
> > > > > in-tree users, but the out-of-tree users already hit it.
> > > > > 
> > > > > Move the declaration and the dummy definition of those functions
> > > > > outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> > > > > 
> > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > 
> > > > Before lockdown was upstreamed, we made sure that IMA and lockdown
> > > > could co-exist.  This patch makes the stub functions available even
> > > > when IMA is not configured.  Do the remaining downstream patches
> > > > require IMA to be disabled or can IMA co-exist?
> > > 
> > > I guess Joey (Cc'ed) can explain this better.  AFAIK, currently it's
> > > used in a part of MODSIGN stuff in SUSE kernels, and it's calling
> > > unconditionally this function for checking whether the system is with
> > > the Secure Boot or not.
> > >
> > 
> > Actually in downstream code, I used arch_ima_get_secureboot() in
> > load_uefi_certs() to prevent the mok be loaded when secure boot is
> > disabled. Because the security of MOK relies on secure boot.
> > 
> > The downstream code likes this:
> > 
> > /* the MOK and MOKx can not be trusted when secure boot is disabled */
> > -      if (!efi_enabled(EFI_SECURE_BOOT))
> > +      if (!arch_ima_get_secureboot())
> > 		return 0;
> > 
> > The old EFI_SECURE_BOOT bit can only be available on x86_64, so I switch
> > the code to to arch_ima_get_secureboot() for cross-architectures and sync
> > with upstream api.
> > 
> > The load_uefi.c depends on CONFIG_INTEGRITY but not CONFIG_IMA. So
> > load_uefi.c still be built when CONFIG_INTEGRITY=y and CONFIG_IMA=n.
> > Then "implicit declaration of function 'arch_ima_get_secureboot'" is
> > happened.
> 
> The existing upstream code doesn't require secureboot to load the
> MOK/MOKx keys.  Why is your change being made downstream?
>

Because the security of MOK relies on secure boot. When secure boot is
disabled, EFI firmware will not verify binary code. So arbitrary efi
binary code can modify MOK when rebooting.

When user disabled secure boot, a hacker can just replace shim.efi then
reboot for enrolling new MOK without any interactive. Or hacker can just
replace shim.efi and wait user to reboot their machine. A hacker's MOK can
also be enrolled by hacked shim. User can't perceive. 
 
> Are you aware of Eric Snowberg's "Enroll kernel keys thru MOK" patch
> set?  When INTEGRITY_MACHINE_KEYRING is enabled and new UEFI variables
> are enabled,  instead of loading the MOK keys onto the .platform
> keyring, they're loaded onto a new keyring name ".machine", which is
> linked to the secondary keyring.
> 
> Eric's patchset doesn't add a new check either to make sure secure boot
> is enabled before loading the MOK/MOKx keys.
>

Kernel doesn't know how was a MOK enrolled. Kernel can only detect the
state of secure boot. If kernel doesn't want to check the state of secure
boot before loading MOK, then user should understands that they can not disable
secure boot when using MOK. 

Thanks a lot!
Joey Lee 

