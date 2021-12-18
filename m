Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B698047982A
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Dec 2021 03:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhLRC1j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 21:27:39 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46750 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229709AbhLRC1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 21:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639794456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0+U/fL0R/UF7Sjy/Rfh0wLT91FUfkQboF5f5i2NKko=;
        b=QKNzbmx3iA9bJrqMrzt4AbDEM8UOJn4mCpvD8X88S4KLAAcAI/S7oOxTIRFnM/3PlnzTSA
        meYf1vtLfQaftmd81sJVztNtHL83wDcc72N7nn5gF7L8Bs2A6ro+D3iqfvaiiLxaqATpm/
        ce6BVbrj16Fua0HhUB//kEyeNR0gnJQ=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-fDVnKHv3N8yc8vC4NjcBzQ-1; Sat, 18 Dec 2021 03:27:35 +0100
X-MC-Unique: fDVnKHv3N8yc8vC4NjcBzQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cpp4bXQJdoCu/cpgR7T4Gmr7KmCJDEaAMAbc/ND8LSUBqUxSTyTZnaUfeyYH/qgbxc7ftNByxw2sLc/mMhxQRH+p7Jvt3zEJXJazISgM0DxGKJdyGwvMeiL7CNAHvpTtjodHAGXxT7TAigO6f7uOXnmbLxlow2xIU9nLtTEcnDdPGYcwTnfeM0IGSv0iQ2paPDdL1Vc8zhi4H1+DTaR6JgDacGDO+eBfsnzdWA+t1PspwwfQnS0YzuKKeKbjZYFdAc9L2iTInr03GziudTrQFvCPSSx1aAnYS4gqCTEIlv1IysmmYpBxadeZkBEjNffHxNhm7JXi/x/mXJ/4PsSvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0+U/fL0R/UF7Sjy/Rfh0wLT91FUfkQboF5f5i2NKko=;
 b=c5vTIaH0/EEoXXZTrKjkmdIZnOqivFIAiMrHukixsBqxpHjov/tqTgbniF3i12RwOJaobAWfnsKDeLZrdsZKsvHSuLHn5WOTKIdTval8PBy2OVlNjEYatvH8wom68X8FiRmN+CFWx4lAblV3e/TfspohvbIjEf1qDG2UX4lBT+5JAG52+WeqpkuRP82fOLSCYSWNfJv+2F8baTFePPTCB3rmYr9/j86nr2aUm9DOHY3tqJIXFrtn6QOXXh/n9kHwPmKN6YLORR4xaOiJ1vAkyFExhQU7TXQ5JlhbHb0/6o/kBUsqkNvc+MYEzE7cfgaStRJp2RUmO2hAakEi0LXUhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB5245.eurprd04.prod.outlook.com (2603:10a6:803:5a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Sat, 18 Dec
 2021 02:27:33 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891%9]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 02:27:32 +0000
Date:   Sat, 18 Dec 2021 10:27:20 +0800
From:   joeyli <jlee@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
Message-ID: <20211218022720.GP3786@linux-l9pv.suse>
References: <20211213161145.3447-1-tiwai@suse.de>
 <d99fc78005d8a245449dd6ca0158cf9e2a897465.camel@linux.ibm.com>
 <s5hpmpz9o08.wl-tiwai@suse.de>
 <20211215160345.GF3786@linux-l9pv.suse>
 <a54f7de463853f9c3b7404739793d2f690aa317e.camel@linux.ibm.com>
 <20211216043212.GG3786@linux-l9pv.suse>
 <72b57e7f22a593ea7fe38e340ba11de944658554.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b57e7f22a593ea7fe38e340ba11de944658554.camel@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR02CA0193.apcprd02.prod.outlook.com
 (2603:1096:201:21::29) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d7a8a07-eea9-44a6-136e-08d9c1cdf100
