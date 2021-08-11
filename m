Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3073E8F92
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhHKLlL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:11 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237329AbhHKLlK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3Sf2w1XzPhrLJEHUt8P2TpmOtcI8RD2/S+iFRxURZZNQfSD4mmW3OPVZ2qvlWje0pmfbiSydW5t6j1bJHrjLELt9lBVXNXq8tt6GNj6cCsg7hwapsSrTouMrD/ifHkbxuWwnOfg3CV7ze9VepJLiX93P+FoRorLxVPoGizQrSr23L6mGosath8TIS+9TSPa2Ko8t0bjhWlD/e/uZORZjRK4ON6Pjlfkr/4sj8MpXCtt52VsiOwjfZvV1AHwNEqXACgVlzSlEqfcXvvB6vsXYIi4ZO6WMK4ds9RCmsXLXmMgqB/9TOLDbit5+Mry5HakNbCaF+kiy6sNdnYmPPODuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXeOeMa6ezky1Xxj3cUOfl+VNyxXeLCyKoyfLL9tsD8=;
 b=A6aiV7ZYtrU0pjG67ZqvP91xxU3vS9fxwqOvDtLah2AhCnjf5sz1jt7I8VaEeKai9EzHRLqPmvSTDJyp8ZiB9zilKajd/mGBhqEOM4wPnNAJTvEE9o/jp4LZcP3UGnvvomy7a0iPmihSpDKGnrg+E1L83OwWUU/Fk1EQpfRQ8vZ3U+n6kdU6oGRsIhGBgvYw0yCs4SKQve/Qe9iXyY0Np8ECuJ/ItvTer/vd71A7yF0a4c2BC3ISSwzveezda49s3fB5aRQDx9DfdAEl7bIVcCxhNBzV5We7J72pYUuOaRBrgQ9ChfM4S8c4xCh99dUvsTfV7kVLlmBeBvraXgsd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXeOeMa6ezky1Xxj3cUOfl+VNyxXeLCyKoyfLL9tsD8=;
 b=O5873MZwt2JLMNIyYmpYCnJxp920NFhIOz7tQ/dP4E5Z/4m+pWLkocNfOwKgmpqFaZQiwrM93qHwXQNJvP6JtU2AqBrEyDdblGOwBfNWxT458eWdFTJSPgv5PKBchoJMVc0MjjR971bQJcF9kuS6xijCS/ddCq0+sowCGr0n+SA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:45 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:45 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v7 0/5] IMA: restrict the accepted digest algorithms for the
 security.ima xattr
Thread-Topic: [PATCH v7 0/5] IMA: restrict the accepted digest algorithms for
 the security.ima xattr
