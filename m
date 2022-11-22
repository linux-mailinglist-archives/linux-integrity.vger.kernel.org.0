Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E5634161
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Nov 2022 17:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiKVQXj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Nov 2022 11:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbiKVQXZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Nov 2022 11:23:25 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-westcentralusazon11022026.outbound.protection.outlook.com [40.93.200.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E60B22534;
        Tue, 22 Nov 2022 08:23:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMh+VoUfp4SVw5u0uKpbztmDqARiJBZGoLOXN4Z5/CEedci44itTEzTS33P9sGXBFI6BgkB6bUlTtvrG3U6DAWd46I9bfbZtmzXI8IMkRsE92MoDGqkvpOBWyLSBEW+/sTXI0/JWDrM8faLU0gQ44M4oM8Q9v3dCyNwwf679oH7Bppmacec6bhuB6hDr0do8Jci5z9yis9tb37Z7s8HOpgXk9M2EemaH5Y7HAZFNwD9sbAUEIJYrPjQaZ5tNpbP58RNjyp9XnZdhxjkhTRIPvrBCIaKXNnT9K1b5nKSf2d9ifwwaBd7XB9T/Sx8poQdf53q0YRO32pkXe4SS69S3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/J/8MUKa7xrufiZHIFJQZF+nae5l/Du2ZQtQntiLqE=;
 b=UjLv7xA32kqK1Q6BLulgdDwzBuw85sMTL9Ah6rlzAOAJ/R/gwwqeswRMAIjs+wvcXulvCT0exb24qYAbtIjaAQaa8aKl+xADj/VE4eK1QUCBr44sesM18iMXWj/bTk6vFo4cUK88tljcehi1QLSWW+lkDztPEDCligVlI0ALuixuRCX2gnTKFg0EGq6SSl//Cgyc1BxlxtCew0w7pVXQNm/k8MBDolzvwQmLjDR+8jcYofPeZpPbt39iY9t61EL4pcyZl/ysQqIrbVUE4wQDMhEbCOPvyR3aMsAWE8Q4XpKTR15dDWriIAlp2jAxJQEbktz4aks8Xd/zVhz7nMuWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/J/8MUKa7xrufiZHIFJQZF+nae5l/Du2ZQtQntiLqE=;
 b=HiMsXvYOaqVuIaq0dngrm0Wc6I27NCxgOXGw6occGSDZ16aulKRCqnP5KrSOG0qVimfLsLTTelLwYI2XHygbrq68V+C1kgKFGTzOFFykL6G9BPRUIPwlashqMAgFfDmJlS2zpzsOLqRcikJq64ppDxsBrdzsXTiPoqrtCW7tqu8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS7PR21MB3340.namprd21.prod.outlook.com (2603:10b6:8:7f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Tue, 22 Nov
 2022 16:23:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%4]) with mapi id 15.20.5880.002; Tue, 22 Nov 2022
 16:23:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Topic: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Index: AQHY9gVFDVN1zIWYSU6EB8Ojq0ZPZa47rwoAgAlUGNA=
Date:   Tue, 22 Nov 2022 16:23:21 +0000
Message-ID: <BYAPR21MB16884CBAC9D8DD004794E801D70D9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
 <MN2PR11MB409396A8C5CA6D4DFDF52B9AE5039@MN2PR11MB4093.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB409396A8C5CA6D4DFDF52B9AE5039@MN2PR11MB4093.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f6d5e983-e789-49c9-89e2-ee5a52d25eb2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-18T18:00:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS7PR21MB3340:EE_
