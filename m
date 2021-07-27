Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9906F3D7304
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 12:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhG0KXq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 06:23:46 -0400
Received: from mail-eopbgr70098.outbound.protection.outlook.com ([40.107.7.98]:4837
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236249AbhG0KXe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 06:23:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDUcpCTDgXsNg3pTySPbusJGsW1wqN+ypHmkr0SxMTplOhaxxzr/qop1Wf6mFwyPAxtaUZE5GiUXxNDQB/kebTjLufCJIML5hXYXbP/61FvOfutNfoD2KoPh1a2+JTF3av2/ae3Bp84PjDF5nD8sEo3YtkJxDdHUuQqwPVqFsGX8XgOMd21xj+r4dn0sBkWfQfUBF6Oa+4N6i+vADftlXlX0aKWhjqXgH+nHdDXNC2GYOifBymXOatQUHW1HMByr/KEwA2ElLyVDzqLtRjO5Eka+xHvnArvfYxcgGoK2e6P33vr3rWrCDDFOy2n2qEjmvr+1rTS3HLaqtpTC5okggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmNh/dVv0XALd56mz9Bu4Nd9ewP8Bx8BFQZbDOFbN3E=;
 b=WxW9SwRGOpb9Cm7fu+J+X2dCddd8P6xAr3Q463bpRfv6hndLrwZEF33d8JmPxcnabZ770+6nL5smICYYYeusbn4ioa1JVISgPuVnW5aVPO3s/pR9M5LOwkdEJuH4k8D8htnFfztNsIRFXMm6EdUJfp5ItiLirYroog5ADHkp8b2Aquz62ix4EBocV6YTkKAWFevfMOEAIAomCSWXDF8JijNSGfFW7qHlT4fP8FPsOvM3/z4WGIWRJFNt1v+mP+jtynJ2fNIM5fmfVZvxW3BjpmTTHii8S2yOJ8mH/ynLod2WHCixrC95A3MeoCxP+hR8rDdEcX4p4SyYuKocgfUHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmNh/dVv0XALd56mz9Bu4Nd9ewP8Bx8BFQZbDOFbN3E=;
 b=PvKA95cGCjVBalsh9RLe+ko+YUZlkvivMd44Qm6nmp6P9ElQ/KWzd9akGX8Tw4EErr562qy8hSTyZO7iSwF6501NznXoBwsdeh6OpqQ7pu01Lk73i8anz7mMHkrfQkL4hPpJGamNECgn/0mrEsmnYMtKEU2UUPD31RZB9BzXjTA=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB3364.eurprd09.prod.outlook.com
 (2603:10a6:208:16c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Tue, 27 Jul
 2021 10:23:33 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 10:23:33 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v3 1/4] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v3 1/4] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXgtFzgGMZrlq3rkCxUiyd7vInTQ==
