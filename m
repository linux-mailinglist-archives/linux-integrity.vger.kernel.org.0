Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAB24A3DE
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 18:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHSQS5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 12:18:57 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3448 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSQSy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 12:18:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d50e00001>; Wed, 19 Aug 2020 09:18:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 09:18:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 09:18:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 16:18:49 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 16:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILCcqNB3WgnhVjIrINau36ONchGAX0KXxs9C0bJeUk0J3q9/FTD5udEmJ2sRNxbPhf2u3Zh+9ETaRwVS0jvA3oM4TQlFRg5grs21qGwHxJaE5Yf/OgjuXWhLEMFsj9vRucSa2gMq54GszgRSQVSpPSpfblHn1rPqHcvErU3Gt+1YN5lRuOxpI4rF6xpKuoj3+nypP7n3Zv0YsJfFcI3I7N59CgJJWcGsK3S1eBzj+2Po0JbUKosLn+da7ZVQB136YAbph3EWhsmd6accSBpqvBC0AGV6dE77c6zjNDD0rOk33cs4/UzX8N7wuxt5U3kDfpmGZv5xatPKP8ScOlbZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx+NhriIZ9oW1zBGJtr/0WgCYrq6rsHCeudTNNMvCPY=;
 b=THtM1O5YpQAaOWigeCafWBYwDIdY91OM/vvqV2jmrpYuStyNkm07hzKQfsbZ/S2WvUBSUTWkD8OhLBGXFAVGaJHHI02zQ1Du/T4TCqNm64lWSMd9hghpBZXlbIhr5+XoAMZ/8QnsnZ4joBYXy6fMqm3/fSkuQxWYsvUsvWQJVpQpVeT8XOfVo2rnSZVrUr/5M/bNc6dRDr6CtDBs6utGU9Mgzd+a8XGeZo+TLOfS90/CXJBPm/mbJf3gvhKftvUC5rTrQQQzgqRtNQAFqd195B+o4qSnMvYsUTQZAEbZMdMHgORQbpTp65qPohGqHBazVBjuXnwXHIX5tpaEKLVdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 16:18:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 16:18:48 +0000
