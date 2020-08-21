Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BECB24E0C0
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Aug 2020 21:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgHUTiz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Aug 2020 15:38:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8484 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHUTiy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Aug 2020 15:38:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4022920000>; Fri, 21 Aug 2020 12:37:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 12:38:53 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Aug 2020 12:38:53 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 19:38:51 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 21 Aug 2020 19:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PocHPa/fliBkwOZ5b0TnhqDG0UXuZOm5x7KIUplkksUkzXS1WsAEfB5plPXjfMZRbXJmmGIhy4T0EdlX6NgnFWi6E9sw0gSuSZsYNXb4WjpBrIK6I5c1zVCy+a+H59DBxZCyTr1qyp3lp+SDhby5PB8cnjPLmZjRbuT7kfXRby69fG7xjayFwyg24bkNK8y/+q/d5ZtnSoRI1Tl5rAfpag2zZOl/9wVEFSZx942cdREeB3t1fCcDTc8pqWl2cVl8bMjPS8CLwi/Y0rXoU0E7OrNO76hVDRRaOSGvvFwUalh1nFTgY9FGbIJlv5nn8HIokZZ4j51fqZfC8+LkehEUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjPdsAAUm7lRK2ySNsDsqrmJb02p73dlGSpz2pHHZ9o=;
 b=FvHb13LAxZYZWUoEAAQDUhSgqUUrY+pxBDS4VWupR+kxt5Zoe7QaPwbkbs2gSZOJC0I9LkoeSi8JzqmpBHtEChDQqQhK1N5mJDmwAusUWado9WZ5aUsB+Z7MEtA2ATOFttbGp+puq7CpIcUJJdnepnx//ltGjhkXAw2DeVil0ukXNEbBdODPYRUCyOJNGqiBsXHBVJ9mVgdwHREQ6wwrzPh+Wq90a6fmWVeRx9QiXYLptZjTnwudk1opFPGU9A38PO4NA6VKkvFdH4jIoFYiUl5p77nQrduKzDYHcSpiYWpuSWlTJ/bpgf7hh4zXVCSCCYioHFYbZBCjeBjgHSS8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Fri, 21 Aug
 2020 19:38:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 19:38:49 +0000
Date:   Fri, 21 Aug 2020 16:38:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Message-ID: <20200821193847.GA2811093@nvidia.com>
References: <20200818183603.GC1152540@nvidia.com>
 <14eaf21a808e333ca414c954d8f3a2f7b6dbf2ca.camel@linux.ibm.com>
 <20200819120238.GD1152540@nvidia.com>
 <1597850231.3875.13.camel@HansenPartnership.com>
 <20200819161845.GK1152540@nvidia.com>
 <78bc28a573f6660ee5b00d5965984fef2e1de167.camel@linux.ibm.com>
 <20200819171709.GN1152540@nvidia.com>
 <1597867756.3875.39.camel@HansenPartnership.com>
 <20200819232132.GT1152540@nvidia.com>
 <1597940084.3864.35.camel@HansenPartnership.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597940084.3864.35.camel@HansenPartnership.com>
