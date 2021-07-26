Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA823D6557
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241652AbhGZQen (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41292 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241117AbhGZQeD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:34:03 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHAZ13029680;
        Mon, 26 Jul 2021 17:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=eEzX9cbiU+OfXErfg1UBDrRm/ODY8qsUIUpjmrXFtIk=;
 b=kvwowQ748TLEKIkTIQ3kS2gqu0wDn4nyC157EYsiW0dKs+IoP3l0Ur2ibguXcIIfanG+
 uappko8nWKyYsiWC8kqh7Nsc/pIwGlnWcu8ECArDM8/Drrcge/oorBzY5zQpAvb1aI9a
 P56bNhgqY/ngc8pvNnlpVQj/qlXbbqf3ZZ36gUhXokONTI1yxatfwcx0XX4DAB6NDm/O
 CR/S5I5VZwvQzFu0+XUh4ftQ3FLCnx6RvOhUW2ZJNjbiP0S3qVoWkCf3Pb0CXfLC+nNL
 pyHlHwJPhj569tef6Z7n53UPGBny1iuLeYliDBcfTxtA1I0AVUl/zlwp4JI6ww9c+y4L mA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=eEzX9cbiU+OfXErfg1UBDrRm/ODY8qsUIUpjmrXFtIk=;
 b=EbO2I2cdFwqniXe96BKF+QUs/HWPSqZCCDg4VN0qPLcixlnGT08ay1T+8UBOMKe2wQbm
 efGssEBy+FV+D1bSDykR94gvesAN76yLLV9+HioCHncRQOKJkL/bJbg6nwQ7B7nLne1O
 I48+FEd5rzvlkHOjSMFlBy+wge4XwHteY1xHFdMDLdN3vlXY8kHQXjjgjQBmPiJki87F
 sY/TX+ihTGY2/RSzKaVLWkvGhfpu8/pPXJghtZ6KDzR4ZBx8P6zqj+hUEcCW8szGZXmE
 laMbZ8CRp5ne7pptLx1VSnFsmgiNO8nyUfcGLwu6LWZf7E9z7sfCFuEMDOfhDso4w0us dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1cmb22n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBQ9t160200;
        Mon, 26 Jul 2021 17:14:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3a0n2gcpjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMp6GM+4LxWRYAjYVbHwFJXDcnmv3DP0KJP2Id8eP3W/b1rbHokiKr3zBUmKvusELOcxxKpiVYh6xSqj7gi+9m8I2A6prw6gaGrpuVDEEmr6y6kVCVzzFqtMkxrcDjnAwX5d6QoNjaAiRly6j4RRkAyOenNTjQLXLAhRzK+np6YH43gUGHs5hZH02TYvQvoygkkk2OWUO4n1XERxjlmruHIm1DuegNYtMoiDMoubiADkG6eP17FmVuCAlE4zLbtKCIS9Z8V4Q5C0JPysE8KA0MKuB2PqpciCQtUsx+ZRwpsQgUg+X/VY4ejKHARFvWL+2FIZRVqFkQiijASLiwdRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEzX9cbiU+OfXErfg1UBDrRm/ODY8qsUIUpjmrXFtIk=;
 b=fbw65L0c3e5JENNvPu61O5zlBe83edutdBPbkq/+muWFUY00Imd045xvZY+UjqBNeJV++AmIWrjMo2wF2EevTbKIMz0PBka7kGuLXIjnfslPLi/o5gMc9COzXoCSM4LQl20WC4uHcnMUojqZZMocoaA+T0akaxkWaDS34fGwKvbLJdqMFGYa7Kxb81mIjV8+ocfOkBa1kRA0oIIrsc6QpseSRtwuwZGpVmlyk+BjE4lkzI+iuLlr8wZCXh0axSA4MwHNjo6YcaOo8RMANyvRL10PiG7ZEDNzFY53htMpQ9Y1bHI8c1F7hOog6iih3rf+ZCEOW4X+WFrJb1a+wa4psg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eEzX9cbiU+OfXErfg1UBDrRm/ODY8qsUIUpjmrXFtIk=;
 b=iFxVlLsYnmi/ZXbDC2NGxWoI3xMqHW4m0h6OA2oUHt9pytw3KSZXV+p+pI9h7NNhPEoNURmVO1u+s/4zqOT6hejLz4gS1tPaNfTqxtkGluSSnHjmc5zSzDm6FqtvC+Bnbg1/6oQUy9iOhrntQsmmISaQ+vIz/sRtDPulmTHc2eI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:14:02 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:14:02 +0000
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
Subject: [PATCH RFC v2 10/12] KEYS: link system_trusted_keys to mok_trusted_keys
Date:   Mon, 26 Jul 2021 13:13:17 -0400
Message-Id: <20210726171319.3133879-11-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c3f04f4-893e-40a5-657a-08d95058c3b2
X-MS-TrafficTypeDiagnostic: CH0PR10MB5019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5019745E52FFF76BBA87DF1487E89@CH0PR10MB5019.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: moCzLGclBh4lZtuD8kc8oKtpAGKL3XTdJ4aWoiE51uhksRgZr06USgiEXKX7o1+YatD79gfAf7JyLZsifyjJGG6P/eL6ZB+vyJKc4BskSjcASWSFe0+ApUajrTd1eWoeLLuxK+RAFPedT4I/0wLQOc0/Lb7kec4K9DSnKgO+kNxnwTW6bTLA2VmXblYzoFsTCC6pTc1pCj7ny5Kmyjl1QXpISWYb2fx7/2uxk9iI7N3bpCsLpBU7QKNukDOH/nNsGU9S94GZX3E9BEXKPJ0/z1bMYWQDqp3jr1WsWqcwjBcaznzAG1v5HiasbZ/9dHHO9jN6MPWzXFZz1UArgFSOIf6MZQcVtrfnjOk24afnNqGO/Gvv039RlhQcuPWtmvWq0bBLMS2lfJyFw5AKCcx88MvgANtt9IZnUDxwM7zLrjj17gIdOcRfM5inGIeKRslI8JbrQ3+U1joKRKCWWGT+3Qaqx+NxW6s0wiuebi/UO4uEDWSBJQR8YqoVuHMhc0pIwITfvnIKLy7k+EjA/2WG8IMrwqMT+Rgdd4Rtur+afY7Qkpmn5qVE8U80vsW3qS+b1O6eyFKgujanKhZaGsUES96d295hHaAF2dG1Dq5GE7l07HWGhQFanHj3OCQsZOkeTwN31MkSCEKsKl3DFZ+gtOij6nj/PHEYEvLT4tEDKXTMFlyf8GXyIu/JhwSDv/U/cOLNs8cgOhdli7U7+No6fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(508600001)(8676002)(186003)(2906002)(1076003)(4326008)(7416002)(316002)(956004)(5660300002)(2616005)(8936002)(107886003)(66476007)(6486002)(66556008)(38100700002)(6666004)(86362001)(921005)(7696005)(44832011)(38350700002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?12K5s/JY9AMOxhz+4QzKvP9soP49iR37LABn6GB5PVye9XlptALNBmZqpswE?=
 =?us-ascii?Q?cr6RFgkFby4rUN/enUw62XW/fuSkrYFrh238Pl7jqUVC3Ldy+d/23S763s34?=
 =?us-ascii?Q?cnA8AGq8cl0a+2URHdhJ00v5qRmQ1UaHHZREQvqPqPUccYKWV1tl27fYczgz?=
 =?us-ascii?Q?R4ZqI7F1MX9edobhh8qIDBCmjDXq8GiQ+ADM6Vs2KlK3WttGgXDnmFLl/8XI?=
 =?us-ascii?Q?7haeSNV0NBrXYp39NxrM/qd66mM3jJ0mRWCFWKaWBriL1pqluheNsDYN4bMH?=
 =?us-ascii?Q?pB3KGm7uqRF1fpRmlRw+W3fDLHgclcPBabTcSDIRXKKviw+Ax2szAOMJtz2I?=
 =?us-ascii?Q?Zgfv9+LtV2IuzHr0enkGxJOkznDw5IbkjB075afm/S++l0OTdsQbEQQhJFE5?=
 =?us-ascii?Q?67B/LbUMP+0Sh6ZVjwo3sYn98FJ7IxQoUmntHHPYOTu32Y4DIltxAJ64mnVZ?=
 =?us-ascii?Q?VJpmXdY++Xcp82veWdfooNYrHp28oSoW4K48ps8P0oP1YN7ezeokOGfKav7d?=
 =?us-ascii?Q?fzgSVnpbwu9uPozxR6LHNiUUSW/ZeInNx8lnsH21kP2fGC56xbWdfAiGDGa6?=
 =?us-ascii?Q?TgqFeHXBk/0F9tfIRcJ/8PRBO1O45iSwrw40PTdXgg8rACsZnOVRrGlY16Du?=
 =?us-ascii?Q?pBGxdakT8aaRdiOEXB/etLE6WXW12AaTcVXAPA3Zuo6pMJinfv/wWGje2GKw?=
 =?us-ascii?Q?7OI5tGhKvH4xSfUHasGFn7XZrklLgBBE2mg8zbIuVeYA00y7Q7qjjyUAek07?=
 =?us-ascii?Q?rBFkRMnEA5qkLh5rYyS5rcqV5W11pBXZEtT3C1IXKwgz8NEgBIqck70+uCke?=
 =?us-ascii?Q?XWYs2LgKppS0HPowJx3OVvfQacqGzQewyYYofJsgxh1QcBZD5HuvxLp2ebTy?=
 =?us-ascii?Q?gpQTSowsZSlcQzW+RE9qL/MkTIvjXloaKZLWqzsj7qlkGPUSr2CibNAx/atG?=
 =?us-ascii?Q?B0/JT1W+0XSyw9GdiWps082E10zIXEo7Y+/f9MokWsTBK8dpyF3QErc90J2D?=
 =?us-ascii?Q?+fTyqp7itQ9zJRovYb1gdQt84gkHrjxDJCz5q/Q9BSeTpRjnMJ6XPGWPGhxN?=
 =?us-ascii?Q?+VYXbZqF8XlL34K0bgMagxZQydlOC85KFtlqy7nrrdr1ypiyF2biB93LG8lD?=
 =?us-ascii?Q?SRKnCI6VTX2rZw1Wl088DdpRc6qzh2uKbytfPqENC39ezOsFxVgr4B1IpJab?=
 =?us-ascii?Q?9Qk4R62D7GmjUs5iVrNCIxh1QSICuldr4UD3j9Iurql6X4TwP64G6oY6N4sD?=
 =?us-ascii?Q?jF3p8pBseO/pVMK5IbFiiSuP8ObFFjw5h5pIgnH6YaKaRO0ay7S0yTy4q7eJ?=
 =?us-ascii?Q?ScyCy1lGl+IFjCOtqXJzo2W9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3f04f4-893e-40a5-657a-08d95058c3b2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:14:02.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFDexkohmRgE9nNUBMqy5W1awoeY1XbH2O1MG52+HlyLPQ7MelvaXZJs9kv+XC4Ubir5u0uAeIk77TNbSjZT4DqyuUnhyOo6Y29w8hL24zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: dyXPs4imPBkrC_xrWGDyhYBw5OdqNJBR
X-Proofpoint-ORIG-GUID: dyXPs4imPBkrC_xrWGDyhYBw5OdqNJBR
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allow the .mok keyring to be linked to either the builtin_trusted_keys
or the secondary_trusted_keys. If CONFIG_SECONDARY_TRUSTED_KEYRING is
enabled, mok keys are linked to the secondary_trusted_keys.  Otherwise
they are linked to the builtin_trusted_keys.  After the link is created,
keys contained in the .mok keyring will automatically be searched when
searching either builtin_trusted_keys or secondary_trusted_keys.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v2: Initial version
---
 certs/system_keyring.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index dcaf74102ab2..b27ae30eaadc 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -45,6 +45,15 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 				     const union key_payload *payload,
 				     struct key *restriction_key)
 {
+	/* If the secondary trusted keyring is not enabled, we may link
+	 * through to the mok keyring and the search may follow that link.
+	 */
+	if (mok_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == builtin_trusted_keys &&
+	    payload == &mok_trusted_keys->payload)
+		/* Allow the mok keyring to be added to the builtin */
+		return 0;
+
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  builtin_trusted_keys);
 }
@@ -91,6 +100,15 @@ int restrict_link_by_builtin_and_secondary_trusted(
 		/* Allow the builtin keyring to be added to the secondary */
 		return 0;
 
+	/* If we have a secondary trusted keyring, it may contain a link
+	 * through to the mok keyring and the search may follow that link.
+	 */
+	if (mok_trusted_keys && type == &key_type_keyring &&
+	    dest_keyring == secondary_trusted_keys &&
+	    payload == &mok_trusted_keys->payload)
+		/* Allow the mok keyring to be added to the secondary */
+		return 0;
+
 	return restrict_link_by_signature(dest_keyring, type, payload,
 					  secondary_trusted_keys);
 }
@@ -321,5 +339,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 void __init set_mok_trusted_keys(struct key *keyring)
 {
 	mok_trusted_keys = keyring;
+
+	if (key_link(system_trusted_keys, mok_trusted_keys) < 0)
+		panic("Can't link (mok) trusted keyrings\n");
 }
 #endif
-- 
2.18.4

