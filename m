Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99003DFDD8
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Aug 2021 11:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbhHDJUc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Aug 2021 05:20:32 -0400
Received: from mail-am6eur05on2111.outbound.protection.outlook.com ([40.107.22.111]:20289
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237005AbhHDJU3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Aug 2021 05:20:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka/w+rrOmLOwFbEl8qQQSFOLYa0NLBjMtz2vMwlN3eiCgK+A4js8HemT+4Jen7fY/9bGbydChgZ69uKG8jhAX+49c60pRVNjQeVr9+GJcUgfY9NEOzuQXCp3XaXa6JhRtxBJAZW4GVSowo6HqyrJNeR+j4hDnT8FvbwZXHHICI+46kCvBSJkYkz9kBqPuOJWozM3ZFQoygExl8jZ51UoGCs6h0AZp8uVzOcfaNnj1KNQM/3B97ixS0ntROApQGV5CJ5AmxCxfSzDBn60nhsIkvghKN1vK4woz+lAjJfBC2I1V+fV65s8MSLsGq6qBm6KkCmqpecMInAPw4nDQqGDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n5Npiv4ACbKZv+BpBMYmzZfl0fM1Qfwe3CPqqbd+ik=;
 b=kNFGiXaqomVL1t6RfoYJAvGtxOvOj6s2XUhueBZfcvMni8e5v5o+EJAzWt6NkokPrNGhx1H6ksnu2JOWRtvzr9w899Co1mAC4R+B7miTJgV/K+XefQRdXlBxrNqugPaHWzmZexGpy+coJFy7GtNETuK0s/HgiB/i2rd94a1E4HwAx12KJRF7M4PDu+LwWyOdVaWKRmhuruK6SIUuAqPlU1dWT+W1tLfrnaf32TZr+Bp1XL+8HsbGprdUjGrodg62u3tuvM3AvPrI7jEUUg/wwE+iSYSM7nPizupwxphVo5U69jtoG6lBoUleNMNTFbSI+M0c5liaDmc2usLxEuZ2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9n5Npiv4ACbKZv+BpBMYmzZfl0fM1Qfwe3CPqqbd+ik=;
 b=H7IwtwdUp92sIBjlElON0WLEWR/DKyCFWIQyKgmVdxJHm2XnII1SJa2A1dEDh1sGfErPbKUEKTnfWeXJl+dj2uTQLK/xifwG3OvwJt1OhaHKmHDA+yPIGru7ZuUmkcfSvoPfLVy2iJgfqRlFYmCEs9tekHnGSPDLV2rvXSfJHjI=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM0PR09MB4244.eurprd09.prod.outlook.com
 (2603:10a6:208:181::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 09:20:16 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 09:20:15 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>
Subject: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Topic: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
Thread-Index: AQHXiRHvsKoLCmhItESAenpSj4tG+w==
Date:   Wed, 4 Aug 2021 09:20:15 +0000
Message-ID: <20210804092010.350372-3-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
In-Reply-To: <20210804092010.350372-1-simon.thoby@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16ddd842-ee84-479c-bca9-08d95729122d
x-ms-traffictypediagnostic: AM0PR09MB4244:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB4244A363469ECED664E5B1E594F19@AM0PR09MB4244.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sL+h8Awbqj5pMsHeDV+uS2hOmXw/SZKhOBRxUiQgvMPwHvv83FdakAiX2iPZ9OQfAypTOHH3+ewdVcNxbCDvckSt7QmsRqXtZil+uvhvLEfVzWqGjKpFsOh7Y16UqobVzVOvyYDE/vP2XR3Fybsda64SCvS86UwSdecrhXKrQ9z1FEsOc8laPUPsfVw247QnCmZB8/rha281lcVm2WkLyMtnZ1wLiT2PVsUg1rIWo5am4xxiHeSJJE7Cntm9jgfbK+b77CQBV5hrYed5zCwl8C3I2yNxsr/Ii3SPa7KoMJsZRcto5BIAE41WXmNQMz03wA4TMJPr2BHxBjNuqhNECsJynmxXWoXo+3TPeBb6hb/fJNGeYEuEgnIVix+PGNKzPXrvXtFpyG3cn+IGS73SuatlIhlWHLCUCyqKukyYPyoYptJxK7YDRiSAykEDQ84BxJEPw5fd+FCwtckIhAo76TBvKItnRI1ZnT9SIHGLgntxv9PozKo+P0he7kfPUz3quNPz+nDzhuFIw+ngGfgwEINYIZzOtAdj/yyyT8LI4CDIGaE/G5MjiFH6tFADkRzYjmaoqw2Tnmx8GifMV56EmxR0UqW/YNJDSBgAiFwLLDAbKCJptW4SSk0t9c37ZPplTPxoRTBaMEnaf5qAHtlBcOQHJGCgLfgxXxAn12mig10vGhYDAJ7YSe+79XwevuIGCKyXT4bUdajwuHWv8XF0YRJd3Ta/LHN70NmBoRZC5I8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39840400004)(366004)(86362001)(64756008)(6636002)(38100700002)(6486002)(71200400001)(478600001)(66446008)(110136005)(66556008)(107886003)(66946007)(15650500001)(66476007)(4326008)(38070700005)(316002)(36756003)(2906002)(122000001)(5660300002)(2616005)(186003)(8676002)(8936002)(91956017)(6512007)(76116006)(83380400001)(6506007)(1076003)(26005)(230434002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GDIpo1qM1vWht5y+cXf2ZSO5mdVEotKJkGwzieVQIRAq+vfQ2D2v4D6nBl?=
 =?iso-8859-1?Q?AaF5CzwSceth6yZBsmbogEKS23VueLcrpvp3gYa1HOeHunh+gnMz9FZ5tr?=
 =?iso-8859-1?Q?mGL6b0Zys54R5XhWuN7IGam2tBLY6k7WoPYw3XEALhBxTQ3HWPbBsQQfOm?=
 =?iso-8859-1?Q?9rK/6vwr1W/LXzBlbxwQnmJCmXzIMc4GjFxmQ3fU+CnkLaRHs1jl0Oxbs7?=
 =?iso-8859-1?Q?+YkuV3Htiipf6VVwVE4iW6BdjIOl1vpriG4wyHqP71MGTg6CpvSnuf6d4X?=
 =?iso-8859-1?Q?3jqot4etaPYvEcqJknUYXkHvT1nEZ80FWB4u1bsh69IB4i3GONNvtSfDBA?=
 =?iso-8859-1?Q?VQCFTWKbWMc9ysYavBrXmdYBEWu7nm8KofssshhLhtKfgD/MJWEBHlaicO?=
 =?iso-8859-1?Q?az/eONFkyvBar5Mf5+SaEMnbgb0SJ9+rneu1cNXdhLt+o3A+9gt/vGAEFD?=
 =?iso-8859-1?Q?eNe2teS+W7KndGbJAh3lI/mAH4IIh36k/whuv4Rr4g+QIS3jJQX2HJ9vJ7?=
 =?iso-8859-1?Q?EZa4JjHj4yhMuEjUhglqEIbJVWVEolRifngaMGvIBVgI0tS7kN6oWYuJpJ?=
 =?iso-8859-1?Q?3NmMzXGxQGdsbINEL9kdt1n228Q5c7rVesyJOi6midABc1HfJUY4DOFpMU?=
 =?iso-8859-1?Q?h40qkf2MpeJkzbjBH0+2Of56suFjV461+8tlmhIbJ0TD6CmJ+mxbWgkQJL?=
 =?iso-8859-1?Q?olbE8ASTl8/lz2IW9EB816azDu5ZFRAKcpyURGfPnJoYfGqV77jf7pd7sn?=
 =?iso-8859-1?Q?cf3iuNZG/50XUmDitXhiMqXJfCO5ZPuD2H3rXuRtctiKl/Jc+xcDmHGLHw?=
 =?iso-8859-1?Q?9+pmAO0lnL3zJ62eQILr2F9f6pZ3H0PXHiQz6+K5w/2wrQlpQg5I1S1cKL?=
 =?iso-8859-1?Q?H5KN60Cs2Omn6DDb0MuCReVYahMdVF41QQgyJeJrMIaahTfDvnUxdaOj3b?=
 =?iso-8859-1?Q?m4w4quQbmiO7xLs7PPjF6uohJtOvTcGRMlYYTc0bKZFggbCPJTBS9fwdHg?=
 =?iso-8859-1?Q?LMn595ELcDKlwoshVssW+O3qCij99DDw6z3TjtdpPB5yr68hZ7jcs4xQ4B?=
 =?iso-8859-1?Q?hneP6ypROYqYY55CNpUTZlIaiIoJoDfQ43SEYo1dV3pavPbPMdzhFeeqiS?=
 =?iso-8859-1?Q?2DzkaA/UfKo6Iu2XtEJDDuSrvBomTorXLcMTNamnekaZwrMjIdY4/lmApz?=
 =?iso-8859-1?Q?oO5151EMOxBH+6LtpgGcGbxWZMdGrU0n2XYD59wVvZjyHZKMqq9pVNdO7i?=
 =?iso-8859-1?Q?nUE7XX6NKMmGYSFzoP306MXrZHjRW68Q2Gzns3Wx7/vyAhvqhxQELXmM5q?=
 =?iso-8859-1?Q?An0PPUQ54yzHf/xFG54L/2APDCuAW/6o7c7GxqBh0JptCv1T5O/oZ1LU/R?=
 =?iso-8859-1?Q?olrLS5bA91?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ddd842-ee84-479c-bca9-08d95729122d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 09:20:15.9548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WXvxwW9eboFbX1pdDxGGfPWEL38kWvr20YbXzLdehKaj9M3EWI1AxktK7Dd7R1zbTwR7qBAzrSGqRQGM+4/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4244
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

By default, writes to the extended attributes security.ima will be
allowed even if the hash algorithm used for the xattr is not compiled
in the kernel (which does not make sense because the kernel would not
be able to appraise that file as it lacks support for validating the
hash).

Prevent writes to the security.ima xattr if the hash algorithm used is
not available in the current kernel. Lo an audit message if such an
operation is attempted.

Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
---
 security/integrity/ima/ima.h          |  2 +-
 security/integrity/ima/ima_appraise.c | 49 ++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 2 deletions(-)

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
index 63bec42c353f..ed1a98f6ee19 100644
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
@@ -575,6 +575,51 @@ static void ima_reset_appraise_flags(struct inode *ino=
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
+				   const struct evm_ima_xattr_data *xattr_value,
+				   size_t xattr_value_len)
+{
+	int result =3D 0;
+	char *path =3D NULL, *pathbuf =3D NULL;
+	enum hash_algo xattr_hash_algo;
+
+	xattr_hash_algo =3D ima_get_hash_algo(xattr_value, xattr_value_len);
+
+	if (likely(xattr_hash_algo =3D=3D ima_hash_algo ||
+		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
+		return result;
+
+	result =3D -EACCES;
+
+	pathbuf =3D kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathbuf)
+		return result;
+
+	path =3D dentry_path(dentry, pathbuf, PATH_MAX);
+
+	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
+			    "collect_data", "unavailable-hash-algorithm",
+			    result, 0);
+
+	kfree(pathbuf);
+
+	return result;
+}
+
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len)
 {
@@ -595,6 +640,8 @@ int ima_inode_setxattr(struct dentry *dentry, const cha=
r *xattr_name,
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result =3D=3D 1)
 			result =3D 0;
+
+		result =3D validate_hash_algo(dentry, xvalue, xattr_value_len);
 	}
 	return result;
 }
--=20
2.31.1
