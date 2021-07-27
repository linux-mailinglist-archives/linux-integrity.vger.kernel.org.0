Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F663D7302
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbhG0KXb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:23:31 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:35061
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236253AbhG0KXZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1MhTsNqyJClJhztWHv8MqGCmHayfZn1jMrbuA6NkRHysfkN+levLTkVIPe2ai5GHLEN+pf9aPvLuN7ylmRpaMb/F4LiVx/mwsQHubjSx5CjNEqnC8k+ogvbhui5c0Oa923PrHS6wCZf5GUF2MqIuuNzopWOZJbwEN3jvQLfHTChKZq29r/CXeDXs5od91r0RXmrsJXgHCdeF98nL0Leq15H4pyL8hdbbnB3jeaJoK2Z6uG8FiWGa09TdoCFm4830QfKTHGPKL8HS31w7xciLi7HCI+judWyOHVLvOd2kEAr+2W1g1x4AxPaOxSYd6nujzuRfwRIuxJHM/M72NUvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wspkq2dDxz/Bfai9RCo0QlAcAYpPrNMjY1rLGMCcWrU=;
 b=LvgEkEWgAesf0D+pWNj9qK153FiCp2E0TwwDfYmQ6P8gl4qpOdEESMnYlk9015h7/NuCwZkdd+7EOvmxQgubfNxhhRWR7Fhj9VomPXKZrX2SXfC1jSiN2F/n3c4DzJHQRpVJaVd5kn0qDWA300+6FdVxA4MtT3j0zqYep6FkMZkoqLB/lCmuL5o2H0yEANOdGOY//r6IuCbjt+QNzzRFFsxw5+O1LKrVBxafHWonW5CzD4hz8eADrgunq7AI9mdq7xR22nA1QEsSE4cOiQ8wztzjupHi69GyFKXNoPfB9VJQaiU6qakweytsEiXx+Ho418hEoHKMfP7ZGUZtyXPEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wspkq2dDxz/Bfai9RCo0QlAcAYpPrNMjY1rLGMCcWrU=;
 b=xrzGpRpfWu0N4RN4YKwGNdllYqL18EkCp3xGhFSUhDUs90V/kNnwv7jSFSETiikCkADm+4WG4/meD+TvOgBAAoNg17AZJUsZ3rIys9lmBz37F0R4njmgbBQBX+TUZbuQj0MN/gUdl4wJ/dBuq2z9EnZi9V8RR+oaDWEG9ioxKNM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3364.eurprd09.prod.outlook.com
 (2603:10a6:208:16c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 10:23:23 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:23:23 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v3 0/4] IMA: restrict the accepted digest algorithms for the
 security.ima xattr
