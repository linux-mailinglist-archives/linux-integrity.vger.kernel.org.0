Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656443DFDD9
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbhHDJUc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:32 -0400
Received: from mail-eopbgr80098.outbound.protection.outlook.com ([40.107.8.98]:59630
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236951AbhHDJU3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhN7abTURGeaTtxjRdDkhwQpoWXGOyQp6oFovDeqmLrzLPKI35MpUaj9bDgsBAyTrRvQEhGsMjEkI5Om3Duj3x+GXjvDq1mZsmamAJCkcyJk9nV3OskGckZMc06E3mVu6bQol9zok115kbnLX58KRTWXNEh5myDmoBIcH6buWcNOs0QUiNeTDQ7Gl3DNIlCZqSxs5A1yRsgIsdPbu84ULi+Z8G0zh+9ho/GPnjAA+LxpIwWafV9jYcYOiTr3DlaYgbsFaTW8rnINHJTCU51xZoBQgirJN6z+CCSn9CBTCrLKwn10KfWoFrjQu8som3OMGDogJ1D8VK1+Bq18bHMUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToxJAqF8h1bsrJFqTJEfvkUmnRvxdlgB8kNNjcmxX+E=;
 b=mplJ5OSmfi4iH7oZlkYxgRvB9+iVO9dtGJSdVN0bFZaXh2zGb0Q8b0ri1uVRzir4w60xXiIuYU3YELvAR76tFYmou22jtLJD11sDZ3/VZqvVXYUkQKOzRlA6A7m99ip8mcUojGe759ejD2544mQULx20rkryUyZ219Od48a8+xrvBv3p7IFviqYMNstYk3QEPKRrwH6XF5w04tFtIGHi4qrqZ1er9foSImPJWPUMoN4vvrM/wLd7Pba6hTar8yGOjMPkPmR2IZb2GQ8zzX/WM2zdbtLjn3TVvzSD2l5NS5PqGUIJltvxhpcPGRyo0QOjmLk9G65BwDGylVIdpHlT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToxJAqF8h1bsrJFqTJEfvkUmnRvxdlgB8kNNjcmxX+E=;
 b=vR6t9NXSPhmKcng+jfrQsAk5CLaXKwtM+di49rR2nkY/QTN43a5BBQbfhasRWOkFAS1pqT6CIVMZqDKSh9zo5+nV05HL/0MGIIJBHgES31cOSFDTc9XlyejV/ichQxbK0aEq1aGcV47CdKZA6i4tT8ElvbGK+7Lv40Nc0x0cux0=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB2545.eurprd09.prod.outlook.com
 (2603:10a6:208:d8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 09:20:14 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:14 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 0/5] IMA: restrict the accepted digest algorithms for the
 security.ima xattr
Thread-Topic: [PATCH v6 0/5] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
Thread-Index: AQHXiRHuSQkcSNdsqEC9ssrYpaNapA==
Date:   Wed, 4 Aug 2021 09:20:14 +0000
Message-ID: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4d59ca8-08f8-474e-234b-08d957291172
x-ms-traffictypediagnostic: AM0PR09MB2545:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB2545E4E691E695525B0643CF94F19@AM0PR09MB2545.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ThoNZX0XYXWGA3ee7exndlcbgKFnVk1yRMI1DYM3tkszRGxCUf0pj8oCVcNN9X7JPI+Zx6Z/nwM2kDHc3IH/8z0cxlBAUdvxcQDDVyO5kz0u6icNYfQQOcBsl++9GjN83D08Y+SwXsyyzCSTyp34roXBg5DUppIIiOEJaKU4LZ4oK0SaqrDu0PT1M2gvMtEpBvBtnpbHmm30JUxpIlOUnSlswcMKwyYZ0esTh2QfDFN5y740Ezn0dLyM6FRxaW3GcKAQZq8aC/knKVwVm/oiGSgrT/89ECVoB06iaP7aOGcv0uOVVtB8f/JvozUphIjHZuzFP5cHb/oRcIpkrZipdsY7YNbhptUxcu6aBDXAmc27POfIfvr7SCW+JA+Va9LGoQhVa8QKhJx71A7GpFG6LHpNe8E1f8u7UwQzdXZgCypENIL8WtC3OKZdtwco3RxzKAT1FcF+AeJ0Mq6/y5QHTPmrjgixS3cKK1F2n5ABCsQUgFXPVyUXctRwTKQBlgyEVJRw70kpKNOL4bLwYAKX46UdsYY837GjAFm0vZBOdg9zWux8rH93wzxlLE0Xk/uO4PWuAVkey+3IEDTGsd5cWd3+3fsxYJ4lXniy7ptvl8SADZKT9fVn65UtvnKgEp3dPaO6C9UOEXURUBJ83RTixTcr/xDrA84RwpGi1ZaH3reuBn69Wm70Ff1x/xP687TkSCUxfLbr7WgmubEZ7zmcESViypMCxGMo6tHDqXhugFSpdD4d6bv4Tn7N3FLiBhuaDWarytbmJw3KMKRLyaxooVScoTrOnILZBvuBbxBNck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(366004)(478600001)(26005)(66476007)(66556008)(8936002)(64756008)(15650500001)(186003)(66446008)(83380400001)(36756003)(6512007)(66946007)(316002)(966005)(86362001)(110136005)(2616005)(38100700002)(6636002)(1076003)(38070700005)(122000001)(5660300002)(107886003)(6506007)(91956017)(6486002)(2906002)(76116006)(4326008)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8gToF9zNLStLRhqIR9jjQsBwewfE+kSfoSlyxwEDkN/ngdUhvly6s96qZn?=
 =?iso-8859-1?Q?Zlw221iFHQNFJH8mHd7HJO74QAdX5N4zCJltBb99F7+bL9Kl3PppaLhaJT?=
 =?iso-8859-1?Q?M72I8ARhBI6z29wwIaPdPN6/eXlBQnt+Ih8gAY8iFTRFtvmtgd8sZIXlHs?=
 =?iso-8859-1?Q?5mUep1Xsr3McxJbkyHVT84NSdsyK/6AVRqVxqRCTkt29YjWRM+6UysYJK/?=
 =?iso-8859-1?Q?zUjRxX8UlW4fIBe7GwWNU7wBgk2YTdD3L6h1Rq5xmVSYtcaSW7C+VtEXXO?=
 =?iso-8859-1?Q?1shSpgu+fxT4Tz2bsIYpclQvH2XDL1r4McxJODauQ2mGCD+MAxUdX2/xFz?=
 =?iso-8859-1?Q?EGgdIVHa2rv/H7Qh8PfvTzwn+DDkEUiYA/GCpXMnMwhkNaQYBP0bAtrlz8?=
 =?iso-8859-1?Q?Lezg/jM/lWRRdkob+acCVr2BEEGxM9SyNrwtbQWKdpJRxuXlueS0iTLjFc?=
 =?iso-8859-1?Q?WoPX2HQq1jLRedfxsKaLjOza8SqQl6Uo0go9+Ma5G8v0z+alRDNBNWTxO4?=
 =?iso-8859-1?Q?OyQzzb/n/UgnuD3lFB3342zs+rqkDzfBBFfmdPp2J6ZNQ1BmR40bbZJ8WK?=
 =?iso-8859-1?Q?KNw7IOJqJwXImUq6gGl8nOXW3nlX5hdJ9hC/dDyDeNBldOjKGm+Si+NeAn?=
 =?iso-8859-1?Q?59YZQ8A+m8ThFn0qs04l7t6YYgfkaTGRDnwatRtp0PJqiFhAN+UPuhInGB?=
 =?iso-8859-1?Q?TUzANrI8khmUyoHgykhguXcFtF8qqY59ygRMIzUC8WWMySRYhVQmbCS/KV?=
 =?iso-8859-1?Q?V23A64F8Fr+V+96TIobl0NTE2Uat44Z/N+Rr7J2h+9YeiMqn94Oe5TsfiU?=
 =?iso-8859-1?Q?jTLibPt6dltTO4dmdG7jhw1XKQre1uaXXRTTOcFq9ibaaNRELjmrgT6UzQ?=
 =?iso-8859-1?Q?KIPygtdPkJMjkNv44/U6q6O9R0GnT+0pRZOtUj+YFyps1BxJCl1EHdW7rn?=
 =?iso-8859-1?Q?Yg8OPC7zl3GMD/gFFCPr0v2tLHJzl1zT2nAUDFOJOXhA+YZEkrdZqPbglm?=
 =?iso-8859-1?Q?ZvtMs+vyRn6amjv9t+OO03SRRqGIHXcYOUe4BmYQNk8hSQxjFsQo9BYAOd?=
 =?iso-8859-1?Q?JTRbDCZnK5swKc+0i4lS8/7Sf2KiYTH6YrLTHMzIhOWQkd0jMP4TobG9+d?=
 =?iso-8859-1?Q?zXawme3OWurKafphp5AKu+pbA3eMY9VBefsqb6oqh9nxhJovNLpHfrJ6ke?=
 =?iso-8859-1?Q?YvvgyO55enuYbS8a0sZBLkCxb5YXUT0g+FJyt7IqBXZ2aslInFevCF/OH4?=
 =?iso-8859-1?Q?m3diNoZDTENap0fuK2V13P1Fduzd1XC3NILKh7+YoTHEjgWUiieuwWxs5m?=
 =?iso-8859-1?Q?sXtz5+TUJ9AiM1iIn1r4EoRWyEol7nVo3zGzgglgVz17C3oPiKpvLqZhHe?=
 =?iso-8859-1?Q?gTMHtFGrAe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d59ca8-08f8-474e-234b-08d957291172
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:14.6764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Vz3YVc+ikctWTvm/cAR6G3nPMZV/AebBsfcQS7TD24YAlDNAw6MoyX3ZAXhpFpdoBhjrRNnt2nAdciSSK8zwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB2545
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA protects files by storing a hash (or a signature thereof) of their
content in the security.ima xattr. While the security.ima xattr itself
is protected by EVM with either a HMAC or a digital signature, no
mechanism is currently in place to ensure that the security.ima xattr
was generated with a strong digest algorithm, and any hash defined
in the kernel will be accepted, even obsolete formats like MD4 and MD5.

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

In addition, users may opt-in to allowlist hash algorithms for
ppraising thanks to the new "appraise_hash" IMA policy option.
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


Here is also a short description of the new audit messages, but I can
send it in a followup mail if that is not the proper place:

When writing the xattr with an algorithm not built in the kernel (here the
kernel was built with CONFIG_CRYPTO_MD5 unset), e.g. with
"evmctl ima_hash -a md5 /usr/bin/strace":
	audit(1628066120.418:121): pid=3D1344 uid=3D0 auid=3D0 ses=3D1 subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dcollect_data cause=
=3Dunavailable-hash-algorithm comm=3D"evmctl" name=3D"/usr/bin/strace" dev=
=3D"dm-0" ino=3D2632657 res=3D0 errno=3D0

With the same command and the policy rule
"appraise func=3DSETXATTR_CHECK appraise_hash=3Dsha256,sha384,sha512", we g=
et:
	audit(1628066210.141:127): pid=3D1362 uid=3D0 auid=3D0 ses=3D1 subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dcollect_data cause=
=3Ddenied-hash-algorithm comm=3D"evmctl" name=3D"/usr/bin/strace" dev=3D"dm=
-0" ino=3D2632657 res=3D0 errno=3D0

Note that the cause is now 'denied-hash-algorithm' instead of
'unavailable-hash-algorithm'. We get that audit message for any algorithm
outside of sha256/384/512 (including MD5). In a sense, 'denied-hash-algorit=
hm'
take predecence over 'unavailable-hash-algorithm'.

When appraising files, e.g. trying to execute a file whose xattr was hashed
with sha1 while the policy rule
"appraise func=3DBPRM_CHECK fowner=3D0 appraise_hash=3Dsha256" is enabled:
	audit(1628066349.230:130): pid=3D1369 uid=3D0 auid=3D0 ses=3D1 subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dcollect_data cause=
=3Ddenied-hash-algorithm comm=3D"bash" name=3D"/usr/bin/strace" dev=3D"dm-0=
" ino=3D2632657 res=3D0 errno=3D0

This yields the same error message when appraising a file and updating a
xattr with an invalid algorithm. Maybe that is not a desired behavior ?


This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrit=
y.git
 branch: next-integrity-testing
 commit e37be5343ae2b9419aea1442b07e5d2428b437b4 ("Merge branch 'ima-buffer=
-measurement-changes-v4' into next-integrity")

Changelog since v5:
- Adapt a few places where lines were longer than 80 characters (suggested =
by
 Mimi Zohar)
- Rebase on top on next-integrity-testing (suggested by Mimi Zohar)
- Replace "whitelist" with "allowlist" (suggested by both Mimi Zohar and
  Lakshmi Ramasubramanian)
- Fix a broken kernel-doc (suggested by Mimi Zohar)
- Prune the feature that updated "func=3DSETXATTR_CHECK" (suggested by Mimi
  Zohar)
- Update the commit messages with suggestions from Lakshmi Ramasubramanian
- Short-circuit a bit the evaluation in ima_appraise.c/validate_hash_algo
  to return earlier in case of memory exhaustion (suggested by Lakshmi
  Ramasubramanian)
- Renamed "forbidden-hash-algorithm" in ima_main.c to reduce the number of

Changelog since v4:
- Deleting the ability to remove SETXATTR_CHECK rules, as it added
  a lot of concurrency troubles while creating a special case for
  SETXATTR_CHECK rules only, which is rarely a good idea (suggested by Mimi
  Zohar)
- Change from #ifdef CONFIG_... to IS_ENABLED (suggested by Mimi Zohar)
- Various fixes (code style, english grammar errors, double initialization
  to zero) reported by Mimi Zohar
- Fixed a logic inversion error introduced in v4 where checks where
  performed when no SETXATTR_CHECK rule was enabled.
- Do not log partial audit messages under memory pressure (suggested by
  Mimi Zohar)

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
 security/integrity/ima/ima.h          |  14 ++-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |  73 ++++++++++-
 security/integrity/ima/ima_main.c     |  23 +++-
 security/integrity/ima/ima_policy.c   | 169 +++++++++++++++++++++++---
 7 files changed, 267 insertions(+), 34 deletions(-)

--=20
2.31.1
