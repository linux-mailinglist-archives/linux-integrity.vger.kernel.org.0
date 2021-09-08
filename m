Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D114F40407C
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 23:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhIHVWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 17:22:08 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:18889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231956AbhIHVWH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 17:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9cZESDA319/r+xSpP1cCRaXsmwajEdeUDTzRb3rPqIy591QpknRmc8Dzvp/ss1UEesWL3HTI6DvBbllyMfy/cP3y6H/wPYBbuhVNKmA0S4x6a6HdpoMKfALBAhyakgJHJRJERDC/Ku3JZwGHF5yy4NRchJPhlllXG/2PeCN0NxMJLaCxpwEwSRuBX/bLJhiHIFQWMyqwdrpe5CYY9oZP6Thmk8JKaIV8GX/mIDrFldBbMAyU9UKGRrRkaoNzHk4AtiVo4rHqfNsQpgBzGNbGG6Zzo5iL9uQzqhAs3tWsrcZYWMqIR952f11pDUgW4EqjbePSwgwIQrHkOtJfBRDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vivWf5E2o8HBWX8Tn1bEHbHwghk4Ml0rlCZ/HvE3U8M=;
 b=EiSCtg14JVw49cOcsw1FnsotI2ITcGwDx7pY2isD2sMBvNVcblUa3NlR71K29Ub62Y2j/z6kVgDhqzpGYLd9qtTBhBPGTfCKNSHE4asOXalqjFms3OmHvlwm4hYZZaFeOFa6mKeuTSkzKqX/jCyEGINBSsuCZ8lhmps+H2OYD7KFimXEitnU0TTstQX7MtjKorooudI+o39vwTP7N00bhjL4Mn2tfKLZUqjW9+AZC2KUVz+vDW67TKU7RkmCwgeCqGphjydV6Sdk90/1FxrFKIR1GAC56Z0J/qPfHQo/yhW+e9D8WjVBSIV5M/5TLzKlOy/YzBq3kAVlQcKQEn7m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vpitech.com; dmarc=pass action=none header.from=vpitech.com;
 dkim=pass header.d=vpitech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vpitech.onmicrosoft.com; s=selector2-vpitech-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vivWf5E2o8HBWX8Tn1bEHbHwghk4Ml0rlCZ/HvE3U8M=;
 b=qSRX98XHQxinUIWX4Vk8CZo/fxG1khb102M77uHH3OgeORGYLnPkUNChCGR1mnaxQG40H5d82XaPsBIhQZ4qkJ7PxpT2gvPxlii6tz0QL8nv+gDwcDy9EGKVtk1TnxSGehABuIl2MyG9aZ7zXhXPwqkQhh8NuZnr+P1P+vZsCVc=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=vpitech.com;