Thread-Index: AQHXjqW4D+fACrKyOECTWVBDRBn2kg==
Date:   Wed, 11 Aug 2021 11:40:44 +0000
Message-ID: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f44b5d84-5d51-428e-4ede-08d95cbcdb39
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB510504B495BF8F99379F2D0B94F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zxgk4zElX7MQTlGTrraSrKHacxXgCXJIa+NULNyVcqXbOctUaG9u9XWc+lru+hGzHHcnHOul5monAyNgXEihKksT8tK3mtsXzPeKHOgh8pHoo8WcpSa2tkFePhj8Wsw1XFhvg+izNDbDYU1x8d8sINYc06RcnmlCNKQY24NqcC8nzFKNRr/xlok2+yq031A0RvbuBX2D+Nh3qSCN9pDwOaqVH98Oz4Mf5QajyhlFOCXJbyk8zDc9zJhl94M88mVHiAxDar9aE1aPtcnATjVMH6aHdIGCjbCTMAVhO9sFYkzHY79hvbjC0CNJH5rWL2utfvEEbem1hP3f7SR75VaX5C1n3PYebSvh4YQnTiaabVPZDiI07I3bib0hGMj2D0lbPRkxb/OtLvkupq28Nyyu87Wr0otemL25zrR2DNH929wHYbfhjTdnb+TtKxUTpkeXSwhOMevJrun6nyJXDgyxa7mHGnli/CWxvD9wlmQ/zlLfTp8IIJ+LuOV6INtKYbTdAYkO2IDaRe92kE6lnUQD4DY7X8QZ10YdEAVxqgrz2P/QwiFBQRvUIft0qDxDX7EC8b/qMZDpxFjst+Ml6/CyMhFXGbfCgLw1uaKrLY7wXZzVANODSs27VjI5V+t+0PxUrnEBaphLwicZRXH1tugw194EzgCnLmOcdtH4m+Z+7/UkFoxIX8M5i1zUYTn5pHvb9TGOPYWXLRik4Y+ub/vJkQ7TZAqQ5o/iH1Pyfq622LNJb6vKJOGC8NEFmH4oGGUjovsiHRw5k2BAcQAtEKX42CEpImOKtVWfuuCc28HdMTQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(966005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(107886003)(2906002)(83380400001)(6486002)(15650500001)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c+uhUyNwIdhUDi7OPA/GnqCJtby+F+pykwNPqrIdj+OTU5iC+JywmHa67z?=
 =?iso-8859-1?Q?Z4igjwesTk6jBLxlcXnX2Z88ltDhPOtEiBNToJsnCKwwHHjECN7frVDqFc?=
 =?iso-8859-1?Q?f8uXqcSAEEOs/lWZzfx2zGXclLtzof7ymNj4i/pc2kHmZ7i8Ymf2PS/tTi?=
 =?iso-8859-1?Q?+RCWFIVK4L6IYUKDOUayKAl8bVmBeDIdbutz/fA6achz4xGwOj5vFwcLL8?=
 =?iso-8859-1?Q?u0DPaOnrIp99UPJL1XGa3na30evcASEc+21dm+ybHDhTtRckeryMYaA0iU?=
 =?iso-8859-1?Q?g9XTKpFcS0zNvAT4gWFOpEXum9SPHcH/U5/Lm05xO1BlHWv75u1mMibYh6?=
 =?iso-8859-1?Q?/jskql8APioiHfvnZupr9F2pyMmWYIxMlIJo0vmgunxfN84S8J2bmIiZAG?=
 =?iso-8859-1?Q?VghZ/vH3OY8tTCiihCz9LR5FmCBw6vxan3OuyQPgelK52WXKguXfdMT+/5?=
 =?iso-8859-1?Q?KLZ6W5tO8asm/5TtdI0vdZDT4vj45JFO4bYoY5CXUUx2K5647VZbpkMVl9?=
 =?iso-8859-1?Q?WrY2xhlO9mDLzTk6DL9lxmH0pa0iKjIoeMSo7V74oymJZxUucZUYyYVr4m?=
 =?iso-8859-1?Q?mGn+ghbUwKwFmPb8NuN9ZwskWEC+xIGh7ko0GwhBJBObkwRyCh4Ei77jE2?=
 =?iso-8859-1?Q?+ywzQGkHLguiRyh1C9aneB+iMha41SVM2oU6e3lpYJ7eRyicRQUerzwdsM?=
 =?iso-8859-1?Q?7do9r1BhwviY2gKxdGx1qGtMy/WDyOrwYuB6WOYsPBWrwWyq6a6bvP7/FB?=
 =?iso-8859-1?Q?8qznXYE9WeUwjpP6wDfsanqDj8uWjaV38gNk3o1ZjShCC8i7uxfzMQ+2/7?=
 =?iso-8859-1?Q?XpHaIDGNtTacPSXXo/xXyvlPNCxvMQLOoJm1CF4fYjCSx5I0XRoXAu23jS?=
 =?iso-8859-1?Q?hTSKZPTIRyeUsbIMWuzwpf8Vt9rNNxa/jS8LWYPYd8bEnFzY5HpoRz6cvU?=
 =?iso-8859-1?Q?wRm/jh43WNKvmGEQ76ef+O5qe8dh5T2A56qkWFn+3cU59LfdzriM8Xts7Y?=
 =?iso-8859-1?Q?C/JSX4eJdoAgq55Uplgoos94U8gFQ2V2SIyo7LIg4HWdqbunynIyqokAVB?=
 =?iso-8859-1?Q?JC62aHm1owpK9Fc16gsRsnedsJUPSBDelSlamApz/n9uJVSJ3FoyAcb88p?=
 =?iso-8859-1?Q?h2PPqmLBjsPzCOqFIN2wZHda7tvQJOPhFzKkm0Ffq9DI9LPF0hDbjCeKVf?=
 =?iso-8859-1?Q?Ki/8VlECN5pohC/2JVGNBrNbn6FBI8T6bn8asCCj4DNInqMlgAzFbui3gu?=
 =?iso-8859-1?Q?AKYbauwIcAkCkrLVpVe8v+A+2/mX4GAPSB/M0sJQD+W77i8k4F9Gv3zEqP?=
 =?iso-8859-1?Q?YbcrFQN61LQOZv4A8MKJnc+uakjGY60O7hsksbTfGWI7ihSkxB8K/iW+YD?=
 =?iso-8859-1?Q?rdQbGMDmKK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44b5d84-5d51-428e-4ede-08d95cbcdb39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:45.0339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ0CazbvS4uDBJ6TKcm2XZynjdnG1X5rApQzu99CgDYNswRFj+eeQCnZdH1pR6ZjhyrGNLy/prgPN6AN3U62vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
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
 security/integrity/ima/ima_main.c     |  20 ++-
 security/integrity/ima/ima_policy.c   | 168 +++++++++++++++++++++++---
 7 files changed, 262 insertions(+), 35 deletions(-)

--=20
2.31.1
