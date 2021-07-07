Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761303BE100
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 04:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGGCr6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 22:47:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60896 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230020AbhGGCrx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 22:47:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1672aFEK017231;
        Wed, 7 Jul 2021 02:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=RYNAzFQOovIxcpaw7/0caBRX98DslUctRyd2Ikn616k=;
 b=V8oTlJP6lmHZiQSGT1l3Ld4zRcE+7R2d1WdRLwreGiaflWqxJWM34sH3ByhwkjFNwuIm
 NUmRywFDZQDclKmwDeoGS2Ij3Wr/RwllFFyUE+7UiWdoblxnMkpOmJHPKoW3Tenbz76X
 Zr7IpdWM379Lx4llTbkP2M1bRaagjqJyJkcEr8Kr04PNX24WDFx1xSYdiec8qlcsap32
 Y2eXaA+F1m9qbAkxiYwj52OrvCfVp5Xje5JskQA8tZ4dfCP3SVvGm9IYKm2/0CKuPPOT
 u6QhjE0PqrFjxn/N1bvvF3dFy4lYrtGDxtsozrrWAbtPBXSgopezao8MaWz2g4GgPa5b Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39kq8ec4yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1672aUAJ070945;
        Wed, 7 Jul 2021 02:44:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
        by userp3020.oracle.com with ESMTP id 39k1nw7pvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 02:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0gzmR+sksUeQkawTvpekX7H5hXpfElYMhjBJ7r3l+57HwIGVDiyLLFqbYesbxRfWqnHpFQWtH7V4kWz81nZQlzql0Mvwwb/3rwHjRQayz9a6BbhGfWL1YLRcmZeS2diSMXxGoJoXXJWQApr+KkZEOp7bz9QVSafoNLFj6Qo+XLmmY8AhGTUFKX5L1y8PJ5Y/iiA+/OmREpqjAnaBY3+Pasu7TrMxwN+m2kSASJ/1iE3dCaIZjtAkn8LIjJW/Dk0AaJuE2EuWzld3MxZWNbrKGXeD0r2N6e501/VHmQ4D76o4b8mJx+Mgl1caL5MCr11Ev0Qi5QZ4GisuUE1/cFaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYNAzFQOovIxcpaw7/0caBRX98DslUctRyd2Ikn616k=;
 b=mQdrrTUB134QIOZtmxhe4EJ/WQk8PJjXD+oCluqERZb+LejO0wn526H9U/pg0JygW/P0kcLK81YM+j2o4Li6Mp2CDgd1h6FmPQIo4fx7aneeICOlOZI9gmivofnnbcxj/yL+mU9PBr66tJF4/RS7DdCpRJdfQjXn0w1OzgPUVBEIpgj+9PEOTVemnpczWsTscRkwczNC+6eO2aGJrh36xmHmYAREW3avz0q8tma2nxCEr7IyubGEi2vpADsOdpithMqerOJIc4B54P/mFxOcasSF+ISmtXXgPx7VEHhWA07oy4FeeAmZ9R8ulT6+CSEQr3U/1+/Il0zXSbv3DxEEDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYNAzFQOovIxcpaw7/0caBRX98DslUctRyd2Ikn616k=;
 b=B3bKAUkOoedReMGQ8Rlw7Zsy2k540Oz4PNB8Csh8nHVski6AqLocOWSHGa+1svAHifql/r+JMn3M0W/U6Xo1jJUDqT9hiurlthXMYcwwRC9hNPlTgJX2AxFpXTQCj2AqppIDsuTOHlaQC5YHOeWc7cwxaAq2/e40IIngGsDGpBk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.24; Wed, 7 Jul
 2021 02:44:30 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 02:44:30 +0000
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
Subject: [PATCH RFC 03/12] KEYS: CA link restriction
Date:   Tue,  6 Jul 2021 22:43:54 -0400
Message-Id: <20210707024403.1083977-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20210707024403.1083977-1-eric.snowberg@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::10) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.us.oracle.com (148.87.23.5) by SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 02:44:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddbe8614-7ee7-4e7e-7d0e-08d940f1250f
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB38634DC799A5462BF7089AF6871A9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cyk7ZOVQh2fnTcZYI0+iXW2M0kJZpGFLAHfDs3nt0BZfmjzZRmaPLd97edCM2X9GJBA/C9Ua7h/XPf54RYcagiua+zBCT76WwCtSNbVaSqvaedwuY/Je9/RH34U7O629W7EcT5TcPMtmZMlcv1ni6c8MHi/PKzScIQp6bDTrEeO6VKIgS1+jF/IRiDtv6rlaFmAc2USpEE/eP+5jaQ7TRZxLIESxT0+4k/ErlO3hs7679zCztiLDab5e9hlDPoqYzGC+Z6Q+rKKFYgmbynQU0t7aiqzcpjXha+XcW4QTdQM0zNCoH4jh9S79Zs9RfMLk3Hlxlvy2AQzcifzXYOz3pGAY0SL1DdJ32XJB8geeRZZKMcjKphf0KAePiI5UzhYZI9MJktLMfhgBTYZefcUscnOScDNRTvXRejtN0DMlDYvnbLZ4EOd/gU1e5eCTEqhHEgIX7GTIXHJ7khzPLj++I2Avm+nC+DhfHvn/i0I2ADvZk0/dlCbOnheO57qRhOj0yiqlqmIKfUDN+X3kaG4PnBlyTsnzyO+aGTtYmgGIuThrup9rmOqRjKBdmYCOHNwtwBDQS2qXv4VHwiBXFljKu61xsV6wz6o6oHwStpnefOtH7k9Muz9CL5b58gCIYAIkn1Bh9YX5m1N6gL9Z0dWotDE0q4cF66XquafhBNt/7MhXtpvUDLRUL1OcC388zi2+Zt+VEze6ZRoUYalIPqhHnlZzXvHOKkf67nEplS4Wu3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(346002)(396003)(376002)(921005)(107886003)(6486002)(45080400002)(7696005)(316002)(66946007)(1076003)(44832011)(86362001)(38350700002)(6666004)(36756003)(83380400001)(186003)(4326008)(956004)(26005)(7416002)(8676002)(52116002)(2906002)(38100700002)(2616005)(8936002)(66476007)(5660300002)(478600001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3rc61Hstpdozsp/DGXsxbFxEFI+hBSB+b9aqv3oxCFmdQ4kz1wj+yx8TbP1Y?=
 =?us-ascii?Q?0l/SzAK7ULtp0yvauAt9ilF0JqO+htxJQ1fvwJjsdsV2JcZD3zpdb2jkLdx9?=
 =?us-ascii?Q?j2PQbc3CGSqx50ITNVbb5X37eM/hxU4W1o1dd1WlIbnYJXlEMVpxrEkvChca?=
 =?us-ascii?Q?6V8FQmDdvmVUIpctswHA0RLmBNo5/n5tLssVmDS21Oq0wpyrcOkyVVWxyUNc?=
 =?us-ascii?Q?aHUowCnauaCGiuapEaFajze8iiWA3dr8qrVb5Pf0MZsIJAOZAmJiRWubHoXH?=
 =?us-ascii?Q?9tVy0cvELOS5NJBW6fUQQSiAotQeYkhy/4SyZ4/aIaaHcj4xwu2Mq2jJODsc?=
 =?us-ascii?Q?PI+5KenQ+Cm+93AB/ENjMz2/5KmXfi57GmM4PHP0HyaytraETCkPxQ1cXF5r?=
 =?us-ascii?Q?SswzAlyFURPlPX8lec6vYK+d8whDdgoF/AMw+PqEwsV9jR+Tow6aUUWKd9mi?=
 =?us-ascii?Q?M3fVY2n53JhABWW2nooR4wo3icdh59HJyVJ0B+MwK4+M9HaIaQ3Rfh5MuGIc?=
 =?us-ascii?Q?3obljZYv00TMTdoRborG8od8pms+I/I0D0b4QjcQsLWU3tGoobbikJHrvvC8?=
 =?us-ascii?Q?FuQGnzGKwyrUBuGPWU4BWNTHijrJyzVLSII8tsLBudgAtWKWTbWpQqtkFC6m?=
 =?us-ascii?Q?175d4RIlg/AHe6MHd2ONZpG9/A3MHGNYIsCHDwnhma/Qj8lZPmjpBBfhZLPV?=
 =?us-ascii?Q?kfWn1TCPLQYcmTn4fySx58Z0N0ShsNYNvFMWYrcG5RPeCUrw/nozuvJK8Sf1?=
 =?us-ascii?Q?uAFiMksUv55wo9JAg/v1Rwxv6/0n3gvHoOHFnTVcaJYto9fvXELb1j4VofN6?=
 =?us-ascii?Q?+6vHmcdR+n4mP5bq04fW4mZqQaoQhLCVv/6+MWHS6VkGM+Im5ZvsTmykHAMc?=
 =?us-ascii?Q?YDi+cwESCrHgYekFam7eVd8msP95675ivKToYO5ZlSVs4fzUO0O4GR21EBVh?=
 =?us-ascii?Q?MkhPJmuzVSilc9AhXqKiGZrHKYAjQ4oiXsQAKv7PVGMLFAFqKEKQtYm7R73Z?=
 =?us-ascii?Q?77rFseCbPIqHe2rij51gLIBCT0tXJicMhJeponJVXbXwtGDePihhEQ7djiwh?=
 =?us-ascii?Q?brD1N2uQxBWHm2fTfCf3yOF/m5xf9FPqT1Lbi0O3ZdmHjwVC6lMKYbB58E1G?=
 =?us-ascii?Q?4vkDCxXnhpuMsRbeNzuvwwmHLyvMfLcGEDV7JyRpIpSy5c+e9VuBuuVQOGB5?=
 =?us-ascii?Q?5pYcStjxtecDTzf6JgbjPUI5hJC/nuFsU6UTI5NlzsvKOWwktxzPl/n2aiCT?=
 =?us-ascii?Q?94TMIZL71tm8fL06/3Qd3Psl3DocnOCk2XJtZcPcLhTy3aNMydh9L9lORGbP?=
 =?us-ascii?Q?EOBoAun6UQ3b+EWq4/hJtWy3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddbe8614-7ee7-4e7e-7d0e-08d940f1250f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 02:44:30.4834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Bcq4RuzJCevXB2R82vBp76ciTcoP77vEtKhJkSZFRxv+ztiETeoHfaxref3KEcCmk7yhiHrfKJOtcL9O8xxUvQAGEhqiilRW38Lyq7pQVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070012
X-Proofpoint-GUID: n4gquWvlNTFZNQ9kvwQ2HTPWT7Lm1-d_
X-Proofpoint-ORIG-GUID: n4gquWvlNTFZNQ9kvwQ2HTPWT7Lm1-d_
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Restrict the addition of keys in a keyring based on the key to be
added being a CA (self-signed) or by being vouched for by a key in
either the built-in or the secondary trusted keyrings.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 certs/system_keyring.c            | 18 ++++++++++
 crypto/asymmetric_keys/restrict.c | 60 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       |  5 +++
 include/keys/system_keyring.h     | 14 ++++++++
 4 files changed, 97 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index f02bc5832684..b4c82276bba5 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -73,6 +73,24 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
+/**
+ * restrict_link_by_secondary_trusted_or_ca - Restrict keyring
+ *   addition by being a CA or vouched by the secondary keyrings.
+ *
+ *  Restrict the addition of keys in a keyring based on the key-to-be-added
+ *  being a CA (self signed) or by being vouched for by a key in either
+ *  the built-in or the secondary system keyrings.
+ */
+int restrict_link_by_secondary_trusted_or_ca(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	return restrict_link_by_ca(dest_keyring, type, payload,
+				   secondary_trusted_keys);
+}
+
 /**
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 84cefe3b3585..75e4379226e8 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,66 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of public keys
+ * based on it being a CA
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trusted: A key or ring of keys that can be used to vouch for the new cert.
+ *
+ * Check if the new certificate is a CA or if they key can be vouched for
+ * by keys already linked in the destination keyring or the trusted
+ * keyring.  If one of those is the signing key or it is self signed, then
+ * mark the new certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if we could not find
+ * a matching parent certificate in the trusted list.  -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate  but the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key_signature *sig;
+	const struct public_key *pkey;
+	struct key *key;
+	int ret;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
+
+	if (!sig->auth_ids[0] && !sig->auth_ids[1])
+		return -ENOKEY;
+
+	pkey = payload->data[asym_crypto];
+	if (!pkey)
+		return -ENOPKG;
+
+	ret = public_key_verify_signature(pkey, sig);
+	if (!ret)
+		return 0;
+
+	if (!trust_keyring)
+		return -ENOKEY;
+
+	key = find_asymmetric_key(trust_keyring,
+				  sig->auth_ids[0], sig->auth_ids[1],
+				  false);
+	if (IS_ERR(key))
+		return -ENOKEY;
+
+	ret = verify_signature(key, sig);
+	key_put(key);
+	return ret;
+}
+
 static bool match_either_id(const struct asymmetric_key_ids *pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 47accec68cb0..545af1ea57de 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -71,6 +71,11 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index f40837026d6d..43c76fba9481 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -34,10 +34,24 @@ extern int restrict_link_by_builtin_and_secondary_trusted(
 	const struct key_type *type,
 	const union key_payload *payload,
 	struct key *restriction_key);
+extern int restrict_link_by_secondary_trusted_or_ca(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key);
 extern __init int move_to_trusted_secondary_keyring(struct key *key,
 						    struct key *from_keyring);
 #else
 #define restrict_link_by_builtin_and_secondary_trusted restrict_link_by_builtin_trusted
+static inline int restrict_link_by_secondary_trusted_or_ca(
+	struct key *dest_keyring,
+	const struct key_type *type,
+	const union key_payload *payload,
+	struct key *restrict_key)
+{
+	return -ENOKEY;
+}
+
 static inline __init int move_to_trusted_secondary_keyring(struct key *key,
 							   struct key *from_keyring)
 {
-- 
2.18.4

