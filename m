Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA793ED004
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhHPILh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:37 -0400
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com ([40.107.21.117]:8288
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234704AbhHPILf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrCNSB5skx7ce+NrItQrMKe5S3+hY0ObVcykZFH+B2cAd/bVB69rAyVNCCjh+eckFuB0S/5fvCue+mpqNprjeUGxl5hBoV/4mpaJPmTUhvOEI21s8atbX/hlwjPp7tytgy4dmzcMCuAPexYrbZz6CaD5TZhE2JcWCaeTkRJ7WEYsSs5xZUhtFKWJru8RfWvsdcGPCWi3EbhZZNxClCmlLJ+PRdviy9ktns4FSRiqIJFnY9oq+z4kalPX3l2Mqimdj3JHd2Zxks1eqyG8n5D6wzwFv2bTsG6yeLy0zG8OFMUl2BRqnsi6cZj7R5+BEkOoYBdKiNZNeT50rH5g0I7rgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ccr57VJO27Fm3vEl6b2XI4XiFRaUphtLHXiMgpAE5k=;
 b=SFWguyCCb9Ki0CjteIfMNzaP+5A+4Hv/UuGQIR+GrGo4OSJMIIB3UHleMbE7MPG0JBqx/n2wzWO9H4C09NtyR2VxvQUVe53q6EIOEyjjUkKD8CeF4vLR1JdFx9NHd7t4gcxSFkKmBbVEg8oqcrA3nCm1G53CQ3Y0M2RGiUeEExBqszawiron2rAG4UsDZcJ8dFsB0MMnIIlwHOpIGHIN9eWvXsxPoGS9dMZbYQTrO7hj/kpeLqo8BTnOs9pJXI1P4KJm9o8G5Tn6yeX+o4wVz3wNTCNHL/itBaVKQD+mtareHutONWCw/qufqdveYFuBbmHZR7e6QZnNAptG1sfUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ccr57VJO27Fm3vEl6b2XI4XiFRaUphtLHXiMgpAE5k=;
 b=KPzM4v3VMOW/7peo2BAchQlfX6KqQp5ouQ/48DqZ3wV3ixEFWNd8A6r08Yii2xjIvmEMEVoAWc4qPAyk2qaCxIOEoku1dDwbkSmTh+dK9gXc+Fff7+PXhd3LYKsWti533DsJNhTsedUW8TlJ0kEsNEXqVr33cC0LI9H649UYb40=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:10:59 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:10:59 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v8 0/6] IMA: restrict the accepted digest algorithms for the
 security.ima xattr
