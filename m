Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3C640B9F8
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 23:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhINVRX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Sep 2021 17:17:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:56822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234792AbhINVQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Sep 2021 17:16:44 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18EKxeSG018644;
        Tue, 14 Sep 2021 21:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=KTA3VLFo7rEsvxDaO/x6l5dAYLwN6ErwXF2LEUU65y4=;
 b=tPqMeVYFMZcQ/KQaxx9P7mkCxAIFfOqVtcJVVcQKlTvbic1JeKTmeXNE+oOOnv8XYr6W
 qVbaO/W/+XbCie+wL3oMo6dU/kY/z8LwkYoNz/NdfNxQ6IKmodKntKZN+ddwk+SoFORh
 MO/q+EK+huso+1yEaToBqMkxmT9bC1nrnZRwiimZbBOrfpV8fmKjtBl7BqToznTXZmcd
 Ugbx9KqC4ZzU/9Gn65rYz80bltWOjLNoWlP6mDwHA2UfRxFwcbAq0XyJbHZwQq0jVwPZ
 wQD9lRi/299nEaKu2pZLoI4rNFJFD4aExLPskbNJnxIu11YBq1ttbjGNsF/GI/hcYI94 Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=KTA3VLFo7rEsvxDaO/x6l5dAYLwN6ErwXF2LEUU65y4=;
 b=oDMsCW6NDhBheKpvd6ybOICU+A6j5AQYV4z74p/4hL4Wm38JsDIVpAdWcvMg0IV8DAXh
 VlrJPwtEhVoH7PPyo4D+o2zNZMZEvdZ+V9QB1CeD25qpyGGDIP2+Bj7gqn9k2iQLwBeB
 VoF23P0UqUrB14ZcLeuXHHPDcB2Spy9z2QdbJ2qm2v53iOEA/IznYXkZwrtXF5PeD0wK
 6WzMRJPSU/yikBpAFmdjc5Qn8OfYmZV1edX4/nGwOWM6cUGCBIICxLEEfG7G6Wn4sZrY
 qk44k2vk3bdAvyLTRvcYIpy29GTtr5cKAooGhxv30lu/n/BvpGh1Gc7BC8vqztJ3Yq26 eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5ubhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:09 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18ELBAXT178928;
        Tue, 14 Sep 2021 21:15:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3b0hjvqwq7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 21:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnWHyw7D0ryCLbJBvXoumzqKnRs97tCRYZWjM2zeEgArquT+7HT3iC1/qxCAMmcwRTCF3LOBEt9N+c2rX91cBpaogaCDY/+nGmA00SvKB/UNHShZ2bbnbWPhTndd8xmgclKsLVR8HL8sWIdKUwcF+M8GSdKXUncP8rquBaGMWjQ34adRgTXSuIfpWvphh/VclUGrPlpY/BYdr1qxA8dVr0tx2LkPAmqlNnmkpxH08m+OXuZpOsnddboAC9Iw4+QHVbHo8cd55TnF3L8Vpvq0I5KSPA2Wvf0cbPEjFcQ5ZfZI2NL8Y1624biqJnNjalAVkFtzUz7fpsNbV4n4hGBvYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KTA3VLFo7rEsvxDaO/x6l5dAYLwN6ErwXF2LEUU65y4=;
 b=fkwkhALZXeDVCEkpjiP4gZbVTLAnejfUxxrJB28x6BicmRo77k6zAAY9cvR9fq8NrIudJflGh5+jrSJfjNXtT5NjpXNb2DP/OxQl1Thup9FIcumOc4V8i0H+fSK1pO22HEP03fOiin1Zrv61Kd9hIJMALlBO+SkqzHbD/F0BXBusS3TX7t0tP19mMJPC9SGe2T4v4PyF2uZqQmylHRMH5ZkOcrwj97dNGFOVKlAbB61/R1FNHnGs1cxq3ONE0hTLgFP9ARt6mEvqLQY+096YfjwPr+tZIbOpN9KshBZfRZ/aodvD38HQkiZtIP/woVHBbWdF/wWDPQawNP0kzz9g/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTA3VLFo7rEsvxDaO/x6l5dAYLwN6ErwXF2LEUU65y4=;
 b=eCvhdIAG4me4TBIvSAwjzp2y+g0HFkSHIF8I+uLcIB0ntXMBP+1Vwh9hxOs0aDqypjbW1887cIdJmAdh1GPRflHKKGLPph52cvN5g5QV/Z7b3A8DqIx6QMeI8psWs+xhbc7jaQ6rDszpS2IHE/BbKSo+4xvp8aMpPqTdw4yb7Aw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3784.namprd10.prod.outlook.com (2603:10b6:610:3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 21:15:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 21:15:05 +0000
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
Subject: [PATCH v6 11/13] integrity: store reference to machine keyring
Date:   Tue, 14 Sep 2021 17:14:14 -0400
Message-Id: <20210914211416.34096-12-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210914211416.34096-1-eric.snowberg@oracle.com>
References: <20210914211416.34096-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0165.namprd04.prod.outlook.com
 (2603:10b6:806:125::20) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from localhost.us.oracle.com (148.87.23.5) by SN7PR04CA0165.namprd04.prod.outlook.com (2603:10b6:806:125::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 21:15:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c20f2d-456d-49be-f778-08d977c4b926
X-MS-TrafficTypeDiagnostic: CH2PR10MB3784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3784EDC9B8A1EE6DF742C62087DA9@CH2PR10MB3784.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWDMbfpbvby5D8rABKGBQA4eON1fQh5HKl5j33jujfS3vOOjZdLRv/0nGrNgbH6fshStPISD2t6GiBPhCb72cgUIc0lDuUlXcj6d+gu4dsB6ZoCQtD4bCiJk6RsPNmjyYORq0/0mspifaTFTjCJQqpfxYyh3wHghViEj0uWWWKvVGUxQdUFiMMw5RFkRccAAjMKe2g3LPqzOozIqA/BrU/ZC+zshasYvD/BzhoA2iFj+JWRxNiUg5juEW1jPMa+YJwLABRY83CFyTq5liGPkDM6jn6EXKElbiwdxjqZ1jCMnjc6fA4w0sAJfrrCStUBMEqcRYTccaGA3Vadya1CuMW73I0BvXxDe1dmIDrE/l9VUJ05L1Zyuz0zgWS/kuWh1EENig7FDEonDVszFbQlXHXn2YowuCu0zVXig2iBEi/O9gnNRUuXasn0F6EclRC+f5xQU/tNaR36RAI2cP6zZM9rCHoLzgowZhwe814EY5p27d0CcYD79JjJ5yWKC480R5Tm7vKl85j4tIRI/WDf1AIom/lDVFsTVv+PiYAsiQUb0ShPenkxuSUXU/2da+dPBWHpII/a+Ri9wNfhLI/MJvZf7WONzDzSYildj9t7vRXCtetxbE2NoHttd0HOFjlNGbM07G8ZAizGVHnDCvm+aa9VNHpZxo2gpbYbaXBr2VlTuiauLQSvvDnuqCNM/6Ip1N4o7FsCNAEI7aFA/rp4JX+Nz/h94jES0TPkEGmfGwzs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(136003)(366004)(346002)(83380400001)(107886003)(4326008)(2906002)(2616005)(86362001)(4744005)(6486002)(956004)(44832011)(6666004)(478600001)(36756003)(7696005)(52116002)(316002)(921005)(1076003)(66476007)(66946007)(7416002)(66556008)(26005)(186003)(8676002)(38350700002)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HIwaqBY7Co8jE6RmUKc5tzzmod30lLLVsk3CA8ZovVkyZyfnYUSRsLET8sqJ?=
 =?us-ascii?Q?waSzJf/TnaR1mH92FNTJJVLVgvWtGRDHC4gxiZ1OJGQ7VdnaUJ5cU7Hyvo3p?=
 =?us-ascii?Q?bPYQGhWqxyvDsSe5yjFCPMct0lnqR0gf7FcuLfvqrfhL4OeTGIDdboDRgdCS?=
 =?us-ascii?Q?XHZyQHsXQslRC+aQwnYwRjI4QjAY5ZCcgvPOY6q4S1snNHWPjLRbq5j1wXjs?=
 =?us-ascii?Q?wFNzviya28Ql/j8+L8NTy6zDEX+k86iWQyuoBmgt9/oegkioilxVLdQK8ykS?=
 =?us-ascii?Q?aWRrxlBnopgnEzBumAQNucYTOezr5vyGqbtUcf/HczR3bq2n2tfDAWMfFpeZ?=
 =?us-ascii?Q?t/8msDxEo9PMybaj4EsoB6Lh2cJjlFzZNHsSjFhPfBXtzJIF6xEJmHBcI1L5?=
 =?us-ascii?Q?C7MBTzRcXHGE/upWW8JjOArMoQvaB/19tiMYwLh/VSfVCeo/odCId2VbH0tc?=
 =?us-ascii?Q?CAaEFYlB5xvIGVtkmr/ry9wopGA9BvuTt1QXcdciyGjGOAOBYK8gFj2aVDbW?=
 =?us-ascii?Q?CjboXdpKGmLjK89JH2iFzixDeYsQSMSXn47ikIu5cyI6fg6uiOtiV6ZvW6NW?=
 =?us-ascii?Q?Wl8CbjAJJS7sAI5Qa7/6hSykEjghnVkiyPdIgfzjRNAm8E1NTVUlFwj9aoHv?=
 =?us-ascii?Q?CmfNtWKlY9ZKr5AzSrrsiJP/CpWf85tAFOo4AkxvrXx9Y51aNT2twcry1xcI?=
 =?us-ascii?Q?n4GV0D3DpWIvaCaoioBZV4EtmVQmCcniFQ23Vh7HKuisp0ZhUucmWNd0EigQ?=
 =?us-ascii?Q?HAMqo4ebOxMGEOP8o3P9wIgVkkDD/CHRT2yMYlF6NPWNVATKI76RMx+N+8ev?=
 =?us-ascii?Q?mZOpUAPwcFkx6wQlspc5+cWljsnXPHsDjx+ZuIIoBFC0RpLyuYXLcVBr0NC0?=
 =?us-ascii?Q?Jl8nazMsDRmx+w/Qon08ZbDM0xFX7QW0SH1+GDW0isOt5PjyNmNkd+/VfAny?=
 =?us-ascii?Q?E7oBnVoPbgjz+k+CH/BPSVKWdfILS+9hOPcTQlIXSOofLlQFHTDTlSYrbqTN?=
 =?us-ascii?Q?7K89VrS8v7E+ZRfHTlKNUloilVfFJQIW+GHWXUiUtalteWbdSfh5dJsuUUrH?=
 =?us-ascii?Q?roMlP/37JXmaBOK6lX+/zsohTnulg6fCQGEzbGZewEP9P3KbRS7bq07POf9e?=
 =?us-ascii?Q?Ref/8QpcQpULFqlDI6gOus5Wg8p+rBUL3UzqsS79QN457LWttUr0cbcUjqAW?=
 =?us-ascii?Q?KvNFqM+2t/t/VPrIJNDW6MMpi+eWhZzgQrVCuJ1fOiTpryEk1JSKXaU1tcAo?=
 =?us-ascii?Q?Ocb4anF4310Z5B6UpZzq8zaDSMkw8c1RoiZS147nTcyQaFQKXPUdD0EVFJkA?=
 =?us-ascii?Q?qsz8qdCXTttv1oim8Fr12Sza?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c20f2d-456d-49be-f778-08d977c4b926
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 21:15:05.6794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KxqY50X6mY8aa83MsrT+7TFDhnd4q9h9IYOKP60NWNBAhIQlfGo+h6pND/T0YLaTNizyqUgQ/Mfr8min+rbL8tWiozgw3m0npNkZs+wy34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3784
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140123
X-Proofpoint-ORIG-GUID: BHbq-lbGJNsTHukjbnHT35E8jWbEIlN8
X-Proofpoint-GUID: BHbq-lbGJNsTHukjbnHT35E8jWbEIlN8
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Store a reference to the machine keyring in system keyring code. The
system keyring code needs this to complete the keyring link to
to machine keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
v5: Rename to machine keyring
v6: Unmodified from v5
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 74f73f7cc4fe..109b58840d45 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,6 +116,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MACHINE)
+			set_machine_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

