Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B353ED002
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Aug 2021 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhHPILf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Aug 2021 04:11:35 -0400
Received: from mail-vi1eur05on2117.outbound.protection.outlook.com ([40.107.21.117]:8288
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234732AbhHPILf (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Aug 2021 04:11:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNT5tqUghZroSV6zYbsT6/ws6sLjeFEuA+0D7q5ojsOmNtiLrFgzgejPBcwvvEPgECDmJ9EJ81UArLz3ON+5XXhGheKbBsoKpje37Xu1rWHlwZKjMpmeByZJ2yUXfCopCCAXQcCogzhNeDwmL1pNQ8+CRKLoA/i9YZRGsebf61yCWiHVCWBsf2ZqWg1DjkqiF1A3vR9AjHmwWXUbcy/uo4uZy891jWmHiR4+G+1InF7eDHTv5CVa9mXtVBsfrzGNHSxHfCWMAXV1MAvZjh2NX26KFiX0X5kXWDy8QBiw2aXmkatAWCvQTZpf6TEPBXDeGfY107WqJOjU5+0fN1//+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ6WmpoEFWhGrlA0EBJTIrBDEEkKVPDDRsv/wVoy9+c=;
 b=hpRNgD50WK/TMMHL6/FE+n0+cDTMCMJl8KEk5kEIE1E9m5WNAEQJLa+7/BtcP6QSjjXSoQ59JatEwG48Ev2+TjyuFjIhYHPdEeX8YqIRJMkh66CnmmXJjtg03U7/GJuwywqZ+sM7UqKbz2BmKAI3QUc/y9ys6Z/cTYel+LynO/guvCBEwMgZC+sRMC2C6eVm0OpNiFx8HC7btWMT2PQ4Q3yPoQYKbYu0adLdHb9fjhf5ugg3dMTpWf+YNP/gxeAlrZzOVdNnSB6mxZS0y5ILoJ3HCO9dyJkqmidvEUvh6oXvr9fG9CRpOeBuhqxbjAk6XfKyauhlz7UqLl6oqOTd9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ6WmpoEFWhGrlA0EBJTIrBDEEkKVPDDRsv/wVoy9+c=;
 b=aivuJf8EvI06FHPRlqk6rOmsVXo256h2SCO6tNKku1AD/WclAgeTpXk4SuFquJ3syzNFckq3Vkw9QcFo61b3s/5EUP5gx8HpfyfCT8vqdMs1WKmwKqhPrxoM9zKF8anMta7547bLJ4JJ8SsWtCFysoTsCYypSzvbyP0XlR+lLgo=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB4516.eurprd09.prod.outlook.com
 (2603:10a6:20b:2d7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Mon, 16 Aug
 2021 08:11:00 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:11:00 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v8 2/6] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v8 2/6] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXknY/eHLT47+l4kq2cfNpE3vmfQ==
Date:   Mon, 16 Aug 2021 08:10:59 +0000
Message-ID: <20210816081056.24530-3-Simon.THOBY@viveris.fr>
References: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
In-Reply-To: <20210816081056.24530-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a07d2b65-a7b2-437e-797b-08d9608d61fe
x-ms-traffictypediagnostic: AM9PR09MB4516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB4516F615597F6DBBEF11214394FD9@AM9PR09MB4516.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Syh7FAVV674+DycDQc6gCHX3Bm50SYLSZb3ZSJtGq4DKk/abKG599Xc+QJtynfU4ddAlwuMFBkI6v+9cgz2uhksQJzR/HpAnDdZup9i0SwnMKT6D2fX/5OCo/jrKxmqy64BSsbAt1xYRGYW6vFe4q/qyYZ0Bk5bkABEr/3dnSpfWMq9N6GL0IkdHsYi3ilIqOSoDK2w7HGeiM8GykYcg5/6aGHMujlELYtAZ9ala0BTofR7Fd8XgrKVlsA1pBJOj0YNlwQAs7bBwQXDGPZGlXgai5ZuqCxEOlc+HjMCErX4BJbCeiEmGPSugG5cArgQfur0Y6EKwWjqbGqOU8yfpdE1NkOpGP9e69k7fJAYumo7qxKjMxP15bhyd5RlGLngHZ2voDY9U6u/XYUz3VOF8E4S2DBZ0gqO+kNwwkItK/+9V39Ff6Izz8H2lmXfyFDqzYteG5MFZfhA0uq5t7crYxQyMxRu7pgcnTTZ3n2KVPlkhSuSIcofvAXBM7GbO6FVnbkfkb3FKoepkUdL1Zr3FM7uLqHcSnFliAeStrK0775Z8T1c8kfkuny6Lw0zI04jIkXzS87ReFGpO+2sBNf6vkMPTbUeTEKICjYPnJElkXLFIsvKTdPnH+frxMlcAs9NhMI5XaYZ8LMi8ay9JYAg5mm0IxC+6+uOM0A0wuAlMr2EihBZxqp9LVUL/VGlWH+N/yR3eDoGjVBspM7ZS0GzA7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(71200400001)(6636002)(2616005)(122000001)(83380400001)(15650500001)(6486002)(36756003)(38100700002)(66446008)(8936002)(4326008)(110136005)(26005)(66946007)(1076003)(2906002)(5660300002)(508600001)(6506007)(8676002)(54906003)(186003)(38070700005)(86362001)(66556008)(316002)(76116006)(91956017)(66476007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3HzPBCgNNno/qUdDaMNqA7WK6/tQLHI2bs33yQgAgu68bT5MF8aIx9f5fY?=
 =?iso-8859-1?Q?sTXtnTsUryFREPhiVyb9p/QzTee15aNp5FEmKWeRyeSh6TzvxDu0l2TEj4?=
 =?iso-8859-1?Q?+Jlb2Ywj8MGOp6+/Ed9WGtasJ+Z1xtLl89yP9Kq1Y7tjnLLo+a5k1kaMR1?=
 =?iso-8859-1?Q?yNht1pyjbomYimH0R1UYVbznm0iljwS2MZKbCnZKl1jBIFMC+6fFhkfkc4?=
 =?iso-8859-1?Q?3Unhsdbd6RFYlYGtOdQ6EFc0PLwGcy5hOykmY/QPJuEr5Q43RF2kzyC12f?=
 =?iso-8859-1?Q?WcO7kjGU0ISBwoBwqC2/MLJxydxHA43vamv2/50OhUns0WboU/+JGMhNNa?=
 =?iso-8859-1?Q?3ZUC7Xb8fQ+2gllru1LQO03TtrrEDpU0GDF2y41W8B9mumSW0jXx4l9ry8?=
 =?iso-8859-1?Q?mGzzI0vTDKja6+BbizcWgA3ADYC54KVpDJsjt0PTeceRVsc1dbEh2UD1nH?=
 =?iso-8859-1?Q?aKtteZ9HKLUCSQ30Jl/zBqFWaBVA9N77D1QFkFMwFZnE7lNHPC5icC96RP?=
 =?iso-8859-1?Q?AhtaGegRMuINHZELgVKNuT9OdBtdhsP9EK5VaL2pklmmmAG/HrBch5d92l?=
 =?iso-8859-1?Q?hti+CnXJ5Y3I20MB5lm03e5T9QN1jLhLx+pdij+m/GGMnp2syBnhjjXZNu?=
 =?iso-8859-1?Q?63NrBqZaJ0tzdDYp98xnpF+EkjLhC/3n/Fqs5NsqX3RSi3YP/8NaI7980P?=
 =?iso-8859-1?Q?8l2BXjPZ1owhza+I8O7RBJAcCNZRP2dDVaGN35+MBYpdctWPLFGaXKPQ5M?=
 =?iso-8859-1?Q?8t4w3i/zUVxK+835y/CgcXUyrATsVbZyWtRrdYKn0QLCz+nQ1xA8+YPAQh?=
 =?iso-8859-1?Q?6OCtcXQx+uzE8/3YEe1u/efKB/nmC7xi7R1eBU+pQ+blcGKOzvrXcAx68b?=
 =?iso-8859-1?Q?vPr78QPUSu71p9nPATEUddWn/R0zuZOnYqfdLG+bbvAGeF7Xeos74GVUAN?=
 =?iso-8859-1?Q?Dv/IM4B8wmzExPwv9km8RSsn7DwIwkGn5jIDUkbQnzhFyQg2PzuoIkNIzK?=
 =?iso-8859-1?Q?/p8oxO09MO0lOyGMpQq90FuhL/NBnqsorD+hlCwwyDD5IvWVHknir/ukER?=
 =?iso-8859-1?Q?lckgc7JHsCYLAnOoXsZsn5EX5Ebd5Bh38gtJ0ntMEyFnR8qvasJ3Iz+Ecf?=
 =?iso-8859-1?Q?Sd80P0cWtKdXz4XkgBwhI+xDKajLrDEPOTxEAkpcJzkNd5Gp349mL2Nr9p?=
 =?iso-8859-1?Q?Kb9BHYOVB55caWmNmivAfHx/0RS4PoT3Yw3kSzkPO8SnAMr0AwB6g81Lw8?=
 =?iso-8859-1?Q?V+vLO977bIjWouQ7AfQcxiplTqXq4tN22vHGe5tAI5785H3nORdD3UQLfS?=
 =?iso-8859-1?Q?ut+AfDHWwAlUUu7f6dvdHGC0IQDcoKj0aQ6ydOV1hADPZJ5Im9x8Pgl/EE?=
 =?iso-8859-1?Q?d6GC3Xtbus?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d2b65-a7b2-437e-797b-08d9608d61fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:10:59.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aj3y/JhR/fgtHe5Mlz2jkHxyCgVC+9J1TvdbSS4J3qmG1gX5/etZBu+r1BAakVu1g/7AFLDyZJRvrAjs6mJm/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4516
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default, writes to the extended attributes security.ima will be
allowed even if the hash algorithm used for the xattr is not compiled
in the kernel (which does not make sense because the kernel would not
be able to appraise that file as it lacks support for validating the
hash).

Prevent and audit writes to the security.ima xattr if the hash algorithm
used in the new value is not available in the current kernel.

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
---
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_appraise.c | 49 +++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 2f4c20b16ad7..829478dabeeb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -319,7 +319,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns=
, struct inode *inode,
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file=
);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *ii=
nt,
 					   enum ima_hooks func);
-enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
+enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_va=
lue,
 				 int xattr_len);
 int ima_read_xattr(struct dentry *dentry,
 		   struct evm_ima_xattr_data **xattr_value);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index 63bec42c353f..baeb10efbf51 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -171,7 +171,7 @@ static void ima_cache_flags(struct integrity_iint_cache=
 *iint,
 	}
 }
=20
-enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
+enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_va=
lue,
 				 int xattr_len)
 {
 	struct signature_v2_hdr *sig;
@@ -575,6 +575,47 @@ static void ima_reset_appraise_flags(struct inode *ino=
de, int digsig)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
=20
+/**
+ * validate_hash_algo() - Block setxattr with unsupported hash algorithms
+ * @dentry: object of the setxattr()
+ * @xattr_value: userland supplied xattr value
+ * @xattr_value_len: length of xattr_value
+ *
+ * The xattr value is mapped to its hash algorithm, and this algorithm
+ * must be built in the kernel for the setxattr to be allowed.
+ *
+ * Emit an audit message when the algorithm is invalid.
+ *
+ * Return: 0 on success, else an error.
+ */
+static int validate_hash_algo(struct dentry *dentry,
+			      const struct evm_ima_xattr_data *xattr_value,
+			      size_t xattr_value_len)
+{
+	char *path =3D NULL, *pathbuf =3D NULL;
+	enum hash_algo xattr_hash_algo;
+
+	xattr_hash_algo =3D ima_get_hash_algo(xattr_value, xattr_value_len);
+
+	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
+		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
+		return 0;
+
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathbuf)
+		return -EACCES;
+
+	path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
+			    "set_data", "unavailable-hash-algorithm",
+			    -EACCES, 0);
+
+	kfree(pathbuf);
+
+	return -EACCES;
+}
+
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
@@ -592,9 +633,11 @@ int ima_inode_setxattr(struct dentry *dentry, const ch=
ar *xattr_name,
 		digsig =3D (xvalue->type =3D=3D EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
+		result =3D validate_hash_algo(dentry, xvalue, xattr_value_len);
+		if (result)
+			return result;
+
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
-		if (result =3D=3D 1)
-			result =3D 0;
 	}
 	return result;
 }
--=20
2.31.1