Thread-Topic: [PATCH v3 0/4] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
Thread-Index: AQHXgtFtJwkB8OJs1ku7xiuulnAV9A==
Date:   Tue, 27 Jul 2021 10:23:23 +0000
Message-ID: <20210727102307.552052-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d6e9e1-cd9e-470d-94b1-08d950e8908c
x-ms-traffictypediagnostic: AM0PR09MB3364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3364F58268D068A761A41F5994E99@AM0PR09MB3364.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2Z/skeIrbCQrJZxmllbgKPqYXIlJtH15P0yEE1K5I59y+ubeFqMdB/UxrGCSBzcgkwkbkHMUEKoCQYJoU5H+uTxilFcdVh6jV/PbxCWFw8zzOTNgJwX57AOsYpcb5jNxV5heJ2Y0zH7okaHuYA4mfx/388HE7/HtCijZU1phbVrWv4gQnSQXstjZUxAA3L/XNIbGSMGVwO7x2uGZs/+OjQBGgcMpDaO2mO8dBHdWEyZb/ZrKkUwuPzTlKTm5jh8VgR1R5EC2GEeUQBcbY2NxoCaSV/Z3y4U07wSazR5E9sPv7soEyWjncis75AY+Eb87IRfTWAlZFM6Hs1uR7vvzWZsO9ePMrqsPQtCTAM+NbesiFVbSZaTMOtrSDtIlSJOLpvaRug3aZJdexkfLK82JWtLrKvpAX6d9SKMycJmhadNsE0WpW7J1fG1Pbxjyrik22DDFZW3fqsfhQIUVZhoiayG+3c+i2NRY5TaQ+1wOmNdhOrZmonoUvpy3v5yxVS+n15YKZecbDAQr4RPGG2QZEhtMJijqIynrT4x+m09aPZ7dSIN3CvFOsXcs4YpfIqtlFgCFyprp480oJMT0RGGF54ZCtSoj6rCTy1F9+6FP/Oks0CU6BT5oc/a1WcQzkEyxvgYF9dKmCtPpsyp4Q5FuOeWKTUgo1L0zaaguwBtzvIrpLYdvjq3SojeL8wA/zYd2l05smM6V98DV2TedgN9GztY1VbrvXqJfy9TDF6btU01VqS6h39Zv+swi1A0EeRYrAbf0bGl+VaNFyatdly3QOhcPBD9O/VMt5kXpPVzk10=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6486002)(122000001)(966005)(2616005)(6512007)(6506007)(478600001)(15650500001)(8936002)(6636002)(66946007)(2906002)(316002)(91956017)(76116006)(107886003)(8676002)(186003)(66476007)(4326008)(64756008)(38100700002)(86362001)(5660300002)(110136005)(66556008)(66446008)(26005)(83380400001)(36756003)(71200400001)(1076003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oKZIpFDWe/EccAjIolBqTGBSqhBS4JH479Vd/s+FGMi+KuPJ+LbAGiUImk?=
 =?iso-8859-1?Q?giVYtMQlpJ/JocbevcEUInWCjeO8K46qhp5j6xABWFLJG5Cs2dqwgPe0LX?=
 =?iso-8859-1?Q?XPGjf3klyWkwGT04ZFLLs7baWEnhQeg4PTaocUMs90g254/BzY89xq+qPR?=
 =?iso-8859-1?Q?1XMFTkSBKLyH00JiOeM9ihFKAYpMNdxzQxOfJ81x9ISKM8KHon9AUe0YnO?=
 =?iso-8859-1?Q?4EEm08diW7JzgguCfoOyqST4/X3SJ+N/nLo4OHsxGi2ifLUcf/Ok7XG3wc?=
 =?iso-8859-1?Q?1YPFX6Le6qXGG8WzUCL1PKjI+oB7f4QMNxyeJaItq91p71aQN8eKp6M2El?=
 =?iso-8859-1?Q?FFYhtBjG+iz8NZuzKS1Gk9zfWcjtdawQ6QYKsROQEH1r5py0hSh9LgbqTz?=
 =?iso-8859-1?Q?YgTWA9FQpR9zdULsAarfuRqwxLzEykJu8QZjrYynNZASh2Scd0aGpXWjEd?=
 =?iso-8859-1?Q?bvSbIesHgUTv/sTDJ/F6/GaTlO3PImJ8pUPb7q8YuZzg1RZpJw49X3ddxO?=
 =?iso-8859-1?Q?eFTdvC5aMXaDF8b8Gd/vn88kbK6zcH3T7zkpkssiGhebt+NbzY8CoUeutY?=
 =?iso-8859-1?Q?HvWLEc6dvhAwOIW7N3LBmnJSRKZkGTb/1ZymJySkwG95rCciVwKK7O4kGQ?=
 =?iso-8859-1?Q?600J2BQU2v/XJR9LTLn3F5evtQL8TvBHYFJtEl+7Dh4JuRhQ7lexMkyYqF?=
 =?iso-8859-1?Q?iAUA6v4hITk4QyNwJHYmDStUUKYP1l+r7ddR98qa2spgwMeUK3UwfT0twi?=
 =?iso-8859-1?Q?ecSIvItNRJ1ElWLHocjCtS+WBoFnK8/cfJmv38vsuhnGP/cmQ6ChLDzLeU?=
 =?iso-8859-1?Q?f3zAB/IiZJQWeU7OBOCrY+FGQP3ysgBs9+DejVlFS3OBFSULAfAUOnyUap?=
 =?iso-8859-1?Q?g1K7aDv4P9GiNOSeYtnZ1D71aJlztDlPD2Sylo/93/0oXZm3EgFPmsybx/?=
 =?iso-8859-1?Q?it4o9/BOJGZQpgqOadm1+6JwHcimtsaE8Z2SzsWp8lz2ErbfyRa3QGBOHE?=
 =?iso-8859-1?Q?GMti4j21ekax2N4er5qeXfMREq5zNbEKaA8+B94LC/YEFPwVNH5HdKy63u?=
 =?iso-8859-1?Q?+8Ez5U31goNh5z+RTCx1LmX223YJ2K80+KEJg7yzmqFVku4vuHMgOcF/h0?=
 =?iso-8859-1?Q?vSp5yBdclJxlFp2CFdiqeQAy3vpB1Ed7i7P8+4GxiT6AHCyLPxOYYgndnG?=
 =?iso-8859-1?Q?K+DZxBAaw+SohA2PlGylev8RWiknAcFehBvykMRiV86SRehqjiRw1uLo2g?=
 =?iso-8859-1?Q?LUMH1AFDywTk9G/KKQA87QPnmqk60heXaOJQUNRC/9cjejW+qSN7fzK10B?=
 =?iso-8859-1?Q?eCuEv8ftOollL4T/tKMNb1CPoNEY/F7lrRufYpVKI4BWfp8+MOje8u6FGe?=
 =?iso-8859-1?Q?b15+WWvvCE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d6e9e1-cd9e-470d-94b1-08d950e8908c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:23:23.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CcYh1KBg/DPPoY8bV8frgDX84WvbiTPXIX2D2JLckS7V5XMeql6BEUHW1cVPrU4qVoFhNN9oc/lkno/gIl5TuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3364
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
'appraise_hash=3Dold_algo,new_algo', update the "ima_hash" parameter to
'new_algo', reboot, relabel all your files with 'new_algo', alter your
policy_rule from 'appraise_hash=3Dold_algo,new_algo' to
'appraise_hash=3Dnew_algo', reboot again and you're done.
Agreed, it's quite a lot of churn - I don't know if this can be reduced -
but this is technically doable.


This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 branch: master
 commit ff1176468d368232b684f75e82563369208bc371 ("Linux 5.14-rc3")

Changelog since v2:
- remove the SecureBoot-specific behavior
- users can now tweak through policy both the algorithms for
 appraising files (a feature already present in v2) and for writing
 with the new SETXATTR_CHECK value for the 'func' ima policy flag
- updating 'forbidden-hash-algorithm' to 'denied-hash-algorithm' and
  'unsupported-hash-algorithm' to disambiguate cases when the user
  asked for an algorithm not present in the kernel and when the system
  vendor explicitly opted in to a restricted list of accepted
  algorithms
- change the order of the patches to be bisect-safe while retaining
  the guarantee that a policy cannot be accepted but not enforced

Changelog since v1:
- Remove the two boot parameters
- filter out hash algorithms not compiled in the kernel
  on xattr writes
- add a special case when secure boot is enabled: only the
  ima_hash algorithm is accepted on userland writes
- add a policy option to opt-in to restricting digest algorithms
  at a per-rule granularity

Simon Thoby (4):
  IMA: block writes of the security.ima xattr with unsupported
    algorithms
  IMA: add support to restrict the hash algorithms used for file
    appraisal
  IMA: add a policy option to restrict xattr hash algorithms on
    appraisal
  IMA: introduce a new policy option func=3DSETXATTR_CHECK

 Documentation/ABI/testing/ima_policy  |  15 ++-
 security/integrity/ima/ima.h          |  10 +-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |  65 ++++++++++-
 security/integrity/ima/ima_main.c     |  22 +++-
 security/integrity/ima/ima_policy.c   | 153 +++++++++++++++++++++++++-
 6 files changed, 254 insertions(+), 17 deletions(-)

--=20
2.31.1
