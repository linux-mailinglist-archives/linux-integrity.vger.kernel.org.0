Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31A6626B3E
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 20:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKLTdC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Nov 2022 14:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiKLTdB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Nov 2022 14:33:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4371513FB0;
        Sat, 12 Nov 2022 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668281575; x=1699817575;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iKpWUjfE2wCk/YUv3iPRAyY5YP+p5wS0hZqw7H3IRdY=;
  b=K6AVvrXxQ/AsXqjBXtooaWHI7eVGAmnQWRmsY8UJxU0iCBfgf+SAEgul
   QlnT93XVRYVpsYJHGkvXtE+pT1d5SgjWzGytJNR/8IxG53n7VOjcf1XX3
   4hFslC4j7qz4MWt9PFgN8MkOgpwJaxKd1YO0K/n03yscWZLJ+ohNsfoqj
   Yv9WH3cmCtA78ug3Mfa+WRCnM2rmVoAEkc7ty6/4LG/g9bGDPZRh51u+U
   PISPEhwVvqpQ91ce4MSHm8fbS2t+fwRewcdjAuvg/634EQvZffsp2YUfQ
   UfSHEEh/RJXld/LDuKOPnX+roj4TpOte9Eve5XxiMgi6cV28RWj0TSYFo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="313552672"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="313552672"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 11:32:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10529"; a="701531170"
X-IronPort-AV: E=Sophos;i="5.96,160,1665471600"; 
   d="scan'208";a="701531170"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 12 Nov 2022 11:32:54 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 11:32:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 11:32:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 11:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hhc1RrlleSEVu0O8uuYP47NHpiQHr0kgoK0vGXAPKZW8aRtwnsHt5Ux1ovjqzQBaz2XISUAUHu6fVqEYJ0qFVkSJYBhRuXj6liCigFqdf6HrJwGC7IRnL6dQWm2eh3BIvoTQUdH5BMoqt9MPl8gm5GPUm5WdwCExUZtHsOySHsP4yiM82MqvTUcwjNNP8Zql/OVHUF4YCSe/3vV/WGO+nKo/JlHoQVNTXBo/bD5Rl+1niOFtQhyChjEUp2ZOSn3+bl5VSKvAgb/ZCLCUH+QELKMKnZT8CB8mzDvpzdvexEfRTpI3qteahXWv83zy7v6UcWy2twPc4giN3/ZCxHYDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luk3pIlUjrKttdOzdIxbm9MqGmggUhfRl6LXBMheQF4=;
 b=LVHvmGkyZX3709/bvNNch3FIbZopRpkEtQQF99xz8oeSTdj2+9slj1lxUjibcx2EXNIfd7/QwbK8XZU6sLc50Ds+OeTVRFriHycOktETpUnutUYkTeB4WULU3tzXxlcG0MuSbxFi8Xqalf2+sFgK1mQt8ZYHyQBIAY/e5wXfvjY2SPJeCz7ROQHq+Kw76l0mUQA2h2FcKfA12tZ2qHh12ljWLFxAl7KFQ+zgBuj4xqkqVfu+qsBkjST3N5CfG2jWeGC1vYhWWq0Wx8PhkP9q02LV2SowCaPxNPPFAx5hADr0+SdVQbe4zFVphEM5TLeos5CywNUAjNFONx0Iw3otWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Sat, 12 Nov
 2022 19:32:46 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::54fc:2e3c:ac29:58d]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::54fc:2e3c:ac29:58d%7]) with mapi id 15.20.5813.016; Sat, 12 Nov 2022
 19:32:46 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Topic: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Index: AQHY9gVLP43QalYY0UyVn396YXCToq47ruMg
