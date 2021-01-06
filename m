Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1C82EBBCA
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbhAFJqi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 04:46:38 -0500
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:19939
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbhAFJqh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 04:46:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2JFJJmu6hfkIPI/IYMR5mQXFpgov3Duh5ea9thECIhsaMi2VsxWjPlV6gJuHsRGQpc2cjXsjsERKsUnZyI1IXwRVznH2ij8j9MO3cTgEz4gzuVhntv+DcPWg2Acj5BLNDUL19WSGG9wHCedBNH5CNzjALFqqpJy7uoxoet3quDDEhEQxNiV8XdIbYLNHSJM5uJgnnnE+eB3cf+Czs28FJjhI3fX6mn7oul2nFtT39Yej19VIm40/PxnmcwvmJuIMLCQpZd60GgCQakQMj0W4cIDNIm9wNYbwtJDzG67oiYyfpjdc/e6sXY+f8VmaD1v69W1wn40qvl3gdTNftMcow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHg3DTse76sTvw8hZXuog0zBgKJhZFfvJ0Bea5Fpgk8=;
 b=P6pLs6aiVEGKzMbo7meoeWIZJTwv+K4zYJkbg4MjCSii77h16ryw1Ikjv7QEWV5lK7N6O7UjaUnfaXEGYC6f8TjQ8dNBWd78X4DX/ZNF13ZVvItz07Rvp75HzRiVngRv1NXWBuvws/AZvffGGtuMAn8cZdca1nyv0AeyyyrCtzF+3bCa90x6DCScR2d7Eg+911ftk/OQlLEw6goeQVhwVjamjs6K8RPXxKXaiE7GqkCNg1rj11l81ssiSyYSsOEuH4tmybTW6F34/eBYF73qz0guAot2rOCaRuN4g2kwUrToxdVOLDQt8Lac3GOYeVZW9JfGpfwOV9Lta4OVS1bcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHg3DTse76sTvw8hZXuog0zBgKJhZFfvJ0Bea5Fpgk8=;
 b=Zh8Le9YW0TNCaawWSoZQ7nELmfycxcYXhwa0KWV385kpmdvSbdmI7hbLoDNncQyjvBcQpfznd3XobjoXCJIeEw6JgY1vPn+wgUxy/nd7dwd7P1oL6e+7nELEtO/QqoJGQtLpLLzXs2qojrTHruNvkPcW+CDo4Bv98hpCuX21KioAhYBcb3VvM1oJ0VGO9dB8X8Ad0hW6CZLw4wSS6AyU9q7Zv3rZHcGQThJ2shWpbplRszN7J89SytuCHJT2wwITN9asPkOB0f/an/Xphlm/OiKokehJo6Ame5MKUm7CLnJf9hJ9igFevwW7afGFzozVJCXrjsAVlEXE4MpFFNMJSw==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM9P191MB1367.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 09:45:54 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::692e:dea5:e2e4:c09%7]) with mapi id 15.20.3742.006; Wed, 6 Jan 2021
 09:45:54 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 0/2] ima-evm-utils: Fix use of sign_hash via API
