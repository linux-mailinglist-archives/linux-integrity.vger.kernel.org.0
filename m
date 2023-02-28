Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332846A58FE
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Feb 2023 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjB1M2O (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Feb 2023 07:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1M2N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Feb 2023 07:28:13 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54357A88;
        Tue, 28 Feb 2023 04:28:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CI2HWQ6PDWOvxg05R0MGgrREhujMf47H3EeU7Rypv539qLAhNrsyyYI7kmvG+L+AjXyqxWKj0CIrzdgjEium70qYa1ye6j4Ekaiju+Ds9/vZfMhtVAd8OL7fisIDZhi6voMFlcWdeN1vZ+bWbJeFJAL8K2bM9KdbhUZpk3iVqT4FMru9oyDeywFgxVMLzo6iFJhjUzWFUobMrWuvlWlbAcMFk5LBJLh5nCc/JXzFtHJv2YVoB7W0GUw+3GPKQOxt/Y61M5MwXAdPrflCFO4GmKeAHADl8M1xIzcOMHmOW47ZAjA+IZ5j53UjclKWqG2+zK7BP77GnqCbnKTZ8QTSkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tH9lw2NSlSG8RHroIJhAv+Ib0s715rmX9679XhMNoM=;
 b=mORmKM3V0+K2s2+xxBMdd+zsR0RWkuYcsUYaTwf9dGp2iSC70Zw4+TW0F+jlijBPv02ESMZU5jftES3reLSnKBjFRcHHOIt0vHMZkERZ13YJdHvvGN4cqVTmsTzCiV6HnEii3bWHohCZT98475g2jWAUV7206Cef/n+JXNE2rmjXBECBUup8iKhKLvRhli32kQYa79fD8AOR+Z8oEs553LgO49VMcbaInRq2uWhTNRunVYXD2J/9kRqz/Xjn9D7u/ZUUevW5TwuKnfgHZ+92aMovDW+BMpBI3H/6h2sgSGNonhFlnrlJ+tdU06BmOfNH2WR7qUgMpLpzRUK4ILljhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tH9lw2NSlSG8RHroIJhAv+Ib0s715rmX9679XhMNoM=;
 b=dU1pTmCD20mK41SI14q4RHK38Zu4qkkfYHKAYDckj6VWokJDtLp2Jz+YBx6hjhAmP/84mfHnZ55mY9lxfxDyhz2Oii0wnhzGhz4oQoC1KfylEtrQaliQTSH/QP7BdRKEpF9HTcq/0zQY3dMFvItiCTshVCQN1iTHpYxd+ZMVIDhF30glFLGGR35QdkOa7KDrHMeUxmLWifBarFsLTMg1iwdD/YD5O2a0dkXfOQ3U8a4BTEOeHEnp3G6spgm7Gjtp8zLMJvkiMUuZYM4cWIsMoZbE5hf5HLZlNRCs4p+yRoDM7BJp546GfZo62jvHTVOC0nrwhaYHzni7sWJkG8mWvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Tue, 28 Feb
 2023 12:28:06 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 12:28:06 +0000
Date:   Tue, 28 Feb 2023 08:28:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, robh+dt@kernel.org,
        broonie@kernel.org, peterhuewe@gmx.de,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/3zVdgnVz8BvGGl@ziepe.ca>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/1oqr0RfD7KVA4y@kernel.org>
X-ClientProxiedBy: BL0PR02CA0098.namprd02.prod.outlook.com
 (2603:10b6:208:51::39) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ff6e20-3d25-417a-4840-08db19873e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKKwT5WeDG4qByQYps8mFLwB6FAUVMJeb6/hJ4K8zVgtXOinNeqyRWnB5uq0nBtcyzxit4HKr463OvsC55qTmVptcXFlN0hij7pDT8Sh8CHuSP7aQ/leWbId1IdlL7KtjcEHQeziyg8YUUFFoI0kapwE5EUuopvijXDr10qltC0rXsNbIF5Xy/vq4/s7rkVKBTM8bwEwV1MSBQnt8O/FoOaVCE7u1AjlH39WUEP8J3FSOtyTH4+bYttI5sfyTLQHZ/AaJBjBpDAGiJ2Ij0Yy3mxs4wAey2oxFMLsKJNE+lQaRKXQeXAcEOMh3mMgst+py+dS8oGBozfXQNtYDiedWhhFNxeZHRVqERBhhOHuhcLmlQZRbO1Dariz0q1VLipYmrAkhCFz6tpoOtnXJw74czFtP2V5uXyDsCPmeIjD50FSAtRki45RejIdlAU0Gbn80I4A3rIJVkeHpuumZLMGd9QfS9Qq6Yyd4buC4og3EEbu4MDjcCPFzgKQSvQg8kv68RuqOe+dYJHn66HDDkwurEKyPYZy61fwZFDgEP/hp6B1cNYOPlxOsjXMHFPMDPRHV8U1RrDFUfvjeuoDn6+/vJKsQZ/TZalewPHwUFrqtikTAojYtEAGA7c0PLGoRJdLE9AUCudrInhwYNi+QQhndw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199018)(66946007)(66556008)(86362001)(66476007)(6486002)(107886003)(478600001)(36756003)(41300700001)(316002)(26005)(6512007)(9686003)(6506007)(8676002)(186003)(6916009)(4326008)(2906002)(38100700002)(8936002)(7416002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVzUmIGixiEVQ09i2R5H9IiVnaUe6nnopvl7bd1T2Z4Mc5JlQ87ZP0c3Z6oX?=
 =?us-ascii?Q?76Kzl1UAfwn911wXvy+sKeFwEdkmcKcIhWsaVgq2zgOu4nm4yzLW9NPAKjpx?=
 =?us-ascii?Q?HDPRHIOl0VLCf/GWhzYz1eq/J+nS3revf518irKmAI8ab/9/1aRrR2DrFm3f?=
 =?us-ascii?Q?fR5VOfM4Tkp78bMI1Wrrqa66pqkiDpDCj0CFegzBSpE9+jT+GksFt1/JBZ36?=
 =?us-ascii?Q?1w66IpF368fpCiLgkdgW/7vfy9kYpZMAlHe6VZOHqXo1Au/OCGJlX9eGj41m?=
 =?us-ascii?Q?IAbGasPyShwhC97HIyvKU+kA0pBnzii/cl9DkcBgyRMOmZQvmY4qenPa3++z?=
 =?us-ascii?Q?JIUA6BwfSbo1QtBnhDhFn+Ya5LodHHr4aqT+8lg+/F1QWM1p70PtKL3CCmcj?=
 =?us-ascii?Q?5YSD3/kByalBBoZOYbBGwHQn/qv6p4M+Hp7zcHlji/HU+6v4DBAjL/0WtVYm?=
 =?us-ascii?Q?BW5m6xB3/Dq+Z8Lo4gmJtmE3F5OHDSsfSedVDSb5RGwBAF9j4bdhNCL5yevD?=
 =?us-ascii?Q?u5+vbwLqAGDrJ+orjwYmqblbN9ivcMT9HGs1h0jRJKzernxodh6vnmDsku1J?=
 =?us-ascii?Q?J1LPEfTmCW/BlMchU+wo97tGFxbbF47vU75LA7eaa14ndD2+61xCZQPsehib?=
 =?us-ascii?Q?G6xiIynwFZ9WkESNZH6sUiGmqvUtYVRqygkLfR2zxfZ8jd8B07iQtNRx3mAP?=
 =?us-ascii?Q?353luDxIrTMOJS4hhL7y/N1qi1g7qfAo++L8ezZ2VydU+5X2htgoNzc6oMGz?=
 =?us-ascii?Q?mDn3uSl4TFVY+0vBPxgXJsvh5+gbm3TgKVKpJ/VePWrB6Xz9//mLjAqIuUSY?=
 =?us-ascii?Q?uVseokoN2UUGvOnn47+fSlT09HK6pDo0XMjD1prQFSne6bgc4mZ9ci4Aku98?=
 =?us-ascii?Q?LA88daAIZ1DERC9C1zcp//XT/NJu6DJGhDpGS6aPnwcwQGWg0Yqi0KKnUF++?=
 =?us-ascii?Q?oPx3b2RlOcsSSBfnxKZCk0Ip+WKHy675Y5FqpmYO81Oh86ryWKtvVrHpDncq?=
 =?us-ascii?Q?VT9Ir6zKLg4O1zV39EzaJPmwQ4fIUbqDLAa9GvO8nLjpRKaONbzsde0QUBOv?=
 =?us-ascii?Q?adYc1zkSaqWM2H0nGuXbfK5S+Eu9El5M5BPWg13UR+OJ/mEa052PPi1qv7hd?=
 =?us-ascii?Q?PdIXDhj7rY33uK/KrzM5LDX1cESnZI8BeAYJ1iMVxhdYb6VP0trVT2kXk4ol?=
 =?us-ascii?Q?FhSKeyQhVz/MIYOsHcItA6DgSlLEyT4aVFVCXE/1fp3Mat5Wh5yMpW6fudZL?=
 =?us-ascii?Q?XxYXPR+/UnhZifBhjJG5sh0viCrq6uaSvgsPtysEPHU1dHmsdMfF6qWIakTd?=
 =?us-ascii?Q?agzmPZrtE2JOvOp6n1qtr8qYwBcQgmLIrxDmytUToDGpoz6fE19nhmq4V2Tg?=
 =?us-ascii?Q?Wev2WWEBEeW1wLLU7QscKBV7YcdKJ+4PiS02P3Oenwt79Jhl1uEkZBYfCFL1?=
 =?us-ascii?Q?waY6UAdCRgC8JuThvAWiHB7xfqZ6fy6VKeHD+xo/Yedjvbd8385EunR6Krv8?=
 =?us-ascii?Q?uZ9zufNn07jjy3lwbhfMTncYBWVILd6lU2grkctbAyANqWV2T/Aspa/BUs7H?=
 =?us-ascii?Q?ddjcfcPI0yn7QaGmvXGsvS0xj8BzGLNdCeylPZQ8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ff6e20-3d25-417a-4840-08db19873e40
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 12:28:06.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeSLlCEM424MZgLX5JzGqJh5SRg6mhEABquTA/4FNjUSRm9kVueRL+O3pdxVHizp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 28, 2023 at 04:36:26AM +0200, Jarkko Sakkinen wrote:
> On Mon, Feb 27, 2023 at 05:37:01PM +0530, Krishna Yarlagadda wrote:
> > TPM devices raise wait signal on last addr cycle. This can be detected
> > by software driver by reading MISO line on same clock which requires
> > full duplex support. In case of half duplex controllers wait detection
> > has to be implemented in HW.
> > Support hardware wait state detection by sending entire message and let
> > controller handle flow control.
> 
> When a is started sentence with the word "support" it translates to "I'm
> too lazy to write a proper and verbose description of the implementation"
> :-)
> 
> It has some abstract ideas of the implementation, I give you that, but do
> you think anyone ever will get any value of reading that honestly? A bit
> more concrette description of the change helps e.g. when bisecting bugs.

I would expect SPI_TPM_HW_FLOW to be documented in the kdocs to a
level that any other HW could implement it as well.

> > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > +			 u8 *in, const u8 *out)
> > +{
> > +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > +	struct spi_controller *ctlr = phy->spi_device->controller;
> > +
> > +	/*
> > +	 * TPM flow control over SPI requires full duplex support.
> > +	 * Send entire message to a half duplex controller to handle
> > +	 * wait polling in controller.
> > +	 * Set TPM HW flow control flag..
> > +	 */
> > +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> > +		phy->spi_device->mode |= SPI_TPM_HW_FLOW;

Shouldn't we check that this special flow is supported when the SPI
device is bound to the tpm in the first place?

Jason
