Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833033E9C5E
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbhHLCVH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:46542 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233675AbhHLCUd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:33 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2AgKU019120;
        Thu, 12 Aug 2021 02:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BPY6yZmsFQ4j5wzxHG1IXiZ/qYgkveaLJK+iSGYbMJ0=;
 b=l9MHframtlnRTic1LV5Auplb82haLixVBbg2ni2Sjw6yMQbu0MY+Z6ZxEop1qkaR668o
 H5IXuKgYXzlpaqSjCJV2E5B8iJBM1fahANkj3JK/SCpyuBCMcGCS795pw7DMatuy0Ubf
 OQdYMfxlH3cNjX/L6h26knlKHaTkBMRR9H/y2b+NMBnzsG12ERHwU8yv1ipfRVLaY1hq
 j8LsX0OfitPlV4yzCET7wvMk2a5D4l08Cvvq1l7tIUo+r/v0jNvOqj8etAdeu7XnCSP4
 ntee23LX9z/9KSXWPNgsgpSu0m3HQ/d7h0Nyn52G59kojOBj9MJRrYbRfBzDLRm+DWuu 3A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=BPY6yZmsFQ4j5wzxHG1IXiZ/qYgkveaLJK+iSGYbMJ0=;
 b=sFNncD6aQOE5pe0NHL6kdYR6tgCj9xTx1sEDXzp8bLWHNdD5RfBMLEKf+aAW7a5LruZ3
 FoDTOiMv32/mSVHZWUFr1AoHRQYIp/MvoKOHb6Jm9ST1BZnww35gVCK6AWng/K+YZ6z/
 GvadL8gHlGzn7BCfQJbEgb+BpYl6ayNAtzksC2TgPMjKW6YAl34T6zp98w4SBJliZmfw
 Y6+y1NziuOAtmLaM7abwthWqRZM1x2jFFPd/HJNPr9h+ikPDj685wPxVdohsZyyza1jU
 U/+dQ1x2aw47XzF3V/HKXLEIUy+ANpfmsGuo3i3HRMlE1lQjN/2PdZ99j0pnTNhWVbWn Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44c6gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GUsL117958;
        Thu, 12 Aug 2021 02:19:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3020.oracle.com with ESMTP id 3accrb4s9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyNjPQZpT8V1LPP8AaMi90Ah10FrUKyC2iibkdGtSKHoJRp47y9ausnz0VgoC0B3YHAqIOlE2gM5t2T3d33juFg5Bfw1RXlZrSN3P/kB5wCf9n2oj5UvUKdAwBlYk/IKRtsWsVVYeplyJl0372oEhwKePCRfKBPGwHxIaC1bHq41OEgxv4FbDRJHqXlQArdCwlSfZT25WEwcgV3V4XqFUOZmQSe29sbuPlww28B6HxQckulyFXvf3LqRNIleRleO13Jj2VYnwU3D7Qx0rQg61NgfQojJP4oAdv6aKyOFWcOroMNwDxGOAAejE9Mq3lKPL0X81HFQK2Rx7Lz75GRqEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPY6yZmsFQ4j5wzxHG1IXiZ/qYgkveaLJK+iSGYbMJ0=;
 b=jtS3R8rRtjL/bFuSqQrOKwulDzVcG3Vy1fxvVF3FDz9DTmjGTDlG8hPFhbZnc+UR7PzzsO53s45GJyaOVdWIcDYgXmlTVLRd4DAveyxNYqniU6fLhURq0/+w/am7eKBgiGCw1WLp22nVNKnZflCkFf2dIXtDeHkCSKUIxPA36ch3pyoxrPPhem0UXwps2y229/6jx6kLVqSynTKg5bSOjfDO80p2VTjnlTvXK9Ti0HUfTAYWNA3Q+v1Pe33AdO4C+2IjjY54y58z5x9XITgTHoBHwJEVeeuI2o8Z8oR4QPy4DcopeZts+2fxDhr0Nu9g5xWTCYhkud5WzNsQf8sA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPY6yZmsFQ4j5wzxHG1IXiZ/qYgkveaLJK+iSGYbMJ0=;
 b=j1IYBxgMlyLV1hTtCjAlu8T92QVhFRBs2IOgv1guY34W/ATq1dSijLN88Sl0OEbaVOX59Biv56MgroOoW9kypNFXv2K3aBAK+vVDpAIrdDw6W83D2Gq0WTxS0Gq0oYI9QF5yUhdFY94k9jum5vznm5MC19wmOJDDLh7P6zjKoRU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:28 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:28 +0000
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
Subject: [PATCH v3 06/14] integrity: accessor function to get trust_moklist
Date:   Wed, 11 Aug 2021 22:18:47 -0400
Message-Id: <20210812021855.3083178-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3a7f66c-38e1-426f-79f6-08d95d379cac
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB39601CF4906E7BC737BB4AFC87F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZ0XskAdtGGA762KWpSe+nQRtbUikw7O5Fq0OQXmrRwrNs33WY6fs1/1Ils4Gl70tPqH/H+I7yqUZu7XfLwbgbdmQ7t6aW1C0RU167WgK4mswOfzB+NqlQgFScRjGxZTJ8kfGoDytzJIY3d4uO+jx0nLUNX6WqWQQpBsr2UZRuT74lCIoTs1AbQitWFR65TU/Pw7om9cXLwrISC3N66lqbhBc8ndyYja2BK2nif2kftpjwwrioPSpzChPDr1ZMYJu+MKq8t53AGBa6OgOFlD6MzjEc6DQz1f20Dp/XwuKhqkpKcsQSFv513XmoZKk11/FxQ8xBkaH8lVVJd7Qv5wkMXdvoHFOxv72UbQ3rP1HfQUtMNXsTMPauRQEL4u5n4bzu+fmgj/f5JzWLrvdI5Z1xBuqclE5sIxuYuCl6Re93YDAr7rKXB4HXcjYPJrhXWiFtCvnpWRRYUzgD1UiRWPiBFxni3aBo2j3TpVll9c6yBAdCj4XYK1/51IR+z0EMcq/jugmzULHKpfsW+TZ3RBYKo8yuqzHHKGj4FocS5p6CdE9CV8vH+3ThVKU5aG3bm0j+0dXEzlFGkse8XFESsq8PKk09fQ7FXS/2pRMVnq4P6rL/ZJjvliXjXZQgyw5183hnL1gm6pNosYXGy2JzgyN/WtYEwuD6NdcSQGBoKr8sLgSV2TEsqhpCfeQb8Lgfq/amhMYK1/ew9R//oqEPnVLA+WfGk4gySPHWm2V6vcYS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C8LXVeDOxcY2MKjqhArUomRQozNCdjdGlMg896tbkeNl97yq8PUpipL1xO4E?=
 =?us-ascii?Q?pOYVzbxCwXoZeuGkSUGHo2n3C4Y/eUt2bkarI+GLNTxg0KH2DkvnPo3yNoUJ?=
 =?us-ascii?Q?bLx97B3AiOtBGuNb/rsnsqIaxmVZ/SXbcIpOedCFLmC5xhY+9VdpnGYLx0hg?=
 =?us-ascii?Q?gv8HBNEU+/6FdU5H5VCQnfr5dPdpl6VDoNGQzkld76w2W/f6j/hXVRvdK9qs?=
 =?us-ascii?Q?d01v6oHPkGUr/09IadWmQUiR2XA9tvval4Db0YTaepeqFj8qRUgmEJmAR41Y?=
 =?us-ascii?Q?IspbeAmJ03iFtIGh6WTi7DpQVSV+N7MKH6/G1Rd+sm9VJoKKeeLCJmWdlRp2?=
 =?us-ascii?Q?/5uF7cME6LKZnCNvcXFD7bIrHHtNOHCfbNSyHTkFiZo4WFERZr9qwYhXgg52?=
 =?us-ascii?Q?DOFhxw0m5/uWDuPAanutw2lI2TB4L59p+N3krAxX5pdhZIMFKaEgWe4vEdnF?=
 =?us-ascii?Q?gpQVSXwuTBJSDVy/GogC2Hp4bd4lCPwcSxrQbEt8TOoEMFO5M4/fvyI1aQf5?=
 =?us-ascii?Q?yEwwu70fCZE8XfzlADvh4hnYho+JZjYxs6uXE1OR203yNzw4AGiZWalCvlEo?=
 =?us-ascii?Q?PXkZ2eeRu1naCIvhc24HLylZR4ODxzD+Yr8bARvHq+8WNFvp9H5KEveCa12+?=
 =?us-ascii?Q?JfjddUcsALNZX91wTBV0PlHsn0oEfp9fW7hZ0LU6g+8yDeno5zRRU6kD7TCu?=
 =?us-ascii?Q?cQZkxd7Rwp3FlJwya2Mo3V/LWgTLfxJheJbhYNwiutTtKIE4IgEJFYlQvEem?=
 =?us-ascii?Q?oZ/JioFSRgG2J//Z/fx9hSLVGjeHNaRzWiZQjDZYoOJ5e+U4RxWq1mJK+iN7?=
 =?us-ascii?Q?fod69d+3aiXbJTnsgLkNd0RqmjTt2/3bJm7YcPou4Cbiw97Zx92tR4wGkqog?=
 =?us-ascii?Q?2k4mCqsFbXEwweN/kvtH5X3mZtftHM22Dm/62yzy3apNVRAqXLNZp4ITa87E?=
 =?us-ascii?Q?9by7pWvBYKFNTe2aOs0zhm9y8Ok33jWSe/j/oh14aj8HdgKtTctge3mJ0La+?=
 =?us-ascii?Q?1ROrRgHwket9hsiwadV3vQvU/B6vdhVxmq4YLjHoMwokunlnfRI5mMGOWEJX?=
 =?us-ascii?Q?qgDym4CSepK3wcCrJ2Wtdq4oxwrYicrlK/AZvf2BInRBBqy7THBeMtU2Qv42?=
 =?us-ascii?Q?mWIQmtcW3UG5QkmaQeKhN5uAjPqjqcoK5zuPcwDTzhTEHNeNSO0LHqmkWKXK?=
 =?us-ascii?Q?c+ZrRNgZ6H8+7+8Io0BTe56BE+J7iUCdcCHi89DwdWJHru0WaAiC05vqfKMP?=
 =?us-ascii?Q?wTBZqXus1v/L1fvcyoK/AeH1hSbJ0nHg2hEerTwT6n4vwzmWARv4i/mtCk/+?=
 =?us-ascii?Q?l3ZVAFArczWgQzLgVYxuXrjH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a7f66c-38e1-426f-79f6-08d95d379cac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:28.4053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCW271t7+4o/ARlpuaSgkSw+q53cqr++Juo26XDKykWYRMalL2+rFwtGKAunwKvL/Wko+axHb+rMnAJzz5BDhPKkWfj3vuvxjiBLoWYagLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: RjeI_Tp25u_6VIAamuDOpUIGVVKw7CZr
X-Proofpoint-GUID: RjeI_Tp25u_6VIAamuDOpUIGVVKw7CZr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an accessor function to see if the mok list should be trusted.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added trust_moklist function
v3: Unmodified from v2
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

