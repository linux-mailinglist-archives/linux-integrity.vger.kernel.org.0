Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132183F0F40
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhHSAW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:22:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:64696 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234778AbhHSAWm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0GHdq021771;
        Thu, 19 Aug 2021 00:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=tvoUeSio7ghD09VVfUAsBLd9t55D58S+2MdTU+tWUpI=;
 b=0JQ6WlgOlf2ZY10qbSVrJY5lxHFxuh9G5eMCOYrk1+v7sgSTLcvu1STe5qrmPjaV1B6W
 bzadqNoHtzkwJQY95DGhZ9XLYVaRG1jB4HHwRLjhHE5X/3Njdqo9/ika6yL4/LMIyu6k
 52Yl09/FJgWOs+3VPnu+8dNdcGuXDqIW4Ct/OxMUkULY+XFrCy8ljbaj0AyMdKgTnrI/
 0xlsGopTll8o17VyTAHnKW1fTDRgqiraItktYIVtYJKI/59bU5Jg1mHnbCuRKZF+DpKi
 xwKsglwfb5AlWAMUjstRqslWVhEBl1tnQSqyiZ4pSJEEVMh8aOeA9kKr6m3VnNc4953X /w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=tvoUeSio7ghD09VVfUAsBLd9t55D58S+2MdTU+tWUpI=;
 b=oRvyHYwfPaRZzxtjdcOj/7SSYbPJg/LBK1h1UNor+iFdnPdzBVluIZFH0BHeF6w2sHGk
 zQQavCjPJ+CVqrQMFgfnmB2VGzffHpzEsyzY/h6jJRoJcuA8HgQDH/goHGv5RQLSkKbv
 R4YpXAuGTxFxVMAgaOOaugaARyShK9i8KQJtIGGNkho9nzRcaPsn+IerzYwsNc4Jt+Iv
 yYUYU43hwAC+0YT8YOv+8MPki4F0wIoTSrWZM+oRNP9YNIO0BJlTZ8r1BOxPGhDdeCGs
 TngWE+ybyRBW1ABLmuJjrH438deaLhGNalQscBVb2GUx9e1mJfG1h2856l5T61mGRCNj Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agu24jghg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0F9Zg040622;
        Thu, 19 Aug 2021 00:21:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3030.oracle.com with ESMTP id 3ae2y3947c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vci7Fk0LrIbAz02I/i9iSJJzHhdnjSPo6mkujYI4EwxcIX1iGufoD5jzW0AqW1muVnQypvjlxsAYjYqqQx/2T92NqgSihmJ0HWv1/U1b5oVT7djzxxx9gMHNP+A4sg3K4iC/G8g0yMBMuKsFxZMBRNTs2Ftr6pnW4ANemu92LANFVQWRoHL0eawmpEaQsN1S5MCbqLp+ih3+9d5CnkgZGm+18bYXdDBQbWFVJ0ve01lja4BxcfEDTmZJOji1pS3vTFjH/4cXw/Vw6UXvhmZGIg/WeuQmoLRYDU/oAbfsQLi31UZjHSIiJRS/YY63qxaxmbCL2nG4AlgRNN+gA127qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoUeSio7ghD09VVfUAsBLd9t55D58S+2MdTU+tWUpI=;
 b=hja0etd6Us9RXCNkBPFm87atK2XQ6m52rfwrqHgY93f1XokYN9TL4R83TzCEGkpZrLzGAqYOtAF7Ux2pLZH4nLzL2SogFvlhizMCS0288OmKHsDI7yb0vxqRorJdtQFcfmtCkXkaahd4cl7HETy0rDN2YKhNtejHtu4hQ3xygOU6RAJ1kmTx9V5JtNFMJZ4tG9ukWbqGHV8Mbfjbel+JEgknlcF0nX1toEPmRMoTakE+ODLayGfTODf39SSIGP/72uS6oHKiW9siqP7W53ZBiiBUGeGJGo1aOiMKYvBN0Bsnd37vkDtVESkJ3ZzJ7kM49YW+XviDc/j/YPssPv1F1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoUeSio7ghD09VVfUAsBLd9t55D58S+2MdTU+tWUpI=;
 b=viKSTS0XjWZxn7GaWKdy/yjE80KIsibWaOY6VUZL9orfzE3cBBx6LGTFb8HIdE+i/tByOKhow1+OAOEMCVG0WtXwxlc5+CBqoPs5Dm7dME9QqFLXEtpkrBCLBIg8U3lbBYQC4bAxRCCTeLxKciK25qgZpohWHUEIPGjB4mmjSuo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:30 +0000
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
Subject: [PATCH v4 02/12] integrity: Do not allow mok keyring updates following init
Date:   Wed, 18 Aug 2021 20:20:59 -0400
Message-Id: <20210819002109.534600-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6b72c6-f156-4224-058c-08d962a74ad8
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116DE2B1A99704837B6C40A87C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzmEbDDfC01ME9C/VM4AoevjaMW/CUiQQedSgKJhJTPBynmR3f35Bm7pjBkBYq55hO4yZLmPGVnhWXc+vXromUHJzZPJ6VorxazO+Mt/gFBOxzvWf7mzYkEi3f0ynGT6CuxOk4NMWazMl7SFzFc1kZk2iNTAF7/1sQHWM6nPbcDq4ZPfX3CdnqouXQEEkzGiaiUYN/GWiXF3IAoA0x1ddJt2n4yKr/avyEvFFSlQhHn9U1wXylVl7bIRbbOZuJt9UrnGxIU0eqK4LaXhRhH9vvq9q8mtA5UPOQa2UU68CEIht3Ap7ZEZ//A0BzC+dWXRsu75qu1iAbvVvaqDPKQGLSJ+jY13UPLoJe0avUxfjZ5xtzW5x/KhzjqFg0deUJcs6tQebBB+FtW6n5r5o1j7vTGcHw1JNjGVzHP9ohNtvY23fncE0NNUBGGqp7Y246ABY9TGkQcosuixu6nFWRn+M/au2yzYGrVBF39P77jWQXE2v056p6EhLYsQFXmV+oxkyHIpFBzMOKF1rYfZb0IheKzYdDOFioGfxvH/0Pv9s8WDqM1/opMdOn/mRaO+LUseASGdK9scqkIDxhDtu+CaF1MgXsZcel4vGyW1ag7OKBErGKTZLjdr9bKJfZwsxwG5XaFJ6a4Bsw5bNO5wjHdMo39rx2UDRawKSMqfxbWNM2/PdsyjhEMuDcFBjN9jV//1iBI5ho0HtyjQjPTyY8jWyvSpRZk0istMWTiJ3YqL3HM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(4744005)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(15650500001)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h5JiC6mxp9gYbLwMA7V/qSAYwgs5vDwqdc2MA/eVBkI0RC0i0OlvuJjh0U5v?=
 =?us-ascii?Q?6y3+HBUItwD6ZZxxZQL2LSH3OEFaiX0rNML8kl0/5qXQdyTLknjhsLkeHgdL?=
 =?us-ascii?Q?QaoSFJE8d69ezZAoYUZCcryxCMAHFqsb4k/L8gYKOBcUHVRaw9W8MHlj8AGg?=
 =?us-ascii?Q?iWRd0KDDRP+zvHtNDPSrXLxEOCbybBxNAHWgTjwkBoHwiEWcwhLHPAArRYZ8?=
 =?us-ascii?Q?l0BZQiJmW5PxLys/BW3tpuVWcBLlVw5rONUbRzngTOgRtEdfYsxjNLGnOHDA?=
 =?us-ascii?Q?A7tMiafT7AUgkZEoyHU19lERi/Uo8g1Lx9SB+wETzVAoF1uJ+jvXCSPaWVhk?=
 =?us-ascii?Q?XgPWRUEv0Ppv/Ns1L2NkK1aFb60h/tDn5JD2g5dhLCJczNsRfszUsN5sQzH5?=
 =?us-ascii?Q?YWdAaJ6nyTymXHQjTx7r5LZoBsuITi+G918dnZ2igzwrAuls3MfHXLxK4X0J?=
 =?us-ascii?Q?SuK3XYdNKC6OzDIQ1FJdRVkf+XsLiuD/jf5opyvCRUKE3MJQpUke7KGejKhx?=
 =?us-ascii?Q?Ww2eqSVmkBCEzY/+b9PVZgN2l1pahbZ/ry1cAflL4D1oUbVjeszFdnmPMSwz?=
 =?us-ascii?Q?lE2BAAX/9blQh3wuy0uVC7ZPY4223Aiwh60p9ogdeIuqO/smArxpd98syxoM?=
 =?us-ascii?Q?gyw+D4NAHyIWQP7FXa26VvdgDaAeASb/LwNc0orDle4etnySoWPjspfppxKg?=
 =?us-ascii?Q?SS2ucIxzBfMrW5DHnBMxQSwicgzXH9P1mA37LJnkqC2nCwb8QJn8fwscixdU?=
 =?us-ascii?Q?an107Yrf+8QxIUkPdsOka55kqhCeM4mmZWtprBAieIbPfXIEeJUC+vd/rjEh?=
 =?us-ascii?Q?Pn8kEnRQPhEaN6rkRFLkVyYoueA/TAItyPZ4LwnmQZgBGbTl4GOw1dlsvwP4?=
 =?us-ascii?Q?X7e9E/Dnqe6j9d/5U87iF2pxSJoLon2y99TSRF4ToTYRDfqMdZgVfGIoTKQ2?=
 =?us-ascii?Q?ze1gX5FtU8BWEY5qfivxkjxBTh0QCVc+7qh3OfhsIOUTZwZRc3zU+oeRhyZw?=
 =?us-ascii?Q?kqMQXNBGfc3mPAkJD1G+lsSUC50KRdNP4ZUQ2KbU3S/peaf69u//647Odq5h?=
 =?us-ascii?Q?2kf75bjhzadDahS4+fDxCcMmh0MG9iyYxIVtHAj8qK1HTqLcELZCtKDjZ9L8?=
 =?us-ascii?Q?wZXDxPxSMCOmfnQux1p932MbAdnyr2Hvnc8pkJgIiSCEogTqSV0KfwkTTCj4?=
 =?us-ascii?Q?IpTHS1rYS67TgM6v0dAfbIF6vOqmOry3uXHZwR50R58HA1eiNkp0MWBleXqt?=
 =?us-ascii?Q?WE+zk6+gCzP57SEZq8ZFrka+cS/sRlTCbUV4McBp2qDQ13u1+hxNdzU//ilg?=
 =?us-ascii?Q?WDFplFAu8zQrpfBBb5o4NueC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6b72c6-f156-4224-058c-08d962a74ad8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:30.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1TuA2vjevEz5gFGqP2KX1g8j5pooenaSSwHtII/y8HW3MVbIPkIwEVXBJnpy6sGR0uqLTRTvy1/UYbqtidp7fYRD0yKpA+VtpWjXpNeNx80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: Q6RsdIQ1QtOP1HUCLrgHYR_BnX3eRY6Z
X-Proofpoint-ORIG-GUID: Q6RsdIQ1QtOP1HUCLrgHYR_BnX3eRY6Z
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The mok keyring is setup during init.  No additional keys should be allowed
to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v4: Unmodified from v2
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e07334504ef1..5cad38e6f56a 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -140,7 +140,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
-	perm |= KEY_USR_WRITE;
+	if (id != INTEGRITY_KEYRING_MOK)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

