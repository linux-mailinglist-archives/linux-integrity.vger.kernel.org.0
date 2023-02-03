Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033D4688F7F
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Feb 2023 07:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBCGKX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Feb 2023 01:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBCGKR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Feb 2023 01:10:17 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE708AC01;
        Thu,  2 Feb 2023 22:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675404588; x=1706940588;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M0fLcCGV/csLgKoDwCXawhdwj5lvNdzWe4uaErkdFBw=;
  b=IkzCrIX2lxSasD2AZJ5rB+GRzcOfo7vZeDoyrp0w5bHzyRg0RHDTv0oa
   JpCwThWv4zMg/j0DXBnsvu59bBOpI2NgB//RLa+JNSJX3sWsTWT6kRQFp
   N+BtVH903oNLsy2v9Rjft6/Sm+d8i2hs5goIy9hF6h7E88AKaT2Hm0tc8
   7KucZUp+G75GrhSActMU0imhx2r/6q+r1loLJzvrIMSvf/XcU20+tWMb8
   U9/LED5niNjVWpqfP14BllEKw0lEN9mO5kfDdl6T5vIsZ2vnR/vhYx/9M
   BlmXhHz1VYPppZcKT6istQS+wVA21EenAO+BOgeRoLhYzz5kNQNFUXmaP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="328683613"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="328683613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 22:09:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="665594997"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="665594997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2023 22:09:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 22:09:25 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 22:09:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 22:09:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 22:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0QvsKtdK3pZyOQcdVxaXyL5lqjYomKln6fnsh7y1Cstb8G6KDghqLkO+We4HrfBD7ifVL2NNJrVkZAE2sdGTo4XFLI4Fc4xKcRl9dv+riXfDIQbJXvLs3vaEi87KdCzH9jWuNejN8/ZlCgwFoHM6tHJE5mKxJcVCNkMigzZaZpqZ3Em/GCQVh+EeIdaGw4/6Zf3dTWZGyCUbwpJl9l3n2t+32qgUsusjs8Oo4loAeDXEZAv6Z+BnsZety/KXct8ZVKHIfkznhTzrN76KWeYXwYq42lLnQ9KZQyZr5dxOgoyOFTgMHRvK1mNSJ3TUIUS1lSnfAGqG/kn8ngjriW6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQbXQ0trs/20oiIQZQj55EOa4+wN2Uv23FPTaOitTF0=;
 b=Q0fZtYgGd/0Cta5Y6Y2nhgJHmkN8DsWoTp10azCrSOoZ8Z3dm5AsA0cnE1gRS8uXR5D2xd3jw2k+fukxW34jqjUECoxcvAlnFrZ7sk/9hNlgbPd1tz4Opw6+FZSOtGGbEU9h5yfgp3NHPho7B6wW8q71mUN5WPDpm7jUr7BFqfhnLGGl3QfpF57iHyfQVC/Azf9gQY5UbhXEz+yc7ZNMEYOks14dSwVFA055e/Vo31fXn294iBORsbBVTHpkUBGqMqtpinyTOLVRYEfJUN5qP5IazRzukQNuOJT8x/Gca9iTiWf16eax8nUAQnXExi8IeKCi3RV6dW8yQUoJhorBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB6832.namprd11.prod.outlook.com (2603:10b6:510:22c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 06:09:22 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%7]) with mapi id 15.20.6064.028; Fri, 3 Feb 2023
 06:09:22 +0000
