Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5D7249D39
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Aug 2020 14:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgHSMDJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Aug 2020 08:03:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2483 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgHSMCo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Aug 2020 08:02:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d14a90004>; Wed, 19 Aug 2020 05:01:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 05:02:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 05:02:44 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 12:02:42 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 19 Aug 2020 12:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPXRV+i33OtJbvGl1HBrkq4Hy5EFBcmaO4aij+NSdH0skS6rOH/9vFuRRds9VmvH87WNi+Q45sdWOvGkW+DEWG6IwzwvQXiEbnRBqJWvWzGTjZ4rM9etNYk5mu7S+5UvFyp8HPbe9MqbEUE493GGxE4kuiNNYpsvt5Hwj7LsvNRZAU9bqBFknchYyhlRcvVGjdFc5kSOooRbclk2MyUIW+mRyjQAIChQZu7mraPCM6Q7vpToO4MbQJ2snpqTBPtmM4X9CMQmJPPzwfSMOWLOmV/h1cQnHQVJ5M0+anLKFgCNfMdsQijvzI4ju7uTJwykM98CJldoEv2703A/hP1FYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jegzxGOWWxku1BEfK7d5OdkiiOoj0AUn98nARCxu1eo=;
 b=XDUOzPkD2aGp62TM8WUF49nhw8DBTSz154691P4/Us7SuY3ZbFLyWDAU0ffiV7ZN1XwprdTY+stdDsov03IdflNkVLg7Qql9MZkJrzKlXLsa1ufBA7zrpsVfK2lk45zUFkUm09f6mEvXHEBx5NmPKRPQzeX/qsYJX/87752tqReYiqLdbjTx3LKGSeSX3MLYQqhClLfTXxC9hecjflTlVIYKr18bv0ZlZqZQ3shH6hc193FiHJyKklAI+m9yyu5V/1JWxrvMMW2hr9gvF50JHVeeOWiEK43V+u6A/UtKNr5UKR+bBX6ZSbEMKaE27TpW1vqn881fC0S4b2bC8/yysA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1515.namprd12.prod.outlook.com (2603:10b6:4:6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Wed, 19 Aug 2020 12:02:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Wed, 19 Aug 2020
 12:02:40 +0000
Date:   Wed, 19 Aug 2020 09:02:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200819120238.GD1152540@nvidia.com>
References: <20200817213506.4474-1-James.Bottomley@HansenPartnership.com>
 <20200817213506.4474-2-James.Bottomley@HansenPartnership.com>
 <20200818161207.GC137138@linux.intel.com>
 <20200818161955.GD137138@linux.intel.com>
 <20200818162630.GE137138@linux.intel.com>
 <20200818164602.GZ1152540@nvidia.com>
 <39eb6b408e7f060ab241954102d06f97d1f99611.camel@linux.ibm.com>
 <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
X-ClientProxiedBy: BL0PR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:207:3d::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 12:02:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8Mne-008vqv-Ir; Wed, 19 Aug 2020 09:02:38 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44a41b29-6a51-4d5b-228f-08d84437c5e5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1515:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15157C3D5A4AC88CA558E7F1C25D0@DM5PR12MB1515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /l3y6HNu78Gx2hfhPiaKItXzubCD0GV0QNUfv9W2S88eJC7IxvU2f/n+ae9boNuNPLUibOYPD72iNoO6JZeUwsusG2oDV6oQVjWenGkluJqLJczm6svejvgVcofJbeKVlLSsWLCTBk8l8VoSGZkCStVSzyfCvOUJuO3HvhpbWXqyD+chS9Qb2r+LdSdTW28QJRO4RczuL0fBPk2HbEcEM3OFHgl0Tz+86isIorYp2Ivyflxoi3PPco7buEF0xxCMm8FudaPtpYGVxpiikn51K51e/Qjfr/XD/Xc4lU+Zt/zFUghNGGx1s96fvClB94hbj3vDzhatdSWgiXcjYWY3FQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(9746002)(4744005)(8936002)(54906003)(8676002)(9786002)(2616005)(1076003)(6916009)(2906002)(186003)(26005)(426003)(478600001)(86362001)(4326008)(66556008)(316002)(66946007)(36756003)(66476007)(33656002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mUfoYMkhRdaB4yGc2knQHYGJ8JbEujpVzgqcHROjWnaNoaF6eDF+TWnZ99dr9uNxU5Cyl3YvMABGS7eKAeBEJWytTBeDy5ymeLOhmye43yC7A73Dw9FQe+FvXcAupwO/87diiazR6F7Gk85KDA/acBrrBZ2ywqedIpjmylKXoYb6naRXFaprPzZaiR3Q4PgYreB7+CEHPv1I6NYBLAsSwM4NE03jZlKk0zkAJSTpArbh/VCp92XI+AJzLff43H7lNSTTaqBxksdaTgL1ABT+rSzz56+kxyvFvN+gMKe3LmI0lAfuMW1hgq1nsNz6ao8mcqQMqkOJv9OCqoDy3QBWB9VhCu+iXbx9VtYUSzOHIL7NtfSWc63YFtIbVSLZycNHJugQSGUFwDDBT08mcK1aN1qUfPAUxy2gRgs03PSii8Tdktwfqed1F07m6Q544c9sJlTiG2rg00OzC1UuUTU4eFtslRKnimtNEOcthn87Cx7sZwhsev/qf5Nb9WuBKLcrwV/1mF1unOKDqNCbZP6X/qGb7GIQVkbpHKOLBlt2AoKgzGdcEE7hTM6awPjqVTc0Jg5PVjPkjkI3f+BPnSs2Oc+HYuFTlu1eRhSyZYk8HN5T4jRs1TH8Lcqq41Y3e8Idl4dFGDJVMpX+5I5XM+03+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a41b29-6a51-4d5b-228f-08d84437c5e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 12:02:40.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4/6rpEW9Vf4pG3HnlYPQ7wmAjJ3VIuEl5mACa1xUuZL3khfcxT9vnMddzD3hL/k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1515
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597838505; bh=jegzxGOWWxku1BEfK7d5OdkiiOoj0AUn98nARCxu1eo=;
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
        b=Kl7vuVp/YEELePjNxZ5BK1fDe4mEolFnDFo+Zzb/IHtaSzjuDDjuuBnI4iqQvTrtF
         mh1X7hnU17feMCF84Xn9tg6pmRMJd1a2nQSFndokBacITCUs9piEnrzCR3dWdfkzcn
         H0SyelSAUm4ltGi5Vh0ELijXBco4BI3taBltdL8QVyZbRq5LujDoSysQ32lU0nX53I
         w+mn/OSgj8UKu8LvB2hUuu5hmzjHd+y02dCB0mSgVqhZ8WgdkQeBNGJNfU51iw4geJ
         zjnfkc/RsLnrm8iZjNlzGFRaBYprKMwRnnyAqmOGRHTCNC/PQsQndksFjkUkooIcaS
         sP9o0GNkQrrjg==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 02:55:50PM -0400, Mimi Zohar wrote:

> The problem is that there isn't just one single userspace library or
> application for reading PCRs.  So now not only is there the kernel
> "boot_aggregate" regression testing, but regression testing of the tool
> itself to support multiple methods of reading the PCRs.

I was thinking just open code 
  open("/dev/tpm")
  write(read_pcrs_cmd)
  read(read_pcrs_cmd)
 
It isn't particularly hard to retrive the PCRs, don't really need to
depend on a library.

Jason
