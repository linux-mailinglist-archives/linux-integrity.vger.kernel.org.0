Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AAC6A6D2D
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCANjh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 08:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCANjg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 08:39:36 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E3E3C3C;
        Wed,  1 Mar 2023 05:39:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhV3wF9wrZ0pdP9kPdPLtar9EXUpKCoXEEblXf8o1Xr9Q1aczj5BPxy9OJ3ikSilMWhtVtKyI4fGIafdRx1dxfogbyVExSMc+yW3rHc3NPJLDOqc6xFclR72wwrpRnslr3mskrc3PZ1my4oo5M5jYxETccgK66Z1/P+i2j54t9XOh7MdAOl3G+sM8qBwd4sFwlUR9aY3Sj5P+fMyj92wS1yyjXrIb07vQ2soidPdIDJ3vFwlIQ3CbFaVNXwTCrJ+uXnUfeFjW8mZlQqQ4fN6LaNQV9SSp/ed+FE96QXL1bPeLi7xxfynAlc7t+6WfD1BHG8ZU7LAa6F5VK5TR24B+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNy7n1QsSyfdhng9jrF77hTHu4WTzisDl+Cw4zn0vKI=;
 b=I9j8OWP98uRtQgouEbFVszYiTyD/h3D+BiOR72TwwuAalyHGzolRUTy5I7t66kTsYuvUsvVe9dxilPXP/z12+BBkZwzdFGdxfdP2oGpux6ICok6P5pNPlPyB8YJDG4zXJBlqPPGNHP1EI4K5tY922m3swIiq0WOFHkfoDFNVUHsDTRFyjdgztdRKkhRSZ8IFAbhffzaloSvmknPrl/V8g7umTfBv3mYiqOpZyVZqNTQSKYa1h8oMk+kpEAu8faWqQ3p3rU1BJDZjZpHNl2A0VzkFbD/AKx21pwKiqmBRv8/I2v+Y8jhsUQxjuslLs18UF2JI8jcgJSI4NxkGZrzh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNy7n1QsSyfdhng9jrF77hTHu4WTzisDl+Cw4zn0vKI=;
 b=Y5LMrBrQTdBmi5/NlZhCJ5Z6y5Wn+5kBvw1qo40fbhn1XpxQjtLx43m5ZqWC9yD8DdueKo9CeUyOSZnNO4tZXlU+yPEw1lEDCqsAFcblUYNkpT2RpeZs3hD69O1nJE10GIyt8Lj68L6Ij9azzwxZga8lmXVhJZVWIYLhluqJTLz9ak9bDs6lvx/OLHcik2Lhg2j25wv5TmB0ZbOKGOBcMNZ0gf3bdMDL+Nk3oqzBLCj2fDrqKXIIwv/NV19CcoMZev3P84l+vu73zc/SVpHFtoxo3sppZB1oZPK+aFHjUdas8DGgBAf98flOCp8DmAan5ESzAuerdR8GDi1rpCgayA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 13:39:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 13:39:31 +0000
Date:   Wed, 1 Mar 2023 09:39:28 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/9VkGjCP48FHtyS@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/9EwTtmxcVBjiHz@nvidia.com>
 <Y/9HB/KF2Kjkihkg@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9HB/KF2Kjkihkg@sirena.org.uk>
