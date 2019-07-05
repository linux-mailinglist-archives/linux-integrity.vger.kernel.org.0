Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686175FF87
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jul 2019 04:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfGEClD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 22:41:03 -0400
Received: from mail-eopbgr710122.outbound.protection.outlook.com ([40.107.71.122]:43456
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfGEClC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 22:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0YLGCSHhEtpkk277s9PSda0C5+y3aaU+BCqDrZwY1q9dVihcQtPyF+noHp4FqfR+4+z54+QsaAHcVd/1zypbeIGayPicmDtJ323nupIyzNfUleqQ9PySqiQEZZH2+/Q9NU62KDj9XTi4Qcrc4kmWtuMwxXUYS0u3DdWJXYp3V5mzgjeAPT5Fa6hl5HVy4oCHzjnko4uDbrBSDs5qPbZOkC4ZgL888xHa/OKS4sOeSOSAHadcSSL9V7smR9skzVa65Jm+PkNj7GMQvwo/6qj8beZyCMe/uJkWm7ICjtv8hwjwbqsgRPcV7qw4I30ZHCQOQmwiWwlczxUReUQALfhGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXjJWygK6VQTwbg+Gb+1WS+X2VX1eifVBTSpr9w/cGQ=;
 b=A8vbDWNFupRGamr0BKDZ3TdxzVNS1v7KsnHV18Nl/jxsZwdfUv4X4CW14crBuHto/Zs0s5p51FhvUcRALVK68ouPxMuDIKGcZZZLJ9yFVOqFNzHD1oyRbW3NXXpTSLs4YZhU337WaCk8ujlNbPp5kqcaCJqJ+XMBqT+D2RHqUaBqZ+VKZtGEJw/IJ0NodrsWb0QwPN+1A/Pn9G0oSsu98svwnIjIw+nuYkgNkR86va4Tr5fvzdgLhxAShXcLRruw1qH3BmBu+y7ckPCPvWuz70bLnUJ2jCJSCMavVzh71aKiKYlSUm5w7UIgxPPayqKJICTmj07J3eWqYmgeS0dIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXjJWygK6VQTwbg+Gb+1WS+X2VX1eifVBTSpr9w/cGQ=;
 b=JInjmBrj9E493+nxL+xL/rj+k+AX0NVRYvvgHVeZIYMq81PJd27cUy4vBHqhHFjlPKE3azWLOXqMHBNS5Z/5V1cgISqQG+lQISgeXImJ3gR0roYJ1yJldpSR5xZWxGLieUMNZxEvDul9kLI6QoH4c1qbuG8oyTA1DxlVMXIqhKk=
Received: from CY4PR21MB0279.namprd21.prod.outlook.com (10.173.193.145) by
 CY4PR21MB0152.namprd21.prod.outlook.com (10.173.189.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.2; Fri, 5 Jul 2019 02:40:56 +0000
Received: from CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d]) by CY4PR21MB0279.namprd21.prod.outlook.com
 ([fe80::543b:4f31:c610:468d%7]) with mapi id 15.20.2073.001; Fri, 5 Jul 2019
 02:40:56 +0000
From:   Thirupathaiah Annapureddy <thiruan@microsoft.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Microsoft Linux Kernel List <linux-kernel@microsoft.com>,
        "Bryan Kelly (CSI)" <bryankel@microsoft.com>,
        "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        Joakim Bech <joakim.bech@linaro.org>
