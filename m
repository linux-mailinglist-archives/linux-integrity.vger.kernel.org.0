Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8A228E77E
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 21:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgJNTpE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 15:45:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:42252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJNTpE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 15:45:04 -0400
IronPort-SDR: r/Kw3hbpsVcTHtqzDUOk7Vdg7mo+qoWSsjvHFOSeAf7wuNqUjTcEW/g9NLY8lbUDJ8GAzJmowd
 cVo7yJn/RGvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="162713882"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="162713882"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 12:45:00 -0700
IronPort-SDR: 64kZhezpA4bGQPow4XKH0olQlBYZasfgUOhA/GPvb5OIccyVeZX420EQQOqcBF6bC12IKpK6fv
 eidaLr2ax67w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="300058704"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 14 Oct 2020 12:45:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 12:44:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 12:44:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 12:44:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 12:44:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3u0i8aXC2MVz/eeSy4xds0efpwTLmhaPLuLRBRfONF+612gQZq/L7IY2wbe1soowEIIPqDnpU7YLUv61oCP062aQ53dTTKRT2G0G9Cwf8m6HizzN/PQfY6FjOf+283KGzaQyO88MsmV0i6dLj4kQIBd9/InWywzg0G4fvUmXjn5kq7a5A3xY3o/y9SMpqMR2sj7C8LAT1mjjKJHRzQf4MMJyX/pGD6YmUl4rBOOYhuC5cw7Ajq4XvtgJ42FtDQpheRMT+Jo5cE752SHtQO+HpN+sjcLDVyrYikBJaeaYiAU0mYzSkfc/Eka3uNsonHbPJ34OAffjA37/Nh9WOUzmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OVD69yoJ3ztl6m6MzBATNrIIRl4y0ipR2aZrrYQ+fU=;
 b=iUnc4Ty/rarYTOZAeoFAK4gCEsM/9/YrQGEwHdyeuP6FE4SvVdPf620xyWlda8cvco+LC+vxUwusuVHM7quoW7NuD2RXEnLFK6X8pfm2VJcYRuaYWqtsr7Ze7y3sFbnUErBB4fgmrXcwelB8uy3OWu7YdX7z6O5wwWVZZt9LAegero6WiafWu7H6NKNjRgUuxfoa7Mxifgn5EmXGY6GVDnO43lGhfvbNvV54v0gr3R7JBhaYW4Pe7bxvW2XzzwfT0uN2Xnwmwv3hAX1HPn6DcLD+TKrH/e6aIiPp0g1WqKDuHWN3sKNOQbx8Da9XNsq1k62EEL/vai4VfI1nG7rZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OVD69yoJ3ztl6m6MzBATNrIIRl4y0ipR2aZrrYQ+fU=;
 b=mbraeOjWe9gjYUynX6a8c/89StL/ZrJELenRfIA/P785fBerFJuB2rcOhHeun0LYxFM6fAnyTUEW4At0Q458EtAhYu1clgeJrdECVgA1hI3P9t1atBjmd94bEXE1ptOj9hknwwjKZOTao8yA2DXkB8sOG8lteLbaI6Uy/XbqvpE=
Received: from SN6PR11MB3437.namprd11.prod.outlook.com (2603:10b6:805:db::13)
 by SA2PR11MB4843.namprd11.prod.outlook.com (2603:10b6:806:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Wed, 14 Oct
 2020 19:44:57 +0000
Received: from SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204]) by SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204%4]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 19:44:57 +0000
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
CC:     "tpm2@lists.01.org" <tpm2@lists.01.org>,
        "ryaharpe@cisco.com" <ryaharpe@cisco.com>,
        "scmoser@cisco.com" <scmoser@cisco.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: QUEMU and TPM2 device emulation
Thread-Topic: QUEMU and TPM2 device emulation
Thread-Index: AdaiOXxaeO4KYc6IRQKmBbySOBZp9gACVbqAAAfkTvA=
Date:   Wed, 14 Oct 2020 19:44:56 +0000
Message-ID: <SN6PR11MB34376F61682669164004284EB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
References: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
 <20201014155815.GA7562@mail.hallyn.com>
In-Reply-To: <20201014155815.GA7562@mail.hallyn.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: hallyn.com; dkim=none (message not signed)
 header.d=none;hallyn.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b09fa1c5-c0e7-40bd-a7a2-08d87079a139
