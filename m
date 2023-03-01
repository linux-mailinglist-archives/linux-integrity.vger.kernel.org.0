Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E16A6FDD
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Mar 2023 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjCAPil (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Mar 2023 10:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCAPik (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Mar 2023 10:38:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8013D6F;
        Wed,  1 Mar 2023 07:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBQDMjjGixJ7te901epFqY//SMqWOZOLpeC+HHY4ZieVpGLz4lllHdc2s33PZ3m3XQ2rfEjB1EsnTjxBgF30CCI0h1IEoagiGQKdPcG5J4/AhuZpqMIeIwyu9rLh2aXAzqDTM0rMkhR4KXz/i0VcGPsMJXnn6QZw7uohOvzjaEjE1785Z8MEzypZO55P1ofqpIjSBiR/0pCe02xmrLlhWiclVXbnqm1nFuLCmqUVfLu2cDOyJkw55dJLj/3/4A1VmocoC08uKu9yUvHKs1aN/tqtXiRKwbeMsXQTWl1RMrA74rxnEq9i9r2uEKXM2XQdNn+ngMkNEEAmVl5ub21Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msDgC+eVwao4GCoq3xMepfhsqhuzAXTaQ53y8/BNOK8=;
 b=S9B7+Bsu0xT8gQmbmZJ3gGbLKV/yzmITiD4wN3HmGcHu+ABsxRZJ8aCzAl1jMNNct7Q55Ldovo7DL4KVC0Y39F8XVRb7j7XCV84pw02Yvfu5O1weHvDMNkFsCk2cSTHtl9p3g6ZpzfCv8R8uB7D5oOSyohCVzTY0pVUsB4s2VV9nHpMjt2AK05+DMDsiQhlAo+VWzI4fDXVhS/i+2ev/QclSFfKtqueqk00bzUwd7NgS4obJwcrOOzqkWWJoxb/q84ihWNhpAakRzI1UGaLSaeN3qEOJSV3pjNMjqMeF+y07L/RGNo/+eZj/jnpe3nhHUfSVlIBWcykW/cKoW3WEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msDgC+eVwao4GCoq3xMepfhsqhuzAXTaQ53y8/BNOK8=;
 b=LxiLWLCtSHZBRO7NKMqC5vjdYtGdjdoPEL3YNtHfRJKLVWDKLFDu0l0x0+ayv594mn+UPUBgc/K7nDD7Pfh+upVzM5FgUoY0p//A3HVTdTpkvMAYZjC2mhhUbubmhRDop9PBcIeoSbk2kg50iRzYXCnYPI9yeth4QFOSQPlfJw3kipxI16bPaTiMEFdpJlD8hn/vaoBYfr/cPY+nleEKWu/pEJ222N4n+QNZXXcRwp16G4bzhNUH/gJKuEskmcxuOHsN/vIlPUD5yib70yWaSprhB3l7lJQnLvFYGrFG7zKyGuD4rxsg6I1Mc9quhR1fSuPv8VTxZlkP1jN0vYeAXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB7863.namprd12.prod.outlook.com (2603:10b6:510:28b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 15:38:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 15:38:37 +0000
Date:   Wed, 1 Mar 2023 11:38:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [Patch V5 2/3] tpm_tis-spi: Support hardware wait polling
Message-ID: <Y/9xec98YXB/6G11@nvidia.com>
References: <20230227120702.13180-1-kyarlagadda@nvidia.com>
 <20230227120702.13180-3-kyarlagadda@nvidia.com>
 <Y/1oqr0RfD7KVA4y@kernel.org>
 <Y/3zVdgnVz8BvGGl@ziepe.ca>
 <DM4PR12MB576942B7C00F446BDF58D984C3AD9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/9EwTtmxcVBjiHz@nvidia.com>
 <Y/9HB/KF2Kjkihkg@sirena.org.uk>
 <Y/9VkGjCP48FHtyS@nvidia.com>
 <Y/9clKU9lAHxvOdd@orome>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/9clKU9lAHxvOdd@orome>
X-ClientProxiedBy: BY5PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB7863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6f6106-dde0-46c0-f0a9-08db1a6b05fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BvClaAieaBHO+C4OXBVRV5t32GOzqGTXTAvyhMoo/ATq74c5cSlhZbkzvZcsz351ixbMIHKh7FJ7tVxbCQ4WKVhxSqSebVLpuTrkEmLQ3nRG7iU+zUil9nJhI2gqDKdjS+RuiUKD5RH6kOZBvYexVgg+tLeP8ILzOyUefyOAW3P15/n0nRgH2UhKCX7YR0HKYE9eX7y+ddO/WFwqvagG2RW8GialDO9TuHp7L7vn4v2VmgpB/EirbST9IgVbewQ0uwYQJqYnD44V8igI4cgOgV43pkMhg0UbDfaPDye/fRsLkiojc4ABJLNDbLBGBRSWCwNRi4eDTJpuPB7jVpgvU3JNJP26HnzzDYCfJVAC97HnTZrN0Cxk8bMylHPmNacBw3LPORFuXbQlPVahsTuc7lXXsqU8X8T5DB3+tf2uVubgqurak7JZFUv05EtoQTpQdwahcZRiPpHWURBxcD289+ezu5ZIyx5w9V3DEk1Dm20pmdKk8jKdEo6fAXgiVyszStP7EsV9VEG3K439ZT0aR2+KLe3V5kkyXSk9aZhkZRaTCgaqp/cNeEWdlleJNHbAe39QASjM831N2pHcUe7vPH/5KEVx/9J1DU9MGbWbNv3Yshv6jzFHo5Y7FiH/unzmF54kc8n1z0kdbDKO29HA2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199018)(41300700001)(66946007)(316002)(66556008)(66476007)(6486002)(86362001)(107886003)(36756003)(6506007)(478600001)(54906003)(6666004)(26005)(4326008)(6512007)(6916009)(8676002)(2616005)(186003)(2906002)(38100700002)(83380400001)(5660300002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3RUE1/6JAq7kQ7hzuP5lNHC3kCOMJUEtW3Pgw5S4cpY41t5goBsG6zqEMDfS?=
 =?us-ascii?Q?ZI7tBK2geqwzoLEvkXfj4yEjBUMwqEYFghpncc4yH9Vu+qcF23HBN1YUdxFV?=
 =?us-ascii?Q?nfoyItrNzKLjg9Jk79wceiZ2VaG3Ah1KnCkmap5xfX8ERLnNG3XqsYI43SNh?=
 =?us-ascii?Q?ZVTp6so5LbZV1xWsaEZC1t71dFVP7JsFaMzOuZvm+Uyb7DXZR2N4eQuSYFMi?=
 =?us-ascii?Q?OFoE2/h/iQ/oN8FqB7u+DLetYXZw4pRIn/RAMPFRRT5v/AflqzJgkYL4Ir+D?=
 =?us-ascii?Q?9o076zmSKKP1qEPCwpQjzQP9VIrXAArOLSl6mkdrlJzXf8Qtaaz51HUUUmuW?=
 =?us-ascii?Q?DVMfK9Z04oQlI8VzyvyQAiRogImI3+kapGXXFBXGOzohT0zbmtGIxd6XQLcC?=
 =?us-ascii?Q?TmDvD908cPGA76Lorab1AvbJsU3Pg2n6y3cLsi1XU1TgviON58SQA5kpjxYv?=
 =?us-ascii?Q?SyceUd973vvFTigB1RuRByZpNDmbrB+Kcriatuy9QL++CXpGRDP5s5pbX9Yu?=
 =?us-ascii?Q?chfIDQ1z8SdTbaVwm2LNiDFWm8Csb1Iins4maxgMybJimGDTGApxDpoLTYUt?=
 =?us-ascii?Q?w+jYB3m1ZXaJe+SekT8oD6K2+NYeeFNvzx9LAxP8nCPI61phIxj5yHMLxz1j?=
 =?us-ascii?Q?3DD4sD0YTfw7ZHveESXsQbfKbkFwxAboDo3se4MXRYffKDEm/aIz9z8azokI?=
 =?us-ascii?Q?PTc8jadSnLyk5+TN1uvOvuU+eWwDClT2H0/NRMNVqHuHFCdDiQQAldTiV+Mt?=
 =?us-ascii?Q?l/1axGtQkzLtMD2amrd/bl+TxYMOBPf/iL/LJEDQiavt5uoDOs36+PYxYDaM?=
 =?us-ascii?Q?JKmTVmyI/AJx0yLO/TwCS8Yd7892aGeFwIpIhNcNiPxbgLp0BWn5Xacg2zye?=
 =?us-ascii?Q?CXIxF71DqN+z5HN4h52leyojuvg+JCBNMXYE+1SLycLmUy4ndy+H039cCTJm?=
 =?us-ascii?Q?bfNjY+HERjSzWFv52bAUod6KN6DI+vKWbI5gFvSjZLLRnU+2FmelVDo1eICR?=
 =?us-ascii?Q?xnml/MaDTwycTpwcSjIQufixDMxrIMcYeB9wVwW00qFh0yMYIuABxDw0bNOH?=
 =?us-ascii?Q?RZ7SVmUqUJBsbFOOB0YfoEH5PKvbwWcjrfuCPG5FCFdngnXIRnUNDpWH6EsF?=
 =?us-ascii?Q?IlYkBWTiKleLypMV8tkgw33e0Xr3/4ueQ0Fbw/YiOqVxDxYCjSQmB1e92UW6?=
 =?us-ascii?Q?xHb+Vjq1rby3ioj1SHddrWafhWpr/rDJJwbcoH4bSSdu/SFYOm4uA6DMioC+?=
 =?us-ascii?Q?BMlPQi2urEGrwGN3n+hbZ/ckj+0FJAuFs6N5EEIYGNU5BVldUXGyxSnWCe3k?=
 =?us-ascii?Q?FgxFfpmECoWW2e6ea6hL1BZGzMZtjEEIrWLwehdAUlQ2r31tAHeCACqmR8iw?=
 =?us-ascii?Q?EAPdLmT+s6mkVZS2N02Ftu3mwZunR+KFC8H1/Q/1vVZ+24AWkdoD6QyDMIit?=
 =?us-ascii?Q?KEKeOs9Uha4IanXM4DgVP0kGFgurQhL/aGjmn00/TeV6P+KHOP91CEgXOj0D?=
 =?us-ascii?Q?+hFv0hSyFe039ROXVdeXRFquVaV1h1QuJmMI68FWj27vP17dvozp0cx1hudn?=
 =?us-ascii?Q?DRrziamWLSQ342JJHfKgWgbOsxd/viZsrvrL5VFv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6f6106-dde0-46c0-f0a9-08db1a6b05fa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 15:38:37.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQpcIefbSRw33/jSZfJ8G1JoH/6CI1sBZwIcuY6dBLxVeXRyjBaF3RV9+J87UJQb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7863
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 01, 2023 at 03:09:24PM +0100, Thierry Reding wrote:
> On Wed, Mar 01, 2023 at 09:39:28AM -0400, Jason Gunthorpe wrote:
> > On Wed, Mar 01, 2023 at 12:37:27PM +0000, Mark Brown wrote:
> > > On Wed, Mar 01, 2023 at 08:27:45AM -0400, Jason Gunthorpe wrote:
> > > > On Wed, Mar 01, 2023 at 11:56:53AM +0000, Krishna Yarlagadda wrote:
> > > 
> > > > > TPM device connected behind half duplex controller can only work
> > > > > this way. So, no additional flag needed to check.
> > > 
> > > > Just because a DT hooks it up this way doesn't mean the kernel driver
> > > > can support it, eg support hasn't been implemented in an older SPI
> > > > driver or something.
> > > 
> > > > If the failure mode is anything other than the TPM doesn't probe we
> > > > will need to check for support.
> > > 
> > > It's not like these buses are hot pluggable - someone would have to
> > > design and manufacture a board which doesn't work.  It's probably
> > > reasonable for this to fail with the SPI subsystem saying it can't
> > > support things when the operation is tried.
> > 
> > If the spi subsystem fails this request with these flags that would be
> > great, it would cause the TPM to fail probing reliably.
> > 
> > But does this patch do that? It looks like non-supporting half duplex
> > drivers will just ignore the new flag?
> 
> I think the assumption is that there are currently no half duplex
> drivers that would be impacted by this. If I understand correctly, the
> TPM driver currently supports only full duplex controllers, because
> that's required in order to detect the wait state in software.
> 
> So, yes, half duplex controllers would ignore this flag, but since they
> couldn't have supported TPM flow control before anyway it doesn't make a
> difference.

If more HW uses this feature it will likely look a lot like these
tegra drivers where an existing supported SPI driver gains a HW bit to
do the flow. Meaning DTs will exist configuring a TPM to a half duplex
SPI and kernels will exist that don't have the HW driver that
implements it.

So, I would like it if old kernels running against a new DT do not
mis-operate the SPI because their SPI driver does not support TPM
operation. Either because the spi layer refuses the request as
unsupported or the TPM layer refuses to use the spi driver as
unsupported.

I do not like the idea that the SPI subsystem will take a request from
a client driver and silently mis-execute it.

Jason
