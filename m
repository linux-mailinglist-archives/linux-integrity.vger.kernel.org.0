Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653E763B921
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Nov 2022 05:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiK2EeO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 23:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiK2EeM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 23:34:12 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022017.outbound.protection.outlook.com [52.101.63.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959015A18;
        Mon, 28 Nov 2022 20:34:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bq7WYTQd/nnn8BT57lWrwpAzQHtFgjo8YYK6sEMC1kb9HlNrFvfQmiVBJi8Mb1rdEEN4oVsU6Q/6LkX+XaxhOIwUoajBkpbSbHTOR4pQtK5wZIthBuIK8hTNgzR/66mCo0S8EkY52gwaF/DgnVyt4G+uawImHJdasD+QG7uUZX4c+wmiLzzbLH4p7G+vt68OyiIGGtPokmC//Eti6wL47cPdu08RtFKordIZ4ryiwp6YORZGe9t/tZ9tQtj9zP+ocZaes0lOBU1g623GoptWvn7uM12OtEL9YE8dyczLH0wn66qH1eGRTC0WfHau3nny1nuS4VvCSz5p9mwp8mhr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSIsufC1uud9VNtw74nCN5WZUO+rqPtaipBvKa6Anf4=;
 b=CAyLCptCBlJGKGdTcoz85zMWUHwbd1NXHu1NTi+MNtX1zOIWf+vWgo/V4kQ2GqF4q4Ar/t9E6vaVNwLL/zQvtjK4gUrcwSHHxInEpW5CDaqkSzYCtS2252KlKth+VUzNIfopGFc3inF6Z1R5rQGST5ZEl6kxzHPAmoVkFO58Z4AG2sa2M5pTxRxoPO++xQoxvwWG6Le7Zj8Cv4OzfYZER4wcwIYIHnitwrf8s/4YTcf//EBgyPpmGgC5U2sQiDekGD8drFsJ2MOa6DlDqos8IWYp4NFJeV+KyNFu7vi0dXTIUCU5aJgfMGQwzxsQmBDtufskgN3WQdtKGyqUpNm+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSIsufC1uud9VNtw74nCN5WZUO+rqPtaipBvKa6Anf4=;
 b=MpmuiguHH/dwKLSlNsh4VEFM/3uZ2bP6SpT7PgXR2aelAdtETBThT3UT28zvqBicEjbzTD8/Htw4RZLisjKFmhcmwpXn4fRjESWMGRJ4MazvDfM+maPJydXcAONG4DNKJ66ownmIjFeotdYc5jYo/FOi2IZCcFPZfGIMF6GOrrQ=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1872.namprd21.prod.outlook.com (2603:10b6:a03:297::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.4; Tue, 29 Nov
 2022 04:34:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::1e50:78ec:6954:d6dd%6]) with mapi id 15.20.5880.008; Tue, 29 Nov 2022
 04:34:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Topic: [PATCH 1/1] tpm/tpm_crb: Fix error message in
 __crb_relinquish_locality()
Thread-Index: AQHY9gVFDVN1zIWYSU6EB8Ojq0ZPZa5TEWwAgAJXhmA=
Date:   Tue, 29 Nov 2022 04:34:09 +0000
Message-ID: <BYAPR21MB1688C889A9EC7773EAC2CA0AD7129@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1668195533-16761-1-git-send-email-mikelley@microsoft.com>
 <Y4OSnFFhj+20wiO0@kernel.org>
