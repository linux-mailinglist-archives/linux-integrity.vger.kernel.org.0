Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F05069415A
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 10:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjBMJgb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 04:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjBMJgJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 04:36:09 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C358C67B;
        Mon, 13 Feb 2023 01:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676280895; x=1707816895;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=IwIIts5SnwYtcR3xHATZbOGMxnqwbvjFcUB8/Jjn828=;
  b=SQHHg3zL1P7ym6LYdvPhMnwBMKRxB+6VxNuu/5wFlLAqIdWJR9cDM5dN
   PwQwRbFZpxYBpuYcnaglZwZ1kP8EMWEd3LDhhFyPv7RrR0Nog9Tw2yiXj
   1Nq0vV6ZXu1tGH/AvWGMI1q35ye9lURdwzkZGSVnC9mdpcgoym42CGESl
   6+VUKzYmBP27UlG2+oNxYR8r0pvcLq9W7TVQ8crI3KrwxBDj++bhFv8Xe
   i8T0HBnnrOpqJgrf5flfWOOl/mWz9P8wp8SEfe40jX4MG2P81pun7tXoD
   Ulg88J04qPVLQssnAm4Zg3qpvQJcPkXuc8n3WV3b7jxM7UAEnT3g+ehdk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="310484454"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="310484454"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 01:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="777774373"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="777774373"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2023 01:34:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 13 Feb 2023 01:34:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 13 Feb 2023 01:34:42 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 13 Feb 2023 01:34:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn0UVle10ImH8Ibj6iXDHABfghW6fF0eKKHY2TMcXBZFerx47QwXPQgZ+TabgChQiv43YNuSGMVBDZ06Pbo0jYqelsR3ZiK4UzAIlI2eDLCwytFWGBAAEBwNPYC7XUzDf619qePvs9Npl3//26TiNLB6NPvpIkbizBjsxNZbWKMnwc7JvRLPVUM6fVuBTgh+mZcDETZr63OUnUvr/v1GkJoiXghl3TheyzYu6xmp1gpjG8Q2+QPLzRSJkR7jw10qv7rCA2Khco+DZMtOHzb8NHgpRVEJredR6E39wUn0l1ngTGkRdCEonyR8fYDfJioBg++rHvKxC69GafsVDX+4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98fXN242SEULnipiCsEi5k/+m6O3Hm3OPRT3bvFSQeQ=;
 b=lknTR2aYgCC+TXFnhkWJ6MyiN6fpLJ5l9SoXdu4BmbrPjIaKXY67oGlNN4NLo2RY5utyLUWaxWC+WZ0Tbu8syYlOkP/abi43PNHcx5OxsTJj1TJN6gb6HFqBBPTIpcNmnqHruJGKUA3FgNA+Qs0nLIT+fEgbOTHQrgN0nOvAu3+JDzXE0t65UL+l0BHzJhIyUGoSeKUvGZWbTmsV+m68OPVlY9KGRJvVj2Yu7gxTr2BJY8dfPQkdmzQpprTVB9OkdOMDjHJSgSEy144zxCwCilpV/uI67GQkzTXSFqiF9C8enhYLzPjTVGnuqYNgWgYhKE/s6PhZQ+iWgr1fzbUiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB7632.namprd11.prod.outlook.com (2603:10b6:8:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Mon, 13 Feb
 2023 09:34:39 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%7]) with mapi id 15.20.6086.024; Mon, 13 Feb 2023
 09:34:39 +0000
Date:   Mon, 13 Feb 2023 17:31:58 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
CC:     kernel test robot <lkp@intel.com>,
        <linux-integrity@vger.kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <keyrings@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 06/11] tpm: Add full HMAC and encrypt/decrypt session
 handling code