x-ms-office365-filtering-correlation-id: 4104cd1a-f1d7-4ae6-9ea6-08dacca5df17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xUQOC/PmEtVlUFhGELd2OhccMGmV9QI6zyfWmWEtAGGBgKishSXkwBRNw4io5QJEepbOZdyxA7NkoZlRr+m8yvwJAwC1j0kQpXQnCVMQ48HK41iuLecUZd7mC4RXl7s+FuD18MlfN7gGWH3qZLy3ND/lIODpRDlkz3NLaSeNFFfed5fbdds3Y4pUy3yjKqrouNPtRo6lXpxyzhQx5tnkVSfL/HEROEwQ/2p7oWLKEnp68gwlbdmxa+AhVSYJTIZ8+FwdcbiTdZ8w+S8tJn2+CqOdW0HozWNYgFw5yW1KgAWO4e5QZYEKqJSEd4SHlcALjoJnune0rdcEIpx7r6/91zV/tABueIYWX7qO1otRrVnteVhhC5bHfc2FdwfsXimneNSs9ilyX6bAJ1M0zIBh0pm+2WlRmUvy19vg4OXM/znloMl84YDla2ZRF3OPYLRaFJHs9hy7slA1zlyHplKsbx4NAS4ccyM7i2uN7aiP/LbUagP1Ps8u15VZQI0zsSinPQq7UanGJeAlWSjs3Grl8E1GSX5wlhBZrvwhSb2N0itGO4MtL37WNS6OTry+jX32cwl9/+7B3cugTJ5AFZOg/N+NIIXW/bs6My7GS+ogSUoiHwb/uFhakYKuNUprLf0CifCYXgbjdZOXCAYuo4GCZHmKnDVuZeNj/3JO5pAs3EvxuHVyYVzFvJlAm2jlW55c6AXFZCHDXsgHgdjAMsS1S6nECkk793+meJxlYKIZRs1MgpiTTKMNYJC9ukuZbqCa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(15650500001)(8936002)(52536014)(64756008)(66446008)(8676002)(66476007)(66556008)(76116006)(66946007)(316002)(2906002)(41300700001)(5660300002)(478600001)(8990500004)(71200400001)(38100700002)(122000001)(33656002)(10290500003)(7696005)(6506007)(26005)(9686003)(53546011)(186003)(110136005)(83380400001)(55016003)(86362001)(82950400001)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D2foa7fkIGbvclvr5vzAYske8LznGjWzb8OyKH1MfUkcO3hAkTLYzIrbsDP5?=
 =?us-ascii?Q?haxPRff1Y9hDH7nUVJA3YnB4CEv/dLMmVxhWaeT2ivlWmlgjwQ2bsk0P/bbr?=
 =?us-ascii?Q?xxUfsHXJF1k5HVbrx9YYcMHzTicD5gLsRQy0Dg4+S11u2mg26zosRjOVH8V8?=
 =?us-ascii?Q?zlCWj/A7LO/FbT5Zxou8gL8c0Ox88EyMcs9Snv6611UBkt9m2HNfWI23HNtZ?=
 =?us-ascii?Q?Rolhuvs/VYwGnldcrv6yR3OtOCsPLOocIDPPJH4QdH6sfBDol5TfOy5tNiFZ?=
 =?us-ascii?Q?gV5iCuuze9v6svUS3AJrMBkwN9hEQfPlOrxd7NHZ0d3yF+Badg1Ax07fHWPG?=
 =?us-ascii?Q?8zsJXzVN0KFQgl8iyZXdvalcO3Q2cU71Fs2dUQ9ws9dHYo6o42L2S0HyT9m9?=
 =?us-ascii?Q?qdU6X4FWe8bUeK9LRX3ONWGdgRkDjyFuKr4t9gg9xLa/lge/NmNpEDIth3bA?=
 =?us-ascii?Q?0vn7PnjBMx8QnygF9UkSKDJLpYhRJmqYNfaY0FYDA+95he5L646FNji08Y5r?=
 =?us-ascii?Q?N0EeMP/yRJ6tU+2KvOP5LdVtqtoGurgC97lPwLLmqrrGdCFZXiTbo8V2CoQe?=
 =?us-ascii?Q?Zq9cD+0K3sfFv/vZ10kyGeutF/17S0EqwhZ3DX0GbaKVs5tbqq2nDPXnnJaI?=
 =?us-ascii?Q?Tt+2t/k7xlS/VAz6JWTsS4geeW2LnWLWti7Urmbg7NeB/iGokp/MLkh2w/NS?=
 =?us-ascii?Q?8I7dzdl+G4edg7CmA/pRvbnHjhMeYU/jPj6up8UhKFrchDATgEE0j5ch0L2y?=
 =?us-ascii?Q?WahRFQp6Uj58qA1mdtKFV7QjC8mrjd+qp+7SnDaLbvRKY3JYyaAqgp+zaq+y?=
 =?us-ascii?Q?J20nLeJ5dLRlCu/0MBHNtA0/FZ+FeiSFl0Wg9bzr9xcMI85VIxLcaBHKzhMd?=
 =?us-ascii?Q?zSx9A2/XHwYdqilfuK55mA08V7W0F+8EnddsF8xIcYYEBHJD8oLY2jm3FnH+?=
 =?us-ascii?Q?22i9tmN6okyI9Eq0ug1hKocUmQ1ugKJ5pIEJ/9sKjFDEFMVx5F8johQhpbKK?=
 =?us-ascii?Q?j84K9IGS5Ygnw986XsziGjRYh83KDUez0Iz82D2ieJNkgLFzVVlwy5Rpgj/s?=
 =?us-ascii?Q?ecpLBCvUKcHsXTxxz/SyvB5KCPA8Ls44tt/dZ4fI6F2zQlFko1OLZy1M9nu9?=
 =?us-ascii?Q?5GAhFZeyrX3O2qy/yYHWk0jJVDEFSFzFu7LZJamepLe92/tM3lPS0H8DbayV?=
 =?us-ascii?Q?ZRz8kwm0cjqkncHn9NMfbrH9pX8+lXDRjd4z3M6Yhax42mvWkG0w+Jb/Dzpg?=
 =?us-ascii?Q?kVu3hptw+2szjTPpOEWTU3Bij0IadVa1nI5LGDspNWNG2KX3q+TsHcmJi8U7?=
 =?us-ascii?Q?b29qEW4jrwIG5wf4XqLKd62WMeCMsfc2lcSdMB14lava8KXLpU0gMLP5ZIgF?=
 =?us-ascii?Q?fHlLU58XEG6q8MLAyeibGv+KnO816Shxa3BMjBhDrzN4O89ZkpT0DUUmtAIV?=
 =?us-ascii?Q?6qnOdtBYr4Y6wEAbBpaQnIC0CTyGJ9hm+knc3/zxXMYkFmEx7r9Y4o4Krrgj?=
 =?us-ascii?Q?jOVbwt0SFBlfzR0OSdD8FigravWFcLtIBKPFPMH3jH7/wHpAkqctHdeaeA3R?=
 =?us-ascii?Q?tQrdN4ynfKqmOOYwAEch29OE8apkao2Weed3dzmuL/tcIojR8kfB24u+6OgF?=
 =?us-ascii?Q?JQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4104cd1a-f1d7-4ae6-9ea6-08dacca5df17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 16:23:21.0570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgatpGH9L50t9lA7Jezf3VwGXbceutqx/6tBQD+AP3N8PlvO4cKxFkldKQb49thywv1Xo+rEubOkEIPLyOfDqTdYHLf3AozePos0cBy/k3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3340
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Winkler, Tomas <tomas.winkler@intel.com> Sent: Saturday, November 12,=
 2022 11:33 AM
> > -----Original Message-----
> > From: Michael Kelley <mikelley@microsoft.com>
> > Sent: Friday, November 11, 2022 21:39
> > To: peterhuewe@gmx.de; jarkko@kernel.org; jgg@ziepe.ca; Winkler, Tomas
> > <tomas.winkler@intel.com>; linux-integrity@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Cc: mikelley@microsoft.com
> > Subject: [PATCH 1/1] tpm/tpm_crb: Fix error message in
> > __crb_relinquish_locality()
> >
> > The error message in __crb_relinquish_locality() mentions requestAccess
> > instead of Relinquish. Fix it.
> >
> > Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after
> > granting locality")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>

Is there a maintainer who can pick up this fix?  It's not time critical; I'=
m
just trying to make sure it doesn't get lost.

Thanks,

Michael

>=20
> > ---
> >  drivers/char/tpm/tpm_crb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c in=
dex
> > 1860665..65f8f17 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device =
*dev,
> >  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
> >  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
> >  				 TPM2_TIMEOUT_C)) {
> > -		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed
> > out\n");
> > +		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed
> > out\n");
> >  		return -ETIME;
> >  	}
> >
> > --
> > 1.8.3.1

