Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82C63BC149
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhGEQA7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 12:00:59 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:55374
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230307AbhGEQA6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 12:00:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYZj8YbdjTxBb8yycnjFjpf24gxLlk2VeUnfuaYTFBElCf+9mTJLF6tPHSmRv1LRZ2mlKVI44sg2fWrBynqcWZkF8k54CzPcX9dGg3EL3xmVZGbZIw3JvCT4dYkzScjy7WWZPzfAQWUJxYdA9EOzeDm/elzcPuoqcg0R07OTOZgUN2+RXaLeym0YYip34oaNQxlj7fsOqCUmvtLe4ODicEhYqHkXIQWfXzCigqGfJMm+xsMDCbtsK3hMiPPtjR5wLPuN5UBgxfdOoTXf8NVEF3sw0oQtMBXtNQnFXseZLPpi2PoiSnkmYt3oNPQevIzCAGzYJKoKUE1vpMhn304eMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6uhFPre6l0Zv/YRuE6xnDcG8GztabtYSj9FqUiTfI=;
 b=R2LEdrNJpW99bb4rso6bMibF1dBH+hzFyaX7Mfq1eM/2HcuXUtjph72f4vXlGkpXikSsR+4WSUoUHe4xtarINQ/Uck6pkaYTF/0oWcyGgn93YZTjO27ujJXu0GCv08iiV5Yf9L3/ULHHQTw3ESDg9fjIGvXw6kR/6ceg95jI+9e4kV9RgM+WQG65c8SzKicS6ToVXZWjh/k3QRw8WeJtlw6Gf1r0usiN7+G+GVVgjL4OsnKJRylQ/rZ0SkR73H2TXaAYA4ruoDm75Pg/+y6HET7WbtLc+ofQJ1HeL7odBQHZxmzOVsQJPE636Fu4UTaii31hdQvkojsyX+X87Mwe0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6uhFPre6l0Zv/YRuE6xnDcG8GztabtYSj9FqUiTfI=;
 b=VXvvrIzpVma43ZEp8sOCqDV/VNATXUvgfd/tsT1BMnR23+Dis4wcXLVpQuaw7RPvadci8cQQ2XEoJ8MyEQTqFW97NYmvPhEAdSPVuneDIvA/DqEyOxHZL+B5NLZ4KXV7gO5pHOw6oQZwhi/he+1WNj7z6WcVvevO3+aqeC1f+BOT6nyFCmGayhZ/Jd4gqkPaJp9c7vnPQ2VvlTfV268rdcQd5QGmU4aK2i+dPSPmaYgJuTbUuLpg66JcykT5KKQ1p5yQOJrkMPb792Ynaowa08oV68AjTnr8kJM0PM90A9T6hLlRlmaBfop/dck80pHNnX0jKTstKjm9ecgfR/973g==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM0P191MB0276.EURP191.PROD.OUTLOOK.COM (2603:10a6:208:45::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Mon, 5 Jul
 2021 15:58:18 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::356b:ce91:e81f:f038%8]) with mapi id 15.20.4287.033; Mon, 5 Jul 2021
 15:58:18 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     pbrobinson@redhat.com, patrick@puiterwijk.org
