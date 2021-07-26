Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C523D6580
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241798AbhGZQfQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:35:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1806 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241290AbhGZQeR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:34:17 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBn6w007952;
        Mon, 26 Jul 2021 17:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=caSiU5a68S9JBTzS3b2dMJ1tHXwt2FDezGnrMdTzGSw=;
 b=rC49gI7B+p/80IyqPo6KGCgw1Pcl+U7eY3CC8KdaCo0DwEbZkxQ/NEkivbo0/sg6ugRn
 0xkPyCVzDrMR1zjkKRwpNE3NzklNKl/lAbRXyviJAgqi7wH7UrvguDc/zIanBkZu+bVy
 QaDq7O7nX70QmvBI3byefrLTNs6CcncDm5PwkGhsHJYIwoR7lI9LfQVGciHbgKxmv3tv
 +5GAXJVrTnVDchC/5WiMLy1Zm87wY9kxtoG/970cBgGi9n1tNP7/jeRllM3TKE19LaGX
 IVc8Ofo4ZCIe2FgLffnoCmtYmSstHGD+NALlUNcrQ8+ZcWKEqu2Ri2yNbpsmOnUeXU3h RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=caSiU5a68S9JBTzS3b2dMJ1tHXwt2FDezGnrMdTzGSw=;
 b=KoDH1uxNdq8QMkzqGE8zIJGKtWxHGYFtcdwYxNF2N6DPDgn5PBoezhJ6pe+JrJuzjAoV
 l5wb5wOlCap+2sJ9tW7EV8D253/tA6b+xN4KvOmbSbFUGnFAuRT1Wdn311mGU5ZwOO9O
 niaPXHXWFHgaDOb3Ctd9qremDPTkmaFF9j+VBJBdrLnw3j6rT599hSbVsAslTHH/xEGg
 3rd+wF4C2sPJ6IpghDxN0WxYV2tsKu/fasuU+F+maC0djK9uiL9xDOzaLAfhdaTuS9gh
 g1cAZWUVQgP5bwEY34XO8LVWcJ2DlP80KfWJBLm7feIxhXxlkJ+wrm1mgPDNoun3r3ia cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHAt85089469;
        Mon, 26 Jul 2021 17:13:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3030.oracle.com with ESMTP id 3a07yvvvkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdnyjW+K/WhhAuAu2QSepTtUsNDsYkJqhtDiapZg8s2EL5RMsp+i1tZj5tsV0diqFWS9so7PHGzsePUe9EfMhNhdk+YcIbmS5pDsyMDI2MxPx5SARoH/hmKH1uawTVJFmySOSNkyqQVWXmmTCD6Doq3EM/Q2aTWhRTMQm7CjCxM+dxRzynE/gxbt7mNABkOBePEDpQCPO2ceFmUHpTcTvZzihKl5dtsKJ+MrX8rEdXdV4E/BJFL7v3srVeAbI5s2j0TFPWYpfy4k+pES/GBXEMiufU2qQr6RP46/paPihWohWScfAtEOWx6JFy45WDC6U3HtaQOKruBe4RYnEu8T8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caSiU5a68S9JBTzS3b2dMJ1tHXwt2FDezGnrMdTzGSw=;
 b=IOhlBcLeMXig8TcCcIYUuBk0BJ37ioW51xoWZYdDh75P/lwIssCUadywss/oucnqWSpqgs+mKNwxDJXJLhTATv8AqAAvp8stJQljoADHOpEvf1gn0gt33huQUlKsIgHlX/CFBXd4STixrDF+sRT9aeEeBJgT5xfP9OieWNGJcfo4G7lqaSQ3e7meZ2GUB7c5y3RTBHNevK7YCuS3RB4AIqzUJTfNLIZ0J90g9qbp4efILrqxkb0IYv5z4YcL+vUpubdXyEtvSP2Jc40diu5JuZgVGUWbt7Z6dAZ0W+dJs/YBCfurzUaFfaaBW5CpILVf2rcrlRl2YmLUiUeXbDm7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caSiU5a68S9JBTzS3b2dMJ1tHXwt2FDezGnrMdTzGSw=;
 b=y+pu5MhWfQ9Y00ynnv2EwKxK5t5wELkl9odVaIBn2Hdd98cqfk+dvivfP227ekEc8mMTZ/NzTUBFyR5lkNrxsczt3RbmI0rtXk9611XDPvu8iJAL5Wnq9GzZtVGU4SMYbMZ1Xkrm1l12y3ifebXFQ/emZEwEmFRa+RPdzBbukFw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:51 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:50 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        zohar@linux.ibm.com, dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com
