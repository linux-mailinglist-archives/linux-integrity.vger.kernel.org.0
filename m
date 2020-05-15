Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1691D5B24
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2020 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOVDT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 May 2020 17:03:19 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:6187
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726179AbgEOVDS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 May 2020 17:03:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLmf4/CgpcbWS4EMUBWP2ZUbyr+j1J7VdGcHHmzgeclI0l+fptnUVtIjtPS2iEJvTNVCH8vZXu31lR4wpyWiiIF+BiiHVFdX53uWVKUv1JrqVm87RfGoVq+A7ewE6jQl97F0kghmS/I4nBymlaxNPMmyqs1vmMLwRBkLFyjmDYUFbtD32t36cWiQenTGvDOyFRwincFseN07wb3OLlFKE4y4XLIn/XUIhdNSLJfTRfetrKMTRkSyRJA8D1P5JGfW3q67dhOh9jMkksqr/sHueHviVBZ2+8GcKLD7CJdtRKGf1Xl9MfQDT5c5g3S+aEXQQIGKXTGI2JAveZoZR4Wt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRSLfmqymLnzfz3PEfsKfi9UcIn5kDkV7j2EykzuLf8=;
 b=KlXgx8XgQHllSdFg5r1A7XHM/10LXN9af/IwhSRqVX1nxRMdwLOY9OSrBIvZ2exgJHYSDeuueUNme1qLhvPxNXu1DfsCcJ/zlh0thZQ01FCq4dQeQMIzhiJ+PUMDQLVD6RYUwIJvWq6oedxR4mYesIkqP5vvsqe5HpoMdA52QhXPbbNw8t9WWqfUdgA+v4PcFgLlKp6axQltjKSOsnk+OIQOV0WxwwJJ0jOFUfvgUrZgSdHN5sPJLmaSdj3dIGInKVYd/y4Vm4suyLSLfOWuKW/+uVvS6CUjyLjCCcxo39TWaeyzZoZdfdms0bx8UKF8RPPIC3w3Yj0idGrqU9vy9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unh.edu; dmarc=pass action=none header.from=unh.edu; dkim=pass
 header.d=unh.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unh.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRSLfmqymLnzfz3PEfsKfi9UcIn5kDkV7j2EykzuLf8=;
 b=igYyJpP9tBmfQxee3eE9Zu0JPqRUM8YTbGTmiPV2NrJ84pxNMBXLK7bzU+gq/+sQrTK+Mcl7hDn4gegXv+LQPrXNVl52tSyn/wLuV8o7jM6bgqtUKBRrm5UrRLSdkJwwmDXe4582hiW2uTXHqJWirzp4HBpbFZotOzVQiHiB/7I=