Thread-Topic: [PATCH v8 0/6] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
Thread-Index: AQHXknY+kNxfQjBkl0GiXhYOpTAnbQ==
Date:   Mon, 16 Aug 2021 08:10:58 +0000
Message-ID: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5403d006-af02-4574-d652-08d9608d6161
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB4516585A182EB0CE017EC2A294FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: winnLYB9i0PKHtwv3RoiuEuTbXvKXCd3+YwCRdn6I9zAJjTLInEzFK9GjYldi6Uq+KN1/BSPmZSkwGLzoK0yQrO4hnojcdYcOd7fvhvRDQxWYcuaPUvvaqfeW8LXTKgo6tLyJeBBjeb3w00lu8/U9sm2KAsZELzbeCvAVBv7n+nUnPTEyGWKlJ8VyiZ0XsCvXq21Bp8ILbmfmQPPbth5sljS1nxI572PLOXXDd8DxOXx9GCN9BtQ/6nbzwMMJElx5JNu+lW6COPkUNCUXtiarw0qkNwiQmI42LDpBQXgOeWlx+l+hADSbHXhi+EbU8RiIV9LDFFVkJL0wYl43Q3AiVDZeWvKZqgk1+CVOg8H40QcY2bzmK5iOhxmLz1R6ZK4xveqcP1QsWTmTUu9UW7UudyB8tcyvy5GxbOWEHdLcYo7m3J6P+QjXDq5+SHi9TlZWi3hJ7ExiaQaKVFPpFv+3jeKR2CZ4KXx7ChYwvwFxcbd+IcRwbalYvIec9Vd0p84EXCZIfLSPs9f17Chv+nP+4CJaDfvkgdkZpOF4kVYpDT3SxdUe2YrmLWmRaSCv6stVMhaFoKpCuLQZk/h8x0TIaPIcdE09MBHdbDvla4LVj+e3OkSXirEcwcLs6XZoUVLHFqfGF947Scd+bwWjnrNpq9zMHvbd6aZ7NvaRRONOFxyeGkVGrzvnYmmd9Qkz5tDDTQ56nsKZMrqQJPtOm9dvnnFhJOFMo77Xxdl8U1wIKEDgMt85Q9qejHjS4WdJ3wASkygB8sfMzyzVxpwa7S/OUjCJuZ2zf0qnXs0DZd3jNM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(107886003)(6636002)(2616005)(122000001)(83380400001)(15650500001)(6486002)(36756003)(38100700002)(66446008)(8936002)(30864003)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(966005)(6506007)(8676002)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V6SwB+J0Xws5QVx2HdzHm4MCruz+5KnhsIB10O3/eP+nWjGfVauhQqLzl0?=
 =?iso-8859-1?Q?n6hZNxaGoPOb0M4RK7KOHhZqEb0An60VTJSp1A7hV/hN4yA//vxhyacQt6?=
 =?iso-8859-1?Q?lDvtMxVj7pKVYKpgZ2xLN9YtEsaM/NiQtA2Ud7pgqhjSVTW11u79urSqZn?=
 =?iso-8859-1?Q?Q7FFhu1A8jqMDEuWFP/7ad+0Ps0suCJa1TgXnLi8ta7rl/RGlAoUlzh36p?=
 =?iso-8859-1?Q?MD+KV1uJeJSb/17rkwlJ2sRnYgw/mRtPl2QVr+XxbK9KaDTSHeRxcisP1h?=
 =?iso-8859-1?Q?MrGip4Jc5HZIBdGyvR9w1xQau2YJt2M4qxdZl2T7InDieMjH/6864tLDJh?=
 =?iso-8859-1?Q?Otm3NlDhQr781A/49liLrOR6jsJxjdbE9b2yNTLFodac4N7qQqiAkR94V5?=
 =?iso-8859-1?Q?nZsoPR5RLzNL8qZzfEVcIyYYbJgRUkOFaWfeBRFe5e7H3ZIAVUJGizwrdl?=
 =?iso-8859-1?Q?fP7FCT1uyMibR30u33RIHuqq9D999jfMMMMRLlJdnx7iE2ZL1W0tBHUTeT?=
 =?iso-8859-1?Q?Ff3qvj3PEdXEqrtNwt7yvPCTJHgIsEqbqY0OslB8s8p4yCLFQi9/7QuQ4x?=
 =?iso-8859-1?Q?vE34ieFsQIDRb/DYStJ17jSqgUObOjIt0iUTIg/BZs8zcCtXH8KUyq/Y64?=
 =?iso-8859-1?Q?mJXAcPp+TmKj55VzYBeP2ShjUkwB5aEV0wSRfnJh9xtEBc9uhHmYTWOdVa?=
 =?iso-8859-1?Q?yujEBPy5ULHn2NXEiMP59pmVKuD9jGZILcky3bZOCY1z+Ojmf5jjklcY1U?=
 =?iso-8859-1?Q?3U6aWugY6UgJaXcT4/nB0BOCi4gzZZ52va5GOb6XfXWLbBPT816zBRTn8C?=
 =?iso-8859-1?Q?m7U6C999nKwQedRZ77jLOqx+z+8IzI1RV9kkVT12hTFj1qxEKEa7YnTtxI?=
 =?iso-8859-1?Q?Pt7rvfSwEd3IdTpdt6IhJ99ZSSLEW4rVrq4R1o5QZKLnoYQiGsFeS5o/7v?=
 =?iso-8859-1?Q?NTbn+fxctTCdPYc91NZ9EYRT3S+7hFO4pjhT0bFaEBiBJBsWaTA4DiTYFE?=
 =?iso-8859-1?Q?x0M7vYroDgTYLJQ/EyZBxULx/wBmOWBx8ybjyIP96yifhemmHah4Ie80KE?=
 =?iso-8859-1?Q?ampWahUBlHhgOd2dGNUHjPLx3NXF53/o7QcAE5xQROYoKqtrjTs2Z4zUcR?=
 =?iso-8859-1?Q?UnyKuq0t64bV3faLZeOrcG8umcIKgLeqNsaMisG31NES72d4LawmWXJrPW?=
 =?iso-8859-1?Q?Z+fFNgnlH9ZfcOz3Zp9V4ghQQ0ZD43ehMNF3bdX8ANRzMtX99e12xr4Y4N?=
 =?iso-8859-1?Q?ysgAlrhn8JrX/arNF/3sDi/kMnvW9UwzHItaLmvYQj78ge6AAM9h8hVUpo?=
 =?iso-8859-1?Q?I7DmjxJjgUaL25+Q/bvVQqtvKou73H9GmYZUiOPDTaUk6cXns6xJJ/dWgG?=
 =?iso-8859-1?Q?4i5bV13HOD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5403d006-af02-4574-d652-08d9608d6161
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:10:58.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84xzisHRy1eeuhdCzDEclBJ92w1yslfpOt8dRj21Rl6eI8ppA/3mxMY1lw7F7+yAmVVlBSsLilbTotuE9q3AJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA protects files by storing a hash (or a signature thereof) of their
content in the security.ima xattr. While the security.ima xattr itself
is protected by EVM with either a HMAC or a digital signature, no
mechanism is currently in place to ensure that the security.ima xattr
was generated with a strong digest algorithm, and any hash defined
in the kernel will be accepted, even obsolete formats like MD4 and MD5.

The kernel itself will only write to this xattr with the 'ima_hash'
parameter, fixed at init, but it will also happily accept userland writes
for said xattr, and those writes may use arbitrary hash algorithms as
long as the kernel have support for it.

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
ppraising thanks to the new 'appraise_algos' IMA policy option.
By default IMA will keep accepting any hash algorithm, but specifying
that option will make appraisal of files hashed with another algorithm
fail.


