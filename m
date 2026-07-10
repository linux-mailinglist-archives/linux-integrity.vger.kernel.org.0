Return-Path: <linux-integrity+bounces-9907-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Wh8SAozQUGq25QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9907-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 12:59:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74840739EA9
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 12:59:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=HSe4zVYi;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9907-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9907-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1D653055439
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2026 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30B8411697;
	Fri, 10 Jul 2026 10:54:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012000.outbound.protection.outlook.com [52.101.126.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95944071FC;
	Fri, 10 Jul 2026 10:54:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680848; cv=fail; b=Vy0EbDjPoijfZrGi39w0NcmeGwdW5JJ/4FTuSLtLDaANVc8ln7k9DvaKpWrfs+oEtvNfoyX0aNLmqEPHySw95IxlLFnzIfoSMFAOtmBYx6v2VekSiLGP18xcb1PcYdUoYO7+gSW2J//8k0csGmeyNxpr/XLcpxSZ2hdP5S3647A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680848; c=relaxed/simple;
	bh=YH9WFb2x/MltxmV/bV/b0n41sq6OEkmsppTe5pi2wIk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VB0qyQgnP6RxTMBk/Lk2/iCncE1x+VmGXZbNa/455E1hud9gX+yFdRbvrjvgSDmjUsg/Fsrz91ndZclyjTX+qj8J6y5DetHigHKJuFWVRAmgtlM0HqHE/NZYMcybqR0yZWVv0ytNkHsfTg5ED6YEIdqj0KifeQtf/Uwz81jOh4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HSe4zVYi; arc=fail smtp.client-ip=52.101.126.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pH6u/MNKDQeOF6s58ueD3jzSl2L9Ou1BY4ItrAjImDIUj7iez4j5q3zt98lD+IRFlqXoH6PBxpXVL08ThpovbjDlvSBiUdKDSze0FfoRi9rMfzPrkiplb9J/C5WqDwm3UbU/W/cypf68KZGSBeo4UQM63wn8TeJvVIDDleMloRRE6X4k+btR9/1n+PpZ6EW8KEQgDRWRJpP/f98HUhxC+ys0lgZqWlW08AZ1vQ6tWRVG+hlqH1HX/fzi5fTYDQN8JgxWbrX32kkGuU1CRlcenfCUyWNSAr9MIXSiE/OHVvbJW+9DR3v0yD76xul35kMEwHlK+4UgAaKqtMo0P1mXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4DEigpiyrlFxcUmRo16+xR6jEtg5yDwqbvSd2rqdgg=;
 b=tLTWcxGZcZUhx6D484wDkXgQogkiDsLqvPvLWZfCvwycTnfIucn7ggjzTDEFAPsOwAd81ZQ7bugYNYMD5TrBfZHGakiJziVvEuOocLB+W4K0jSbD0NQVBVD92L/07bezP+mSyrnS/ckaDFsNiOP2sgRi+Fx0jbQu+9qCOx0JY0HU9P78ylkc4Y14OFXtrKuuiN1GSqN0O8rIMOQNibJsh77r31rdgHbavaUX99XPg7LsOMUiFBpRxutd66qzHJv2+du1cHr905roSI7fuiPWt5FHvwG9H2P09R4WnctOcFlF2wz9sV2u/xTN8s8eWVYhkTaQtmNwcOLBIm41wEgqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4DEigpiyrlFxcUmRo16+xR6jEtg5yDwqbvSd2rqdgg=;
 b=HSe4zVYirlRs0YUWx+lsXdGMWzR/fHA+9NfwjkKS+juB1rSZgPnaxjbkXAoiT/DO9OsCYNTWKKvMHa2ARIN+ZRVlZiP96xyPrnelfRwCFB8BEG29+uLfsCln3d8nhEVIByCzv235pVW2L2yrEeEVVcyI2rO46JKwNdCBk4e6V7Q0bc/vZ2tuo0tCS+bebS4DKMnNy0nzuCLrMIacSBd1fiUeiVkHFHmTPhkxMbZKmG3wSPFJIZNa7KSZzK6Oe0mjvCd0nwbmDgudShRNMu+lvd+xgIZ7wRa0w10DABbEErxhVvAiHt7dvrFC4zKPWhDfJt/g6LbCU5NOGPiNwMLSsg==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KU4PR06MB8388.apcprd06.prod.outlook.com (2603:1096:d10:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:53:59 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:53:59 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Alper Ak <alperyasinak1@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] tpm: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 18:53:07 +0800
Message-Id: <20260710105318.376496-3-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710105318.376496-1-panchuang@vivo.com>
References: <20260710105318.376496-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0021.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::12) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KU4PR06MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: f72f5094-c67a-4e9e-331d-08dede718ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|11063799006|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HPM6K2RjhOkggsq6Y8zEMtdxZgLEsWSWdzJoRppWqdHunFER7Ux0j/EsEXPGODMQQOu/8QozJOcLTwK2JDJo66M1guDhhiln7amR5/699kGjubUL0R7mJKBIks9IC9CpfVlkYuyrcwj9NY0cCV/S5S2HzSNzWMkVjEgqbw0n5J0dMeggW5Lk8a1/XkwMta9qjuJF4GvtYUt/UL72KI3q1RIfXW2G4F/qH1hFkiIFVFXmMaSODFukX/Qu61ksjU6+r2TFLXjQhwRA4vn0rTNqqJ/K9IZaIchTAlKIFELrAx1COshp38Va5ttosx1wm5XTIDwp3MRKzXtyQe5rmRe32ylcm0DUFXxl7l0dSHgV9VMfd+GQ3lf2O5Guovpba+bnmEINViRfdZbhtI1ylIa5zeWhgcMVdhUPtFdCxpGGaLBKdI+S+Dd+ax9Pcmj0dHJzUgGLwjqSNkKKMJD4b0gorGhoY9+xphZEbM+q7zXsHYjBtpXFNPCcD7Ewaqh0HKx3LNnKqCPcsWwdAy6Ze5xDt0ezUV5sZFN0oYtDiAGLPxHfZ7vWY4thZ2bjihJ/Sy8C7y36Ng2hGG68pZ8Q4z8HehInjkgErxAPQRcyFgGCT8QUjvf850erZk5c5hj81wxthdmT6hl/m58jUxs7VsXvruKoaDsZdr0WzOkqWssrJ0xU21/30wxYAAAFpEp/JQ+gnoys51mnog56GIXbzG/oNfhsrEglLI3XmtiBNOD3jZk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqbGfDj6GM50B8QoqMzbrHZTF2U4eegB0fRK4ctaS1bgDgYZF8BUYgBf1mZv?=
 =?us-ascii?Q?ZiRiQ8zvhsZKp6MxGXjo9cUsltG7O/quJcoejpi9z6ke7fHlChVxFucFTWSy?=
 =?us-ascii?Q?+nHcpLRe+gDEfT95iL1O2NMdxV8G9tmeeNGZ6FwywBn4aGnwbjhzg16NBHWV?=
 =?us-ascii?Q?na5wKzMt+TZyR7/R5cWGUNXanpWvYBbj9KTkGhSJv9+RFYAPeoYaj+uWmTGL?=
 =?us-ascii?Q?ECHIx2uha4/Ikg4lyGlf5UwcQsv+QIuxwaAA5/hrOMtIt4kWeTsr2gam9tVm?=
 =?us-ascii?Q?TVaFk66Ym3QiuVx27ErBNKEN4E8mpfYRUdaO6vANS5VzBZPWb5Wdsf8A1MMT?=
 =?us-ascii?Q?DozL8yg1P/Nf0douuPKzXHCQP8nd2BF9tZBfehEp/6kCFKETUJEN4pG1o50a?=
 =?us-ascii?Q?GiHjrMH8cJMuXIUfr5INB3HbPTVuantAXZfgvi3b9ijA+oTt+67CmJe8liMA?=
 =?us-ascii?Q?CFvpQnISK0k2ERUiRrZW8qy9ATPMaW8+EkbLvoeSsylr8HKNuoYjJmOJD8F9?=
 =?us-ascii?Q?icneKLVN7UH0cOPGVgX/KL6C1MIRQ5ajmlw1hN5Ccjo5IEolghSPIVlMN6u+?=
 =?us-ascii?Q?IjNwFusYLZn1FE6oRQFkQuWPfeqWsDA/euxygWVoabRq/td67DU7iSk3vlso?=
 =?us-ascii?Q?XkLBlzobHYfmU37m2J6pvtwfWl3VnCFAzbjPCNx3osGujMPnXBUbVsUN2a/S?=
 =?us-ascii?Q?fyHsVHjlKG0y0quNoo1prJ5gzCpRlMjfpO8kyC36xb9L2XoJ3P1rWyyRmvmT?=
 =?us-ascii?Q?wp15tB0tGSUBVujYcUW7zIPmsJt/OjY+rWqkjxZ9l1wRMCiDLN7/UAJ6cOV4?=
 =?us-ascii?Q?3CVy8PnJoCOseHGUsKAeSwYkRwV9T/EMIq1S1YBGJRPLCPLh80t3OBeeN8vc?=
 =?us-ascii?Q?cmKCDKp5bEolHOr80EgL2pZp6Po4n/AXkeQiO7TrEidtaZphYniF3bJgw+/z?=
 =?us-ascii?Q?HufggxwMEK07aVjQAWzkckXzsw33FFzYfOAlPfrxfdsmQx6vh+sEl4z9XSHI?=
 =?us-ascii?Q?japKxProuiEwEE4gwTJYbHsazOolzhpI1X3rzF/zKqtFlz46yfS3d6fAC4lF?=
 =?us-ascii?Q?qhQJpMtc0mskz9EB8LbcS4Nx2buVomv9lIc7g0ZQEAi/h6hsRD6WOTkjaomQ?=
 =?us-ascii?Q?Xt8WFppcIvSxaCJateb6gVmavCQCJ52PNP2Q1rlCQo0+q3vRuJwXsej7BuPV?=
 =?us-ascii?Q?wooRfwQx5Q94cYDs0qv3NQwObgiAdKYE/9WjOOms84oNv6Y10iqA/Erf9dir?=
 =?us-ascii?Q?4LkNiGCEUiHoJZpAWyny5uJofcZ3rPJD5hXO91Kmt6zkPHcMZ6/A0xdCjyGY?=
 =?us-ascii?Q?buD1Uno94Wi+9FIYKOU0sIfystFI3T3s0FpufXLF8vG73s4kcFtU7CxV3b1+?=
 =?us-ascii?Q?VV68YmW377lwvCTVSW2yKEi8scthBL/bKUCwO2+HgiL4Nm/YU6q+NVtuEMwx?=
 =?us-ascii?Q?5QaFB8286Sg8vVsUGvF5R34BAJ+DR8UPfVGR1thtGdMKKfZUsJh+l0Bvq4eq?=
 =?us-ascii?Q?2ytBUX33R8enDG0he5vkrasdgZ9dheY9HCrz/n/BpAimiVHbNjclrUb31vWP?=
 =?us-ascii?Q?OPC37cwwWYV/bGPYtXLweFzESkxCdXT+G86NbCn19kS9TVdQucsQPiEtp8tc?=
 =?us-ascii?Q?MTbgzhTsyi/F7e3hbgS79X11jzCLUH1IMyhk3UNkKAiWR3M0bhU/fWx9VV9S?=
 =?us-ascii?Q?/SmXSPnJZjfWF4sgWjBAASL/kG8qOPYrfUs3vUuXhUKZLgqcoiO7L2IJ5hQZ?=
 =?us-ascii?Q?/X6L7JDqng=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f5094-c67a-4e9e-331d-08dede718ba0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:53:58.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaqDIYbXDD00tkdINPt7N3XE0gWaPbu4UcrwSrbiX5/35cujoHoy3AwAS4m6hy4624+85x3bN/0t895fDyfBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8388
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9907-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,linux-integrity@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,redhat.com,gmail.com,vivo.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:peterhuewe@gmx.de,m:jarkko@kernel.org,m:jgg@ziepe.ca,m:sgarzare@redhat.com,m:alperyasinak1@gmail.com,m:panchuang@vivo.com,m:linux-integrity@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74840739EA9

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 5 +----
 drivers/char/tpm/tpm_i2c_nuvoton.c   | 2 --
 drivers/char/tpm/tpm_tis_i2c_cr50.c  | 4 +---
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index e2b7451ea7cc..8d5179367eac 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -506,11 +506,8 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 		ret = devm_request_irq(dev, irq, tpm_ioserirq_handler,
 				IRQF_TRIGGER_HIGH, "TPM SERIRQ management",
 				chip);
-		if (ret < 0) {
-			dev_err(&chip->dev, "TPM SERIRQ signals %d not available\n",
-				irq);
+		if (ret < 0)
 			goto _tpm_clean_answer;
-		}
 
 		intmask |= TPM_INTF_CMD_READY_INT
 			|  TPM_INTF_STS_VALID_INT
diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index aa3673002f3a..c84afb29d548 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -576,8 +576,6 @@ static int i2c_nuvoton_probe(struct i2c_client *client)
 				      dev_name(&chip->dev),
 				      chip);
 		if (rc) {
-			dev_err(dev, "%s() Unable to request irq: %d for use\n",
-				__func__, priv->irq);
 			priv->irq = 0;
 		} else {
 			chip->flags |= TPM_CHIP_FLAG_IRQ;
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
index b48cacacc066..7f828fae70d3 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -751,10 +751,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
 		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
 				      IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
 				      dev->driver->name, chip);
-		if (rc < 0) {
-			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
+		if (rc < 0)
 			return rc;
-		}
 
 		priv->irq = client->irq;
 	} else {
-- 
2.34.1


