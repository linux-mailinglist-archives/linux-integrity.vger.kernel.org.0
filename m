Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6D6A6C53
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 13:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCAM1y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 07:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAM1w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 07:27:52 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079BB38E9D;
        Wed,  1 Mar 2023 04:27:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNDjRKmzMij2rda7+mDNeIx7hU4cOUFZ2wsfcW+ZfqnaMGXW0kYvizdr8rzJlSj7IgSYZyRQStYcisNeAuck7hrWG7QhNHWUjnIix+pxIyl4FmYSrp/X6kq4Is0pYbLnL66JcxxPQMtWrJbWieA9nxFGikFq1zWZ3xq1GTRR05a/d9Xw2JhhBVxkcN8/vp3FuXEVBIz0vOxh9SGsBz52c/F6SnPym5RSnS7a82AqeWR3VnuL0f6Ysbe4VLO6vG6KtkyoKFgskBi7rDPELHTarlg6T8lttJT9MXCfqtXHoYg6z5Z3iwTSr80pcNJXkug8J1H3fdTwHdyN9nxc7g/CHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmvmFsTVMRZSXs4VXPncbRCb5IgwkcmcLhU2wCklck4=;
 b=gQctiDIXG4fdU0W/1A8dF4uPi91+FqY/YB8ezOrE/FGYLvUj9CyqCQl9rrhSwF2ZZiOETDA6ASr8P/KBhnPJRPPxSBeEPSFnC0LqTH62f1LqxfPrqlSxW9JNeCnDL6f1JYS5HBLdiXsr1RnruLpIKz/Cv8rASGcbYJw/IybWa+zbNwzQ/eP+j5M8W9qXMLdi0dOE3I74fKhaw9Y5j6FVIXFCgIxHrnmOYlAUBotavdHGLhyKEM0A/qzUcK+ohMcANTycmtbwJzrUIU0q4ADjIp3otgC1IJSGQGmTL+bmdwYBIgmKzicmXyltqgdPfN8yImZCS9U5Ak4Q8b3i05euEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmvmFsTVMRZSXs4VXPncbRCb5IgwkcmcLhU2wCklck4=;
 b=CrmQX0aVLZhkU4XIyVtrIgThOtsZjXvwiHUc1zftOra9Kb7gjQXLDnBVU/t2fAkVMP0iKAW/nGe9trpyUt7EDoUy6pu5cE5ND4qyWLC+bxJsudPtfqiiYM4sP9N+AEQbAnEoa+tQH2mzPnVDduVfZ2vB9ymSo9kL7rx3lYx8pwsihJ9vMGSZyZ3b8dmHgkGFEEcfL1SBg2+/J+G9bqDgu+HINahGhJaNyRKmyAV8ldQSltY9R9bFnVTPs2tsij7Axo94xGIrDYm9ArUZuFrBuJYFeNJ5nEXpP5kyP9gL0871upQq9Fz+LY0yuYvS5S0GNIGeC3L2CWDPa+ZiO7CTLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6300.namprd12.prod.outlook.com (2603:10b6:930:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Wed, 1 Mar
 2023 12:27:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 12:27:47 +0000
Date:   Wed, 1 Mar 2023 08:27:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
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
Message-ID: <Y/9EwTtmxcVBjiHz@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f534aa-e353-41cc-efd3-08db1a505d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlMel9oAmy03y1r8rJACwcKEIeW0w9P0Ahf8pxtAvNKf9lwB1OJaIWUhtH+9SGvgiFObah1NwTncPES/xhpgxgI+ZkQs3RmKrGbQuw0Dn+UlvbtondZBp+DSd561F5XxTY6ATO3BHoE/UqPCdDprlxAt5syF7c1yynls5hulULrc+m8uTaNA8kInGSE6rE+sbHB3hjiaGioLWEFyxEDdifuSFQ3rv/e1qeJOh6Im/oVt2a4Y0sw6d+lJfRXFp5C6xA9VfcfLPGP1w6KDMZHHAtI7TioMtiXLgkGCc+tIgO6q73YWn48y6x3MLj5wfIB3VXA2QBL8McUEyBYwG3/yV/4jT3VTVrzU2XfKAOGhyLLgaiCzUUcqo1iSkzOjwWtSX91JEYBxO+8Tk8ilyZl9gMqmDUyPgtjzMAzHVN6fz3eYIfDWKi6mylKLXh/UlZDDH1nQy1Fz4PGq2p0I/jNaYVLFiN/lYFZSI0kljkP0KhTFw1Qd4l+YpJRWakTfDrI1vygYaYptSXxjGI9MHTJrGkuoIxJWA5Yfvh7w0QWvPdAL0rB0EkAlA+Bz4PgXuhD+Mzz1Qhlr/GqcfHOEg6KkOu2u7VIZtMhsFcV3LQZcMoQdd5+1MDEBuKTvWws4izdraSodo/40AZcKIbaQEzOBEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199018)(2906002)(66556008)(66476007)(8676002)(8936002)(41300700001)(7416002)(6862004)(38100700002)(86362001)(36756003)(5660300002)(66946007)(316002)(107886003)(478600001)(37006003)(6512007)(26005)(6506007)(186003)(4326008)(54906003)(6636002)(6486002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JTWhNZT90gLfibXosdGIYwHLWJ/z7V80hYNEim1R2J+EpyEL+kACS2uQg9OO?=
 =?us-ascii?Q?s87w/2XEMCIeN76wWZYngOsiG7ZEb2ynT2Pu/BRn9/BPBmGk2CUL0opkrilS?=
 =?us-ascii?Q?G4MNWTgk7AfySzS1mGyVgCuic4Owx9Gv/U+facktEh8YJVFkfv+wKNMbrJq4?=
 =?us-ascii?Q?u6JQ71TssrveKxUcxM6Phj3rpBdvuPvb0ou2gpleM9SKfgGc0GmESPV9DPfS?=
 =?us-ascii?Q?Rj7KsZlKhEVs1V6jjZc4qRdheTbvJtBrCL8wbPonmSvPmuSV+yOAdDLmdvuE?=
 =?us-ascii?Q?6QAQrsbnyQpBCc33n6q5yyqYZO0/3FoR4wXmjLxXYoWC/OpfxCH4cbxL3ILS?=
 =?us-ascii?Q?7xLqEDAjaj8obIL8Nqo6KdkHzSo3GENx0aDWTCoiNeVdNgB3iwtmC0WZaGfo?=
 =?us-ascii?Q?kC2IfcdKlNJtZVX8bNX9T4RfhWRHPXXvOzuOV54lQCxR/UJUdDA1Mdkr2yBx?=
 =?us-ascii?Q?w4WyA2YF/ePUCK15KOBpK34XF+BVKl70932bM5qShScZSC9GIwv4E6TdGSCK?=
 =?us-ascii?Q?CEXSUoR2nAFtTP+zQhzmtVqw04br6FXANsB4QJ3g55tWj8gV/pCiZ295Dp0h?=
 =?us-ascii?Q?crUCRUG5XzEHMSnZvCMU7iVgW47egESa5CUTx4B3+Yo0w8DoKg7WSGKOe+69?=
 =?us-ascii?Q?ziTgav9LgvvvErfvgc/Ha4zmG6kWxMhbLSZ8mTob5nlg86Exhwmt0OBMplI3?=
 =?us-ascii?Q?1/VqW+tiyQgGk6Isg8OCEnMf2jFGEKC9P/EgFZrk1PuZNOefpujaut05X5SG?=
 =?us-ascii?Q?zzvFuLiYkF9VPttzx2Z2xHdqHthrdLMe1FsMavNPBgYr85XjbT7/vJjnBG9g?=
 =?us-ascii?Q?iuE6jCzSMK67PJR2z6T/UdFzPXol8pBTE/2FfxHdphbiMsaBUqc+Fo+IHqxu?=
 =?us-ascii?Q?J9i9G8gwMJHK2DJKr6vaFvZaMLm9L9p6GInVuAOX6D38pnLzureyPMlDhmda?=
 =?us-ascii?Q?GsTQLz8CG8WKS+BAOuCBPXRGwqJoy7HH2na6imeEDStrH/Bf/ruJ2iqqD5hP?=
 =?us-ascii?Q?6skA/vCb11nhi80J3A3GyP0Oo+CqRiAc2sSer4zrRcjfh+6r9Nj4SrTp31Qu?=
 =?us-ascii?Q?cuRjVtFHBEaobXRBInBCVdZfd+nrt4UgndlV84XOnPnI0k6MHmjuPgn/+xmR?=
 =?us-ascii?Q?4kQIWGtms3K17q7GjzEeNOwD5lIPGWeyIDOToYzxIPgIsK/LUkU9gTST1WLJ?=
 =?us-ascii?Q?sWuGa07d+iogItpRQtxGvRJuABV25isuj1qpvb/zAb+owHKMgkAuPttmLzdN?=
 =?us-ascii?Q?8NnfusokjUuZFX9nDpxZ4tTtfp72Pcdibcz4Ox4K62+0T5s2K5sRsUPVZOT4?=
 =?us-ascii?Q?+GLSVyqwmYQ5O7BAhYODahSMVHUUku91pF8IWhf/f9kLfpcDJJSRm56OjAlS?=
 =?us-ascii?Q?z0ma2t4aJfGAOmyckNBLUa4moxPFYlEsr73VSQ6L1jEaTK1SVVRcprW4biP/?=
 =?us-ascii?Q?4fNdQYh0AEmzv916zjVMWf5ktwC/ea7DGSndMZ0T8jqNq9zQsUj2iMlM+7/n?=
 =?us-ascii?Q?8h7VSQKQOhWz7ZJyr9ryH/5EY7eeMBffv8fkyqhqnO9mQw0zDo1Hh8eDaJOD?=
 =?us-ascii?Q?ZF4OS+t2M1dH6RKwvJD4Sfcj9PlWiOcaOStj+QyF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f534aa-e353-41cc-efd3-08db1a505d41
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 12:27:46.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81S9Rhlu+BIJirFv1tDYWqGQxWeJc2q1EYUxBKgCsVVboZrhTlV159CRF5EOTlmi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6300
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 01, 2023 at 11:56:53AM +0000, Krishna Yarlagadda wrote:

> > > > +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> > > > +			 u8 *in, const u8 *out)
> > > > +{
> > > > +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> > > > +	struct spi_controller *ctlr = phy->spi_device->controller;
> > > > +
> > > > +	/*
> > > > +	 * TPM flow control over SPI requires full duplex support.
> > > > +	 * Send entire message to a half duplex controller to handle
> > > > +	 * wait polling in controller.
> > > > +	 * Set TPM HW flow control flag..
> > > > +	 */
> > > > +	if (ctlr->flags & SPI_CONTROLLER_HALF_DUPLEX) {
> > > > +		phy->spi_device->mode |= SPI_TPM_HW_FLOW;
> > 
> > Shouldn't we check that this special flow is supported when the SPI
> > device is bound to the tpm in the first place?
> TPM device connected behind half duplex controller can only work
> this way. So, no additional flag needed to check.

Just because a DT hooks it up this way doesn't mean the kernel driver
can support it, eg support hasn't been implemented in an older SPI
driver or something.

If the failure mode is anything other than the TPM doesn't probe we
will need to check for support.

Jason