Date:   Tue, 27 Jul 2021 10:23:32 +0000
Message-ID: <20210727102307.552052-2-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
In-Reply-To: <20210727102307.552052-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1320ad4f-ddb4-4bdf-77cd-08d950e89617
x-ms-traffictypediagnostic: AM0PR09MB3364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB3364CD5161367B62E46BFAA394E99@AM0PR09MB3364.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pV49p/tk0eGCekrK4Iujcjyic6lGvgIbrlbHo1PaxAmhmwlHWQi05aX+UZyao7al2Tm3MfS8HVyP9XQhLLb4VmcwCAjNWku1FFKybRvaBa9B/2e6z/lWKQuKYF0HoSJlU6iPc3nU+xnlMkcb/jPVp5UYUULe1nyZF39Y/rU7CJNSaxBVLXmZ9PNEamybDlgqCfiCxIvXYVDcX8+gH1C4ra8RtHzXqxphPdK6FLKfV5YV596U185XS0IqnZLFu/hfAliYWZsPC/S03yX1T3fiQo9246gmyUGAIwMyueAPs9ImKlBA/WXLVWRStcrsSBJ8gS546w6+1Sn02+ykmfxwRqE5N904w/OpZ1uU4JgGWQny+CMo+jpNfV2Ibvm+I6krc+NaSzA7k0h51olvDV2x/Rzs0PrN+5co+vnZ4ie/6Xhgvg2yTb5niX3XpXZZMnhyAQOTHCqqOgWJzkDtGJq7xqtwZ8KlXGnGmFJwMtEtTaJxViLGBPpm/WBHJtlSRFD0ez3Nv6S5pR42KZCsIKpa6IdFUguW6Xa1YucAZ6UYz43OVrqpWMC/3pnfR2XyEvrk3AJxcYowujLLI6tn+lLTnKBo/fUPviFlmWfhApcIqsM3GIuAXR+HtICnc9zN5ld3BQsmc2Zd4/P5TC6msCMNqmOdxzLsCijiMPtjmsW7ksYQdbLrJEoZLazRQC98xNwAL4Z0lc5lWwOg/0WhSDX7Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(346002)(376002)(396003)(136003)(6486002)(122000001)(2616005)(6512007)(6506007)(478600001)(15650500001)(8936002)(6636002)(66946007)(2906002)(316002)(91956017)(76116006)(107886003)(8676002)(186003)(66476007)(4326008)(64756008)(38100700002)(86362001)(5660300002)(110136005)(66556008)(66446008)(26005)(83380400001)(36756003)(71200400001)(1076003)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yBG6FmiFMjB/XDpFwoDj4jIsfMi4MdUjwdc+VUNVMVhRrh3idN66+qYpnK?=
 =?iso-8859-1?Q?YjJQt1FajGdRqauqW8b1yfT6/fGT+HUgreGagJVqOpW4v8oRLfW6LN6dDf?=
 =?iso-8859-1?Q?ZoMDthdxIKVNRjwj9sEMGMNttvGzEp+l/XowiKYkoI2HUIfk6hO8s9H7rJ?=
 =?iso-8859-1?Q?7DlKToHAKgT1cEeOsIrmLmQkon6x+IRin2hqRyX+Nnhyx7L7jJtQX91E5S?=
 =?iso-8859-1?Q?H4hW6mk6Y70r0ZzdQ2dndL3H4iUKDv0xNx3XGS8lYK+fbpgqN3c2IzXVFx?=
 =?iso-8859-1?Q?crUWgv4ktzGQvwdDWnOzcoi7D5sPS3/EnQiiqm1wkXcfqLUfieSpG6WwNd?=
 =?iso-8859-1?Q?yuZap/tp2iZ4JFs/oetD4gRoLZz5odWG8aP1dQiHsIbRI1/9xzK3Y/2wQW?=
 =?iso-8859-1?Q?u982AzyzNuzBjNPa4Rltrk1Kt1oEDNYjdVW0O/szgtcya6sjq6a0Om+Fyw?=
 =?iso-8859-1?Q?F6ItJ4q67UvXn8xd4+LLnfkCJX3xbm0DnbjSHBY0Po4zYwG1sIHZeZgICb?=
 =?iso-8859-1?Q?RbLC9ImVfOTOHvvBh6pDPAsIRTRaHEqfaJWqkZ0N/Ie1rkTABAi1ML6rLV?=
 =?iso-8859-1?Q?dEgzBOfyIdoRVcU4ySlhB9qnix/j4uV3EDucY0UiaZ+FTA4jO3L6uIS1bi?=
 =?iso-8859-1?Q?prt/5gtpiQhhbSpduhp5uHT/uzp7M/UVdl71sHAYG3WW97E6bwoikKP6gt?=
 =?iso-8859-1?Q?6TBPGHTPHGi5vSYNLit9POcsF3eIwDXvTXDMjKudUCRlmq6bh9yK6q7h0B?=
 =?iso-8859-1?Q?1SEFDcGvx44hUf4iY9N3MRA9u4zSgoNDJdgcOiSaimgzzsS/EF9X20QR3n?=
 =?iso-8859-1?Q?kz1KFNtD61BAV9AisRRK1hxLlK+XBkXxc24S7tk37pHNqfXQb38k1MLeQI?=
 =?iso-8859-1?Q?ee/2u4UF+L9lNWoWJRkThQcBM0OhJcayi1hPLElmtXiQu7eRrqRgrw3hYi?=
 =?iso-8859-1?Q?LhkB67+niweAoAAVyYWIKG5UtH0pbs0zv0BFGtYM7umD/t2VBy+3KLpwtF?=
 =?iso-8859-1?Q?Cvpfyy7InK0FqJMBAUCsQCQe6uJpRvT0Mj1AGz/wdTsQTQnMj1l1qZo3ok?=
 =?iso-8859-1?Q?jNfD6foy+mOTo7A43M7oPWczZy/VBFsiySWqJbNpvcPnvouuY1F1PP9cg6?=
 =?iso-8859-1?Q?mY2Lp0qOkB0zRqZPIp0UxyPSj+MCldt28VEsxY0+e+LnioE2nvW0WY7MEp?=
 =?iso-8859-1?Q?P1teai1OwX+YIV/Aex43rFmPtWkWT2h6QspHQtaHlox/INt17GdQ/VJAYF?=
 =?iso-8859-1?Q?vUDzzrCJAZfRGFEzlvmEcfPszmYWRpxHnjHS4vwcX3dFVdbRyRs0ngjZul?=
 =?iso-8859-1?Q?nI3+G2jjU0WeYv71mLsNPyrxjKYh0mrSwCxtf/JVhB16BG9T3jgvzc+DM9?=
 =?iso-8859-1?Q?LZxLT1DXef?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1320ad4f-ddb4-4bdf-77cd-08d950e89617
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 10:23:32.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBgv0C2UuUPeyVEaWBWyglzT8WQLLwtlu2/U175FREt6Bq7klRJlMNIp5YBfObuovvfzs34j/2eMVbbEv1NOIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3364
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default, any write to the extended attributes security.ima will be
accepted, even if the xattr value uses a hash algorithm not compiled in
the kernel (which doesn't make sense, because the kernel wouldn't be able
to appraise that file, as it lacks support for validating the hash).

This patch prevents such writes: only writes using hash algorithms
available in the current kernel are now allowed. Any attempt to
perform these writes will be denied with an audit message.

The idea behind this patch is that a user can disable weak hashes
when building the kernel, and thereby prevent their use in IMA
(these hash algorithms will not only be blocked for setxattr per
this patch, but they also won't be allowed for measurement/appraisal
either as the kernel isn't able to measure files hashed with them).

Note however that CONFIG_IMA depends on CONFIG_CRYPTO_MD5 and
CONFIG_CRYPTO_SHA1, which hampers the security benefits of this
measure.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima_appraise.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index ef9dcfce45d4..b5b11f5ec90a 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -575,6 +575,42 @@ static void ima_reset_appraise_flags(struct inode *ino=
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
+	/* disallow xattr writes with algorithms not built in the kernel */
+	if (likely(hash_alg =3D=3D ima_hash_algo
+	    || crypto_has_alg(hash_algo_name[hash_alg], 0, 0)))
+		return 0;
+
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	/* no memory available ? no file path for you */
+	if (pathbuf)
+		path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
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
@@ -592,6 +628,12 @@ int ima_inode_setxattr(struct dentry *dentry, const ch=
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
