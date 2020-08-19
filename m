Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2DE24A9E8
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 01:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHSX0X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 19:26:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15485 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSX0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:21 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3db4e20000>; Wed, 19 Aug 2020 16:25:22 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 16:26:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Aug 2020 16:26:21 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 23:26:18 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 23:26:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HASxqlFLPdnweygkxDpJcdeGErOFtcrHc4W4gks/3VL0GSJS85IJMwNvKVzhijow9tbOZAUgdOTOTijFDbUktZib+p7lPoMHuC81Gzdq6pXkWiX/aMMOGhfmkX5HaNsqY3ilhjLOGHzLC1aEXbbKzoyvxDj+/ADpGz7oNCY1FvpIjBThiwdQj/XsWzaeqHeoydybkRduj7Tv2sxPxzeVZyV9v1Vbkq4waYUbwa9UKdNWFxNiBEjRpkz6qCiFY72x2+Zxh98di2AB02kYBrRJK1+n+VrBtMjON0cboKorv2gCU0Ds7MLE6VphNax28erj4jZpJN9wiFmAJcW1TKMkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vJNNPhP73s+tHJcC7R1zw85khcW8F+4bSJcM6o5TSw=;
 b=joXDQ1xBuVXzXb1Kn1vlclw2+jY5cE6tmTdJ76bkFMtMDM46w7CYfsUH9F6m48aMGkTXIg2qSQ9JvLb68AQj/+LblznT4A4V4cah6sk9qZyApUlGiDPR/Vrv37hWx4KQ+qxtDJkFRkrDzgI0bfN4Yi74MIZgpOkU97cxD1ekmslq//FrR38+hUUYsr3ScTeBbxy5Gllrgu4gELffEcUCSz5rfoehxwSMY4XKyvHSCyltC9ZNissHLIxcB0iheUiEAZRWKEjxYPFq2Q2tV23BRL31kLg8c1Qp6KhRih38SGTBb9NjB3orHWKeraqdMuFzfLcj2fg7UY9p+U0/a0YGNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 23:26:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 23:26:16 +0000
Date:   Wed, 19 Aug 2020 20:26:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819232615.GU1152540@nvidia.com>
References: <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
 <20200819140943.GH1152540@nvidia.com>
 <e33cca9a33a151cf35f12aca9dfd42378d632322.camel@linux.ibm.com>
 <20200819221647.GN9942@linux.intel.com>
 <87lfiamevo.fsf@jsnitsel.users.ipa.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87lfiamevo.fsf@jsnitsel.users.ipa.redhat.com>
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 23:26:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8XTD-009TwI-9A; Wed, 19 Aug 2020 20:26:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 215ca7eb-e61e-4ff8-f9a3-08d844974510
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2439AEADB1FC77A9D2B41EA8C25D0@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdblKeRQz8N3sAunCdF8raVNWZIJYgsUcnx9EvuwcUSpLQO8kMbEi8BQGWgAIGB0pFQzTyxD3P1joikHBtXDAsTl2ARI9rkgYtyuRhSVO6OqQuevyxMVpFRdOMpDrbgRqrtGIYVo431bRaAOFfp93EHOxYuV8P2caPC+RWXF9wMd01rJemMhUa1kQm4hkP4JreptQ9IeZ89t/dU7URQGpQsxm3mgQ2IUyImTr5cBls9vn7z2pMlpXlII/QSGwqgTWcKNBVDZvx31lTa910urojKTxWgtPlwXBRPIrHRr0RQX4HuNPllJEMKKaXfy5+5Re8CZPaBxjRHwEh9O7Le0Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(33656002)(6916009)(2906002)(186003)(8676002)(83380400001)(426003)(26005)(4744005)(36756003)(86362001)(66946007)(316002)(66476007)(66556008)(8936002)(9746002)(2616005)(9786002)(478600001)(4326008)(54906003)(1076003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4pGgIb8U+LBOGfgTKOWE1QUz+69zALp4S5oi7GakmZ/tZZ/9jO0RIyJAlh2ELiD4SfFRVmuow+VBF7r7TOqChVnopgm2Owj5pLvyGR9Ykj28nsQnGQb9R4x0xG2AGgEWZtcJoBxexffasbdb/cH/xON7MAd1ENL76ToASRZycBW0xkNzZ2ScM81mDOH1C1RlgBQYk/3UYK2765O4OJ9EEjczRwPfWyly3lrzePmM24CbNwLv4rafH0geI889z++MKsxAAAdiAi6gieA2HEmKAQXH7llG64FYti71BoXnCpR50swn9+BqAa3/oYy3kE89kv1QYQ/VsFcoGmK6AUzAWizvY3iCZzTkAaPvxcgVPKUgyekXbsn4vcXXIKNhuJISOhg9H3tizpX/1k8sxARTXrYRtcSAdW6YHn/vZWJ5jJndqI5mvPJsG7rZKfOoOhi82Z6SbeWJPmzphjl7KzN1tNLBiGcOjxsW9uoaOdzwXk8+jthzr8mUYRtqckus2un9O8u7nTZvzxdfICS2zZlScOILJpdWCzS/r6T/BjrIFbU7x5DF2K7cKkvjb3NvjvOiR9kg4Ex93xR4eI5UCFIQXcthjoK47Inn7+tSOlP6PPENM3ur2KYXCnhsYi74CovREUQCImUUBdD4BQ4xiUV8nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 215ca7eb-e61e-4ff8-f9a3-08d844974510
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 23:26:16.5564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +CQBGhZd+Z0F/MDAHS7Rp4dlH8W+VtF8H3aZxrSRSHP9X0Q7SdN4Aj8KshxK4gKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597879522; bh=/vJNNPhP73s+tHJcC7R1zw85khcW8F+4bSJcM6o5TSw=;
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
        b=EFe3pw78LBpgMgjHeCJK5rVXcuj1Lwjl1cBn0/dnnD99qb1VoTkUGGv02urtpk3MG
         oemUQeO59ZoqwZvEtwEvMi0atrZeGdGJnOA/gn4vqQSPHUbeAnuTC+64nQj+EErqIl
         A9RsKseyOQ+rm+IArEOqlxZATdHN9qoOHLAUyXTN0dQvzMu7vZf/hepyvzdKM2j2YO
         HqBMrb/ReSpzCP+Oox2WhAif91+SCNaJ0Q5NhngAJrlbU8vxsJu81f8bPsOmeFOoYM
         EqWF63S1mLdG85LY8rz3hW/HkDpCD6T5fCT6pAVPuu8rSglMuD0SwNEyqqkdhQgKeu
         UVvzejO2JZOgA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 03:48:11PM -0700, Jerry Snitselaar wrote:

> I guess the question is where does the line get drawn. My exporting the
> major version of the tpm probably could've been handled instead with a
> pr_info spitting it out for people to grab out of dmesg.

FWIW, I did feel the tpm_version could be detected from the /dev/tpm
as well. However the small size of kernel code, the general early boot
argument, udev (eg only start the TPM2 daemons on a TPM2 system), and
something like how INQUIRY is used by reporting tools, made it seem
OK.

Jason
