Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456833257CD
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Feb 2021 21:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhBYUgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Feb 2021 15:36:02 -0500
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:14296
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234048AbhBYUd6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Feb 2021 15:33:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEAlozTRf2Xv6T9x4CkVC5ZRDgr6q9yPbwkpf2p/hh9ErZMie+VBdmFIWraXVwd3zxsb8/EZC7uSNX033ihmMuPlfStNKMbcK4heJD/jBhYe3WhzyNbfwRZ4jgI6OCnz5KGc3HfE0MkvNdwkGOrZ6yTpcuUI2vFzEXfJkKMUWDtEbhwaogD1JILSeXAu8dkmSDrBhykydf1hUz37NaP+J4trfTi7GMhkRzEZQV64qD95I0OFcM9DDv5lFyvX06o1jmzb0fAJutAGfl2ir+VZu3xnGeGRCsMFOJOveYNpbIee7E9J8b4VnulyIUPnmFD/dLvfDjZPxDWb3YpDLgxiYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBR19EqEI9KksQW2OroZKYQJM8szH3P30eZIxLDEG7s=;
 b=oAhY3SjrOptoJFAC4/YBKauJDWWyNBLDVMfEJrWTZyxf6yi7+jtXv+QxkBl3rgOr3m2lWHk6C/PKCpaW8jg/qOb/O/s3qx04fvauqTD5t6m6Mieo/9yeRYbXj7u6OjmFLgQHmtI5LQ79ky8eifGtq8MBGwmpdPM16ScWtcXmOedBeW4kjawJQCjjDf06In9Hu69mHHENp9GQjqxC6ItEKCYXFaLfVoOYU4hfrYcpIHWPehq8Mntlyv38n8T3o/NsLxbRYOjOvxlfOr9XfjxfmTvRHf7ElGFOt+2Kk7V/4Gbs/+pwi/plGnqDcISkBUeIKUOpe3svcRKrSFR1GLlYHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=puiterwijk.org; dmarc=pass action=none
 header.from=puiterwijk.org; dkim=pass header.d=puiterwijk.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=puiterwijk.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBR19EqEI9KksQW2OroZKYQJM8szH3P30eZIxLDEG7s=;
 b=rzyrF1sB3ORqngyJQU6NsXsavJSKzCbNt7Kd3O00BUDbJoAcdcxkQCO3pJK0O/tLA4cMI7GcKY/0/94f66Z0FYcgctPbVTiNjY5buqnOCY0BgUZwcPMK3V81QLJ9Gl9Lu2CYlz7iI805cM4AsQApaFFAObRwbihFSXaE+/3P1oeDXNn7e+k8Svp+SqCgoTtCxGrF6piOy5ygesJ1zDaGqhlOv2uiwOzHXZ/rs8Q7ak0S9Dwqg2oiL9OiEby0nZE1GFVffU5QHpXsrxSF8AWAx/BbdbTbklxDbIV50RHqgovz0oJKn8n1NqdOLw9ASLWbxWc1G7d8ZB/KNJcalcElfg==
Authentication-Results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=puiterwijk.org;
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:15f::13)
 by AM4P191MB0083.EURP191.PROD.OUTLOOK.COM (2603:10a6:200:65::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Thu, 25 Feb
 2021 20:32:47 +0000
Received: from AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b]) by AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 ([fe80::b002:8668:5cfa:a46b%8]) with mapi id 15.20.3890.019; Thu, 25 Feb 2021
 20:32:47 +0000
From:   Patrick Uiterwijk <patrick@puiterwijk.org>
To:     peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        linux-integrity@vger.kernel.org
Cc:     pbrobinson@gmail.com, stefanb@linux.ibm.com, kgold@linux.ibm.com,
        Patrick Uiterwijk <patrick@puiterwijk.org>
Subject: [PATCH 2/3] integrity: Allow specifying flags in integrity_load_cert
Date:   Thu, 25 Feb 2021 21:32:28 +0100
Message-Id: <20210225203229.363302-3-patrick@puiterwijk.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210225203229.363302-1-patrick@puiterwijk.org>
References: <20210225203229.363302-1-patrick@puiterwijk.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2a10:3781:662:0:ec87:3741:6e9a:b11e]
X-ClientProxiedBy: AM0PR03CA0018.eurprd03.prod.outlook.com
 (2603:10a6:208:14::31) To AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:15f::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rowhammer.mgmt.home.puiterwijk.org (2a10:3781:662:0:ec87:3741:6e9a:b11e) by AM0PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:208:14::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Thu, 25 Feb 2021 20:32:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86184aed-e2af-4e97-9700-08d8d9cc8366