Subject: RE: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Topic: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
Thread-Index: AQHVK5KBxkypLT05X0KOGP9E2DZ32Kaul3GAgAAHEYCAAN+wgIAAA4QAgAAzCoCAB7bkgIAAJOcggADxrICAABS/AIABZouAgADTHACAABjKAA==
Date:   Fri, 5 Jul 2019 02:40:56 +0000
Message-ID: <CY4PR21MB027937ADCEBF85826FF3516FBCF50@CY4PR21MB0279.namprd21.prod.outlook.com>
References: <673dd30d03e8ed9825bb46ef21b2efef015f6f2a.camel@linux.intel.com>
 <20190626235653.GL7898@sasha-vm>
 <b688e845ccbe011c54b10043fbc3c0de8f0befc2.camel@linux.intel.com>
 <20190627133004.GA3757@apalos>
 <0893dc429d4c3f3b52d423f9e61c08a5012a7519.camel@linux.intel.com>
 <20190702142109.GA32069@apalos>
 <CY4PR21MB0279B99FB0097309ADE83809BCF80@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190703065813.GA12724@apalos>
 <CAC_iWjK2F13QxjuvqzqNLx00SiGz_FQ5X=MQxJyDev57bo3=LQ@mail.gmail.com>
 <CY4PR21MB02791B5EF653514DC0223694BCFA0@CY4PR21MB0279.namprd21.prod.outlook.com>
 <20190704181120.GA21445@apalos>
