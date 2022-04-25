Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B101350EC03
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbiDYW01 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Apr 2022 18:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiDYWZv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Apr 2022 18:25:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA2A7A9A7;
        Mon, 25 Apr 2022 15:21:49 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PJat6R022547;
        Mon, 25 Apr 2022 22:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=/VugjAkkwakedsnbxxxfoh52iUiJK7Gbd9Zf81j3sNk=;
 b=KkBH2bpZc/6jvIx9/juUqUhPkIIVJh9gthmtQ7dNyaXVKh/VYMOYE8v9+bhtj9ASaK2Z
 MVPrMLLFi9g8UeFmtu471/PIJLvxjlALqcxxk6nVqCJBxYaMGrIhixjrBXz8/m/BnMC/
 WyxPi+u6UD7ZjduQBA9ABz58E8RMBVSD/jkYg2kmVlCranVTqLyYihzMVRrBOIcy6dBT
 xLKOu2lLmK4mR9yVmAMDP4Vjyse0XddJ0k10xXEm0XFzEjQ8cNzIt2cxBhbktJ4obZYu
 XWBuJlz1033XPGxS5kLhII6X10Me8DXwIwgnmVOM+Z3AkbyhYyps1XKcZ8STlHPcAeTQ Tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yvcv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 22:21:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23PMAP50009898;
        Mon, 25 Apr 2022 22:21:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w2c8bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 22:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLIWEPobBeqLutUK7gGFAZ/UfENqIuZRy6J0FAXSwlghqME/a1wp2WtuqUKkhTmMICYRSTdhGF/M+xVxCwynODOI6zRXrRed2fET3Q3xlzk3vwTtp8SbIfkD0pWgesSR7K5vC4Us+IOHbqO5kvZeK3QhC1USCH0pONfwkv+7Hdhc8mV5trbW9t7DqjgW+2zqcF6o7lXK4NnQWjCOGErkOpGwuSDk8Ulnm3j2/s8i7bXwmS2XMifvEC+BOrxU9jJpB3PpBPYo38/79RDR5tdowF0AnjBuRbTIwedagiFt37ubo1Ez1vXe7R/qXOanC4kwCVcad3ZiNEHhPak3YTbGGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VugjAkkwakedsnbxxxfoh52iUiJK7Gbd9Zf81j3sNk=;
 b=XO0KHubWOz6VgQpYvflgOkkkKucIRYH41Nx17Bw+OH1DmuYT4W3bYYDANuie5RsEVuP3igYkMkISUIyrM9lyXcL7DaqOeWYbswnUXgzNRJCYaoTOwOKA3JrxKRHTzsd6mG+ItIEkZ9+nQBXOCJnhV1u6F1B/VieuXYQ9sahjR7p88qmPaEkkwGAIzX70rt7vgeimgLr0asUSnHBdcp6kED9ifqLlnvTkR0Or4v7JgZoxlUekNrDRRQP13idSaf+cND8HB7KIgS1n9zbXmi4ayWWHk7ryEKfZcem/fUQ2kiEQggcY5zkehvIIi8miWRxD27Xdu3t6fJY/rrfTXUhGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VugjAkkwakedsnbxxxfoh52iUiJK7Gbd9Zf81j3sNk=;
 b=BLoVO8nQZ/2tARu6xb3/yq6CxN2ksz92LlEv9clo0dueAO7IDLV63+BenVGM3H8YIuqEj/9gF8gbNcmy5BY8gCcBwMYH0RESkUbU/a/v7YD9QZf+WXpxg8+ADYywni2GSczier4yh8niJurqP5pRqI/jxAXGZ3iwfOduauB6Ruc=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB3228.namprd10.prod.outlook.com (2603:10b6:5:1a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 22:21:31 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 22:21:31 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     zohar@linux.ibm.com
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] integrity: Allow ima_appraise bootparam to be set when SB is enabled
Date:   Mon, 25 Apr 2022 18:21:20 -0400
Message-Id: <20220425222120.1998888-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2974f27-cf64-46e9-8f7f-08da2709f25a
X-MS-TrafficTypeDiagnostic: DM6PR10MB3228:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB322877EAF40C936A046ED5B587F89@DM6PR10MB3228.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T0wv1I4iyHxCPxsqosnvZlIkc6OO9JBNei6Catt3wYwENwngVGnac+tju8C27j32UL0zU5xnvj101QIdIuTHnu8Jc7NULwSb2mQXPpb5/ZAiCfXj3BPdCF5yiycWASp9EZPuhg2f0dJuglOYbLoEkscMCyq9Yy+VFDZy77ll3onIAsodyungyB5fz9ekeutb8KhzPhx+0QnbUDXDmo468q9P97X3BSz8N6H1337vbkH5EiHJK8TGouUJlTOMOjDyV86YjoyES6xpBT0jwf64E26xLgyArcfohcUueuRehCFeW9jhfjcyybnUzKGRB1iS/LC1yfZ2ut1NpFm6k8FT2s7Jb23pvoJB1Z5ZJzLjsLE9GQdC//HkLAnKu4a4UYacVgYdSOu9nuO97Jco/J/5RG+JmjeFM+OrwP9ie+cmrE/1at0PBfPXnAilBykAUrcGn84gFH2BtA/UqQknkBQD4zVepQxVnumYrRKrPK6+dpYuv/lWgd1vt/KSQX4TzmAYGzIWMr/EUcN46V8ZI2J5hrSvPUi6u2qQgMGPrfWLoAyrJj2eHmUcEkrPCulH2WnDpk0JtyV1IOu6WzGOeWjrvnz+VM7ixgqRtB77Q5BuQSZWLTSwcRHOYi3BjM6IrHzWacxWV9bngX1d/fUf+NJA0AdUCotH7AftXcFHQ7z6/xoaoBNGhYWBV3WIMvpKFSkFDhayE3kbwUCNMltWY6869A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(1076003)(38100700002)(83380400001)(38350700002)(86362001)(508600001)(8936002)(36756003)(5660300002)(44832011)(2906002)(6506007)(52116002)(26005)(66476007)(2616005)(4326008)(6916009)(6512007)(8676002)(66946007)(66556008)(316002)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JDVKU9h8KEqM4dH2+Q2+Rj+3vub40E5xaI5mPcTfnv5dHOoIsxKGHrsgjmuL?=
 =?us-ascii?Q?X3KOgm1QmGCl7S/tX0kuApv3Ae5GFVtM4jGmOKn4Aix0hFkgsy29lrniarws?=
 =?us-ascii?Q?04bJUPK9y4MGJ+8G45da4FZBP/C1dUXCi31EGmjHsCSAoR1zbkgBBIO6EzRc?=
 =?us-ascii?Q?C0uB4vuWZIKZokjG6FuqoLEu7QCN+WJhhR9Lp6/9TAbewnEmuunrr4vdQe7y?=
 =?us-ascii?Q?Y1xMBp+IdaFF9+j267bpMyQPSTK5gk+D0qtPKqaav8svgXw5PQgliwmK84Th?=
 =?us-ascii?Q?/G42CdpdhiE+oaiZHGcwi/wUHw9A0cludntArW+me9BowMxr7VsER6Xh5Bd/?=
 =?us-ascii?Q?T7Y7TLoWmYiT53fOMGqPFH16WmCH9tIaQ04OxvlrFm7pEXTs48fVmY8krIrg?=
 =?us-ascii?Q?U+V4kOBkBeVLGeoz8GHvXAqdXxohuba6MZ0rd4qvAdJfzDjpEpN/1DzTnnut?=
 =?us-ascii?Q?USme0pLjLHx8tz27PH1a5Jjavl95+pk9oM33lnQyMuHTT+uAz4shPXEcazzj?=
 =?us-ascii?Q?aX/Frsy07TGu8yx96NQceKNZj6WX+ghCAWE1Tdkp8e0xPASmHN5NZbrT6xqg?=
 =?us-ascii?Q?1sVSadGgfNf09VQXk05vU10qB0fw4dwiRPJe8GWKYvYF/mA+u+kQxoGiRDiX?=
 =?us-ascii?Q?5+BbENYhEeBqp/3yNJEa48X0uSVX6EwmJmMyeEP2jYJmxz+1EcKkYvnbZiIM?=
 =?us-ascii?Q?mS6NIYqo3oP7NNRGb//PKwANSaV+GhyJxpMtOal7qGUJ+9J1cHZ927aGJ2hf?=
 =?us-ascii?Q?4EYy8CFU/JZtN5246nThwXEQ0Y4pSLDWWRemOV8lH2g4BW5XY2vsVzbk1ucC?=
 =?us-ascii?Q?c12QGtEmfIOiT4BZViN0b7Q4b3Ut1w/Hya9hXZsyK7G/x36vJSxXawE/i/U9?=
 =?us-ascii?Q?NiRdSZvc1i6rvoXBrFTZ4tPJmepEY3dMkv9cpSup+kKPWUlHWOVDh2t/LAlt?=
 =?us-ascii?Q?L1IY7lN4Gg1M2FDTrtQV/0Ub5vFO6E8eMlnW8vy+uMR1bGREzD24ekjv6/kg?=
 =?us-ascii?Q?KN/g/GjnE2q8akziFXifwNvAMA5zRLXm50uanbVyh39KXBPuqCE3fZI3zdXs?=
 =?us-ascii?Q?MoMwXjcR4mM2zC4Gjliu3TZrCZlIc8Caji8xptr95+e1pE5RlLw5YKYITWLw?=
 =?us-ascii?Q?eisYZ1eCKEYFmgrxxvQ1S7RNIaDgBI7Z2C+zGbOHXjwzToVwNel49AmpXShK?=
 =?us-ascii?Q?ukVKIzj3mVcBkiQr4d/Ywx0zOz+t/OUmlUsJWKhAB9tF2OWTpxHEwIjvhSlX?=
 =?us-ascii?Q?hAAJkKeAmx6HqLKARY0p+PmvcrDtnMG+1+6B0zc3xgFEN/4mXaHcbR2qdwES?=
 =?us-ascii?Q?tpjrNBs1cCx5pUe+89Tw+2dRykGHknJVp2DryvqTmOp8ATklxpFNlzWyxdTp?=
 =?us-ascii?Q?yEkV1CWkBvQVMB5zOCLUvt0QsDaIfUHCPzNfecaiVXE+wGAf+vAeVaqPHa0C?=
 =?us-ascii?Q?xB53womRAy1DNTuZSjp2WhdIAqav2iMRO+c5YYe/cj1qaofxF1/R4eVeYrsx?=
 =?us-ascii?Q?fiHj384qJxnf62aNJWV162iJI+lvXZq8rqCkBk64YCj/5vlwgr0BTTRZaQzx?=
 =?us-ascii?Q?rqI+kh2riylmI/rHezqHZs2e6/SwRy5IRzExW/zPFVR/6ok4dzsEqtmfIUkx?=
 =?us-ascii?Q?5exEGMB4/Oj58IFQKYtXhuED3Zz1Z+ZdYWr++/9UKGtujJPIGRIjTP1bwlzZ?=
 =?us-ascii?Q?tUJsVC8fgoZUyT/FTg2l0hy7/v61/Z3iz+mQ0hNZlMCrfjk3lpYC5hgOsEQ/?=
 =?us-ascii?Q?U1GTtz/sRT23ZEZWG0iThxw2m9PBRM0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2974f27-cf64-46e9-8f7f-08da2709f25a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 22:21:30.9317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HPLfzVw1ZQgFb15oV6MaALEHq3seoPvtFsZ5bP+EQzzz7MskZBS4SfxuJkz+YXwj+ySftC8MdBBzkYgGDdnnFoXvBWyRUyyOLJuwlAM+pnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3228
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-25_08:2022-04-25,2022-04-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204250099
X-Proofpoint-ORIG-GUID: P8lPI_FkKH-WjONUiStvHiA0iDxqSlC9
X-Proofpoint-GUID: P8lPI_FkKH-WjONUiStvHiA0iDxqSlC9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA_APPRAISE_BOOTPARM config allows enabling different "ima_appraise="
modes (log, fix, enforce) to be configured at boot time.  When booting
with Secure Boot enabled, all modes are ignored except enforce.  To use
log or fix, Secure Boot must be disabled.

