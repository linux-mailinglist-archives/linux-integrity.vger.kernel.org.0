Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA20C250B37
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 23:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHXV5S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 17:57:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:28370 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXV5R (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 17:57:17 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4437ba0000>; Tue, 25 Aug 2020 05:57:14 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 14:57:14 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Mon, 24 Aug 2020 14:57:14 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 21:57:09 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 21:57:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZTLJjFlixMD9MwSfohHSk4mHHB/9EUYgNMTotXcb/CTTqvNIqpZ+OqT58fbUdgQHDPL5yqGdTP/8H71Ish6Hiq61GBvJUB4HywhOs6TqznQxPBbCieBw7TpSQA5J+2f8c3veLWFo+2j/a+VGse+3ko5Q3AbuZTotoCzzRyMyMuAgN3lEArTQDbJQM/e9lk6IT8mC/1iXf8zSXMRcD4miSOnXw0AUSChLi1Bt+rzWQw9qr7+MZYt9S4KbUIVMhKYElxYrXF7GOs8K2vdoiZAL9AqGlNz0yDmPykEXlCmRhO2LQPhR5v938qIkzMWXshxZDBX4fU7RAfpOOOi+USLJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL3PN0UUjPdejE+Z8e81WUgEts3khK5BurfDN3FN1Ec=;
 b=Es4dR5ELvv/bu0d6C3o6EI21FJVcFmhz/kI0DLYvzbXGSKVkYrEZ3tZ2xGs/Ll6CVTsxm19NB+0Y0YI7cYbqskOuMAMEk7wP7tZHrcYlK2XflviiiQWbOV2Fx9l0kUmr++YMo7gdQ9BTucmldLJrOM7sXdNcm5S0xQy3KD5s1z1CNQqEqS4cGRUPFVsXM2bo4fJA71ayVGsuzAZcG5gxRuonPdWxAzOomsZJycbCtAibnQWd5fTSyPweOCSi/g20y744GwjMcB5/Da9g1H7YZTd/rS9YIAzMek+vl5x5eiEAX0F2dPAIQ/DRFqA+WON909aua6pa3bTXDOV8669laQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 21:57:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 21:57:06 +0000
Date:   Mon, 24 Aug 2020 18:57:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200824215705.GN1152540@nvidia.com>
References: <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
 <20200821193847.GA2811093@nvidia.com> <20200824194457.GA7391@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824194457.GA7391@linux.intel.com>
X-ClientProxiedBy: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR0102CA0020.prod.exchangelabs.com (2603:10b6:207:18::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 21:57:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAKSf-00E07i-5A; Mon, 24 Aug 2020 18:57:05 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4894c3-b941-4018-431a-08d84878a46c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3305B483BEACD1101F6CDCAFC2560@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qweuJoIlsPd9yKHQkE0WFLrBh4mXX+R8bwKBtxBFdxHPz8Vs6nrXhNZp3xSdu3sgO+m9+9OutQQKv2cyNwzOw08+tH6nWcOw/WScl+uNj+vWNMd4RAxyIP1yDSuOtXNa9AyWkv+mXwVnFAxnZyvrVDd54pXstwNuP513T7lIBfdhWLSb0g8M6lZvhDSNJ/ThFguaz65yInvJFrFCksDyEYP1a8Y6UTjPlLQuMIzH3lG5+Shlbvj0uSjhl3ZSTyd1aoVXO67Y9ijfJJ3EHoHpKMm/TsK2tR1WNmBnNrhIbBiWJbXYx715ZIDK0OKZBHoD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(2616005)(8676002)(8936002)(426003)(6916009)(478600001)(66556008)(66946007)(54906003)(66476007)(5660300002)(9786002)(83380400001)(9746002)(36756003)(86362001)(1076003)(15650500001)(26005)(186003)(316002)(33656002)(4744005)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GQm7kiWn6uWE4gpTa1Bs2ohyBHJhFf+KDQtPbFMeqPUtko0Q2PJV198MEZszs5hNIAlQNk9Bc4GUh38Miv6rioZbQZxO5abNTQG71/3KwrLuajGMGQingINn3vaiuqm5tX63P784rOhOFXyiOn+Lyr++DsDuoeaQBRx88foFZmnvRFqMdX+pMBNJtznGvEnzuLHxLrytR7I9OqrLuktRmyZ8Gx/imDRETM4KpzpqLm1/otZ6mmjW7W9BS7l5DjfPGQCFl6Ky4q6SIUXieJzdw2oh5Ue91ZqHYy9vUFwoDuuf2xSzRbEd1rzUycZv8P+wBCf6LPD0nXaRU5x2RXdzJm0IYXpKXUo05xfBTGuAJSRPIEqNwxblmZDIoW+dMQeeYMY6gNFGB9yWOom+xcBYAUpJVIUDAyC8AZPFv6f7CxSiacsPACAKDkeIR4ue9GhR4Sk+v93ySNef1AzksycFQeh9tZi+kfYHCO5dcP2lH+yU2/ce7Wr9bmVEQrfZCZiMdpn+P3PgTLTEuM2mNpeWh2i0FWN0yGR9PR3YSa52o136AnDUD4WYBOMuy7ghqodj60uiwD4GeC3l803NIXqZ3fse7Zxma6Qj2CD1pEytqQGILtFdtS0zvOkwdOF6YwsWQfJloK7GUz9KfDZNPUwpPQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4894c3-b941-4018-431a-08d84878a46c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 21:57:06.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 968p2isOhL6eIZIqOXfdNRdSVcHZ48uVkB1h6JSFaeRKC6oE6YcDgxCf+vXjJERq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598306234; bh=AL3PN0UUjPdejE+Z8e81WUgEts3khK5BurfDN3FN1Ec=;
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
        b=aFafu9E98IG+g6Ys+Fw3eTys7RnktZwaAIyrFHS2XSRv7SnGLlwY3kgx1wVzYwtFA
         BrApuTBkB+uzsBI7oQPuCQQM/tPafX1A2WkqRDbYE8i7VqNPF1J7h12JgkETOK3rk1
         l/8IOHvDR9LylAhtld+JLnLAmKc5vIaFkisF54o9Y7D+vik/e8ebG7m8oQ/W3nkb1p
         SHyf3PE1szo6DSTnjMB0t1VBX/s7olviKljA6/JNhykX2u4DifbNul6xcQowojq8jd
         l3gUd2MiEniMpU8cWEpRhSwLXW/h2QlxeOaKvBDMKU1xJACsHjCWw4Ae2rNE1n+4sh
         IV8GzeRocR7dQ==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 24, 2020 at 10:44:57PM +0300, Jarkko Sakkinen wrote:
> On Fri, Aug 21, 2020 at 04:38:47PM -0300, Jason Gunthorpe wrote:
> > On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:
> > 
> > > > eg we can't do it because we can't access /dev/tpm for permissions or
> > > > something.
> > > 
> > > I already said that: we can't it's root.root 0600 currently.  All the
> > > TSSs seem to change at least /dev/tpmrm to tpm.tpm 0660 but we can't do
> > > that in the kernel because there's no fixed tpm uid/gid.
> > 
> > Permissions is a pretty good reason to add a sysfs file.
> > 
> > Jason
> 
> I'm not sure why suid/sgid utility to read pcrs would be worse.

suid would be more complex than this patch - most things ever made
suid seem to have security bugs :\

Jason
