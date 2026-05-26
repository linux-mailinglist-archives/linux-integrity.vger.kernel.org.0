Return-Path: <linux-integrity+bounces-9679-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGSZD9mmFWqJXAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9679-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:57:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 751595D6F36
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 15:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 208E130087B9
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E1534B662;
	Tue, 26 May 2026 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b="Zu3UhCgt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023111.outbound.protection.outlook.com [52.101.72.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65809232367
	for <linux-integrity@vger.kernel.org>; Tue, 26 May 2026 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779803630; cv=fail; b=BcYMOmpdNBXiP+UNiYY6CMoQaZwpUsqfZltMXRFpo8IRCQixb/pPpE1peHh9W56aFJDR75/6/TuDf8GAG5q/R7Te08NqqznUz2ZUTa052nHk+RP99Jfs3o4ogSRKpTTgjEozRg8Gohrv+nU1vOwyixiaRwfhJwGYX7THkausaAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779803630; c=relaxed/simple;
	bh=No2q/ejAWtX+j445gSAYVCvRu955tIs/Zt93pT1VeBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRzd45vEL8FIaDGzan7FMb7zSf5sajcEwv6jZmFeqT52zD/zDSj8zXGscbwB+yMwbgpQ2FtSW1h7Bd6a9ooHVzZCzJkXNYyd46MTPmExxzpYe8v/JroEkDAsjt3tp5FJxB4iYcDMdm/+ke590G7xnTdV9mb3dzzZezh4WDeNJ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it; spf=pass smtp.mailfrom=polito.it; dkim=pass (1024-bit key) header.d=polito.it header.i=@polito.it header.b=Zu3UhCgt; arc=fail smtp.client-ip=52.101.72.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polito.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polito.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nF5+MWfVFgRXdNdd9iVQp3gyNq7/LSMW3qXdgQ2o4aG5Dhd1mRYhZJKHFwKmf8wXopCu6wGVd364on71tpxjBPZ8+SChYTaje11PXVqKKJ8nRI06OLV+I2YkqALD2DJfJ5zctgElZKAoXTcPNZLeq+K2c+mq6+sTmDm9v+mqSgaOsT/hKPrVx2HlYqyLn/LIjshi+fPIekMZb9YqRiFEyMJS0DmjC36OVrP41E2Qga+ov38fyG/Cy6QARAc9wDECXyWnY6eeksCP0Kd08SoV9+wroR2OhklE5vkvYAAwBxuPvVlyAPktrL20uZ9MzMtIAHAwiHBND8chplHVaBVTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQo9EHqSO8Tis+ApduKjEcSxaqeJH7nr/rztU5nEhxA=;
 b=nyajktSGigyPwLnc4y5NASQdj0EDSzBmf6y0StU3ZcummAt68iewFzWe+jFLn7plzqyJzeB15DreLR+9EYLH1qB6dNbTsfPkBacwwFrhIED6hA7+xDPKxKc+WTPHiBoLjmHl5LcYGzbKQRz7TNHdCKgFXVqa0hgOUa6RLWPmJ9W9K05+b9S1g6NxH0P5ihd2iVs9rbF/EfgW47jX/fnUEb1+CIrCxEyUMDBpLH8J4bU0USbX6K7C3i4bybQM06v9Sg1ofMzzUpO3q8qG/AjQNYcxV6fcNJqr7euYFbxa9AjgojniGbI0E/ZfTrbY7GjBtDfL/TtH9eb0Y0oZBXP1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polito.it; dmarc=pass action=none header.from=polito.it;
 dkim=pass header.d=polito.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polito.it;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQo9EHqSO8Tis+ApduKjEcSxaqeJH7nr/rztU5nEhxA=;
 b=Zu3UhCgtdf6nQykLKmsp0JvBmNKErCc6ctdkv5f4/uIgCUxdaj1nORVS+4273QwymGo8QXbzNdo/qAw0veCk1krunFzA/5oLOqdzqmOKmC9a1Cx4Y3czFSWaaWBbeAwghnkClVP9eR150HAxPV9sJaK+tCt+I6Uk5gWYX5yy9TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polito.it;
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com (2603:10a6:20b:253::20)
 by AS8PR05MB7672.eurprd05.prod.outlook.com (2603:10a6:20b:256::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 13:53:45 +0000
Received: from AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64]) by AS8PR05MB7880.eurprd05.prod.outlook.com
 ([fe80::b739:4a27:cccc:cd64%5]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 13:53:45 +0000
From: Enrico Bravi <enrico.bravi@polito.it>
To: linux-integrity@vger.kernel.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com,
	Enrico Bravi <enrico.bravi@polito.it>
Subject: [RFC][PATCH v3 2/2] ima: measure buffer sent to securityfs policy file
Date: Tue, 26 May 2026 15:51:19 +0200
Message-Id: <20260526135118.289633-3-enrico.bravi@polito.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526135118.289633-1-enrico.bravi@polito.it>
References: <20260526135118.289633-1-enrico.bravi@polito.it>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To AS8PR05MB7880.eurprd05.prod.outlook.com
 (2603:10a6:20b:253::20)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR05MB7880:EE_|AS8PR05MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: c2da7f3a-bd14-4eb0-d95b-08debb2e344d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|786006|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IA/4wUHpmm6aSB2OsxxWKBRyF3qwwh1Dtouxcwzhi8/SMqQ4dO6b2quBVJgEHejAqreeo+jpFGHA8ESRlY0Hy7JYgpTuqzBRJjHT8PPqnv92mY4MbaEHtftubcJxTq/kFULxif8V2KW/B+fqhlA93EIk0BHp7woXp2ie1RJ1LXPAezQGiW0PL/XqL+ILYW/pfF4j8VdN6LFkHM7CRiqvxpPWh7QtfZ6SDreMnyHzaY8QunvWwSMFimS/XGijIR2DvDn3FmK5QkRGGJgB3uqTWENSduVXeGXJ/kV5LeEWAShHfXm0V0QmdVf7qm8qqwI+PvRd9F1XaQGRVBuJrgdQDam7lPRMzRv100yKDZN/XVIEpN4dqdlA1hpq7sPQZCwraB7E8TaDqsHpxMcOP6GUB/wLMqt+O4ihesOYJJHk3mMO99yqpM1RZQyFZCBZ61YUFQfF7ItC6j9l/aoaRl8ldDKDYLAMlbBLwkeMcIfUOyMzJymFQ2HEGnLn0APta2Njw+M8Xejo8ZihKaJIRqjYQR2ujGVi2Z4xzBykC9Ukj8RR0OveyZA2Ly5XG+fZ3dpc0UgxV+pD6tZBxA3oaVuTJNjADgxU3l4mLFwjWVznrOgLXrHbZwhTE2J6uXb9u6QLz/52DKZrAVX0fSaMeqPISICCv33paUUWXEkHH85iTwPlSaBm/F0syGPXSUm/Hp3k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB7880.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(786006)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGZNiIceUDCdFqE73igo7uzL6xIy3a9OKK2j0Gp+v469DTanH4DvuPI8Ksq/?=
 =?us-ascii?Q?qmKPyc8rfEzSNdGPsvCUx9idydSRQ/EkwVsa4UPqddCYlI7PBsAwRkKk1FAM?=
 =?us-ascii?Q?kVBRsuqj6SEusUfQiNAFJ/GPxsXUZpk1ATuS9uTXteKDi/OHHdvLksAthY3v?=
 =?us-ascii?Q?1Q5EG8rYi5IQdnhu8DPsZFAtpdgLtF8i3wTtPWNXcKbo4frSSmR9dLRIUSRb?=
 =?us-ascii?Q?Pz/zFS/26vmlKP2OBaBUhyUg6TGr81ytpR3wAGlcp/qNlk45CI0CxhyaT03/?=
 =?us-ascii?Q?nmxXWv6ygMDURIugWcK0OohDeCqjh/IdEacqYxWiUTj/zrsQECT5ctXPEmAD?=
 =?us-ascii?Q?JvYmNIpJe4JONE4rWEjoqaIKND7GCLiaZnGGF+A9EXW6WNGZ9JwJF4eqEemw?=
 =?us-ascii?Q?bcCGd2r5QNGOvTjEjCA+Unq09BafDVi/49agwoF0yaBoaQrn3BI320MxPJXT?=
 =?us-ascii?Q?d1Xj05qnyT0OGM7V+xy0G527uDBgXS29HLEaRqwdUNvlj9H/9yCi6GZWPyKO?=
 =?us-ascii?Q?HuTiKrGnDhZDBthmcBDVI4LlGtK+70UjG/77MP6htHBdfo8bF7BXmiGAWQK5?=
 =?us-ascii?Q?jDfEaoPbMGCwSgzk9XxaNLHSdWqTqzJ0UvuKAWgWkv7nIgC9ZYELA3bSnqpw?=
 =?us-ascii?Q?jhIn0cItTo9VrL2Hy70MyPUbo4R3HBA4kAVrBlMFRp8kkMvEOHMYVXfIs5G5?=
 =?us-ascii?Q?I8ELxBeFdJUaptRa/9s/OrVwmD2hPgPBsHmNAeZJOMstgwIlabs0N/bxFBkM?=
 =?us-ascii?Q?K4UgKUTvpBiu+bWq6b1P/G9s0i7ENn3EaQeoGRxHM/ZYF3adt3gChS78lLvH?=
 =?us-ascii?Q?PYymEtwhA6ieDWeMTInZEGpP8ASQFw/FkTJyjb2LXkCHvr6D2HCs37AY/Ap5?=
 =?us-ascii?Q?enuupg87G7fswK93iaXhmfGGxQj8HZEjri2p6Ti1zVeiKppxpwW8g72dOiE1?=
 =?us-ascii?Q?8uxgtZGWQSDOL2KWNFtMkLsOMbJny5HVxvZAKi5UTOs7ayWBmEmQH76zPvOR?=
 =?us-ascii?Q?OhE0WkG8uKOCctpVweNMsR5u3H3t7jC6dV6ssg7G2Tgz8sG6B0IGSosb507u?=
 =?us-ascii?Q?4hwaeGVzjkxjOuvBrbrzQjEhSstdnKejhDs2CjdUpY49PLkP9KRftXPwmAr0?=
 =?us-ascii?Q?lIElYx3bGWDCmyuUqVJL8IogtsFRMmVb4chpZ9dU+aZ4fB5PKpEYibLKtpYi?=
 =?us-ascii?Q?ebJILxZTEeppfOCIZnC/8+job1EEnX4xwCpXhE9CXsgMOGP6ma+SJZ+RQD3O?=
 =?us-ascii?Q?GobNTaNN68j4eUTYicFN0NdlcUW14MZbEOR+Xkn9m3jpZGOKbQQsdK8511Ey?=
 =?us-ascii?Q?yLccj3Po2F09wo0xs0a4exjoR78k5EJwJB0N7iTBU60kpCVlkTTeu0VI/vzg?=
 =?us-ascii?Q?lBCzC4Z7QmE5O2LB5m3HdCIEqN5x5fH1dvqBZ6e7UglNQI5g6I3YROCztFv6?=
 =?us-ascii?Q?425uFb19jpNa/db96gqMzwykwlQ9F9f7sJxOLQw1U5Kcy/9+tFwzU7JidIr+?=
 =?us-ascii?Q?h82BZy89KQoSt2VZBoe16jRaq0miYz1NGTA+hX0uQv/LEu4RG3e2cCknGuoN?=
 =?us-ascii?Q?Rk6a1+BSiH7ryTtYFm9K1SwRl1GAuBGWbZPVmHP6RDehXlnCqDq1FCG7fdz2?=
 =?us-ascii?Q?23VR1jhHGtNnic2PyjhqpWK0iYhMgV/fT4Zg9UppUQd/GWnTOWZaPvUOoY/g?=
 =?us-ascii?Q?hs+Bhbs52YSQ/RISp1ICE8Krl2cB2efSdxeB2LWW3gRoWUOok4z2Te6uWEHJ?=
 =?us-ascii?Q?4Y9iBcDP1A=3D=3D?=
X-OriginatorOrg: polito.it
X-MS-Exchange-CrossTenant-Network-Message-Id: c2da7f3a-bd14-4eb0-d95b-08debb2e344d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR05MB7880.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:53:45.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a05ac92-2049-4a26-9b34-897763efc8e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb6i4gXKY+bQcmpWRizPgUsU+WETSJkhwexPiNQO/LOXfpPtiIVsfjtHlvs/HWJkXU75QrGdyXtQ4SgXLQPCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR05MB7672
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[polito.it,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[polito.it:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9679-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[polito.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enrico.bravi@polito.it,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.985];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 751595D6F36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a signed policy is not mandatory, it is possible to write the IMA
policy directly on the corresponding securityfs file:

echo -e "measure func=BPRM_CHECK mask=MAY_EXEC\n" \
        "audit func=BPRM_CHECK mask=MAY_EXEC\n" \
     > /sys/kernel/security/ima/policy

Add input buffer measurement, regardless of whether the new policy
will be accepted or not, that can be caught when
'measure func=POLICY_CHECK' is enabled (e.g., ima_policy=tcb). The
measurement template is forced to ima-buf.

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_fs.c     |  1 +
 security/integrity/ima/ima_main.c   | 19 +++++++++++++++++++
 security/integrity/ima/ima_policy.c |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a223d3f30d88..320c80a1a847 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -426,6 +426,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 void ima_measure_loaded_policy(void);
+int ima_measure_policy_buf(const char *buf, size_t buf_len);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 75cb308cf01f..601718e02429 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -362,6 +362,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
+		ima_measure_policy_buf(data, datalen);
 		result = ima_parse_add_rule(data);
 	}
 	mutex_unlock(&ima_write_mutex);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..174110da0030 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1204,6 +1204,25 @@ int ima_measure_critical_data(const char *event_label,
 }
 EXPORT_SYMBOL_GPL(ima_measure_critical_data);
 
+/**
+ * ima_measure_policy_buf - Measure the policy write buffer
+ * @buf: pointer to the buffer containing the policy write data
+ * @buf_len: size of the buffer
+ *
+ * Measure the buffer sent to the IMA policy securityfs file.
+ *
+ * Return 0 on success, a negative value otherwise.
+ */
+int ima_measure_policy_buf(const char *buf, size_t buf_len)
+{
+	if (!buf || !buf_len)
+		return -ENOPARAM;
+
+	return process_buffer_measurement(&nop_mnt_idmap, NULL, buf, buf_len,
+					 "ima_write_policy_buf", POLICY_CHECK,
+					 0, NULL, false, NULL, 0);
+}
+
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0b4dae922b6..d44af7422c04 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -541,6 +541,8 @@ static bool ima_match_rule_data(struct ima_rule_entry *rule,
 
 		opt_list = rule->label;
 		break;
+	case POLICY_CHECK:
+		return true;
 	default:
 		return false;
 	}
@@ -589,6 +591,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	switch (func) {
 	case KEY_CHECK:
 	case CRITICAL_DATA:
+	case POLICY_CHECK:
 		return ((rule->func == func) &&
 			ima_match_rule_data(rule, func_data, cred));
 	default:
-- 
2.52.0


