Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA324A9E1
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 01:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgHSXVi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 19:21:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2935 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSXVg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 19:21:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3db3f20000>; Wed, 19 Aug 2020 16:21:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 16:21:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 16:21:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 23:21:35 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 23:21:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmZgcf+abVTTNaX8u2DKmI49nKIE3qiISUh+rbUAHTSciYTbHTg2LbIejPU3tkxd6eiS2F0F5oV/s5f7cNmvBMXSAQOSr08ljzfvwJtWz4nrCnbsXZBHUZ5q48vSgrU+zzxJNLCltA7l8+MrZCNd3fGyM58i3d8gdbhOkDa++ffO8XbHgArvGnCYmspc4bnN0jasikzqa1Py/UnScIhcW2LORr7L7OqfP7fZasXUTvkTD4mhwMS8ycPl+Gln1RLGDRgLcMZIAqK4mQ6r6OMdyCstiXWXaNc9fqJTLCT3AXsvgJd02g0EG9f87YdwLgzRnbxZKC85BvX35e/zj8bAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCcfcg92nDy75jzKjJV8kgkAtvQ80mESDinyranXAcI=;
 b=frI3RnQ05qk80uC98pOzqBvICrXcSyKRqsez8aHIByqItXwe04dU3T4zR4axMgCQKdTacj9Xjzf8OXVXr3G524agOwiwHgl9WzT1OvlLBiFSBeBNZbGO1cUfRbef4DF1gVmrnKbOY2Rjab/OiFZEyOAOL+7Dp0iNVkaJY+3HaBAvJ3MqyciSsnfjQq879Xhth32rTuEsA/6nfGhaiT230nV6CtfgtD8KlMrkMJxMi9uFRbgedOqEaQcJG3w0FG5oBet2vdNHVCBtxd17G7fTwD8hSAbORj+zuJA9j31Wb9PGKRubaLYHa1/PYS1PzE9qfVVRpGTT/ct/RZCz0P9fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0203.namprd12.prod.outlook.com (2603:10b6:4:56::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 23:21:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 23:21:34 +0000
Date:   Wed, 19 Aug 2020 20:21:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819232132.GT1152540@nvidia.com>
References: <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597867756.3875.39.camel@HansenPartnership.com>
X-ClientProxiedBy: BL0PR0102CA0062.prod.exchangelabs.com
 (2603:10b6:208:25::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 23:21:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8XOe-009Ts1-Dq; Wed, 19 Aug 2020 20:21:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c411642-f137-4265-0d50-08d844969cd5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0203:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0203DE78151529BB74C4C121C25D0@DM5PR1201MB0203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3glxZirlZRVsvpEqgETDKrggHdu36TSaG+eE+pVpPIIEo4JnTzSSqtN1ejYPYDZQOVSXxhc2Yv+u9feYY44rltew/3Gg3yy9YSj8w3YiOpPzvIE504zpsbiDSOQQwONcsVhMWRw279Be6J3fkB3CtoQtbJoLnaV8l0hZEkX1T7Zqh74jkvDUpqI4VGGc8b4H+JGK2HxXlN+i2PROr7uramIeIC1O57KUl2j1ByjD0snQ7iQmhB2LzXzpgYhs6fazfbqJWyVCV5Al5VofFkiX8vl+ow7QFAFRT91nbybL1oiZ4YcyLDtmTd7ZUfS5gVIZhumsVUlT8WCAC2i5yTak5auFhDQxEnSh8TgVJJc5aVacC52wDFjlCXlU9Mu37ApY2ZaqpmCLaVPkq7ysYN8b2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(966005)(478600001)(1076003)(54906003)(2616005)(36756003)(26005)(86362001)(186003)(316002)(15650500001)(9746002)(66476007)(66946007)(9786002)(5660300002)(8936002)(8676002)(6916009)(83380400001)(2906002)(33656002)(426003)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tWbNczKgpfn6W/mYSAA4x+V4j3m7sPTXS/4Oxe++KM5jLGeQNGPpoVn7APlrjL3wmqDpcq/hVA/j6qnwsUGn5J8CH4eG/ikjDbveXaxt//yzhH4K8xWCtkVRahtsc6NwHEeikQm/caS4Rn/UXUzrlAOEZ5ew7Nh+iBAwuidYdAl0Z9kKQawM6sX9VuG+QnLsZKIDbMCmRVmJW1EzaI+tPHvb7Qrv796D+EQEj/gOPJ85mm/yNVe5UG3raB++tOpvlRat4r8lYTorl7lxLmyLUP+XnBG0pE2rkby6Hrjvr5q1nqk4XE7CBhoHK/DB1s49qa/XKdTTmgMGgoqr/pYTqJf6vr9xDuga3oozNYqCTQxC6pJGpfOntBScQ8FiJ2rLTzWnjs6fzWwCy/YNYZlkIGdUEO69Dbby+V/iKtxCoo6A5xuYQW64+5JZlSeSawQILEnYHHWEFdPKFf9Hj2rDrNQL7vudUNfB7UK/fZ6GcEufPG2HoB5xXageHeamnqwHPQVAu8ReOkf5vm1/p3UJMfPv9O6s4lEcmnqIkWnYzdoqj+brtK+0bymv5HSJubyRYgAZ4/CComvTGCkFBhhJB4CjD11xcRShhLhg+oNQfItGSQCL31Xeb4yoa1No2Itw9/iKry+erp0kyscqYPnI4A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c411642-f137-4265-0d50-08d844969cd5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 23:21:34.1955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcFKLSG+Qkb67uIkKhlOq+qryP0t9rzgACTnbG7z+c+EUhWdQs90NOUM1/HpUPo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0203
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597879282; bh=ZCcfcg92nDy75jzKjJV8kgkAtvQ80mESDinyranXAcI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=n/CKDaFFI1D2X+aqyIUFJf2hxisBvEgBZIX4ZCCf1BY40eirbtXq3ciGoyOfz1mtK
         H6gyXeAvn15oldfhNgv8u8BGoLkrBuRkLvgo9JdD1jWNcTHzhUCADxD8NQ8fWdwcg8
         zBV73rMGjEq3NPIafrlZrDL9e3o1uepwWIAcnDevIdbvy+e8ZFVTE+iuyzrXP7QDs8
         Xerc4vcuQ3mrKiW0BUvuvI3iQdYFGj+Y+FnEyXGNbjTgOziqbD+nmDZ9DLhhzt3plx
         1bNoBViBrUelgnir/9x4iQPHZw0lSfJhcduIPOjsTFOmCcgpKm/HD+BrQdOcMXokid
         FIUmYXNcAbQGQ==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 01:09:16PM -0700, James Bottomley wrote:
> On Wed, 2020-08-19 at 14:17 -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 19, 2020 at 12:57:42PM -0400, Mimi Zohar wrote:
> > > On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> > > > Yes - it was dropped because TPM 2 was a *complete ABI break* for
> > > > everything. The kernel was reset to a uABI that matches current
> > > > uABI standards starting TPM 2.
> > > > 
> > > > The whole userspace needed to be redone anyhow, and certainly
> > > > nobody objected at the time.
> > > > 
> > > > At least my expecation was that a sensible userspace for TPM (for
> > > > administrator user) would be built, like we see in other
> > > > subsystems eg 'ip' for netdev.
> > > 
> > > "Because TPM 2 was a complete ABI break for everything" could be
> > > reason for upstreaming a minimal subset of functionality initially,
> > > which could be expanded over time.  I don't recall a discussion
> > > about limting features in the future.
> > 
> > All new uAPI additions need to pass the usual uAPI hurdles.
> > 
> > As James outlined, justify why the kernel must present a duplicated
> > uAPI between sysfs and /dev/tpm. 
> > 
> > There have been good reasons in the past, eg SCSI inquiry.
> 
> First, can we please agree /dev/tpm does not substitute as a "duplicate
> API". 

Er? Huh? How so?

> I can now clarify the objection into "it's a binary marshalled
> interface and Linus doesn't think we should force users to use them":
> 
> https://lore.kernel.org/linux-api/CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com/

I'm not sure which part of that you want to quote?

"It's great for well-specified wire protocols." which is describing
/dev/tpm - it has a multivendor standards body.

Bit puzzled about the rest of this message? Do you think Linus belives
netlink should have been implemented as ASCII? JSON parser in the
kernel maybe? Confusing.

> Perhaps we should also simply copy linux-api and accept the judgment of
> the experts on whether we should expose PCRs via sysfs.

Well, AFAIK, for a long time now the mantra has been "if it can be
done in userspace then it should not be in the kernel" ..

I would really like to see a better reason for this - one that doesn't
boil down to it being 'too hard' to write a bit of code in userspace.

eg we can't do it because we can't access /dev/tpm for permissions or
something.

> The reason we provide a kernel interface instead of a library or tool
> is that libraries and tools tend to be domain specific and the
> information needs to be provided across domains.  So: both the current
> TPM 2.0 TSSs are written in C.  This means they can just about be
> plugged into python but not easily into Go because of its abhorrence of
> ffis.  Providing the PCRs from sysfs allows Go attestation easy access
> that the TSS tools don't because of the language domain problem.

I went to try to make a python implementation.. After about 10mins I
came up with this approximate thing:

 select = struct.pack(">BBB", 1, 0, 0) # PCR 1
 pcrread_in = struct.pack(">IHB", 1, TPM2_ALG_SHA1, len(select)) + select
 msg = struct.pack(">HII", TPM2_ST_NO_SESSIONS, 10 + len(pcrread_in), TPM2_CC_PCR_READ) + pcrread_in

 with open("/dev/tpm","wb") as tpm:
    tpm.write(msg)
    resp = tpm.read(msg)

 tag, length, return_code = struct.unpack(">HII",res[:10])
 if not return_code:
    raise Error()

 return res[10+20:] # digest

Which is hopefully quite close to being something working - at least
it looks fairly close to what the kernel implementation does.

Fortunately no Phd was required! I think Go would be about similar,
right?

Jason
