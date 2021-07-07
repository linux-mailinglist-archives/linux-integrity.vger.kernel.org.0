Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA553BEA6E
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbhGGPNB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 11:13:01 -0400
Received: from mail-eopbgr20125.outbound.protection.outlook.com ([40.107.2.125]:58883
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232133AbhGGPNB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 11:13:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZaoHHcxgkAjfq5prsmm1K46mvaPFZiWCtw2Y5dyFYJWISEwHD9NZ3XpYBuJ4rU1Kws31poNPkCZ2Vu/GA3B4hhE/e4fD6riLzmt7wnMSulunq+zHWLeX8D/jrX5XCooCF/LkYrh8MqPZwnDt0Edl6Anzoip4qYkkth1KHQxZOsodVu2Y0SL/KAE945xiRK14LD2BJj8o1MaSTEpnDjX1eVaWq9Mq4GEo9sDCpn0Gh+aGcoiSTF6W4DI2qUKCIPI5uj7ibQFyG1RL+IhKkqzJGoidxL/8vJA8i8M67rngmuQqG2l0aXCfY/ovNfrXVCfugBtfVfg+/lzmFWHm91do+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjTu8jgvhFdczfuU0tQrIlxdn43Pt8U0lObdEwq+ebI=;
 b=PgnGvD/3bmfe3OlO1CcbzIZQaQxnuv9KGdZhGvs4G5TbW7wp3sZoA4V4Y0o3KmXPywVbg7HYW2GtzpieqkO138OCOlo4T+qYrHx4uErrtr78nIYsmnTRggpeQqQAAURGT/622JajnMxQJm0d/qYbnB2hX+8kzYmaaUkDQRCfvau0Px3yDBVKQwcky8ZPqkhxqYMB2reYMd6x/mYDu8F+QjH3rbNsM42P2F2/EA2jwItmVr04PTibu/xerGenWUL5P/dxY998sVnCeo3PwN1z9PW8oYcmUG67eFRyQDG1VDxub5TsAOOlAZ/AzkytEbeI0u/OC4aDvrDVszXuGdV+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjTu8jgvhFdczfuU0tQrIlxdn43Pt8U0lObdEwq+ebI=;
 b=J165ES2/BqcNAIM4gtHGrlw/EbCP2+ToQI4vyuiTnIGvGEGTFcvhG/VZ0pSg5roQS/DYLOBNUJ8Ey0sHsEw2fyrlMxNn5uHBc0oVu9TJcs+CQCovNf24buMW7ncAYuyx/CLp+gc496k0SlLZGQmmxUrIzhgomSc9Sz29OCspRw8=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4305.eurprd09.prod.outlook.com
 (2603:10a6:20b:168::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 15:10:18 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 15:10:18 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: RE: Weak hash algorithms allowed with DIGEST_NG
Thread-Topic: Weak hash algorithms allowed with DIGEST_NG
Thread-Index: AQHXcwvZ3imzEUWtz06ax4bC82bErKs3lRsAgAAAlDs=
Date:   Wed, 7 Jul 2021 15:10:18 +0000
Message-ID: <AM4PR0902MB174890B0AB5F5D96E4366FFD941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
References: <AM4PR0902MB1748D83387C6F3D39C98992F941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>,<96afb16f1f9ac6a476b8fb7be988f90267837c6c.camel@linux.ibm.com>
In-Reply-To: <96afb16f1f9ac6a476b8fb7be988f90267837c6c.camel@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a90999bc-7c76-45e1-6305-08d9415954fb
x-ms-traffictypediagnostic: AM0PR09MB4305:
x-microsoft-antispam-prvs: <AM0PR09MB43054A8BE6F179475C490CEE941A9@AM0PR09MB4305.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Iggor6VIPwftNSuIzkOm7yfdj8CIYitkstn9KOL1uCYPbN1RKET9fsrGpDlDOjBr0WhsmSR8LL1XsNvd6l2aMvR+HLD6Dxx7JPDH0urJoSJyF68EUGoD1EaiQdAWuBQbDYTBk2azI0GBge8OX7D3a3lnf6Z9O3eVZqupzZh2UNhfaGwR6ee5ZkFv5QbYpYxjlEqylTs9NzOH6gLMuOh8YfUM4GBkr6KtxPqxuLP6D4CpNioPxa9rCLklSSCA1LF77Q851k5vBkZA/DX97b5grdJWZ0MbTFfE5keBWg0jlbzMgZI1m4/FMGkUGj3YFBrOxKsmjiv6Uy2Gxz+zBSE/G0AK1NqbgzmCIarZVdohwEEnppw4pJEEv+b3iNi+FP3ABg6UozcrEeEPvEu+htjT6w7cNdS5mkjtdSCGIxWsxWDp4SAJPPEbswVoow0ZySpovyUp9XwhAAKiQQVULmfbF5j9Da7xyCEEyrdL/a5sD8SbBHnu0sWzVGPJ+1r+7QMNocPRSdWoTSkvotE7TALqTP3usULBG+RC3wD/hm8yjzr5izKnhWxnPjmwJSS7WIEvR/Xnygqf5ZrHYeFgVPm/muAGOZ1t0tQUORCVW5e1mefukjR1cy94s0P15GhMYNmqbhyK+rY4ULHPZoG1AUVZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39830400003)(396003)(83380400001)(38100700002)(86362001)(71200400001)(122000001)(186003)(33656002)(5660300002)(110136005)(7696005)(2906002)(8936002)(8676002)(9686003)(55016002)(52536014)(6506007)(91956017)(508600001)(66556008)(66476007)(66946007)(64756008)(66446008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9n2TMdnabqDj8kNueq5vVXluQzERaTl8KxfRHp4ONUNKi1zeIHhZszdyUm?=
 =?iso-8859-1?Q?CUZ5kQzNbJzf0oVwCmJI9ct1pwYA231JVdRCDY0Lmszuj+manobj1FSVKM?=
 =?iso-8859-1?Q?xtzqFMthCkRI3aSIw5qXnuok6W4faCi/ygy6IIh6PPn6jlh2CHjNh3KfVU?=
 =?iso-8859-1?Q?c4SfYqJznuE/gtGq+1oN8vtHKNKSxubg50rm7lEyiFkAhZcudVAyWEVhVR?=
 =?iso-8859-1?Q?nXrApY3Nhv/16nPXwIhBjXzCCJMVyUkg7FP9uBe5ayoa8NLeIo6QhGktrC?=
 =?iso-8859-1?Q?SM/c8LxT3xdw+he7/o7hPd1LMPYJuwtBceMgvXrOwRTcUM5PnJjvgHMWly?=
 =?iso-8859-1?Q?BK2v/NTR1EIYyK/F7WSiR6dTMmUAOhu+pTjFAKcGqhS4b2Wr8KpF1rthlY?=
 =?iso-8859-1?Q?+JD2ZDWyu5sTC7S6EekpPCDQBbMZor4FfL89rNpW6T1SmqWYyGxDfmBewL?=
 =?iso-8859-1?Q?QUjlRjm4hjjtVPAU0Xk6tiifnem7wjtOtGzy34TY4VBKJBvAZ0LLOCvi2C?=
 =?iso-8859-1?Q?Dpg1SUGkQ5gPqBr93D6remM/6OWDi4h2h7gqdmAwpl1jK1flPIBoF1yC05?=
 =?iso-8859-1?Q?dXvXoXWVFnzenjJfBDEpG57usO8xThsw3teMWqpR3yAuvlAGVtNhCHW3md?=
 =?iso-8859-1?Q?k9KPBupSuTtwcz6rC4k/IZTLEaUcUbj6+pIovh0cTTm3adPKD/Xy63MAfg?=
 =?iso-8859-1?Q?zch1Ds5YdunxrmAd6HTGxpUXLoZzvkjsA78BVYxcyghg9oGkFqkvFdyDnL?=
 =?iso-8859-1?Q?oAtkT+l/q3Scbz/V164/rN8vy3v1/C/63RhAPQT6Dg3sqc25u5IfPRENfc?=
 =?iso-8859-1?Q?Noy7KJ+QH/2OaFUJgYEcjlmh/CHRAtF2zVrq/FkR12N9Ohq0n0apMfRQC9?=
 =?iso-8859-1?Q?HsofQBqaZVBrrmEQJBOEwIvPde0lzz4ThSAEUHWWnK21A76b3l3qtx8i3s?=
 =?iso-8859-1?Q?78KMN1CgLZr7Z7Mxp3FECyi26g8laR20Yc9xQqzla51Ym2e10zmOHCvH7o?=
 =?iso-8859-1?Q?Ky//UNOdMJIgogP3KnOX5WJF3dEROBGBRAzbINkTx4cVP93h2S2kz9yH5e?=
 =?iso-8859-1?Q?LkRMvjmAXyjLP+e7tBqRkL2lH1qANrkhokQeBhBf6D87/lQouoWFNTaPlK?=
 =?iso-8859-1?Q?osObT03o0BUHDDp6UlAa4PGuMwhsshvLDd8oPtDSmQ9LxbV9P8fDe2YqhV?=
 =?iso-8859-1?Q?LJrL0rs0T0Lvxq1CKcpsVgQghcLhP5Y5IO8VDUmsyhFJUg6qiz7G8UFfiU?=
 =?iso-8859-1?Q?eQaFIWOyxhpb0p08toVH9oDLvHm9qug/TwG5Mtq0jTYGb0wbcrjIfHivxU?=
 =?iso-8859-1?Q?eQiy3+q7JXxMO4Do5d9tp+zqTJHMD73rfRCgcJAw54EJ2td7h98UYQK9wn?=
 =?iso-8859-1?Q?lTaBaif1fad62EQY4KhaMOkIPYcd8slbkXLLhl2SkjP+1v6ZoRSxYljl6b?=
 =?iso-8859-1?Q?ZRC+yBKQCAvxfB67?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90999bc-7c76-45e1-6305-08d9415954fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 15:10:18.2741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vNCDe370kIe86KsYjd2AWcT5AuBxmlKcGpuVzYtp3nRM7H9qT7BTzFb4/rZwCmw3nITzXWX6kITHa3Fcz1yYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4305
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello again,=0A=
=0A=
From : Mimi Zohar <zohar@linux.ibm.com>=0A=
> Before allowing the EVM HMAC to be updated, EVM verifies the existing=0A=
> HMAC to protect against an offline attack.  It doesn't prevent online=0A=
> changes.  Additional support to prevent crypto downgrade would need to=0A=
> be added.=0A=
> =0A=
=0A=
Yes, I wasn't really worrying about EVM, but only about IMA itself. Because=
 if a=0A=
critical file (let's say bash) was hashed by the rightful user, but with a =
weak=0A=
algorithm, one can imagine an attacker finding a collision (another file,=
=0A=
carefully crafted by the attacker to have the same hash), and replacing off=
line=0A=
the legitimate file buy the "malicious" one. As far as I understand, the ne=
w=0A=
file would share the same hash, so the security.ima attribute wouldn't chan=
ge,=0A=
and the security.evm wouldn't either because no xattr or inode number chang=
ed.=0A=
Of course this issue isn't critical because even if people hash their files=
=0A=
by calling evmctl, the default is SHA1 and it should be fairly hard to find=
=0A=
collisions (comparatively to e.g. MD4 or MD5), so nobody in pratice=0A=
should use a very weak algorithm where collisions would be "easy".=0A=
=0A=
A careful owner/device producer should have no issue, but this highlights=
=0A=
the value of sane defaults, and I think evmctl certainly could benefit from=
=0A=
defaulting to sha256 in 2021 (but there may be compatibility issues I'm=0A=
not aware of that prevent such change).=0A=
=0A=
> <snip>=0A=
> =0A=
> > Is there any way to enforce the use of the hash specified in the=0A=
> > 'ima_hash' cmdline parameter ?=0A=
> =0A=
> The cmdline parameter overrides the compile time default hash algorithm=
=0A=
> used for (re-)calculating the file hash.=0A=
> =0A=
=0A=
Yes, but that only applies to the hashes performed automatically by the ker=
nel,=0A=
not to a user relabelling his whole / with=0A=
find / \( -fstype rootfs -o -fstype ext4 \) -type f -uid 0 -exec evmctl ima=
_hash '{}' 2> /dev/null \;=0A=
and forgetting to specify a stronger algorithm (that's how I learned of thi=
s pitfall myself).=0A=
=0A=
> > I couldn't find any glancing at the code, but I didn't read all of it=
=0A=
> > and I understood even less, so I secretly hope to have missed a small=
=0A=
> > yet critical check/option.=0A=
> > And if there is no such way, would you be opposed to a patch adding=0A=
> > an option (something like 'ima_enforce_hash_alg') that only allows=0A=
> > digest hashed with the values supplied in the 'ima_hash' parameter ?=0A=
> =0A=
> Please keep in mind that:=0A=
> - depending on which file is not properly signed with the required=0A=
> hash, the system might not boot.=0A=
=0A=
Yes, yet in a sense that is also true when deploying IMA on a system, so it=
 shouldn't=0A=
change much is such a scenario. This could definitely break a working syste=
m however,=0A=
so I have no doubt that if such option were to exit, it should be opt-in an=
d not opt-out=0A=
(and to think I was talking of "sane defaults" a few lines above :)).=0A=
=0A=
> - limiting the hash algorithm to a single algorithm would prevent=0A=
> migrating to a stronger algorithm.=0A=
> =0A=
=0A=
Indeed, I fear migrating the system online with such an option would be qui=
te complex.=0A=
=0A=
> For embedded/IoT, these concerns might not be a problem.=0A=
> =0A=
> thanks,=0A=
> =0A=
> Mimi=0A=
> =0A=
=0A=
Simon=