X-MS-TrafficTypeDiagnostic: AM4P191MB0083:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4P191MB0083E08FE6FFC3091608BE87C89E9@AM4P191MB0083.EURP191.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:171;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mH2DGZxRya3nRjW2nKS6y5d8J+DL8wI+8ALLhxx34QWSynKfJsY3a7x7tM1yqpZF42XS8F8O+DA1NLmRBSacvClcaWjQeCtxZhNPzj2dbwFRWIBIBsT1VZpGBrp4W62vI469PrOq9vYxMoL8WFnJ9Q1NbI1m+81jTNCBrO3I2jXEQ9zzUfUd0x4n0E4fYK50cKasSuY6Vt9OAdP1mEsujs4EFCGTJU9lC6L/K5EDQfXRJKw6ghQFqHu8FxsgaDAAg9PuGnpszcAdzjBgso91sFwDrM+QHlxPRzn5FlwJ5Tldw3junXkB7I/UIFmtl+G3cJPm2djzNZVc+Va3pLHqWlOc855fSnVKe4257wfm02TCX5XoZ2pmarsYa91ptI9nS+caeR+XGjd2aK1itVSOAIpWjKbmTM5Wpf9P6NWUULrEgs2QE+SQoDHJ2YrWeU0eaaqDFtNTND0jOY5ijsJio/gtxkYAR9Cz9C1XxI9Jyycdo9eur/jVqapud2UXJSCBLlz8V29KARQQHOXODyvsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P191MB0721.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(39830400003)(136003)(346002)(366004)(396003)(2616005)(316002)(186003)(107886003)(6486002)(5660300002)(4326008)(66476007)(1076003)(478600001)(66946007)(6666004)(2906002)(36756003)(7696005)(52116002)(66556008)(83380400001)(8676002)(8936002)(16526019)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AImM8BEf9QqJpdsnL8yvIJezUYFpbTjXkhWvdq1loqRBSJnonB59sRfoOJbH?=
 =?us-ascii?Q?wrD9HvT0GI4cjKMAhMSeE3rEZwgA9LuEdQ05czDMf18KFWpXAWVRFw8qdT0e?=
 =?us-ascii?Q?Izr364CcR9DvCx+6ywDsH647Nomz4dIuoSO7OWxVUqRHPo1dffbeWUTd3Ecm?=
 =?us-ascii?Q?bxdvrniOE5bc/rYa4lsup6agzukvSR5+cMnZh+rwhnE0FKGFHBv02OMDfA9C?=
 =?us-ascii?Q?Ynt72kmUJrZ9B0jgukj/jLl/KMt2Un8riQ6ctcND0aKkLfYuW+KNEOV5hoMY?=
 =?us-ascii?Q?mefTMQKkP9G0o9qodzDYNWPfTs2k+s1shii3EFGF2bkAfqhP2CzZWp19j6c5?=
 =?us-ascii?Q?T7EsI+Rfj3InUS7daLMmkOdFHL57mJ14+Uf2rvNED8c4KD35g619OKcLiLvC?=
 =?us-ascii?Q?cXL7rm9fpwKa2CKDsIaAn92DIktuvb8YrHR6Yoxn/QooCnDXOtjllsOjVn0b?=
 =?us-ascii?Q?0LPY/EMMc2KqwaZmPZAy2sWn2FqHO42RbO583A91xF/IPWPo5wLUJkIU5oYZ?=
 =?us-ascii?Q?pmwpByYfJu57xAh8PTxR7l+leotysllNo4RhwJjbRwIwSXctre0deszPYwj0?=
 =?us-ascii?Q?ET6RKm7/amH6syG6J1fAXxNZIH7Xs/7xsjfoWLg4GYZr/8hYn9/Yst7U6UM3?=
 =?us-ascii?Q?DJs8jFJ2XNRNjfwyaXIqbG7x/0Lu48UMVEuYxD5X6yCKwy+1B3GqddWZ0IpF?=
 =?us-ascii?Q?xYCYHTGqA60z3wTYbYR45wjZTmC6ck8t+y5mQTC8VvlT8t6c6fDfFE0P4rjW?=
 =?us-ascii?Q?bi/lxSiNGMkwotuHPp3SFPItYxezCxsoHKwiHVRVFXNw1vuWBBQgVgUhvXg6?=
 =?us-ascii?Q?YUqmBdA0aD0yzzxTtcUjPgHkxcxnC5k7x18yfAPb4N0fXNaO4qYEyolKC5HD?=
 =?us-ascii?Q?TIU6n96AZux8So4coBTUNaKFjuwxzDpYwnR4hR735WzTgc1zDfYkpDmVKFTu?=
 =?us-ascii?Q?TgwnpeZXhAbfNSyyc2SKKuNobablMAR/bLyUM7eQMqJMa/NPqUzq1CaD8lw9?=
 =?us-ascii?Q?lqqUTvW0QcZTBp2ITd60MKECoN99aDupcpWZtCMvRuguGL2BdDAMG4RV+2qD?=
 =?us-ascii?Q?EgJ5RC4gX+I7IrkvmGxfwhmsyvN+zhHu+Wvo9EDUHkSUKA1Iz0iGuDHFHhKI?=
 =?us-ascii?Q?AKCbz0E3+DILYCW5jBKhpsp/4rzaID2b8YECP0fiQ976j5XfVrxRcv9dIjwU?=
 =?us-ascii?Q?3QGxD9qDrvxU4u5ZMiPo7jwlsUccAvVtfQriQQA33RVVfhIwJ5QTfd0lSUzR?=
 =?us-ascii?Q?dmbM/Sy8RAm/EhhdrVp1B4CiLjeaD/j9mLBrBdJpKENWuapjREYfqzlsjq6k?=
 =?us-ascii?Q?6V5tnBzCv/Krm8mVeCup38V2Uay+GyrC3+uinoyg+CBY0g2W2sH0/P/QS0NA?=
 =?us-ascii?Q?+OzT3Eh1aRK9R/+rw42UKs+i77mf?=