Subject: [PATCH ima-evm-utils v2 0/2] Fix use of sign_hash via API
Date:   Mon,  5 Jul 2021 17:49:48 +0200
Message-Id: <20210705154950.497359-1-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210106094335.3178261-1-patrick@puiterwijk.org>
References: <20210106094335.3178261-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [45.148.140.78]
X-ClientProxiedBy: AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40)
 To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fedora.patrick.home.puiterwijk.org (45.148.140.78) by AM0PR03CA0063.eurprd03.prod.outlook.com (2603:10a6:208::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Mon, 5 Jul 2021 15:58:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff807631-d2de-4692-43b3-08d93fcdb470
X-MS-TrafficTypeDiagnostic: AM0P191MB0276:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P191MB02766989F7E8EA23F51EE9FBC81C9@AM0P191MB0276.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCM/1FyLAL/jWBNtdISyKtLew1agxz1BT0BZh+0iiw2xAUGEzxGwJTTH3/J8HhCiRoEwNJtXlQK76UDzRc0h3SfeWMQ3L13r1VOnJQUsUgKaBJY1MEMfIxUStT8bkVXfTH6G1msQ7sgMXdGnnxARU1SonYqSyjnlAlAGmhO64adsDSBf4BZHeaRWIyg/8vDyoTqcoMT9qEIagPWYLYGYM8mW1NXbESBKekJQC/AebmbOU1gYPqT0p8NhNIcz/VLrp9Gv33IuffiQyz0vx/IkQtdFBiO7uC/d6+osnbW6hb1DFqz+03Ksd+HH1twmILIWofOlkNzAmAMOi7Jr/e0Q+C+exMjVRhD5yt22Xg/KhNssvipuPYrqtFRLSFiBaxesjvtGE/u9pxKNnIaC2OnCTb4xiMKe0KHm+7Xwsm1eumhu2OAXCqohMOe2WEfvoVNWLp0bX9jareOZm22Qw+F4Jqdo6b185b3oLSljoxF1guc1k9IesV70OY0BP/fFEomIxLA2BEzhlSLp8Erta8z3sjLZyz2ScJjpYolMNNALAmzPnDexb9ruV9OEtLSKqha9Hj7JFEY6ceFmIlwna/1ARswtO2enmGnijAv04EJJunnmPoFwa0A0hNMBROZCJCjxqVTumX3PamYljCvbzYFQ2/sUNnrYG9uVNNXew+3mxezlWz0A/ebJN0ZTIHgImSHe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(39830400003)(376002)(346002)(6666004)(956004)(52116002)(7696005)(316002)(36756003)(2616005)(66946007)(66476007)(66556008)(6486002)(26005)(186003)(8936002)(38100700002)(38350700002)(478600001)(1076003)(86362001)(16526019)(2906002)(83380400001)(8676002)(4326008)(4744005)(107886003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7Az/W6jcdcEuDPxLtn979noUpNhfOfv2pPWj1dViFsK3Yknysd4KYwLXSaW3?=
 =?us-ascii?Q?vRtmMpvYJBUyMSNy5duGajqQSp5bX8eA+aSfgEXZjTg7cmf88LaXa5Za7w1o?=
 =?us-ascii?Q?afGz4djAOUVhedpahsUklZhAQTkn3A21WQ0hu6q7mFuSf4vVzjXr1wrBKcjC?=
 =?us-ascii?Q?BFcqRuA0mitkYrkTNnFyF2YDnmc/FzdYXxecjUzDeAYXsNCj4CubITJgFX2J?=
 =?us-ascii?Q?aytdGyv19AseAUZ3hKhxntBG1e8Ac2c3zMR89hZ8u0ZKiInm1rzKcnwU1nBv?=
 =?us-ascii?Q?G5NmT/r0SpUpOIPgqYHkR/CItA9pTE92b+Dh9d/7KsebrNS+YWJiaGXT1fo1?=
 =?us-ascii?Q?bbmgklV3ZczlpDv/EYiRkanaWdBozdgLk7fL4sOEDazyka4HTZ7gEzdYXvxw?=
 =?us-ascii?Q?dEm+Bg7K8YlT/wCjMljFglyU7jMwAoSO+BG1UjarlJubstJrLT/4Qb6ABYEH?=
 =?us-ascii?Q?u2NsBTccgjVBxIhglqbxX11YMyMvQX0KBncY2f00SzDrbWy/CQOaJHj8YJmg?=
 =?us-ascii?Q?4EmbP/iS3gfUNH6wldXgXBPcYiikZHoCoo1BdQp8/JEJ1ZfljaxSlCB06xVt?=
 =?us-ascii?Q?g2/1/K2ZSXzhfRoqbA6NmLItych3djhWZcZ0cuIoITfEMwj6ON1R9QNJXYa9?=
 =?us-ascii?Q?cd46xHjFGk46gK4yCTUhz+XeiDhIoPK6t49eZbMnNyYj4xZYBHGiZ15r8dqZ?=
 =?us-ascii?Q?NOIw0QWTRkMkWvErtmiwn80+a6NQ56Dm0eZSiyW9jA05BbZk2Xp+XEVxqpQS?=
 =?us-ascii?Q?J7qvB6wCBOZ4Nk+sDsK2UejaL7Xmj8Hz2dCaTE1pBVOS4AgYXbpPjSl3qwe0?=
 =?us-ascii?Q?10vV1mXIKL3MkgTmVZNb2HxJrxBw9JrRhe6TIE0uXBjCqGQyEAcqzElwasry?=
 =?us-ascii?Q?iHbnUy3cnb6rGwF6pyMq8zE3NjhwkuOQ7Khj0B7nEqtGkWw/B9074GBiO9/m?=
 =?us-ascii?Q?mTMwzcxZl5tOYzETFWmFLtOt17IPkrl06YutPHXJgtrEn3rEeL6heYJ4ZauO?=
 =?us-ascii?Q?ZYBvZfol1X6Nd7rxFk3SfaLBaqg7SGtAXSMy7NEMYLwsAMvaI/bBlKjl6Rlb?=
 =?us-ascii?Q?+AVnXPsSRD9kudKPwHQqsAG7hZJoKRUlZXYhZqtFZhToeQR6HuAg28x4dwuk?=
 =?us-ascii?Q?TtiCscc2CnySO5GLnruhE9GhbDklVAynvidIYgpOaSRHPYEKd9nUpmZME9wG?=
 =?us-ascii?Q?fO7LU2MNzi4zryjf8i71XSn4dnBxaJAj9oyd+yOlnVQNKmR5P2pXWD5ImYbh?=
 =?us-ascii?Q?Og+4Tp9nBzlcj4wcFE5/ZlBmGa4bXRO1Tn1/idrQmlOV6G+O6ktMsdytgxj2?=
 =?us-ascii?Q?ES6KhRKSFcKreeVDqQ8JmlXc?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: ff807631-d2de-4692-43b3-08d93fcdb470
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2021 15:58:17.9041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Tp5ktEGQHXf/mN26m1EdTyDDGzABGDL0IExv16T+a6onNBJF0levPm58u5ZC4zNWgUjw7cf0+lgS1Z1P6w9eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P191MB0276
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When using sign_hash, the resulting signature is incorrect if any hash
algorithm other than sha1 is used.
This is because while the sign_hash function has a hashalgo argument,
the sign_hash_v2 function does not actually use this argument for
anything except setting the hash_algo value in the header.
This patch makes sure it uses the algo variable consistently.

Changes since v1:
  - Using sys/xattr.h
  - Removed copyright line for sign_ima

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
2.31.1