Date:   Wed,  6 Jan 2021 10:43:33 +0100
Message-Id: <20210106094335.3178261-1-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:daf9:2c4e:f3f0:a740]
X-ClientProxiedBy: AM0PR02CA0202.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::9) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.home.puiterwijk.org (2a10:3781:662:0:daf9:2c4e:f3f0:a740) by AM0PR02CA0202.eurprd02.prod.outlook.com (2603:10a6:20b:28f::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Wed, 6 Jan 2021 09:45:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f5c33a5-813b-474f-4a80-08d8b227dc50
X-MS-TrafficTypeDiagnostic: AM9P191MB1367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P191MB13678942EE437791FE635CB3C8D00@AM9P191MB1367.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBVfZuKZ+O9yLawp0C8XQ1Gg7trooxez38+YbGSsAJaBzgoyevam6U1U8Df2PXuPXhJdgi6rqYbNl2M6oVvAGPwCry79YpivyrUOUcIR3vsTUWTgZ6V7CUehS5kXNQOaBvCJQY3+GMCeMd6M/Zu3MN2DF6ecZ2YUwNGKNcl52zezrNndom8XsDogAVYvZLLJXEo6uMy4DfLJZStgf8G44FdwsQCuGw+t0pSIXlOMZzKpTE/m8kcJhR9NrTnWe1hXefsu68KRtgnxmjveR/jZvgnKb9ZHpnkiRBTeeuap8dFMR4O/pcDsLSYO5MXJWAxuZiCeKxAQO0kvAQPnjd6ZBjfibZdiIepOCEn+b1y+eR9BlsVAHahDDNwtdvg/32volnbyvLQoZGCSzcigio3A9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39830400003)(376002)(346002)(6486002)(16526019)(186003)(83380400001)(36756003)(316002)(52116002)(8936002)(7696005)(107886003)(4326008)(4744005)(6666004)(86362001)(2906002)(1076003)(2616005)(66556008)(66476007)(66946007)(478600001)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mDecTe13KFjH4+4Ird8ASFW7I99fn3MVgGVoSmXvTu5wUyTKWc8kY7Lu+vPi?=
 =?us-ascii?Q?FY2P4QsaDRaksf77/ZpQLEV8NLc2qS1uXrR+wRwkbG2mQIy0Uo7zvtUf3HwX?=
 =?us-ascii?Q?3RXk+1u95yUCztPsGv+xoOb23veOMf86q+TIjo7UxDCiT9kdS8gURNeq1hjZ?=
 =?us-ascii?Q?z2NMnuOvMSnp8VZs3k7Q8Kb9jIRM99A5AISNWKfya7tGWXeUQoHCEJyT2T5q?=
 =?us-ascii?Q?MvsdPuv+w/9s2WjVXZHfe+2NsdPaT/pz13CtL4mu/WO4ewnW/KuwOZC6aXlc?=
 =?us-ascii?Q?8kPI9rAySFqUihrC65/ozAOMjYqAM/oRzA3eMnjgfI6rM8MD5w9Bgh3jaq0f?=
 =?us-ascii?Q?w7+usPSt3MunCVeKW71cswHyMC5aEgh8f1Zd1bpjiCJg2VhO95u6eRdgV9/A?=
 =?us-ascii?Q?WTRpb9VIiCH9RYK1X72YXfEXK6/vnYPFRs5pygvmu6NqMq6ZGrolZGtpPtQO?=
 =?us-ascii?Q?Dv8cLTubWfGro37ZJ936ALHu7d5EnLgaqlrqp4vvzkPTiunysakCeT1NFn5W?=
 =?us-ascii?Q?8S4BAk5jZvtUmmbjEKq6N4yedunS/0JJE0ahUJbhhaEuBulcsa/NpLgBxxZ3?=
 =?us-ascii?Q?PDzJYYaW2qdOjIso7E+TCqxt/wK7Gtge3VekRAcATBN7RMl0vcRGDxF57kk1?=
 =?us-ascii?Q?q0wgFFadWvvfMpitB7RI2mxf8ShCwuUxcNyJmmjxH6diJOL5T5mpKHE/ge/Z?=
 =?us-ascii?Q?jnIa33VhoKwTviMSiuyDPQtH3CRrvIBPCwdxB6BZOI3djmZJF+zMsKmRNeME?=
 =?us-ascii?Q?AengQRMoi1XMe78mWipIcg4+Rx0QA+T2bYODSFvvRJZI4TYaEeSsywSPI9AB?=
 =?us-ascii?Q?F0oXnAfsXi06TC6C8tzUzODhnWNFZtMKcPKjfYse6HVEldXFqd7LS2ficgK4?=
 =?us-ascii?Q?kubmIVTvhG1SZ+KLicLir3M3x9e7RipmR7c/+X8Ro5ShxTh7o+Ap4NokyfPX?=
 =?us-ascii?Q?iwvnae4HgHaxj0tIWva5iWng43IhDV8BZCOgM3iTNdUddrjKLfT3g25P/SGT?=
 =?us-ascii?Q?un0q1hFWQGhIMKQGWs6jPtYMCyo3C6V9CFV0TCqfLAY68p4=3D?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 09:45:54.1130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5c33a5-813b-474f-4a80-08d8b227dc50
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpCesPfOkiST/UAFgi2S9J1ztzuJoOAHhhtyWJy7rawD+UcQ3B2eElfxlyMolJjPEP5Q24G7gQSQQNkQ/PPvKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P191MB1367
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When using sign_hash, the resulting signature is incorrect if any hash
algorithm other than sha1 is used.
This is because while the sign_hash function has a hashalgo argument,
the sign_hash_v2 function does not actually use this argument for
anything except setting the hash_algo value in the header.
This patch makes sure it uses the algo variable consistently.

Patrick Uiterwijk (2):
  Fix sign_hash not observing the hashalgo argument
  Add test for using sign_hash API

 src/evmctl.c                | 23 ----------------
 src/libimaevm.c             |  4 +--
 src/utils.c                 | 20 ++++++++++++++
 src/utils.h                 |  1 +
 tests/.gitignore            |  2 ++
 tests/Makefile.am           |  5 ++++
 tests/sign_verify.apitest.c | 55 +++++++++++++++++++++++++++++++++++++
 tests/sign_verify.test      | 30 ++++++++++++++++----
 8 files changed, 109 insertions(+), 31 deletions(-)
 create mode 100644 tests/sign_verify.apitest.c

-- 
2.26.2

