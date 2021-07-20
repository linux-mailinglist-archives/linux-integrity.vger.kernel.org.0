Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2F63CF6C8
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jul 2021 11:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhGTIo6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 04:44:58 -0400
Received: from mail-eopbgr150138.outbound.protection.outlook.com ([40.107.15.138]:4871
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235073AbhGTIor (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 04:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHMZeYox9wywSqki8w2EhlBB1/6yYbvz6QARvS4hIovwQAuuuUOPdqxeZDPcp2IrTxcIpdx9ngiG1stJtUcYt70w743+EY/fr3ROPLsrS2nk9rsVf+gtFZVl0jz0bGvH0Qovz3uMEihWTdDjFR+UlluuL4ekbb7jcSqyLcjHF0uJxruJjf2EwT/0t6vj8F1OTUO7mL75Y/12YW6NAYWLoobTD45y1u4qhag/gX04bkUXnAU/eXUinaxS/IsM97R7aWJpqgWd2baLFFdQm0bIarCakOiKk19o1W0kmb10Er2nTM8T4i/ovsQENz1TOO9NuhrV5JYgCRvAE2Hwa+LP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3qhi1b6nAtVKmH7Fhx5LVTxb7s7Dp/zFjW1XVQjuuU=;
 b=iyqgBQ5nuSSHUWCaT0N4tav8+sJCI3NIIdm9KfqdLd/mLasgqWRlx6EUtdlwoAFFKQWe/9j1TzmSpBF63Btv7l7linfuM2zzUkZowtCQy8fn/RIW3wHzD/RaKnLDh2J6P2wP27N2oPZBJkTD4xGjaLc7/ni0Me9rExkal9vUXEHN7mZUzov6Gkdku6zl54IrwTs05fiOgipFEhEEJBVt7S64gaPVkWu5BGdReqyIUxfrmPAc0Z5Z2bTbnPKT/3HYBt4XS3c1OZ/TIjR8QxM92hlyyPHg2a5BpPFOGveEfESa1Uq8ssVFYkvle3N8niNa5YUiu0dxxTPLAj5XvBq1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3qhi1b6nAtVKmH7Fhx5LVTxb7s7Dp/zFjW1XVQjuuU=;
 b=XKl5TM2UDucTyPvi5fAZoqiTK3AiVRZOAVaC2A+CBUFyBB2imaeLrjWQhCs88+TiwU5aQOv+wxWZ1DckwOn1LD9bn/R3IFsiOjk/6j5sL/LFj47h3eJ1CcQ8WqWWPNNwcJekuzvOzySY4t7/VU7RYc17eVbWqA0miIM0eieXK+o=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4193.eurprd09.prod.outlook.com
 (2603:10a6:208:194::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Tue, 20 Jul
 2021 09:25:24 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4331.034; Tue, 20 Jul
 2021 09:25:24 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v2 1/3] IMA: block writes of the security.ima xattr with weak
 hash algorithms
Thread-Topic: [PATCH v2 1/3] IMA: block writes of the security.ima xattr with
 weak hash algorithms
Thread-Index: AQHXfUkrctHilsbZW0OuAdQfY14dGQ==
Date:   Tue, 20 Jul 2021 09:25:24 +0000
Message-ID: <20210720092404.120172-2-simon.thoby@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
In-Reply-To: <20210720092404.120172-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08b718f3-b903-4cb6-5890-08d94b604dcd
x-ms-traffictypediagnostic: AM0PR09MB4193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4193C9A5B23246B3A9E5413394E29@AM0PR09MB4193.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9t4qxAJzNb95gLAz63dog9AGyExNbtTHsvIwDwm8AgsqwStUntZugoXsV9Y87hbjy1Ac7z/2yckxB+ju261bStexaQ+Fv5964/o83ew0+EKVWGZWJX10KFVitWDghf30xzon+w5t7fdCtGeTCBAcf7mBvF+aRsyXwYCz7GqB5iWGPxKVh3kQ+ztHlssQ8lxKXldnVN6wFr7ju8SeP3QU6TX71lbu037+echQOmzrDD/JblcsnmFuxESIQL48AeSk10NP0Ijuiz9TeU6OUFLBNegJnPO3OJJ825lmSz/+yYbPrlMqaI4LRekXBZCLRb0BVRneWSP5DFRoy+stdZWua4IniyfdpVdAwSeowI1piNdHugi7a5QBypormqoV8dgWKyYxQbEjitimeUJeUZ/yNrSqiZg9oz8o/FkhmUoGJJZoLOD58zY+n8t0xaf0aq+sMQQpq65/OqAbBfPh5P0eqDG6mVLIuCr0saS3WYgnj7s7dhrCXyyH+VNLnrOEaVLIGcbOOEOe3LI92gGvnA3reeCzVIAjqLzghf0VXFzrHLtWcXOAR9a/tL4zlps+u/qRdFu8BFGcZHdZ6nJ9hdyCoRjP/PDTiCqKAVniQoJs5F1ZlyC5qgE2r4X04ihRq9+V/D+83r5LR9SfGQQOkbvsLYbY6YKKW0qSXfUl1HTeRLSakPAo2kaD1xcgLwayhWGdpkcicnvbGoHRsoDJka95Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39840400004)(396003)(366004)(26005)(4326008)(71200400001)(6636002)(316002)(110136005)(6506007)(2616005)(1076003)(15650500001)(122000001)(107886003)(6486002)(2906002)(478600001)(38100700002)(86362001)(8676002)(186003)(36756003)(5660300002)(66946007)(91956017)(76116006)(66476007)(64756008)(66446008)(66556008)(83380400001)(6512007)(8936002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fYHrBo7FtEmSXgEj79mhnsK1I0tdkX2joXk2yqAZpJfZJYy55xLQSaeqIM?=
 =?iso-8859-1?Q?j0iWscVU/wAiU+g5zgfQOc/PltoWF1DfKVj+3GO32HNLQOCQJ9iBqrnrpV?=
 =?iso-8859-1?Q?ESvGvc838S74h30MRF+jO9COGuGqE8dR6c5kxYD6ZwVVuLUZOtAv9p4Fbd?=
 =?iso-8859-1?Q?M3NJ0eqeK7z90xm6uWjoBbBZUNmFt9kRlR94dp8rW42Q5QvJHTt/Qx7jum?=
 =?iso-8859-1?Q?L+q/xgIGXh665832F3aTHSCWHpJbQPA1XhA1apZMTuK0Jk/WkThk78Au4o?=
 =?iso-8859-1?Q?wc3q6Z4llDaH5Cw0yURsORjhk9xdbWEX71wCwxK23zOt0iIjbHSKI2zV9l?=
 =?iso-8859-1?Q?FV5dRZtbZlIz5BXoN27n4pbF8cfOLrZvIr44w2Jj8ZBhCtOLFvit6NmhAl?=
 =?iso-8859-1?Q?vHuaaMmqYh3iACb/cmz3JSefzBsXmy0WPzjh4/FRl0OUdV/RxFhdioRSj9?=
 =?iso-8859-1?Q?IMpmF42yJWzE7X9LQVUFVxzIUUHgnwKE2Xt84AdNnVIHmgHP0g/Aqrev/T?=
 =?iso-8859-1?Q?KZLHaPBFJWt7vt+EcrSmZunFgFmEFEmlNOM3tgKwbqT15foNj43+lkR1jo?=
 =?iso-8859-1?Q?X8uQ7WK8+VZsjafI05i9UJLeVocX2dnyznRC3kbIupYcyhFQV9+1gWUH0v?=
 =?iso-8859-1?Q?P/UxwwtN9R2fmWcP/MpgR/HBTAAWTdEmKW4tafkiOVLW4gGtaxkU9T7H1T?=
 =?iso-8859-1?Q?k5Aft5iiN8z5RX70U2p0sFHYrLCDjO5A3ME4HZ8VSvrvoHBmbx7nlUEbfl?=
 =?iso-8859-1?Q?ZZpSznttCHF7beRTsjeJGBrbhB3j0BrOwmlLW0/DUot8EyexheiZ93entd?=
 =?iso-8859-1?Q?dkYOXOvaVnxs5cmMqet0s/lFFQzQNK9FuDWODgCL+n2p7OOK7lPrsikcQf?=
 =?iso-8859-1?Q?GAzkh54i7vWEP1nD5o9Ug/fQvcNJ9UACb8OYhh2Lo/gKrY2UfCARslZqNP?=
 =?iso-8859-1?Q?m3S14a99udLhkazCau3sWPRbLOY2KZeYOIoabAdPKtLrSPp19j7ahZ478e?=
 =?iso-8859-1?Q?Bo5AoKchH+iWg5KPLwFcQDXlmXS8a+b6Qpoh/SFYlOeKVGAtFW8OWvVU2J?=
 =?iso-8859-1?Q?dY7ZF5pByywvgSeqIPzLusQPOnBTFnK642VHYroDRVqdbi/5CkeEpvBBLD?=
 =?iso-8859-1?Q?INz7yPeFlMAZWfL4LNvj07JMzKCfFkhbsRw0lZoeJ1r7J1pC3c66aGqTou?=
 =?iso-8859-1?Q?vnBX87UqsX2W+bM16fuKomguRcHvO/fbq7BSX57xopZfw02mmZp1iGeGtr?=
 =?iso-8859-1?Q?H7nuB9NfVuOkZlfktGUjUbBgaE4b59cPeV0rQaRRbnco9kK/C5ecak5PBE?=
 =?iso-8859-1?Q?Aj+LX03qlWTNQ23I1cVMpEph/P6sTo5z/IgNKzrJdBevnHnHj+mW5c03Oh?=
 =?iso-8859-1?Q?zrF8TsTeIB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b718f3-b903-4cb6-5890-08d94b604dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2021 09:25:24.3073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsjZNusNxLXLpEF7LIKKHpDAnStIWzFhiNpCaYR+UpIm2ocFKJ2mC4lkxCQiytn4UfV3y304i6esQJa0PxMMZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4193
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default, writes of the extended attributes security.ima will be
forbidden if the xattr value uses a hash algorithm not compiled in the
kernel. Disabling weak hashes when building the kernel will thus prevent
their use in IMA (these hashes will not only be blocked for setxattr,
but they won't be allowed for measurement/appraisal either as the kernel
will obviously not be able to measure files hashed with them). Note
however that CONFIG_IMA depends on CONFIG_CRYPTO_MD5 and
CONFIG_CRYPTO_SHA1, so this limits the security benefits of this
measure.
To bypass that limitation, if secure boot is enabled on the system,
the allowed algorithms are further restricted: only writes performed
with the algorithm specified in the ima_hash parameter (defined at
build-time with CONFIG_IMA_DEFAULT_HASH or overwritten with a boot
cmdline option) are allowed.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima_appraise.c | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index ef9dcfce45d4..e9a24acf25c6 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -575,6 +575,54 @@ static void ima_reset_appraise_flags(struct inode *ino=
de, int digsig)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
=20
+/**
+ * ima_setxattr_validate_hash_alg
+ *
+ * Called when the user tries to write the security.ima xattr.
+ * The xattr value maps to the hash algorithm hash_alg, and this function
+ * returns whether this setxattr should be allowed, emitting an audit
+ * message if necessary.
+ */
+int ima_setxattr_validate_hash_alg(struct dentry *dentry,
+				   const void *xattr_value,
+				   size_t xattr_value_len)
+{
+	int res =3D -EACCES;
+	char *path =3D NULL, *pathbuf =3D NULL;
+	enum hash_algo hash_alg =3D
+		ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
+				  xattr_value_len);
+
+	/**
+	 * When secure boot is enabled, only accept the IMA xattr if
+	 * hashed with the same algorithm as defined in the ima_hash
+	 * parameter (just like the 'ima_appraise' cmdline parameter
+	 * is ignored if secure boot is enabled)
+	 */
+	if (arch_ima_get_secureboot() && hash_alg !=3D ima_hash_algo)
+		goto out_warn;
+
+	/* disallow xattr writes with algorithms not built in the kernel */
+	if (hash_alg !=3D ima_hash_algo
+	    && !crypto_has_alg(hash_algo_name[hash_alg], 0, 0))
+		goto out_warn;
+
+	return 0;
+
+out_warn:
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	/* no memory available ? no file path for you */
+	if (pathbuf)
+		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
+		path, "collect_data", "forbidden-hash-algorithm", res, 0);
+
+	kfree(pathbuf);
+
+	return res;
+}
+
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
@@ -592,6 +640,12 @@ int ima_inode_setxattr(struct dentry *dentry, const ch=
ar *xattr_name,
 		digsig =3D (xvalue->type =3D=3D EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
+		/* the user-supplied xattr must use an allowed hash algo */
+		int rc =3D ima_setxattr_validate_hash_alg(dentry, xattr_value,
+							xattr_value_len);
+		if (rc !=3D 0)
+			return rc;
+
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result =3D=3D 1)
 			result =3D 0;
--=20
2.31.1