Even when using this option to restrict accepted hashes, a migration
to a new algorithm is still possible. Suppose your policy states you
must migrate from 'old_algo' (e.g. sha1) to 'new_algo' (e.g. one of
sha256/384/512). You can upgrade without relaxing the hash requirements:
alter your policy rules from 'appraise_algos=3Dold_algo' to
'appraise_algos=3Dold_algo,new_algo', load a new SETXATTR_CHECK policy
rule that accept writes using 'new_algo', reboot, relabel
all your files with 'new_algo', alter your policy rules from
'appraise_algos=3Dold_algo,new_algo' to 'appraise_algos=3Dnew_algo',
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
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dset_data cause=3Duna=
vailable-hash-algorithm comm=3D"evmctl" name=3D"/usr/bin/strace" dev=3D"dm-=
0" ino=3D2632657 res=3D0 errno=3D0

With the same command and the policy rule
"appraise func=3DSETXATTR_CHECK appraise_algos=3Dsha256,sha384,sha512", we =
get:
	audit(1628066210.141:127): pid=3D1362 uid=3D0 auid=3D0 ses=3D1 subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dset_data cause=3Dden=
ied-hash-algorithm comm=3D"evmctl" name=3D"/usr/bin/strace" dev=3D"dm-0" in=
o=3D2632657 res=3D0 errno=3D0

Note that the cause is now 'denied-hash-algorithm' instead of
'unavailable-hash-algorithm'. We get that audit message for any algorithm
outside of sha256/384/512 (including algorithms not compiled in the kernel
like MD5). In a sense, 'denied-hash-algorithm' takes predecence over
'unavailable-hash-algorithm'.

When appraising files, e.g. trying to execute a file whose xattr was hashed
with sha1 while the policy rule
"appraise func=3DBPRM_CHECK fowner=3D0 appraise_algos=3Dsha256" is enabled:
	audit(1628066349.230:130): pid=3D1369 uid=3D0 auid=3D0 ses=3D1 subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dcollect_data cause=
=3Ddenied-hash-algorithm comm=3D"bash" name=3D"/usr/bin/strace" dev=3D"dm-0=
" ino=3D2632657 res=3D0 errno=3D0


This series is based on the following repo/branch:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrit=
y.git
 branch: next-integrity-testing
 commit e37be5343ae2b9419aea1442b07e5d2428b437b4 ("Merge branch 'ima-buffer=
-measurement-changes-v4' into next-integrity")


Changelog since v7:
- Add a new (tiny) patch on top to restrict the hash algorithms in
  'appraise_algos' to algorithms enabled in the kernel configuration
- Fix the Signed-off-by header because my git configuration didn't match
  how my corporate email provider was rewriting the 'FROM' header

Changelog since v6:
- removed the IS_ENABLED(CONFIG_CRYPTO_MD5) as IMA fails gracefully and
  already defaults to sha256 in that case (with a more helpful error
  message than "invalid hash algorithm for template")
- Update the commit message of patch 2/5 to fix a typo (reported by Mimi
  Zohar and Lakshmi Ramasubramanian)
- Update the kernel-doc (I decided to keep it as it is acceptable to docume=
nt
  static fucntions according to 'Documentation/doc-guide/kernel-doc.rst')
  (reported by Mimi Zohar)
- Prevent file re-validation when the hash algorithm is invalid on setxattr=
()
  (reported by Mimi Zohar)
- Update the operation in the audit log from 'collect_data' to 'set_data' w=
hen
  performing setxatttr()s. (reported by Mimi Zohar)
- Rename the user options from 'appraise_hash' to 'appraise_algos' (reporte=
d
  by Mimi Zohar)
- Reject the policy update when the 'appraise_algos' parameter cannot be pa=
rsed
  (reported by Lakshmi Ramasubramanian)
- Kept the (single) whitespace->tab change in
  'Documentation/ABI/testing/ima_policy' for consistency

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

THOBY Simon (6):
  IMA: remove the dependency on CRYPTO_MD5
  IMA: block writes of the security.ima xattr with unsupported
    algorithms
  IMA: add support to restrict the hash algorithms used for file
    appraisal
  IMA: add a policy option to restrict xattr hash algorithms on
    appraisal
  IMA: introduce a new policy option func=3DSETXATTR_CHECK
  IMA: prevent SETXATTR_CHECK policy rules with unavailable algorithms

 Documentation/ABI/testing/ima_policy  |  15 ++-
 security/integrity/ima/Kconfig        |   1 -
 security/integrity/ima/ima.h          |  14 ++-
 security/integrity/ima/ima_api.c      |   6 +-
 security/integrity/ima/ima_appraise.c |  73 ++++++++++-
 security/integrity/ima/ima_main.c     |  20 ++-
 security/integrity/ima/ima_policy.c   | 174 +++++++++++++++++++++++---
 7 files changed, 268 insertions(+), 35 deletions(-)

--=20
2.31.1