X-OriginatorOrg: puiterwijk.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 86184aed-e2af-4e97-9700-08d8d9cc8366
X-MS-Exchange-CrossTenant-AuthSource: AM0P191MB0721.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 20:32:47.5234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 963619a5-d7a7-4543-a254-29462dc51fb3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtEIAyOKjXnhJl8fIt1r95Eg8hFvUVNstNB5KWEwyb1MlNyI8RxvT2dBx04UHC5THb6iwthNpyCVZpOboGZgbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4P191MB0083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Allows passing flags for key_create_or_update via
integrity_load_cert.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 security/integrity/digsig.c                          | 11 ++++++-----
 security/integrity/integrity.h                       |  6 ++++--
 security/integrity/platform_certs/platform_keyring.c |  2 +-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 250fb0836156..93203c767b57 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -144,7 +144,7 @@ int __init integrity_init_keyring(const unsigned int id)
 }
 
 static int __init integrity_add_key(const unsigned int id, const void *data,
-				    off_t size, key_perm_t perm)
+				    off_t size, key_perm_t perm, unsigned long flags)
 {
 	key_ref_t key;
 	int rc = 0;
@@ -154,7 +154,7 @@ static int __init integrity_add_key(const unsigned int id, const void *data,
 
 	key = key_create_or_update(make_key_ref(keyring[id], 1), "asymmetric",
 				   NULL, data, size, perm,
-				   KEY_ALLOC_NOT_IN_QUOTA);
+				   flags | KEY_ALLOC_NOT_IN_QUOTA);
 	if (IS_ERR(key)) {
 		rc = PTR_ERR(key);
 		pr_err("Problem loading X.509 certificate %d\n", rc);
@@ -186,18 +186,19 @@ int __init integrity_load_x509(const unsigned int id, const char *path)
 	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW | KEY_USR_READ;
 
 	pr_info("Loading X.509 certificate: %s\n", path);
-	rc = integrity_add_key(id, (const void *)data, size, perm);
+	rc = integrity_add_key(id, (const void *)data, size, perm, 0);
 
 	vfree(data);
 	return rc;
 }
 
 int __init integrity_load_cert(const unsigned int id, const char *source,
-			       const void *data, size_t len, key_perm_t perm)
+			       const void *data, size_t len, key_perm_t perm,
+			       unsigned long flags)
 {
 	if (!data)
 		return -EINVAL;
 
 	pr_info("Loading X.509 certificate: %s\n", source);
-	return integrity_add_key(id, data, len, perm);
+	return integrity_add_key(id, data, len, perm, flags);
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 547425c20e11..1194ff71a1c1 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -166,7 +166,8 @@ int integrity_modsig_verify(unsigned int id, const struct modsig *modsig);
 int __init integrity_init_keyring(const unsigned int id);
 int __init integrity_load_x509(const unsigned int id, const char *path);
 int __init integrity_load_cert(const unsigned int id, const char *source,
-			       const void *data, size_t len, key_perm_t perm);
+			       const void *data, size_t len, key_perm_t perm,
+			       unsigned long flags);
 #else
 
 static inline int integrity_digsig_verify(const unsigned int id,
@@ -190,7 +191,8 @@ static inline int integrity_init_keyring(const unsigned int id)
 static inline int __init integrity_load_cert(const unsigned int id,
 					     const char *source,
 					     const void *data, size_t len,
-					     key_perm_t perm)
+					     key_perm_t perm,
+					     unsigned long flags)
 {
 	return 0;
 }
diff --git a/security/integrity/platform_certs/platform_keyring.c b/security/integrity/platform_certs/platform_keyring.c
index bcafd7387729..131462c826b5 100644
--- a/security/integrity/platform_certs/platform_keyring.c
+++ b/security/integrity/platform_certs/platform_keyring.c
@@ -32,7 +32,7 @@ void __init add_to_platform_keyring(const char *source, const void *data,
 	perm = (KEY_POS_ALL & ~KEY_POS_SETATTR) | KEY_USR_VIEW;
 
 	rc = integrity_load_cert(INTEGRITY_KEYRING_PLATFORM, source, data, len,
-				 perm);
+				 perm, 0);
 	if (rc)
 		pr_info("Error adding keys to platform keyring %s\n", source);
 }
-- 
2.29.2

