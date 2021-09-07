Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB5B402C74
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 18:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343813AbhIGQDk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 12:03:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6414 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242334AbhIGQDc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 12:03:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187EdjnD020764;
        Tue, 7 Sep 2021 16:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=TagJP8q4B4xHN6BaPYBQ54aG+H/V8owz3wMaKpjQkUY=;
 b=KhhidOpS2AVx+qNq25rX+O+XbMV3MydFzWU5pJLZ9LjeJr/rvXvW7x+ihHI+xZquDWmZ
 /Mtxv217zRBzjwNFyk4Ne7om+EK2Y+/g4EkclipN5VHpiH/4GRr2Q3AoZiXZJ7mVd+Rq
 qARYSUTspvsH8M9Ex1V4rfWYiZOmCY89zss67Z8ewdNqKWTc2S+pcQ8J0PpAQvtdzon9
 YxGj85wijzM5vop/zVBpNgnovzMgRyPHuD6GtNo3skFUujM9i3LgcagB2fFe3GFHTKl6
 C7jjilY5ErYNfkTN3eYYgUECa3h94g1dUOXfqvq1Ddn+PNeZv50Rdc7xB3pmNrKX3ANY TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=TagJP8q4B4xHN6BaPYBQ54aG+H/V8owz3wMaKpjQkUY=;
 b=JbfFNPTS5of9/RWgK5KTneP2ft84LgC33aULvpzPadmdaztQSceU6NdlznT9Xz/MWsC9
 plnSR11GD515440eSPTIj52Y45NgyKM9O+1+SzdNXCu75TuzEhvexoS7pmPkDGFyG0dn
 nm0ugsMudHL+tFWAqTRj8q1KSZ37iV/fU11EaVT/4wsJovgOuVQz+qYrLvwz5phpmNZH
 rsOzodxnJgNmhQaYcCpMYCrnjavdxgVQQ0Fu6VQjDtCkgorxGNRuGGEFgbllY4arrzYT
 1GYSCW6jYCQvOaVCPgu8y2UPVV0OSNQ+XRO3K5kFKK0tXCLIT6phpHZ4mypUgejSm8YL 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3awpvnagxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 187G0G3D134760;
        Tue, 7 Sep 2021 16:01:41 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by userp3020.oracle.com with ESMTP id 3avqte3dcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Sep 2021 16:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah2SMYlhtTt8KwTuUfNSu1Uq5yVApOMwYJFAoTXpLnzHk3LRSld2Y+I11dy0YypWso73FgWMIN9HjnwSK/txRyNeuniZKAFJJe/B1e69Pe5Y9/lmCBWJGPlXqY7Axjt5sCUPLWYW/xSCjKyohK3sJNRDT90iwYAyZxjyYYHZbe2/8MyqyVKIRQqNQzouxvQLuJ64TOuRmhxZFT1XEZl7YmBCKN/OIdDZxynsJFJ5kJy1x5M5QDtaIZYfCrpxHJ5P5p+d6x0g57FjLWCjJJX//YnxRH43rt/SWj4skGoW5FQebrxU8s+PEAgTDqc4UlFAZalZZ/8meqsx3PoKdfYIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TagJP8q4B4xHN6BaPYBQ54aG+H/V8owz3wMaKpjQkUY=;
 b=dzCFz9eFKK2PjUZhiFKf5uPboFt2gvZyI2qwqS7n1E5MK6OwnZdMs/9xo3BKVgrLR8ZS5DO2Tgyc64CddB3ZA5aaaIbdl8sKnUS3qX05lMCxbUuPwoOQdgCeqxUshvetbdaOta8d+91W+p23AtpfHQXgolpzrhex8ku46fgYJi9pYnuQLpa5aKpKRzHtn6dmr6wMxctR7Yj4c7z0MTQkcBwvjPXVikX1g+e2skDiYpPyERp4OxTmCJJ/a/WjtqMFfPnbTzvhAQKUaeZuEOaSk+lPoPE9z73TEOzAC5Bau/T1zvnWJydc5L5zGkYRFO0yDIuqMvBls8ZhrjBI8FH+hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TagJP8q4B4xHN6BaPYBQ54aG+H/V8owz3wMaKpjQkUY=;
 b=mKv76pgJs/MiZs/2IZnpFBio6H+Z1g92Hvna05bpTZ6Tq8BleDMIPoDDOcCkeGxGjC+txbbKkQPSx9vfylWYPPPn376MGMBKJisLSWyO4JgJSOcJLYLCcTIUv1XMXwd5bjYA/TA0mxRhYVdEszo/MMNVJZgFuFGrC+eOASI7V2s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5004.namprd10.prod.outlook.com (2603:10b6:610:de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 7 Sep
 2021 16:01:39 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:01:39 +0000
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
Subject: [PATCH v5 06/12] KEYS: add a reference to machine keyring
Date:   Tue,  7 Sep 2021 12:01:04 -0400
Message-Id: <20210907160110.2699645-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210907160110.2699645-1-eric.snowberg@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:254::28) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.13) by BY3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:254::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.4 via Frontend Transport; Tue, 7 Sep 2021 16:01:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f05f752-19e7-481f-5539-08d97218c707
X-MS-TrafficTypeDiagnostic: CH0PR10MB5004:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB50040B7EEC3BE79BC25767BC87D39@CH0PR10MB5004.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0DzVL0BMmQbcezLerXTAB1UhWcbxZEj7rdIX0WNE/f8tpV/fPFFMCAc8ekcH8Rfkt5dYuu5ITy9ddPdZ5EzuWXjdfGnilnlrSvNKfv0VPEqP00s+DA591V2NUzy/+bo1jHEJ0YCBTwO4BUllOXrIvdL+UiW9UgoYJz8DRZfU0VcpJmCT8B3L8WG/DJ2FyJj5e0SYU28EA/cDoI1AD/5346ja/DNNOxE/7DGWQbZUFAXZhudjaMNxgTe1zYfJBHIhO4Y4PQ3Ahqfx3iXFS35q0fGKPmGH0Hqvn4mGi7mt3BXxT2eq9iBBNYFHyL3lxi2SCjIBQ+hpxsmghMuu6UoWuxXHMHZWfiT1D5a749QKUXvs7nq5OaXTxEjG7cNZJhJlaknHbaM7MrSyjcgbTYIyvPfezY/squOOfz1UHBkTXIZzUfGE+QXttXVCFSuHGUp1ydbZsPLQ35djA25k6L4ZxKK5Cw8zFZjdeZMYO92yhAfXVHsP7NPRzUcLgtJAb9kHFZCXCMFRe5S8cytAfE8uCOG3m6jc2VDuYEj8YlD2lSQl/z1GbYIYb2zGqP594yXV4RT7gd4QQpsI07FNyhNkeJMgQujMYHzirGJBck04wx2I3N2bGCcXpEJEM2H5KooISS/5hc5Epk0RnjiaK+CGGxTpO99kyrGL2nf/SxWt0NLQmEK0fDCnbR6J+FTHg4NU4g/6YTjslMwS2Zfmc66UcaCOHMg2rpbbqoTgPXIMEc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(1076003)(66556008)(66946007)(508600001)(66476007)(8676002)(921005)(8936002)(44832011)(5660300002)(186003)(26005)(52116002)(4326008)(7416002)(83380400001)(107886003)(7696005)(36756003)(86362001)(316002)(2906002)(956004)(2616005)(6666004)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axoAiYdJ6EqPU6YgqMmYvEQm8pVX1L7ksKgCmchguLllEiF3a8jJBmDyEK0K?=
 =?us-ascii?Q?I58JrXH4+IHUl2QLibScMfP1PQsoYD3T4LXr+xyU0gEUKndzWmXoVzvp5Zrm?=
 =?us-ascii?Q?hQqpv3DxBpQHfd3YF6f0FJudJZTsK0giKQNd9y2imGD1wu4fIO/fyX7+0qgM?=
 =?us-ascii?Q?OVDz2L2CMWEiDfou//i6kqP0GPWSotSAK5JdAJ60ZNkTL5SliVJni32NkD2U?=
 =?us-ascii?Q?505KNFCA6Q5O8xQB7ZcbnKwmNKS3SBtldPi6znogwwxnzgLa6XkUIs2ZvQ4l?=
 =?us-ascii?Q?42j15zvcYyy5qeM4d1mq9IpfkOebIiJntelmZjTDEDKb58H26LLi21j/tjiN?=
 =?us-ascii?Q?/9kAn6YGAQQRXjKthsVc+W1EfgtW2wn8m7+dAWqPr/4qK3+jI8QsDp2+U5Cv?=
 =?us-ascii?Q?8p/dBYUHpN8d7KPFZBGXHsfcNO9nfwvD17hKdK/Uf1kpKzEJwMGTBqd63HaR?=
 =?us-ascii?Q?d8e0UqItfUUSgM6a0WgBsHrNiQT4ZOodfdGpHTtgKo05roOD2LsawVM9+44Y?=
 =?us-ascii?Q?+kpVykB1TOPX1VD7aIPwq/inZYlMDYq9WjWgk1QMeBIy3d8H7g2wb/uIddHV?=
 =?us-ascii?Q?116cUd8kL8gSVaiKjukoIr92svlUwp7LoIdS+wAdxwJiBk1w8MuwC6caweKQ?=
 =?us-ascii?Q?A8vFWp75OdlOoGAB+L99Aa07y5+7O7l200Kn2A7x6RAzLk1S/nZMHIboXZIa?=
 =?us-ascii?Q?lVZFpSbx1m+Vc4xcO59RVSw5Ywd4pFnlpYJ7/2ci3if7krvH/QyMPcqzjVpx?=
 =?us-ascii?Q?aBshVGQWcogkS/s8+lxpCxp0cdnp9z2XjFiwb2WTx/lTv52kNoha+UWqq4MT?=
 =?us-ascii?Q?2gqZmY4MJSdb8KerA9K1X1RBt3I8I58TThZIdsy68irji+HAnPYAnG01CgSu?=
 =?us-ascii?Q?VanX575ycFWgdDEO008ReKWQtu0NaE/idjepDNXo/WSAACX2SLE6i3KtUsKK?=
 =?us-ascii?Q?jDZ5dnN7BelV+JkgynefCm/6j5cVNXxk2qxZQtJUZ8Dp2vXce1e1nV02gTal?=
 =?us-ascii?Q?5X5I1Onoy3YpdYSnPlxjaMJMXu1Ro6iblqoqH/Z0dfvOrKbw/tXWk+yDG4vX?=
 =?us-ascii?Q?pFS7+WUq/7zGle3b966PvZuvxYJU/yameqjgKy3RUS110ujarXJ4+0PwgxE9?=
 =?us-ascii?Q?ShTC02NgeGMLfIWV9lwAHY1aWJxV1HUiOXf2jJupKZbMqsr4R9QtZ4wH1VFj?=
 =?us-ascii?Q?v/7eBvljDggo5VK3WgT4DdpvB3ROM0hJOiOUpiuIkRYthyySjJfGc2cBEa+l?=
 =?us-ascii?Q?P8RADQWDQOT2DB5+jGls0i9dKwy7wNKTS3IfMQsz3XvYNjwGw0hYaiikQMGA?=
 =?us-ascii?Q?pevQY/5JQ/6LiqOysE3JkH+U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f05f752-19e7-481f-5539-08d97218c707
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:01:39.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ARFhON8NnszfeDUtwUPu0qzSbZ0aD2UQ24hiNpL6gUw990J0JhzTIpl5U5LmvFLA/jRz6TWBft5S5JEJa1Fs6oHJ6lasT/76D2gFjOwhIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5004
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10099 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109070105
X-Proofpoint-ORIG-GUID: A2D3X4v3p0vz9Yw4rJ8GhhqHhZEXXBJr
X-Proofpoint-GUID: A2D3X4v3p0vz9Yw4rJ8GhhqHhZEXXBJr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Expose the .machine keyring created in integrity code by adding
a reference.  This makes the machine keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
v4: Moved code under CONFIG_INTEGRITY_MOK_KEYRING
v5: Rename to machine keyring
---
 certs/system_keyring.c        | 9 +++++++++
 include/keys/system_keyring.h | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..08ea542c8096 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -22,6 +22,9 @@ static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+static struct key *machine_trusted_keys;
+#endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
 #endif
@@ -91,6 +94,12 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 	return restriction;
 }
 #endif
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+void __init set_machine_trusted_keys(struct key *keyring)
+{
+	machine_trusted_keys = keyring;
+}
+#endif
 
 /*
  * Create the trusted keyrings
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..98c9b10cdc17 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -38,6 +38,14 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
 #endif
 
+#ifdef CONFIG_INTEGRITY_MACHINE_KEYRING
+extern void __init set_machine_trusted_keys(struct key *keyring);
+#else
+static inline void __init set_machine_trusted_keys(struct key *keyring)
+{
+}
+#endif
+
 extern struct pkcs7_message *pkcs7;
 #ifdef CONFIG_SYSTEM_BLACKLIST_KEYRING
 extern int mark_hash_blacklisted(const char *hash);
-- 
2.18.4

