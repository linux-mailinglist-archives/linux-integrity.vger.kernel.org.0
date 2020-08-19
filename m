Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D290024A161
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgHSOJ7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 10:09:59 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4889 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgHSOJx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 10:09:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d32740000>; Wed, 19 Aug 2020 07:08:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 07:09:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 07:09:50 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 14:09:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 14:09:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pu5NdFjoOkmsykvmNPjp8atuSZ3E7Ec9Zq3is4aj9iDsOPjUxl5rkClzduuJTRL8xTDYYKjwY//FXJ7JH1NnyXrt/KBrjDIT//cVltuf2wCKlwkzrIFrWVYJTqdz0g2wjCqh8r8UDD+LFfVhfzDNFY1Z3cjlq29xvYXhXgn8wYdvAn46v1k0eWpm9nOsAwE8T77NUeeL3dQAj5MnByGllL063clID6cRF19W21jq+b3Ba+1QeTuT81iczoonw6RL0Eaho7kM+kSi5s/CAC81g4cCFqPbOd7G3dKhR7tNMSmq+jkd3cv5PUPJZstlUrcH0i45ITUTWNrWa4xtJBM5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKLNcApHPHXO/GUKvn/TayupVGXkb2PS+gW8hjSW/Zk=;
 b=HwXiE+lRG/mfdBDAu24+bzr+cnMnNXvq12hF+rCQMWR+2qd8ayXUKZnTyGavxny4zBIA8DAMp9wbXwHPqlUGBobS1ZDOhNvnyxgDMFxz0LXwckw+k4dLHmIWJal4CvXOEU0cDg/N7JMlhrnNvINce55FYIvo+b6BhrENAB86D9a+OPcNnmLMab5Dc5xj3cDgEVefaaU2qxU6o7qQb6oviKJGCfZOiQ7D7e0oAb21mliCD9YoYT4CP+1ax4f4du4YP8AdOEZXkugfJts9fT1PgqYUde4N/DxgLBkXCIHk0oSx2Nfw2XO7gcEhUR4u6o+Tf6ZEqxH3jJjoOsmvqeNcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3017.namprd12.prod.outlook.com (2603:10b6:5:3e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 14:09:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 14:09:45 +0000
Date:   Wed, 19 Aug 2020 11:09:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819140943.GH1152540@nvidia.com>
References: <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <59f983156fed466d568c324de72ef733c1a15d76.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR02CA0061.namprd02.prod.outlook.com
 (2603:10b6:207:3d::38) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0061.namprd02.prod.outlook.com (2603:10b6:207:3d::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Wed, 19 Aug 2020 14:09:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8Omd-008xsP-Vz; Wed, 19 Aug 2020 11:09:44 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92f0600-28c7-4a19-5a45-08d84449868a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3017:
X-Microsoft-Antispam-PRVS: <DM6PR12MB301775695C2751844117B857C25D0@DM6PR12MB3017.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R71ZawGmSQsNq2LOFgx8vLwWJSzIRdvME6pr5i5rMUbC4I2ZWEhZmWD2764+x3eqfVXtA0mAG97zr0KDBJUDJ+2asFxwG9kupSfFy21LWD5ukzkjGS47b6N5CKOQpRvZrR/xvOwfUlkLVa6jO6XzeJWZy/D+He3N+UpxCtm0xPlplHxBZlcWdTrSnsHwWjor6XcJ28c1FhJPXV3SbcE/Fspf0K91jFx0u4+Z6YZHCB62+iHOajYUHZjhsXaB4Tjbe32x84Oty6dygMLK9GzYITylbTUJD9L1WiRFU6OfIOXU5JYwcLSZ7gDCjyxehxrBB1LK6pC051x3rLjHBeM7FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(66556008)(316002)(66476007)(66946007)(86362001)(426003)(36756003)(478600001)(2616005)(8676002)(9746002)(2906002)(26005)(54906003)(6916009)(5660300002)(8936002)(9786002)(1076003)(33656002)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VMD1HwRIylN9mqusnw+75KkQytpkHhFGV9uFruVTNWvUwAlo8JsEHG0wqk1Nii302bzEtQqPLBf6tyEJMJb4vonY7xGU9VarHPnlZQMkJWvihyduoETSnVjSFgCf0OeyNgNjt/QK0MIwTFVo9Kju933DbT8jEZwF9TsDa0cggQNfG2Uq9z+MNZncrwoJEwoFwsxKWR2JN8CaPAq0mVKEeBCQhuJ2xe/jnWITTal8nm+iv8phqMwUWkPi4wJBC5lLvE2o7FppHF2J3yrDSVI3d0yNDe6mN+YhirQFcCMxwzMag133SVix+Kf5WkQa44R6GkbhTBDHDfPC70WSCLMIKMF6nQTvUJwRUMd/VOrfc8jte1tRqX7VdXRedv3qN1Opa8OCn/+BRo9WPdwg+rhEC+V1v/YDpaa8PeRdFzlkzVy2xVPlh6WuGrGTt9nq0KjMgUvKROuOjac2jlXnr8+rpt/RUCt6E2kXwKLVBTdaYnAVOarLgxm6C6od0qClqcAIrDgqeaenVzfpNWDfhVptb2v9CSDazyGOURZKA9f2D+g0UAsKQVPBZe+SvDx+eZGMxFLXuEdE0npsGYcgH/F3v5tfA7uiWndwipwFmb7Ntv2xI4C900T1Mnxv1Vphw3oM11VZrIaKz+T1p9lSEAQmHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b92f0600-28c7-4a19-5a45-08d84449868a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:09:45.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c9vBhk/pa1lhBIg/ELonfgn75ryAhe7ntjWFc/vhYXQnnIhPyFtwPwAcwNWdTCky
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3017
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597846132; bh=aKLNcApHPHXO/GUKvn/TayupVGXkb2PS+gW8hjSW/Zk=;
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
        b=JrUQh3HSYU3wbuRtyioYLF2IpTOmA2XgxRASxCaO6gqpg3p+fv3z9KFssJj4rzxUA
         xut95jOjTyUVVpyVp6BeDXlRIcDSqd2gPLXMWTthSYShWPJ7Kk3jbKY8F6G6zvWq0n
         nI1O57l6JiHqv+OiGfw/+TbRZ2GrCOPO8HYGG1hKQP/01agWaa0gFLqZJHDM1DA+oa
         mW2adj2wwNoejsgzW3Mg9a3/JcfNSmRHu0+nfd5hmFeGIvV6s3dZ81PyxmBvkwBDmI
         LWH0WVbk6SDkqeLeY+3HWO2Ml4KDY8PsBEketatj42rZGX4VHNOk6z8dO+q9nfqdE4
         LF1GdUwtfvm4Q==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 19, 2020 at 09:27:33AM -0400, Mimi Zohar wrote:
> On Wed, 2020-08-19 at 09:02 -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:
> > 
> > > The problem is that there isn't just one single userspace library or
> > > application for reading PCRs.  So now not only is there the kernel
> > > "boot_aggregate" regression testing, but regression testing of the tool
> > > itself to support multiple methods of reading the PCRs.
> > 
> > I was thinking just open code 
> >   open("/dev/tpm")
> >   write(read_pcrs_cmd)
> >   read(read_pcrs_cmd)
> >  
> > It isn't particularly hard to retrive the PCRs, don't really need to
> > depend on a library.
> 
> Ok, do you want to contribute it to ima-evm-utils?  While you're at it,
> do you also have code to parse the TPM 2.0 event log that you could
> contribute?
> 
> Seriously, we shouldn't be (re-)writing code to do this.

The kernel should not be used a dumping ground to work around a
dysfunctional userspace either. :(

You've basicaly said you can't rely on a sane userspace library
because *reasons* so we need to dump stuff in the kernel instead.

It is not a good justification to add new uAPI.

James seems to have the same basic conclusion too, unfortunately.

Jason