Date:   Fri, 3 Feb 2023 14:06:48 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
CC:     kernel test robot <lkp@intel.com>,
        <linux-integrity@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        <keyrings@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <Y9ykeASyzhSKQCmx@yujie-X299>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
 <202301250706.deGvd0yq-lkp@intel.com>
 <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce21b38-689d-44fd-7d79-08db05ad319a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVaI1JjxfR512iFyXEDaNINVUwhLNwmNgxuRJOD5f+DyuiuiZMwPClh88VtnUYwIEzEuA9l4EYji8gZhKbAxzxdM/KBwEgGFgb6kVnlfZhs1LnfToJBlRoq16SmSR77rTIbhmVW3QWvOI4aNV2QiZW8iQ3yxrvglM90aulhqYx1091kb4UeMTfz+cwsClek1d0DfXF9QZ2Dg8NRgmG0x8oUI8XQ4/W/PJJHYfAwHJHDKGKWFFpWxBo6FEqiEeajlkwn/R1jAyLux/CZQFn1AOa17JKle/C6GXw6zxO2c0Z/Yn+5oB8J0pHPrW3MGsaeOvXhCTI2x95wEszESeu9UM16bmW2bAEAOAO50ZrwydJ4hIk+ZP9WRhGwsWD8+Hl7zMPeWh/to2YO31o6PmahtAMnYt6bT5EOvoyvWTos3TRqICImSoMHBNtP5vYBfCtFptamTCt6Qs9sRpnicNxWIEYUaT7D4iXkeh6F/E03QhmKd3H42VJ9vRr8/ya9/zQi/a8/8GPKs6kONGGonF3zfxXB5XRvmPjQxOH4SxiU4yS+uRLnHO1rtD4IZQMIG79tDJY3JPmKHow6mAxvhJ6Y5tZ3bKZKwpWKOVIJmOmFgfLO/QU1/Tvd4NVj1NzK7XckDguVoZVBVK8zA74cPflSN7/KheCDM5zTWMsnVhT7jz60oQeN3K3SPjgKqx4cwY9nYDzdbcwW43pliF7raBbzI5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199018)(966005)(478600001)(6486002)(186003)(83380400001)(6666004)(6506007)(9686003)(6512007)(26005)(44832011)(2906002)(5660300002)(33716001)(316002)(54906003)(8676002)(41300700001)(66946007)(8936002)(6916009)(66476007)(4326008)(66556008)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vGp8343LEofB4yZMc1fDxL0KiEE26mhA3dOTMEUjct2E8Qnea9Qi3TgES5?=
 =?iso-8859-1?Q?evZJhtz/hRZdUy8iEr1e5EtqY551CE4H8QSu80SAa4uI12r6TCIo0NQcMo?=
 =?iso-8859-1?Q?R+LeHvcg5e4KJpH0YYAeIirJwqO858OtcpTVJf4T4uU/s5LxXFZlmnT8To?=
 =?iso-8859-1?Q?3neF2SswXzI8+gSHPZMMnEq1FZvcrVzQ7oMrEgYRRzmGR4NCU/+r7TbU6M?=
 =?iso-8859-1?Q?sA0DkVSzwlGUlqetaVR3A+B3yehZHHHzK55rz7FvWiyGd9vXEXbO1BtQ+W?=
 =?iso-8859-1?Q?On+0Y6NCvRzcDJXsEH0PRAr41MtqOCzU2E8u/Jyv76DXTk7etkry4HPxmc?=
 =?iso-8859-1?Q?ZkAQQ0trfAHRiGkIsda0Udq1Dh2A+yHy5mdea9mwkZ3fKdYjz9h16s+NpP?=
 =?iso-8859-1?Q?bezoOMSxbG/iDlWCfxNexJvPxipftsabI5QMGNYGqZy0eodniMMy0ILue3?=
 =?iso-8859-1?Q?m1TKRSRmhShVWzvgoRIvbfGmBadcOzGQ81LDMNL5cbKlIVSP8O1zYOM7hO?=
 =?iso-8859-1?Q?1BgPGOWNYNUu5zmpU9LPjA22xoNJIsk9jNg9hsyGTBDqCyN/eV4OJ3T143?=
 =?iso-8859-1?Q?jFrdiwdMiJxPOebAeYE/+GnJaTwTZQ+p/vmcPkk3L8ogCmOzx98519xO+L?=
 =?iso-8859-1?Q?YTZjqcDSmzcKRqmqdtUZ93qbFRHRzVkmHHFH0Qrc/d1BJsC4bdNzanuF7S?=
 =?iso-8859-1?Q?hYvwWrHO+7c+61D8U9NABFvnlmvX6STGYFcHSkUPNQCGn7oP0RSphwKX96?=
 =?iso-8859-1?Q?Pn9ASkJl5aOuMVof1ySHHJfCHmnQexPo3RJAHwQD8/w9ukb7estbpZCTjD?=
 =?iso-8859-1?Q?duLUGSJ4ww4BJVX4UD94QEC2kU+Hdee1BXkBHD3DxZkTquw1FWrLNUI78y?=
 =?iso-8859-1?Q?/FgviSMJn5VmAo9LK0/ws2zpcr3K8/w0uZXpZarrozfdMrPze7yVyCY1R2?=
 =?iso-8859-1?Q?uqvAvZHR97am4g5+VbGNc8MTowOCWcDCOiF/HwjZVy9tP6hoIyD/2F76o6?=
 =?iso-8859-1?Q?kiA687OOT5uIDVN4TuaE8mH3ORGqNK4A6S7Dwbde40sUB2nsyQx4tqYYZ2?=
 =?iso-8859-1?Q?NUJbF+89h56ZWT5ummthu8ttiPM7J1KsuPgB5jGqIaAxBmpBqE2qsw8HLK?=
 =?iso-8859-1?Q?vnzPy+z7d8aTClIYZmN0Fw+gMt1nxBmLaL6uO5OnBmqtzJDMC6z3g2lbn3?=
 =?iso-8859-1?Q?MYu6BYiH6CqyNbcS76OzVnyxaUo0aq8OGdFR5Pyn71UblOxNq49eeG1NQA?=
 =?iso-8859-1?Q?bSm5OD07yu5BbwksGR1o25xW53qBvnx8m7ADbxjEUVuqSI+J7Ukkeg/W0/?=
 =?iso-8859-1?Q?We56TOcaTSkp0QWv/b/Y0XM491eNMMbGBi46drop3S/mYe7SK+Et/fOqzc?=
 =?iso-8859-1?Q?NbBOXkVMm591ye73JPgWbBoEjEKr29vz2fjgKWuZ4T4Sf+eHCsDMOZJ2b8?=
 =?iso-8859-1?Q?7nryU1CrJtvFtRDJ97ji2AbLrLKU41NYLBktJ8O3mIBSr684kEx8O/ddVX?=
 =?iso-8859-1?Q?9ZO1P20FukxNQoZBL0KwEXUY6cvBR1ARgFWSq6vY7nrg4fg89l4OcIU2Vp?=
 =?iso-8859-1?Q?CR2fwsCj5qkDG59V1hYjIptRjzMoao0nrClch+MTH9ClL1nM/Q7SWEsZsf?=
 =?iso-8859-1?Q?O9O4qg5fx7aWxIOeqDuepiBajlcyO4QuQb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce21b38-689d-44fd-7d79-08db05ad319a
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 06:09:22.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VnJORCmAgATpPV3H2jro9o1TQvxKouv0Y/yIdGKjPMiaqPPUTmH74QR9Xu2ozRxvyIeJn3VoGueWQ5IE1FU0qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Wed, Jan 25, 2023 at 07:59:09AM -0500, James Bottomley wrote:
> On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
> > Hi James,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on char-misc/char-misc-testing]
> > [also build test WARNING on char-misc/char-misc-next char-misc/char-
> > misc-linus zohar-integrity/next-integrity linus/master v6.2-rc5 next-
> > 20230124]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:   
> > https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/tpm-move-buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> > patch link:   
> > https://lore.kernel.org/r/20230124175516.5984-7-James.Bottomley%40HansenPartnership.com
> > patch subject: [PATCH v2 06/11] tpm: Add full HMAC and
> > encrypt/decrypt session handling code
> > config: arc-allyesconfig
> > (https://download.01.org/0day-ci/archive/20230125/202301250706.deGvd0
> > yq-lkp@intel.com/config)
> > compiler: arceb-elf-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> >  -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         #
> > https://github.com/intel-lab-lkp/linux/commit/dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> >         git remote add linux-review
> > https://github.com/intel-lab-lkp/linux
> >         git fetch --no-tags linux-review James-Bottomley/tpm-move-
> > buffer-handling-from-static-inlines-to-real-functions/20230125-020146
> >         git checkout dc0fc74718b4a786aba4a954233e8ab3afdcc03c
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > make.cross W=1 O=build_dir ARCH=arc olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0
> > make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/tpm/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no previous
> > prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
> >     1184 | int tpm2_create_null_primary(struct tpm_chip *chip) {
> >          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/char/tpm/tpm2-sessions.c: In function
> > 'tpm_buf_check_hmac_response':
> > > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame size
> > > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >      831 | }
> >          | ^
> >    drivers/char/tpm/tpm2-sessions.c: In function
> > 'tpm_buf_fill_hmac_session':
> >    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame size of
> > 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> >      579 | }
> >          | ^
> 
> Is this a test problem?  I can't see why the code would only blow the
> stack on the arc architecture and not on any other ... does it have
> something funny with on stack crypto structures?

This warning is controlled by the value of CONFIG_FRAME_WARN.

For "make ARCH=arc allyesconfig", the default value is 1024, so this
frame warning shows up during the build.

For other arch such as "make ARCH=x86_64 allyesconfig", the default
value would be 2048 and won't have this warning.

Not sure if this is a real problem that need to be fixed, here just
providing above information for your reference.

--
Best Regards,
Yujie