Message-ID: <Y+oDjm3dpqtXx1Jv@yujie-X299>
References: <20230124175516.5984-7-James.Bottomley@HansenPartnership.com>
 <202301250706.deGvd0yq-lkp@intel.com>
 <a588a74bb930f38c9322dd51d21661398b5e2bb8.camel@HansenPartnership.com>
 <Y9ykeASyzhSKQCmx@yujie-X299>
 <Y+MNxmzlILarAlZA@kernel.org>
 <3109ff421139af6b0d9e66a06d8399135e546fa7.camel@HansenPartnership.com>
 <Y+nqpLm2YyYkcZ+H@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+nqpLm2YyYkcZ+H@kernel.org>
X-ClientProxiedBy: SG2P153CA0041.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::10)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 9239b8ad-7b0f-4c2f-4858-08db0da5870e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xszldxae3+fZur1s/YxVdXy3zy/6oVhASXXOVfiYe5n6QNRPgH3jkhKU4bNkVeln69BgfcD9X4anSXTB/vSzzpCuvbHKfKJlN5dgL3IQ1StpgF0oSRGJ9ycu+CS3sa1UNuTqcDHLMh4+oQpmGPgzmc59JQK73fJ5XsHgDaNekDvPp75/9BCSwHq//UPxZjh3OgTJtuqHygcJZ/RdkmC22fZh6F4IkieCeMfHlIINFRdMc2dEnpnATtCSFPWIeu0DtlQWGgkjDhQ2CWQv2FSxcCaWvnE+rcQ9/iy/kNSYc4YzbczFiHjCJj4hwSsK7/hEuSYZsRwiOy719ogaUhuzSceJi2eBq3iYXkevA4IMaU1gZVugWjV3dRKw/pRzwN6ALd/o+lZsHu4x4c9tJNZFQW9RzthWJjxtZ2KFmCBIfZHjzkNIjW5Bu/LTcAs8Rq8PoS/awEWsAqPZnf/EurCtdBsTcNhJeHLLBkvko+Q7XX09Qnls+avXJHniIp5Rya0cMDcVDj1GXPl8G7uZ9+nDXqp6TnKqvsofE6CwfJKc8e+PSEFyiFa4fOT81TPG9ScF9uOqL6SCrkfIurxQsZnA0yVu8vx3nyFdOPfej3yCPmO/S3bFAR1edeB+x5bj9mYMj6tEIN2/lB48OF8xIgtBGFpCaE8WMVU0tM9dIHgPw+R6+chEL4f6Im4glgAB74x4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199018)(110136005)(54906003)(316002)(5660300002)(38100700002)(8936002)(41300700001)(2906002)(82960400001)(66476007)(8676002)(6666004)(44832011)(83380400001)(6512007)(86362001)(6486002)(478600001)(33716001)(4326008)(26005)(66556008)(6506007)(186003)(9686003)(66946007)(66899018)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?z64pzZYOdSFjJ/Z22ITAYsXX8zW0Tnm0VztiGp9S0eJrLVE5Bjn0OpkWvA?=
 =?iso-8859-1?Q?R+zyOewJ/5LhLbaNWd57wwzVLsSXEALpAFIEzzDq+qGQQTph2s5dM8VEMv?=
 =?iso-8859-1?Q?LEBEI3b2ALCCcsobyhqhHRdxRKQt55tAFEzrTwWooWe8IjumUUmiTxdcJL?=
 =?iso-8859-1?Q?6PLFgr6tlwg7OnMwh/aaLbydeiGmmCTBfHWsY13jBiWu2Ort0FA2RZNgsD?=
 =?iso-8859-1?Q?eHPoyw5mp2B3h4oxnOckPjiVDbdQkBjB61wz40YdiAADgHHukqK1qpSf0k?=
 =?iso-8859-1?Q?DZZUwdAdkjshRSD527VHRPpj9okmm4dlzeqnJon44bd6+Bs68u/eUBOwl+?=
 =?iso-8859-1?Q?K/LCDKgCuK0ZKNuQxtb06VhNDAZDVtUiV1x36Qfov6wIMRl+CLa4ohKOxD?=
 =?iso-8859-1?Q?4J41ie9okY/1qxqQ7hCPa6gJzrmxkqoQYpwgdkHgtAkCRnnEY35IdBUp7o?=
 =?iso-8859-1?Q?mTzwTcBt0xLfRP2a/ZElM3B2pZMEWk4pIvBC/yp/+Xs8Oreei2zXgSrSB4?=
 =?iso-8859-1?Q?nRW3dkS8DkGeEbsNdz1YIklpNtex4c7ku+7G2BWTFBCvxU62RASHryOWQ6?=
 =?iso-8859-1?Q?WzsAY4LUJgo+j/jMtranWIpbHvCIUgTXBRl9K32lAYjRpcYJAx/weGTvF5?=
 =?iso-8859-1?Q?DVI8HZW49bvR9+CBBdKORDdQRaw0kXWB2BAqf9wTy7eSacjG4VuGwAWsgF?=
 =?iso-8859-1?Q?mCzGWH4DvDR0QhKgEI3/rqxnt99GkB3QwpYxkz84OPR7xKhX/eAJaCH9d3?=
 =?iso-8859-1?Q?rN7nfvAW6U7mfba7YDo+B9D7nH+ob5eh0gP0kSKFFy8RxkTIhR31IqFTyj?=
 =?iso-8859-1?Q?Vcz3yn+WGaiqfa0htF+l4n36FQ3/LckRfY0GJdUPoQT7HvhPTMz73UsTFw?=
 =?iso-8859-1?Q?N8IzHp76Ky4fvaUZ5HNsGARH8f63xjh7hoNsUcnI7/NWJzROCxxCHySCVQ?=
 =?iso-8859-1?Q?qA4AEgg/+1QDNuMS32Tfwjm7q9tBKHXMeYxJe++FicojAoE5kEPHeJ0HVj?=
 =?iso-8859-1?Q?7mxYvr9rkvvegUfBXg97AjWyWDqa7EM8nORLfsNvkpBJZQojojxLyy7U+R?=
 =?iso-8859-1?Q?UOX6YHIchvzo3d2Rq3ATX31KlTy/AgpARaN3f912yq7i++FLc81b59aNJS?=
 =?iso-8859-1?Q?4sqgCG7gBlg7nb96MOfS9Ffm8UBZm5nNpHk0t7x4RRpj6ZbfwnD71NlHHl?=
 =?iso-8859-1?Q?x1AJ9EFrIcD+kRjGmGALB4/cDAH7VhftVg6XXG8Yh4NOi3IlXB8uwkAM+3?=
 =?iso-8859-1?Q?uVOCBiF6/0YYSe6J/711ATGf68qu+izKuZn9zVLGsVVM5rB4aDGnG7wua8?=
 =?iso-8859-1?Q?MhxCYevo7WT3GJhNoOdvuo1h8b58JVSbPfhn9+K8hucBUj/746hkXN3jE/?=
 =?iso-8859-1?Q?rrUWuMz0ny1OrYhslNpQ/u+T/2rK/P0ZGZEnW7dDgFzSxo2g+3xPWEXD0D?=
 =?iso-8859-1?Q?cLG/njDbGS3jX553adS9N/iYVHhqgsLGoaShv+JDZiTYC0mjRVShqiQNy3?=
 =?iso-8859-1?Q?E3qMUr6ttaxxtqyDpLDTkqiQ36s3F8DqHSMhpjCflLEkVXVs9sIFC6R262?=
 =?iso-8859-1?Q?5Iwg6T3HkElueWE9k8pab7DyGIc05x72f33rN8/ILnRK17+3ylEa0lsbrv?=
 =?iso-8859-1?Q?0fnJJDLK68iA2M0YZtgj/Es21zAp9vNLDL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9239b8ad-7b0f-4c2f-4858-08db0da5870e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 09:34:39.3275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wTQ8Pzzv+KlUanC3dbREMBShM4wjqh8MWejSnP7MoETmOph0f9M9/eg//J/8O3k+SMwA0j+amUGX2/S6H39Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Feb 13, 2023 at 09:45:40AM +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 10, 2023 at 09:48:15AM -0500, James Bottomley wrote:
