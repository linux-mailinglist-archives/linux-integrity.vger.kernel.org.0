Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC43D7B00
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhG0Qdo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 12:33:44 -0400
Received: from mail-eopbgr130129.outbound.protection.outlook.com ([40.107.13.129]:40010
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229630AbhG0Qdn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 12:33:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVRZDrbh/RUEMjbgD3SENRhd6DFiS+ty9m9/Yd0a1N3VAjr7BzzNDb4272NKoNkk5bA7GI2nDyzIfcYWNKpoeMQ5CXIyMjSIDcqGLWLV49nUP9kKY4v+jAci7Vas8ne7tlpTGfZYU4hqKHCXi0BZcdaSGmfgaKxClqs3EjOiyDSCKb4uruHD1kWN2HrBoXmnsiZ8gyfv2dtBAXscQ2GAWoTsoZpdrXO5UXhlNmlk0QLG3bqVgTw9gsNLXgqkktsiUi1qusfkK0VO2ZPQdOwlZjy0LzgeeiR4qNjtFkvtFf2f43Ri7yen8C9hYEPH8qABBjJmYDx7mbdaHLNUpSUMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVT7j4SAxiAXCzYWfHDM8WroRG6rNQkQ4wisGSK7nJs=;
 b=oKaFkZR2FEejoqStUACoinkd7Y8coL3jMpFt9GQypVX2/u7PkfrSXz27dVggtesNfz15lb2uJbGrNiRIt71qSNHNjMe6I4zqggOo3ClD4JAt2V6S8aNlPqoc6xIy7x6mPwMgac2L4adXqK6HhMT4Pjo582a1NnWlTDiRDInywhOPltevE9PaVQuI5FxkafShfxqshn7usWrXQJ6WcGa61Ujf6bsDAnQWq9Fgj0NpebqA4xG0I1iGZMbTyt9VUsJ+FZ+lOS1/VMQP6Mc9jJVOQTEaExPFZOmRIoAHT4E/ju68qhATHsUgg0tpbGmlWTXArkdZGxwjMbLCbxml22VJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVT7j4SAxiAXCzYWfHDM8WroRG6rNQkQ4wisGSK7nJs=;
 b=zU8zkFSdQV1Tw82sdBF6XeqnbFPgtqS4krUAMtMhzCv8o2S3aYqFiP3d8ImMQHadn2vz5ouGTJJguU0iQdL1MlmAN5+F2YmYNrPkDcYzffUuHOi1Xzp0xrZu5vKSIrBrczqxOMK/ZTn6emP1LZTlPuGPNNvP2tXte1FBzZPN8zk=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4243.eurprd09.prod.outlook.com
 (2603:10a6:208:182::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Tue, 27 Jul
 2021 16:33:39 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 16:33:39 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXgwUkWGVV9iy3rkKcNLQiDD+1vA==
Date:   Tue, 27 Jul 2021 16:33:34 +0000
Message-ID: <20210727163330.790010-3-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727163330.790010-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b3e7ede-b519-4cc3-7877-08d9511c4a44
x-ms-traffictypediagnostic: AM0PR09MB4243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB424311D7460B650F4CC4F7A094E99@AM0PR09MB4243.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mssqaTb52AwaGlQ0nJ5HXzHLo/4CdTlGHSXK2M8vFmlIepBu/ZeXV3dkT3+74Qs84RcoujZd+V5kCMOxF3xghIez02OJeH1RxVzeyLq6jTuyfeI6RfsfyBmovFD3w7d9yHfl4cLzbjac7HfvzzCyvfqREeQMEwWW/dcedbWl+51wnMi6h7lVX0zK71q9wcDJd8+v5f0+W9nrEhCV3+pK+vHO04bNBiOtVeSY5c4LigIA/JRb9TEFFndY1aD4M77CIszdILkG1rig9RKAvYcq6p2xF5tDLLcLXZ0XzId0c/bLxQMdUPd4tP2T/l4LG+1SnV+3L3saTOYUlZu8dUL1FWfljyJyAX8qzIRXz7W4C/onn4Q5ObKfq791LdNaeqhL0Kk3ijzXXAcVpBsSqI1uiwJ/Zu3ni0gRFXkL95ghOJJMVeeideNMiuJqvH2HBASYuUqAiq2HH0cj4hITTx4nIKofE1Gg7FUBOv+T3XyGg2aXu/F4i9i/EcWzsmWdNyGp1qgHQ7T9CWUun6FgXYyUQFpSA8QIns2P5ZCRVAARpoKdYO8W8bQ6V6hHBKmAbHnNpjqHQuUGX41IKoc20hEqxAkv4LV986foQvHQ0H005+y22xqK6WAmQFcUOyNaeuWETMYHnaiaZ24t9CiWE3GvlnmLeoXEI2M7zutVndKqFi6FU+TKAgCWd+NlOtUKlx/6gFEeH6sGI2F8i6io+Cbveg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39840400004)(396003)(346002)(136003)(15650500001)(66446008)(122000001)(66946007)(6666004)(76116006)(36756003)(91956017)(2906002)(38100700002)(26005)(2616005)(186003)(6486002)(86362001)(6506007)(110136005)(4326008)(478600001)(64756008)(66556008)(66476007)(6512007)(71200400001)(1076003)(316002)(5660300002)(6636002)(83380400001)(8936002)(8676002)(107886003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fwY3AfNfp6JZAspVvHO5GtFi9XOiBJVIPNVgKLCvNTytTbmBGJk7ohZxpB?=
 =?iso-8859-1?Q?/osyloAqyNy5+p4Mst1MGtk9525fvVzpWoykw3teQ+KhWMMdnhSiy5b/YN?=
 =?iso-8859-1?Q?/0iOCPAqVX/mPk5dEHPNNr6uGD5sxv8UHioQf1ZZRFDmVO5Z3ZAvKL4fyY?=
 =?iso-8859-1?Q?UZ3+XSlSa+Ft5ekfxDjWpke1K1Qtbn1Mharm7utF/SZJc6q3dQgTIXSEQX?=
 =?iso-8859-1?Q?RGbNfJl8kitBf18QfhKjhyvVWDL44391SEYDMgl/mCs/lbcHRZQg1eWBAu?=
 =?iso-8859-1?Q?QYncSAigobyPBd/5wLwXaGML/E1PRo/Blw409hYy6FFUBk3CSfj5VYSdvq?=
 =?iso-8859-1?Q?FP43sUmg9Xh5VqGiLNJfSHEOqpHRLwWTx5dvmfdy2qViwBUgitO1siJkKk?=
 =?iso-8859-1?Q?mrn5npXvqklZnptdw3q12Z8b5bWzLV7z2ygBh9kiPPTCJQ5gxj25VWxe/y?=
 =?iso-8859-1?Q?pZXufItFGmAHp+UUbpCn2Jgp/6LNMOolZ7vk/FoxBX7Y8ZZfDH550n9Y7Z?=
 =?iso-8859-1?Q?0jRmrTDQMyC1BvVS5KL5du+21r7qGj04nxNYUM5/AFNYJ/gr/uKDmA7KOi?=
 =?iso-8859-1?Q?4Zgm+2K4j5EExVF5PCx5aQQ04Q2XAt5dQGtMeEfBtn5i1cRSnZ9YWVMblr?=
 =?iso-8859-1?Q?FwiXxIR5Y2BgChVy1syBq33TdOthre7PkDzgIcEUycyyvJ1nbqBXA3a1xw?=
 =?iso-8859-1?Q?EGnFOrpE1azu7ePMMsbsA2rfFFrB5MY5SCbRrNtnVK1pjJR6bI4qOTgSUh?=
 =?iso-8859-1?Q?JwcTKRPHoFPZKLYMvvsYkhjCyRiXo7BD2wW9IwusrNXlcjwUNOPHDqoi+2?=
 =?iso-8859-1?Q?20no4ezSOO6om36do6LszxUYU3t96dosdVTpJmVs8tSsgAHdej5nE6EXhy?=
 =?iso-8859-1?Q?M1qgKRdq8mYPyPknzrBiXpxrWeluhdDMPoobUogBJirx6CvGmFOIF5F86v?=
 =?iso-8859-1?Q?+x2OcGCmsRPI/qULyflWAquWnz8SFjJNPX1efghrjsH0QkzKn4vgsRyxId?=
 =?iso-8859-1?Q?boVoNa6Id3ZKq0Ao/5Lksr0ijq+Zop0FpK5UJwU8gZfWpak/URj0A1kbPL?=
 =?iso-8859-1?Q?8FAxfwk+bg402DzK1/I5mnp8Mffh4eqasbgofYHTybOHtThipK1Vvb91Fo?=
 =?iso-8859-1?Q?SiLWG29CPADMzKrp08h7Dmpzo+0/b9hYqG3UqrXabaElNQsd3913zJLY5K?=
 =?iso-8859-1?Q?Sb6J7Kqrm1C91zd3MJthW1RyJsmiXhByF8OjNeH6k3B1wN/Ta5ISOEB4kw?=
 =?iso-8859-1?Q?AS0E4Fk9mF6504ETuRtruWb0DLhbDlob13GICneCLpGAfDaT5MCfYz6Jlv?=
 =?iso-8859-1?Q?67/j0ykRkd2tNNM+Yn/vRyAGQec1bxFu9HcYWz4j7gZozHyG3cLtuqE5Nz?=
 =?iso-8859-1?Q?Fe37P5yJG6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e7ede-b519-4cc3-7877-08d9511c4a44
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 16:33:34.3854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VctxQrDB4bfY62RYJhN186mE90cSUeVzzYaayPmnxdjRd+VhJjCe5UW9zGcedyXW2WBcCoIlIt6j2UImYy6RNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4243
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
 security/integrity/ima/ima_appraise.c | 51 ++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index ef9dcfce45d4..989da2fbf496 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -575,12 +575,55 @@ static void ima_reset_appraise_flags(struct inode *in=
ode, int digsig)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
=20
+/**
+ * ima_setxattr_validate_hash_alg() - Block setxattr with invalid digests
+ * @dentry: file being altered
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
+int ima_setxattr_validate_hash_alg(struct dentry *dentry,
+				   const void *xattr_value,
+				   size_t xattr_value_len)
+{
+	int res =3D -EACCES;
+	char *path =3D NULL, *pathbuf =3D NULL;
+	enum hash_algo dentry_hash;
+
+	dentry_hash =3D ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_valu=
e,
+				     xattr_value_len);
+
+	if (likely(dentry_hash =3D=3D ima_hash_algo
+	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
+		return 0;
+
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	/* no memory available ? no file path for you */
+	if (pathbuf)
+		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
+	/* disallow xattr writes with algorithms not built in the kernel */
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
+		path, "collect_data", "unavailable-hash-algorithm", res, 0);
+
+	kfree(pathbuf);
+
+	return res;
+}
+
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
 	const struct evm_ima_xattr_data *xvalue =3D xattr_value;
 	int digsig =3D 0;
-	int result;
+	int result, rc;
=20
 	result =3D ima_protect_xattr(dentry, xattr_name, xattr_value,
 				   xattr_value_len);
@@ -592,6 +635,12 @@ int ima_inode_setxattr(struct dentry *dentry, const ch=
ar *xattr_name,
 		digsig =3D (xvalue->type =3D=3D EVM_XATTR_PORTABLE_DIGSIG);
 	}
 	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
+		/* the user-supplied xattr must use an allowed hash algo */
+		rc =3D ima_setxattr_validate_hash_alg(dentry, xattr_value,
+							xattr_value_len);
+		if (!rc)
+			return rc;
+
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result =3D=3D 1)
 			result =3D 0;
--=20
2.31.1