X-ClientProxiedBy: BL0PR02CA0104.namprd02.prod.outlook.com
 (2603:10b6:208:51::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0104.namprd02.prod.outlook.com (2603:10b6:208:51::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 19:38:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k9CsB-00BnLX-9K; Fri, 21 Aug 2020 16:38:47 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10a875ee-b3ab-4594-e916-08d84609d35b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR12MB133917A6CD7C52182BCCEB03C25B0@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TyXREp+KcTfEfOYXq2/CLvawKiDsgfv2u76B3e0Zb1/c3cb5FdFi/o18d8CakVwrpcKI8DCHWIttApIx1b0vePZ85qUm7Nix5ZTTOZXeVj/jiY2TPWoj0q0W6l8Uk7uLVzlJ0IS2vc7gd0REia78ha4GY1Ry1TzH6qv3NB0ItLjkpei8aOwL7zkR7lZDzCSuprb9Wt0MqKNZOSuDwrnwXLhMWxDcRtSuOSKLglmOtQYozgTKmcOtmvdyQp0eJXtxVMMZakd07a7EBviRh1VItPr3jI4WuW4jfywQMWfrcdPibF4s0VGa9UAQn0yr4TgBku3X/gADjZu9AEN3/XwMyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(1076003)(66946007)(8936002)(66556008)(66476007)(26005)(54906003)(316002)(5660300002)(83380400001)(186003)(2906002)(8676002)(478600001)(426003)(36756003)(33656002)(2616005)(6916009)(4326008)(4744005)(9746002)(9786002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4dgFw1NRrPfSm/T0n+rFyueP2UX5ysFa7f/ZAzubAHQmXh2iSwjk49hzaiN1p61Jb0wWRie8+cX9s3jfqA3wOmQ+0BzAjDhfj0mVKy8uJsbhuM+xCGHad5SOyfJJ2hQ0rwnPWZwlKVJKd0r7cLwv9PYSNjV/N2Y9fi2Wi74Ju7qfLKgeP5vZ0NHvA89NDaFERxzHZVcm21z9OEMq/l1DIl97kSh+lC+rqa+u8J+lhvz7YHTbGCV+SmYBFMDnPtHVdCARQ8IMcZk35CJxNawCTw3VWUzD3VGs1wDrBQGqNMPkMKmO3bsThROVKMlMb9g8+OXpBBudOyh/ewt5qzq5XNzMjjGBFICzVvjWkm5YLl8HdEQp6698s6GzxAE/u6FH5ZfLJ/OdP6NRQ/YMNnNijnpe6UKjOwh9Zn80sA1HLIsBnHmUl1kCssrL3YuBjjThvjmJAFCX55jxTXTiMPHXoK6q543LOtZBPD65rhbXVQhjQhjoBTLOH3tzSpZvLFp9CRxk9ZbRq1NrCLypi5AQ8Bwfcyf254bRarqhaNt7/9VWoiCVBy3BFOsTU2BClP38qSzfhAuo4G6uhgqHH4eZvrFkiYdEzitBmJ2u4/kSRaiiQoAM7H7yaQjQ3sYQ8ANB51NUJtBWWII+GR3lCBUIzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a875ee-b3ab-4594-e916-08d84609d35b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 19:38:49.2908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8K5r7LKopq9zWXxNlw6yauBxqonvYgGRniswjN3upAK3/knlFS5J0kaLuHq+tFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598038674; bh=IjPdsAAUm7lRK2ySNsDsqrmJb02p73dlGSpz2pHHZ9o=;
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
        b=pUzFjVAYdnwO1BsFNkRgGz0Ql/MjayWUeP9PxtMHjcuse/Kd2E9N2zFV8tHOJCWOg
         CBdOTH8+qYknMbNvBsDvGxDO/ITQh/UEu5JljjJRlxps9ChPJvcKbApGQkQjrRWa0P
         opDcUkL0uGiAplqnvkiBI+PclBRH6jtD0aNzJtZIwiAWgRCHxAoTGETm8QkZwDGheK
         QgfzMUR878fLjLmLWYxkCIhC8Pg3Wwlqt17j6BO3ZEPa55Jwz1ILuof6qpjIbsUO91
         C93toej0PxPcC5ICtPhHjaZhT7+FpF+m0HWwtGmBt0eWCmx9nU/k07LsxKjv/VsWmG
         jGnh3Ci7oSVfw==
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Aug 20, 2020 at 09:14:44AM -0700, James Bottomley wrote:

> > eg we can't do it because we can't access /dev/tpm for permissions or
> > something.
> 
> I already said that: we can't it's root.root 0600 currently.  All the
> TSSs seem to change at least /dev/tpmrm to tpm.tpm 0660 but we can't do
> that in the kernel because there's no fixed tpm uid/gid.

Permissions is a pretty good reason to add a sysfs file.

Jason
