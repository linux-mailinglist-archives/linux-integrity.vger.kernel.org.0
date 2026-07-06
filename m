Return-Path: <linux-integrity+bounces-9886-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5usNzW9S2rcZQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9886-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 16:35:33 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79F71209B
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Jul 2026 16:35:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=e50HneG3;
	dmarc=pass (policy=quarantine) header.from=polito.it;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9886-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9886-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4049E3734057
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jul 2026 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE59842087C;
	Mon,  6 Jul 2026 12:59:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023073.outbound.protection.outlook.com [40.107.159.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACD420865
	for <linux-integrity@vger.kernel.org>; Mon,  6 Jul 2026 12:59:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342752; cv=fail; b=HwxLpKJAAg2xOV3jU6J+AmfeBgjoFGCNorFLvTaRuAELtYkQLYHu4UfXrjCVFvyS8hMnO9eZvB588eIHf8HDHYbS/EXKM4+tbNWKJZ0zjLY6x71fNUmod8ysYWIKJ83MZ3IXg31SmVpzGwJWsiDXRk2rie6+EkWqFQ3rMMcQP/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342752; c=relaxed/simple;
	bh=K4umRQJ9gMm/RAw/z4+Gu8uqtQCAUaEwWQSloxHnGOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LfC89sjp3m6ZFS+QVOsikDjgJrKfcfzj40Cv1Qib0rix+JdJaBUTD45Dg7w3hdboaGZdxTPdcCGYEdmXNH4ZFcdWvd/mPrqoyodZcEkyB45vYXZEMwZMo293anzky6YUebEIHIQcv3M0v0V+JUizALiSEhtYvG6RBzQ4JmWLCuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=e50HneG3; arc=fail smtp.client-ip=40.107.159.73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzO62qx8tj4PZTFy6OXt0TeCnfp473F3+YKgTNr5Yf6v+8hRB/lVYsLx3IGQz+lttdm7G9UwZZ+F+XFu0Yua7V0VkBhPJse5Fhp6XkSf3V2a/1TKvrCGTfxBc6ipBBC/RFhr8gqZEZLNlLGESgf9v49USlVp7b1JmbHCf6NL2B8afxrnGsZCt3yG0UwLERI0eSd1GZisskahKfSWAZ01cQxUYUU34BPDkRxee5Y8hMykjlTk0xKbMSz4KEq0zIJsOVXg2HkXvO6zyLRuzWIuu96xkUaP0Ra6BYTffryAZL4K3FsR/WfhktMeX6iBOMgAGNGHurHFx3YF7W4idEQYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8ALnRazLBALTn4zm7qqaFPG51jAMRonHoLeIl63VtY=;
 b=i2gQU3JFDkXvXp4yfu1lpVRyDh/OjpyT8XCjV3E9Q6IO+fIIp5MhHVo+qT4dJ4M321bRcSmNNvfoV6Upu/v8yzci2fR+vUZlJKC0LYFG5AXtuIHU16sHZ0wmNCd8yDrgdanZx+BpP93QFT9Rd3Kzq8d2ZlObTJp6BLgyMAs3jZie8/uO6+o94GGr+2vhGtChPVrCEevsj1YEmJhB+M4UhNZ36AByuTKAqYXLLCDCRih22C19+IjrFPyj4uTQ03/0gw4poWE5E7ges9mhGm+GEW5fi/GdnQXkv4l0b5Qt+dZ2KlAndRvBe4wsOyTYKQmUXqYxEayNJFawo4reLdRLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8ALnRazLBALTn4zm7qqaFPG51jAMRonHoLeIl63VtY=;
 b=e50HneG3lp5MUF7aCjNRUqvVHi4Q+GD/Z6xNxpHp5ClX1msbNtNOqUdQAyNhOnaXZQx8OxCGHW3Xb3HQ1RkoGW/DrJZaqIY+K4IJAzxNdAIASdVIOUhdJggZHa09wP8kNxvT/9TP59nGK0cDe02zgAiRB9N+74EjSt2hU/c5xKw=
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AM9PR05MB7762.eurprd05.prod.outlook.com (2603:10a6:20b:2c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 12:59:06 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 12:59:05 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH v2] ima: correctly recover number of violations after kexec
Date: Mon,  6 Jul 2026 14:44:55 +0200
Message-Id: <20260706124454.165706-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::12) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AM9PR05MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: b98f5f83-7230-402d-7244-08dedb5e5c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|1800799024|376014|23010399003|366016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+aQvzhJawixFP1oe/byjoqFWAyJqq9ZUioBYamH4rcmDHLhPsfMEPNSLh31eSw3k5v4Gornahm9/5ykURTILezOl3k+jNAS7NTwt6gvq2LY5HX/TbR+9I2gcSsjgvBIigVA95f+wfWqCHyIYCNMB8uQx96daqrfaqEVwKMYv7aJS54yN2dILDdHZumt2iuLX36sprEpP1XDroKe/5+AjoTc+srIeqwQaE8uNswI2pgppp1ENJ4Fv3RNh90CDPvs91k24rwdS8kZw5idURq6d2UGrO93JbWItZSP1JADfOdDsqhS+ouJRuajyqVPgP4hKS2Xi7tpFhuUB7J+cBiHz09DXtVBEG2BeO91js+vXP9JhN8TP7KRrSTzqPbKtTALQX/f9dvFLdfX8nv/t/mArTDLHWizytQQvFZIY7VEYwGkshXj6/SHB63JO1vCMxgFwayChAfnbulY0DVHZAMXSbeCEYr7jOvTrH4JdgF2GjSLUCgXTi3SrmAzk2u2TqxRbtKcP4pQzXeTExxz+YjOvTiMzHVQaMoOuS1mRHFMnOkzk8a1TuHbgFzFTBWZV40iZnTf3w4Tb/myNAu2voaNcHB8qnGD1tJoPR70/cE98RAgGmzZ+UOvw/y/11NdrrFr/4BWOB38HwgOoKTatUUS3/g3MaFiE8+TOHEXJiT3wliE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(376014)(23010399003)(366016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7GbL7j4TPT0CjusjiIRkYvqBcM0eg3c7G6KpERFYQXMhpeiKsHBx0BYsHIFO?=
 =?us-ascii?Q?C6JMiI/owiCYbfJXwVNd/rZAfrmmvUCr1rdzFH/Be3I9hhvm/OGdXYGlgjjc?=
 =?us-ascii?Q?59Z1eNnXqujDyPoeYfl9h3I17LXQAzwA2LsvGXDhUyBvSHffNjB1XAszRKAM?=
 =?us-ascii?Q?x3Kjc3Yo9txeBw7gydMdkC9p+tmZpg3yZGX/+5G2LctcewDh0ESCbSOihGX1?=
 =?us-ascii?Q?fkgcCOUdifJES/qFW5XwKKP+pAyduAzW2gbdOOyWYhnCRB0FMiV2GacLeY3t?=
 =?us-ascii?Q?YgQeDjOLSEKbcUr0SI9Khndo3nJtcBPXbF/kiDAWp3DzJ058i10uKCWK21Uy?=
 =?us-ascii?Q?cOzdEaZUDPoaf4nLbrSjxUMBmPEMClIDDi7IrKLUzD4lt4Tvq2b3KZdPP/7X?=
 =?us-ascii?Q?/dNr0b3fik+useoIacKxY2wrzJfjVGn/cEG1glbh1nbL9CLYOGZbQvOFEUqU?=
 =?us-ascii?Q?LKN98V+XEz9kOhnwxiUJLxzK57orSREt0i9XVgxSaRa7LLY+4M53W45S3My1?=
 =?us-ascii?Q?juUxRCqSZYAuj7yvLCw9iHSAcCKgfkvAS/Ygs2iQlN9IvLrkJLVyWpHqS6wo?=
 =?us-ascii?Q?LuvfzjCtLviRjIiFU9yxyvifnY3wbqHmXuTv/yaTmdPLkge0M4f9+2gyZLCC?=
 =?us-ascii?Q?d7Ih3tAzt8saw/XYZDlOCqetf2M7Nw5d+ebbw8+WZnl2a4Q8cj3vIc9OZ5wM?=
 =?us-ascii?Q?jB27FBnAHrIMUbvMoUrtEF3Q9KYyVcWqBBda/DDtv+jOtm35JJalBP7HPL42?=
 =?us-ascii?Q?5ACtu48Pg1SChdE7enUkvjBBdp8hgvaLHdUTeluxANEMkW7RXn9XPJkvCk60?=
 =?us-ascii?Q?IDLdJSJTPHiyjp+b4NtEAyGD9pflQc9ielg9L4Bpw3t/MgaDihQQrJFqL4UK?=
 =?us-ascii?Q?E9i7oB55O/IZ51Osmd3zR2KKrMYPmnecVahB1nTD/kGRq0/Gn7Vhuc0X/7x4?=
 =?us-ascii?Q?mM7inybiawxaxsv6cWz+DdIHfheWszHj9VuDV/mm41+Avsfb+jetn+k4hT3Y?=
 =?us-ascii?Q?XsR0sNOBYzPBBoGGvyRiEu5hC3JwbOi8leL6XhHWh0NMXq6C7uO7b+IPhoJA?=
 =?us-ascii?Q?Sor3jVbnK5KxnsEqW477XTvdJnzxYmvZmg4Shll2DrjiGHXb+ujQi54wQ1x4?=
 =?us-ascii?Q?dIFFidPKWFLMOS4BJSOB+YwQTmu2PP67XO9F4Tbbb4fbAwaxMOloTLnzOcRc?=
 =?us-ascii?Q?BKKFyjK3EwIj1R1PnCctL4dCpH0rPjMAts7iCpUwB9364U9/ekVe7nHtiHHP?=
 =?us-ascii?Q?9gHD1U/d/YY7lO9R0M6z0gfhcxbe8vcHnUbS7ia83CRRjV0oSAxEnIRNhGpB?=
 =?us-ascii?Q?KYnmrcREIQOl4iq1soCX87g0SDpbAhIMi2gz7rHyxQ9GYRJNsGrJMznae/Kd?=
 =?us-ascii?Q?5TD12lpbfO5S5Tvo3ybZm+bEatg1NlVsoiJhus6hBw8LuodOy4YrWXnYDAZ5?=
 =?us-ascii?Q?BjjHU6dUiLGBIWrKO+UM8w6fmDY9ljzTae57i2G94QUDimNVTUUEju7Xn2dT?=
 =?us-ascii?Q?XJEM4YE6RL+ywmWUhMzhYIJkb50B5BTB1OUM6UtA6W15BQ/O/C97IJ0HGM1H?=
 =?us-ascii?Q?HGtGJPtyZOmDRiV7/a3u7ojuggyA+92BwHnmzjfd4ic/XZZ3cDPoZsGbOcYt?=
 =?us-ascii?Q?6L+7syLRI74qS94I3TVSv85Rng99vG54qWpJrzDUcqlO79emmv396SwzVHww?=
 =?us-ascii?Q?xvSmaRFQs/bhoNHZHguUom1P5IPa8i4Zpzmlvh1akcd2f6vtd6uXuC1QRJ5v?=
 =?us-ascii?Q?ZMrdqqhOIg=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: b98f5f83-7230-402d-7244-08dedb5e5c75
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:59:05.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyrr2Apm+6TriM3goe7Iy9v4+qVsR8/w6Bz8lIxsndvRStv/W67RxOF9YYeiLZFePFBXh3OSgWeLCpN575vA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR05MB7762
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9886-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-integrity@vger.kernel.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:enrico.bravi@polito.it,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E79F71209B

When recovering the IMA measurement list after kexec(), currently, the counter
of violations is not restored. This lack causes a mismatch between the real
number of violations and the value reported by the <securityfs>/ima/violations
file.

Restore the violations counter during the IMA measurement list recovery. To
verify if a measurement corresponds to a violation, check if the corresponding
recalculated template data hash is all zeros as read from the kexec buffer.
This check permits avoiding false positives, but it does not account for false
negatives. If the template data hash results in all zeros, it is not counted
as a violation even if it could be.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Closes: https://github.com/linux-integrity/linux/issues/13
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---

Changes in v2:
- Reworked patch description as suggested by Roberto.
- Added descriptive comment as suggested by Roberto.
- Moved from ima_algo_array[i].digest_size to ARRAY_SIZE() as suggested
  by Roberto.

---
 security/integrity/ima/ima_template.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573fb41e..f7749c8499dd 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -430,6 +430,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	DECLARE_BITMAP(hdr_mask, HDR__LAST);
 	unsigned long count = 0;
 	int ret = 0;
+	int i;
 
 	if (!buf || size < sizeof(*khdr))
 		return 0;
@@ -515,15 +516,27 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 		if (ret < 0)
 			break;
 
-		if (memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero))) {
-			ret = ima_calc_field_array_hash(
-						&entry->template_data[0],
+		ret = ima_calc_field_array_hash(&entry->template_data[0],
 						entry);
-			if (ret < 0) {
-				pr_err("cannot calculate template digest\n");
-				ret = -EINVAL;
-				break;
+		if (ret < 0) {
+			pr_err("cannot calculate template digest\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		/*
+		 * Check if the current measurement is a violation as reported
+		 * in the kexec buffer. In case it is, revert the effect of
+		 * ima_calc_field_array_hash(), setting all the calculated
+		 * digests to zero, and update the violations counter.
+		 */
+		if (!memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero)) &&
+		    memcmp(entry->digests[ima_sha1_idx].digest, zero, sizeof(zero))) {
+			for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+				memset(entry->digests[i].digest, 0,
+				       ARRAY_SIZE(entry->digests[i].digest));
 			}
+			atomic_long_inc(&ima_htable.violations);
 		}
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.52.0