Date:   Sat, 12 Nov 2022 19:32:46 +0000
Message-ID: <MN2PR11MB409396A8C5CA6D4DFDF52B9AE5039@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|DM6PR11MB4545:EE_
x-ms-office365-filtering-correlation-id: 47a696b5-274f-415b-4031-08dac4e4ad14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7iiB9kLEDHwIc4Pjp+sVpev7x7NaTlYjpiyBxKknf7QpiDwiLW1XKnoFGCYllowr9Axen2+CLLjBXERGHqKbvk68nxFUFC53+XE/MSC9d+hcS1qkjRi1gjvDOPDCg80k/UNHLU+MY7P3njjLkP7f4Ul3Sm0CGtTliM92xvLedJ3U529JnFD9O5v9ohOMd8G0cVy560fesphZ5BgPHTieAy4uZ/KAr5LyRPXyA7iSkOdUD9hNGX6/LpddmVTYleaa7ydZUxjbH3QLnt5cuXe81frO/NM6AMkol17AqUyCut1tW4UzQwmnlcdQnSGHFWuwA8UJZrNtweKKTWCxrKvBFK/f4K7M6mzX9al5Q26QsanUXWOFtlID5V8Jij3jJfcq0ut/QQ8+M0hWMfVsSv3zL2hUtP2xLce3N8Qxxv3zYmrayDLuVcXBG31OQJOY4XpGWV+4GXy2l7lRWOqdEk/Rig/RjLSIgRSDslbbmn48Y2x1DKXgli/tOpyeRUR5QbpiPst1+PS4TlBfk+hUfmXJOEqZkkKNsRExtzpIa009uquZtfcHIv+b/DqmElutdUljqI+BdcAH3SLMCtQUNKjD0N1dDnU5NPFxrfzsx+54s0qe9U1PLSN1BPtEzehO6aO82S1NCBjjXepWRRYief9FczwbPv3PXtyg70/mEQh2Q+9jApMnINOgmuXwRZMexOTDAlRthK069MCgXrvDgvdBedE36kReGagL8R7gKP3p5KXzoU4nqIiKo3dhjjc/+TcPaRbN29RQWIIH4jBa7q6BwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(86362001)(83380400001)(122000001)(33656002)(82960400001)(38100700002)(38070700005)(478600001)(55016003)(71200400001)(52536014)(8936002)(8676002)(76116006)(66946007)(64756008)(45080400002)(66446008)(41300700001)(66476007)(110136005)(316002)(9686003)(66556008)(26005)(5660300002)(186003)(15650500001)(2906002)(53546011)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tXyOh9cN63eI0T0+bjYqcUMnFoGFqFh5BJmY22cgXcH/ZIZuG9y2F1rTcR+u?=
 =?us-ascii?Q?9U7Y+i2BLzOiWzAiYMdAC1TU3OM5x/ilCMzJfTUOT3vEC+L31m7KaIs5z5z8?=
 =?us-ascii?Q?yYvd9PgcuK1LU3gLkQAx6zJwcsKCrrHm7+lZuWlDiAXxzpurcHiZ2sB+GBZk?=
 =?us-ascii?Q?ZBBuKBWkUJJv36XNYsNcJ/2LB4C/P9HWHoKuzr7Ot06MWCQpB9hMIe45M1FX?=
 =?us-ascii?Q?lHdsHa+8CDxOX7bk7LQt50QyrRXKJLuK8tifvOcqcuwhnXqIHfioNSuohWOY?=
 =?us-ascii?Q?ktORPC/E10d9U4gZosvfI/4ryze66oGoM4CTC74WjGKVyjkuyT/j7JU1gbJ9?=
 =?us-ascii?Q?hxsxHjhDtjSnArRHsj5YLuPVgoc3ccihxXkX0yhNZShljuUUyUudhQuID+1k?=
 =?us-ascii?Q?VcwHBQHWeCgwJfbOguB68TvKkwqlh9jyD/g96EI9+eI4Er9MPY9BH1l0KDuj?=
 =?us-ascii?Q?HG9TDJQqaELqS6kPxAz4KsX8wJI1Q1PETqebZtmuZJ6YF+m0CRQM+0iL1g55?=
 =?us-ascii?Q?fty737DZq8KexVAO5OCrH/pppk5vTQbsB3eQKPJNih8fRuml8GI8M+o507IQ?=
 =?us-ascii?Q?KLoistsFMppgGoqrjaIWFG0dlYECaTOEA1Cpz6SQ50PrPh5RaJ05MXZt/5xZ?=
 =?us-ascii?Q?0+MBDT5K3KAM+4NIGlD3GbFydAxlxlOcEX8xAs/c1cr+r6WCRuV0R8IpO//I?=
 =?us-ascii?Q?mX56MOWy5TGbiljl1Dh/l9XNEXDDNyEvUckZRIIrzRvmzeo+bdBUj0aIgxdo?=
 =?us-ascii?Q?OYjDMxgdwHfAvStBFvzzi+qr34UR9bNR6K0exrSZAnDIGrK1ykZLBB4ueNFp?=
 =?us-ascii?Q?yQGaN1vlvNPZS5uhbqs5d4KBS2jsAkogsv6F0wUuLx1UMXQnHUQmuH9oXjgw?=
 =?us-ascii?Q?DMTzKkpPdgR1voSEcRSSPWi+AM8djyBXXnurDFuN9DdRsrf0Xb+7kUakxH87?=
 =?us-ascii?Q?BrMX5c/QS3PJffzkenwXMj2rmUrnsS2XPt6/hM2z3U5EA75BCz1a0oQQvR5b?=
 =?us-ascii?Q?ET2/9qBpXHwwLCcHDz5g1T4dzcwppIuA7MPxeGcl+Uf/agxo70W2gBPrQ9lJ?=
 =?us-ascii?Q?6FXSVboUZ6zkqq51oiKwPKgHei0Xo1FF+GF3HZlNaBUXapUu4scAlLCK9Wtl?=
 =?us-ascii?Q?At+4W4yX6UA218HZ0rXcis9GAYt/OMQgDdDDO3Y++Sx3tx53oDOYJkgc9RtW?=
 =?us-ascii?Q?OSZ6dXtiwNPvu1/ko9xyRXJxaS4uvPQpWmuiGt3KXH0Q7YZmT2uRt9nZlrfe?=
 =?us-ascii?Q?UUzv9wgmTLJfb2Zr+ddcXTEImEwd5VwvNx1lyQ/e7SKaG+iEabGY0fI2fT8D?=
 =?us-ascii?Q?EtFKlVs6eNtt1URuhbY8haQfalIn6s9XZ9s8ZvZ+WCOzv4c3X8GCGZC3Qj23?=
 =?us-ascii?Q?7YJyJyVn+MbLrNktjdkzf2Z7FJHVfC9Z3OxKgU5EJkT6TPDgCepvliMIt1Tz?=
 =?us-ascii?Q?Nv8y7DwZZzbohVTvnHvubkEGa7iXVAKXYeiJsEzAK6qXYXTtcKsdMLqXsu0V?=
 =?us-ascii?Q?LUVCkr8iXVunN0JeZjqRaH/o6/zVJ5a1gmCIANk66QbXqie9wwBoOf7BJqcM?=
 =?us-ascii?Q?UfHnbTfbklZzN1e6QUVPbTv+zbKXaL3wso4HeWro?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a696b5-274f-415b-4031-08dac4e4ad14
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2022 19:32:46.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RnO31Ru3SxxhiDy9nL5QLEQH/zccLxpOGa4yc7s+l7HBfXG+UKDdn2/x81+5DfV/um7hjfpYczVCzLjj5i1IWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4545
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley <mikelley@microsoft.com>
> Sent: Friday, November 11, 2022 21:39
> To: peterhuewe@gmx.de; jarkko@kernel.org; jgg@ziepe.ca; Winkler, Tomas
> <tomas.winkler@intel.com>; linux-integrity@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: mikelley@microsoft.com
> Subject: [PATCH 1/1] tpm/tpm_crb: Fix error message in
> __crb_relinquish_locality()
>=20
> The error message in __crb_relinquish_locality() mentions requestAccess
> instead of Relinquish. Fix it.
>=20
> Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after
> granting locality")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>=20

> ---
>  drivers/char/tpm/tpm_crb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c inde=
x
> 1860665..65f8f17 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device *d=
ev,
>  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
>  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
>  				 TPM2_TIMEOUT_C)) {
> -		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed
> out\n");
> +		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed
> out\n");
>  		return -ETIME;
>  	}
>=20
> --
> 1.8.3.1

