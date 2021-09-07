Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF93402C55
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhIGQDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40720 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234102AbhIGQDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:21 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EfWEt026869;
        Tue, 7 Sep 2021 16:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=bIS+ZsQcDbm18vUWg6MnbErxHbzJu23cwjgvnTlJmNs=;
 b=kQZko1HSqjVgpRIEI971jp9kIa0Hz6AXulfBj1k34g68WjgQIAnY4DFufWXl/nKkeoGt
 RADl+s90ifxSzyZ2caG5Y9iQc2u07xJGCE7jgcVAFv7ofBARYeddZaUaGNRxKlSxFRhd
 16RNX0jPhIY0I1txo0r0dJYfekNohrQL+730Zu8EVwQv/h9VMa0E2LqhSF5Pkqtm3h9c
 2ltEZfadJckjTftCoGG0snS+UDXxPeDdNyg/uWUbb6nJIUrcI2mEMz1jp4vUDj/rEHZ5
 F8wKCWaFjtbdLK60hspuB/905gUb9gtI0IYP7Lrwjv/prEp7HIxpApNa55G2YDAbWJlt cw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=bIS+ZsQcDbm18vUWg6MnbErxHbzJu23cwjgvnTlJmNs=;
 b=q9aXjfpLizwvOodplSfcsgdzYiOBfg90i/KxJ/YEEjpR7iuFGJg27ai/mv2qULzIeMab
 HafcEB00HBE9zD5GF4gcYnNxZ3/YxqjuOWVedD0wnx/qRiiAApcV7FsuBunqQJQgiCn+
 8n1qmQGHjG+1Ih8VyYceuSpnP40oLwwXb/S+8Icj9uX18QaBL4BpVw2BbtpB5F6cd1n0
 yLtIAgQfKXu70IuEqIvpGwRv+NbPZhodQGWYdd6Nilk9B8XOv/kuXNEv8J266VdQr2b7
 MEldU5FDVAxzaUwoqg306sgBkNp5G2wjB3drPOqQR/XIIPYxtvs2CCbyiKfUHMo8OzSe aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awq29jg7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G03S9185879;
        Tue, 7 Sep 2021 16:01:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by aserp3020.oracle.com with ESMTP id 3av0m4t4vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy7cd5aV6Z8P7yqKnJbm1so+CEJsFN1bcBzxizj8fifrQPx4NlaRoYGhOxm6jZmRGAK3xTvn3MDrLgofEB9sDwKiGtPL95+yLStfUyJLgDTf+3RNsEDD//yYlDKE17vo4K/bFv8I29b03GnqaN4F4Uq5HVklZTDK2j4l6MOBBC32w/ncrTbFhl/PaGLEd3pvx3R4EKHSg+KVVNllbSXciqTdMRerTDZyy+AXNY3J6OXhrC9HPNXvBkU23mZb00Zc3aoD7GDoJIRsgCQSKaS0sqlkf6WO5WEdSju0oqFlp9ICjA1tzFQfnPWu+Rveehu5VbsQSFIAUH7nOZRCjGegGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bIS+ZsQcDbm18vUWg6MnbErxHbzJu23cwjgvnTlJmNs=;
 b=EKT0//IgNsKMTnrVYe9hOQcE8rF2kQZt3Z55auvGLURtGBCk0v622Z2ypejbqSCr18oQBU5PaCvyZkPZOW29LlgtxiiYBW7yUiCBr/u1cO4KK751YmmpRPrpowwFWe/H//Zl6yl1yywohfSnTfHF+6zTOK+zAIG5PfM90cahlLXIV3nndyQoXdG7bQN1w1o/EVdL5j3UOb14qClGNt7UAehqW/ZD/HNFaNtJQUD/ILy+L9f27tbS6Ah9f20DKnU7kWfc3AN5foC7MB5k4TR+GcljDxRmI1SdIoC7gVvrRWuNEbMYQbggF2R0EG86idBZyrujrRvS8lcq6rVqmX07FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIS+ZsQcDbm18vUWg6MnbErxHbzJu23cwjgvnTlJmNs=;
 b=tSBkagkwvtLrAA+KTsK5n7P0dOp4J1irQce+azD8HuCfH8VchODtVqa3F8ai1YIpgAv6d6OwK5FQki/6IV5D/d295+ySj1mPOtBuk9hRtMfuzw7vlAeyyO1OVR3TOhnqFFUxC/cA7lNFbAKjqTJ/ynfcDBOF7lYI5MF8DbDL+ik=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:41 +0000
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
        konrad.wilk@oracle.com
