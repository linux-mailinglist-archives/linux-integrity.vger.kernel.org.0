Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D093CF6C6
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhGTIoi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 04:44:38 -0400
Received: from mail-eopbgr150093.outbound.protection.outlook.com ([40.107.15.93]:57312
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232017AbhGTIoh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 04:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0xtJDyXcuc7t8GgjOaF5dk4QoobyNgiPeeUT4SEhK4sshtLCEpbynTTKZSWdEOkL743TTGI9Hee4S3TQCAHy09FdcKJ+QMfBQnRCaSC7nsCBOW4MahWhVYqbvmHtlBRebKYWzGjiBelFKn6x+tSsqDf3AcyUp3dPkkCKEfiL1eHNxCT8fMmD8vOjnfGSdbx7kNc7/AQBGx3hgIlsRXxF9ZiQ4XAV9634QaDcbAke9rMMieUNHYLPKruM7O6VjpnMl24K6RpC81ElZEjiLHVpmPs6AF+4hP6aP5M77Po+1aDCk4JfciIZK5VtWGFiHPhnh5P8s4CVporb/UHZeRt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWHd25uY8MqD8m5WFizaLraSH2daPfc9/Ay9GvjbkGw=;
 b=D+4TDJvMM9gCFwm14N7WxYbWMdmOuDCBHQerGuqabmNaCsFNblVe406P0ybefR6pDd/NZ+uE+yGHpXY1fR6YmpeZnzCo7Cq91i5Dy9u50/bs4qGCVnHt/XUQnC5epp5XZqIqOYAAczHuV0fPw+4W8hWALi1UCdQxkieT66ukrPyBfIQb/CCQDhgfmiud6igUUxhR3im2chlvNlVN7UoO0LZRNEDwWvq1O2PVpWew2kE/cXZLw+lxzXp+Uwa4AbbWqt45rSOQm4LZ5yS6n+rmLoAm3kPNm8ZqUspLK97RXj7v15sf2aF+ut3jdbEKNFIU3onWHALrAaxXR+sd5X/Svg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWHd25uY8MqD8m5WFizaLraSH2daPfc9/Ay9GvjbkGw=;
 b=pYrUxDpgyPjtT5nwFsvcJUrW/JnD57SbJ55zFMaDOkUHXNjmvtNNnnmvdIN5GKvQG2KdeXuuy73Br/Kr1cdrMHzBtO+p7KRyUJKjjzD2ks1ZCk4E++/2l3htRlMj/Y62ylyiJt4F05X4Co2oy0zsbEys+qUKZMVtIFItYflCqmQ=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4193.eurprd09.prod.outlook.com
 (2603:10a6:208:194::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 09:25:14 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4331.034; Tue, 20 Jul
 2021 09:25:14 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v2 0/3] IMA: restrict the accepted digest algorithms
Thread-Topic: [PATCH v2 0/3] IMA: restrict the accepted digest algorithms
Thread-Index: AQHXfUklgzXbxfssQUiTBueqTjZnfg==
Date:   Tue, 20 Jul 2021 09:25:14 +0000
Message-ID: <20210720092404.120172-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea6046c2-f48f-40b1-2f32-08d94b6047e6
x-ms-traffictypediagnostic: AM0PR09MB4193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB41936EFD4A32B8541B12B92C94E29@AM0PR09MB4193.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8MpIvUYflf4dBH/WAzSVmwcV14Yq7pbGHiIrMW7caVCi/o4EoTHjuSzaWl8u5Z3SY9ugeTEGUq99ze+6lymdBAla4OTMmyYKMQhRSsE+VaA9LtBwR8NPwff/ffTEmZsaAlf1313CMf2nb6lqgWhLy/SGNaWwsfgso2Fl9/aK2Hu6Jbvkzm7RCqyIjOGDmMlKiSMVzdiKj0xX+KF4ZLe4xXD5niNb0Tjy/SS5GuQ5ikeFBj85/WrGYscvzmeKukWPJr/MjplieeVNeEkXYnjM+ayiNKWlCiWYAflTa0mdHfDYdpouY5bfdm+ZbHZYDkSn0IMx6hElnvGZfJFJC1i/6mcZA3bH6gxpbXgsZ20XY06dGuwjC5fXWcMcW75Gcwxe0tjhVh3VLIy9660GQCfjTHUDnLGzb1J+LKdGQLqHaHICGv0M2L/L3+uziigqZanGE4D8p7L2wt5ZkQqleWb7o9RZZ+7CgK8ukKYwcZ7n0X/6lFgGvitHHfYn8+2sCN2fGQgwvjOAdfe86dXslNoSLXjYzY6Gp9Ic+t7CpStdAo2wMkm+5WALnCk2QaHItRzN3r9B0kXwpwH+F93eRQNRqv/W8Bc6R9yxDBEtR2S19TedGWQ21kLF5MZUz3pbZG7CAGBDLIqCh8+ylMstjKlMKN5DjxNLHJiqstg+uVVc0O3ExMOns0uCZQyaUE/YzVMq+vfkhhjrMaWRNK0ALqI0Oic1ZSGA8zkyemxKBbMTslK0eSB0OvDNerX/YHCyZSb5Ex55g6DkC06DszJN9g8cb7qDARTMhn0Uc7x0/IWzELI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(966005)(26005)(4326008)(71200400001)(6636002)(316002)(110136005)(6506007)(2616005)(1076003)(122000001)(107886003)(6486002)(2906002)(478600001)(38100700002)(86362001)(8676002)(186003)(36756003)(5660300002)(66946007)(91956017)(76116006)(66476007)(64756008)(66446008)(66556008)(83380400001)(6512007)(8936002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WkBnkWrHWLmIt38c2f6cL9HJU0In9rdDOjRV7+/s72VW6/YaFystgkXrCM?=
 =?iso-8859-1?Q?eSxrJ8ITk10YrAfrnPMie2j7fh2w5dVeabLklK1q/Pj9NGwyd4SpPeG8EH?=
 =?iso-8859-1?Q?cenKe6GfBQNUW5JfOwp72T3ISjhPL3+hwX830SxCJ7QX80A79SHW2quq1Y?=
 =?iso-8859-1?Q?aNU6ITy5qLRNDvW908sxCQaWRAhMZR3XFWGVz/AQ3eX8rk4sQi4bhKxMb+?=
 =?iso-8859-1?Q?e0nm28RELwtZVu2/9AwqlBUpDjqrOZmfweugFsFXLIz+ScjTh3+IVBH4YJ?=
 =?iso-8859-1?Q?hocwy9FIEtozQAElsv/tC30NKuxspxoq6zK8MfqOwZlumjZPpC27zjAzxF?=
 =?iso-8859-1?Q?5JjGCQpVzwHmmQoWZpLkyhmOLXFP0AvSkUay9m37/IdMZONW5n83jtS3tv?=
 =?iso-8859-1?Q?6CQrNQLZApN6Pwvc2GxTijgeZ2iGQ7mzBy5TsU5W6NXN4dlm+xGJOQENFW?=
 =?iso-8859-1?Q?+3xERPZHouwkndtfUn4km7A2Xwr9jjbk6iqFZLQO8SdgejLZPWA9s1oS6/?=
 =?iso-8859-1?Q?IuKoVLa9mlOrSrTYwGq9jhi19sdTKQsIvBZJ1qtHN/uqS2+gNT77SxE2aV?=
 =?iso-8859-1?Q?/p6LpKmGNZkt47CtOndWaifsSqtQtde/bQbyjRP5YwZM5+Zn3lEjzCuSS3?=
 =?iso-8859-1?Q?uy6udlbDinFlqN+Y9mAdWhEGpJ1PPV4ZYmCmoBl1/bFKSkn/t8eoWENn7n?=
 =?iso-8859-1?Q?A3xckMY0Lfld7uzt0kbebtgtFoLizNEX6MBmqp/o/FJ+LrqgRlYjK2jpk/?=
 =?iso-8859-1?Q?u88rMIefEFx86wCboZK1ANRTm4rGCNEPbsuDlmS9kJs/r0Yi5x6CYy+6qQ?=
 =?iso-8859-1?Q?yDsB+kpZXCMQJmRnvqy3P03mXBNUtJL8aZCbV76QZtVVSRvJDksYrOJtoo?=
 =?iso-8859-1?Q?1QIbUSrejU15ef0AdL1pbff+3b2KTGJbjyoGHcATb+snJM1Mio16GvOs3o?=
 =?iso-8859-1?Q?PvyxuEmuswTtk2KT7ObA4IOWvoOCqcTky8dUIB0AAziDi1PiuZ4BJtbxL8?=
 =?iso-8859-1?Q?yuXggorpC9NprPGyZG66ZzOvO5l9F9I9b6nFEk/DobNl2NuxIFZLPrpfB1?=
 =?iso-8859-1?Q?AF/HMbQdx0GnjExYrktxzmBjnoUu8wfCapD0e+EEJJnh4g9igwO4JZpcJh?=
 =?iso-8859-1?Q?HXdELleyOTaBr0c2/UQt1IUdYKTD1FeMfNiKyjiPNP6MPwm4UC6nQiEF3q?=
 =?iso-8859-1?Q?brLUNh0mdVTLH/b1SoT2s9j1gVpxA2y9/WBhFeQOFpjcFgLErdmV1VRDwI?=
 =?iso-8859-1?Q?gBvDEgqMdPx/Ro1ys6UN2f+KiSuiTO4Vg2hQVQIercS4AEpNHX094R9klq?=
 =?iso-8859-1?Q?gpvYOmFMozds2LQm1iVlQJ0tH+/Zrwspj2mA9EYzZHhQ5dSZP6GasVRIO6?=
 =?iso-8859-1?Q?P+3C0JHAUe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6046c2-f48f-40b1-2f32-08d94b6047e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 09:25:14.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPE1c3jFx/QpZi6mx4pxayzINkPLgJnXDvLuDFALao7Lg6XDwSDNr+qQOqBZ933JX4wKXwgxe7CLEkvGXptmow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4193
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA protects files by storing a hash (or a signature thereof) of their
content in the security.ima xattr. While the security.ima xattr itself
is protected by EVM with either a HMAC or a digital signature, no
mechanism is currently in place to ensure that the security.ima xattr
was generated with a strong digest algorithm, as was outlined in
https://lore.kernel.org/linux-integrity/10dde047d76b447f32ca91356599be679b8=
a76e5.camel@linux.ibm.com/t/#m0f8127c6982ef94aa42f5cc13ea83b9f9000917e

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
in the kernel (complete list crypto/hash_info.c). In addition, if
secure boot is enabled, assume the system settings must be enforced
(as IMA already does for the ima_appraise boot parameter) and only
accept writes that uses the same digest the kernel uses (the
'ima_hash' kernel parameter).
In addition, users may opt-in to whitelisting the accepted hash
algorithms with the new "appraise_hash" IMA policy option.
By default IMA will keep accepting any hash algorithm, but specifying
that option will make appraisal of files hash with another algorithm
fail.


Even when using this option to restrict accepted hashes, migrations
to a new algorithm are still possible. Suppose your policy states you
must migrate from 'old_algo' (e.g. sha1) to 'new_algo' (e.g. one of
sha256/384/512). You can upgrade without relaxing the hash requirements:
alter your policy rules from 'appraise_hash=3Dold_algo' to
'appraise_hash=3Dold_algo,new_algo', update the "ima_hash" parameter to
'new_algo', reboot, relabel all your files with 'new_algo', alter your
policy_rule from 'appraise_hash=3Dold_algo,new_algo' to
'appraise_hash=3Dnew_algo', reboot again and you're done.
Agreed, it's quite a lot of churn - I don't know if this can be reduced -
but this is technically doable.


Note that the secure boot restriction is not backward compatible, so
maybe this cannot be merged as-is. Yet this only applies to new
hash/signatures performed from userspace, and does not impact the
appraisal of existing files, so this will probably not break systems on
upgrade either.

This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 branch: master
 commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c ("Linux 5.14-rc2")

Changelog since v1:
- Remove the two boot parameters
- filter out hash algorithms nto compiled in the kernel
  on xattr writes
- add a special case when secure boot is enabled: only the
  ima_hash algorithm is accepted on userland writes
- add a policy option to opt-in to restricting digest algorithms
  at a per-rule granularity


Simon Thoby (3):
  IMA: block writes of the security.ima xattr with weak hash algorithms
  IMA: add policy support for restricting the accepted hash algorithms
  IMA: honor the appraise_hash policy option

 Documentation/ABI/testing/ima_policy  |  6 +-
 security/integrity/ima/ima.h          |  6 +-
 security/integrity/ima/ima_api.c      |  6 +-
 security/integrity/ima/ima_appraise.c | 59 +++++++++++++++++-
 security/integrity/ima/ima_main.c     | 22 ++++++-
 security/integrity/ima/ima_policy.c   | 90 +++++++++++++++++++++++++--
 6 files changed, 173 insertions(+), 16 deletions(-)

--=20
2.31.1
