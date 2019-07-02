Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97CAD5D4DB
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2019 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfGBQyy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jul 2019 12:54:54 -0400
Received: from mail-eopbgr790129.outbound.protection.outlook.com ([40.107.79.129]:51120
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726255AbfGBQyy (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 12:54:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSrF5XsvZ8Dhf5sq/QYrbagDrcezWv9+eLQQECVGjJH11NwtVUVhvz7RlVfn3vXVPSq/dDgh8VmN6kahzXX+4ty1cRNP8e+SFA+Oc8VOo9Qm3vnahweElQttzbN1ZQwDDBGSGQ4ax+ur1PUQunW3iCEVIQekpuiIuAKiRVWIv5/NIIjmit+L7VldwTXbkEdkX+Ryfkr/ZnnokPFSP7G2Ctd9rFkxnlxq5+zkZbQOeifeiBT0BMf37oVgSkv2BwuBQCje8nJl4skKKajM39kIMwpeBRC1ujLmg5SlNdsYrRSmVpIVj5kPfTO+erxBqHB0TRJiFIzgKY/rYhQU4+bqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVaUler8IbluHwspeG+vHE0TdGqDfiRmScG5WlqMf34=;
 b=i9golprDA9D0jH3elVEi6zzDgxdlTNErlSQjrDMOQug9liGoFfJcrd7hMP5GKZoSE/5XYjiPZ/5xdG/raHVEN2YPPpu26X/aFQDuj0MXUelVsOo2g2nKb//ltPo0XCZarEzkydhVJyZFQt2L1BlV8CaK96bChZ1prYABuup4YOu1TUd3MD+lTsFXPgi/pJ2giOcTuiIWlzRgbwySbVFvR3b3R6XEuJCRkC8v83bo+k6nCNLeeYM+TSLA70WOeGmZ+yw0Kg85T7TbjlmxvYBup/bp2jqQ7lwtseWe5BhH4Igl2FPge/e/xqa435SETac7vkoeRlXsTtl5Y/tEEnG6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVaUler8IbluHwspeG+vHE0TdGqDfiRmScG5WlqMf34=;
 b=j1CFajHrAGXhXjjjYRJoN3Yh0JQdk9b6jA5H1FVMjmv+va7h6oVnlHpODAYUc8htVpyLDc8aEs/8A8qwozSfj4q3yMi32wfln+VtTJKlQL20RVtYUNfcoXtN+7DojsVpryJHjbKOVue1qX24vqaO63QH2sRxayzKMUH+F6XtAF0=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) by
 CY4PR21MB0838.namprd21.prod.outlook.com (10.173.192.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Tue, 2 Jul 2019 16:54:50 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d%7]) with mapi id 15.20.2073.001; Tue, 2 Jul 2019
 16:54:50 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: RE: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Topic: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Index: AQHVK5KBxkypLT05X0KOGP9E2DZ32Kaul3GAgAAHEYCAAN+wgIAAA4QAgAAzCoCAB7bkgIAAJOcg
Date:   Tue, 2 Jul 2019 16:54:49 +0000
Message-ID: <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <20190625201341.15865-1-sashal@kernel.org>
 <20190625201341.15865-2-sashal@kernel.org>
 <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
