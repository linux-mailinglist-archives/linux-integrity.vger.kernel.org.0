Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402EF3D8EDC
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhG1NV1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:27 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:63047
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233315AbhG1NV0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNx21xNUENMRwrZ3rk3wEnKGwqDgzH3yHsadXlrN/tMnMtYiYKQtcE5HpHxB+Xl+CHbZQip2VLsQndM404MQWtSnke67yoLg6uqB6VFiPOZGtC0DEBSfTwzWP6bFhgnNNsa/heKUj02zsJ+UuAy2lrW7NUlXUrQWGzdFppNxUtvXpnFNDMo7o2TiGo2l8edqkWA1AtJoP0SY52pYDdYDbHZGwUXKngpjBlJwI6pRVkRkmWnjfIEb9sv/NG+BJGTHSEQfeOWxKnmGOq/BFGcYl2EcQMhTKqhlAg54YXDFFiPfc8iskcDAo+uYirgqWSJg6o21uH1IPWO6GS2BwM/I0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thOr4DJtd++ekMc77I761jlRCrKmb4ACFkD3CpFqbc4=;
 b=Gcz5IsW6nirEvTOt/oOuCaqsL6Uoms9MU0neIAOuDZtmouGGQN4VFIxNpFougq1zqCanU610M9qInwBq/6cuWsKyexEXeZhjEgWVcQvTp88Y9bof14dX5p9b61VwurJKHN+acTe8+TonASaRJcoz8tZsFQk3qAyqOd4vctnyNIlKwx8LtiVxodDXnq7o9qOLnMvpNLq+/CmF0kbEcFmqJ5R2zm2YwhHyRkDf+6TrM1ok47GYhXBVCyLlBokgVhT8A8v96qIWUpextoX2Icofg1OEYPsYYAiJ1KsGtJALZffqhdpH4+pnK+F0c+rXsHK48rOK9nayX+Md1EgFUit2oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thOr4DJtd++ekMc77I761jlRCrKmb4ACFkD3CpFqbc4=;
 b=OBHNnfbJCsKBR9FF6AhQTRKWqdgvtDPHpkEKnGNrTDIizFES9MlRlSAtSAjzUvmfMqQgxTSOWwXTVwsVkJ4ohjUvG5mSMaP2DzORgvyPahtekheedhfntXrXE28+6M2Yus7sdJ2mpIv/4+XIfliuCNwOjnchlzc//4Qws5cr+nM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:23 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:23 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 0/5] IMA: restrict the accepted digest algorithms for the
 security.ima xattr
