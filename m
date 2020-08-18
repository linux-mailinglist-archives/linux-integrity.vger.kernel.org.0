Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38404248E09
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHRSgQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 14:36:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1207 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHRSgI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 14:36:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c1f890001>; Tue, 18 Aug 2020 11:35:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:36:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 18 Aug 2020 11:36:07 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:36:06 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6lMkAgkv/yEddmxYYFxWp/maAdYB4IW5PPFPArCC9bTe+zA7OTKvFZkloo6UssqRbUFhA7OwGkF01tbYAIQ0928DJPDsIzCOTASEk6qKubkqbFABtrVjGk+CaEjq1zdzSPxkxLdJqpBgZRvmT50ajPp+4NahBc+78F+vLzomusz1so8IXGTDpJAF5nuh8GQoAJv9GwimZXw1+wyKJnsEpLbzmpgiLb/qr74dsDfTwpx6QqoJQybiNZyoq77H2QrRRuI7u4mmtwvMGPhNRaca4VkEhBd60caTr7/p/qEftfAZYtRnX3mOgzEHcFbhw/8jDpLaCDFxBU/x+eNm8s+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfFkRnaLwiO2n7xNvS12FArtF1cyZLLLzfFWLrX2mPU=;
 b=fnw+p5RoDhkOikzaxJ/HmtiEqIjdklCTR2o0ZF2oGLq3FpyY383X5DRYa1WZNvhAPQVEdJ4oKtls224s2HEOXcgYwv3D/vMfuNTBeHjvaZ5C234Frs+e+FJ/kJxlfwwd/XrUEeN4mK7XtCYu5uYfh8Myzn3yZaGMcW07bzhmwE6Fo/yuEKP5ZgUdkpW3twJePTioVBMQ7dyYOjW10couZN+hcFoLd+NWRjV42O5zDyM47DqBaCO7qQIcPQXtTkIAz8Vwx2BSoGKzaNCgXHq3264cjt75s2kiL1n6gANWv2CEqx5n/P5EoHf5vnFgGyPePb20toeXYyFjJV/oWbwQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 18:36:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:36:05 +0000