In-Reply-To: <20190702142109.GA32069@apalos>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:a14b:6cf6:8620:2d99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cca73322-ddde-43a0-5ffb-08d6ff0dff36
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0838;
x-ms-traffictypediagnostic: CY4PR21MB0838:|CY4PR21MB0838:
x-microsoft-antispam-prvs: <CY4PR21MB0838ADFC593A2ABF914E0404BCF80@CY4PR21MB0838.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(199004)(189003)(13464003)(81166006)(305945005)(74316002)(81156014)(229853002)(6116002)(22452003)(7736002)(55016002)(8676002)(8936002)(6436002)(10090500001)(71200400001)(33656002)(110136005)(54906003)(316002)(7696005)(2906002)(9686003)(7416002)(4326008)(8990500004)(71190400001)(68736007)(6506007)(14444005)(76176011)(52536014)(478600001)(10290500003)(14454004)(486006)(53546011)(476003)(186003)(99286004)(256004)(5660300002)(11346002)(446003)(66476007)(102836004)(46003)(66446008)(53936002)(66556008)(73956011)(66946007)(25786009)(64756008)(6246003)(76116006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0838;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: flLEcYHgNWB2mZMa1V9m0n7halWgMMT4k4lrdpUbbwbQSyIKZXZ2ZOs+7SknRZmy2CVs8C3EtAW5abet/M1IkChu2nyMbgB3YqwWjLHIO56v+saXJx94WHUnYEEQF6kYv16FFtzv+KZreyWHaLDQ4Xuya9lSI3++C+w2xCk0QR2cuw0J6Eyp1TvxwJb76ZZMCXiRemBpYG/IYZJAVbW8BMKizr66cg5mg4vmGOq1qXRiFgXlb8jb6deC1FmXELbyPruOqEYJNgmwF6z5pqjsFoZRQe3zYDqPPpY7xjEzs+giny+At/+6sYM0x51zWw5o27JKZeAUX77bfMxie+c1I8jEajeOA5smAHmXCEml4vjcex8P4AP2Fbg/7EV+KI2/jJ+XmZWfs39DLoieWSrj+22ja+I2EqbHAShQusbgmO8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca73322-ddde-43a0-5ffb-08d6ff0dff36
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 16:54:50.0025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thiruan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0838
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ilias,

First of all, Thanks a lot for trying to test the driver.=20

> -----Original Message-----
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Sent: Tuesday, July 2, 2019 7:21 AM
> To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Sasha Levin <sashal@kernel.org>; peterhuewe@gmx.de; jgg@ziepe.ca;
> corbet@lwn.net; linux-kernel@vger.kernel.org; linux-doc@vger.kernel.org;
> linux-integrity@vger.kernel.org; Microsoft Linux Kernel List <linux-
> kernel@microsoft.com>; Thirupathaiah Annapureddy <thiruan@microsoft.com>;
> Bryan Kelly (CSI) <bryankel@microsoft.com>; tee-dev@lists.linaro.org;
> sumit.garg@linaro.org; rdunlap@infradead.org
> Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
>=20
> Hi,
>=20
> > On Thu, 2019-06-27 at 16:30 +0300, Ilias Apalodimas wrote:
> > > is really useful. I don't have hardware to test this at the moment, b=
ut
> once i
> > > get it, i'll give it a spin.
> >
> > Thank you for responding, really appreciate it.
> >
> No worries
> > Please note, however, that I already did my v5.3 PR so there is a lot o=
f
> > time to give it a spin. In all cases, we will find a way to put this to
> > my v5.4 PR. I don't see any reason why not.
> >
> > As soon as the cosmetic stuff is fixed that I remarked in v7 I'm ready
> > to take this to my tree and after that soonish make it available on
> > linux-next.
> I managed to do some quick testing in QEMU.
> Everything works fine when i build this as a module (using IBM's TPM 2.0
> TSS)
>=20
> - As module
> # insmod /lib/modules/5.2.0-rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> # getrandom -by 8
> randomBytes length 8
> 23 b9 3d c3 90 13 d9 6b
>=20
> - Built-in
> # dmesg | grep optee
> ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session failed,
> err=3Dffff0008
This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.

Where is fTPM TA located in the your test setup?=20
Is it stitched into TEE binary as an EARLY_TA or=20
Is it expected to be loaded during run-time with the help of user mode OP-T=
EE supplicant?

My guess is that you are trying to load fTPM TA through user mode OP-TEE su=
pplicant.=20
Can you confirm?=20
If that is the true,=20
- In the case of driver built as a module (CONFIG_TCG_FTPM_TEE=3Dm), this i=
s works fine=20
as user mode supplicant is ready.=20
- In the built-in case (CONFIG_TCG_FTPM_TEE=3Dy),=20
This would result in the above error 0xffff0008 as TEE is unable to find fT=
PM TA.=20

The expectation is that fTPM TA is built as an EARLY_TA (in BL32) so that
U-boot and Linux driver stacks work seamlessly without dependency on suppli=
cant. =20


> ftpm-tee: probe of firmware:optee failed with error -22
> # getrandom -by 8
> random: fast init done
> urandom_read: 2 callbacks suppressed
> random: getrandom: uninitialized urandom read (32 bytes read)
> TSS_Dev_Open: Error opening /dev/tpm0
> getrandom: failed, rc 000b0008
> TSS_RC_NO_CONNECTION - Failure connecting to lower layer
>=20
> Am i missing anything?
>=20
> Thanks
> /Ilias
