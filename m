Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D799B3D654D
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240984AbhGZQeh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22530 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241007AbhGZQdx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBpFZ008000;
        Mon, 26 Jul 2021 17:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=e3mwnTanO1Eru2mV6C6lBUUD8WSx9o1BkN0UkIxKQuY=;
 b=J9HYADxYl4jj84eQpsPI07eCsZo9qywviN6LLPI9/mIpYbP20D3RS7ZUWaxlwnXOfHr8
 IEZQQNiqGObop+7SJFw8yEsZi4r7AcONlK+7BAwcVwWHT8pHiU05LcGXrPhTxpbcr3DO
 Bz6QVdS6WWvtSyI8LZJzSubQOSm4D0TBYAaadGa7fpDp1PRA5/JLS5eZ8A+Abr6kE7GC
 sb1DbB/1ar+wpeCgnrWGEXTg3R4hKNiTcUzNXBzJud5Nq70Lf49RoBdfEKnTcip1vBkK
 h3dMDi8WARaLumK/my/8K9QKYFkGLU9SPPXINWrfgOCR1jqTN470moRYof2NVFU85gc1 JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=e3mwnTanO1Eru2mV6C6lBUUD8WSx9o1BkN0UkIxKQuY=;
 b=XcA/ApQdc78NRbH5CpZpJgtFuLSbUnH4YIv80EIZRY+xsSbtJ4zCHoLq4RbkF5bVoick
 ZuWYWQpoTAuSKdVsy/CZxshkyqzsXOxdpi/3ZWxQgJ+c/g69QNhy6vldpClLhyh5lk4D
 l/iGH362q2DyD/HQ0nZrAup4B8T86JcWg0jhQXBR7e8Pkm4IcIuG1e/bzzc0Sp/rZigG
 E9ar1/+tI8iRx1ZBeyo7v+0ffcEgCTVlVK0oNcPC5eoiuKjIXLsCdnUFIkm7LAZP3IFa
 T6eyIQgfMAp75tU5YrnwgiQWnwoU4Mh5bfvYNFdHUdB6Xa89yqjKpkEfv+jrokYWZuwx ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqsk1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBd0O043753;
        Mon, 26 Jul 2021 17:13:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3a08wewwje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lj9yj2BIytqxfgxmtv3DczMXTjm7ZUGhzM6X+luQRtvWYP0SPMGlQsJBaW76q6kixhBC3Yk53T+QG/gmWXmX3jDChdRgpBWZufw6TUsYUmHle6i9vs3j3XVJyGD5PE01LEHQUCgFEOVAkEzoVfI9nt+4r/BlDIWmEeySgxqP/IB4/2EQ00+D+dIGRrd2+PThU9BJzUfrzlti5HV8M0d6lE15UGinDIK47WFumKcJ7SVyJo0dkqrCT4lFaaF+hDB4cHV6tJIOSsRZQMmvfVEDVmB4Ey600fZ8tAUhgMOyPjkRVXgsVn+551//EdTm2/B35uuMs+qCoJ/tKo3I0Y7vDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3mwnTanO1Eru2mV6C6lBUUD8WSx9o1BkN0UkIxKQuY=;
 b=WGX4jJLD1wdWz+CABT2lfdsTSL6+46YkYjNnc5xiSDVjafx5IqFnbiCRCBQYNJ4ECzekuhmPPLqmeVtfrabDqsePlEA57AeCwfXPKBzBIYNbW4xiKJW9p7l0Yi84ML+civv8VpSruRldQ4mV2yUiw7zuz6OTAWLmj/LcTPX82k7eJgtqOlzglosxR43+tcRLiClDrWoDuVQQkYdyxSSgR7f7KUJBbbRn+5O4pvfSJ2A1bmfMBGC71vmbHIzesAnXG627TdpfwaZdvcc9K7+68ollkjSLNprq+vZ4GBzkkv8Ck4FLUhCYYEFRZRPRjYt2cNNDwIf42cUW+++z2wsPcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3mwnTanO1Eru2mV6C6lBUUD8WSx9o1BkN0UkIxKQuY=;
 b=faVSIA6eBrS62yWoDJwO1S83AEM8ne333+sI7CS8Vgp1BKQtVrSFYKTRNLAm3v+080y9/EvWEwXJLIC2Ggj5D+2VQxuUErP5VlcOdb65AixoNJAv8CdizAxvmm42vjU5R6HKe3RR86qar2wQ5Gryzg5+PXHo8+trfSXwCDksvto=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:42 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:42 +0000
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
Subject: [PATCH RFC v2 03/12] integrity: Trust MOK keys if MokListTrustedRT found
Date:   Mon, 26 Jul 2021 13:13:10 -0400
Message-Id: <20210726171319.3133879-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f739f15d-03a1-4b4d-3ada-08d95058b7d1
X-MS-TrafficTypeDiagnostic: CH0PR10MB5211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB52112824ACD7949E8BA840A787E89@CH0PR10MB5211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSFbs7suSNezk2m9K2kJvV2STEriruxZA8nMjvx2O90/gMccdBomMWTX6HZOcHTZVZljocuIaMNX42z/rRvtZVij0UCG3vLTgd/y65axe9ZwVVA9cctq8M6LFRmsH859WHkN1vNcpw4BCkmKkHIbCbqTFEIgnLQ5g7bRgJZSb4HubUYWvnMMeMg6X1aB5R6waC8FnP0MaFnsZunS2oWE+TMwzvr2r3iTo/yA42TRXQSOACEI0SsLh4qd/Dzo+PKca6N0cHw2m9WVbuoVP4RVXyUrCMQSvjCz5kUrAAhN78WIk4UU/aa5MienUcnFcfz/ceT4+KTk6Ra3WbnPkGjSpoP40lPkMBDbbxMP6DDNJRtQ5WdO3p75mqG/t3PPd63o3RPhbVoalqRRwnPzR2fiSIiAIO6a6lrYBJedhGjKHggruoFq1IHxQY9qv0kz/k8B8bXbU8ZJB0k7nsG0aQ8m67BaR/ebXIb56T5htuw8vZEtHHQ7Zk173GJBZeXHO2luedDyGp8xSI/RFp7idPjy0vsrbsaiskXd2hY309xvKxP1dNZXT3Q07oYEuw8BdFAkvy+41upSZqqDAnkgbAxRCYBsHhjBhWZSrjwQ3Sh2+BYLqs/hqWL5rjvPpm7r3H+LKyZF8ATaiD3q4FQ+l+8DFo5pcBsD+au03DPKBE6ocLCaj3aJFJP7FF0XwSzVl+FV15nhuGH6t6WVjqvcLXvXyNAnrN8AzgRwmZE60S7nPEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(1076003)(2616005)(7416002)(52116002)(7696005)(44832011)(478600001)(36756003)(66946007)(38100700002)(38350700002)(186003)(921005)(956004)(8936002)(2906002)(26005)(86362001)(8676002)(5660300002)(6666004)(4326008)(66556008)(66476007)(6486002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hxpim7CFEpCvXQRSigY6wMtnQ8QhiNtNAvs4qijgtHcWsgADtQ2xBrTDBABy?=
 =?us-ascii?Q?HTqch58JXlTTHaUeZ+tw8Xy69rJlJaoKuqDSTldX5Mlv/vg9Ew1cADrL1/hX?=
 =?us-ascii?Q?BzpIaZZL3qoPBcUHnk1Q1rBFJKz2Evxh7We1d69MEVdqm3iF9xd/jzpDYfzQ?=
 =?us-ascii?Q?XlPKU9QqQsXGL1jkawZ61F+olqMtwJybcmecWGujzOn2bWKkDdVqzje9xaj/?=
 =?us-ascii?Q?+fnWInfXRJ895Mr8feVrCUxVLAzzOLTpKHM3rjCuubNCX0HkYBG/ab6ptc7H?=
 =?us-ascii?Q?HdKQwjWB/UUEUT7/bbi0LUKIuV19AcyA21UST1L7w20LCRCKk6R50g6lA1Af?=
 =?us-ascii?Q?PgNuBxOzqpfb3Fl7b/MVC6WWbSO0IZgigq0VGAJgZgBZpFkbo4kbE9JlN4RV?=
 =?us-ascii?Q?nj6dRbgdQfzRjnLlDL6/dhexwQxxepBeXBS9/76qQkvbVAlSA0PFKv1oUn7Y?=
 =?us-ascii?Q?lWRtTA5i+YNnG6NaEViNv1p0mm3Roy1obhQRBgPUMLJNREJxOeu1S+weyuDA?=
 =?us-ascii?Q?USCSUB8gWyB5ZPSsSLc6ta9/yuOpnu43umsHbbzKya+JUVvRsvCJ0TS068Lt?=
 =?us-ascii?Q?XlWoGXy14JEoN91KRt4X+tU2Y/acKj8nzU/iIqDQHA5m7pF16gEqcetAaa46?=
 =?us-ascii?Q?dxGkWCnINx5NUcepw49S9ouNKhL0i3Oc0i9N8wiJGAjytrUooVbkCXxRu/vp?=
 =?us-ascii?Q?gEffosucALBAnw+78Un6GLgZAlzx7p2h0dqd8LA6WxG3+jMkv+LFe35M9rPU?=
 =?us-ascii?Q?Fgk9qG8eDmN5MVmvmOxNm8zZHn/g8gbpKgDooqmvyz1FSml3e10OypnOPRNM?=
 =?us-ascii?Q?uIUTwNPxVE/2iPRU/ookQdJj5ugFTW9EBOqLrT/P09uNw4/GOLoM86b7feFx?=
 =?us-ascii?Q?kqe2jsnElX4MR9HcrPocUPxNFHxk4yUAoWxEyC/X/V1piecBiy5f7gVHwN2j?=
 =?us-ascii?Q?BP9ogCjdPCVqOnWsQOnLJS3VEI8MCvb+7Tm5u6IbHMZzY+MCasyramCBJjL0?=
 =?us-ascii?Q?TR6Aj4MwIkuK8AFJFKRhlqaK2dc64umODKES6Fwx3SshNeqew3aQrPjWvsZR?=
 =?us-ascii?Q?SBf7VOYlDfDF/+/0S4G2EodbHM4CLPLA+ugNXbH29NPPzbI+MjkUeHRYilC/?=
 =?us-ascii?Q?ZMucGJoL2ViOC+Gftld0ljNBR1qawTJeIMlSl/VtPW+I/uY4k9cGTld5D0Xz?=
 =?us-ascii?Q?6ZZs+ku4MrPzb0hJohHVs/fPP9JjrTwxiF7CG31D/ZN4EgEvQrwp8IwYXlee?=
 =?us-ascii?Q?0Neas0oA25jjiqSpSh6CXRGVm8VJKISGpYLjicTDW55uBJ6XX5EcX21ayJd8?=
 =?us-ascii?Q?iQQW2ySEPiSzZY5kCjiyAaX2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f739f15d-03a1-4b4d-3ada-08d95058b7d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:42.2734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjyw24is3VUxDIUY3C5Zqdz4NojyhEQwUvxC6VP65vY5PapIsw3MyENsQEC7jQE/tVMoNPZdB6F0++Yh9sQNmIgt9XJXwzZ8pv17nmZG7O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: KZXCCym4V2TF1YwprUHKRUBNdzInkxDE
X-Proofpoint-ORIG-GUID: KZXCCym4V2TF1YwprUHKRUBNdzInkxDE
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A new Machine Owner Key (MOK) variable called MokListTrustedRT has been
introduced in shim. When this UEFI variable is set, it indicates the
end-user has made the decision themself that they wish to trust MOK keys
within the Linux trust boundary.  It is not an error if this variable
does not exist. If it does not exist, the MOK keys should not be trusted
within the kernel.

MOK variables are mirrored from Boot Services to Runtime Services.  When
shim sees the new MokTML BS variable, it will create a new variable
(before Exit Boot Services is called) called MokListTrustedRT without
EFI_VARIABLE_NON_VOLATILE set.  Following Exit Boot Services, UEFI
variables can only be set and created with SetVariable if both
EFI_VARIABLE_RUNTIME_ACCESS & EFI_VARIABLE_NON_VOLATILE are set.
Therefore, this can not be defeated by simply creating a
MokListTrustedRT variable from Linux, the existence of
EFI_VARIABLE_NON_VOLATILE will cause uefi_check_trust_mok_keys to return
false.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: removed mok_keyring_trust_setup function
---
 .../integrity/platform_certs/mok_keyring.c    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/integrity/platform_certs/mok_keyring.c b/security/integrity/platform_certs/mok_keyring.c
index b1ee45b77731..fe4f2d336260 100644
--- a/security/integrity/platform_certs/mok_keyring.c
+++ b/security/integrity/platform_certs/mok_keyring.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2021, Oracle and/or its affiliates.
  */
 
+#include <linux/efi.h>
 #include "../integrity.h"
 
 static __init int mok_keyring_init(void)
@@ -19,3 +20,29 @@ static __init int mok_keyring_init(void)
 	return 0;
 }
 device_initcall(mok_keyring_init);
+
+/*
+ * Try to load the MokListTrustedRT UEFI variable to see if we should trust
+ * the mok keys within the kernel. It is not an error if this variable
+ * does not exist.  If it does not exist, mok keys should not be trusted
+ * within the kernel.
+ */
+static __init bool uefi_check_trust_mok_keys(void)
+{
+	efi_status_t status;
+	unsigned int mtrust = 0;
+	unsigned long size = sizeof(mtrust);
+	efi_guid_t guid = EFI_SHIM_LOCK_GUID;
+	u32 attr;
+
+	status = efi.get_variable(L"MokListTrustedRT", &guid, &attr, &size, &mtrust);
+
+	/*
+	 * The EFI_VARIABLE_NON_VOLATILE check is to verify MokListTrustedRT
+	 * was set thru shim mirrioring and not by a user from the host os.
+	 * According to the UEFI spec, once EBS is performed, SetVariable()
+	 * will succeed only when both EFI_VARIABLE_RUNTIME_ACCESS &
+	 * EFI_VARIABLE_NON_VOLATILE are set.
+	 */
+	return (status == EFI_SUCCESS && (!(attr & EFI_VARIABLE_NON_VOLATILE)));
+}
-- 
2.18.4

