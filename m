Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180BF3E9C6B
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Aug 2021 04:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhHLCVX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 22:21:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57798 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233785AbhHLCUn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 22:20:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17C2BxF3016204;
        Thu, 12 Aug 2021 02:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ZUKp4CsDrGLzDk4ILUQrNSey8xcCKAP2OcvdwHf2PiA=;
 b=hg8hl2Qu/U/Ak6CMZ6+WyCrr5cJAWmu3FGyaFNkO0k/h4lv5XeGkrNP2gykJo2MsFv3w
 XC6quPuP95Y1YgEh6IppV5nk+Kjn+O4Xu2DirwlqXkpwFDXXQzRsfu1py8TSTX7poU6H
 ezDgpLD9uXg3BeQkU27eclOgMRYjiegUXwxQcTWxrA0Sg3FksMpzyiP+jKtL6zKj/sOS
 0hyPyNiypuybA/leH6L2j47UfWPqUBcKshfFiy2/UylxJ/Pb6wUABFUU4J7PGdobWnx3
 WEbV09u+2pgd2QrpbShZs3EKHOHMx7YsJpQJ60W1hMz8vtg4vXGJg4FinQpHlBR7ubdx +A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=ZUKp4CsDrGLzDk4ILUQrNSey8xcCKAP2OcvdwHf2PiA=;
 b=bXjOWratFwtN3Tll/9Hs5Nv1Q6qgN0+mTgkHak+X5moaFsueC8T6SSyp7FZ3+A3r03ME
 ybdB4nI9jcir5kGBO1wDsViV/JkLO6EApQRu1koT5KBm19L7xZYt+MgjuRQYbDVBpu68
 dicCAjZCq1Eobe75UkI6YGDz59IOTRv1WPA8hKEJdXIMgzvj2EBwS3GqpqU90nvMmjHt
 LhjncRKOC6EuYmHbqn19g327+p/lmjS5G4/YM5ATz9Docfwy51nnOYWUHfmxJrPZ7VkK
 ggqfrJgZpUApjsMMlyNSlDhHaq6Td0R5Mc6/S1NUHcT8VlAsYR8YXRfzOdUr3ij6DKCc jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abwqguqqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17C2GIHK143188;
        Thu, 12 Aug 2021 02:19:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3030.oracle.com with ESMTP id 3abjw7j8gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Aug 2021 02:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvVaySoT35zOeo8xOpXYuDIhLBeLwI0MtqjE+CRD4PfGTFpu2bIODkykLCyHlso9QZMXY8deo95MWRPgmuxoGRCTofG0UPOIJR8mGEzdADTUdH2cW7whTto1k1pdVz2JnXS2fB0WFIv+6LW4XNhAjmHpLIVuLMCemfF6iPlNW3tCEgGvxwlteieHruHm2ExoMFrBDq2GWuC6YsvHwhvdOFY+Jb5MxX4Q1up8YfFE5sKMuiSQrbItLlBlKkA+9/VmE5dnWvPARcFc7H25HVrIyYFsI0vZio8eA0kVU2Vvg3KcJKu/8ffZ0JB/fTXotzJuf+gChWwH5l3JSls+zEFZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUKp4CsDrGLzDk4ILUQrNSey8xcCKAP2OcvdwHf2PiA=;
 b=VXYa+fx1VDykSkzQMG5+EbEfFctL9O0viXcuCmuzaEj5fwXG0sjwvXxIizE+RHQp/wwQ5O5xKbHVgbW5CFPRcADEOKc9BDpUapsGxb8k8+x6G64k74cf1kFet/evEoYT740+X1pbt/1sQoEqkqHHGmCCmy7XTSc5/J/nIWPm2e8BaFAcdWKEXYmp0k19PXQz3aH0nenI4AuLl3VpGAvPaInYVZ7LFHUDT2/uzH8ItY4/KFNqJ52Ak+/xRKWji5p3SmYZYIjCo8chDSoCjMOKKGewN+kD4etaShqjdx2lJygsT71Wp9Nifrqyi3kWTtKZzJNhnepaAPbVm5M74e69CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUKp4CsDrGLzDk4ILUQrNSey8xcCKAP2OcvdwHf2PiA=;
 b=HjmfA6qflMqDFJUFRdX5fRzoE4Ke/M5W1YJokZ98LFuTgabg5Tf7iKln6cNBOiEKj87u4hDPbIMEynnnkDI6Qy6sD4w55ZVHDy7z+h0C92yWI1NRyLW/d8pSKER09zrzgznx4JBsTrzUiJ9tmDA8mIpy0RtGWiu+sU7SZbBc5kQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3960.namprd10.prod.outlook.com (2603:10b6:610:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Thu, 12 Aug
 2021 02:19:44 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4394.023; Thu, 12 Aug 2021
 02:19:44 +0000
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
Subject: [PATCH v3 12/14] integrity: Do not allow mok keyring updates following init
Date:   Wed, 11 Aug 2021 22:18:53 -0400
Message-Id: <20210812021855.3083178-13-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210812021855.3083178-1-eric.snowberg@oracle.com>
References: <20210812021855.3083178-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:a03:74::39) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.9) by BYAPR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:74::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Thu, 12 Aug 2021 02:19:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b9dddf-be16-44c6-c5b0-08d95d37a5e7
X-MS-TrafficTypeDiagnostic: CH2PR10MB3960:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3960DD52D8F093894D457AFF87F99@CH2PR10MB3960.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAo2sWf+BLGbK+5nAn/cB9tNhSObG/hKXvSJdwrMqzQjANchZxh4QYfjP/q13R1VssJvuaxYsTCScHRub224tE5mocT3nAD2lnUQfOrKehxQsk61f1/9QLMELErZjfC5yM5IhXkAu3pNN7LeLSVLJIt42VM14TI+GEuSFLCRAEqvgQbZY4LYVvw9n15iZfdwACfPczeWPcjwSqEDTVfYtzevVFMZJS9hXqo5SayqlILL8lgplb0gXiitfElq9BSdlcSGV0haMT0pW5Xj3THTRTSXBUcpPY8SkZMIZQhNy782zf2pH8L4nlW9XBn+TiMyLY/nE9fy2VMO+Qm6I0Plg54MGV6uZQVLtJJleLOnyj+EUAtny9uMOFvdiVHD1NDbjoKvfLzOXkT+QX1z4JiITpoRig8f5BG1kOiG0ejSy2Lgk9cBMjYaFCdXwIOWOLBu8aYZR4t1Po2/lu9ztaE5muYnUPsvXXIaepW/mt26Ps3T5LCD/FeeCoGahX9K5KnzayQ56X/qPNSimU4Ifzo7rTMFp/1+9mytkxOws+bKkMRvmltHH14gZojhag+l71EbJQCaHzstceFzdzVAkJHSYlscFlQ61XDy2lIWgABS+7CzAKM206W9coUmmRMu147eIG7vu9fUlOX2zfIArnXkCPWnKiIp2itNOZbei4YXv9htgsSDT88jfQHXmKQp8Mkx6xS9iTFYsLiny9JJAZRz/7XLVHA+POJAEs8UMHG51V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(346002)(136003)(376002)(7696005)(2616005)(38100700002)(4744005)(66476007)(956004)(38350700002)(8936002)(6486002)(52116002)(66946007)(2906002)(44832011)(478600001)(316002)(36756003)(26005)(86362001)(4326008)(66556008)(15650500001)(921005)(83380400001)(186003)(8676002)(5660300002)(1076003)(107886003)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVcSZMNppJxI3Q62xOrmy0bgLJHBtUxsj4PAftosLcat5jUUWakwe3tMc8FN?=
 =?us-ascii?Q?3wHyOaNfJolHvdt4Abqn8LvL2SJEZLFeeVUDshKAWpuEwCeIVgp9BHre1vFw?=
 =?us-ascii?Q?T+/oPW1AIAcd9qPPtLk+GI6vE8a6KV0XHBhlpZYeau5QRl51aMmaHGBpo93p?=
 =?us-ascii?Q?ZgN5WTomcO/YSwBCAVMyCYlWnSdObzhzdaTR1TfNlQHBY01iIR2iCALN+9ZD?=
 =?us-ascii?Q?rUrBV2vcmkUyN34iFr0BN/1rTgusmE1LZwGZEvx/hwWfs3C38oI1JQagZFTY?=
 =?us-ascii?Q?cgcSzhAqes3OVLYIPNsstqeo3dMjGy9/3hNNAbwvCLS/RhWjKuZyNrPf8/3L?=
 =?us-ascii?Q?U/Vxgs7Ly7doB53i0PbyVMi3f5UDb2z+gMLDawiUhEnyAtRdULajyRlugqg1?=
 =?us-ascii?Q?LBU2v8nOeRTvfVRe7Q1qHwv1G2FWpdVMPtAucOnm9Jf6MWyTMWuqgiNTluSu?=
 =?us-ascii?Q?Ty9ZjSjQRhxqyP5tszyjPANaaUuEEIMo3WBuDvF6xOt90jcNStx2oGoYi1Pi?=
 =?us-ascii?Q?W9TGSrAw6DMc2iiSX440MZP5CHh1XNPalkKz5iAWr7+ThayD4GZjclTWRUkz?=
 =?us-ascii?Q?H+m7vy2z1DLuwm9LrlVQhZEsx2zV/rhpPF7u+pGeYwur0UBn4B7nFSFt0+rm?=
 =?us-ascii?Q?pkArzE4VurA+zVw3vdWZT+WNojHfHXmSGgLYqiXrok3CiI2wr9HRVLmX1y1h?=
 =?us-ascii?Q?2LBmFpXxwc/FOOKBf26jLDUg1ySIhVyAClQUHpb708uiPgHn5+IO4eRlCDEm?=
 =?us-ascii?Q?pZWVvyPnrg1rRl2Scbb8JDczkCK7btcf9vv97PgW49eA5rvTbOfGaztFBvfI?=
 =?us-ascii?Q?LdHrHl7NsF/2XmLWGKP43eJXfq07JHcIGqaprSXbvJiSBpA5QvGeC8LIMNcy?=
 =?us-ascii?Q?TrIxw8KIEP0EEY5u6I30p04883ywaOHYzaeAOJ460Wy/2u9E/ubIBIc/gJMp?=
 =?us-ascii?Q?mGOsC3xhcTTYbWiQMqZV5CbLMcXaKO2f4uzeHrBO6UzvAV1Z6Ri0dAi5H8i+?=
 =?us-ascii?Q?/Wh5wRSfJD3b85zswIuudVXocqfrv2yoZVPUbjyyTFLP78IfXcWFl5EPmfl6?=
 =?us-ascii?Q?k2ENZaCL8l46N8NcrYf01J8Bi52Aiij+VsemFvOfWGh42zNNqBFdp0+mr7At?=
 =?us-ascii?Q?UTCVUFSuDsv5DwED5tnwalzfVqBtcOKWFnYB9RLdZmVjv5sBXiGF2Ip4mXPU?=
 =?us-ascii?Q?UJCFWQMFGiOTPZwyi8D2/159bZtq8xO+GlsQ7DXqtEPBiXWvkIK22vx8Uakf?=
 =?us-ascii?Q?cI0xDfS0nsK9uwF4/r/hly8DUJmxOdEbNXsVvcJjv5VcxIkKiSXqbgtuMFZE?=
 =?us-ascii?Q?AorUoTGWcUJtNAs/8UT5LnjI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b9dddf-be16-44c6-c5b0-08d95d37a5e7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 02:19:43.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQ8LPTCXBgJxlP4sUjwoFvKzif0LBwgMuAQ9p6Ahp3f+IWbWI7nYzE63IzzcH2DK6kO43HbKfkTyYx5v98Jjw5YoqcRY47B5mrxYJeSbRn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3960
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10073 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108120013
X-Proofpoint-ORIG-GUID: VexbvrNR8aXJsy03prVg3kBiV7jy-KR_
X-Proofpoint-GUID: VexbvrNR8aXJsy03prVg3kBiV7jy-KR_
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The mok keyring is setup during init.  No additional keys should be allowed
to be added afterwards.  Leave the permission as read only.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index ec94d564c68a..0601ef458e03 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -145,7 +145,8 @@ int __init integrity_init_keyring(const unsigned int id)
 	else
 		restriction->check = restrict_link_to_ima;
 
-	perm |= KEY_USR_WRITE;
+	if (id != INTEGRITY_KEYRING_MOK)
+		perm |= KEY_USR_WRITE;
 
 out:
 	return __integrity_init_keyring(id, perm, restriction);
-- 
2.18.4

