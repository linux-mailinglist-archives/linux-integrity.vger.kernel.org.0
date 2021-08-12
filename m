Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF23E9C3D
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhHLCUa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:20:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41312 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233426AbhHLCU2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:28 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2B8Qg031617;
        Thu, 12 Aug 2021 02:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=mPhASgRgSvZRc7FB+LtMMBO1Ye6oIVA/Xh37pGQL1Xw=;
 b=u7gklOs6fSHjydqHC0dUPjuD4Oo/UEqDgDJOdFghUl17edzQCC0T6DwUe/glDuQ8Rwd8
 sBPsPtvoKm8oqVE6XeWtc+PQDhzC0I1J7cF1u55dTsIMrqRfm6BJuYhe42vL5aZfeP9n
 lgY3NkkVPoCgX/4u0ApPsJIv/b+cCaOZygqkinhoZJktvEXlyJoc1mFOKkJK6McMF533
 0QW8bqCRDGu4wzANCyetNrtQJpBIljqxmJB0dFgw3i7c1TYMhJTBJsbmSxu+Kv0wVrcw
 jPQTj+A+IbTJFnjPUl5oSUgcdnYk/AgZIyUOaoqVqn5lFUZM35QOxXkCjnaGTy98Matc LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=mPhASgRgSvZRc7FB+LtMMBO1Ye6oIVA/Xh37pGQL1Xw=;
 b=xQ33tP6CAdOv7jpT8gE6F5ugayV/qEp4tIKEBttY8Uw1djBitYkPkjC1534Wjf0SVsTC
 Jzp1Zd5ykwoWrDSICXOFVAph4oDjBl0sbYmhpUHrg4SZofS6osYHdbvefTGwGmQPbpFM
 XZtQO0BYby5y9wgiOrAzvKQ1+3df5QRUdJk54KSQerXgKWz1qvfBiiw4KEdHdfdScHSR
 tjEAbKrTqbICW67ubTAWqkjrQgcx09KgWTMxcI+Q1JOAOiaBaKhnxIyPNawPVhC3koqn
 st+mED22s365ybe92xRkpQIi/tI7jfZQ/grc08tA5Q7Or8/RR1Co/Zdchdx2XiAKBHfo fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3acd649v17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GUsP117958;
        Thu, 12 Aug 2021 02:19:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by aserp3020.oracle.com with ESMTP id 3accrb4sch-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OucZVUQSI6YwWB5FjudaizgmXschxi96zFzDqkoyzbsq8MU6Vqe3EyK9uSMglUklGL+r0COeIyJvQYWHGzm6IpmSsx0HY/lZK6VlFsphV4owHv0UOMkvAfw+W1/pv3sQ1wp2oEx+WwpMRb/iTortw6TgA1QD5cLDi5LYyR06QZntyq4T/nyfcxUNKPcLk3B6x06gT2+liA1y6YeF/BtXXBhFLHR9aLkTRGuX+ypTL6OB/dadqVkKpgrNgqb36v3uLZsYzqzqjnny4Q4Yl6W+gxg3msjU/Fmi9UU4TMv6+GSiHc3/VJ+vjwN9bnnW5GweTC+IBUwSKf1g3rlVvsYMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPhASgRgSvZRc7FB+LtMMBO1Ye6oIVA/Xh37pGQL1Xw=;
 b=eH38ztmAoKgn6pWeCBTx5GjONZds/kRloVb6k8+lcTTgDtRSH6BSWMk5AJBK9rjEGU0fRf867sFjeuCg8E+eXzTlsqnJB4cC28Hhd+0nBhXFg1iMScdErMn++9PeqNo8HWLyDf8CcgXRqxlGkHw9Dp16uoO9Xnk8FNTdQQbCgPj2wiFt4sEvh/WPoxRLWB2NgOrDxlPWeQvXJG2Zb2ZIg64uLln17nnUq+15Xho0dJH0MikW0v7frtkR7vDoxZ/zwD/gJfBl0pA0iMnbcq+Ocexnfb/d9WDic4SOkXZx6ObRy5k65uKYR4TQMzevFfwZAK1YSqaKYbYZTcVNWESWpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPhASgRgSvZRc7FB+LtMMBO1Ye6oIVA/Xh37pGQL1Xw=;
 b=WvpCdp3+x5YEjs8U7n+15JE4bHYBl9O6MObAtbj/Tu8o2EURqrsqvpbP4mJy343+9gFc4+SmRdZsJiy/89rupj8zEr2Vp+66jM5HzmN3i8yvNFc744oZHXlInH6mSk5HhPH5ozJBZZhfJt2nhOYv50153Ydq3ZE1FaTsWeX0Bv4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:33 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:33 +0000
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
Subject: [PATCH v3 08/14] KEYS: add a reference to mok keyring
Date:   Wed, 11 Aug 2021 22:18:49 -0400
Message-Id: <20210812021855.3083178-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f3ffa8c-d3ae-4762-6e9b-08d95d379f70
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39607B00172ACBBEBFFB8D0487F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UJsyzBksEV5RLm3sUWLI/+4Z7HOGN4Nma4q1Fhgl5hCPlAb83isfpouvnIJQpoDxm0zdANkOZWhN9fKmu2spC8mHaqbFQxlsXlo8z2amoQSgm+tLdFx8Fb/fCzTNUqdNe9XrdHNF4LkbHN7JZPeN9w6DoUPZvX7hzPGmZrXC6X6M+2t0fdVKJyRfi7VwyZQzq+jqw184KBjRuEqtxjPX+Q86qj9Cwgr/3aTrwti9c0tuUt7tobkNq8YEUPv1+RNXIgUleUw1QJdk+e7kIjc9COsWLNPJ4dpc9DcEWIhh4Hjem7iHWnfVaDnwUb5ppxifnzl85LPdyY0VuixM3Mi6qRevx1W7JZwYYEjmkNcAmlUU48kjiupUAHvCg/yHZtYWi6K8IjfVE4qsl9d+cgR+prkogfrGkUaPZG7qmPsHO46E11EUdrD5hgAHbts9Shbv8F9ERHTUfZDHgI76qpa1hdn2KDaoi0v2bGyK+hyQ3pLbwWz1Vc9mjnt89oSB86+JspA+1HAQ8WsxAabCv2/3yOo10kZI2h8Qn4ctUMU7MC9VcFrTTOsviCW8/aXaNTt9e/i3YLtSX0MiW9osqIGf1fD4go1IXZ3tAyzwd0OYQckq1ZGL6woYUBib/d85hNjdf10RlyeRQ1TBqE9MjhyfMkajWIHXfpxXMNh92ikkcleAIP3WE0SBvwqiFFQELWf9CG5qLAltCpen3rMSDqeiMa+kI+JM9PboVJFzovh6nMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cVDkMN7cqHW/uNodG0TF04d2onODwwhda3DG4xtjdA9oAH2yb+53ip8lKPlr?=
 =?us-ascii?Q?gqpOpzJy8cfnhKT4EqCuvCUjeconoBYN8trBWL1RAv/sFCxSv/2nVf0qd+vi?=
 =?us-ascii?Q?V5TAhDXM0kY+ZgzxnbrS70ZRhMoXY381zItUJ85wGI1jxY473c0EVfVv4Snq?=
 =?us-ascii?Q?8OIRAC6nMDX4ar0qcpNPERrszRb398Q0fg0vKQKgYFQXlqOo2Y2y0gQI4MqX?=
 =?us-ascii?Q?cV6Zp77zKW8HaKHb/OqjttyFUuAgvWRCsS+zeFNNnt3sADFRltH5krDssjsG?=
 =?us-ascii?Q?kicRBnKdl7ftnBWm3udQtB3K9KGiIgC7VGT2v90ZbJDtJldIbxX9H2IpY6Rw?=
 =?us-ascii?Q?y4sGw0sUq3ABJtyLyiZLM3ThHQl11oayDlSkemFL7dfYNlU8K5SmRdSYPuu+?=
 =?us-ascii?Q?Ywztz95TYwZw4QT7BQXrw5ap9YsHHKSOK7zlQ5Y6N+dtH7x0y3gBUHz0lnHw?=
 =?us-ascii?Q?hu2ZiZrXRnp51qXJpAUhhb5zp3WY/coXyXmz8plCiy8Dt0SOXd+L1kTcksqu?=
 =?us-ascii?Q?5IS7gD/sFJCQF9QPXdKRzIRMnZAKb1RXoRAaW4TCEJga21EMOA17zAifOD+D?=
 =?us-ascii?Q?dvawL9S64CPjCSpUgmaeCGDc7C2PBLBQwNsx8Ds1L7h0rq4tMVR5OxxRABfp?=
 =?us-ascii?Q?o8QO7Rd4fimTypqsiP9IWG8sQ6YqqMz1r1A6UQyB/Cjb5UqEETMFQE/kPOef?=
 =?us-ascii?Q?dmzRlIe2Bg++uD6QfsFK7S7pbymsH/NrddTCC0jJhfEyj2w0+fSzg20CylyH?=
 =?us-ascii?Q?wrjkpoYgHbIq3F60aE0Xtd1dRtSsv/OsIGjY8CyUY3DYbcAPx9E6GoTwwk+2?=
 =?us-ascii?Q?VyFYof5UntXuVpjotHwGH5kQb2Beo6yFzLMxz5DxLK6Ar7eYOfoWK02qsT3E?=
 =?us-ascii?Q?+mOowFG91SLPyzz/r8aRyIAExzAa8yWhfeZ5zSJfBGzHeyAkcmUhbzzI481q?=
 =?us-ascii?Q?wkQVRk6GwVHlpUVTrkt9zb5bOLTwQBFVC9QUzaRcK5Zs04CBMWeq2Y5q6XPS?=
 =?us-ascii?Q?u8tWvQp8E5yQW7RO0xmJ2dTY+9fERA/IHIiIa6yuEMCh0tVeEzFPctVUd8z7?=
 =?us-ascii?Q?vDnk3wjzhA84jHMe18yxN4zNULXPUNpy8nQNagtwl2XNLW/HLVphZou9mMUh?=
 =?us-ascii?Q?BOmORH/rTxFqa2p89MD8wSkk5qYN+D6gxgPTFURxqkmmCQptWtHdlp6MKhCo?=
 =?us-ascii?Q?dVAAOX2Z1+sTIWAWYC87FuqqbzRIinxNLuDyR3/JMQ4Sq52AlusbU0piggC9?=
 =?us-ascii?Q?hlvq5fi10apd+J7sQHeOIonKJPBTyCV8ztNWqjoOXvwJpJJG1Jnop6Pgjblf?=
 =?us-ascii?Q?l7v1LxKi+oiZ03peRlHmnKSQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3ffa8c-d3ae-4762-6e9b-08d95d379f70
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:33.0699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8ZqkDMCesFpIHowGykIlJu1jdh2B6nBsL6cPsdgeDR/r8C0Jx9WiyBAjkkWfWfCzEGzc+QwNXwh0LOXFeRqW0P6CTN+8LvBQicWIlnvFp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-GUID: RculwFoZP3GrEl9oaRQ-QRtOl_pb2h_P
X-Proofpoint-ORIG-GUID: RculwFoZP3GrEl9oaRQ-QRtOl_pb2h_P
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Expose the .mok keyring created in integrity code by adding
a reference.  This makes the mok keyring accessible for keyring
restrictions in the future.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: set_mok_trusted_keys only available when secondary is enabled
---
 certs/system_keyring.c        | 5 +++++
 include/keys/system_keyring.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 692365dee2bd..2baf5447b116 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -21,6 +21,7 @@
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 static struct key *secondary_trusted_keys;
+static struct key *mok_trusted_keys;
 #endif
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
 static struct key *platform_trusted_keys;
@@ -90,6 +91,10 @@ static __init struct key_restriction *get_builtin_and_secondary_restriction(void
 
 	return restriction;
 }
+void __init set_mok_trusted_keys(struct key *keyring)
+{
+	mok_trusted_keys = keyring;
+}
 #endif
 
 /*
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 6acd3cf13a18..4fe9cca58685 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -34,8 +34,12 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern void __init set_mok_trusted_keys(struct key *keyring);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+static inline void __init set_mok_trusted_keys(struct key *keyring)
+{
+}
 #endif
 
 extern struct pkcs7_message *pkcs7;
-- 
2.18.4