Date:   Wed, 19 Aug 2020 13:18:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819161845.GK1152540@nvidia.com>
References: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597850231.3875.13.camel@HansenPartnership.com>
X-ClientProxiedBy: MN2PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:208:c0::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:c0::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.13 via Frontend Transport; Wed, 19 Aug 2020 16:18:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8QnV-0094p0-Pp; Wed, 19 Aug 2020 13:18:45 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d471449-9c23-4795-185d-08d8445b8d28
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB400907E64DD0484C09562793C25D0@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOIo+BoKAl0+yPHqO1UuulK2TvuRwcefUouy+gXDSft5I8FJ63RnXCd5B8IUDp3xa7M+AVUFpkGAAH82F06tGAFbJEAaJdw4uyJdaS5oRVKD/fYQyHeBKgwqHVHrITRnv0u3awxOz4EB071qG08FXa5tne3SzZbo0Y38qqpUcYE3WEoP/fVJ0BDAqIk0RFgMespa7f9HRuVrSFqwCdEvWsZkTAgWv0alPjkB1w77jMzpdo5D1YATSjsrL83nAyJjsNeYJrY1Nbab/et1YNhdUdadKyVnyJgd6OCgxfMFCmh+4+Q42wFWQW0bHC9+WQLBaL7MckGnlgdWWgNzIjcQUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(478600001)(36756003)(2616005)(316002)(1076003)(33656002)(426003)(5660300002)(83380400001)(2906002)(4326008)(66946007)(6916009)(8676002)(26005)(54906003)(8936002)(9746002)(86362001)(66556008)(66476007)(186003)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EtFsyt+YG3vXK0p6ceXHV15MSeAem2WjamF9zl0r+wSlmbmULfO7/nRFJdf3Rs4cMEB108giTUgZT2jd/REj6Kgum4QyfaWb6+h8gFgrAWjHwvPH/BBFVwMyHHLXVExD7QC7n1UlEcYI72Fj9B2KteWenA7Ku4j6a0KQRf69akSYD8b4G3pI7rU74jZc8h91Zw/ZHsHm26TQ/ZCXtKeoZnWLZAFxwssNw+t/xEEq1P+F/vKtvlp7KU2lKVjL9gCYzKOuqup2kZkD8QXuDGWygh9vlPNjjtq3derCe/HcALpB8TFjhK8inLqFJE5LEQ0NbzTZVvmVUY2x4J8WzaUYshMytk48zz3Nx00KaI6LBqj4RJb7GWShW/14LThPUd6zFfX6+Ys2lu8ohCwEFWP2tDBP+amJsj2JuYCaGHSFVaUP7eIATBf/R12xk8zmr1ObIOBY/plt/Q1jrrnCBqKj45SrRMoz0KT/m0RzRFX8TihKdHLv35vJV5iPCorpVS2xTZ8bPxT3DXXwLHKlW4H6L+iG2SHfyf+DQTViV0FZ9GTXkVx+cc/dd4wX5zoyGrttRCiI9re6DGZS6PZXgsgYhIxy3zCNHOb2KHlEJq+a0sC7XtSx65yze4Gw5ud0FovEC2yn3N88dai+dTGWvtzQ3g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d471449-9c23-4795-185d-08d8445b8d28
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 16:18:48.2048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUYBfF1HtiXgLex1PETcft3/hzvmM3dKiklPSF6KbDUqjxO72HZ+rMaO0gqN+0Sh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597853920; bh=Yx+NhriIZ9oW1zBGJtr/0WgCYrq6rsHCeudTNNMvCPY=;
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
        b=FYGuR2NgTicNOKCi1BSIp3zdhh5b4hIBTD6YcI0w6ei+2UPKD2EKSXIn7bfFZp0At
         2Yyhglr9tsQxjjVQccYOinNfR2AEYXWSIWuQ+9nVvgMvJuygbd5gxeN5svVGQCcwdi
         nFd/vOZ5fnYrOYXkfPa+CR4Ysne8th2fQCro8SVFffRgZp3PNsn7mgfAAWj5XC3buo
         qcKHpQ6BbxC95Oj9CWQwmM4CbMl+4s+zTbNDAcN8xQcKPrHWAKHSZx/2l8H2bPL7mO
         4KItpoONMFExLME5GHh3MPGC5wDmeblCPiS56QzHboxEqEpIIfdiVoYNDOiJZQEKZB
         l9JqLuwFogpXg==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 08:17:11AM -0700, James Bottomley wrote:
> On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> > 
> > > The problem is that there isn't just one single userspace library
> > > or application for reading PCRs.  So now not only is there the
> > > kernel "boot_aggregate" regression testing, but regression testing
> > > of the tool itself to support multiple methods of reading the PCRs.
> > 
> > I was thinking just open code 
> >   open("/dev/tpm")
> >   write(read_pcrs_cmd)
> 
> That's rather an over simplification.  The command takes a
> TPML_PCR_SELECTION structure which is, in turn, a packed array of
> TPMS_PCR_SELECTION which is a hash type and big endian packed bitmap.

Which is a fixed value, so at least the write is not a complete over
simplification, and this is a LTP where it is reasonable to directly
talk to the kernel.

Remember, the only reason we got here is because apparently there is
no sane single userspace library the LTP could use. Which seems crazy at
this point..

Your other reasons are more compelling, but they also sound like a
tool will be needed to do the other parts - and if we need a tool we
can't the tool read the PCRS progmatically too?

Especially if the tool has to parse log, call hashing functions and
unpack TPM keys already.

And to Mimi's other jab:

> "dysfunctional" is dropping existing TPM 1.2 sysfs support, which was
> done without consideration about existing applications/tools (e.g. ima-
> evm-utils, ltp) and without community input. 

Yes - it was dropped because TPM 2 was a *complete ABI break* for
everything. The kernel was reset to a uABI that matches current
uABI standards starting TPM 2.

The whole userspace needed to be redone anyhow, and certainly nobody
objected at the time.

At least my expecation was that a sensible userspace for TPM (for
administrator user) would be built, like we see in other subsystems eg
'ip' for netdev.

Jason