Received: from BL0PR04MB4723.namprd04.prod.outlook.com (2603:10b6:208:4c::28)
 by BL0PR04MB4738.namprd04.prod.outlook.com (2603:10b6:208:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Fri, 15 May
 2020 21:03:16 +0000
Received: from BL0PR04MB4723.namprd04.prod.outlook.com
 ([fe80::c402:eb4d:6e41:6270]) by BL0PR04MB4723.namprd04.prod.outlook.com
 ([fe80::c402:eb4d:6e41:6270%7]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 21:03:16 +0000
From:   "Kayaalp, Mehmet" <Mehmet.Kayaalp@unh.edu>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
CC:     Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Thread-Topic: [PATCH v9 0/8] TPM 2.0 trusted keys with attached policy
Thread-Index: AQHWJMTr+JeQQ6Ae60O53JcdBv30ZqinrwwAgADGyYCAABbfgIAAVJAAgACwRwCAAASpAIAACfWAgAAOzYA=
Date:   Fri, 15 May 2020 21:03:16 +0000
Message-ID: <56688CD4-A4A5-4D98-8724-6CBA10C7E1CE@unh.edu>
References: <20200507231147.27025-1-James.Bottomley@HansenPartnership.com>
 <23639de13874c00e6bb2b816b4db0b586c9a074c.camel@linux.intel.com>
 <483c4f1af7be41c8d091b11d4484b606ebd319b7.camel@linux.intel.com>
 <1589514263.5759.25.camel@HansenPartnership.com>
 <20200515084702.GA3404@linux.intel.com>
 <20200515191758.ieojyk5xhsx2hzzd@cantor>
 <1589571278.3653.22.camel@HansenPartnership.com>
 <1589573417.3653.28.camel@HansenPartnership.com>
In-Reply-To: <1589573417.3653.28.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hansenpartnership.com; dkim=none (message not signed)
 header.d=none;hansenpartnership.com; dmarc=none action=none
 header.from=unh.edu;
x-originating-ip: [71.233.81.115]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dac857a-2bb5-4a70-8143-08d7f913638f
x-ms-traffictypediagnostic: BL0PR04MB4738:
x-microsoft-antispam-prvs: <BL0PR04MB473886FA249760E76749D3788EBD0@BL0PR04MB4738.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OKfJ0OOLDu4K7hN7LCmmVCZmI0FMVrwsbztGAHgH1HWS0Fj1oVUJa4v7gwll8ufjzrZYqVX1vS9H33vEWYliUWWmaa5zXOKHKQ5DSuEqXj+rXl7yJYebaIFY4lqWi1ZfFg3R1Z7LW7LENGD8RFvHwfaoUX9HyKQrRJ2pDN0Hme894f4vnl672IH61ywBkNc55cXaydzVfu/IYnjzJ4B8T0+EfTlapJg7+ibmHuSGPEt2x5tAhh1woFHX/Um9RtidDDMFUtQF8r94+i6NT3W+n9K3ovKMfp/WKhg34IyKXNUj53pX73X9C48MN+HCs16qYNdFA8LQOw87zF1l4YnON1aoM4+l+3u7MGjSlS/eghddDQpy5Yb0N08E9pRfp0XFWPM8jVO6IrmWP8CQzmzDU0mmpZSPCScnZxHmqGRfHl4BHko7k006gw3pOWR36+Gu5Me11w8wdGKL94KfwU/Y+P0xpsEe99nU0MptNC48D1LeJTI29+11e/bWnUApHm+9CZI7Y+a9kjCrpgajDf9L9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4723.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(4326008)(36756003)(6486002)(6506007)(966005)(6916009)(53546011)(66946007)(76116006)(86362001)(316002)(54906003)(478600001)(8676002)(786003)(75432002)(8936002)(2906002)(2616005)(4744005)(6512007)(5660300002)(26005)(66446008)(186003)(33656002)(71200400001)(66556008)(66476007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OL7FXztW49HDh78rxIm17hwgJhXFShCSc4XONorfYc+38v2x89KYMY6ka6O+JKXPYqVdpXni3Tp9TpR4D7lMtkSlJ9xjvTjoVDqWS05DLr+47OzVw2/E++Q3JuUM+l2E1Czg+NE/wZod6G+IsPihR0x/r4UbzWsyI1FlVhG/DkREOKYZj7CGus1KV0EcIjyqyZ9/L5UV7BawJsbRySA8yT/PdGWFevNWMH+zUijdkdoNnachShF+Zcbs8vrB8ISUu8osDTNZdfoDUpVHJPieWAGxKzZ687vSAqUupWG1LXSlgW9akOZZLbmt5Yv7tzk/2GFXxeiQ5+OG84zl+FcYy8R0RD99KRdfxyiJ73JI0Ly0z4m+LNfxmYEgJsgPi9gnvogyf6K2a8UvTopd7g7ceGFCwCuwxZ3pd2+NTc5Q+raFpjJuKP7+Qa4gN5BeT6DFTdVdyIz3DiX4UpTIJvIvr8GWSmtDsDMGvjNhPjDHjlI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92E9F77926947E478786C893B301D5C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: unh.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dac857a-2bb5-4a70-8143-08d7f913638f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 21:03:16.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6241893-512d-46dc-8d2b-be47e25f5666
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLJZ+MgpfWZ1BW662fUoL4bHnrT3c5tkv3+hBcZ8fPEjv8CKJD6OWlFYcsR12Ywi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4738
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On May 15, 2020, at 4:10 PM, James Bottomley <James.Bottomley@hansenpartn=
ership.com> wrote:
>=20
> I think that means the solution is not to run the smoke test under sudo
> but to do sudo -s and then run it.
>=20
> James

How about "sudo -i":

https://askubuntu.com/questions/376199/sudo-su-vs-sudo-i-vs-sudo-bin-bash-w=
hen-does-it-matter-which-is-used

Mehmet=
