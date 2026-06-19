Return-Path: <linux-integrity+bounces-9815-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+ibD/OVNWoz0gYAu9opvQ
	(envelope-from <linux-integrity+bounces-9815-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:18:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9088B6A7788
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 21:18:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polito.it header.s=selector1 header.b=BI33PYTr;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9815-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9815-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=polito.it;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89F493009986
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jun 2026 19:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7220280A56;
	Fri, 19 Jun 2026 19:18:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021086.outbound.protection.outlook.com [40.107.130.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CA025B09B
	for <linux-integrity@vger.kernel.org>; Fri, 19 Jun 2026 19:18:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781896687; cv=fail; b=p9K89bXDpyyC0cJUcFMr8iVAU/bi5XKLjg1HkZbFUOvkDJhNPZV5y6MKWzyFjYhJFv1mO+z06N7eDGT1qpq02tbrU7Eus6LvwTxdscA7LrWplyZl2/fsErlwb2t7E7/k60clvFTtdgt/pPQFwLmuUN9R/Scuj8noQhEplTW7mak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781896687; c=relaxed/simple;
	bh=9aZ4ec91QpnBxavecDi63EkVBhnyZO9UJmuPbblE3FQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Ac5UsDtpve79HxJtsB6FPOWxva2Vf0/BrAa9IcnimaOO21+kjug17Z2C3jb9Cp1zGrlDwW9UXX6p0KKNn/LFtkMZm4gujVZQFHTQWTA5qIVsNFTsU7TvP6thln7zlTkC7IkT38F6+5xdpaziqT32B9aUqTCHR6633WTL/DoIUsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=BI33PYTr; arc=fail smtp.client-ip=40.107.130.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RcyHSF9t0oAhikOfjuuSH3v+jrO/3DppJlRjkfR+XcU/RK2mKJqO/YDdl8H/eQqZKiEovnMozHXIL9Ntz07s7HSCa15EZhL3XlvWZ/TjKGZeV8hfVd0it8D/97vqvUwOElJi93S6JtSgD53meSfHxW8SHWaNPGAIu9Y+09gkxw/lu+ddja1OOk9DvF4fxtTocBfnwmRPRVlldfsJuNMMxUCYuJVni8qdqnsD+Lu9UUb+a9ZKeHxvbFGjWGh3eDshAgMj5BJHW5AZ0n1aVh2iskCzkHg2OsaEvHPyGKS1mBnp9kKCe7KZkCnX9lW4u3+L+HItF1K/y0vieb7vRkRBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z30CiX9Z84y8MaYV2mNnmP8SfmZi1gMAwEeQ1in44MA=;
 b=EZu7tyG5UJO7i5M57CRMnnXxB+ttmnZywpRYMepL1bMy69ksBn17akpFYqn2cIri3eeMTOZtzHtwS+RbCXAqwJhB8LDTbZXhjviK6McgGO5FnL5aPfUEAqMtkExrZF0Q6ERjzLqvkF2VF0zFK+E9wIVcY4F+zSNVYifj2flpEv8TB1Xt6WuN86A9J17p2AN18+3x2nxiSeBnvHMhVN7ZkT5prfhMHIz22B1JuakPElSTi/W2cbkmWRD0PY+HTqp+nH+Xdo4UL8s3yLW4czAWVOZTQ2mMp4K2uCENIFytXoiIoRoAlM82ZdL6OWFLOuqJtFWbCIvn/LsDgRXkJV8ygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z30CiX9Z84y8MaYV2mNnmP8SfmZi1gMAwEeQ1in44MA=;
 b=BI33PYTrCrXa3XSag7JdA17gDDcE0SkWEPBgETUgOwySXaFqZgRYWV5hfkUc5PMGkHYfZnAUddyUeG7lrtinY8uvs7O+glHlHDSPXaGpm99jj+PP4lu/9lPazxwxxDKXwCC3uod/EPh6bOAq3SppwCE2WI5ifB6wy8sE3lQ6ARg=
Received: from DB9PR05MB7882.eurprd05.prod.outlook.com (2603:10a6:10:212::20)
 by DU0PR05MB9767.eurprd05.prod.outlook.com (2603:10a6:10:40d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 19:18:00 +0000
Received: from DB9PR05MB7882.eurprd05.prod.outlook.com
 ([fe80::56be:6fd5:1231:4b18]) by DB9PR05MB7882.eurprd05.prod.outlook.com
 ([fe80::56be:6fd5:1231:4b18%3]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 19:18:00 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [PATCH] ima: correctly recover number of violations after kexec
Date: Fri, 19 Jun 2026 21:14:53 +0200
Message-Id: <20260619191452.7179-1-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::17) To DB9PR05MB7882.eurprd05.prod.outlook.com
 (2603:10a6:10:212::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR05MB7882:EE_|DU0PR05MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b53950e-172a-49af-c4c7-08dece37798c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|786006|1800799024|366016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	zws3kpcrYGHfF1sahWiEEi3Ltdk+QmDk7cJ5Hzd1dAoaTa//CWUg8e9KQPrPHBBYKjkY4uUef6cz96OvbPM+/BjZFQBhsRU+5OoYED/lbQMCBe/YgaHDkc/t4B32lx6NJVSzqjhtXB9WSMxgdVDRie8MbihcGhTV0Nsz9xeEsApkaiQn1ixxKZkRN59x2kQrFpivhIfpEYYbeOH89/QKl7NoBzICPqwQdo3MjvYzrxr94OQY2ttqi6xiEfoKd2JXcK2PboWeJyryDqHzMb6CZ6gXxt35+gmblIlOMGDLEJloxWqKZuKXwnl1rbyPTQ0CKMrkekCBMinliTAcCBwsP1+ZPV7LqogeUH49B+3oDKs8g/WD6jNGy/7GrKlQm99UncF5LUhOIDsQvVbEwm5Ihe8Z+jMVCR+KTKP/88kqBTgcZN3izxkUPNkNdO/PA0Ohr72+Mpl/38m3SQHZhXB9wPqFYOdKY63wuoGJyGmNxE1VsdWSzRBVBolOOBQKqG9JcSiODPUSfIec5zTiSpIYVfpB+6oWuAb/jCGPn07c5OmwwGvDhP6AHJ4wHsu0UADfS2VdbNchWS/O9ef7kQOlwJc467XOLptOGPoamUM3gDmzsCm4cxQz/kCEIym9Yoi7Nouer3LNvDylk0RNb/Lc0q1fqfkIlLzCsNjdczp7OuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR05MB7882.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(786006)(1800799024)(366016)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1PyxHJWOrx/LYjL5uEzWWrA5SLD+3Q0b75AyjWv60ow9PRO6H1tAojN3IJg?=
 =?us-ascii?Q?UVOADulC0NgDTaZZBK69IVkbqGr7XT0kMWYhT3OtQaNW8puW+Bf5Q5wwBVIv?=
 =?us-ascii?Q?fijRBPB2SLRSfpFxxZWd4BS27o4OMlWNR6LJ5I/fcoBb190ErVgF2jC9rSUj?=
 =?us-ascii?Q?4yDx/wWWERRchTHx1EtD8nZOeG/MKOa+R6cWGzh/pkXKc6b9z8xSOIcy5EID?=
 =?us-ascii?Q?yPFylgIiqJv566iEzgyAEXfmWF0vl80Vcl04Cwo3EICnU+Hqpy87+hwp4gM/?=
 =?us-ascii?Q?DfQm92A6EW1UHr139Ry89wFoFbjty6GRl4m3DRcBO6+lG66AGXCaAEdV71jy?=
 =?us-ascii?Q?sI4YsXKrAGtevTaSI7MsY7Q6SVZZ+wzUuqhfKLholLQF2tQd8/PzkYq0ZO4A?=
 =?us-ascii?Q?Pd9A75mY+D1iijVkkUgZllJTNWoZ0hrSEKOjFbH6tJ6CxpS88RNSUCMqdRat?=
 =?us-ascii?Q?ufQL1UvAPjjk9sYJNNfB+yHzw7vgOjdYzg852IYaYa1txKiw4kQ3KdGvBhHa?=
 =?us-ascii?Q?jbTG5SSdllwnRrdaP9zQNg7bK2yc3+bjfrXEZS/jqni5rsyhPE5E+roKU9YU?=
 =?us-ascii?Q?HJKaPNWwfLB14cpnlzfiG95bWIormIzr7vfktgUfjJDGZAqTWnHAVCzn02uK?=
 =?us-ascii?Q?Dcgqk0PFbQTlDGADBJS9UHLsAalhmyhuEO9j09nxis5Je113zlAzDNXKnFE3?=
 =?us-ascii?Q?iUkCwmaz79ZyFQQIMiX90FGIUUBpGRmoS3c1nM2iRslFbl5ZqF4VLMyob093?=
 =?us-ascii?Q?LPvL30xpP/OMYx9QeEpwOMdokpHvqeaK99oHptJf74VpOzSEKgzZ10z6JKYb?=
 =?us-ascii?Q?ymb5D73lz1uMZGjkTM/qMahUHrNLQDaLjOS8Ed24zgQ3ArRVAFHKXsmXuZsj?=
 =?us-ascii?Q?3/cUV0wvd4tbof7m3ITPqTBDrHWj3JVmYvP7OpSRMvGdVfWIQAUDZICO3K1L?=
 =?us-ascii?Q?sz7SP8gwzshV6DLwir6ZhuBpzBJzf7UzdQnYbddcqMpkD6eCp3tcQ674JWv8?=
 =?us-ascii?Q?HwFunTCXGib3F/Yjz+/KhF9MMeDR2IP9GqTqoxyd6am1A9yDIzJaHDtcQoj1?=
 =?us-ascii?Q?sSvel1ifvYIGi3s742YZJTzNhhfs8Ba5aziLdPtkANZx6OsJ22UpBidbm/Te?=
 =?us-ascii?Q?RFHLGkw1JEYVU5DLfAnUCc4C1ksgiv1LkScbWKyWocrSmlxqFD1ufG3S6hQ8?=
 =?us-ascii?Q?pp9r1Zmfe6UGvjbci1V/7aNTZ7GZ1WdqqMUf37rD80Fi8BFmLmjohODd/SfK?=
 =?us-ascii?Q?IxoDfFkZZhuw6qRiN58lQ19yt2RdotIwZLOjAtEkqAdjdyGK44Z+FrDkEoG6?=
 =?us-ascii?Q?Y+OiI3LrhdGbzTKauC28+05wV8NExzekwHSoZg0V0K318L/F7l3vN6Av98FZ?=
 =?us-ascii?Q?ieCiLg9R2nQadRaHcSbU5Uy6wR9dAuTqKbN/y+nEy6CymkLq+mvfYsNQDbD1?=
 =?us-ascii?Q?JXRKgcg8u88GguxY2+alAHZObVZNvi4kKJvRCROv2aEjy0p+YF4ktWBvc3Hx?=
 =?us-ascii?Q?RWsoHniKBo1n7g+4H3gasbFZtYQkqGcAVXkqGlQMSfzidPKiByisbtzqZMHc?=
 =?us-ascii?Q?BlJWMksngwccZSog7aQZw69H7u2R+p6aLsCIAlGPkk1Ose/gIn1e8takLC59?=
 =?us-ascii?Q?D2gFWC3NN4DbcGUBUHT8EfeHfh7yD0RwrNJiAX+cBit9gexeuD0WnMnI2F86?=
 =?us-ascii?Q?d2/p3RPy0FCkW2TQ0txl9nV1eYJ2kBW9/mgbsWXXnskP77fPPRIQQR6xLoAK?=
 =?us-ascii?Q?md0arIunCA=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b53950e-172a-49af-c4c7-08dece37798c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR05MB7882.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 19:18:00.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FD2sc2rZVUEW9S78q9LgrxNOvD8tHOmWULOm6KoKDS4/Qtn+TYXaRiRqoLWgXLlriQYF6U+biK9HCky1zGJTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR05MB9767
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9815-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[polito.it:dkim,polito.it:email,polito.it:mid,polito.it:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9088B6A7788

When recovering the measurement list after kexec(), the number of
violations is not recovered as well, causing a mismatch between the
number reported by the <securityfs>/ima/violations user interface and
the actual value. In addition, currently it is assumed that when
recovering an entry, this is a violation if the template data hash
read from the kexec buffer is an all-zero hash, which can actually be a
valid hash.

Verify that an all-zero hash corresponds to a violation and consequently
correctly recover the number of violations.

Reported-by: Roberto Sassu <roberto.sassu@huawei.com>
Closes: https://github.com/linux-integrity/linux/issues/13
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

---
 security/integrity/ima/ima_template.c | 28 ++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 7034573fb41e..147f228ed246 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -430,6 +430,7 @@ int ima_restore_measurement_list(loff_t size, void *buf)
 	DECLARE_BITMAP(hdr_mask, HDR__LAST);
 	unsigned long count = 0;
 	int ret = 0;
+	int i;
 
 	if (!buf || size < sizeof(*khdr))
 		return 0;
@@ -515,15 +516,28 @@ int ima_restore_measurement_list(loff_t size, void *buf)
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
+		if (!memcmp(hdr[HDR_DIGEST].data, zero, sizeof(zero)) &&
+		    memcmp(entry->digests[ima_sha1_idx].digest, zero, sizeof(zero))) {
+			for (i = 0; i < NR_BANKS(ima_tpm_chip) + ima_extra_slots; i++) {
+				/* Unmapped TPM algorithms */
+				if (!ima_algo_array[i].tfm) {
+					memset(entry->digests[i].digest, 0,
+					       TPM_DIGEST_SIZE);
+					continue;
+				}
+
+				memset(entry->digests[i].digest, 0,
+				       ima_algo_array[i].digest_size);
 			}
+			atomic_long_inc(&ima_htable.violations);
 		}
 
 		entry->pcr = !ima_canonical_fmt ? *(u32 *)(hdr[HDR_PCR].data) :

base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.52.0