X-ClientProxiedBy: BY5PR17CA0038.namprd17.prod.outlook.com
 (2603:10b6:a03:167::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: 09fe3ddf-423a-44e4-a41b-08db1a5a631e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XReZYszB7RZWiZPTdz1CMIx1A3h/4CaXRjAFmGNlRtoINu0JcRertWyhYvzUXhKUVw+cbt1wR6gE0mOh3K/pFbtEQ6D6AlLxyL2WRWw6O7Yw8NGDmBLj662CuHXkZYjTib1mCo9YGQQoRCiPxomTU1X3wZOKRNe1UaqM2uCw8uMsllgSxAjM1uPgHg1RtAhm4elTVPIVcL9YzCfkG1wZLEUVPa2pZ+qI8hwNWpitRuqvbWpMYMoTNmYBDPGdJSiTwyn0d7MGo4aeEEX2Eismt/zofpZiOd+Z2ai+9LDjKyYCovT9ClfoHvpfNPUS5SecGpNddiq1K42m0bNEzBsGYzNpXiRuhMm+tPAprZPHlT22i7lXKmyAq9NN1BFJ1kh6In2SIzESJJ5qhFlNZqP46ARGfFGaA2I9K1mgKz07qF6KEmCB45mxNenl+ymouNA3WPQNy8J7C94eBX7P9uq9Tvcu+oY6uRGannGztcBhIalyDiAx/VYsb383y87UJ086ImX3YJyJ/Y47Lth7pmH1WFNfupoGKzRi85rPcWOgYi0Vkjk6BYQv9M19E11UbILia9jC9xo8mvx2t7vL5JYEc6CXetHu7wWRRKalm3zQDfKWcWsNq23ZIVRK4JsQQqh3pzNbk5tklOYoZBMmrHxT3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199018)(7416002)(66476007)(66556008)(66946007)(2906002)(6486002)(6666004)(107886003)(36756003)(478600001)(54906003)(2616005)(316002)(26005)(86362001)(6512007)(6506007)(186003)(83380400001)(5660300002)(41300700001)(6916009)(4326008)(8676002)(8936002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IgyeFk7QM+sEU6WKNB7OkWUmpnYDFvs17zNwK6OxHrvgl/W395QLhMn96qN?=
 =?us-ascii?Q?NTv14C+U2zZkn9FVMdOMYjB3FKWlVYJOSmaqt9IE6fiVgcrwRA8x75b+Thxv?=
 =?us-ascii?Q?/fhS2UMPEuuLIGloNyMg0tcoOe80ogLbLFHhCb7qRbZmn6PG7NWg8ISPzrRp?=
 =?us-ascii?Q?7EM8nUJQriXnwzCaCVBhYQxopV7KU7DGknkLh4IYnJUd0l5gmxRBK4uJVpLY?=
 =?us-ascii?Q?s+h0LojW3BJzY2nLr0W/zapAhVRo39QrAJRxPG2GBRA9SkVYl1CX4DY/uPu6?=
 =?us-ascii?Q?l42HE/gx/YSy9DsXX2aNHjX+2bkvr86qdfBy9i+pIYqioMuWEGY1/rkjVbJQ?=
 =?us-ascii?Q?BuF0/Fl3Mc+oxTk+gMYZBUZYSb0Fr/EPIyOLw0bM1hK/oGuIjdiUqSyTugbF?=
 =?us-ascii?Q?/Xm9ApRb330ZZlNnO7a043PgjUrwj1OyfWnY5INoWD+Trshw8Tc14VRX4hw8?=
 =?us-ascii?Q?K/P+7S1BGZ4dX2jFDGI3BKCqi/J8SMMatw3WBa/T6biANM8wqd73KmC2SSno?=
 =?us-ascii?Q?QVdlb/pDY+kmBJuEC4scGmhAhhreGp5gP115biy+clOr+E2eoMf/h0bUYAnf?=
 =?us-ascii?Q?Z1q/t8asd+5NoMtpSki0tOF4jUzNBw2b0TU7ayU0VqMmo3cMD7wxvmEEa1Qs?=
 =?us-ascii?Q?hMUMVygP7Nn3YwfjSqP8OV9AoYj/TLrpiocg2EPEd0gY28gjhYN0HiRRmrQk?=
 =?us-ascii?Q?55SRAY9jVzEK1JwOVSY3d83WETvpZztQ0gC8pyTdlTkpABthZXo61PfVFOvc?=
 =?us-ascii?Q?WLsS2KOIg/ccJRk7rDfgQgQ1l+ZYUsFSf4FyPv28U10tH38hO7lXoCZcjeiX?=
 =?us-ascii?Q?pZtr8/rrawfiG0NdaaLMHkX5nzWYo4Bhe7aTna64oWAmYFR51ZHuBZlWy1eo?=
 =?us-ascii?Q?1539A3ei5ZLHjQllnJH3X3fyj9J5snF5UXDQszJRdsTb2VvgWgL01K00/j7l?=
 =?us-ascii?Q?w2iRi7dyZ/OVw97g+x/0xJSCv4/JMJtParVnAGZ1gAIW4RgiXSFpm4qaTzZb?=
 =?us-ascii?Q?uxcaDQj4lcr3rU9qGE+dZJQi8YXQIpZNeyll4tUrsrUkLgVB8YRDzW1Az0hz?=
 =?us-ascii?Q?/xfUcvIUcrUpWzxXFgFOj3NPX6UGrs/97/MvZ6KLBdjGs2rGYcSsPHl9bfIX?=
 =?us-ascii?Q?sQx8VrUPi3sSRftFhsjCuTUZu2fWymB4Pn2FG1cMDEYOia7tho5G+DSSRBqq?=
 =?us-ascii?Q?1GXKwtNL8vHD4bmIvl5unEd106/7lVDDJ+JU9V/UItwWrDlzOztBDkJr8pJh?=
 =?us-ascii?Q?9ZM0C+H94s3G5+ElT+bQ5kodPFjR976YoR+HhmsFtIrPH6OCSYrcC2NMY7ds?=
 =?us-ascii?Q?bYHQtDypRe3pRYZCr3dxRi2geScvvUmRNdnhbteSAtXn7LFcejhB8W1knmqB?=
 =?us-ascii?Q?eX6El4qkjNRyRm9yktuwP+fBetQtMxX+03hH90fgNunyOUdOWOlCW8/NpfPw?=
 =?us-ascii?Q?+eYhWptIuPAAkmrq13UcEBQUGPuwZCTsXe0RuoaRwnzbpTDUbucBbBvs9FBZ?=
 =?us-ascii?Q?2hnu0hai0C7O5oLAuF/GpmkXYbDeaFvC1lxUQJjImNOGCMYlNqT5p9lBqcaH?=
 =?us-ascii?Q?0XIyWrn9xmT7jplNApmeR1k/teI1q2l5ridOK7Ei?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09fe3ddf-423a-44e4-a41b-08db1a5a631e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 13:39:31.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLUQxo6ISRJUIHIfiX/Ylj0YwE8l0kQTSrXhRYwdz7aeNJpt6RyU09yEBuABoj7b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 01, 2023 at 12:37:27PM +0000, Mark Brown wrote:
> On Wed, Mar 01, 2023 at 08:27:45AM -0400, Jason Gunthorpe wrote:
> > On Wed, Mar 01, 2023 at 11:56:53AM +0000, Krishna Yarlagadda wrote:
> 
> > > TPM device connected behind half duplex controller can only work
> > > this way. So, no additional flag needed to check.
> 
> > Just because a DT hooks it up this way doesn't mean the kernel driver
> > can support it, eg support hasn't been implemented in an older SPI
> > driver or something.
> 
> > If the failure mode is anything other than the TPM doesn't probe we
> > will need to check for support.
> 
> It's not like these buses are hot pluggable - someone would have to
> design and manufacture a board which doesn't work.  It's probably
> reasonable for this to fail with the SPI subsystem saying it can't
> support things when the operation is tried.

If the spi subsystem fails this request with these flags that would be
great, it would cause the TPM to fail probing reliably.

But does this patch do that? It looks like non-supporting half duplex
drivers will just ignore the new flag?

Jason