Subject: [PATCH v5 07/12] KEYS: Introduce link restriction to include builtin, secondary and machine keys
Date:   Tue,  7 Sep 2021 12:01:05 -0400
Message-Id: <20210907160110.2699645-8-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 366f831a-4162-4cc7-78d3-08d97218c856
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5004E81AB0B0A536F9AED87387D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4sXelSBX0KGwt0QrYlTmNzB/aItMfFcAuxy5LgUGpv6JQQv71Cd7Ti8ddcWn55LaPT3Jf+5rpe9RytMwg+IKv98H+FEK+d3HMim4OULx4jBOE9gtbo7+sX/RUmoCbPckl3Us9wgNMHCjKdCdXIqYfDzVpDdhxY4htOI2M/T0uaosRhFB/BiEIBOZ1Sslc/+cI5A+XTPdh+K4ryCfGp0vmDtfXQ0dQrB4HbjuOxqa92Msnvb3ewDW1MEwig9UQbRg6n41XDj3+fp1W1x/Cv28HYJ923ggG5qWVAbw4mzD9epA3e6VVLm3xgS3SE8f7tEPvfO5k6nK6TvWziFfR2FFS1FOBldxF9d5I8rAosD9Bh+6m9jyu8Vzol6AhsAhB1VAfaJt/68fflslLdMfJ5+ZCW5XoHAbzfFp2cXJIu52MsICNbl8pjbGzmYo9gs4o6K7BaR8Km1O+sIBckHTveuz/UG1LWD/uqhVfjYDZyIDCoW3pKT+/tgt8UZfZbsdbO6ZWAseoZL1xVSphd5s0ZS09LwUje8CLlgZAU6cGpBr5Rhgv8VYEak7ZjbllpuDCbhZyGT3d6u8S9/glJ6W/A6fKIiaXs9XgX2GpuyQoHlPyUQliwxD5FE+uX0e+RFZmO26VY1iFXMjSrS/lstJzDhvI2M9qpM2ZCrwzUSnCXBuU3w3KJ144ad1N+iIBiN2z3B9Gwir2azndvTxXy+vKO2kA+bnyk7GxR7GOar1jrx+hY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQgrfh73Dcjzat9uyZAz13N6kAyffk+/tVMn3dk7qqOjMTopaRearyofyU5P?=
 =?us-ascii?Q?zaToRug/L6ge95iC3dJ4FCJJ1o3rNAz1ju3lcBxwzomfIMnN+pvqUTsXs88l?=
 =?us-ascii?Q?lARotX95syHC5J73XSUmZ78MQtyrXFm8JEYMymfFTnT0j54JZOUVaPvpytw4?=
 =?us-ascii?Q?lTsAMYKsKfDjFolnopYaXpwUey/9OyueYa/woiqXVcEYkhph0rG6PYreW1Bd?=
 =?us-ascii?Q?L0jPY7zZYOaiYnHQEezAVKxKIfR975mFJqDLsxlfqRyB02FrmIQMaMlenpkb?=
 =?us-ascii?Q?Ejc2YVzarn0vlndBbc7ezeUKtZt6weiqhMQBG9g6blc2DP9WaR20VPMbsKCR?=
 =?us-ascii?Q?q1ZzL9QZWJ74HMfbaBdciV1pWpqwqrEzmDo9PJHxG0Yqo0iWB48HAM0fL2sE?=
 =?us-ascii?Q?0a4n5DQG4GVuUKcR/M/r3qpLQK81gicF97NoQQRcDM4NFc5VUxRmF1Om/vdO?=
 =?us-ascii?Q?3eExXaduOGzuqlfxIGaDELCm+QJFpU6v2aI+qN1HvBUMOILEv5OCijLriDMe?=
 =?us-ascii?Q?NtamlehwLQyieTLc75m9ReQjEoJffuANP7iHDgAf4S8MVF2+AsEhDD31HjaF?=
 =?us-ascii?Q?Tt6KDVH+wMmyuEOQId4Aw+/1i+Pq/7mA0ncyUQhUk1nFT60vOPNXDYzDd5KB?=
 =?us-ascii?Q?H7zo09B7k8k5BaoSSDYhgKMYO3Q+VDq+rWs8I6FZdDZ6Yu420fYIZ28C0yY5?=
 =?us-ascii?Q?oJ10omKQg3hPa6Sax1yvnMkbh1RumblNsAnIs9WW3x/sf3LhZc9Hj7CwiXf2?=
 =?us-ascii?Q?6HDtMrlo7F6RC3lxWlLMg355CAASTNd/AvNgLJc5d4fsXCHmHosA5FvZKpyf?=
 =?us-ascii?Q?3q37C4Y1daaybfUDFRChdQJETqUeiAMbBVDJTpwemoczZ2Y3t0zXDjJVPEjl?=
 =?us-ascii?Q?C2I1XgqGG+/WdRcnaN/Yn/fY/u296B2G0RZ4lj1tzcLsNtenYKnpo8i5VOIA?=
 =?us-ascii?Q?HelJspKF4391rXM9Ph5ViwBkBuzj8jZ1z6MIosFnY9L0Qzd+abI/uHti5Vng?=
 =?us-ascii?Q?GdhGqRFd5wbj9NkshfS3vr9t3WpSN0sJUvTjNkKjT2Nn0uh6XRobhwc1nSRG?=
 =?us-ascii?Q?EuqQ7oOc1T1rdho9q06wbwLI7VjFO3r9JC0YQUJpfWR/n60mXEa50PrB7SzH?=
 =?us-ascii?Q?hKovbb6/rLGR3564QzZDWzZ97H85EG71HXvR6yMWFT0Xty32tp84OeY+eWZW?=
 =?us-ascii?Q?tf6Rk3itwJc7iqp4bgBqanvcgvrA4gEUYytCWHSFBl7b148zjkB+kDENZPad?=
 =?us-ascii?Q?+Vd9IrVE1Eo/cZVGPhrNz/nFBFKChJcHQjxH52iY6B1RwZ9Yt9ZDSyt69B16?=
 =?us-ascii?Q?7yaEAoBCKMaegE4asUwaRSSb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f831a-4162-4cc7-78d3-08d97218c856
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:41.7976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c0vlJApVJOFoZlpwsOJpA6+ZDFLq2QKonjhtz8Ik2++oXd0i3h6kjTWklLX3zSzaA/e/oOvMLCnO0f/f/mESX94d4AxeA0TsnFfGtT823wI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: h3uXkCcX8QQwPnEIfzmS5MhNfQ2xguj0
X-Proofpoint-GUID: h3uXkCcX8QQwPnEIfzmS5MhNfQ2xguj0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce a new link restriction that includes the trusted builtin,
secondary and machine keys. The restriction is based on the key to be added
being vouched for by a key in any of these three keyrings.

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
---
 certs/system_keyring.c        | 23 +++++++++++++++++++++++
 include/keys/system_keyring.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 08ea542c8096..955bd57815f4 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -99,6 +99,29 @@ void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
 }
+
+/**
+ * restrict_link_by_builtin_secondary_and_ca_trusted
+ *
+ * Restrict the addition of keys into a keyring based on the key-to-be-added
+ * being vouched for by a key in either the built-in, the secondary, or
+ * the machine keyrings.
+ */
+int restrict_link_by_builtin_secondary_and_ca_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	if (machine_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &machine_trusted_keys->payload)
+		/* Allow the machine keyring to be added to the secondary */
+		return 0;
+
+	return restrict_link_by_builtin_and_secondary_trusted(dest_keyring, type,
+							      payload, restrict_key);
+}
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 98c9b10cdc17..fe4be10e66ef 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -39,8 +39,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #endif
 
 #ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern int restrict_link_by_builtin_secondary_and_ca_trusted(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern void __init set_machine_trusted_keys(struct key *keyring);
 #else
+#define restrict_link_by_builtin_secondary_and_ca_trusted restrict_link_by_builtin_trusted
 static inline void __init set_machine_trusted_keys(struct key *keyring)
 {
 }
-- 
2.18.4

