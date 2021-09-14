Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C515440B9F6
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhINVRT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:17:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58454 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234829AbhINVQp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxdvi018628;
        Tue, 14 Sep 2021 21:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Yl+xa8zty0HoXEGw0xbnz8s/GfHcrrFSpEDhsVtRzwQ=;
 b=FAYFc1iYHHOf00WG05Vauq4BYHKOoyCba3dIXWUOZmzQ+Zw01LqY+8j4R4wqhLX8Di7B
 O8IVrZV0jT3kxDY/KHbLIrsOTHVh21YMTuW4ocIeibEyDOJiqnuD60rEpsK3sZkceGtS
 h4Dc+LorL0VMd4zdURG1g+sUco8FqlyEXpgpIeQCV8thgifk+yuI2SkP1c/Ebvc+A/2B
 iSi0+kSsRWjvOXtHLUPLU5RrxugahOsde2i9IW3GiZqgI1qsvi8vR+eUtdriDsI+yLN5
 n3i44CMLM7+joWdaZxm1FrsWcv8uRAOT1r5OYtpzBiGNOIYiIuGEma5k7RMX0ACbOMlH yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Yl+xa8zty0HoXEGw0xbnz8s/GfHcrrFSpEDhsVtRzwQ=;
 b=nf62KymzjcS90NTmGjWeVmSSzX3H1kWXy4ZG6SWLl0EsmZN7wVRidQdJ0VahnLWW8DGE
 2aYeeC1klKVt7VjKpEinckSXRpjg17PhFBOZIGGThJDoMC52pHxsXfDCxi9KxOLqRhg9
 T50Tkc/KrDWrmGUhYr2az4/wJsTg5mm2hqJbzE/rbBtKMV58pg40a5hx9+Q7o5H5T7CC
 NUPyBC4urI4fqfLbjzBpPWGPZUlDx19qxpx6YOMVRfCDJ66Trz7JK4yoHZnzfCdhfr3E
 Q2WiVvPEuUk8yurirB7EA47G3pOE8iorknxfL1vr6b9yY4n8s2MUSdLeBR8fzEC96aI+ pw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5ubhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBAXR178928;
        Tue, 14 Sep 2021 21:15:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9vfcMB8l+C70s1U16itMgNLSiJZzYvuvV9azw3fS5/op4a2WFla+bM0hfF1NKepmJNWw5PjihkzA1Ss4tlPb62sJdGHLL3N8rFyEL3/ueiIM+6UTU2X0YEapohPfYLq6OzK19RTQAu1ZByB6MCjLRVMVMJl0NdJj8XF/6osadCDwESwXASbLgI+CCBZ3e/I8q0aysr52Vpzt7mlpdTz6G+ylyRqcg38TAGs/NRE9NlcCD7Rhsztq8B2izWjPhq9xoyG9K6nOq7S9bMZ6lrENVLlVYWQFFpaAPaMz4ZBcKSsEZf/zP+NR3Qox/qPqAPFJ8vOMQbYXRnhZiuc9IXWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Yl+xa8zty0HoXEGw0xbnz8s/GfHcrrFSpEDhsVtRzwQ=;
 b=cKISg6c8JcWKyY1+pniaAOCt3fydITr3mWwZB6lVOAXRnXeZQ9X3W2UaaGKxe44D+CY8cG1haaOr5jutqojq6KN5OzUZ6WNrU9wPBtZXF+GxUN+Od1pIEvchMkqS9gUGUH4Jx9RkDH5YuEv8xoU64Fr+qLWY06kOtr/dK3OfgjZq5QpHowQc/Zsqaqmy9ZT583f4sVjv44DRLFyok0sjtxlomQh7fjX87t45Qkz/saKuIv4s4SwVpPXbOdFi0cYr9k5LMzi1t2eGUQoqbJXjfdkyywZWp4JqPSEFBCtiU29bJLuuZcRmAC8PVjjqA3ksUN9wLuqxr07MM5rrV04JzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl+xa8zty0HoXEGw0xbnz8s/GfHcrrFSpEDhsVtRzwQ=;
 b=WfMgsGxVLLidVySdDbhpgXeMF+glDlr1db+pT4gQLJ0qmkaUpMW4IA3Q0H9RmxoRCtWhtqL+SiK4zxQUO7P7CJMKQb6jq3U5bLL0/SDo+E9UOxZJGtNTxEYTw54l8dt58S2PGpQAbUr8iXGZ5Szjg+o8MV/IfdmS9bflnGrGb3c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:15:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:15:02 +0000
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
Subject: [PATCH v6 10/13] KEYS: link secondary_trusted_keys to machine trusted keys
Date:   Tue, 14 Sep 2021 17:14:13 -0400
Message-Id: <20210914211416.34096-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:15:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13850a3e-1959-41bf-51c2-08d977c4b774
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB37845DF85C1C215D071F80F787DA9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwfjzDdfRNnwCgN05SZOtmr6lgne5zoRWVhnoSK5dbwCe8KLcIaf0XaPEvWkT+xfIUmrQ2xDJ7lwr//tBEdnXq35pdWaXQfSpo5CBkpsLbW3WHUPbcwNALVfjCBeNMASsp+VGuZh9TTsUkubt+Mf12ds0wUE0xixySqfUpvLmd5Ov9WEF23phDeFpvbklbsHschRTrNqWmaXnlbrV0DkiVI2+YKOrtqnk6VnYH0LwrZvAsnOe7NC1QP2drQ4HmTWnVouUpLQLR4Gh9fU1AU/6JMFZvngANPsux5lhKtuPxVxfFn/gLC2MrYRMbaj9+jlAGGAzXhwVqqnA9YSgoulSLnAp9qJGuT1fMzcR7npgud3EcH84P+Gt9dzY/6hTV+hqoGjtWRvaDNK6k6NBmAYb7lh2y5xjRGB8irf23ijpViddsPf1bn0RTezFFzR2Cj3u2DW9HHNDCduO1Xh/oOp2DClO7HTklB1joR+H65OVpvCLZAMObm9Xd3d+Ilrf2DXVm3t3Xl2NxmOPCCDsjBqBJMP08koMnPH1RwxoJiUlfaSyPuDbtKb0VmE27SKcMQRv9NWANErqVo+Q4aIOgNEqc+oEQ2eRWxUBwBYcFjhJsXUfNPD2fURc716M1POVbIKKW2lWZ0yZ3EB3rXuXNq+bJBoy/3Uj7udRAKjIId/T1EYrtcARIakSlgohmJ0z5za9cJZztY5caKZoLN+zqM/jn+VJDEleIIc0xDw6hFxSZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(107886003)(4326008)(2906002)(2616005)(86362001)(4744005)(6486002)(956004)(44832011)(6666004)(478600001)(36756003)(7696005)(52116002)(316002)(921005)(1076003)(66476007)(66946007)(7416002)(66556008)(26005)(186003)(8676002)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AeSCV/iIAd4WPfRVvrNFBMyw3WmyGcgl3+rh/RMBJqBm51wUuzV6mJUHMKJU?=
 =?us-ascii?Q?Xyl+zebZBufn4G+UfENxATW+dAtExY6rl65ArMrvMAslga0oU8OkpdHZzJSi?=
 =?us-ascii?Q?KVPwcjO7hrD88cidqix8/tZLgnLTcq+ve6dyO+H4tW1AfKSanu9pqJrLLrpj?=
 =?us-ascii?Q?rLdY6KZctnC4BJhWJ0TfYuU9L59a7oc961/qPhcl/94Jpb2zBLDDW2GUwcnX?=
 =?us-ascii?Q?TqayKCDVNPDnFnsxJp+HTt37pxQQfbhIYspI96B7V0G3ix0+Vh1prc/Jx0dc?=
 =?us-ascii?Q?WpQ5I9XMZbF28n5ZdkeTucnaFTmljbDEB3K2+x2CQ1Ht/wAGFhXZoDLTqFHe?=
 =?us-ascii?Q?o0ROL0aQfyZQ00MEs9zsutI6wmW0dm3YBG727kboUGieO9FVw/A0xexD4S3s?=
 =?us-ascii?Q?EW3ydyvoeqbYKfoMGvwpw4oS92qFBUSE443iKpf088sATue8hl8RPEvOQxOT?=
 =?us-ascii?Q?jExnTC0yKnxToBF5p0h7AMtviX8dsGp9kABDygjt2Pt9iulsHcMPXVpDzPkX?=
 =?us-ascii?Q?YWAMt8G3za3RnTsKM+6ErpnnwdPLG3hkRz9/Y1i5D7qLe4N2JiIZ6dsmDgLh?=
 =?us-ascii?Q?TGAU3ajdk43uKLjizyCz39y5tl4PRaw54QmNAikG0geVFZqycag7VMhbxbP6?=
 =?us-ascii?Q?BZ+EDu1iAbeM8ZbLn8MnV6xhCKcfk+2/HSO1VgPzP9HkynWTBMLrESG1Pg/h?=
 =?us-ascii?Q?8W6UaYEuSWUOe7aq9idQJGymNYqJYv6/vqayOZxGnB9bNbwB+FVRZpjAxdRj?=
 =?us-ascii?Q?th2vVKo0oI8DCttryZJ4owrqVOYvkR+jb2C6UsKBxmHJCr2zWzcYXq8OZDFi?=
 =?us-ascii?Q?GfFJAkS7NLqN1NqoF8dHO9Wn/CiFYNQ8j/sQDJrLEmhThnbyrqCy5U3IsL2J?=
 =?us-ascii?Q?1GhiJHWfTz75mxJsiEZLGxD7Sa77dgIf3zNdnwZPJud4yVIsEVwE/khBmbe1?=
 =?us-ascii?Q?dJByzBbHVSeK3oejVtdIrBbIBY/cK8dzGgOSxaHf1nCZ8q/Ahybsy0NYpsmQ?=
 =?us-ascii?Q?jeoKTee/0g28i7H7r2PN6h8WtQO9673vJ2w88RnjNQCPICC/ZQUz/CorBEa0?=
 =?us-ascii?Q?AaVhktgZduW/JWUbs/AxZPL5mp1vIWAzR62/nv0avfIDLKiJmuv0SBx/3RXw?=
 =?us-ascii?Q?hy3sD1jYDACczjdd3FxvSqMyiJ15cJq7IvEKBjZqoKjES3kt7Cuj2vR9hvla?=
 =?us-ascii?Q?a3JtmFlVlcGGCsYgiCUd/uXr5naTNvkOGEopqq7QUlFFbTXzpRJQDJZvx3GY?=
 =?us-ascii?Q?jWiEPK2BkR3eKt8asYrMhjK2Fl0tliFxPj8VfX3JZ8zl/7ZCM4rcaWejQwZq?=
 =?us-ascii?Q?WtjYFUnucZc5REYPWYV+PHl/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13850a3e-1959-41bf-51c2-08d977c4b774
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:15:02.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1iIoGQxaKhVf97J5pwEhiN3RqHba3IVz0fFJZ5Bwn2w7zKyMtl24bEBaTlf1QKmEkkcxYyQyejsd58j+lLdxVnUMVRkj/c5gf6iRnjVd84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-ORIG-GUID: IXNi8Ne7anXqb1-R2cSSuElNNbkESvUq
X-Proofpoint-GUID: IXNi8Ne7anXqb1-R2cSSuElNNbkESvUq
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow the .machine keyring to be linked to the secondary_trusted_keys.
After the link is created, keys contained in the .machine keyring will
automatically be searched when searching secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v3: Initial version
v4: Unmodified from v3
v5: Rename to machine keyring
v6: Unmodified from v5
---
 certs/system_keyring.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index ba732856ebd0..2a2dc70b126c 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -101,6 +101,9 @@ static __init struct key_restriction *get_secondary_restriction(void)
 void __init set_machine_trusted_keys(struct key *keyring)
 {
 	machine_trusted_keys = keyring;
+
+	if (key_link(secondary_trusted_keys, machine_trusted_keys) < 0)
+		panic("Can't link (machine) trusted keyrings\n");
 }
 
 /**
-- 
2.18.4