X-MS-TrafficTypeDiagnostic: VI1PR04MB5245:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB52450A3AC63E22AD9201997CA3799@VI1PR04MB5245.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juFALcnEfHINgQ8qvhaukcteWaQbDSELj0vf4gVRPhY3av4WCSJ/rU+mEj1SFiyHZdP3sGVFHGzWfjtnEY3jBXmdUeUZbQZszgOj4D5e+NMe0DkkEOSRP7XRmUIk5e8c9up2aV/XW12+PPE0/M/WPr0L5y/Wr1fjWIAwzNorNxMw6TVDG8500aOKOfk0RkYtT+UnLPYEA6L/DCEao4r4rWxaLjYN9jYo98R3HP0m8Il4K5qK1puBfQyo3Yf0QoUE5RsX98PtxYwVDDTPoR1Zg8HRAsGhmphijK9gqYJjopwC2plHcVjJmBPac+EwgrWd6Sfid9E3GfDFTDb5xa9HsQ8UR4+mStemmK9LPSRp9VIDtN2A4Pf3EtSrWC6SLdxFUc3yTElTxyhodFPn7JedmlpL0NZ9MhQ/7NUP7LIz/nZMpQWyfBDPhsBfztB9UOkzNupkFE3k7kId/6AccW6c3JXv5ZmME7uLGDjOFynZX9bMLkJGMh5RAw5RTGqhnVbcT7uLmrkWLFpWk0Aumxd3G8GwMqdcb6NFZCfYOSVAWU6FwB4cU6k3Sa9WPuZzmFPOx3Y5m+S9vGJIk/CiJLeV8It7ZpPsiS6c39nK07pJOzi56JveraOfO/9jeJUKOFPP/BA1Yog1VZErl+ldgwJiYdHTtYdHO8fROA95O18oJf7lNDCq12qkhLNy9IedJO3ID1sjdyEceBxdV9WzxAJ2aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66946007)(66556008)(54906003)(508600001)(33656002)(1076003)(86362001)(66476007)(36756003)(8936002)(5660300002)(6486002)(2906002)(186003)(6506007)(26005)(8676002)(316002)(6512007)(9686003)(6666004)(4001150100001)(4326008)(6916009)(38100700002)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s2B9p0ZQB68E3NWl4Ee15O2kPl4VzWxCKbU2gbWX3mw6qWOhHiQnbspRwpHS?=
 =?us-ascii?Q?Pccx8v5qsrvm7JETYTXRNrqlAqF4lXMjuBe59bXDZ6xxr2K9VaV727+HEDNZ?=
 =?us-ascii?Q?FTF0g9U7pZFd+B3vI1pInFbSWZSGXnma8RgVzTBkQwkM28/6SoUu5T5LVj9V?=
 =?us-ascii?Q?N2Psh5nZXL+DOYz7SWL5msy8KArWIet8+4F4xFDHySvgonsfSIxRkLb+58cf?=
 =?us-ascii?Q?oMa5wjDw06XSwNFpRr3Y7Q+SOuqrGhg5SIpRF1uzQf/uKqFlHMYjHLEYMbd2?=
 =?us-ascii?Q?9U1VAxi6slqJjFQHLLTf/wVkCIl8M+BnfdMoSd/8EKqeCw7pV3Rk34VGbTMJ?=
 =?us-ascii?Q?DWLN8gWvzsq+J626RKSXuD990wCi3+ojc7BipGiUbgBTHiMpOgBeew/mf39D?=
 =?us-ascii?Q?7QstBJ1hjzkSR9yNgziCwG74nVtWEgR1GIfw2R0fKegppK8IHm2wDzAp7u6S?=
 =?us-ascii?Q?Hl/3JKY6JkpLus2U4F7k6fOKndQjJvjwlLFB2OSskG1d4oHBca6PsajjXCH5?=
 =?us-ascii?Q?7yQcgeqGlzUoyx6OyA46EBDr62YgZO3sie2ZQELatH72cdDDCt3jRQwvPn5Y?=
 =?us-ascii?Q?pvjIt0KZ/OffrK+BwTGF5O4aGavYL/gCz4OmUZkL8kHC6P4kiptX5QrPV67V?=
 =?us-ascii?Q?ErQzUVow6M81Nn77hpXTfBziGTJ+eBVDEVbF2AaWcJavnYPOhG4XYgE2fdlw?=
 =?us-ascii?Q?PEBIuOF0FM019/ANQxL9ISD/zw2O2UKhJNaCLI44yr+qTejmeEbJCueaaqBw?=
 =?us-ascii?Q?DqbPZwSXghsZQbIwGi4q2Eq0HYtmJlupsq0G4yZDXc/LXTW+Qqz5FBHmM0g0?=
 =?us-ascii?Q?EtujoKuMeCEV6roZhNQaCMTtt89yf2o05IdOiv4DC0Gz+rYIuU8AKywfnslx?=
 =?us-ascii?Q?e9et3PjjQeEYSyZgTvoc9yW6jFVxF5JwNiVVKZ6uD8AFxR0QPNpWXUQC3jIo?=
 =?us-ascii?Q?tvnSVfxLKoog8B3q6mV99JhBRCQ4mM4QGigI5cZ087/1w7AndXxfqqkI35zb?=
 =?us-ascii?Q?umi2AKAdsNKmsPOpQFZSZFoksigWeg1hOWBQx9G+IqbKr3c+NmjHczYl7vTq?=
 =?us-ascii?Q?p7mAlLWEkP5wxeaHulmvROmq0g6BWKwooqL1nFtyE/GxKga+ucwYPW0zWGhA?=
 =?us-ascii?Q?wRQQMC/Pwif/npoxo7TUTfiKPH6ZEKiEd7WWa6bgh2B14ha7m1ZF4wEXHlQF?=
 =?us-ascii?Q?BvS2a9DT+9J+jte1hxdrSWXcwo9acq4hY7cIxh2y1km0qIbjMXzXrzNIFNEu?=
 =?us-ascii?Q?d0YyvNaSoqO1AbBGM2cPhXAOPIdzwSbxHyJc1z/ziYGrKo4F9ftivXIYJLA1?=
 =?us-ascii?Q?sJMFKYNXXkWUnEcas5mTKgMz93zpt8yZaV2BYr3hulexPHFd/GG/Doxoy4Mf?=
 =?us-ascii?Q?UzMBweUtnDi9ao5dVUCtpbmoJrGcDgWQ9QUpBShGlxjJU66Fq+tPr6rHzET+?=
 =?us-ascii?Q?eQBZ4SdoC8NiYf05/P6v4Nvsy3isRHU58ttqqXQNJxxgVSYIx3rOUn59uTsl?=
 =?us-ascii?Q?1rUMxrPQYO3PvUC6ea9H931f7HObXGlRqHjYk7M/4K4oysc6eTy488ShAGXu?=
 =?us-ascii?Q?GtuxQxbi7NOI0EXJDAc=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7a8a07-eea9-44a6-136e-08d9c1cdf100
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2021 02:27:32.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97A+3Iz3j8W0caqFhC2jpKWrxRj3PtO28crQoLwzSkSLfud/vW5Pd9LjawowjXAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5245
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Dec 16, 2021 at 08:22:56AM -0500, Mimi Zohar wrote:
> On Thu, 2021-12-16 at 12:32 +0800, joeyli wrote:
> > On Wed, Dec 15, 2021 at 01:16:48PM -0500, Mimi Zohar wrote:
> > > [Cc'ing Eric Snowberg, Jarkko]
> > > 
> > > Hi Joey,
> > > 
> > > On Thu, 2021-12-16 at 00:03 +0800, joeyli wrote:
> > > > Hi Takashi, Mimi,
> > > > 
> > > > On Tue, Dec 14, 2021 at 04:58:47PM +0100, Takashi Iwai wrote:
> > > > > On Tue, 14 Dec 2021 16:31:21 +0100,
> > > > > Mimi Zohar wrote:
> > > > > > 
> > > > > > Hi Takashi,
> > > > > > 
> > > > > > On Mon, 2021-12-13 at 17:11 +0100, Takashi Iwai wrote:
> > > > > > > Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
> > > > > > > defined only when CONFIG_IMA is set, and this makes the code calling
> > > > > > > those functions without CONFIG_IMA failing.  Although there is no such
> > > > > > > in-tree users, but the out-of-tree users already hit it.
> > > > > > > 
> > > > > > > Move the declaration and the dummy definition of those functions
> > > > > > > outside ifdef-CONFIG_IMA block for fixing the undefined symbols.
> > > > > > > 
> > > > > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > > > 
> > > > > > Before lockdown was upstreamed, we made sure that IMA and lockdown
> > > > > > could co-exist.  This patch makes the stub functions available even
> > > > > > when IMA is not configured.  Do the remaining downstream patches
> > > > > > require IMA to be disabled or can IMA co-exist?
> > > > > 
> > > > > I guess Joey (Cc'ed) can explain this better.  AFAIK, currently it's
> > > > > used in a part of MODSIGN stuff in SUSE kernels, and it's calling
> > > > > unconditionally this function for checking whether the system is with
> > > > > the Secure Boot or not.
> > > > >
> > > > 
> > > > Actually in downstream code, I used arch_ima_get_secureboot() in
> > > > load_uefi_certs() to prevent the mok be loaded when secure boot is
> > > > disabled. Because the security of MOK relies on secure boot.
> > > > 
> > > > The downstream code likes this:
> > > > 
> > > > /* the MOK and MOKx can not be trusted when secure boot is disabled */
> > > > -      if (!efi_enabled(EFI_SECURE_BOOT))
> > > > +      if (!arch_ima_get_secureboot())
> > > > 		return 0;
> > > > 
> > > > The old EFI_SECURE_BOOT bit can only be available on x86_64, so I switch
> > > > the code to to arch_ima_get_secureboot() for cross-architectures and sync
> > > > with upstream api.
> > > > 
> > > > The load_uefi.c depends on CONFIG_INTEGRITY but not CONFIG_IMA. So
> > > > load_uefi.c still be built when CONFIG_INTEGRITY=y and CONFIG_IMA=n.
> > > > Then "implicit declaration of function 'arch_ima_get_secureboot'" is
> > > > happened.
> > > 
> > > The existing upstream code doesn't require secureboot to load the
> > > MOK/MOKx keys.  Why is your change being made downstream?
> > >
> > Because the security of MOK relies on secure boot. When secure boot is
> > disabled, EFI firmware will not verify binary code. So arbitrary efi
> > binary code can modify MOK when rebooting.
> > 
> > When user disabled secure boot, a hacker can just replace shim.efi then
> > reboot for enrolling new MOK without any interactive. Or hacker can just
> > replace shim.efi and wait user to reboot their machine. A hacker's MOK can
> > also be enrolled by hacked shim. User can't perceive. 
> >  
> > > Are you aware of Eric Snowberg's "Enroll kernel keys thru MOK" patch
> > > set?  When INTEGRITY_MACHINE_KEYRING is enabled and new UEFI variables
> > > are enabled,  instead of loading the MOK keys onto the .platform
> > > keyring, they're loaded onto a new keyring name ".machine", which is
> > > linked to the secondary keyring.
> > > 
> > > Eric's patchset doesn't add a new check either to make sure secure boot
> > > is enabled before loading the MOK/MOKx keys.
> > >
> > 
> > Kernel doesn't know how was a MOK enrolled. Kernel can only detect the
> > state of secure boot. If kernel doesn't want to check the state of secure
> > boot before loading MOK, then user should understands that they can not disable
> > secure boot when using MOK. 
> 
> Thanks, Joey, for the detailed explained.  I was agreeing with you that
> MOK/MOKx keys should only be loaded when secure boot is enabled.  A
> better way for me to have phrased the questions would have been, why
> are you making this change downstream and not upstream?
>

I just sent patch. The patch may changes behavior of kernel functions who
used MOK/MOKx. We can discuss in that patch.

Thanks
Joey Lee

