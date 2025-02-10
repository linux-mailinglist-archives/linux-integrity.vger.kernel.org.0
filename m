Return-Path: <linux-integrity+bounces-4762-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB02A2EBC6
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 12:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A70518802F0
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27C51FECA4;
	Mon, 10 Feb 2025 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VnjQIViA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBC1F3FD9;
	Mon, 10 Feb 2025 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188012; cv=fail; b=p1i8UInc298o52vnWA0PEnvg+rlZoDbl+n8UYEtM7vOsyhuAm7mDlqOB6cRhyJJXD5dsQBOlwqL0rd3vqZdqe/fhnGcOlockkk9ululnIlE0PmHOkPVgMgCamVhM1oqmz1g2mtKeDcxWzBZ/vwoA7MpFy3hNLjDHXCs0BDoGoX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188012; c=relaxed/simple;
	bh=Aau5h3knKHa17bKlf5qQfTEK6JU12fukXhEY6d4i3zs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LXtzRvfxSKixJkyiZVrZnYBboRX/4kr4OaUVTHzzlKO5dKy/W2TaxDwL1dlhcGleNj3mdPaUTu/hbSfcULCEPsMbJhEGwYdcrydxrpIvTXprLJ6wv4uF8UGKSf9v3ngq2NXeBcwzkjMC5IvBUib1BgRbUJuqMlI8cM/AvG4Z+2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VnjQIViA; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrtLM2gpva7saoZFQDvjXxb4yxwm2rBPcWEx9WaixOtSaakWNt0bKmzQLWYPTedifTunkBMLgf65R/5o48oP6MI1xM29bj9uaMSa8RbPq4s3wFcUC6JrohZqIBhX88LYdFbxXqYK5CQe33O52mCuJkDFTecFvJZZFwzXkpT1gAB+ZO6AKmA5ss2O6YtVWCMOue0xE+Vo/inHDKAQBTGr/QwXxxYptHe+0cIm7HOsokpovCVzSYllMRUfz1Ew1hdl3V56h1yAUV+70khKhypyylFPA7UjbHz7HES6ZNh/nw2xS6V1mVJkftXOwZAY665+9dhptw2kpKD/xrquZJ9GJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T06sLd6s6+tCaP2Zc4+9Oxzeb97Awl2Q3AKTlziGPoM=;
 b=Wy+qEhy6phM37fwi9TjsZppZreOWt/4nraa/SX2ha6IFQVRrKe85q6WS3QUvQzMIEuCFs6itYBpHrQJTvFGTrRt3fwu39BtD2AzQB9jjJ8PvtcnkUw0ZcxXXo5+JFPIWdTbmIgDeVENz2T0N3zMahXmOxGXV8ZrYW99ZxxpbcsPwIiqHkndyMFvCQiuoNRBdnwAHJFusoNaHa7YkGNCrG7mDYTDZ9fXjV6Jd4OnwFLw/BYgGK6wHEVmVu7a0Lidx6p02oEYCCzBMlTc8NQWZyRdSqhqawLshB9dTQqFwWepH9Ic1y2lZlqmkF69qQd8hd/N/058rhHkacYlKw3Y0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T06sLd6s6+tCaP2Zc4+9Oxzeb97Awl2Q3AKTlziGPoM=;
 b=VnjQIViA5iOabajw/v017L+xR5Hq0PUhV3L3DmNCC0wDGMii/4nF+eqUA76O4vJkFBTpMnvRz+Vrn7qF4aBCRsv+9w0n1SiS14dhBSrpi6hbUWpV/Goev+m6nZWymOTHLHxhnXS9cpJC7ImFlGFn6nTVxB0Kd9wt2tRArmws6rsTuTNXnarKCitvIuRcosEtZLo/s2sGGnA0VSwaAQRQcnC8N86wotfzc5V7SQZu7aVYY6rewAdyNDWXK/dVD/hbrO3H219f2/sNn5aPpjvpAFA0JNSvJgcXVwJ5HAsd3VwCxU2RSaZk5C7Im66v3Bbhsve72f2TnmJ2d3eZB91Tiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3047.eurprd04.prod.outlook.com (2603:10a6:6:a::30) by
 VI2PR04MB10716.eurprd04.prod.outlook.com (2603:10a6:800:270::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Mon, 10 Feb
 2025 11:46:47 +0000
Received: from DB6PR04MB3047.eurprd04.prod.outlook.com
 ([fe80::3bf3:61cb:2bf:5c14]) by DB6PR04MB3047.eurprd04.prod.outlook.com
 ([fe80::3bf3:61cb:2bf:5c14%5]) with mapi id 15.20.8398.025; Mon, 10 Feb 2025
 11:46:47 +0000
From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
To: David Gstir <david@sigma-star.at>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	SCE_Linux_Security_team@msteams.nxp.com
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject: [PATCH v1] trusted_dcp.c: Do not return in case of non-secure mode
Date: Mon, 10 Feb 2025 12:46:06 +0100
Message-Id: <20250210114606.1593650-1-kshitiz.varshney@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::10) To DB6PR04MB3047.eurprd04.prod.outlook.com
 (2603:10a6:6:a::30)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3047:EE_|VI2PR04MB10716:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ca59e4-bca4-4d73-664b-08dd49c89918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzCTzYU3444S1B2eNEh3Tyntd1OcpY6raGnPfT4hV93LZsqUScGNwLXO1Vfd?=
 =?us-ascii?Q?iN2EkE7uT/LOCtBmLdMID0qOaHSu7RuRl1L11JAS2IFroXYzHvxeFkOxFSmM?=
 =?us-ascii?Q?Lt8AZY1Sbl+AON5qp1/pm+2/X8vchu0V1N/pTJx+F+McRwgdHvyS9nWW4bGy?=
 =?us-ascii?Q?WXwewTIi0TQo3JYwjV6fMMKOjgeU1RUbvzN8CjWZcMx2bbtNiA8uHNVKPdx1?=
 =?us-ascii?Q?xi17lfKi1TK+F+dNp72x/LfU9dm87XawLBKEnp5C58LTD89sSJrOyblNGncq?=
 =?us-ascii?Q?Aq8alN+baaPteHg192isn9CAwidlllC8BokUtXlXVa0AFm72UfoRPjDNOR1N?=
 =?us-ascii?Q?JUGKEG7ibu4rwouzZvEA/qntAYh0MZyFEIhZBzd30KeujLbVEDdeZHL/ro0C?=
 =?us-ascii?Q?xYB4jLxN5VBvPZKmjvKVgNTicsvhs8sQ3hueVRFqRoKo5n8G8dEo336Neuqa?=
 =?us-ascii?Q?tr3jnKt+imO+qH9hUtuwJ5JHi5UHIR5kTlVuurUbPZOLyOI1m/V5n6rKuUeh?=
 =?us-ascii?Q?LdVVgZJRpn58U3PupSv2dmfx5gvJXA8dI8ILoDADJ6VLBzx3obfkJcUxy3B5?=
 =?us-ascii?Q?blzYXSbyTWfHrarhHeiB4YPYLijvo8nQ6WzjSrVntqshY7cEXFiXB08FgiB3?=
 =?us-ascii?Q?tZbk2DxUgfrq4aon7UvTGj3OHAbZ8WgBaxFQYTc6XyimAAMiV7AYAeQhj9u1?=
 =?us-ascii?Q?O8TR0GdMR7+JyGyCL6L/G6Yq8l1srIsTSBnp30g8MZVVGDJ1ctdKJAvxTEsj?=
 =?us-ascii?Q?gw2HXHBpNALWrrh8WmN/6sdW6BI00TS1pOdCDo3KLXSdBGcnWfuiz0QpiS9H?=
 =?us-ascii?Q?+o6mP8EuExETl/tPHES/ZvFYpnzRpPBJIS4BijjRzybkLVPHWCIcJw/B5jLG?=
 =?us-ascii?Q?PX07Ss+bMIW6lPnFrmKPbh/jT45Y864mJIPWsa1ZGP3E60WuqaZsttXPWwcP?=
 =?us-ascii?Q?QkE5M9QESIXr8NRTxmSNqzksthRzHsYfopYbw7Rr4CCQVV5ISSNisvvoap9P?=
 =?us-ascii?Q?nZbu12M0JM+MsPKGLgOqUYARpSNUrjB7LZLT4C0w4m4AGhBgYvWiMiu/RjCb?=
 =?us-ascii?Q?hDN2fqkSHHUVIQtAYYbEnKoqVaPw1amSbuDkrxcTUaSd3fTnGy3PfU+r93tS?=
 =?us-ascii?Q?1iM+95DH/O1umfxmsj4sgaeIUtkyBluUTqskXHqDVQBN5D3XMiWUXSVCe935?=
 =?us-ascii?Q?0cX+rMsix+j/3hePmq4aEtDqKdFlrC+M8yAJ7wZ0O0lE9TBVkmL2iy7obVIJ?=
 =?us-ascii?Q?tOjs+Xy4+8zguHf1flTGwZCVbKcgRbdeBItPqtvyCJoAtExdbY0Q9IS3HO08?=
 =?us-ascii?Q?8f1rZryKhBqM0+1fAIfIz+KEhf+FgzzqqA3OmHike9aePu9f4k9gihvlvqz/?=
 =?us-ascii?Q?nkShGpfjcZE3wzmxc0FLu62yl7zt6nyC3yiTTbx5keOHdIfEqxSHkzG0ymK7?=
 =?us-ascii?Q?1sKnX5UCk4bTTMh3hQFC4a9yuvkwj+VmA9Es1HAh3gKrMiPihiSzDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3047.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyKm9vrgSr1ELNzg5uNnHzW9kIN4KtUXuuRerbNgGPtI7SAwY1vJsBr2GpVK?=
 =?us-ascii?Q?hNdp4x5dsSN+P/mu1rUPkeqXEhhphhEZR/cRPi/2UvM1FFOPIAZ3gqN5z7Px?=
 =?us-ascii?Q?hrJn3cScYoYe6agE6zsKmt6B6TbIX+Uxf8zY4Pm02RHmYoY9F86GavWNaMaQ?=
 =?us-ascii?Q?9MhJ5kuSQSqY25EKAZs18VahTPoxDvQMg9VEmsiskZRkRz7MTSjFWsbdOAea?=
 =?us-ascii?Q?IWimaVw0JM1KecGk7NjD6TZZfj2bcfJagubQNbUUjUrkp9yh7HARfMMQew95?=
 =?us-ascii?Q?z9yc4YsncguefrLy4c6q/QTABfIV07uyQVHRPC04aaTY1OWAHOAdFxMaxDdT?=
 =?us-ascii?Q?eJnOzXQqtQUL/8BraT4zZ/9ZaNZBiBWm5H6mRhg4uRxfcRfYK5C+NFlgEBB2?=
 =?us-ascii?Q?LFmWCUoYclz08zeD5sFis34gFFjo7Ts1SeeQNrMONvCedVuDNqi56lbPR+VV?=
 =?us-ascii?Q?sSMdatpbcGgumkjyWjoGOk+rCKz3OM/tEKtC+U4ytA1hlmA+fYNeRIyzZrIf?=
 =?us-ascii?Q?u0ycDWLWRgZ7D/SCpsJ0tZY2nqC4wt2E/HaX+GfOwaEt30LAaU2D/RcURRd4?=
 =?us-ascii?Q?XkyYfUc8jW/DmVtcHKyUd+dBLaUjwVBiIAW8L7+JDVHuQKpOQwahMVA3RY3h?=
 =?us-ascii?Q?gGe4G4CRS7KDUj/cENvAiCa1DFkXQk11enuvepMUwCtUhJTooovGiYE9rdTe?=
 =?us-ascii?Q?QxviI1HUHbscN/U4gH34ipBgwLhDKS3E0EGcZ5q2PoTnVGwiSetEZzT8v252?=
 =?us-ascii?Q?r4OlPOR2Lr6bUqh54Qh4gy3LAAPwMcIYHyYpnqe7nQLp5153bYFLf4NMgqej?=
 =?us-ascii?Q?8rtbOhqRY1Tb5xpORXAY3SGA58KWBr0IZdO6gFqczeqxQRK4H3bnD+ciYCz7?=
 =?us-ascii?Q?PegfugvYV3Z3ZCX3CVHm4wfI1z2ZPHdxCWfpu+UE0QgnOIKHZ5irwtC/QWbk?=
 =?us-ascii?Q?OFKuwI3PyrJ7tvws3XlGTv/wziJmVt7kaScv5kAaUttihL8evHj9r/wqzBpO?=
 =?us-ascii?Q?8P9EO4sXwAS+Ii4DK4BSBj/tqjj9SX6ZPAQklfIDAKehr4SisH7VKtbSi/mk?=
 =?us-ascii?Q?va3duH+sEY78wMPQcYA0cpeMRLkQELAkLetHdYynvNnSFWx69oIiBRi5ogul?=
 =?us-ascii?Q?SkJtuf8CVAwei1okjIWaBl94WEkDlN9uBcWgANLty7SWZsBhfEARntYSiCBg?=
 =?us-ascii?Q?KLykJPkiz+OfYWEphlu7fUtJFZNzWYJDNW7eYkx9eRD098M0TVmzk3oYmqUm?=
 =?us-ascii?Q?frdp7LBIY19552oPiwoMPh4qW5+fRdhY1GaWwuY0dJrAnPN8yHKRvlcVm4xm?=
 =?us-ascii?Q?q/VTqne02CdFgII5Im7ylOuKg4j3+e22FhH23DbowXvwxnGobFHFrwPJChAY?=
 =?us-ascii?Q?Weo+fVIZV2NL7RCmOtkmqKKXK2b4MjHZvKZ9a1KUkjWzI2iXKeI1v5Xfeslc?=
 =?us-ascii?Q?QI9ynnQzBI9od6i9dG69EXkonAFh7UG40QBKAVUHbxcu1CJ1ObuVRB7vH8kF?=
 =?us-ascii?Q?jCIrTNVGGKL8Qsdltfiv9R3rJLekS4b5sYstW+RVoRueNLzxDuI4p6iXRHoK?=
 =?us-ascii?Q?vExMlGp5rfX7AgCWULX1+r1DFAs+cmgNTbFL4P4q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ca59e4-bca4-4d73-664b-08dd49c89918
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3047.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 11:46:47.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOcQIG7CBhYsgH2O8s6LwGNYJ6wz5gO+6L9OqCkfyzwWLF8FcGfuqOfOU9rRWdSYEw4Isl89mJEm05zyWjtBnR3XAA/mCxNKsV/GRF5+meQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10716

There are multiple type of keys in different worlds, like
test key in case of non-secure world and OTP, unique key
in case of secure world.
So, instead of returning with an error, in case of test key, we
should display warning to the user and allow the user to run the
trusted key functionality with test key.

Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
---
 security/keys/trusted-keys/trusted_dcp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index e908c53a803c..99c9f9619f4f 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -319,11 +319,8 @@ static int trusted_dcp_init(void)
 		pr_info("Using DCP OTP key\n");
 
 	ret = test_for_zero_key();
-	if (ret) {
-		pr_warn("Test for zero'ed keys failed: %i\n", ret);
-
-		return -EINVAL;
-	}
+	if (ret)
+		pr_warn("Using insecure test key, enable HAB to use unique device key!\n");
 
 	return register_key_type(&key_type_trusted);
 }
-- 
2.25.1


