Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9308A319A2F
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBLHU7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 02:20:59 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:54951
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229592AbhBLHUt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 02:20:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixkgU1uTY8GQUraojEDixymBZeKck4+RDozp7zLPyP0yxQE9itTGztfGV6/3K1jkO6D4DqOaBMbjApTR541yuk7NtjMWhHwLCHPntd8j0gLk38pDwy4Xou9EIkQNcwQiXb5vUAPAcuLQ8n24BBQ8lRxuuo/HRhxgkp2TFAOkT1Q7mGSaDSVD4cRiFOtyIQk6JSDIzubQ1O0P3WL3lUqnoIt7NNifTKyI21V5DOBIhDouS1mgdPAdBgkyKX1TdygMsBVQdZum97k4DYbd/ZLP8IPA+ExkHnzqiAEoMiRY1j95u4uOlUYnk3w8ftgBHdGeQLsxNKpBwdNlcaCAE8Xwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K78PnY9Uw2+qSszYGnKr4ezzXY9xB5PFIdXXSZUR5w0=;
 b=gjpQycUsbQ7tjvuHA0uJ+xiQo7ts1CWDEujECn5Sy2SLdl31gVR+wLf1AcO+4E5e4/TLxF+iHqHz+jO3/rvo64iXjnnpWC7rwXNbDnVObxzPpdmBfKWcgUnreA9cLH8NEP+8B2mwoRgoDix/EfNnvfzi8737wFU7upO/LX1Ui2E+Lz4PgxotbEdD0p0qePqnhd4Jkuuod8WMOgwCLz4iojpNVaoJot03SyI3lEbUdUUFDPbTVB2Do33f3Dqg8dbOaMmuzqq4c9loHfYetyMOgFJDjXbQdPtINVqxOsUbf3JUqZooqt7v5k91MpF2bJtWjAIunMa0LXfc25f2Vg1nvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=siemens.onmicrosoft.com; s=selector1-siemens-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K78PnY9Uw2+qSszYGnKr4ezzXY9xB5PFIdXXSZUR5w0=;
 b=MfX7t2FJXlEoleH72aCwiAPvekNSwKHemaRFPv1oq6i/V3YRO8dZzwxRgeu3KHUeaTeStXUBHABIxQneTpWNUG59UrKTdCY1OpAGn14198nOjB9eNDuSJEbB7O7FEa56ubtJCdGbgKv4FoxNb/ZjjwAayi42Dk78yuJas1k3wVk=
Received: from AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:115::16)
 by AM0PR10MB2609.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 12 Feb
 2021 07:20:03 +0000
Received: from AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61cb:96f8:9a62:c18]) by AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::61cb:96f8:9a62:c18%4]) with mapi id 15.20.3846.025; Fri, 12 Feb 2021
 07:20:03 +0000
From:   "florian.manoel@siemens.com" <florian.manoel@siemens.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "Fuchs, Andreas" <andreas.fuchs@sit.fraunhofer.de>,
        "Peter.Huewe@infineon.com" <Peter.Huewe@infineon.com>,
        "joshz@google.com" <joshz@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: AW: TPM V2: kernel panic on linux reboot
Thread-Topic: TPM V2: kernel panic on linux reboot
Thread-Index: AdbrC5vRfY3emgdzQJCNnKjYyzhKVAAAgKhwAHx7L4AB7rMrkAB26XIAAp4fG7A=
Date:   Fri, 12 Feb 2021 07:20:02 +0000
Message-ID: <AM0PR10MB254856FDA3E44D4373C17451848B9@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
References: <VI1PR10MB2559EB47FE26FA85EB4B4D4484A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB2559EA5D0EC208129AA503F684A70@VI1PR10MB2559.EURPRD10.PROD.OUTLOOK.COM>
 <YASDd5pphvndrsm+@kernel.org>
 <AM0PR10MB25481FFED2CDFBEC5596098F84BB0@AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM>
 <YBSZWPNUV2y09Yg0@kernel.org>