x-ms-traffictypediagnostic: SA2PR11MB4843:
x-microsoft-antispam-prvs: <SA2PR11MB48436FBB7977DAD21029AE05B8050@SA2PR11MB4843.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQNSs4u+ff6pjTY/Jirho0FvgN24bpAF1R5jr5jg9roXubdeLoYkhEZwevjt6B6xGehRcCsCT8hUuvhMTgjY/gUQp0W44f1niNW1xYw7UAnNZ+3ICRvpjwN1svjtxA2qtQrpmOQtVU2y14pDi3wsZ+DQ/0PbGoYOEzt09n+s5KDRBKKQNaY16Jm8QvrV0UpE/tXFebH7GH6VCgbR0h2bJEBHBKlNjs0T3Hv+KN1cqO1ivWnlPXGgIn6iIQE+pJhkJobL51X1Ec4IOIejYV5ET1LufTR3d9x926Xo7Kzoo2M37H8c1A34xZu7QN4QS9JnOm5dlTSS1N0+dbWx2yEi8phhEBO3p9BOoo/+IyP243flADm2MhGCpCkmG7FFmiNnZl/EU4HuNJh/nzNpvm4IOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3437.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(5660300002)(54906003)(6916009)(33656002)(966005)(186003)(4326008)(316002)(83380400001)(478600001)(66476007)(2906002)(9686003)(66556008)(64756008)(66446008)(71200400001)(8936002)(66946007)(86362001)(55016002)(53546011)(76116006)(26005)(7696005)(8676002)(52536014)(83080400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7xEI0t1BHNckTQhxCgjrPYWxK7nHeUYGHQJGxksc5RCphy2FKFa5VnTvEcLHOLb4Klub6y58FcQfz42q8XiiitapYsJmzVyA6qtiekBmToPf7aaG317Wo/dYTNApK4GHGFnEwezBXzz6Nn6yaRFMY1Jtl3pYoqcc31JHzXnSWTyXx4vCGFCqru01LKtuLM6k6CvVVJMdOmlPf0Y/BYb9xwYTwNrWgLyo59VBKCzgY75D/U/DOi/xu0R9dDdOuwnSFEGo+QEyOn5qFFNmpPwQ8/DMcBdisPr84WdQ/7dKx1dzW5BDNKEgH/A0bT131m+08Einy3FBiQc0cYh1o8vXQQ17iCbg3s/+C4sk3jHsUx166OmtFcHndRJytgzzD5Tby36ACazNHyk0Irxy8n8By7exAJfFSlSe+4o623a6TnZnXJL47w3311oxXJCIhj54Hbh4SEf+xqR8tFT2FIyIY2gFwrpgiXV6nVoE2rAOgtAzcD/lYo1WQvNi3T3/tAHgHgqvaOu/DK1vcCnB5mJfse4eNvxIoj2jPS06rdVfbVrTD0iwBpwT1nzQp0xxOnZT3BX3bEWIte6CyO9uHEsrd9DoiZFI5n6zbH9b/E9iK72ZJcquLeKLi5LO2HnJJB5tUNgKrAfKK4jvPYml1PDZ8A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3437.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09fa1c5-c0e7-40bd-a7a2-08d87079a139
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 19:44:56.9440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/0MopJAfpp4GxXOcFRaikHlQvhjFpDgXoAa0dwecCHQ5BK3TY7yTCiFffUWTJA5hypKz5AghQaPZYFwH8WNkpzQKMZd0nTaScF/aE2XJ+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4843
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Serge E. Hallyn <serge@hallyn.com>
> Sent: Wednesday, October 14, 2020 10:58 AM
> To: Roberts, William C <william.c.roberts@intel.com>
> Cc: tpm2@lists.01.org; ryaharpe@cisco.com; scmoser@cisco.com; linux-
> integrity@vger.kernel.org
> Subject: Re: QUEMU and TPM2 device emulation
>=20
> On Wed, Oct 14, 2020 at 03:27:53PM +0000, Roberts, William C wrote:
> > Has anyone ever setup a QUEMU instance with a virtualized TPM? I need
> > to try and replicate an issue with the in-kernel Resource manager. My g=
oal is to
> use the integrated QUEMU support To bring up an emulated TPM device and i=
t's
> associated RM node @ /dev/tpmrm0.
> >
> > I am looking at:
> > https://android.googlesource.com/platform/external/qemu/+/emu-master-d
> > ev/docs/specs/tpm.txt
> >
> > Which shows this command:
> >
> > qemu-system-x86_64 -display sdl -enable-kvm \
> >   -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> >   -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> >   -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> >   -device tpm-tis,tpmdev=3Dtpm0 test.img
> >
> > <snip>
> > #> dmesg | grep -i tpm
> > [    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)
> >
> > I have a few questions around this that I cannot seem to dig up any
> documentation on:
> > 1. How to specify TPM2.0 device? The project
> https://github.com/stefanberger/swtpm/wiki seems to indicate it would be
> supported.
> >
> > 2. Does anyone know the minimum QUEMU version for this support? I
> > looked in the CHANGELOG here, https://wiki.qemu.org/ChangeLog from
> version 2.8 to 5.2 and never saw anything Call out TPM 2.0 specifically.
>=20
> 2.11 should suffice.
>=20
> > 3. Does anyone have or know of better documentation to set this up? If =
their
> isn't better documentation, should we (read I) create it? This seems like=
 a pretty
> handy feature.
>=20
> I'm not sure how relevant this is any more, but I did this about two year=
s ago and
> documented it at https://s3hh.wordpress.com/2018/06/03/tpm-2-0-in-qemu/

Thanks, yeah I stumbled into this, it was super helpful. I got it working a=
nd posted back
With my commands.

