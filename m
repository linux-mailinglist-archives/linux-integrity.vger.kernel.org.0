Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F524A4C2
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHSRRq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 13:17:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4288 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHSRRP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 13:17:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d5e280000>; Wed, 19 Aug 2020 10:15:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 10:17:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 10:17:14 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 17:17:12 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 17:17:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzg2q9ETMJkPRxCrC5ncFHHFsX8q5fVYOGgboNW8IU7tW8LhbEwGsr8kRCHk7FFoID3LtYEhWjILJGjTXHecb0mASB1Ykntyllhz27SIz2nH+UtzTLCwUjuU/9BfaT0yQHyF+kwFgXj2sLaFliQuLrTbjc9jCVxaIcGHw4hFJswhM7xWNysAzqP+rsPD1FXgPxW1MBxMj7Kj/RS7vx13Rd6z+kRBsqhiqoipbbHTOia9fMw8I0hL1+xvMrD22O2U0P3XIFgv9oNuPsXQa3T1Hf02VFDpkAfXgkQLeq9p3YSwXkr2SwcYixDAG8yJmPstUPawfZAvfudPM5K6ysnPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d31qE8YcFDr/TopZ6PngSxjbAKQSIv+FYfFdlarpR20=;
 b=mWvCJcyduNsosU+rMcXnaNC8RyRZ/h/WU9szKqAIIoR4DGuX+4Qj552CFUjUYvEWHqxDByKAIigOhEBpsIh6/5LiGVerUt/zeZeiRx28CBrb//m73sL+qUuVie/Em5CXcGR8M+wGK+W1755nM27yQl9GO3QOdyM51uiVBuNtw/zS5iQjcy17MR6a5xR6Bf3PmhEG6TaOO6vBCf055iwpabqZjlpBYh8mHw8KT130MjPbrjTk5wt8K4YM89lAN/sOyluM7FhbMgsryQz/TmOxFRMi4zjBL9CCkWZvu0JT/DcZhPfeOjQVUAI0arFxpdPe4tm48ZU9jyXbghxIiZmk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3404.namprd12.prod.outlook.com (2603:10b6:5:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Wed, 19 Aug
 2020 17:17:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 17:17:11 +0000
Date:   Wed, 19 Aug 2020 14:17:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819171709.GN1152540@nvidia.com>
References: <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:c0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Wed, 19 Aug 2020 17:17:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8Ri1-0098no-Dp; Wed, 19 Aug 2020 14:17:09 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5ae4339-2036-4683-d84b-08d84463b554
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3404BDF2E20785B1B7380EEBC25D0@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9hZHxMWFtGeBUFLkbhC+v+HDv3WKMiBqk89VaCF1A4XHyU4PID/wWvQGRQLw8dNe6aqsd7x7yw0pAulilHiPEgVul8z+uyYgalz4q52TSBK3sAY2USjA23ytm8B3uK4vO5WmzRd1SMwy4wxD0SNlceGsszwUz10+B0AYE38F+4zACCfhTndtXnTu5pCRS9IgTmCwY8KgLRDVszegGwA7ib1hHL3V+Wcll813xBVvvQAxedcGueLexDErVCO1jXTyH/QCF8Nxkkjgj00PeU5McxwRs1YpqqtiFUShE0pzwa6gQRyqNfJeaRB+sxqA93VKaUVcDRPo4Mwz+cxtSTrn+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(86362001)(9786002)(54906003)(5660300002)(33656002)(2616005)(8936002)(83380400001)(6916009)(66946007)(36756003)(9746002)(2906002)(426003)(66556008)(1076003)(316002)(186003)(8676002)(66476007)(478600001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5T5h8uOnPcT3maZQkOtKr2Mxn8kKvX5HBBon87p/BHArhecXEJ3P/BQAbT9B2t7l2rjHBzbFEVOvVkLNv7rhgq33c7P1YLoNgsmvMJGWtGcjLevjj7W9uV1NOIED9LXozP0qxmfyLhQILaWfAEPSfwli3K4/z5A2FpgeHrXBCwjq5RqFZp0MOjel3hhGovSpgs2wVfWj2QYEE2lI+SSdXFTqWU+PZc/pW8wxtIOa2FKnnVCtagPJM4zIbkAl0BLloDzPXnW7FvrL3WK58t8ow2XmOsn90ZgmAdMcyzKHSLZemApsDiOvHi1niVnLpj/q8AwEfphrvS9NwY8TpU+E3aBpvYieuv4/T/5bx9jX9mQRML3yJhdxf1Y7dpDBsHLSNqG+3DM8RzKYyJaSdZATBFlZqqVhrqYqJyAcg8FlwTgPBcV4sO3M78RBK8qUSGB5YLSf1hd0i5HsCTS+APZ8A2A3yXhqwr5qxReRyOgAiebbBGIoDS8ieikCr85pvT5YE+5Mh1gKxbP06MD7QEStqlr0Pbr55xrcld/xcfP0W4mpWTLnCD1ZWwWm4m8fUx9pE3CjzKOU9GYoz+SN4EgwA6ur+ABXXxEE4jWWPXHfrefL0awVF3YwC9wV/NVswqCWNgaVjinNjrdDitsoy5aoFw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ae4339-2036-4683-d84b-08d84463b554
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 17:17:10.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywIdqcx158aOmYa88aWy5ohq8aR7vnym6LsmrZ+OdKZaBF1Vj0SAz8nEdmp+hswr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597857320; bh=d31qE8YcFDr/TopZ6PngSxjbAKQSIv+FYfFdlarpR20=;
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
        b=WmTsCmwZp5fxpMASEWVdbUSgXIXuKwgTxb4Tu0tFP0QjZHw56onddI/fxVeZgsTc1
         bk2NvidHRHZRsiFNXJIPTnQ4P4EtAK+rWnIcU8tcczDVgo/uFyBcPHCVGlTnR1Ev4m
         yJme0YP5E7I5/5GDtyCjuiPKNJ5LORzpe7EW5gN0dRXzcHpyiN2zn7qtOmr+9r/m0G
         199RGs9LMTPpaeGGXscIghd0+ImiKSgKwf6bFOH3Oe9EWHoyPXYxLuilXmi3E+ryKQ
         YT1KIf/DtE/8GwXnsIf3mPDyrtYRdI1NbgrIEJMaixTEO9fLhy3X5+YyEGQT33Y7Zn
         8KksfrSf018Aw==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 12:57:42PM -0400, Mimi Zohar wrote:
> On Wed, 2020-08-19 at 13:18 -0300, Jason Gunthorpe wrote:
> > Yes - it was dropped because TPM 2 was a *complete ABI break* for
> > everything. The kernel was reset to a uABI that matches current
> > uABI standards starting TPM 2.
> > 
> > The whole userspace needed to be redone anyhow, and certainly nobody
> > objected at the time.
> > 
> > At least my expecation was that a sensible userspace for TPM (for
> > administrator user) would be built, like we see in other subsystems eg
> > 'ip' for netdev.
> 
> "Because TPM 2 was a complete ABI break for everything" could be reason
> for upstreaming a minimal subset of functionality initially, which
> could be expanded over time.  I don't recall a discussion about limting
> features in the future.

All new uAPI additions need to pass the usual uAPI hurdles.

As James outlined, justify why the kernel must present a duplicated
uAPI between sysfs and /dev/tpm. 

There have been good reasons in the past, eg SCSI inquiry.

But there are also bad reasons like "our userpsace is dysfunctional
and can't make a library or tool".

Jason