In-Reply-To: <20190704181120.GA21445@apalos>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thiruan@microsoft.com; 
x-originating-ip: [2001:4898:80e8:f:e9b5:5e6a:92ce:7feb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca8a199-3bec-4c9e-60c4-08d700f234e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0152;
x-ms-traffictypediagnostic: CY4PR21MB0152:|CY4PR21MB0152:
x-microsoft-antispam-prvs: <CY4PR21MB0152A50DBA79B698D84D04F5BCF50@CY4PR21MB0152.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(199004)(31014005)(189003)(13464003)(5660300002)(66476007)(2906002)(66946007)(305945005)(66556008)(73956011)(68736007)(53546011)(6506007)(8990500004)(66446008)(478600001)(11346002)(6916009)(10290500003)(316002)(6246003)(7736002)(22452003)(7696005)(76176011)(8676002)(186003)(81166006)(54906003)(81156014)(10090500001)(6116002)(102836004)(4326008)(25786009)(229853002)(7416002)(52536014)(86362001)(256004)(14444005)(486006)(476003)(99286004)(53936002)(71200400001)(71190400001)(14454004)(74316002)(55016002)(33656002)(64756008)(6436002)(446003)(9686003)(8936002)(46003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0152;H:CY4PR21MB0279.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GTZKyzOfxH10ZYriXwpP487Yt5ArQsAGdAKqLTq+gMMp/JADggIjF9Ptgn6wbgREXoejXabmET1GPp0VXPyNjjP9tKTjXdoKmDZ5korzJ8FXl5586AXJxDPd7dZrHmtDgQr9f3Hfbj8J31TIkbqnhvmv7if8whiP1kUsxY9oc8I9BRR0lTh5DBhPJTJtViVt4kXMVfBMJdBQ+JRC0Cu+2FBY96Xoo9B22ZR6mk5W+yZ4C/6pOWGvyqYiEszTeepme5/LpL0XqY5ibxm+fanJJNX60v60J0oSd1vsKAKKCwC4IPWaF4h2lU28SVv2Onaae8swHhW+CEq5HvshV7ipJqilj+KkrVNY5hoRPtY4sDZMH6nIIsdvLIMu/8QWpYsYdZtDx8Q+vAtrQYKuU6+PABdjMIWdQaPGTlTJQERu7tk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca8a199-3bec-4c9e-60c4-08d700f234e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 02:40:56.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thiruan@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> -----Original Message-----
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Sent: Thursday, July 4, 2019 11:11 AM
> To: Thirupathaiah Annapureddy <thiruan@microsoft.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Sasha Levin
> <sashal@kernel.org>; peterhuewe@gmx.de; jgg@ziepe.ca; corbet@lwn.net; lin=
ux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> integrity@vger.kernel.org; Microsoft Linux Kernel List <linux-
> kernel@microsoft.com>; Bryan Kelly (CSI) <bryankel@microsoft.com>; tee-
> dev@lists.linaro.org; sumit.garg@linaro.org; rdunlap@infradead.org; Joaki=
m Bech
> <joakim.bech@linaro.org>
> Subject: Re: [PATCH v7 1/2] fTPM: firmware TPM running in TEE
>=20
> Hi Thirupathaiah,
> [...]
> > > > > > I managed to do some quick testing in QEMU.
> > > > > > Everything works fine when i build this as a module (using IBM'=
s TPM
> 2.0
> > > > > > TSS)
> > > > > >
> > > > > > - As module
> > > > > > # insmod /lib/modules/5.2.0-
> rc1/kernel/drivers/char/tpm/tpm_ftpm_tee.ko
> > > > > > # getrandom -by 8
> > > > > > randomBytes length 8
> > > > > > 23 b9 3d c3 90 13 d9 6b
> > > > > >
> > > > > > - Built-in
> > > > > > # dmesg | grep optee
> > > > > > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session
> failed,
> > > > > > err=3Dffff0008
> > > > > This (0xffff0008) translates to TEE_ERROR_ITEM_NOT_FOUND.
> > > > >
> > > > > Where is fTPM TA located in the your test setup?
> > > > > Is it stitched into TEE binary as an EARLY_TA or
> > > > > Is it expected to be loaded during run-time with the help of user=
 mode
> OP-
> > > TEE supplicant?
> > > > >
> > > > > My guess is that you are trying to load fTPM TA through user mode=
 OP-
> TEE
> > > supplicant.
> > > > > Can you confirm?
> > > > I tried both
> > > >
> > >
> > > Ok apparently there was a failure with my built-in binary which i
> > > didn't notice. I did a full rebuilt and checked the elf this time :)
> > >
> > > Built as an earlyTA my error now is:
> > > ftpm-tee firmware:optee: ftpm_tee_probe:tee_client_open_session
> > > failed, err=3Dffff3024 (translates to TEE_ERROR_TARGET_DEAD)
> > > Since you tested it on real hardware i guess you tried both
> > > module/built-in. Which TEE version are you using?
> >
> > I am glad that the first issue (TEE_ERROR_ITEM_NOT_FOUND) is resolved a=
fter
> stitching
> > fTPM TA as an EARLY_TA.
> >
> > Regarding TEE_ERROR_TARGET_DEAD error, may I know which HW platform you=
 are
> using to test?
>=20
> QEMU, on armv7
>=20
> > What is the preboot environment (UEFI or U-boot)?
> > Where is the secure storage in that HW platform?
> > I could think of two classes of secure storage.
> > 1. UFS/eMMC RPMB : If Supplicant in U-boot/UEFI initializes the
> > fTPM TA NV Storage, there should be no issue.
> > If fTPM TA NV storage is not initialized in pre-boot environment and yo=
u are
> using
> > built-in fTPM Linux driver, you can run into this issue as TA will try =
to
> initialize
> > NV store and fail.
> >
> > 2. other storage devices like QSPI accessible to only secure mode after
> > EBS/ReadyToBoot mile posts during boot. In this case, there should be n=
o
> issue at all
> > as there is no dependency on non-secure side services provided by suppl=
icant.
> >
>=20
> Please check the previous mail from Sumit. It explains exaclty what's goi=
ng on.
> The tl;dr version is that the storage is up only when the supplicant is
> running.

I definitely know that OP-TEE can access storage only when the "user mode" =
supplicant=20
is running :). But fTPM NV storage should have been initialized in=20
in the preboot environment (UEFI/U-boot).=20

It would also be helpful to understand the overall use case/scenario (Measu=
red boot?)you
are trying to exercise with the fTPM.=20

I also want to emphasize that this discussion is turning into more of how=20
fTPM gets integrated/enabled in a new HW platform. =20
fTPM is hosted in github and you definitely bring any issues/feature reques=
ts there.=20


>=20
> > If you let me know the HW platform details, I am happy to work with you=
 to
> enable/integrate
> > fTPM TA on that HW platform.
> >
> Thanks,
> The hardware i am waiting for for has an eMMC RPMB. In theory the U-Boot
> supplicant support will be there so i'll be able to test it.
Can you give me the details of HW so that I can order one for myself?=20
Is it one of the 96boards?=20
The reason for the ask is that we have not upstreamd u-boot fTPM stack yet,=
=20
although we have future plans for it.=20

--Thiru

