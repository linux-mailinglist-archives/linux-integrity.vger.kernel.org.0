Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AD03D6568
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbhGZQe6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 12:34:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241074AbhGZQd5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 12:33:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QHBeVC006257;
        Mon, 26 Jul 2021 17:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Rpguz7FJSExcSTBbcJvZ00lTubl9WGEkNdv5G6GIUnk=;
 b=lrcHFWoPyfwrmLeXToRzGozTl2lRJEzjJYyFZXSXtHYSNxQoNF0vJK57ld+BuSwLUsC4
 1QJ+qqsGvQcaeof38onK13nh40CS0BQ278owzq4HQuH3gcCpEquJNLE15XJ8Lt2PJ0Nf
 BiVejIvDbzqjGGQQzIIiB6+VrqGCmC8t2nvMFGyFcRtyZfdV4wBN/k8zY5fD7XKlZrzo
 iXeLn97M6XQ86Bos7n+/rnKxJq3tdi/kKA2WCtxHzGzgNcQfBYACv26c12axzDffbJyx
 f/oMYPfGMFdG7LivrqTltgLy0GQAhy7zE4EELq1gdCwwKUIHNCyoaOGDbU973rf+fGG0 qA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Rpguz7FJSExcSTBbcJvZ00lTubl9WGEkNdv5G6GIUnk=;
 b=gNn+aEov5h4E+gcOEj96bJ6A4TB6q6xNpHnyB/EWAAyC0nXdkMkbbETBm5QWSddKhfx8
 DfkQPP3fuZjhM3Sok/GAMj0Oh2c4sKuOQQooa+qXabYNPK3bB61w90vj0htWdcuekvxa
 A1a5aImZtydQwwNIkTltRNGBGtPYdrj8OS63uXZLCpwRks/1PV9fCBDJMLVdQrDPaARR
 r868tolmxSg5YTSpzwZUfwebvRWFrEv+5BICg56GI63lj9N4V1on32LS84PbuyatT88J
 1skq/4DOg0Zm9HAdfRVbANGeoG8fQNLfvyXmBa9BMISk37WIkjt6ZIJZSCOhOyK5Ji4j 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1vmc0u8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:14:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QHBcn5043683;
        Mon, 26 Jul 2021 17:13:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3a08wewwxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 17:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt1EPvUgPjTaUZxSXCFZLg711O94zR0/qAHDkHqcwwdBlwF4Shjyx77Zf0wSjUHgpT/iT2F+Uzq9Tgbu3chKEtWfn2M1NGfGDUoVCgOoQvEVwhggeFV2w4WkiL3xbY19tXLtCDIqkjO7gm821oiFDyFrL0DpxdPSedFeKy24BWV/REs0jD65xrIy50zFfzGkYtOaLPkT7MrY4ccyM6NbRIJpQW6yeTjGld7jjpfnIpMMhWu4adOOD4e2UtU4YMjMqC+XBM6TItX1SL06fFPi6//D711PTOkQsYCvoDBfEjx7hFInT3/CtA0ADSvOun7ai4viqI46RqHrbJAxNgsGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpguz7FJSExcSTBbcJvZ00lTubl9WGEkNdv5G6GIUnk=;
 b=DPOPNyDDI6I3uc9BJ+KBbO+lVQPJYefORbohsy2cfm2uAmyyZpVl/vWrs8Cw2N5hGzVMtd+EaltIwmfeU4LUAwBhEpQ2cVfw8TrD3c2mVWz6yJdt8Y7LMDXplP0df4x/5s7rvU0mVaPzg10nM+MOgsj0LkWmkD813+ZGRv3/AA5TcPr0SyqC4BXnojqPAKW0KzKA3rajylQowElCt2omxSEu3hiYui9eGuaPkFlafBbX818E7VRJME/Bh5P7gH/a+dRiDmR15GR70Wn/SPpKsp/m+wDsul2t7HuvpxcUxy0UOvLcth5X592TB0RBFtk89+IlFXzg7jBiuVsk/MPQ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpguz7FJSExcSTBbcJvZ00lTubl9WGEkNdv5G6GIUnk=;
 b=EybOo/WjTpupPk9VKxyWs9pi5ogokdl8eLYpqtWFKtjSzadllCqCtYeJcUXTMvHap1KddFZnl9UHU+GWny8FbpB2ekN1QSr7g5/0uyRfx9DPxhyFFukkRkmCfYthbNX2vDxa3HoBa7zpDNLSHMiAWr275qjPmQl0Mc/Zb0K5ZtA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 17:13:56 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::1d17:4a7d:92cc:8fc3%6]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 17:13:56 +0000
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
Subject: [PATCH RFC v2 08/12] integrity: Suppress error message for keys added to the mok keyring
Date:   Mon, 26 Jul 2021 13:13:15 -0400
Message-Id: <20210726171319.3133879-9-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210726171319.3133879-1-eric.snowberg@oracle.com>
References: <20210726171319.3133879-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17)
 To CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.11) by SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 17:13:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cbc9c7-4c22-4efe-5ad6-08d95058c051