In-Reply-To: <YBSZWPNUV2y09Yg0@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-02-12T07:20:01Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=0d8bae08-55cd-425a-997c-bca4e4a5c06b;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=siemens.com;
x-originating-ip: [94.134.180.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 69827fdd-1305-4668-9c93-08d8cf269d77
x-ms-traffictypediagnostic: AM0PR10MB2609:
x-microsoft-antispam-prvs: <AM0PR10MB2609D82BD508688EF34844A1848B9@AM0PR10MB2609.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gm4XrBGaaQf5cjExTxx2MmwkXy/v6kYVIFJL11+nrTmRNQxQ57WKIssIkPgYGeTvPhVD+IyPor5Q/EUTuFnQiFReAz0OISSCWMkboPojWUoqMIGkTYYEk316FFbDSIaP1Dk0gYLsWI7IgeroxTg6Bvv65raxl3BRcU/KxIC5TAC5z46lE84BqMFpckV10ZsrX6DKPd5ykYO+AJCQemJUeYUrdaMbCEQx0BzuDsKkuDMtgWKpRpm/L+ettz4JxS/sKMNVLFta3ysIPapq9vnHoNuoBkypp4iBHdHGJf8G4scXTSQ8SLOEhyqAAaaXg2CYaaIZiEkgNfD+637eB7TVCr2gHYDOrjgCjrXqL8SDfUyua6/2iITfb6ugF1M3BJpRKWCQXDUikRWn+C/A1h637DF5ZtfpgU9xfUGdyKLZheYrkaz45VLJF/2w6eqdX8a2hUffgd3fvMsnSEm5QLDQrih7NvkFX3ZVs4fpB1iwlLmQ/Qj/xQMGlOCwFVn84Yn1sTgJH7eYTFz1BKtmuNxhpvnELhtVq1meM4SIaoCvL6gVifZ4KMlMuPSt9bfFcE75yFFtZaWZbhd8ZUmXMLSmS0PoLtP7X82Fmv6Ax+bFNas=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(2906002)(8676002)(64756008)(71200400001)(33656002)(66946007)(4326008)(66476007)(45080400002)(52536014)(54906003)(66556008)(66446008)(76116006)(66574015)(6506007)(83380400001)(26005)(478600001)(86362001)(15974865002)(5660300002)(7696005)(186003)(316002)(6916009)(55016002)(8936002)(966005)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?iW0pixsw9HqCxct5LJdjRfA64aJRo9G/GBxo/nzEMfto5jLXrwm3Qeo1aT?=
 =?iso-8859-1?Q?L5qEotfM+oSlxlkvD1uPSrH3XqoRdNC2W/vME318jSFCSb1xWKopEUXG6R?=
 =?iso-8859-1?Q?XNnWYvpkYWtAG6usK8eAMYhIFqr5cqg6lbpWVwyCv7Gtf1uWJQBnKxBdWb?=
 =?iso-8859-1?Q?kya10YaCWRNRNcYvFAkG0XK4ZlMze8L+GWffQxS2YGQPkO0g2F17Puw2dF?=
 =?iso-8859-1?Q?lIgbqk8f7c1SfbSvOCkJPmcZ+V1JtdpsKRKejAgJ4ZHM3Prn4vuTtYVsW0?=
 =?iso-8859-1?Q?aC7Wt0plfdKwJxbdStOZ8EYHAnA6M/9q8DI5E3glScS1JTPHFKxtvnC0jd?=
 =?iso-8859-1?Q?wwKpjTA8BcA/p7q1E/2YbRIAqYdmxpJPwVrRqRbh2SeImFZnWJAny4oQ00?=
 =?iso-8859-1?Q?8IyaGpUOO9MIetL+fsRfKV+VAZxWqfDJZj2Ibc7wG4ZtgxmpVt8dBb8q1e?=
 =?iso-8859-1?Q?2JxJWmNHIyPTm3sPWP48/fyvsJ+U1ekAjTT08ZCRB8nR/VQRx3bf3xhI4C?=
 =?iso-8859-1?Q?B2CyWDtpoib8JRZKffk23+KzFU3VBc8v9AKBQx8J4GgkjzIAeWORpoTSDR?=
 =?iso-8859-1?Q?CVLpMxUvp6ieQ0K/TAwXMrpJUnfSDFYu2yh0DHyRDzMy+LcD6FUKW6c9BF?=
 =?iso-8859-1?Q?dPkapt6pio7NNj/wwktrNy1KSlmOR96jnBvGrCEfSaO6DL6dL3y57xtWZj?=
 =?iso-8859-1?Q?YbkpOJcclmov1z5VjQwo2+f8rmpHzbwwB71migDopYyHKzmxGX0HWHd2hs?=
 =?iso-8859-1?Q?O2RRItLG1WfFo3fL/9DOMj8yLm85FQ/IHWSHGvcQGPL1KsxeU2sDeOQsDo?=
 =?iso-8859-1?Q?DVMlnnevFJEHBadRXpamUz3ciZv1Ov0mHsx2Zbz0EyzB7R6Vc6RLY3UIzL?=
 =?iso-8859-1?Q?htiLkrZlsXuOeVaJQGowXxdmX/4UyNMZPhH4um2lqqs2wvAMzP0qVcMAsq?=
 =?iso-8859-1?Q?AWPod1ZsAX5xbSjIeQJ2EXdXbaLF8XgSENHfn1gPSLNQWtP4BlH0pR42N5?=
 =?iso-8859-1?Q?QHC2EphehM7kpFv4v/G5xJ6G+pJmqJszGPHZhddbV70DTI7ziiAo7RxKCH?=
 =?iso-8859-1?Q?NNmUdF/O8VbG7yUzjNzwPGIdmVNpIozJ5ve8X/+KGF3Oknx+V2XxpxzgCj?=
 =?iso-8859-1?Q?FEFVVmti3w8QWv0vRthCqlkPof6D1oCXvhM8kAWXAEYuMc9j1UUsyoRiC4?=
 =?iso-8859-1?Q?QPRPjdFVkqR/ib5qvYk0ZgwJKgHFgpc56NSdBZLDJbwlWjvK/IBtTZO0/D?=
 =?iso-8859-1?Q?yCZWuxYsYC4BEqxcsMWx4SNNk1pqmJtR4YIEGBljLod8Rdai74PgI3/rCP?=
 =?iso-8859-1?Q?DBEM9u33To/oEA8GNPtGGb+wo8tSwyz67RwrnCvZ5mNWwifzwPA6xSIKUV?=
 =?iso-8859-1?Q?g/2OYlPBoR?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2548.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69827fdd-1305-4668-9c93-08d8cf269d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2021 07:20:02.9164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clQlEBV0VJRbj1Qjdyt98RxJMnzOFFNLMaSiZbmT0MemsnmdLRar1qkZLSsOaDkCDD/EeKrPEqKtzpQarYFzQ6kw7+J/f5Tt3erbiknxyes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2609
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

=3D> Last update and happy end

To remember what the issue was : kernel panic on reboot on a custom board e=
quipped with CPU NXP LS1043a and TMP V2.0 Infineon slb9670 (spi interface).
What we did but didn't fix the issue : update our kernel to 5.10.8 =3D> pan=
ic still occurs
What we did and fix the issue =3D> use this patch : https://lkml.org/lkml/2=
020/7/9/1242

Now everything is working as expected and no more panic.

Thanks again for your support.

Mit freundlichen Gr=FC=DFen
Florian Mano=EBl

Siemens AG
Digital Industries
Process Automation
DI PA DCP R&D 2
=D6stliche Rheinbr=FCckenstr. 50
76187 Karlsruhe, Deutschland
Tel.: +49 721 667-20051
mailto:florian.manoel@siemens.com

www.siemens.com

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Jim Hagemann Sn=
abe; Vorstand: Joe Kaeser, Vorsitzender; Roland Busch, Klaus Helmrich, Cedr=
ik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese; Sitz der Gesell=
schaft: Berlin und M=FCnchen, Deutschland; Registergericht: Berlin-Charlott=
enburg, HRB 12300, M=FCnchen, HRB 6684; WEEE-Reg.-Nr. DE 23691322
-----Urspr=FCngliche Nachricht-----
Von: Jarkko Sakkinen <jarkko@kernel.org>=20
Gesendet: Samstag, 30. Januar 2021 00:25
An: Manoel, Florian (DI PA DCP R&D 2) <florian.manoel@siemens.com>
Cc: linux-integrity@vger.kernel.org; Fuchs, Andreas <andreas.fuchs@sit.frau=
nhofer.de>; Peter.Huewe@infineon.com; joshz@google.com
Betreff: Re: TPM V2: kernel panic on linux reboot

On Wed, Jan 27, 2021 at 02:51:56PM +0000, mailto:florian.manoel@siemens.com=
 wrote:
> Hi,
>=20
> thanks for your support,
> an update on the kernel panic I am experiencing while trying to set up a =
TPM V2 on an ARM64 NXP LS1043a custom board :
> We updated the kernel from 4.19.144 to 4.19.165, no changes, the panic is=
 still occurring.
>=20
> I started to debug, and identify what I believe is the point where this k=
ernel panic is triggered:
> '/drivers/char/tpm/tpm-interface.c'
>=20
> "
> 	if (chip->ops->clk_enable !=3D NULL)
> 		chip->ops->clk_enable(chip, true);
> "

BTW, that is quite stupid code from us. In all cases a direct call to
tpm_tis_clkrun_enable() would make a lot more sense. Anyway, this does not =
explain the bug. This just hurts my eyes, that's all..

Anyway we, can disclose that function given the IS_ENABLED() check early
on:

static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value) {
	struct tpm_tis_data *data =3D dev_get_drvdata(&chip->dev);
	u32 clkrun_val;

	if (!IS_ENABLED(CONFIG_X86) || !is_bsw() ||
	    !data->ilb_base_addr)
		return;

I think a safe conclusion to make that chip->ops is NULL, and causes the pa=
nic.

> It looks a lot like an issue that is described here with a TPM 1.2 :
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fchro
> mium.googlesource.com%2Fchromiumos%2Fthird_party%2Fkernel%2F%2B%2F01d1
> d6e2a1a74b9b8acba7d5eee67fe83e914aa1&amp;data=3D04%7C01%7Cflorian.manoel
> %40siemens.com%7Cbc4c3252c2d74220ab9308d8c4ad25ab%7C38ae3bcd95794fd4ad
> dab42e1495d55a%7C1%7C0%7C637475595224343568%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3DVVG4RNo6gtCj8X951xMX%2FsypZ34b1mvaROJmP87r5w8%3D&amp;reser
> ved=3D0


I get:

"NOT_FOUND: Requested entity was not found"

Please try out with the mainline kernel. I only now spotted that you are us=
ing a really old kernel. And I have no idea how patched the kernel is.

I misread last time that this happening with the mainline kernel. Debugging=
 downstream kernel is unfortunately out-of-scope.

When you have test data with the latest unpatched mainline kernel, it makes=
 sense to look this further.


/Jarkko
