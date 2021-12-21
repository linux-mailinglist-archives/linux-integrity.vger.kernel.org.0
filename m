Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3947C174
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 15:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhLUO1Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 09:27:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:42634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhLUO1Y (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 09:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640096844; x=1671632844;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=iEfaYO99pkhnC/gz8wh3hYi8GKbbPOZXq8SdhTQWGmM=;
  b=dPZNGKyIgARyGJfa4CHG6vkQdNf7wYJRmEIuKs8ZFa8VNpVt13Wslezh
   E8LxruFgp0yEfKSwUlb4Es2TgwBG509HHCyzwaykp+Dn6C4pgWUVRhex5
   pV2yecThd2WBQ+XwNf0dcP8/QbNWwgnNdChKjaECgO2W3KwrgMCqOu3d9
   qber3rgM1VEtvakrW7ozi7MLxl8wbITb+9+RGnttwyLP9A4fcULbbCH9E
   AJurSe5yGdpD48tjAaDwBm3FDqe5gJTHeKIRZvpLrkGSjDQY1X54SgA5K
   34iCGN1gwXmDHGcHchDs4jyWsPMh3RZa1uY/W6uqm9wCxUdJd1euZfzS/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303771719"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="303771719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 06:27:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="607072223"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2021 06:27:23 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 06:27:23 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 06:27:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 21 Dec 2021 06:27:22 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 21 Dec 2021 06:27:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzo9NB0f6y/zZm1O1y/VXvfjBTh4PZMuLrBUDvU8cuj4N1k+kXudLNjU7pSvKxYSFuDP8g5sTcOuiLsaSFsXM0SzW3gOJkXvyg+FGA7LEUSFzgBo6WgAIjFEupQ4VZPkYzG52xUIfN4bTkA8GuhEwJn+4iyocZ+QJXAA7IQABUZAneU5ZZhruzQDde+qPinwqr1m0tqujfUpU3ghqjLZ/Kr9SXC6kz8ZohlhpJUKRQqvXCixFDBnc5CPfAA6JjN7yVisWqLBL9RKwWwrQIi/MIG9JfTh9EAnIhyn6GDq9AwfF0Mv9DFO3kNEeFljX6FSPN41Pxj/T9wqHmIubqOI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5I9qfaU1hibxiblE36TQUjOmTP2wPqYayxKBZyqoVA=;
 b=V1MECEUESKPPDkpO+1Bvd+7S5q3audaKzkr2dRd+GEQqCKgOKucCKtYB/ph9/LMMD/FDPMIWHgcPISODmJqhaTN/2DFjXlHHkkWabWDy5rzN81dbd971/wm3dUouKEKOQXw10WImpVE6P5Ml82/5qaqHc9DGqzbBg5pYBvs7VrbNFXer+iEOOrmbHn8YPNDfwmG3ONuffb2col1f5ZvXbrOH9ve6SP/IcnFNGPUogsYBRgPSBhmWhDzcbhy1Z7QTVUp3oru0cDN8eE9BvKjV003/FRTopYYiiHUUxxqJUwUh4XIbV9q4Js0z2zp2PORq9v54fYcDV/bOdjN5vlykaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SN6PR11MB3437.namprd11.prod.outlook.com (2603:10b6:805:db::13)
 by SA2PR11MB4892.namprd11.prod.outlook.com (2603:10b6:806:f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Tue, 21 Dec
 2021 14:27:21 +0000
Received: from SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::f0e4:1984:eb13:3903]) by SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::f0e4:1984:eb13:3903%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 14:27:21 +0000
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Fw: TCTI poll with kernel 5.10
Thread-Topic: TCTI poll with kernel 5.10
Thread-Index: AQHX9atDv2n3Y816d0KnN8J5r5gEhKw9AD55
Date:   Tue, 21 Dec 2021 14:27:21 +0000
Message-ID: <SN6PR11MB3437EAA88CD86CD428F2BF29B87C9@SN6PR11MB3437.namprd11.prod.outlook.com>
References: <e71a18ea-d829-c844-8896-55bd47518d26@sit.fraunhofer.de>
In-Reply-To: <e71a18ea-d829-c844-8896-55bd47518d26@sit.fraunhofer.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: cdac2231-6209-c4c7-73bf-0ff622beed3c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9546a059-5dce-4ba6-b927-08d9c48e0020
x-ms-traffictypediagnostic: SA2PR11MB4892:EE_
x-microsoft-antispam-prvs: <SA2PR11MB4892BF86D63FE9DF93382A48B87C9@SA2PR11MB4892.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5HoXRhPEkF9zVcTtQxWoLR9pjp0x5iExPVIb2wG12LXRbGmgZbIBc+k56HeA4dh8EIr0DdMzVM3ZehtwsCsdKBUHa76yfXgShY2oONkm0Ck9N4+6YC4ZzWMxz6kkCIp5fvBGLzkfnaqa+c0TgZMh+fEbs68C8YItuPDM7Tw9EJmXA/80+XKOlNeiPTXe+6Og9KE4XMShVvHq9CEboOFjeBMjKYTrHoN51b4bqRexECClAqahAHjtYTfUKTAVouspusU+Uq5ftpltNd7cbFUjuREY68yOB5d5l7zKJCrub0D8xelK8TNH8+4lz499l7wi9tFCZFxdfsA7xSlnxe7bFBSScD0LqtDkbKIP0/e2iBusbySS5ivXNR70f3gLjwO6WBoJkuhtUOpcXSIgZLtUlNMKLxg/UsXmfcQm6kXLZojhvSoH+zedaoTsVbANPTJQgbBATvOPlqmqwo7DaTfloDss/6LMXvMt9PSkCtU/0lhUpv1nPHFMR73RuDgjIyO6puJkohsPYfktTgxLyuawodct622ccgC4bnakMBeuEI3xU+a9zfmsTAnMTwR6sMb4zZYF+BiBwp/2C+65nMrB/u4BsraPNmFxtaWjYrO7ni/qrL4RCWm7wS0waHrdQ7JKYs/jtVOcR5zRbO8m4cnzPuxNqzYWA+ug1ydvMAAHGfncZ7lFKqrKGOijVBY+Qla9Q9V6qPZjUL37hsQSSlcIOMSVL+BgOi0UvrfSTC/GztUzXOK4+4RKReaUHBxBGbp+4i7+CpAjCD8G0IAPpGuQF5/1PasMSXJttAO8hsn2+Mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3437.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(508600001)(64756008)(9686003)(83380400001)(316002)(66946007)(66574015)(8676002)(38070700005)(5660300002)(4744005)(66476007)(76116006)(91956017)(6506007)(186003)(55016003)(7696005)(52536014)(71200400001)(53546011)(66446008)(82960400001)(33656002)(966005)(26005)(6916009)(8936002)(2906002)(122000001)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5gozirypMnlMEJsvkdPqm1BR/cAfOv3ErLFzlaQcBb8E78XwVCYnWX2ZIu?=
 =?iso-8859-1?Q?629hvo4ZUk27MPE/83mdvntmv7dahRqP/pyPeLDsIIkSgCsnKgNq1t3ksg?=
 =?iso-8859-1?Q?IE3ZkEVNH1/zukz2d2MDddDbfGzsKfG6HSgOW63kBLbqa03Q4xaA1EgRZN?=
 =?iso-8859-1?Q?79HCcgcKXOW/EnPiw10EBDcGJW4BJLq5KTVugR6F72rIO/a0Mqa1IFa6Jn?=
 =?iso-8859-1?Q?12D2CVl5PfIkvmjmtz85fcjyHhA2HY7/t5va0Xooc63T7rmO8MGvGvNol+?=
 =?iso-8859-1?Q?d5JW3Nm5+lwwsSjLa6TwrDrgAWYqiEqF41GnuFRf5HbOlXtCyUcsWFDJiO?=
 =?iso-8859-1?Q?/e5mxxZudZ60VBas0KMvE9xIub4+sWaWyfb8GAK/U4ln1cTepxb7OPGGl4?=
 =?iso-8859-1?Q?QeXFXzcVXXRrJ+mfA+ZILh7OUvlV+Qmp832yQ9zBNeFHA7NUshpz6jetYw?=
 =?iso-8859-1?Q?7WFaaki2Vd4LI9ne5R/EEXf6KnczvDrfBWUWcvwYQjLSRcszyJ4RignI+6?=
 =?iso-8859-1?Q?5XxkHO7zz3jiiUIlqfRo5b+LlR1w+gkgDriGo5MtwZypeNhry7a5I5qSBX?=
 =?iso-8859-1?Q?2rxM+jj/QasNoJ3Tcd453R1gCd1wzRtlxsyY6QFExQjjgrAAkpHEJaVBz9?=
 =?iso-8859-1?Q?i6+U3Zl74WR9EarJbI46nZV+p6K5ILTD5eouoRQBG+6ha1E/iiEGkMf3Zc?=
 =?iso-8859-1?Q?MP5gDs6NWkZZhdFCXA94Uf0s17Z4l4/+qKV28S3zjWg6xcJR7zGil4CHZB?=
 =?iso-8859-1?Q?IMY8TqgTXtRmNyfM4B9OzzZJi1YbSDuECsFAXqvKpJSXZGtcmnJv75kyFP?=
 =?iso-8859-1?Q?U43tYklDd/fOydHsw0qp+0NtwQEX0i1ja+6Vlcxj9hTPfe2M2fhWt+BEME?=
 =?iso-8859-1?Q?+cgvf5UzCP/JGzgf9UFNGtRwlfXmFLbC9ntRL+l77mKdOEEjEoMlN1787x?=
 =?iso-8859-1?Q?R5Wo/NH5+5vgtEutyLk2fiFZlmJ806z171FNjA4G+5KXo5RkYotP5FVqiF?=
 =?iso-8859-1?Q?zIp9BOhZOaC1i0AQ5Q4i0afpYVRqO6+qu45jCklYYm1UHrGqCSNWwDu2jc?=
 =?iso-8859-1?Q?kSn6tqy+Ol9+dyfH/JYkloXJjtclq967ZeaMNjF3g3wX7CklPBa7S4glD9?=
 =?iso-8859-1?Q?DwObHkWaCutxm5+j3ddvj8yQaRyLI7uWP9cu23cWAnoysoHWS0nuKUY0ke?=
 =?iso-8859-1?Q?dCZc1WDRw8SFfTStBcB26p+6bSXxx+VtkPUmJTZUHkNOdh5P/XWN6bmIH4?=
 =?iso-8859-1?Q?Qqf8CVoHZ4KRrmZ8K6wsVT6yXe7IvZExjZ5xL6CwqZ7rraO58HNTwK9JKj?=
 =?iso-8859-1?Q?9egal+XcLrm4SHzY6jLAcAkStb0ehj6yZSlruBVl5ACLvBwLUW5/oFK5Xd?=
 =?iso-8859-1?Q?eyCN0t2JAdnz1eEy0WsXwwIEhhk8GxGMXeJ1rLtt75cZhhlNGnlRsolB0d?=
 =?iso-8859-1?Q?iDVIFaSsryP8KDoH9B/l8lX67bmxgbIavcdaEJ+dNSfnO0YqOcTz7Mad9e?=
 =?iso-8859-1?Q?lEOSntu8arzTQPDD2EpyLjKEaobZicR2Uh24XeXKmtoye3b1Tq5vbglyZV?=
 =?iso-8859-1?Q?dWsOBa14+FUF/Do7QZMRPOKIs1R88TAFng+Sx5qpQCTH1yiOKGmloygaWf?=
 =?iso-8859-1?Q?vnyJkiDk7Cpm9ev5Qtke+o7Dk+j3DRsleH+jlYJcBx927sFHcDrBNUW/M2?=
 =?iso-8859-1?Q?IUB7/REOT0eWXOL4uNw/yHIxU8LOybJNbYg3yU40noearjyvyuqivAil5J?=
 =?iso-8859-1?Q?YS9w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3437.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9546a059-5dce-4ba6-b927-08d9c48e0020
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 14:27:21.4930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CernARCS/jMi0sMwlGbNcaepL+HNyyTjgtPqPaZaH7IoBrPB4vaTm+ET1OJFuuc0IXqz6ZKsNCnnmv0/hd/Xj0HNwgkS81nKfEDqxP+uiLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4892
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,=0A=
=0A=
It seems that theirs a regression in the TPM 2.0 in-kernel Resource Manager=
 that was reported to our list and confirmed by one of the userspace mainta=
