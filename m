Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2773D8EDE
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Jul 2021 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhG1NV2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 09:21:28 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:63047
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236233AbhG1NV2 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 09:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO8G5STPBY39oCf9rmrx1Y2CYeJaZmHfM53U62d/+r6+FNYSReme2BhgZ0l8K2Xfry0T68m0pr8no9D5htacDscEIt/JqoahDgPk/jNVjsxZNeq7qA97zbX6Z4TCrgNVnSnGHoetf7YhQSnRCA6eOp7VpR+uUkiguNyr1he01wiHtJSNiJqUPEU8cAJBz10bjY2gfsCHHs+azZh+AggGZpGAII/RXRVldZVd3+8Xp8gQzaSexqwTZCMECvozRaVdYTozmweRp30PSx7AkR1MkMOazUqzoSV/bvJLEDpufU0EW1asIOLUDZc2Zcv15vdMaBhWxXABhb8c2YLOqZb6lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDhr08LdfAMxKSKZU/bYMre9XsgZHXXpJyP7gRf9Bq8=;
 b=VtBzD6xkPp4W3ARBCDb6AmlB4v2YbDfau7oCG1gt8HauLQcIQegZLULlYyk7ACP7+umDO4wqUnYp1QUSOyybfWJKawsZaLddYlSLVv4FUdvARNtI+CEC7ZpuuePCQeb4TOpG3bQiWF5YVcwMA5TVHqtC9ZHVmCBTcZGxvd56cPJf8tfnte/7WT68fJ3ILfIX6jVka4Fe7YIgZMYlMwKzAkEWz/VMOsBtLgISIn6GKkN1UB6wgRiFIciE00FgLdR99XavCQNYXlFwMNG1NfKICi618w83NmjU+V/HD2T4us3+Ehn5Vrj7wlHzdFqCj3t/Sn6u7RascATUkBj0lKOqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDhr08LdfAMxKSKZU/bYMre9XsgZHXXpJyP7gRf9Bq8=;
 b=IC4WUlaBkcZl2jdnhp7muScsL+YUNN4/luCN6+9L8vqoDIEqPLt349hKlgl+z3FsRmltCXWRuXl9uW2xfAbnnaKYem6w0KHkF30sRTzpt1QShM7AHV23w5z7eNGItcttwkWj4ujpDJnqmoeLN2PEwnyQbao5XkXBigxqZb+7MZE=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3361.eurprd09.prod.outlook.com
 (2603:10a6:208:170::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 13:21:24 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 13:21:24 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v5 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v5 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXg7N2un7kevPBzEuzZUqw6D+kDw==
Date:   Wed, 28 Jul 2021 13:21:24 +0000
Message-ID: <20210728132112.258606-3-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
In-Reply-To: <20210728132112.258606-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef2263e1-6ab0-4332-f5d7-08d951ca98fa
x-ms-traffictypediagnostic: AM0PR09MB3361:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB336126A70EB65813B836433094EA9@AM0PR09MB3361.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqTm+7CEc71j2sCLjVlFeCorYbOxshsHSEUXt3oxYiMEonDpefaP3WP5ZHa4k00OmJvx3tMmcgp+2udNxyuOr91Nx7gR/QsO1UmMytSk+nWouKg/8l0A+WzPKbYKVgrcvNOi/SlJ2mZnYe49Aq0DXenywNFXQnawEuH2U2Hej8cK+xdXh0bAd49IUF3LbU+YW7zEfMXM23tNOZMydHoLAM+JKJhtLKa6jIgalAi7rzCWcQDE3oqBxGRJn9qguDCmlvbA5TD4OKAfpouxVJ7kHDPVctMEDxuuU83uSGxBDoDzFHcvb/KQcU00E8+wK78L293uK99DnEymdIkxHDHQKrbn1WR7c3TYWZ/Ery08+9B3RZA/UG8uUIMFLGZbz3PHe/IiyWvXnSaezyaXrmpCwQzmcpaZUi41lqy+uw8RaWK1aqPT46cHKK5P437MZdjWAdcb17TVanjYApeF83oB1dPfvMs9aJdksIljnYo8+da3Ua0qMxqrHBNoYySmebDSgsmv39owDl/j7yMBh5GE0dOsVXR0XacGDwFS+/dun4DMcBR4d0zHzMUAR6Awom7WWL+34jd6oP++cdEUrU9UVy58auLUd8lJAZyLfizZRuqcVcvIYB+JjiwGKNb8JBzoIwH3v2dYSqcjwdlXtfJtVVX/wrrNF4Et+Nufc6IGSnpbr6Iu7k3feh0nCbgQnm+BQDnWekERaWcBeaWksqcmRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(136003)(346002)(376002)(8676002)(6512007)(8936002)(6486002)(110136005)(76116006)(186003)(71200400001)(66446008)(26005)(91956017)(83380400001)(6506007)(64756008)(478600001)(66946007)(66476007)(66556008)(38100700002)(316002)(122000001)(86362001)(15650500001)(1076003)(4326008)(2906002)(5660300002)(6636002)(107886003)(38070700005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gk3sGcCY0W19atkN+GKaLtkT+59nvZRhBhO9UBEbd8cSlpqQbDL0YOeY8N?=
 =?iso-8859-1?Q?FKp5cN9eW0wJoHranot/gB48gQtSsX43HOw6PDpwBpjJeTZIJNmI7F1c3S?=
 =?iso-8859-1?Q?fltEjJJSQk9gvhOmYzvPmlMbfnpTs3OTEZ1ZhEEbnHROpAVIP1L8ON+iy6?=
 =?iso-8859-1?Q?7SHVKdwdXyMtu4iDksAc5Qqy1S0SbqHSg5433Gp/qSyGQetAAe4s7ijA5N?=
 =?iso-8859-1?Q?Ru5d4GNZWHmvcLrjN0nFNWE2MK7eOuNuRX1EmtKWBiENNumUQgGNqyR8Ju?=
 =?iso-8859-1?Q?ZHfXr9yweu5jghPeq0bnu26XJ2pFrJVMM7ngYuX0c71MkT9iJxP1fPNyH1?=
 =?iso-8859-1?Q?CVKKKPDW/4iqUUUVtxp4jyIhMiaDSGtTb4mMqUu88FtaUptRty1Wzgq/mo?=
 =?iso-8859-1?Q?ZTvRQQ5JIPd3W3Or+PIc7Ky+5gH2T/2zOIwGdZqn/K+iujCPAI6ISrx9Mr?=
 =?iso-8859-1?Q?3FuVujP05U4EQSyElmwMINIyiubKJYErUUYOIBliyINpE1ZL0BjW2mLF3D?=
 =?iso-8859-1?Q?M7WEs3udS+PhIwXytPd4E6G+4gAc8aCs7bOBGq7YgM1RgfDw1uoHZcK7Bj?=
 =?iso-8859-1?Q?wAKaQc/RMv6tVRTZ3/AsyR7u4Fb1X0Q57YCLlkwMRIYc098aPLZEJYTtEB?=
 =?iso-8859-1?Q?AMHey26ZKXBzkG9nQwhdMHweWzdydN6Fdr1DwnvXGOuU5WRCe8dRgw7TTJ?=
 =?iso-8859-1?Q?ktBMHKwTzrQG4cYGNPfJWmP/iWdh0EJy2aOGuEirAiV2wb7hHQUN8q4fx5?=
 =?iso-8859-1?Q?b+VPJaUQOf/CMBBk07DTfr4WD+ApyaoNebrM6b5gdnpvsapc456UNZgDeK?=
 =?iso-8859-1?Q?1AoFnVsvYUBkGzfBQ9AAfS3yk8lgcyaLEcLTVJgaD+UAuhrtPfC2y/IDSE?=
 =?iso-8859-1?Q?WdST2qMHVA72ikrZCRD/WJbhwZ9BYl9hgjY9QcApe/s+zHVGQnP2y6XO4v?=
 =?iso-8859-1?Q?zUO8p3KEmoSJXwKwB6Ch4U1wYNqGYxx7wxml+NjHME58Du4eqPdMYY5ZhP?=
 =?iso-8859-1?Q?DyFH5WY6m7TzFacwEAt0o4mzBwqAoGZzoJ7uwl0K4V+6ypN9kAyjJsmVKB?=
 =?iso-8859-1?Q?FkHlOz3Vs8DVOTvBIJnKTddAkB5SnlhbnGqxes1N3dcpRffWgB6SrDcYFf?=
 =?iso-8859-1?Q?bc9gEzR8NzVO5MFJqHszj7jtoJ4TcTO7/8T6pVdqZjTLWlc3rRxnKHoHHa?=
 =?iso-8859-1?Q?qFsDNBOPDpHwokHfKWvzOd8LPQMH0qjjgxAt9xjxIP4XznNrQiTAdCLVmO?=
 =?iso-8859-1?Q?IaJUwqYQHjg5ewQbavwijB3CAFw44xs2tSO/scg850F/JyC+ylRD9JNSLp?=
 =?iso-8859-1?Q?unDgzKL2XmxOrpwUUrk+BXq7XDi5ZFedheOiYMXoecnqjpqeCC8z6K0S65?=
 =?iso-8859-1?Q?g8PQPiOXAa1YgQiG9A9X/KaJWT9OSEZQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2263e1-6ab0-4332-f5d7-08d951ca98fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 13:21:24.1103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wz+6hdiUTePoOf5Av9itleikD4vgEYxkn97pyBdjh3716R0JEQkp0JSWKlTW/Pa/Tb/4icX831aL5pkEX8gk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3361
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default, any write to the extended attributes security.ima will be
accepted, even if the xattr value uses a hash algorithm not compiled in
the kernel (which doesn't make sense, because the kernel wouldn't be able
to appraise that file, as it lacks support for validating the hash).

Prevent such writes: only writes using hash algorithms
available in the current kernel are now allowed. Any attempt to
perform these writes will be denied with an audit message.

Note however that CONFIG_IMA depends on CONFIG_CRYPTO_SHA1, which
somewhat hampers the security benefits of this measure (but MD4 and
MD5 can be disabled, which is already a significant improvement).

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima_appraise.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index ef9dcfce45d4..a5e0d3400bd1 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -575,6 +575,53 @@ static void ima_reset_appraise_flags(struct inode *ino=
de, int digsig)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
=20
+/**
+ * validate_hash_algo() - Block setxattr with invalid digests
+ * @dentry: object being setxattr()'ed
+ * @xattr_value: value supplied by userland for the xattr
+ * @xattr_value_len: length of xattr_value
+ *
+ * Context: called when the user tries to write the security.ima xattr.
+ * The xattr value is mapped to some hash algorithm, and this algorithm
+ * must be built in the kernel for the setxattr to be allowed.
+ *
+ * Emit an audit message when the algorithm is invalid.
+ *
+ * Return: 0 on success, else an error.
+ */
+static int validate_hash_algo(struct dentry *dentry,
+				   const void *xattr_value,
+				   size_t xattr_value_len)
+{
+	char *path =3D NULL, *pathbuf =3D NULL;
+	enum hash_algo xattr_hash_algo;
+
+	xattr_hash_algo =3D ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_=
value,
+					    xattr_value_len);
+
+	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
+		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
+		return 0;
+
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	if (pathbuf) {
+		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
+		/*
+		 * disallow xattr writes with algorithms disabled in the
+		 * kernel configuration
+		 */
+		integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
+				    path, "collect_data",
+				    "unavailable-hash-algorithm",
+				    -EACCES, 0);
+
+		kfree(pathbuf);
+	}
+
+	return -EACCES;
+}
+
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
@@ -595,6 +642,9 @@ int ima_inode_setxattr(struct dentry *dentry, const cha=
r *xattr_name,
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result =3D=3D 1)
 			result =3D 0;
+
+		result =3D validate_hash_algo(dentry, xattr_value,
+					    xattr_value_len);
 	}
 	return result;
 }
--=20
2.31.1