Date:   Tue, 18 Aug 2020 15:36:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200818183603.GC1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
X-ClientProxiedBy: MN2PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:208:23d::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR06CA0014.namprd06.prod.outlook.com (2603:10b6:208:23d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 18:36:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k86Sp-008ero-Tn; Tue, 18 Aug 2020 15:36:03 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f022c5a-66bb-4972-e1e3-08d843a590b0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241F9AC15EDD8D6F5248B20C25C0@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lP2PRkvV1uLw4fDGkbO6h5mIe5uSdvxr323DvL51/f4rGj+nUi5dAullDvXjv11h89rNkWQr44ODIZS64CdLkM/hwZ0LBICy4/sWUlSOxWnbmj7YteER64u2YSW+3bb9HdXriiNhWjPjyN68sLEUri7b/DvI3odWRB3wafLRryfGGskhrUAlmsK4ZVBRPa2158GcHJg/Dksoj+RcUQKQVeRVker3N0xB3kPkBt4+j7XUT3XKwxXgwu6EkFta2T2QcxizNFz6QGpCC6pZve1roWGVA861R2wPU0OtB1Z6AZclivnqhmjoeuqM2AphvPQfgQkExB/qqtktC4X7dHebMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(5660300002)(9746002)(316002)(66556008)(9786002)(2616005)(426003)(26005)(2906002)(478600001)(54906003)(8936002)(66946007)(66476007)(36756003)(6916009)(186003)(8676002)(1076003)(86362001)(83380400001)(33656002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: O7d4Nbjp/anajOVW7pHX9vymKLT2LSqF8VIYMNtkmPn0LOWJYm/fJCa5AJvq0XEgUnUf0bFVIWSlCyNqjiDdWMgILEvP+0vlV8mD/f3yQi6zLRGRhR66phkSgSu7hHteVV5n9q3MV6U0IABXYahujG5G1LGEAqlFykS/AqgFNeCmRXcxWFo7KwT+iuI2FmPDoEofNuh3+nEUUwijqGMsAIKfeJQA3Ydzc4/hsYL8hPSjxSY8JlUCuxO/ifXoikoGC+DE8xvDWs7AX0HxqYU8CYGUxoqnZ89n/+LjJeTL0hzQpW+cXQ5UNeULcW4j5S9FcumttZOLsW3hXZhTMm2o+VSCl7C8uLtDEW53hiaRkaigLv7y4pvhATPccv7ZTn2A3DnIlwRwCSf2X+zpm2as3A+xA99uV9wUyvHIvI2i7jvD1VhaX8Z9PeNt83ZJ/eHkJRWd5LXqdQXd7MRpaDkVN9zsvtV0g5KJZCVaqzMzH7yD0aNTW8Ux/23Mv64V82dj3kVe5l6z0U11zA2RPISb7J7BbHjionW7ljysjES6Hw9BNvUdXXYDx8EVBLKPDlRH68ps1YlOM93/REPFatBTU7l1KKzGCkUGcn2+H8xwugubYtYYJRdkzPkquZ+SwvRkOzyV5HCG2MRZmL5507CeFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f022c5a-66bb-4972-e1e3-08d843a590b0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:36:05.0610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CnnaDFkWHJ8aDig+LNvRdRCf0J6oJl+MYmGDoCHqnDtd8HV+CAAISDH1Z1JRIjhW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597775753; bh=cfFkRnaLwiO2n7xNvS12FArtF1cyZLLLzfFWLrX2mPU=;
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
        b=sAPiitpbOAky8+74c7KpsmSKLpOoo05zLvAMkL5Ixa5ty4TOFO3MJLaoAcwRrmB60
         Z5EKqUrzXVXjXkWMiR7A46momj/jN1qThbyPNgEO2ktQ67KcqE4nvq9OMM0FFDkeks
         EbeQDsobMz7Jsb9NkZUHFxkZk4+M9a4NgvulERNueqC9WW0V4/RDSbG5RYOlf1od2Y
         ALDv4BH8Pczb+wTundglGqlCTUxdcWHAaCgyr5Blfgr2AKIIOIpFTEdO221xQSxCjJ
         2jFqEuu7HhL6lV2lfTGGXMj/ocIzn/cHzleFLiLEW8gt4X0tBNITURgjh+yPia0A1/
         JJKCOq58+pUQw==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 02:26:04PM -0400, Mimi Zohar wrote:
> On Tue, 2020-08-18 at 13:46 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 07:26:30PM +0300, Jarkko Sakkinen wrote:
> > > On Tue, Aug 18, 2020 at 07:19:57PM +0300, Jarkko Sakkinen wrote:
> > > > On Tue, Aug 18, 2020 at 07:12:09PM +0300, Jarkko Sakkinen wrote:
> > > > > On Mon, Aug 17, 2020 at 02:35:06PM -0700, James Bottomley wrote:
> > > > > > Create sysfs per hash groups with 24 PCR files in them one group,
> > > > > > named pcr-<hash>, for each agile hash of the TPM.  The files are
> > > > > > plugged in to a PCR read function which is TPM version agnostic, so
> > > > > > this works also for TPM 1.2 but the hash is only sha1 in that case.
> > > > > > 
> > > > > > Note: the macros used to create the hashes emit spurious checkpatch
> > > > > > warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> > > > > > they'll break.
> > > > > > 
> > > > > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > > > > Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > > > > > Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> > > > > 
> > > > > I have hard time understanding why this is required.
> > > > > 
> > > > > You can grab the information through /dev/tpm0 just fine.
> > > > 
> > > > I just think it is principally wrong to add sysfs files if they don't
> > > > have any measurable value other than perhaps some convenience.
> > > > 
> > > > It is trival to write only a libc dependent program that outputs PCRs.
> > > > 
> > > > I think this is essentially an user space problem that is getting sorted
> > > > out with kernel code.
> > > 
> > > Jason, what do you make of this? I recall that it was you who I
> > > discussed with about this topic when TPM 2.0 support was first
> > > upstreamed.
> > 
> > TPM 2.0 broke all the userspace so it made sense to get rid of the
> > non-conforming sysfs files from TPM v1.x time as part of the userspace
> > API. That was the main reason to not continue forward with PCR in
> > userspace.
> > 
> > As far as doing it properly as this patch does.. I agree with you that
> > sysfs files should have some reason to be added, espcially if it
> > causes quite big code cost as this does. eg to drive a udev rule
> > decision.
> > 
> > Why is PCRs so special it needs to be in sysfs? What is userspace
> > going to do with this information?
> 
> The original IMA LTP "boot_aggregate" regression test is dependent on
> the exported TPM event log and PCRs.  Similar support is needed for TPM
> 2.0.  There isn't just a single userspace application for reading
> PCRs.  As soon as we add support for one userspace
> application,  support for the other applications is requested.  So
> instead of a having a simple regression test with a single method of
> reading PCRs, we're now required to support multiple userspace
> applications.

But this test already has a C program as part of the boot aggregate
test, why is it such a problem to use a C program to also read the
PCRs?

As Jarkko says it is not so hard

Jason
