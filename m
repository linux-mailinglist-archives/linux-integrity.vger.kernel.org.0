Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F313E8F94
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 13:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237390AbhHKLlN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 07:41:13 -0400
Received: from mail-vi1eur05on2118.outbound.protection.outlook.com ([40.107.21.118]:48096
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237329AbhHKLlM (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 07:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUNu8X9eWNZCq5UoOI/C3htBBjAuK4To5c4IQJZNs2wqwJMo6+HeeKyf7BpuqM1D0BJxLQYgBG3FRJE++NkAbDzX9USj/63eOsm2mVBjGWaUmjTSBaUB80g/3grl7Xk93kRohuM1Giwte2loZVWQbu1t6iEdPZhWQIkbF5xUqMkQXPIOCtga5o4Vf8Pxx2LoXP3SwtWFj010XZn/k7NxCsc2+vmnXeQg/98AEs9tkx0QqpAa5IhOj027EmvNargYqyQXrQtmOoCmC8uXnGL8K7R3/Cm987o5cgBCW+Vr8D4MWRowYXzXhxaHfAUWAOF5a4YIOX1iNTc4udRc4f8DsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYvYgpZzQTrXwry5eMWS2ngnfgJPSOEnm2i9ebyew4=;
 b=Y4iKrjjq9X2Avzdghjoe+8XiZTOfCN7peD0V0o+vbJcyHSTi4uuMDsbAIddMO1xDp8PSh9HBNZq3ZqSU2PHnVf4+zgdunR3AAO9KDq4d2LaaW7YXMukuKxMK2J0/CQAf8+qb+uyuqpwnv5q1tO56L/v8fi3n71KG3xAwYrc1N9ZAqxrWiZTzVtaidQ0MP0F3sJuxZgjJZ6tBX4509tKhvwjDiCol6/EikCOJFl1rUDa5SGwnw26cNXiWn9Jrlt4FZLk1Jpgk/JVsz2PqrcMoPOWnTK6DmzSurwRPHbVgAa2jGGFos8VjwDWrAJPNEOfkpluLmigySx6dY9WxywPB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBYvYgpZzQTrXwry5eMWS2ngnfgJPSOEnm2i9ebyew4=;
 b=4sbZ9bEbIljQls1CoGiJEWWn8hnKuekE1UVkXO+P50EQGvv6XB355Jlo4IQn5BABNpXihMXFfYin0fr5Iw5uxbpSGFjIL6pxBaQYlwrS1wXvS27Zladgrmd30dRF9cfJv9TDYB6ORAdX9noOQ3av0B416AE3xhvT8U57/Phyi3A=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5105.eurprd09.prod.outlook.com
 (2603:10a6:20b:30a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Wed, 11 Aug
 2021 11:40:46 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 11:40:46 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: [PATCH v7 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v7 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXjqW51IM16NL7pk+jESew0EP0/A==
Date:   Wed, 11 Aug 2021 11:40:46 +0000
Message-ID: <20210811114037.201887-3-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
In-Reply-To: <20210811114037.201887-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09633e66-15e9-4351-6213-08d95cbcdbea
x-ms-traffictypediagnostic: AM9PR09MB5105:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM9PR09MB5105D9BCE322351E0DF2A47B94F89@AM9PR09MB5105.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSphTP9XbsQp8gAewa8hhsNm73EG9aTzSK8Uc0K+XT6UqhIUAIccCpPfbxPJile078461B+oRviqvpBIPgWKK6OzMYjLpw23TgcR4cbLMkB1P2QAdF5bxBKHs873D89/3hgVrH/ogJJbWtsxFhv4nwSHqbfCbo8FD11cRW873bBQmYuDiT/QBXBRShDeAEmLJHGri7bFxvPCAyrGlK68cBYXDfGFgL4ggVAle0N5AtZwHu95aK5tn61MrMqFv3NtWxOWCLlrO27DFKmXTUDo4MR97ibyM0l1DA5t2XqWcH77nHQXNhfyuzvSu75qLMpn4VDba1KXutV08Paxyngxwrpudr89yNKQJrqMR/8I89qdx3INIluL6cw5XKQ0s4Cu+klDaLvC/DsvNXDCENA55THeG8H5Qbdv6DjhUdTfbCLzbdrQYWepdyqkkgEYRqxSKwjswrEFEu0Q0cs4vUbvsRyPUuftv3cl4KGgZKpaXmb9BIw5LmK9ml4CcTW7pXYnZNJujTZsKXiGBWOEThzuQV+pJJSl3jRioWso4zcYNj6AK7hWG9JX8dRhKMPsoBPO7EZjpwiTfq4KEabOfxPLC/4wEGpck6YTx/O22EuTvfWa61YDEYpehSFca7TowkWVd+20A3LvZPkuGwCBIml522lZnBh6G4kXpQAhILF46pyiI2QZQsTaTUNBIqEKg0KbuybwHZRFgnynWMH5mYbOeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(346002)(136003)(366004)(376002)(2616005)(5660300002)(36756003)(54906003)(76116006)(6512007)(186003)(316002)(8676002)(6636002)(6506007)(91956017)(64756008)(8936002)(66556008)(110136005)(66476007)(122000001)(4326008)(38100700002)(66446008)(66946007)(1076003)(2906002)(83380400001)(6486002)(15650500001)(38070700005)(71200400001)(478600001)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iSq02zrdOTkOYiZj5rQ0xhAVf/vWnL67VYrmfye3vPmkS47ckF1OSgpZ/M?=
 =?iso-8859-1?Q?VgWL5rfWSUBE2acsRr/T46I8ePGvydowrVZ95bg2CVVwIb+e+bzXEQvdEy?=
 =?iso-8859-1?Q?d+ZQQIEE4UNje58yGuIA6xW+9+7Elkrt4ayVw+WywedxBLXpYVzxQfRemn?=
 =?iso-8859-1?Q?1+CGsh+8Ta/RK8bms8LVnnp0iLwcp5QzKPs4H+93/HM1+OFLyyILx8n/Pt?=
 =?iso-8859-1?Q?CpcJ1BrecFiTApVtDvG/qkA4YAizttkuOwoGM2XuWIUVS1hMiyb/raw/7P?=
 =?iso-8859-1?Q?+rM1AW2U/DmOEHsBei2T4oAfhHKdvLxuJCjB3yUwWPK/QMhzRUZnH6VqyU?=
 =?iso-8859-1?Q?5Mmo6pZx3e8UfaRgY7voNRLsM57JIRXWfeqnZhmLEzzI+zmx68gkq+ra9s?=
 =?iso-8859-1?Q?XxrZ1jrO6udvwPf+i3JddnVN5xdwGW6fYAvi+OZdz7h+DeQJqtHtqaJ9gI?=
 =?iso-8859-1?Q?E5WkFFwggRkZrUnGIcQieM0oTXU8b7ZWPCmNVph8c6TKuqPmLTrIlSiiEv?=
 =?iso-8859-1?Q?Dt5utSaPx7rb/un04mTSX94lZa9lS1maIleWrtyHgBkG+foFYiLXNehp6G?=
 =?iso-8859-1?Q?eBVyrQclPT7d9rRHq3jnOA0Vs4qdE8YqO6l4SVdDKKE591ZAceHdumkJO+?=
 =?iso-8859-1?Q?j6UoE/W5nRPxNHWumuqgetPpWiwJ2imu/7lCJLM0QoJigxZGKfDy+nGP6j?=
 =?iso-8859-1?Q?Tgiq1k/y4vkpA+ubxm0irgbgdMHw6M+GTlsrwQAj2mtPqnWiE/Kdqd73qh?=
 =?iso-8859-1?Q?zJMDupZqfDudmTCFk+16e+9VcUx+asJxX9fAayNhpE7rD+pz4B5xF+G0oL?=
 =?iso-8859-1?Q?WpKilZK1PpT1XEv+JZG4p6VOY3L9kDbLzDkXWF5aPYs3+KK2hlODrJ8Sfw?=
 =?iso-8859-1?Q?oFDskBcsGzgVGXXKZ4YAQFp+qVk9RrBJ9slHAZELWMzPTL+wBY26oKDrs1?=
 =?iso-8859-1?Q?4cj0UAIlIK+fO9M9DwHSbRid3wM6yzImc7tbO05gqy2sj93lQCKewPH40F?=
 =?iso-8859-1?Q?/YWpEZycjxhUKhvctWrMknh0dE3Y4nQ94wDbjPimb4AQtHW/c5bW5/HFIn?=
 =?iso-8859-1?Q?ZW3GpOtIEjJ3ScXOxl1ivPjn2x+KEamOBT80HN1ejiiImTX1LCRGw9uVOr?=
 =?iso-8859-1?Q?WLs5leWTZXxZJJ7OV/lgLY92D7lnaYUIwi3LpbmEN96R8hIbzABuOU5GCQ?=
 =?iso-8859-1?Q?ibz9/6NIMesEenqFJhrPbGHqZugJ6tzokEiSNAIEQuk51hKUARS2f4ZUgI?=
 =?iso-8859-1?Q?bBjRCbjkr4xQr6saUnCC75Hnf4gs+P3wHhVWUd4HlBwqX0NvG5rWgPevOz?=
 =?iso-8859-1?Q?QWPYEq8OivSMIfF20hzOiysUUuVirWKu5jx0k0TIhI0s+QelWGAQZr7Umc?=
 =?iso-8859-1?Q?0MM7LEkJcH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09633e66-15e9-4351-6213-08d95cbcdbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 11:40:46.1224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5m2t/SFjRwCQWlePdk6FiyrencKT3lg2X9q+Q16i7fYO63T0qLV7WnsmNwfnn4e9ohe8lJq1TKmemXay/HIaRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5105
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
Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
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