Cc:     eric.snowberg@oracle.com, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        glin@suse.com, konrad.wilk@oracle.com
Subject: [PATCH RFC v2 06/12] integrity: accessor function to get trust_moklist
Date:   Mon, 26 Jul 2021 13:13:13 -0400
Message-Id: <20210726171319.3133879-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 205f0a9e-9688-46be-eec8-08d95058bce9
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB52113903E6F102A94B883F7987E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gHWNVPICuvYGy8s6V97CeELAU4CQKwqOzWT+m4B/tuaC67hl8IHFZMPjSTycztvrmGeCTntMnA9NavN4WsVHAGKkXXupafigwNG8ALlzuDo4K24KlKBWrqo7GYs+jgquqW4zy0Ftg4rCTgFG98djFXXBrYPFAH+Q/2k0PGoOsazFMN3zoBO6aT6lO6zRwnDIFr0Z+J9v3FfeJ1r+nRfXD/gM21XTtocpWUkIFAEYPHxIen4C/kvOlhWSvjSXGYBYJPWXxdS00r6GTt+69+SvlacestPCLv92SQEWXPddkR94eI6dbg/2yC5RpY7SO06PHmp9mObuXJ1GMoPRxGpQ/xiPnZF9hKWD4shjaBNEycxrJSMZ7CDFC3wEbLSc4mKKfeZh6DfI45NR52NV1BFqn2VwUnLaNxcujgnRHDpFiZs9CcPCp25Mh/YorS0VK0ADGEwOgna7OpKEXm8riehVAQRRe2fRARq0AWkmT7+Cq1H6Rp/frLdXuCnyvCgkT8+jbc3lhlVbmWyTKZjgqhNTZz37DBVRQa13u1wN8UMIgSQ/912YEzTbL4gZV9rxUez2VnzPxyELzYGZNaaxW9EVappJyZHDFyPnhvz//FRHwTBJLBgPSaSOjMo9NTDwudi1KlELRj1ArhGVVpNOlfpRthffcGqhSbq1E22aoV1tdSuFWmBKCjYVAlUmgBmC7Gxxu/CYsmTdKC+dpx0sM02DQK7g11tu0YJzIEzoDpjjnR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mgKCrEMoTE6RO+dUwl/Yxhbgac1/SBvuOtGGCu1/JSwu5zoyTfiEuD1VT9aj?=
 =?us-ascii?Q?WUgg1510CWEnCCFkZAGHpxFQOMtrJMtIIeIyHxqJeJIIW7hp4ZX8gcoWgoZh?=
 =?us-ascii?Q?I/aeWdjMETNnMZ6pxr2vEpNeWyyeG+lA8xbCsc99JK6aAFGYDKUKEMpTpxdS?=
 =?us-ascii?Q?xxs23fscVaymTIy/OWp1kqEYlZgcvFl34w9on7RnVFqFneHY5w3utmpZskV/?=
 =?us-ascii?Q?8s4hWBHxJvZ2P+9ed3so3Jc7/OvRhRSx+Ye1aGN6H1mFYqvrSgoRhIUEhxFf?=
 =?us-ascii?Q?3UwnNBtJmqLNReBPqPBWbZssKf8MO9npHn5t4UNmxnh0G+roAXCEDe/MD6sg?=
 =?us-ascii?Q?FCApzMkGJaQywj/EhjmI5epBJ3li8id8r18boiDywPvCZMQ+1EH/Vr2cJSJh?=
 =?us-ascii?Q?nR8VCWTmR+5zbNHekj2YwtdtwgR1rj+f+E9+Bxh0/QGVJigaIm8OiDYXhHGA?=
 =?us-ascii?Q?3yvXoBf2gBIupK7X+Lwju2HZ7eekEDBEIMOPlG5Q+Eh7qLIvrmavW/Mh2oxe?=
 =?us-ascii?Q?Tf8duQIgiBZwip1ycnl+gw4yOzJ3Zst0Fvtja6rSft4Zgj9cT4gwDnu0rMoS?=
 =?us-ascii?Q?4WLXgoRT+pKS7UZQbOPABN2Oo3BtIqOWhVs6v1J2KirDuBKCzSLukPHWoDxq?=
 =?us-ascii?Q?/gtSmdV98mZQYXM4yX/71IGm/3coDQt5fY4/GFcSIygGcaUHZ9lpkuMR2BNK?=
 =?us-ascii?Q?NpePyWoWJ7f5llVTIBNTHtpznqN353E/ZBkN1S7LbK89JfxLUJ2GnJxVDIQa?=
 =?us-ascii?Q?t7X9TJSSpCdQ6+AbN3SBj/Y7qdMtSa+FE3e0Mpjr4UoO9dQnt5KnWbFiQo66?=
 =?us-ascii?Q?VzXm1UjnaLHqS/UWj9HCxDZhh/HJSus1i76/ZTEA4cJLb9IiqSwNHhC5JnQq?=
 =?us-ascii?Q?po6IMeG2s0eWGQKinW0VO8oVmG+rqWKhNA/IYR03N/2Q1VSDQuPqUpXGd7gW?=
 =?us-ascii?Q?FR65/MD5tGpkO+J9lMFO3Q/A68Lc0B/WPTHMpZ2T7bFhlmiD5kAaulaZdFXr?=
 =?us-ascii?Q?rP0iUBolSzxZRgBD52EF5MxAD7cACQgVtz++Zeu5eMuXRBn8Yq0iSlybdgmw?=
 =?us-ascii?Q?24PRBRFLK19K2TGKBqAKpy04t3lGJjqSwIk27uQqqknrZYZFcVPdDl1wjERz?=
 =?us-ascii?Q?eQRz0KAlWozVTT0Oh7XNGTyzP2LgVkh1OUi1Jql+Alk0Y3hcuDgQ7Bj5HPBb?=
 =?us-ascii?Q?VC3VvuC/Bvwue7eYygVS6nBOrJUN4HQhMU47RoWbESa1bi9bSb1RG8xGCMMp?=
 =?us-ascii?Q?1YeS9l8wHOPkKD+4drAOaJ5tqZQhFI6TpTx039UAnNZvwaIe6vP82SMRJgkS?=
 =?us-ascii?Q?ok63T7DGHpcxxKxlVipSNtj4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205f0a9e-9688-46be-eec8-08d95058bce9
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:50.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzP4LCBATADz8DAoa2ohUQPMsQzXYm2pSdekC7mRinIafpLdfv3NVysa9qEokUZSCRyiJk5a/uP0Crv7x/TmJrpk6VbZyijoj0dVxw20VLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: lEaJPWbLI6Xab0iryMilh_UeldejVfH3
X-Proofpoint-ORIG-GUID: lEaJPWbLI6Xab0iryMilh_UeldejVfH3
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an accessor function to see if the mok list should be trusted.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added trust_moklist function
---
 security/integrity/integrity.h                  |  5 +++++
 security/integrity/platform_certs/mok_keyring.c | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 60d5c7ba05b2..1fcefceb0da1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -279,6 +279,7 @@ integrity_audit_log_start(struct audit_context *ctx, gfp_t gfp_mask, int type)
 void __init add_to_platform_keyring(const char *source, const void *data,
 				    size_t len);
 void __init add_to_mok_keyring(const char *source, const void *data, size_t len);
+bool __init trust_moklist(void);
 #else
 static inline void __init add_to_platform_keyring(const char *source,
 						  const void *data, size_t len)
@@ -287,4 +288,8 @@ static inline void __init add_to_platform_keyring(const char *source,
 void __init add_to_mok_keyring(const char *source, const void *data, size_t len)
 {
 }
+static inline bool __init trust_moklist(void)
+{
+	return false;
+}
 #endif
diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index f260edac0863..c7820d9136f3 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -8,6 +8,8 @@
 #include <linux/efi.h>
 #include "../integrity.h"
 
+bool trust_mok;
+
 static __init int mok_keyring_init(void)
 {
 	int rc;
@@ -67,3 +69,17 @@ static __init bool uefi_check_trust_mok_keys(void)
 	 */
 	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
 }
+
+bool __init trust_moklist(void)
+{
+	static bool initialized;
+
+	if (!initialized) {
+		initialized = true;
+
+		if (uefi_check_trust_mok_keys())
+			trust_mok = true;
+	}
+
+	return trust_mok;
+}
-- 
2.18.4