With a policy such as:

appraise func=BPRM_CHECK appraise_type=imasig

A user may just want to audit signature validation. Not all users
are interested in full enforcement and find the audit log appropriate
for their use case.

Add a new IMA_APPRAISE_SB_BOOTPARAM config allowing "ima_appraise="
to work when Secure Boot is enabled.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 security/integrity/ima/Kconfig        | 9 +++++++++
 security/integrity/ima/ima_appraise.c | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index f3a9cc201c8c..66d25345e478 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -237,6 +237,15 @@ config IMA_APPRAISE_BOOTPARAM
 	  This option enables the different "ima_appraise=" modes
 	  (eg. fix, log) from the boot command line.
 
+config IMA_APPRAISE_SB_BOOTPARAM
+	bool "ima_appraise secure boot parameter"
+	depends on IMA_APPRAISE_BOOTPARAM
+	default n
+	help
+	  This option enables the different "ima_appraise=" modes
+	  (eg. fix, log) from the boot command line when booting
+	  with Secure Boot enabled.
+
 config IMA_APPRAISE_MODSIG
 	bool "Support module-style signatures for appraisal"
 	depends on IMA_APPRAISE
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 17232bbfb9f9..a66b1e271806 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -43,7 +43,7 @@ void __init ima_appraise_parse_cmdline(void)
 
 	/* If appraisal state was changed, but secure boot is enabled,
 	 * keep its default */
-	if (sb_state) {
+	if (sb_state && !IS_ENABLED(CONFIG_IMA_APPRAISE_SB_BOOTPARAM)) {
 		if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
 			pr_info("Secure boot enabled: ignoring ima_appraise=%s option",
 				str);
-- 
2.27.0

