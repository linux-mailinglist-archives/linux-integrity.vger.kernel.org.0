Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E235828E349
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgJNP2A (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 11:28:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:13726 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgJNP17 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 11:27:59 -0400
IronPort-SDR: cfm5kEOkfsWCY0vo5YlHukMGI7txqPUETfaaIuFQZ1Rz8pX4VDXUuCe7P3QqyssAU48ECRwjfr
 p4WPOIlsungg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="145989602"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="145989602"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 08:27:58 -0700
IronPort-SDR: +59IktWe+acc4MhBaGdC3vLAEPbhjKcPRewl6t08yPffn1AiNfaBu3cLcXNVDzcSqijoZX0tYV
 DzJNkcbGHE8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="357404014"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2020 08:27:58 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 08:27:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 14 Oct 2020 08:27:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 14 Oct 2020 08:27:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 14 Oct 2020 08:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQJGe6JK8fm5O2PRGbRpLEuMMdXQuj8eF1UUd5XrOQVPVnR1kGKjiSBvgY2TA1srjoquwSZnrcYmNR3VhQ49xGzyrTChlo2+5eqILfFiKBH+5HHJmeRTvTFmym3fzreiCJ/2acAfSwTkLA6KXHpqWZ38pk2FsRgKHNTeEApS8eWTFnP4EnSIW8U+1gjUFZmcFhZozReV1WXXANEHnFX2HZ+PkRb9ghAiUC71JRFX770dhEUw4m4iimtKt1fqhkxbtkaN8kUOCpTLtGSCouuXVuH49dnAHckH1stWFSf3KlmVIMLdrFdzqnKyYefZe8Sp6vi6FYAbaZNzRqfoH0w8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjtvwrLNfv+Uryvusm9BfQ8YxNtVrglxs8/Pf+fgPRA=;
 b=dhHSfSS1DcCb/qJYCQhL2N5n3g4uIS9uFEd7XSf+e0qnRbzCz/k5083hPYouwcKvR0hNIQMa4Sud+i7XQjz/Sx2y0mBbeOQ0kr3rGB1f0N7lgHRM4gikccR84awWn6LfODLhWlaxFRVhu16m6PWYmvdQoTqWymY7Ofl4gOMruencpY4ud+kMQ0VBemAOXPAujSV/t/vgVS3t62swNXxg3wnKBoPz+u//Mdxy+GD94w4Qu7QLoMtJZXGSGbXlcFDoQQvMWSvKtxHgKmSSIHXl/IxAV6sYUhB5+09Opd0M9zmdNeY2MWaaPIwTgqOqQXvf+R2cD17J4IGIv/jdhdxpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjtvwrLNfv+Uryvusm9BfQ8YxNtVrglxs8/Pf+fgPRA=;
 b=T+jTR/1LQAsdpmZMww+Pnpe2ZJZPrRNmOMlsn/QbtVxTl/0O8ROS1LQmtrZBSjN8awPiLHg8w2ON0rZhrdk5fURBqBVu/uFI9hSauEljeZMGl2ndjNL7uO6lI1NcUPXkE1XD4XyUcX1tXor38qjG0ny3Zsd04MEHCOCj7T5o/JY=
Received: from SN6PR11MB3437.namprd11.prod.outlook.com (2603:10b6:805:db::13)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 15:27:53 +0000
Received: from SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204]) by SN6PR11MB3437.namprd11.prod.outlook.com
 ([fe80::7d04:a30b:7d9e:d204%4]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 15:27:53 +0000
From:   "Roberts, William C" <william.c.roberts@intel.com>
To:     "tpm2@lists.01.org" <tpm2@lists.01.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: QUEMU and TPM2 device emulation
Thread-Topic: QUEMU and TPM2 device emulation
Thread-Index: AdaiOXxaeO4KYc6IRQKmBbySOBZp9g==
Date:   Wed, 14 Oct 2020 15:27:53 +0000
Message-ID: <SN6PR11MB34372D6EA769E056632095CFB8050@SN6PR11MB3437.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf1a392a-4ccf-45a4-fb5e-08d87055b814
x-ms-traffictypediagnostic: SA2PR11MB5082:
x-microsoft-antispam-prvs: <SA2PR11MB5082DA7BB496ED98E5CE74FEB8050@SA2PR11MB5082.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YQ2JtUZKqSpUlrIZqWV9qWtNK8Ib+9Ttv547PwXRW8MrN5UrDtwWrSRJ+rIBIR9Ut+Iwpbn63XX4JiA6qM/RemIysysagHVLUbKZCNupogfcTf1avvFeN0LVYzjmYrZ1jW1f5p9nUzfNsHO52ZiGZdp7GP80O9S/H8FF/bX+QJvTtbwKRh2mwKoBZ85+5TLQFMrFPMqXZZ++7SzvPbB+LVdbUOSnknXb6Kq3P1AvPyOAQmeXSqMYIoX57OWxEpmw37poF2nvMc71q/2OTg7wtzhOH8vgdLg/vltQfe2trEVjVGGXbemb80NPpMLEpbGCvQuu/hsuqYZHQ4qzW8l7N65rsMU0kIavYKgDBI8ZQ7DsQRMX8DeCrsTDz4DmD5SjSJTI0cWloQZUmvlsnBGTqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3437.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(8676002)(76116006)(5660300002)(52536014)(316002)(110136005)(86362001)(9686003)(55016002)(478600001)(26005)(966005)(33656002)(186003)(7696005)(6506007)(66476007)(66556008)(66446008)(64756008)(2906002)(71200400001)(83080400001)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: L/NPgyu+NeCs+90tPYItfKrNHz74vOygT4Mu1bK0Gfomt0InqVoaoKstd44GM40OxGSwB/iihDuSMiHxjfLKiIbbPd+YiitHkCUmTvWqr0Pe5tLJoH8PccVVkydn8W1EHByOvtYXBV7SSj3ujeRC5Mlqkbw/EhiSvxbFLCruEGJokIts7HzUF8PmJjjCGFuSiTXnsgZhNaWksxf0tv4lxe4aW5/Xnq/R59zyw0Z6WW0PSJQawp6BRwxB6xoGrYNMW5qk7w4dh7ejlVQFqHSJmK8XawQuDKKdvcUSaKGKr28pmVQ0AsXhrg6h28nFGAghwbSyyJWscKs59fzMc9ddz75bgKUEl004XB6R/hjENnik882pTL6PUgNEBsLn0ElZVWDzuEU47SI4PrahGniZkHPz+zxMP5fijMgKGwlaLw4Qc69uFJVKkFcv1s8PIehSpU6dKbSxjRfp2wFyL8ngWeFpNwUo0KNx75sLTc0AlHSX9x8mPLXi1AFzu39CJNk1hQ+CzyJBQyWCg/hwcsBB9OU23HsUhmv+ou+YJNdLAG99vLtXOHExE7ceSxHx4wUwC4dnBSkGw3RhlgW7ILwS42N+++Iv8YXNGEdAzOGBS5QhYoL1rDgg3C5ZCcdHarcfDyTIpe0W6x6UoCUg3EMxXA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3437.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1a392a-4ccf-45a4-fb5e-08d87055b814
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 15:27:53.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4/7jZyDBt9buQVfUSzoJDCWaBSYgZhsJUYpZQVAoYYOvrFE8gyy2eQbHrM7KW7QS6/UFcW6RfgruYqa8C3H+VYCZDfZQEwMgLpw0jrojKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Has anyone ever setup a QUEMU instance with a virtualized TPM? I need to tr=
y and replicate an issue with the in-kernel Resource manager. My goal is to=
 use the integrated QUEMU support
To bring up an emulated TPM device and it's associated RM node @ /dev/tpmrm=
0.

I am looking at:
https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/do=
cs/specs/tpm.txt

Which shows this command:

qemu-system-x86_64 -display sdl -enable-kvm \
  -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
  -device tpm-tis,tpmdev=3Dtpm0 test.img

<snip>
#> dmesg | grep -i tpm
[    0.711310] tpm_tis 00:06: 1.2 TPM (device=3Did 0x1, rev-id 1)

I have a few questions around this that I cannot seem to dig up any documen=
tation on:
1. How to specify TPM2.0 device? The project https://github.com/stefanberge=
r/swtpm/wiki seems to indicate it would be supported.

2. Does anyone know the minimum QUEMU version for this support? I looked in=
 the CHANGELOG here, https://wiki.qemu.org/ChangeLog from version 2.8 to 5.=
2 and never saw anything
Call out TPM 2.0 specifically.

3. Does anyone have or know of better documentation to set this up? If thei=
r isn't better documentation, should we (read I) create it? This seems like=
 a pretty handy feature.

Thanks,
Bill
