Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AE4248BE1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgHRQqM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:46:12 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3615 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHRQqK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 12:46:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c05c40001>; Tue, 18 Aug 2020 09:45:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 09:46:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 09:46:10 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 16:46:05 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 16:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0ZMZ9NM8gmSGIW8IayAZXHQYCHraBjoAKVT8T5FrbGcQ6forRRWp15xA53q8yg0NB4a4fiFU6kbm9iH1xHQVtBC/Lf7a+9qYJhRFOCNpcvJ28DcIV81WN/S0oF6pQYA1omtCsyGR4AL9Wavpqx2+f7TWZg/N6TaaLqd+GmV2exUUGsj+lIKWinIP6LWd9byqE6wPlQPXNlBdoVHeVi5BkhHGQiu7mg6a7k3vW+rdNZ+9Bbif4l9N9LZ726gYpq3bWg5D8GKm+4Fmol+NlaaSqDY+/fV4p4PInrft9GCQowOF/CmbexFEvPSoTl9MS97NuuJHHBRBSIwjtOwek9fpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeymJ2NXWtkin5gCl4fPPNzUVPBTYha8VTgKK4mVj80=;
 b=GEuFifbLT2sO0TqOPbgb9PR24bDugVRLhzxinNySyk8a8zcJGVyhct4tDrd5iDfa2T39MC1nq32L/WpnJjagVGrjj24bUxfy+TDC35bRUQQ+eh7GAwgFKjgGlP5gWD+5u6BQV9GxuqaFb4RfLRpOGDU4g8OLkd0+IYgfqTFsqUn5b3jfCIj/IpLbtR7G4EPL2eSEZzRtuyLVkkVTc5migYiuzN1oYN0HZiRuxSoH+gK/FtZkfsUZrcc3DVPYZJv/w4Hx8zowqEFMOGOvGabmiUa9o96cwHVlGWDibKBmKm57u8upFkCurddPlbQvcVPIde0WuZcHuKWLUClsy1NQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Tue, 18 Aug
 2020 16:46:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:46:04 +0000
Date:   Tue, 18 Aug 2020 13:46:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200818164602.GZ1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200818162630.GE137138@linux.intel.com>
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0026.namprd08.prod.outlook.com (2603:10b6:208:239::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 16:46:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k84kM-008ViD-Dq; Tue, 18 Aug 2020 13:46:02 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8a1cf3a-e59e-44d0-69e4-08d84396320f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44971A849E359605881AF384C25C0@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9510To4wa6i6gRUdDbQtlHjIo2Z+/QglymBdsLbKNS4sj0BoqhMLJuZzoZCPbXPriecXaeoec27e06S6M3C95IoEmTUXgtBETVgmIKMI2Q8AqtEhTZkdvyDDQJvRR92ZNDBLu2lhZZv5kVhDTe/ai3yExq+BBRhIr3Bx2/4DJGGj5aIZ2G7qbyuVE4LuvCrj+xCLi5QAW4jGW5FwCTcT0r535dw+ZNco3lzw7Cf9sF3ovP8xGqJfXYpSn09OLAovvlqkY7TJ5yMi5WhZNuU/zh3+TPWbdRVcYi8aQDKz+5LK4t/LWwdOTBTJszAxyQCAPtJOq1MdzHKqps/XSABGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(66476007)(9786002)(2906002)(36756003)(1076003)(33656002)(83380400001)(6916009)(2616005)(9746002)(316002)(5660300002)(478600001)(66556008)(186003)(426003)(8936002)(8676002)(26005)(4326008)(86362001)(54906003)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qQx8x2ggX1dkiaAGrbF1cpcHBZG2Y17F3bRHWgG9Jpi0HzOH3DrPSPYx1e8Ftn24O/S2LWSu8oS1+rA/QOr/kiGmRHsc7EqApUmrkwwWsrXnZID4fy82+ft+DDnxvbJ3o95F5GmNf7jdlFZdoh7n3hLSU4dafPzGuAckdY7CG0uVGZJtUb902v7z67zzeNNW2gTpl4M+p4vf7Z2RISNc+Ka8tJgJw2L24gydZn+T/Ld6Cudm/o9pyLrgGxC5H64kTRZysv+4XLD/DmH6qymsZoUi/7W9AhL50geGvY0HWzjBFPjd48/kdhvmslnXKYbPo9DRCaRBWW4bH3yYjaQAWmE4O+GR1kHtPyzT5t8/f80p3hrw3F18PIMx2ioWUoF4U6g39h1wKa3SqJcSzkwsDkRyktlbKMHOAtT+bPDKCv0BO6GKuqnoNkpDGf3oLudrLserhX409KOTAHPzngVR1x5//s325sdVPSEmge58Pc98UBuZ9PGM44rKF0+1d3GxfoShiIP8qCIRqf7csdzAzEDQ5AqIw5PWLDfli3q7NmtcTrADQKUXr+dhn33OU8G+0iwfIpJmbGCZ947KOlcKi3szXOrxepaBFseI9L0K5e/XS5oXM1ByOTeD1x9GQk0yYfHNr/tLc/WXLAOrJDz9EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a1cf3a-e59e-44d0-69e4-08d84396320f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:46:03.8730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLjaqKUqJucs2nyQBOh5bB6844RtckOldkyCnGqZJ+V7vWG8oe2wKSX1JQi4Dq9I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597769156; bh=UeymJ2NXWtkin5gCl4fPPNzUVPBTYha8VTgKK4mVj80=;
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
        b=QCyI8QEnt1wFwAZ44O8QvwQ8RO4Qy1+41YOn7hg54jG0mk2f8s+bBqxLEu8NrR4/q
         bvS3J/iCPNc38VIvx2Y38Mw4V6Jfsd6z60hGp0thoMMBP9V1Mb14e0WUIJLeG1Km/K
         b03q2mnrmAP3wvo+jWa8BKV1tpp1rpDME+fzpQwnWaYAYBHr7AY9RnyD2UbTmcKLhp
         EiX2+9irPb9YGzqg3vGHtjtvpGlbAZx/QnqKrhzfv9asSGs5V6YTiVYe1orgrKuvKs
         E5WwSUG9EgxrtOcQnMjJuYzOfcEK5Oe1yfswz/dv3EUkryPTuPWwbZHRBDdMgz9ZSs
         YkoqWa6GvewHA==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > plugged in to a PCR read function which is TPM version agnostic, so
> > > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > > 
> > > > Note: the macros used to create the hashes emit spurious checkpatch
> > > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > > they'll break.
> > > > 
> > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > 
> > > I have hard time understanding why this is required.
> > > 
> > > You can grab the information through /dev/tpm0 just fine.
> > 
> > I just think it is principally wrong to add sysfs files if they don't
> > have any measurable value other than perhaps some convenience.
> > 
> > It is trival to write only a libc dependent program that outputs PCRs.
> > 
> > I think this is essentially an user space problem that is getting sorted
> > out with kernel code.
> 
> Jason, what do you make of this? I recall that it was you who I
> discussed with about this topic when TPM 2.0 support was first
> upstreamed.

TPM 2.0 broke all the userspace so it made sense to get rid of the
non-conforming sysfs files from TPM v1.x time as part of the userspace
API. That was the main reason to not continue forward with PCR in
userspace.

As far as doing it properly as this patch does.. I agree with you that
sysfs files should have some reason to be added, espcially if it
causes quite big code cost as this does. eg to drive a udev rule
decision.

Why is PCRs so special it needs to be in sysfs? What is userspace
going to do with this information?

Jason
