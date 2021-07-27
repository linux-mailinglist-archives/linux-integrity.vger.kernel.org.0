Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BE3D7AFF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhG0Qdn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:43 -0400
Received: from mail-eopbgr150132.outbound.protection.outlook.com ([40.107.15.132]:37894
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229580AbhG0Qdm (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7XlMT0YzoNfC5ls6i37PAPP3ywRj5aD08Iycao6xeaGG/dpWoX76M+uk1CDahUsB0xkSZm7N/MhSKUXVWRnh8+KLlbQdW4ztz5OOjSrOWLLyMXpZpwwog+aFIRXMxyTiAEpSfp5eQiWvQ7YX/74UkE4tDU8H7BZCJDCf6xQFVF6vnpOu9DJADMSHMt1IuehAeNx7vSW1/zck56GzxpNnxRFsVlUe47YPDfQqqAz0XM3wCX3xtTX2LXXA4xjJJzswgE1EPS8HSP92zhv+J2qinE265Yrtx9kr4EUVx7+pXn6lrhYLTTWKw52nFWweS/YE6ZbijgfuY/cJIT9XDp7TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn0BiVISq43+MS04ScnaVdU/MGL1sJm9RvjfgMWU0ZE=;
 b=fmZUy6ouda44VJRJwWfC/B5KxtCUJtl8vm+VLvKypU1WwxpNZlumnhlOVwKdLpdAJAE/u5EEEOG4Lc8LS7hTbmJjYskch0V6wF8hoQxObR7vv6MG1YbA9UjhxWCRCjFVnHKIF8JEN1jfqzRxaDxeGXovZIienNAt7BTvvdj6VaTYEloyFQZi9angB90PJOmXnnpsSoFy2tJIf2uQ5BXsPzVJGlnk6v/XF322eLCD+G34JQ1FJxfC5kmqUyadMco37Yd1ylkTJbctyZ293XNgCKTan1/ktP70uHn1Gb/GWWmalGGIPtfwQhEJCPrvYXpR7d37As3MTCsaJ6XJ27WKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zn0BiVISq43+MS04ScnaVdU/MGL1sJm9RvjfgMWU0ZE=;
 b=p38r6kO5X5VXh78tWrG5ZCsgzdkI6IIPuL1il7X71Ich+RnOJ6OWTeU0P8QvsKstS86JcvjfER98OCgVuM9asra8cbsKOHtsrprfYu7tstxpBc+vyCzAUnlQo8kD1ZkJvvq43BSEqrC1Hb32DlTFZERb5OrTD5jIblUF2z+GBc8=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4243.eurprd09.prod.outlook.com
 (2603:10a6:208:182::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:33:39 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:33:33 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v4 0/5] IMA: restrict the accepted digest algorithms for
Thread-Topic: [PATCH v4 0/5] IMA: restrict the accepted digest algorithms for
Thread-Index: AQHXgwUjIzkwnmRK4kKnEl46pUVNCw==
Date:   Tue, 27 Jul 2021 16:33:33 +0000
Message-ID: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b77c7316-22f5-4d7e-6a1c-08d9511c4675
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4243740CE904B8AAD85889E794E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZlIkpMVlHIFR6s0VKI8OWzROh2fEKbA1YM4SLeNRbzztM17tqIeiw+f8hYRJk/xgW+8nrqSg+oJtahKxQYCT2CQWtrnq51+Ho8lVA2JREP2Hx4FU77qvqc4t314CDKdLMNrUFlTf8jMkP5exbvNbZ7r1tw5EJqejh2dTCRtmR/6yFhLe9ywLy/4X/ZWyMW76LfPvyxoTTSU+oa2N2GgK3mz9VeC7ogTcvRUnTL86+QyAEzk+4QEXITb9J6A3coC/VZTFwxkBDcNT0ZyxIW5WLw0AlxfqlhwaZ15bpYx3sdQrfJc8ZukmQTaDIGn7D/qvKvcLn2faxnlYjMnC9rlUor3UmlVmTYqpIRaY0W6GaUq0OKsxltPwsEcaU2U+9LqMqZMkWfbp3ZO58Yvogg4qPiW0gUmGU8njydgxgeXZW1dQwaXoImjHfTX8ALx6viKAFim12K28UMVdDq09OTA0YQIOOAV8r5a7YKOjEUrLNOgxDwtg99mgvxkIO7lbE5bjopWGzSpIrWpYj3HhMx49EhO/CKR+bS336iLRgRlcsiXF24OI2cpo7UXpZEw31xkTxCQwEFwEP5gxlk9AESBUqUnYlFXjE5G8ZvdIZIiwl2WSOVLMEmpvM9yt78pZOJxro5PM7Swu+waAivrPaf6gyf0aiBJ1nSywa3tE4Ehyw5uUvGWy6k7vvdTd1/tXV260fqllHfkxc9OBuh7GRpg3HrroXbVBg5Yk/cmx6QyKgU6mJEfm+n6gGULmVVmNScP8OUJThmoEcCb1wvE9pMoNt1U9n2AiEwzRDB2XXl6WPpo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(966005)(66446008)(122000001)(66946007)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bojl1cYLRDK1okfSP9Fls7KuE33YUNGekb3w7JLDYKeS1CcbaTxSlnjYoa?=
 =?iso-8859-1?Q?LyuKNXO+Gg61wRHw5CLeQEB2xZLhjMQYbjailI/LuqRzP6QPdX5qYmu1cr?=
 =?iso-8859-1?Q?yYTW9ReHyaqJpN9+AuwLvgpaX1wvxBepsInOAg3FMvXQn35hKxXQG83LJ8?=
 =?iso-8859-1?Q?PUDZ42rJDPShwdxTT4oqFtCn1lDzRFefSZK1WnypRXA9NxSpsnnDMSdOUn?=
 =?iso-8859-1?Q?R9V3ESyDuhvfmZj9SOjzSA6uhHdd9jTPCOQxcloz3bPjMvQ1751FyqYf5/?=
 =?iso-8859-1?Q?6HGfuzFsEy7yrI7rOuvLny6pkhJVXX9mi5dgd/Cctu+MyER7zMYT7nUZP/?=
 =?iso-8859-1?Q?VLgZk+nnp8yXCqOtU9qtz1xv8Y2LRnif5TAKc8NjfYYrnX3B8S6N/zrQBn?=
 =?iso-8859-1?Q?0v6YhdwWaajz22YPzx6362VV9XO10X8uarChZMVc66pCPaAZWjzxm3GgVW?=
 =?iso-8859-1?Q?rmU4+MPbmmfgnmlqdb1QaD63wD4186dFir4TUKwYNvOPUtX6U7BpAS3Cr7?=
 =?iso-8859-1?Q?ZgzwKaQOzD5hQM47BKIlactc/OHhjOAWbU0JuX6gt3sojZRtpdix46xvOS?=
 =?iso-8859-1?Q?c5y+9VHBUbmWyneExES7v+7uf12PlJ/Ygut9e0p7p9KJyXT7+LKplYB0ea?=
 =?iso-8859-1?Q?nL/aoi8HKjy1izrg8o+MFdsqpHUPZX8e5QXWDZVkmrrcveUmskyHZi6JB2?=
 =?iso-8859-1?Q?y46sykg7NGalFMvkXPg6uoLx345m7zRk+aQenY9DSEex4v7Xq1JlSpSwIt?=
 =?iso-8859-1?Q?a/Fmxh3Y3cGNQzGaVlsefjXiGkYCErpuhtngEEInKK6OsItF6vTi4erg3c?=
 =?iso-8859-1?Q?4tfUs3L3dyIpcWD/b9Uq1qc3jcPvfvl4xv/PXwcDRQY+C3xBdtKiz5Eu3g?=
 =?iso-8859-1?Q?KNEZ1rhDlQzsOUcxkn2D2Iz4E6w/K83uJTz48eF28XLBQRkZ6z+cVgt+7j?=
 =?iso-8859-1?Q?tNP7bpbbMOTFzhHWeQVTRxh34G9/JwadWFknDzAVtg5HqSKVffYqSbrB+z?=
 =?iso-8859-1?Q?vw+V0JD1YGlRuBJpaxtk6vALpsFho3nCxp/dy0wAGNphdcvGl5K2D6aWcI?=
 =?iso-8859-1?Q?MnQPJcVphkTIwGnt4inPgzPKIlr224EAfnNML/ws+N9qLNsvXG4jSkGp8W?=
 =?iso-8859-1?Q?owf6qjGYhpa9sqqlKvJ3MyxbKtHN9m0jNdqjfr+zvQX7xODzieY0GlxOGH?=
 =?iso-8859-1?Q?allXoy9fUzKqwYXdpzv7MRZbyKuW23Mh46ytIM//h7jwntEL611GN3B+TE?=
 =?iso-8859-1?Q?tOou2uest0FubPYxhOk7f8ZGNSAGw+lmtVWuCAEhZ+xdgejA75uScSh8QZ?=
 =?iso-8859-1?Q?EBgwi/nHCnIWA7A8CV6xz+UJG2r5unFV1X5okrKikChZMwMqUmVMAPymIg?=
 =?iso-8859-1?Q?AF1yEEJsub?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b77c7316-22f5-4d7e-6a1c-08d9511c4675
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:33.1980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cn1edfm0jWSYBrmPSDW+QSZt3HdR2WPINt5POgKkNJ34h4b33kWgV+iBbv8MrZ0f240GZYXnPzJv8Pv4LkPnhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
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

Simon Thoby (4):
  IMA: block writes of the security.ima xattr with unsupported
    algorithms
  IMA: add support to restrict the hash algorithms used for file
    appraisal
  IMA: add a policy option to restrict xattr hash algorithms on
    appraisal
  IMA: introduce a new policy option func=3DSETXATTR_CHECK

Simon Thoby (4):
  IMA: block writes of the security.ima xattr with unsupported
    algorithms
  IMA: add support to restrict the hash algorithms used for file
    appraisal
  IMA: add a policy option to restrict xattr hash algorithms on
    appraisal
  IMA: introduce a new policy option func=3DSETXATTR_CHECK

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
 security/integrity/ima/ima_appraise.c |  79 +++++++++++-
 security/integrity/ima/ima_main.c     |  19 ++-
 security/integrity/ima/ima_policy.c   | 168 +++++++++++++++++++++++++-
 7 files changed, 278 insertions(+), 20 deletions(-)

--=20
2.31.1