iners (see below).=0A=
=0A=
Here is the link to the full discussion:=0A=
  - https://lists.01.org/hyperkitty/list/tpm2@lists.01.org/thread/GRKCQLDRF=
I5QCB5ZY3KDXBZIUGAVI35K/=0A=
=0A=
=0A=
> From: Juergen Repp <Juergen.Repp@sit.fraunhofer.de>=0A=
> Sent: Monday, December 20, 2021 8:04 AM=0A=
> To: Roberts, William C <william.c.roberts@intel.com>=0A=
> Cc: Andreas Fuchs <andreas.fuchs@sit.fraunhofer.de>=0A=
> Subject: TCTI poll with kernel 5.10 =0A=
=A0=0A=
> Hi Bill,=0A=
=0A=
> I did verify the problem described in the mails "tpm2_flushcontext stuck"=
 related to /dev/tpmrm0 with kernel 5.10.=0A=
> After sending the command read public:=0A=
> 0x80 0x01 0x00 0x00 0x00 0x0e 0x00 0x00 0x01 0x73 0x80 0x00 0x00 0x00=0A=
=0A=
> the poll call in=A0 tcti_device_receive does not return when kernel 5.10 =
is used.=0A=
> With kernel 4.19 write for this command did return -1=0A=
=0A=
> Could you please contact Jarkko about this problem.=0A=
=0A=
> Best=0A=
> J=FCrgen=