X-MS-TrafficTypeDiagnostic: CH0PR10MB5019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5019C30864BB8F4444C33F2D87E89@CH0PR10MB5019.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDws8pKbUgCbjl9ALAkM9osOEJOBWyt+45aTbpMkw49kWwdHWvFNBoE2g3Ae2U8Oft8uTg0S6IpbWWXaRR55ff8oEh0qWOwu5UA0q5bnckJjlT62QwMRAX2Z07T4NSvYJh21bgMKlr1PdiejHuGmKoz+hvqsY6A51jp3jKQSBvdcjbz6gkxTPJPu0PPBEJ6z27RoluEcDbfxCyuDMMgUWSL0c5ld4BiKALhkYm8K6cjWYS8+e98S00HSOMQLbBkrXy/OkWjmLB1B6cVYQZ9NkgP52H17ODudPt2d2NxBe50drkTspfyWvkEgEunuQVU/6Vc5SZ/Q9vAy+m2i9A2UZxK/QweayLSGPS9kvQxrSel24XZhVMbj+bsSUruqIOLNfaPhzCKTCRkI/l275YMYNrJoN3DnxUgGBKds1mZGtpItX8gHzc8Rc8svrLWELhdpqFfWOcAtuUJJzEFQYPSmWLcMHPUHc1LPGiHxcqniyQQPHqtMCX1PjP+JvkzzY/sGvmmap/PSXnJ6l65yP4Jsrc5QHZSAS4Rz/liwjKI1XmTAhEBDI01r3PlbqEgxWleFxTse/dnSCrbb7rIBsSn9YAcNtKBFicVS+kkq5MIi6Ng/3B2QPwwNMOFUltcpA8x9MVm9KzpXDV/9PxUrZkr3fhAGAeAB4WygMJqD2S0iwc91tednGc19cjxb3sVG+pPYVyLkkUiwEi6MT8/ykHTFtqL8nfgoEkVogJQVxK6eWc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(66946007)(508600001)(8676002)(186003)(2906002)(15650500001)(4744005)(1076003)(4326008)(7416002)(316002)(956004)(5660300002)(2616005)(8936002)(107886003)(66476007)(6486002)(66556008)(83380400001)(38100700002)(6666004)(86362001)(921005)(7696005)(44832011)(38350700002)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2zCNqCcw8/cDJJfsm2zi8WvR9nu5F6vFECVkoSJZDBrsLJgUHYVW0VM6XDXg?=
 =?us-ascii?Q?1Vcb8ubBKYUWc5l+WO3GTMqN/z0JawfTbkFwEA+kgQhs69xoy7NtR4bq97P1?=
 =?us-ascii?Q?QHgVWsnnwacldMQk2+SqqnhXxo6CaocWYMS4zXvwVEBEVlUSIDhQHLsMphbl?=
 =?us-ascii?Q?nE57A9n0dh6dULD/35n2uQF/RS3oiEHRWynFt/Zd+fIvuS2G/ld+GSj+sBNr?=
 =?us-ascii?Q?o5aMU3U/AlfmvhK013XZO8Hujs00IQAufQ8i6zQLWgnWR/3HukEY6CiI9OKX?=
 =?us-ascii?Q?VHdOoSuBU79YzQjhcooMfap4kDGuInUkhiBe9dbj8PS4oaOz6T5eFePcWWXX?=
 =?us-ascii?Q?xrWHC4Ja8AFhgfQAqcB7NQ9/565iSY/rXhAFpTjkVDEvk+mPK+ca8+b7JBTf?=
 =?us-ascii?Q?Wu59V+mrPW10wV7mwcO44b6mHHhsMao5+C/KXQV/e3ivF3MluLEL+kkJhw0p?=
 =?us-ascii?Q?beHSB6nijtmZeQ/GSPWV/ftnjf4CJCUaA89GOF8BC4ydldASmZoTpPzc8Vg3?=
 =?us-ascii?Q?WPDTEMZrDoq94z8D0KyaPUqENFtH1GmNPnOCeXCfV4ytliKbWDQhL3As2+Pn?=
 =?us-ascii?Q?UgLNMQjMWceeyPYkI75WT2Z0XXvlncNQS/nNF2VBe+e6U5HSne3nWV8FmrtD?=
 =?us-ascii?Q?gZshG/ZlL0wIDIDQSxQy6BYgJT0EtkOsf/Y8iuMn3YoMQLUjfnIVo3jNZmKp?=
 =?us-ascii?Q?vdvcVesI5z1nR/tDViVInTXeCVybeg3mrh+4QD/5EQRqj/+Hh/7yQMfRaNjh?=
 =?us-ascii?Q?2vM9+jbRtKQjCWdMWzr5ELNDCEXQM4au8UC0u3GogcUtF2w8q5A8R+bBB3wh?=
 =?us-ascii?Q?L0CM8ng/zQnam1wBXuRJizHuilMhjA8w/8svR7PyT7jGyHC9wrnjGC+3lWnM?=
 =?us-ascii?Q?dxuAF+sndujY+MGtUWGareIO4Tf3BQ2fFHSKquIhTDHPbGpDnZoL1/8QYrmG?=
 =?us-ascii?Q?UeDDGRUYv4dbdHtpHMbOm+y8t2S2iS62FsF+i5l+KX3Ef6RBv/L/RzLutWdq?=
 =?us-ascii?Q?kCM18+MFnR8kdDh/pgV+S9vUVCpXf4q4cuTsrY6f5cmBgb7IkTv81ZCzREio?=
 =?us-ascii?Q?CFod95ZptEqddNWbO0s41t5oGAm8wxrYGQnmG6O8g3f8EDj6QIW0tUUw4Ril?=
 =?us-ascii?Q?W5ZK+pbO2nN0QX2250loYmsjrC/3nOmSAnp+ES8EF4F4fHFRfMgibRs1gtKX?=
 =?us-ascii?Q?X/w4yGZOiT215W8fclmBlWmK9CrMLxBDfdOGsW6az/6PWsDPozCoO5o2B0yC?=
 =?us-ascii?Q?R3yD6i1L4WLsmzrU6Wp+5VnXaiJE1jFRgBR8q+0wdoM7siLKh5pw1dcDo5lb?=
 =?us-ascii?Q?iKPu0tzIZ7VV3TfU3laHF4X4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cbc9c7-4c22-4efe-5ad6-08d95058c051
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 17:13:56.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvI6lrAjKLfp+I0B4lz1dAvqPAUUrQRp3zoK9UkpIPDALqlL73tLCFbylmzew1KN58ueyaaKUdqrGnVlOlIM4NuLBz0hXf8aLni9jvaZErw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10057 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260100
X-Proofpoint-GUID: _86nVqApMhjYG2Jv8hBD77lvvXpFfRf7
X-Proofpoint-ORIG-GUID: _86nVqApMhjYG2Jv8hBD77lvvXpFfRf7
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Suppress the error message for keys added to the mok keyring. If an
error occurs, the key will be added to the platform keyring instead.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
v1: Initial version
v2: Unmodified from v1
---
 security/integrity/digsig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 2f6898c89f60..be4860c596b9 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -165,7 +165,8 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 				   KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
-		pr_err("Problem loading X.509 certificate %d\n", rc);
+		if (id != INTEGRITY_KEYRING_MOK)
+			pr_err("Problem loading X.509 certificate %d\n", rc);
 	} else {
 		pr_notice("Loaded X.509 cert '%s'\n",
 			  key_ref_to_ptr(key)->description);
-- 
2.18.4