In-Reply-To: <Y4OSnFFhj+20wiO0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=83895ecd-d582-4a27-aaaa-7e41fa5b7840;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-29T04:24:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1872:EE_
x-ms-office365-filtering-correlation-id: ed6e5500-6bfc-488b-43ca-08dad1c2f513
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9A202lx1DKFZzyV+g7NrCepPHa03zF6GQ1+/ne1z0w/y73K3PqG5vcAn6jEc6MyQ7cfHRUDYMXfIx+k+lYcn1lchccdMR0mTNyYZ34lnbsAlSjPIdweRC1I9H+763KpNyCaL439SbikBwYdpPvWIFapeUjGi5PdHXhw9Oen7RCgLvei1wXoRwPOJPUxBXy0yWUAMCbJKu9EXe+qBSdnZBnY7OFVnigM0ea+ujX24HTfo7GbE5YDBZy4mdWyMQAIKwuss++08CgQjRLQtNXaPi32zc6xszYnxbLsobB3Ayg/hBcbyoVMiKbUDFjNhPTK5j+AtOLl93sofcaF7HIdq4FVokDn5R8IjHy2gaj9HQWDxPCYxYW+tmg4RaVxWdH/al9X84tsiex5yseUrQu/GqU72EuC+HT3C5akzDBsvmUrYfUrepyaEaSGU/13d7rss1J0Oi1QEFNCG0iEMBBnRPVTB7w67OqHpc0f4+p8mfPLO4w0/2X5w/ZVr41jr/ZeJx69WZvl1l7AqEB6LXvAY7I+Eq+ophIngEx9XvAfbXbv1OpmRLCwMYreKkXtPQHkgo7OiDNZc8rVk+z/967pNyJJOj4ZFKdUiebNA6ZM5v2bhpD8ZxNAIT3FFUA5pyYv/VIT0QbOIYlGFIb/e+Y/9nFxXbL+aY7UsW2ZahwugBDCXPOTqToos4rbi7QparqqsJGjC8RemKhdPlx6d425Y+TzI5kcBkZPbioV+F0P7TlIPsPa2qGRfLbs8tlx+8MO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199015)(38100700002)(122000001)(33656002)(55016003)(38070700005)(82960400001)(82950400001)(86362001)(26005)(9686003)(316002)(54906003)(6916009)(478600001)(71200400001)(10290500003)(7696005)(6506007)(15650500001)(2906002)(83380400001)(5660300002)(4326008)(8676002)(64756008)(66476007)(66556008)(76116006)(66946007)(66446008)(186003)(8990500004)(52536014)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n37N8vvfIa9n7r6IeRxOZ4AjATG746mksloFiqrLDxKJaivJOd75bb/N2fYZ?=
 =?us-ascii?Q?mDAkNxsKaBmenzlofpq+imwzmfdWjj+Gq5OdAKL02B4T8xADeWRTM8hX8GV/?=
 =?us-ascii?Q?H07wnu7QS7ECtYtas5yyHE6qPeKRhEVu8NF1YlT4MQg4mW0nJhFwU6Z+drIv?=
 =?us-ascii?Q?FoBOKuSeZPO6UmRzsowT3j6m5GD7k5gBilec6B36DmLV6znVphcDatLbSa7B?=
 =?us-ascii?Q?uwkYkA90F1lUor9+i/XF4Y/7em6mXxjrMz1CE/atTTP3mxu5ElhwbGRFCXws?=
 =?us-ascii?Q?3FRVm9o34jXQmR/+JJjDHd336Fy3JaPYZzv8TBLz6KyjtHMY6NOngtc+yJO6?=
 =?us-ascii?Q?SgI1uignTGx0XNXb82nFST6K8W1K+TJfyO7nbyW1ab0bhPx7NBv+78uz+/yV?=
 =?us-ascii?Q?55bR/HtdOO1CqZ/g5vZxPBUVx6VT0gcQrAGo0NdCTg/YXjYrC9W3irozqrpD?=
 =?us-ascii?Q?NcuR69SAfCwEilhpeMvxoqWI9tGqCkU2Bl5u9ecG6sm+/gXInmGt7kWkg9f0?=
 =?us-ascii?Q?NMx6bD8jz0j7BTggfXQqojNDSnmRQidjAEAIkzb23CacJpOtYTqIjiaNDoyY?=
 =?us-ascii?Q?T2y4+ADdk9STY2cHp9VWmstWDnQRKRWErU3ymBUviru4HNfb41lCnaum8pWC?=
 =?us-ascii?Q?BmJ6/AL+j1RoWbAgqi+5+I7qZutX6VQ+JXwXGfPhQldlqawuhcuuaI7BUJ1s?=
 =?us-ascii?Q?+6XmmFfp/LAh54F7QlgePlBUVWdPqOVqw2LYYMGfd6VNMArgaFOlUfims7JR?=
 =?us-ascii?Q?pox5KzoGDLHOpw47++iZFX6spCJtfBeDs6IUPkwNha01jg8WO0BZIcMp8rAa?=
 =?us-ascii?Q?XZawN5hC9v+uPyjiCCiGedgJqS/FM93dJmGQgQoz3Hdx9JtMEKXK+5lzsONO?=
 =?us-ascii?Q?HLD5YVM8FsmYr/J8g5mDU4sAe7ej+eeYJ84MbVH8DIV5GIisHWmEn8KJk9yj?=
 =?us-ascii?Q?IgmDmjsj+cUCyJ9FxHv+y9NdYPtLdKa1NQPzIlsitRoueWk1K9q5LAWXvOYi?=
 =?us-ascii?Q?sL3AWy9VT7xtyYcqoZCegmQTCM7mKv40raUNjCnm0C8y3dd1+g48ALQMdKLU?=
 =?us-ascii?Q?zDy5J7FP/Q/KquQ6D5OIGbc0enFHnKIRSF/7PKMZ4k+2e2C1N6wCA+8ToJ46?=
 =?us-ascii?Q?AdwTzwVBvlet7ee/42WL72UYIf+2OMUK3fKQb9H1SFB62xpKOEW5bdGwkRD9?=
 =?us-ascii?Q?mfaf7CzD/WoTENZtk2OtXyzRVV1S4nJPfIeB7beiCEq8Auh9LzqVz2ZkzRqk?=
 =?us-ascii?Q?Z6DrNkh5eGrZdGmIyklgJzz8FyfAirBFBiwEx1epboMoy3F5b+ArKsBi1a0B?=
 =?us-ascii?Q?Nc6MKwFERh0KKZEtPusf+gt3SV4IsYYmuXOEfTB3QfsuuZ8VoInh/xfGV5lR?=
 =?us-ascii?Q?HEZSki+dsrlC3KokyIVl/9VzSlp0utDfCTLMPkgnvZBDCrapfhOVgDh1oOtL?=
 =?us-ascii?Q?kM0M3wvb5DLI72MOxKIMs5c1/zpvm3l4/Uk7XKSoGOXnTmLhAmXI54UYtKDE?=
 =?us-ascii?Q?hk7JML0CCnaBTHUC7J1rsGOrOECjAra9an/ZZfOz4UbbwXQ+ktzkg9Bd6fNt?=
 =?us-ascii?Q?ckwX+19MihT0xND+WKVf77rYRwrEErJbupc+YogNg+SzdxtjICe+e3J4tVwf?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6e5500-6bfc-488b-43ca-08dad1c2f513
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 04:34:09.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmtIu1JmZ+rY6suHmBAkQrfE2e0uauJhFd+lsvUZ+AnwfCNLK6qU1TY0eczwnxkMv9cwitdL5FT5OLndwKKu1es2oG1/vSjhnRclooQstgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko@kernel.org> Sent: Sunday, November 27, 2022 8=
:39 AM
>=20
> On Fri, Nov 11, 2022 at 11:38:53AM -0800, Michael Kelley wrote:
> > The error message in __crb_relinquish_locality() mentions requestAccess
> > instead of Relinquish. Fix it.
> >
> > Fixes: 888d867df441 ("tpm: cmd_ready command can be issued only after g=
ranting locality")
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > index 1860665..65f8f17 100644
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -252,7 +252,7 @@ static int __crb_relinquish_locality(struct device =
*dev,
> >  	iowrite32(CRB_LOC_CTRL_RELINQUISH, &priv->regs_h->loc_ctrl);
> >  	if (!crb_wait_for_reg_32(&priv->regs_h->loc_state, mask, value,
> >  				 TPM2_TIMEOUT_C)) {
> > -		dev_warn(dev, "TPM_LOC_STATE_x.requestAccess timed out\n");
> > +		dev_warn(dev, "TPM_LOC_STATE_x.Relinquish timed out\n");
> >  		return -ETIME;
> >  	}
> >
> > --
> > 1.8.3.1
> >
>=20
> Please explain.
>=20

There are two parallel functions:  __crb_request_locality() and
__crb_relinquish_locality().  In the current code, both return the
same text in the error message if a timeout occurs.  That
error message seems appropriate for __crb_request_locality()
since it is setting the "requestAccess" bit.

But the error message seems inappropriate for
__crb_relinquish_locality(), which is setting the "Relinquish" bit.
So the patch changes the error message to indicate that the
timeout occurred in setting the Relinquish bit.

I'm looking at Section 6.5.3.2.2.1 in the TCG PC Client Platform
TPM Profile Specification for TPM 2.0, Version 1.05 Revision 14.
This is where the "requestAccess" and "Relinquish" bits are defined.

Or maybe I am not understanding what you are getting at with
"Please explain."

Michael