> > On Wed, 2023-02-08 at 04:49 +0200, Jarkko Sakkinen wrote:
> > > On Fri, Feb 03, 2023 at 02:06:48PM +0800, Yujie Liu wrote:
> > > > Hi James,
> > > > 
> > > > On Wed, Jan 25, 2023 at 07:59:09AM -0500, James Bottomley wrote:
> > > > > On Wed, 2023-01-25 at 07:11 +0800, kernel test robot wrote:
> > > > > > 
> > > > > > If you fix the issue, kindly add following tag where applicable
> > > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > 
> > > > > > All warnings (new ones prefixed by >>):
> > > > > > 
> > > > > >    drivers/char/tpm/tpm2-sessions.c:1184:5: warning: no
> > > > > > previous
> > > > > > prototype for 'tpm2_create_null_primary' [-Wmissing-prototypes]
> > > > > >     1184 | int tpm2_create_null_primary(struct tpm_chip *chip)
> > > > > > {
> > > > > >          |     ^~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > > > 'tpm_buf_check_hmac_response':
> > > > > > > > drivers/char/tpm/tpm2-sessions.c:831:1: warning: the frame
> > > > > > > > size
> > > > > > > > of 1132 bytes is larger than 1024 bytes [-Wframe-larger-
> > > > > > > > than=]
> > > > > >      831 | }
> > > > > >          | ^
> > > > > >    drivers/char/tpm/tpm2-sessions.c: In function
> > > > > > 'tpm_buf_fill_hmac_session':
> > > > > >    drivers/char/tpm/tpm2-sessions.c:579:1: warning: the frame
> > > > > > size of
> > > > > > 1132 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > > > > >      579 | }
> > > > > >          | ^
> > > > > 
> > > > > Is this a test problem?  I can't see why the code would only blow
> > > > > the
> > > > > stack on the arc architecture and not on any other ... does it
> > > > > have
> > > > > something funny with on stack crypto structures?
> > > > 
> > > > This warning is controlled by the value of CONFIG_FRAME_WARN.
> > > > 
> > > > For "make ARCH=arc allyesconfig", the default value is 1024, so
> > > > this frame warning shows up during the build.
> > > > 
> > > > For other arch such as "make ARCH=x86_64 allyesconfig", the default
> > > > value would be 2048 and won't have this warning.
> > > > 
> > > > Not sure if this is a real problem that need to be fixed, here just
> > > > providing above information for your reference.
> > > > 
> > > > --
> > > > Best Regards,
> > > > Yujie
> > > 
> > > *Must* be fixed given that it is how the default value is set now.
> > > This is wrong place to reconsider.
> > >
> > > 
> > > And we do not want to add functions that bloat the stack this way.
> > > 
> > > Shash just needs to be allocated from heap instead of stack.
> > 
> > On x86_64 the stack usage is measured at 984 bytes, so rather than
> > jumping to conclusions let's root cause why this is a problem only on
> > the arc architecture.  I suspect it's something to do with the
> > alignment constraints of shash.  I've also noted it shouldn't actually
> > warn on arc because the default stack warning size there should be 2048
> > (like x86_64).

The stack usage varies on different architectures, so does the default
value of CONFIG_FRAME_WARN. The warning shows up when the stack usage
exceeds the default warning size.

For arc arch, I reconfirmed that the default stack warning size is 1024
no matter allyesconfig or defconfig, while the usage could reach 1132
bytes.

$ make ARCH=arc allyesconfig
$ grep FRAME_WARN .config
CONFIG_FRAME_WARN=1024

$ make ARCH=arc defconfig
$ grep FRAME_WARN .config
CONFIG_FRAME_WARN=1024

> Would it such a big deal to allocate shash from heap? That would
> be IMHO more robust in the end.

Thanks Jarkko for the suggestion. This would be a faster and better fix
without having to look into this arc-specific problem.

Best Regards,
Yujie
 
> BR, Jarkko