Thread-Topic: [PATCH v5 0/5] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
Thread-Index: AQHXg7N1xwv4YMww+kaQtFVf/Z4WTw==
Date:   Wed, 28 Jul 2021 13:21:23 +0000
Message-ID: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe8bcf59-bee5-42db-ee7a-08d951ca9867
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3361E975FE52B424DB2B8E2794EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wEGp1Dc9VCrjyMxkcWrS5gSO/PgUyg9+1DupL9PjfrS+a5AtWoJ2moDnzptgS4KRpucHUeo01AOMtorMPdy7U9SEZiedvHi86UZ+13RKuZHPKkc+CjdM3JvRhfVIJeLLjZ+FGqwWYK/ZTGZFtRkzy0S7Zt1DWB1me9FLzO/OdMwrMtRkTGI9cghYf2VKHsmWev+t+XZ187XgqHgnCUfNAA1vWLUAd1+8580gdFMGv8yZub+EFWncaocB5G4xa1Lv8FW5SJTzlnj3o4CBDEI3RIxAPw1czRZO9U2ITg7hzDnvwyuwJ1htWsJ2JMwMfUXpWaXXVI2Kl1uP3a1yIhi6cYQqyC80J0cSGsfrnhiB2ZWrhd/hZrIukm4Nlu6aGokd43pAgK4+79vf8n74qY9KiulP4pozJ2B7FUoEbFLaXw4ppL04EHGnxGS1Fo4nI/LJABcfh6SsMyQq6LNEOUMu5qvHiciYFQciecQqtbqY+gZPZMSIsL9Jdvqu/3ckc4wW5NagUaFrT6DljDX43yOiPcBefTeuHklRz7/ITcKouz62Pm78HbbEOv27MC5KX38JHX2T+aZWQX2YtmM4ezZYQ3g37XpurHLX6X0aNjmArG+UO7VgflYKHyBK4Ty6PC3lVZhZx1xgOQTKokq4Z54OPLvw6mk2s8ZgFz3qZUEvAFs0QtQPy5plqyEleO4l1eeLCZNpc/wXXDgH/pOBfYfq7gc9eZKUXNUJVdHPzCzlQjyL3jsWxm+p3sUB+tFUPU+Jux6L9+nS6CMXmB3uex/jP/9UAU+foCepIIuC5agdg5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(966005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(15650500001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yQCQgDkpftXtvb8W44q+B3vE2J7GI0TckExBlu6ediUsXouGpLjbpdNrsZ?=
 =?iso-8859-1?Q?rWX4LYbJ9H6KkqdJhs/TNAaYvm0xpCjwzskuMMg3Xh3U/M+x2IzTnL1G6y?=
 =?iso-8859-1?Q?fWbXCm5UQAgCeHqY8HdaMNdxLeomnkTXaPE2s5VTwulVnTnkltApLqACbh?=
 =?iso-8859-1?Q?KdHOyauouANlUtmvqL4VHa36DJhW9+9ZW3wXsBlLq4Zpd3PgZ9gy+wYuWD?=
 =?iso-8859-1?Q?Qfv0bhUffMzsVhGnfqit0RGs2//936owNrhR7/Hs5DY4ntIn5HtXDOsLXR?=
 =?iso-8859-1?Q?946uNYIBTINgmeQ4laOS3gXYjqwJw8pXCqiIvsfRfF9BdwZfmMLUetr/oU?=
 =?iso-8859-1?Q?o1B/6t/6EWNdsBH4YLXMh87Oro2tAwOkkQft1DSIe8lScZNadHRZZQOdD6?=
 =?iso-8859-1?Q?fpoBhowWgQ9mpgASEkwSNWcK6d3wAre/GFBEgzL7O2BLMaG/IeBDKOigeb?=
 =?iso-8859-1?Q?XBQOWIPVe6e0Wd/f/JL+F/LOdhS6tHZprXEDrJrBs8+wJdtKqoAT/3Y4zw?=
 =?iso-8859-1?Q?L8IzSfbC4cm2/pLGWQHUw7+PyGOxmaIpDYi3WKKY/p9/hEjiWRIEbUUPK4?=
 =?iso-8859-1?Q?+L9up2CvjB5XyfirPQF/GIHh+RH+MP/5GquMyxw2F9bNh4KETfu3Y1Oyhn?=
 =?iso-8859-1?Q?tfB0/TQSgOM1pyiUonxc9oy+4qSBFs2IkZ3yszRbhacf4qgyNr4vC7rjle?=
 =?iso-8859-1?Q?qx/Y4WsUZJejqsgKVvCvBUcQXC4c3pzQfxiCAOduLcgOvKS+pT6p9xeBAm?=
 =?iso-8859-1?Q?a5WDDqrtHQeA/3zV14zHIH70CmlbRYPkJBxTHah1wrGgMgQR5/M57IWwf2?=
 =?iso-8859-1?Q?DHoCq6JsZUhT0pwa88HvP3C9oxi9nlaeLTa5s8Q143Qv5mgQspGmNk5vNH?=
 =?iso-8859-1?Q?vP++8b06pekP09lEjP5/9ksSikoXP6JnbJhSKGGK0oh5FGHVK/txWMK5Bk?=
 =?iso-8859-1?Q?d64e8zi80r9MgqwdUUOCso3TA0TONjDXDgSlTr1RDrteYCwwtC3woQ7oSA?=
 =?iso-8859-1?Q?hJ4+r1hniqeehzqJAVsBQi07uklCGP5y3/Bxag0iSNZeimdYPkpR9QlFTP?=
 =?iso-8859-1?Q?EFcebhz3mDmaOL1VxTYsp7Bsxivcvr1lmcDbtTMW9Yuwa+ixL7o/wJzc40?=
 =?iso-8859-1?Q?FcFog+4cdHI2Q7kAhtUwChaMvBjRqsESHnevz4sBLHifu6sHeK/WLFZEKH?=
 =?iso-8859-1?Q?vS+wW7UdwXeITM2HIVPB/ci/cH13hZmFPF9hWsh8q2gWYk/OdztF4DFXDe?=
 =?iso-8859-1?Q?oHOp8fp/AFEc3s86r0MsuFmznFxYAnwYcOEcryXZI8zYgy2inurby633jR?=
 =?iso-8859-1?Q?AIKPH7JrVOtHpvyJJ6PCyr3FphXa6Q5O52M1hdPARPL5ofeRAZDRBRHHEU?=
 =?iso-8859-1?Q?cGAKroTp07fBhrwsIt2wjmOuLtOWVsLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8bcf59-bee5-42db-ee7a-08d951ca9867
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:23.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1Oo26plNHmdt/43av1kNRTlI0Sg9zHMJZBwvq7OI42DDSmi4HHcQp7eCxTYeY1iopLf7QHTaa8h1sFan0t1Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA protects files by storing a hash (or a signature thereof) of their
content in the security.ima xattr. While the security.ima xattr itself
is protected by EVM with either a HMAC or a digital signature, no
mechanism is currently in place to ensure that the security.ima xattr
was generated with a strong digest algorithm, and any hash defined
in the kernel will be accepted, even obsolete format like MD4 and MD5.

The kernel itself will only write this xattr with the 'ima_hash' parameter,
fixed at init, but it will also happily accept userland writes for said
xattr, and those writes may use arbitrary hash algorithms as long as the
kernel have support for it.

One important point is safeguarding users from mislabelling their
files when using userland utilities to update their files, as this
is the kind of behavior one can observe with evmctl (`evmctl ima_hash`
defaults to sha1). Another group that may be interested is those
that have deployed IMA years ago, possibly using algorithms that
was then deemed sufficiently collision-resistant, but that proved
to be weak with the passage of time (note that this could also
happen in the future with algorithms considered safe today).
This patch provides a migration path of sorts for these users.

This patch series gives users the ability to restrict the algorithms
accepted by their system, both when writing/updating xattrs, and
when appraising files, while retaining a permissive behavior by default
to preserve backward compatibility.

To provide these features, alter the behavior of setxattr to
only accept hashes built in the kernel, instead of any hash listed
in the kernel (complete list crypto/hash_info.c). In addition, the
user can define in his IMA policy the list of digest algorithms
allowed for writing to the security.ima xattr. In that case,
only algorithms present in that list are accepted for writing.

In addition, users may opt-in to whitelisting the hash
algorithms accepted when appraising thanks to the new
"appraise_hash" IMA policy option.
By default IMA will keep accepting any hash algorithm, but specifying
that option will make appraisal of files hashed with another algorithm
fail.


Even when using this option to restrict accepted hashes, a migration
to a new algorithm is still possible. Suppose your policy states you
must migrate from 'old_algo' (e.g. sha1) to 'new_algo' (e.g. one of
sha256/384/512). You can upgrade without relaxing the hash requirements:
alter your policy rules from 'appraise_hash=3Dold_algo' to
'appraise_hash=3Dold_algo,new_algo', load a new SETXATTR_CHECK policy
rule that accept writes using 'new_algo', reboot, relabel
all your files with 'new_algo', alter your policy rules from
'appraise_hash=3Dold_algo,new_algo' to 'appraise_hash=3Dnew_algo',
and you're done.
While this represent a significant amount of work, it is important to
showcase that this patchset is flexible enough to let users upgrade
if needed.


This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 branch: master
 commit ff1176468d368232b684f75e82563369208bc371 ("Linux 5.14-rc3")

Changelog since v4:
- Deleting the ability to remove SETXATTR_CHECK rules, as it added
  a lot of concurrency troubles while creating a special case for
  SETXATTR_CHECK rules only, which is rarely a good idea (suggested by Mimi=
 Zohar)
- Change from #ifdef CONFIG_... to IS_ENABLED (suggested by Mimi Zohar)
- Various fixes (code style, english grammar errors, double initilization t=
o
  zero) reported by Mimi Zohar
- Fixed a logic inversion error introduced in v4 where checks where
  performed when no SETXATTR_CHECK rule was enabled.
- Do not log partial audit messages under memory pressure (suggested by Mim=
i Zohar)

Changelog since v3:
- fixed an issue where the first write to the policy would ignore the
  SETXATTR_CHECK attribute
- fixed potential concurrency issues (I would greatly like external
  opinions on this, because I clearly don't know much about RCU. Beside
  maybe it's better to completely ignore the duplicates SETXATTR_CHECK
  issue and not update the IMA policy in any case)
- remove the CONFIG_CRYPTO_MD5 requirement for IMA (suggested by Mimi Zohar=
)
- updated commit messages to follow more closely the kernel style guide
  (suggested by Mimi Zohar)
- moved the hash verification code on appraisal a bit later, to prevent
  issues when using the code with IMA in a disable/auditing mode
  (suggested by Mimi Zohar)
- limit the 'appraise_hash' parameter to the 'appraise' action
  (suggested by Mimi Zohar)

Changelog since v2:
- remove the SecureBoot-specific behavior (suggested by Mimi Zohar)
- users can now tweak through policy both the algorithms for
  appraising files (a feature already present in v2) and for writing
  with the new SETXATTR_CHECK value for the 'func' ima policy flag
- updating 'forbidden-hash-algorithm' to 'denied-hash-algorithm' and
  'unsupported-hash-algorithm' to disambiguate cases when the user
  asked for an algorithm not present in the kernel and when the system
  vendor explicitly opted in to a restricted list of accepted
  algorithms (suggested by Mimi Zohar)
- change the order of the patches to be bisect-safe while retaining
  the guarantee that a policy cannot be accepted but not enforced
  (suggested by Mimi Zohar)

Changelog since v1:
- Remove the two boot parameters (suggested by Mimi Zohar)
- filter out hash algorithms not compiled in the kernel
  on xattr writes (suggested by Mimi Zohar)
- add a special case when secure boot is enabled: only the
  ima_hash algorithm is accepted on userland writes
- add a policy option to opt-in to restricting digest algorithms
  at a per-rule granularity (suggested by Mimi Zohar)

Simon Thoby (5):
  IMA: remove the dependency on CRYPTO_MD5
  IMA: block writes of the security.ima xattr with unsupported
    algorithms
  IMA: add support to restrict the hash algorithms used for file
    appraisal
  IMA: add a policy option to restrict xattr hash algorithms on
    appraisal
  IMA: introduce a new policy option func=3DSETXATTR_CHECK

 Documentation/ABI/testing/ima_policy  |  15 ++-
 security/integrity/ima/Kconfig        |   1 -
 security/integrity/ima/ima.h          |  10 +-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |  74 ++++++++++++-
 security/integrity/ima/ima_main.c     |  19 +++-
 security/integrity/ima/ima_policy.c   | 149 ++++++++++++++++++++++++--
 7 files changed, 254 insertions(+), 20 deletions(-)

--=20
2.31.1
