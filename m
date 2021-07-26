Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DD13D655E
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbhGZQew (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23714 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241018AbhGZQdx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBeV3006257;
        Mon, 26 Jul 2021 17:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=DYRBArv035U6vYrXuHYu1Z4x2/dZlbUUPk6aU1x/2eU=;
 b=wEqX32miNuufldH5qnR2/YKYErq2i71XVIG31UiCE9EP1xtb7hVDS/zg9U5tXrQyanaw
 rYLi/obx8Fl/eXUdVUTr5NFzbY6BAjLTQt3x/LHgRy+p7MQxo6zIsgsf5UXWPLhsSO38
 7kypZkR504uOdbirYSz+gWSxdtguDdHZs+bGfbwuDqj3y/rqz6LETWPOzYjtCiQ0BCtG
 qUC7TJO4qLBtUpAquuZK004CrDDHIH3KX5YSB2vU4vJT0b5IlMDiI/0n+OPQtXaTVNq8
 yNgznoYBVsJh3U639gqPcpXoNl7Q1crZwuv1caneoQfyBRgCmgXXffhILZhF0EHCTLiu Dw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=DYRBArv035U6vYrXuHYu1Z4x2/dZlbUUPk6aU1x/2eU=;
 b=UpcQK5Ftdph0YiwZGnZMU6tlveH0q9AjcXMk/32GbUdKEx6UUFXbs9dKAm7/A8KAbnZ6
 XcQT1mV0Weirubk32l7nF2Gy8IQl+IiDnj1Vh5ccoVXNi4I4KCFOto3541JtJE4TaTdP
 xt0VZ5rJwlsVHDUjahcL6Ivy5DDuA1caVhf//vX7IqriKIskyTP1i+B3w1FSwZHkBLDl
 S2BzhhSfu5U9Ikk1zHmjIr8C9F0d7lKhhtsfr703T31QksJresbGqTXQmpXspMK1Y4xJ
 /Tv0jpNIOMLrjvtfhX60FyYH8k7g5cDv/wZa8NtQjRMtrSpfqLFzZLfsCZKIuIq7OQVk 5w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1vmc0u7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBP0K160169;
        Mon, 26 Jul 2021 17:13:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3020.oracle.com with ESMTP id 3a0n2gcp6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5TW3Au8mbytukuqzPAfHPZuYq4L1jOZ0D9rFmIS6h4r4bkQI9R6DUPBHaFfcEreU9fiL0gKhlIKsAY3KrTYAr7zUqg/GYJqu8WMvNJZS1Hy3vUIzG4JW5LpbjW6jX3T0VAp2EsBRNx1iM9Qx+MYQLd0RMUTMiWzqhva36akjKbqy/8lUR6CWa5SI9vUsZjbWNs1fOSRYFLuwjKvANTWiTtpsD81S9PFwWZTFD+SVcTVRx6XzLyzmTYQ7QGy+jodx86pEzvPPHi+udP2LEkB4AM/7xC8/YwfW4Jz35VezpiAxyV41PHvOT0ikRDNiS/KOli8+/UrDtKELIUEZTmk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYRBArv035U6vYrXuHYu1Z4x2/dZlbUUPk6aU1x/2eU=;
 b=WVqi82xntuBdD5PUs4ifNdniDpRXGqKyasD1I1ALcj58NLsBbidKmwkhTi+CqGYYYH8iRWfJ+/o8PQnde7QwOWwCdw7Q3c96MfRsTh9w79hmkwDQEzry3eTC/nhk+nGP7R7L3sS09bRc4P0tyIjJvP26JuTBbfntn9hNjgXZ7N+P+SXUDFduexJfSZ6Fki7fXUCM/XIIqxUY1/6NcPCRHoJqjfio7kFMeH9OQDOxhYy/NGzFghQD7eQaoccvB33ZR09y9J1sItx8qTcsJyniUHdVjli6atw++bCnF3zHRcs1axJFfTVQYY/ySuiCwlh0K8jQUVOhaX44+X0qU3NceQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYRBArv035U6vYrXuHYu1Z4x2/dZlbUUPk6aU1x/2eU=;
 b=YbNpmzg1fk5RTsM8xbu9OWyZo6McaVQp7Jxz7vtaG6MNuuOtCe7zFcbpXOkuObLoC4sk73XL4X7CuOIOGs7++r0fyhl7VSUMPXu80KNC6YP9H1DH+89uaKzHeyjnjftFqTrk6WjDLJ0NZD0tLLJdMZo36GO1VO7QgEey6RgZIwM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:48 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:48 +0000
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
Subject: [PATCH RFC v2 05/12] integrity: restrict INTEGRITY_KEYRING_MOK to restrict_link_by_system_trusted_or_ca
Date:   Mon, 26 Jul 2021 13:13:12 -0400
Message-Id: <20210726171319.3133879-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a147d2d9-01f5-4063-3c1e-08d95058bb3b
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5211D7B7D1DBDA7C9CAC743687E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5i8U4M2VXGZXd7ZSoOJAWeiv+ldy2xsXEYUdWt9wktbsEZEsTPx1ft/oqxNVi3MWVug+JvbQGZ6m+AGmxT38mQJA5USYcVneSvCP2TcDgLr3n6XvODxgaNpI6w21JId+W6TTUKNFxgpxKkPFmvmhb60jOJXfVrLVajooyYWwFgWJ1XFHGWp7S2ENVpc4dICAyneoni3/ChZme6uXiwBfwRBZQ7Kmyy8GE8Pl8ke1tyYEgoY14pDX1AdMSyV5UnG1LXKz+FcTLEdHU1xZAUt7lwWggteCT25RKVxKyooOOVG4r2TzlJY08950Eud94+TNJC0nshkkeQI2lXY8yeGG+45/IhK81i/vcHmgtbHTJzXI7NIHTwoNbhw6d9r7Hh66t0B2SbyBswCSAR23aXGb2s/HvWAWomEf8rMmY9VnDLt9hLxFFYMuvM1yyoeNScDFr61AgkCpp9BtxcnbUcN0QNMkp0T258jdO5WH27zAoUcHJ4KGY+RCValKp5soyuKqbp6IH3HRN4Ur5D5tuRv3rRmM4DMlg1uORDCkly8yPLmY9IiVQ8F1VNCj1fapnl8OQb8GeoB16JP7kmhGhJZdllBneQSbXpl3ndklDC3ANJCxQUNnZIhECfaWdaIax2DjzKXkZ+Obutj1XzxutcdY+BGTLYfLoI5FkzQrcqKOtU3V3wTW927Glp4T+PprnzWVoIV+uXs3jhTA4RVVlZ5Dncb7BdTlhtOCCI6u0zYJbcQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XDk7w0Ntlc96CzqCCK+1zmPGdPgkaoFqV1mSXx2zDm6fKIOItmwN1NCXs/Ca?=
 =?us-ascii?Q?tx9MgzTUIHaahlcIv6w8GoXYM8g1C+IrD3zdLyizTHxxOqh6Y6z4+igaDwfn?=
 =?us-ascii?Q?7/qopsvAlY7fJJGkGqVfvafaLdQd5EEbjWrFUNuDUcO7fn2lXlfONeibqUtf?=
 =?us-ascii?Q?UZ2tU3TmQVs48TkliY9rYDBlhewktbkNlPiP7abyi4+VA3HcPxN+DOzQxZ+Q?=
 =?us-ascii?Q?feFv7gB5cN5ABeKxz/yrROFYeAUbZ+G3p4lW4k2S0N/KwChX9sQWmcav8tTh?=
 =?us-ascii?Q?CzFviMOHZdv51jnevY8oBcMd6PWGwaN2sInRlVf1dPTUWYrlm8az2GjwtA/Z?=
 =?us-ascii?Q?X5ifNIaa6ELY7KbGsoO5obvEJyrdcCh8mBHbKhjxaJOUT2DHBYgO39v1R1t3?=
 =?us-ascii?Q?DML4iSROT1V5s2ngcXJ/JKMf7AtbUFWBl6vIdq4WM9ZX4mXhCIyqUcdTbJCH?=
 =?us-ascii?Q?bdzsA4kPKxzE3+7NUI9MkRJBT4Gf5B/Lt++lCVT01BuiCOxGQnHp15r3UrSV?=
 =?us-ascii?Q?JzDHM7W0aASVbgbS/cFAjXgewtwR4AWpzrWZ3ieaAFHnVDHHGT8vRgp5vwt9?=
 =?us-ascii?Q?clWl17EBVZGA9jOGj+tV83TS+JGyVV0vrBL/k7eGpnNhiy5OrknILZuJ6kPy?=
 =?us-ascii?Q?JxrGX8JZa9gupl2cFNXXYjL6ZEMQOK8H4Pme2qE9WwW4B5AeO6f1zMfC7IuN?=
 =?us-ascii?Q?9Oxd3eA8eZUlcEmvAm4yto9KYwUkR7YsCrQsHtyVqlf1eFTh8QXHGDB7iZzr?=
 =?us-ascii?Q?wKNE8F91QmRTfCYfr2myQCdO3BuDDbAk1Dc3Uz9HUCibktEGiN6rF8yIN8c/?=
 =?us-ascii?Q?O/+OkQha2CYZmrQ/YeF0uAJi5HgnuWV1j0PQzQYbhR1IlKnpfVYJnR8olVen?=
 =?us-ascii?Q?i72jv68TILHKu65nEzipKDO9x18laMgdcSflUkF/HXhut8HEpCHb8mLG4YOo?=
 =?us-ascii?Q?6hgBd6Fz8VhNQhtmj5hB1IL8P3SAXTYYXbbz4HG4tmnSWOE3VkDl/e19l8Xy?=
 =?us-ascii?Q?P+xn7Inw5ikBqlr+7WgR+HHzxl0SivYUs1GFxH6QkjLY2HMTd6inZBX7/T0u?=
 =?us-ascii?Q?/4+akv51mQboze+oVTB6nwKMC7FtjibnIHzVQQEJtnx0x6Zp0c+jn/IFkPWp?=
 =?us-ascii?Q?Jwp7Cp3gBRsWOjyXJNBJODdORnpicxyjOHSZOZhwKl2AlAywVhGikqjoe3jw?=
 =?us-ascii?Q?11BuSF6eMbIKZyM+vofICKVbOtrHeiPiGxxmrJ1FiyUSuv/jZ6zEVsucLiMh?=
 =?us-ascii?Q?Mm7zFgNX9WpXeSKeQ2ZESWmfgGwBb/pQ0RLiTOM7Xj1D9157Mt6CrG6JfjzR?=
 =?us-ascii?Q?z+WQ4ycqutDyUoL2SauFxhZA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a147d2d9-01f5-4063-3c1e-08d95058bb3b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:47.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U731ggQdGjoPxAykGF+FMMW3xLujdsyhPm6mEx6Q3y5jQ0clA+x2HR/d0PzuDdRMh1QXDg2HnM6njIarAla3tAfUCnakCODDD8Yr2iB+PiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: NWyThGTKP-MJtqFcVKfJIkL8WZTgY1ba
X-Proofpoint-ORIG-GUID: NWyThGTKP-MJtqFcVKfJIkL8WZTgY1ba
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Set the restriction check for INTEGRITY_KEYRING_MOK keys to
restrict_link_by_system_trusted_or_ca.  This will only allow keys
into the mok keyring that are either a CA or trusted by a key contained
within the builtin or secondary trusted keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Added !IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING check so mok
    keyring gets created even when it isn't enabled
---
 security/integrity/digsig.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index e07334504ef1..2f6898c89f60 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,7 +132,7 @@ int __init integrity_init_keyring(const unsigned int id)
 		goto out;
 	}
 
-	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING))
+	if (!IS_ENABLED(CONFIG_INTEGRITY_TRUSTED_KEYRING) && id != INTEGRITY_KEYRING_MOK)
 		return 0;
 
 	restriction = kzalloc(sizeof(struct key_restriction), GFP_KERNEL);
@@ -140,6 +140,11 @@ int __init integrity_init_keyring(const unsigned int id)
 		return -ENOMEM;
 
 	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MOK)
+		restriction->check = restrict_link_by_system_trusted_or_ca;
+	else
+		restriction->check = restrict_link_to_ima;
+
 	perm |= KEY_USR_WRITE;
 
 out:
-- 
2.18.4

