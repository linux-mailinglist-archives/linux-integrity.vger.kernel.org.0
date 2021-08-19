Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD973F0F4D
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 02:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235504AbhHSAXK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Aug 2021 20:23:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235258AbhHSAWx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Aug 2021 20:22:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17J0Fwx2000473;
        Thu, 19 Aug 2021 00:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1SUwqIAtgVwTvQrlM69Hzfm7S6Uke8xbxje+kqS8kPU=;
 b=nA/u5NmNqoW12EyoSML+JdjOHhMoV/8Yg4+ZLjdFGOTtzvTcwrbwuomK4a8b2sfSIfOn
 4qtvS1GInjT+3r4vHCuu/lqr3NxRnZwa2HII+sbR7cRRHvwRvgndIUjDgyMhSYn/NqQw
 LRziOI0tGqiLBlXJw8N6jBsi7uhETVptDfy4JIE6k4HE8bsQ+oag1dC0XEw+X3TAatyx
 CLKLkNhCWm/H2Q1HrJBz0+ZHTPEz6qnyhv7YjxTxrTEmtkyHB/NY/pE80RSMG10xQKLc
 GueGhjm6XIOxFYpJcxtJtqTQ+uKPGPiUihT4/saU+F2Onu1Hx7BkKqjDbxxhxFC6UuUD Zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=1SUwqIAtgVwTvQrlM69Hzfm7S6Uke8xbxje+kqS8kPU=;
 b=xYGJT14nHo6dvBK3/47/T7eBqSgupCy3ReBncgDhRTCteRMKQdJWNCjeYvXQTNePy6Er
 goIlxXISy8tzan7BVweudCrt/ErvkFXak9gxw/GKkKH+uVvHFt0s0dzc7GqcbQcYRW4f
 N2I55fw+86PVEtDH2WpkMUP34paw6Jna2vSXFshmkv9TOKCb/34cxnBUqloOuaaiWJA0
 0m4LshlPMDe89URxnG7sRP5PAceHlOxgNfWstVn5trqrafkToR1/NurUkEzcxLQhraD6
 vQ8wyFZxEpgbhcAD5fV5QAfu0UCknLkHLyxHY3piOdgY4U4M09lW50Nqb28/UGxGCvOz Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7dc321-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17J0ExVq007566;
        Thu, 19 Aug 2021 00:21:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by aserp3030.oracle.com with ESMTP id 3ae3vjf8mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 00:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUBSt4xejlo/AUXDIZcbgAj61E0x8+JaGvpa3pwbwR2imYhDkG8wFVsA9o6KIven8AmUDET6BOGCXiPXEjouQ3+xHeslinZtbYLcIoMPLVfxhtDTtRSD99QyT2Sbs94ZVRuTehEgJl00ZFl2SdmsvVrtKlX/UDSPO5cI1G6jj0ZGqMfNu18rOsZwpqMa2B6uDnkfI0tblrvhgG14E1B9lRVM+7sejximFzTJynFyr8lgy7CVk/AK8w6029vL9OeItZRYD5kwvuPv+j+CRBxvNBSjrjX61NBr/lc5Hw7ZIdDJOGu1OAr4+mVv3YR8+Ov4XteAGStTEebqVjKhwZ9jQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SUwqIAtgVwTvQrlM69Hzfm7S6Uke8xbxje+kqS8kPU=;
 b=DMvbhQGUllicqupUvToc2ZHcj1e2a4++iMdtI+saxk/19THboH7OGbeRMyMiGguc3EK6vJsAZgeJJg1dxlun00y/FlLVxKHqzDDuPi3+lpwk+4dy7OBh62/XEVlCMrZE39Wbx46R34K1PBlJmXAfLKkm2jCyP/Qw1g11e8uf0qTOIplB9vuTjd0vESf6RtegWMJKQUcmgZ8seMINr8z37pBQ1ihrVCZ+gIFivvoKf8u7Hp4VThE9B7kKSUHUfJrc8cTpo0ho+w/K3CAUO7+jU1xjca9Dh72wf2dSC9ck8bvjb3JSynOWhxzqXJsGMBG2Ac9/iKiUWLCm2h1B+bqkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SUwqIAtgVwTvQrlM69Hzfm7S6Uke8xbxje+kqS8kPU=;
 b=qFEJoDOM/RyHQaAXubg8pgy11NJe3bsCHwzJnkF6bOPZAKPjcCODSwFdVQOtK3fRsrHGkzkJ4zV70gckWPkx3DDfLWKEj0GPGiHWey/EE1E94lePiRvDmOezshW4qCV6iuyOqpSgUmWJO9VAUcexCcaleHpVYyTMFbfgnYBEags=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5116.namprd10.prod.outlook.com (2603:10b6:610:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 19 Aug
 2021 00:21:53 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::bdce:cf4c:518c:fd15%6]) with mapi id 15.20.4415.024; Thu, 19 Aug 2021
 00:21:52 +0000
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
Subject: [PATCH v4 10/12] integrity: store reference to mok keyring
Date:   Wed, 18 Aug 2021 20:21:07 -0400
Message-Id: <20210819002109.534600-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210819002109.534600-1-eric.snowberg@oracle.com>
References: <20210819002109.534600-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0401CA0025.namprd04.prod.outlook.com
 (2603:10b6:803:2a::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.4) by SN4PR0401CA0025.namprd04.prod.outlook.com (2603:10b6:803:2a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 00:21:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bd81f9-5ff1-4039-9217-08d962a75813
X-MS-TrafficTypeDiagnostic: CH0PR10MB5116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5116ABF4A432743E4F66F1B587C09@CH0PR10MB5116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BXPHTwZYhbrWyZmckKXyhGNCXa2DbXWr2GToR5DskppfMNekPFoUi9m1HyLN8hUucIKbwcWkh+yu8MZjeDyVCezvqyO8F4r2znEtVtZoQCkIpuFxF5l/sdWwGpzMMtaZx9rDmcUc/P1NmPwITPXSMae2oY6os7VDoYAfUTFJfYCFyOhIGucSFe6uJcJXiNtj7PeFucBdKoYepB/suvzOOgDjf+U9rFvqsmQl3O7RyPsTdFw6qb1+HA3rQ2miqqAsCFZszeugMnEUuuUeygkx+OcP1F7TsFcAeBnv5ghGCoipmSZmO2cvI0RjxwfusZv7HOZrrK0btyYHhgogqjceqy1phb/00xMiM1bfx02G91ZzLht1KQxbPPYpccAnJZcmEpuvlZXbwei1MwIZdEXLSc6rRo7SrzvLhlXRohowjKCb6aCYiYMVUR4/WTpwHUPAr7mxnq2ecdy6mrmrvE0gx+9OZ1khB1l1AGLoPAf0O5l/2SGNQXsWbyv2FLmecoFGNvNtUtV+vI3n9a6e3kufnTIsH7RP8RufmSx4ppExO0Tem6UWSUxH78bXJVzxV2X/60ji33Q1SC5CiBSrnxiINQJ2fxvaw4g6nxAOwDJDbmL4uMiuU/BXsy16rA+PE0OorUpbGdUdmfWutweooEAkT69XiWH0S0EbOT1tqLssbfDSC6S+IQCx/IrjbYoZfe2JVzpU5QBH0fh+s0rUU6I/kdMXlM+8jwRWr7iDgyaGWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(396003)(376002)(5660300002)(4744005)(478600001)(6666004)(6486002)(66556008)(66476007)(83380400001)(86362001)(316002)(956004)(2616005)(38350700002)(66946007)(186003)(107886003)(38100700002)(52116002)(44832011)(7696005)(2906002)(26005)(36756003)(7416002)(921005)(8676002)(4326008)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8HF3MFYznd6mfx+VmipAK6GO4cyU6jGmV4wjXq605iY5IJ04+m1txI+cJu8/?=
 =?us-ascii?Q?o1CtPmcVfix8eu31f95pHfx9ExqIQkp/TttYs9pPvOle8EA1c6F/xijK+jil?=
 =?us-ascii?Q?AGxCtW7F/8k9oi7Rqlsn/PnazjZ11WY3lvWkEATr8h7DewKJ7KoVP+aBQ3MY?=
 =?us-ascii?Q?WaKTkqY+M+VtxHBH6vAK+2wLqU2SvdVrrbkmXnbmMCkxEmZ2FZKsBo2+0BoD?=
 =?us-ascii?Q?WxWK+jaVe3nlJDYq+1G4iIM0Q8xvj4CrmUUkoahQD2t6d/vGQ3rSIXu173SV?=
 =?us-ascii?Q?1X6fJFR+VIDZv0cYXPjECp8dKhSjVUwetY1VUhs/Q4hI6ZiEFslfPUne3wr2?=
 =?us-ascii?Q?NUI8+R6087iAAFJCVlhzHmSOyAwQPoxSaDbSYFsRd3IasEFUsofCiqOLI25t?=
 =?us-ascii?Q?iVTNSABgk8gdE9HYMAbN8e0l3QiEbmK/6qUuar/GEHchgRNF811Ep+kXkoJj?=
 =?us-ascii?Q?Q+R/6K6g6f0LRamhbmVwg03aLb1IP5E/YAxBw2rdIJIMHRedS55FnM/ssK9E?=
 =?us-ascii?Q?Kt7w3WLQBmMvcM14pqtgsvjV31KaLhOzTmN+Wp2HFGU2WxaSTw/6oOx7DGmy?=
 =?us-ascii?Q?7PIajPzCqbiQEyyPRrz1JA7GtQkBAvvyfsLExAp/FfNxMXzqoEg3A79fX7Pb?=
 =?us-ascii?Q?ZHRThRNVdlo2LrAV7tG604j2g/6j5gXrnGdkGixOgfvhCRDJlDcnZQ+4aHhe?=
 =?us-ascii?Q?z+SUQPyJC1w6bEXdyylSkLcYtiWeswKnVlxp/kFg5+is0yQA0/ubcbAXnZRe?=
 =?us-ascii?Q?cVSaWzO0g3/47x0EU/olSky90JjnmgWiE8Y3w7hJ38qwuNUociqj8rkcyJ0k?=
 =?us-ascii?Q?Vo2RZpS4sFPuSN9pQbiPR8KpzSnVkQS1DO5QAVSXiCQmpXV9TziuhWppTRXE?=
 =?us-ascii?Q?WD1la+zvZc1MMB+9a0vBu75ro2a3UYe7Y6kk4WEEENYaTnxUaAq+VBzcp3xw?=
 =?us-ascii?Q?ua/nFM9c/RLg7uCZ76kWyEuLoMjY7Gc4CCIRHmkp6u/2BvH0vB0wP8Sixqzz?=
 =?us-ascii?Q?dMCCQcuBWi2FeQ57BgIqmmUHoqCz7bbmARo/rLJL5FEqciPcyqWDMPeiAXk0?=
 =?us-ascii?Q?j0TAR0lNKy6J6JTXINY+STU25wCPJZxXLMU0T18n67/yWSune1QVXtVgqp1b?=
 =?us-ascii?Q?BtbeVW7gZfWPEMdO0zwJEgEptb3L2ceYMv5bRN1aG3juOIELgNc0IbpaplQL?=
 =?us-ascii?Q?D8SqGp8X+XVH+sNVPuaqifm64juUEw9j8tYkkEVAQAsjey9kv/tUPzkPPAkm?=
 =?us-ascii?Q?KTaJbpXNAwSG7gyGdGHLc3F55yKb4OWhhKXFgZ0hIIsf/xKs5Fn68RFwhyZS?=
 =?us-ascii?Q?wx3YSwktfVh2DF7y4eW6MRjN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bd81f9-5ff1-4039-9217-08d962a75813
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 00:21:52.8713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoqZ4tRsgaY7isume06RTeLPnKzJWcpIKHdtytJElYQrxaNdfug0a4ixqJdU/R6bzUu5wuUzkaXMiUzceer1mpagpJaJ5dV4E4PYseDm2HE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10080 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190000
X-Proofpoint-GUID: hSn5lnQetJ5Dewd23aCiHP_NhKXs1w9_
X-Proofpoint-ORIG-GUID: hSn5lnQetJ5Dewd23aCiHP_NhKXs1w9_
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Store a reference to the mok keyring in system keyring code. The
system keyring code needs this to complete the keyring link to
to mok keyring.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
v3: Unmodified from v2
v4: Removed trust_moklist check
---
 security/integrity/digsig.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index a93d558b795b..0f14ffef9c43 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -116,6 +116,8 @@ static int __init __integrity_init_keyring(const unsigned int id,
 	} else {
 		if (id == INTEGRITY_KEYRING_PLATFORM)
 			set_platform_trusted_keys(keyring[id]);
+		if (id == INTEGRITY_KEYRING_MOK)
+			set_mok_trusted_keys(keyring[id]);
 		if (id == INTEGRITY_KEYRING_IMA)
 			load_module_cert(keyring[id]);
 	}
-- 
2.18.4