Received: from MW2PR07MB3980.namprd07.prod.outlook.com (2603:10b6:907:a::32)
 by MW2PR07MB3913.namprd07.prod.outlook.com (2603:10b6:907:9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Wed, 8 Sep
 2021 21:20:57 +0000
Received: from MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014]) by MW2PR07MB3980.namprd07.prod.outlook.com
 ([fe80::cc48:9777:4f07:6014%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 21:20:56 +0000
Date:   Wed, 8 Sep 2021 15:20:54 -0600
From:   Alex Henrie <alexh@vpitech.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, alexhenrie24@gmail.com
Subject: Re: [PATCH] ima: add gid support
Message-Id: <20210908152054.b6483142c7fce15f2bf01548@vpitech.com>
In-Reply-To: <ab00a38ebd268a67eae306a368cd94964a06f0ba.camel@linux.ibm.com>
References: <20210702222027.13973-1-alexh@vpitech.com>
        <20210831201241.a256fa28b510a8e2546be79a@vpitech.com>
        <ab00a38ebd268a67eae306a368cd94964a06f0ba.camel@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR08CA0060.namprd08.prod.outlook.com
 (2603:10b6:300:c0::34) To MW2PR07MB3980.namprd07.prod.outlook.com
 (2603:10b6:907:a::32)
MIME-Version: 1.0
Received: from demeter (66.60.105.30) by MWHPR08CA0060.namprd08.prod.outlook.com (2603:10b6:300:c0::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 21:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be74db14-7b2b-45f1-1298-08d9730e8bec
X-MS-TrafficTypeDiagnostic: MW2PR07MB3913:
X-Microsoft-Antispam-PRVS: <MW2PR07MB3913DF31D611542C01145AD8B8D49@MW2PR07MB3913.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kmjV56eCym9hZ2KOVl3dIPWuG78IXBQdoIwvJUXYwoL1kBqiepihZsRuJTk+C8JXkmpbZuZmJer8IuHv8seOkEIooNhn8kq1ndjLXXJpGWrSod+aYHk8g2I5NnxsI34pvqNPyWjYwdZ6qgcFExBnCwQxw9fOQf192kBo90FwR+LqMJC7r1ISEhcv9MMazWqKiV8pq9IfkX5iD+ZR3Bpv1EZMuNH/I2llwbsb/6fWCNxycdv1B1tignYnB4B2e4ft1Xc4ckvo50nAE0k/LGkTPS5hS7wOSl3odMFhlLaD2GvIt7MJ4UpEkq45By1ab7LRkPuTOIAImrvjg5zUFZyt1U36oZP+9nWThphotxObx077NRMv8JfoCLfw2C5fsADQ63fC13lv2Qku0U+dqJVoh/e2sLjSENQ+Gn0D3AfVcoCGllFouAVlqVHGsPwyVr1bNFK14xfK7LeQD6MWKRw1c60O859tY5nVTfOXiZcS3QgV6uaFQqXhRtqW0z2puHEDR2iiYgwNqyoRn6JqewIIM90PmWcRiRqoMCUSJ+FDPMlblIktp/gQxWdvAci4Xz4wnxj9SFMS7p2FXjDW15ok9n5FIo9eQ9s0esjre/v2TitsZeJzifV25ABTLx3Qg2OtWJiiZs1qhYjMlbQuw0aDZZfrBY6sksrAepL86N64eK4hPxLLFO4MJOk2SodaJAuU6f9vPpQoeH8NEQS7OazVKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR07MB3980.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39840400004)(66476007)(8676002)(66946007)(66556008)(2616005)(6496006)(316002)(52116002)(36756003)(8936002)(6486002)(6916009)(2906002)(1076003)(38100700002)(38350700002)(26005)(478600001)(186003)(86362001)(956004)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyo/PjMG7v1HuByejXQoJHko/oBf01roHkAcJfuV4A1V0rElgbSbP/ry/2d7?=
 =?us-ascii?Q?7kenYMC+31s+EN7xYWktrGeuVJ6MB3si5IydhMHXGbm3MPchfy4q+ckJJFjM?=
 =?us-ascii?Q?4yIxDBV6QLIer+nn45zRuJq41hVQcxyQxwz/9iX4mZB6ay/YPN2s6s55xa/t?=
 =?us-ascii?Q?lQPyyS+m3WT5S2e2m+sXffYO5mjfHbw8mLAtxUN4LVMj9Ya1hhV4HsqUf0VG?=
 =?us-ascii?Q?AeffY8rueALHolXOOLa2CaebQTAkm9YO9i3xoJFBASdt0DyVjhKklnNoofn/?=
 =?us-ascii?Q?XiZAtQEEPot3882TUQkaeNlgRQ/WjiitWVdCd9VxAuQGPF36Cp7RPpyhhpZJ?=
 =?us-ascii?Q?ZMVnnWbNcbDHLW4VWbAEdKcWo2juWp7VQXR+Eaw8mYfiLHm6+GZtVaLQMi0l?=
 =?us-ascii?Q?QS6LjKegJzx4nkpDrWgV3XWZOXwq4R/sacHtGMeH4wIvFf8UXiaZt+KprP/Q?=
 =?us-ascii?Q?rsvd6FIeFEHvSmsz9+TUlBoejNdcHq14C0lUqcM68fDeuII6PsDTwJVVgESH?=
 =?us-ascii?Q?iYYqmcCEG355VNAUh91rhS9gNnu/nIEiz9RS9DJ3utkZ7h5xHozaPccXTeBm?=
 =?us-ascii?Q?pzn1+StwxBK1hCDye2Rt29n2ckXwpW0aLrQxTA03A1FIIMtaDO2DQ2hil1jm?=
 =?us-ascii?Q?EDuTWtfevcDr+0tGF5bszWE45cmjgfFaPKFl9x21uBCGeZuPAFtWO8S5oRba?=
 =?us-ascii?Q?XQM368R1V5dZiAGIh9eWlTFEThxCUjTquIMhHZI+InfmdjKO+26db+BMn4QY?=
 =?us-ascii?Q?uZVIcYSFiEIr17gRrDeDD6Hw+/Pgr3e3Q3591NogLEZiAsicuCKj2TrtAMDm?=
 =?us-ascii?Q?krCc/ELa5KxzCAKt8ToZnKCZ5t5G3th1ekYVaVy7gFU7fu8ac8V3/AHUVDEN?=
 =?us-ascii?Q?nEobhOg516ooolOH6vWI6c8FLxoVc6IinXiT0uZuntJinnHVhAxF5B500gC2?=
 =?us-ascii?Q?GhDuOP98NepVO3vmvqaevMy1EeRietTVS/oJoNVjeMdZwoFmrjIFmsNFU2Gk?=
 =?us-ascii?Q?XKi6F4vWITqnecH1eqJI+l52Ip0NK0Y2IcZhA41Q5Ot7IyEe+shPKjJgTW+p?=
 =?us-ascii?Q?SikJSTRll1BrUf3jgh8PqzjFGCKmj0wj2AS8j9M4sYlPpSZcXwgyaeH9f/mm?=
 =?us-ascii?Q?ftJzc0y5B1GUHXFLe6l1gDdRQtXcNgdTHydEoy+5q96N2i8lqHUI/7U5C+BN?=
 =?us-ascii?Q?WdSKqI9xNYRit8kbQ5+/7SuSStH4zZY2Rit/ez1WeXh0w4pqHGgNiCLoecgE?=
 =?us-ascii?Q?71VYTRMOkXgCOwMlrKx7gZ7LevOSbS7ZJOxjYQe6fjmIWz88si0L5T7ihpqS?=
 =?us-ascii?Q?sUF5CPbUb1p2M+IDfyzu9Qg4?=
X-OriginatorOrg: vpitech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be74db14-7b2b-45f1-1298-08d9730e8bec
X-MS-Exchange-CrossTenant-AuthSource: MW2PR07MB3980.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 21:20:56.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 130d6264-38b7-4474-a9bf-511ff1224fac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xqqFIYao3gq4RepEW+zH96LJ1mwlMPpRTrOmRuYDIPeWR6DO+/rVog2yPEIj6LbpxWpmEk20LUUja/H2V0epg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR07MB3913
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 01 Sep 2021 10:54:21 -0400
Mimi Zohar <zohar@linux.ibm.com> wrote:

> Hi Alex,
> 
> On Tue, 2021-08-31 at 20:12 -0600, Alex Henrie wrote:
> > Hello, could I get some feedback on this patch? Are there any
> > objections to including it upstream?
> 
> Conceptually I don't have a problem with the patch, but I'd also like a
> test to go with it.  
> 
> Roberto posted "ima-evm-utils: Add UML support and tests for EVM
> portable signatures", which introduces using UML (User Mode Linux) for
> testing new kernel features, which, unfortunately, still needs to be
> reviewed and upstreamed.  (Hint, hint help with reviewing.]
> 
> Another option is to define an LTP test.   In either case, a custom IMA
> policy would be defined in terms of a loopback mounted filesystem to
> avoid affecting the entire system.
> 
> I'd appreciate your re-basing and re-posting this patch.
> 
> thanks,
> 
> Mimi
> 

Thanks for the feedback! The UML tests are intriguing and I will be
interested to see how they work out. However, I think the tests for
this particular patch fit better with the existing LTP tests. I will
send a rebased kernel patch and an LTP patch.

-Alex
