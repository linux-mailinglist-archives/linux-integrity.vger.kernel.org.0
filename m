Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42144F5D24
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 14:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiDFMEM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 08:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiDFMCu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 08:02:50 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F84435BCF;
        Tue,  5 Apr 2022 18:54:33 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 235KWY9D012570;
        Wed, 6 Apr 2022 01:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ooioI83J9ndcWeBkD13Hvh+2cbQGalhmIkEwiTHV0rg=;
 b=MDLSM4r7aVLFCMp5CAvVTXxmgFwGAtkTY+6nfyi3Hj815kOBpy+zZ8gsz0ZPzvGu7nFD
 bRIgPWHjnu8FxQFziDON5p++JYmjemI3fqR+Jh8I/PLRq0awUp4Qfhe1aD5JSUOjWVTx
 EVnborWz87v5pH0S8ByGWHZ1eThh0vRgFiO3jYta6+3K4LTQXFZTW2sCBO4gW5ODBcSK
 drEsUShi9UDoMXe8+4PhFmM5RwBMOVq4zMcj+OSdAKVaYL9O2BMif9dbPV3g+Tzs79ar
 6pvHVebGz2tropkkUKFlf8ey+WnOUbMJ19WmUZ03muR16em6+n+w6DzLaZQFXbEc2852 zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcfdm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:54:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2361pd30001674;
        Wed, 6 Apr 2022 01:53:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx48c7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 01:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAeqUZY8SJlH+lqrQxQEyxnQH7Dm+DLFMPU+IQH8PlTwGU6Hq24IJr4jI/r/1HjxMeSSqMKUchde8TL91UvIznRjTpvEeclr6RpGJDzD6QvCsi+f4uCY+MfPq+YhkT3JJoVEg9bynxkVIHwhcSCIcUd3BSFeQsMGyn7U7RCTFiPV76NDcQvj04MRVwZwBMDhLjPrew/QU+25BlkTBwrP8QPsiVmkL1Qu8qwedYR1+rZfx61bYq9uzua2R8iADQuN9PW7bW2y7ukbSGrkA5b1XpNQSsB+6KUYJB7TYCyf568h1Gafbq/J3YB/c1iW11G2G+KAWQTi/0DSJoVoPymgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooioI83J9ndcWeBkD13Hvh+2cbQGalhmIkEwiTHV0rg=;
 b=bOYv4B+pd/c8WgFDMK+8tozhKJzqRbR/XjAUFcxXAmXpUioiFS1z+EwEM/bPRfCcW0OOASvhp5EZABJtizGccrsuwn/lquBX613cqcdEQV3brlEWm4iSX4HSvGLa0aapLSJIz0Tyuy4RBukiGt5iPUxJdxXmqLZopXuqZNu4uXqvrtPQOlnEtiClPYhFehNANM4mo17JQ3yzutwYQ5bL67WVE8INX2vcdnqY3P7w3zCSM+lJxxVwjQtqyg1QAdimGQwbw2aw0mkpEJqSbRkuJu7hf86LzAOgdf4Z3965SLJEcByMNunRFqA0XKFR+qQMBLtrJ/hIObuugVF1XdNR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooioI83J9ndcWeBkD13Hvh+2cbQGalhmIkEwiTHV0rg=;
 b=YPg6MAJZRNTzS+bo8aOSHVRLwMzrN7euR/Q+hfntwQPfRHji2cuG213gTjec4qPF+dyViUHY78MLdDCOYquqW10kBGQ1Rq91iuQl8n/tfK71IHE8k9PA/nqobTzi69SAP6ii0grrQHKXg88olClNHLxPwlYZSqSjFdw5HGGkGwo=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MN2PR10MB4349.namprd10.prod.outlook.com (2603:10b6:208:1d4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:53:57 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:53:57 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     dhowells@redhat.com, dwmw2@infradead.org, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        eric.snowberg@oracle.com, pvorel@suse.cz, tiwai@suse.de,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH 3/7] KEYS: X.509: Parse Key Usage
Date:   Tue,  5 Apr 2022 21:53:33 -0400
Message-Id: <20220406015337.4000739-4-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0091.namprd11.prod.outlook.com
 (2603:10b6:806:d1::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad09be6-e044-4ef7-1220-08da17705026
X-MS-TrafficTypeDiagnostic: MN2PR10MB4349:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4349FA3C86DB39E4912A9C7587E79@MN2PR10MB4349.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7XHgyDugoqY1oErYAePtepnIyXcsOXkD8Ijd0koUzUCcZlFrV20BGw3sQLHSKMoJfnXEckqzP+QFSjs+GCXfpRX8QhFCIX3KeTKPxrU9I64Br8wM9mxhrnv+J2d0d+EpeUuk7wTychZeQDuo0DFRqVFfCdvKWk2NMmOWKbSdaagq05Uuu2d2QWeVzaVnH5/IKu3Tk/oEYjirjon32qCdAKpZMqtrC7zsaZ3xbYsnphq7BuNWgsu95AHQeqH9PLsznjT5rJXi5tbjhdPtJJQOco6Bpyq/uK9u8X11WKBzJxKI/mZG/91zJcjm3S9zW/vWEJtwqyDzRy3ewATxqp+8DnVquKhSRptBnPjhoGx8VAgI3DyCweagDfbQQaEajxVBJPRr4lzcRz76vVFXo4yxA5YOAkxXt44oewAWYVrMPvMzbNU//MCMHZbVWGWEpJP+D3wNNHWuxFdvhIIAWRmjETt/iUrrMEPfWHrbq/OhJY46AlxA6W0SqdqWXEczzLtKlCrXQsF1KRkh0ymtH4mephKYYRx8KSpWqxqFu9KzlactSn8jYAB/re+dpgPLFsXILE/lu4SeUfObm6LT3VYDxOfXZsnzZNfDRorLmTIU6QOO4lhtZl+GK/G5l9tcPLZr/DjIg/6cQrhOM31aMcaToAqUi7vCjLc8LaGyLCUNtC5AROmWS84yptJNHBpZQhiRNOZbtmbP7Wj2dpq/OK7ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8676002)(6486002)(6506007)(6512007)(6666004)(5660300002)(508600001)(316002)(4326008)(66556008)(1076003)(83380400001)(36756003)(186003)(26005)(44832011)(38350700002)(38100700002)(66946007)(2616005)(86362001)(8936002)(2906002)(7416002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r615JfzC/FakTVKms9nMBuVsjkIrAT+W16zSocjnYKhoCIt9nAk6zGzbZ1CW?=
 =?us-ascii?Q?ObXYOcivH1+23puA0ITBLBCjhs66xjViQQiMCakbezKpSeAvm/YLj4s9eps8?=
 =?us-ascii?Q?t0i4OWOrM+fy31KRnZDUVrzmIHdfBVVtYX0lirZF8G+8blu3y1BzU8qXYy6/?=
 =?us-ascii?Q?SoA+Mh44PS9s/bz8OJstrykjmW5nZotCH+7vFqeJRQbo5/rvXXbk6xnMpps7?=
 =?us-ascii?Q?v2RfA0V30AYd7gCh8HTQluN6hRw6VIGMyvaUx4Z8JKcB5plu/YxUptv9Zl7Z?=
 =?us-ascii?Q?E/9b5vry/Wq3fy9Y5DOo3REjN5rvbs5KIcBt3ChKYb4sH6HS/Oi1X8iUYA1v?=
 =?us-ascii?Q?h+GKG60nzqAUFveiXh0qbqzJS6znPNSK5w25GcBdh56sV7ux0kWQgjH9kKVQ?=
 =?us-ascii?Q?AlJ1nTZ/Jvshxothniy7TXnRCP6OcqYdEj9WYJry8njIMMvKC35NpV9ycwG/?=
 =?us-ascii?Q?38PktZwDRnaAfd2bY0ZrrPgf6rVUQstvRjjoQD8M1J9HuLBXvjMnmUeV52wH?=
 =?us-ascii?Q?B1XVvC2PglkPPYystdfKocdpWnY9auI896oSlMB/fjgrkYJzBRHMoRzF4BhV?=
 =?us-ascii?Q?tJl9wYVp1DGTecWCpiYoFb0jlH0ygTdRrAjwZAn0u8h2v8+g6zPq1JGnojCK?=
 =?us-ascii?Q?/C41PSuE/B9vwyh2kM9HVTlmLAuB6rvNLx/PgFyeIzwm3KEwSAohDNgkAJn6?=
 =?us-ascii?Q?DvrIdRuCV+C8LdjPmUZpgPbMDA5DHzc7i53Fi5MpLyVLu3KIRIhpq8o4EiGj?=
 =?us-ascii?Q?+imrye5qByw0yFuWFtqBCiTIb6a+7WSUy7e6f7WMKS34xSwB0Ile8esiEWYE?=
 =?us-ascii?Q?jomhIamhCqDWXKaOmVvVu8jswEaCh0yFX2/b9oKLQgplXTGsCXcyVqtwv4FL?=
 =?us-ascii?Q?m3Oahfg8fleQceqZTOx7yNjQijWaxJ7qRL+Tssy2Id5bPekrannTgw4DjQoC?=
 =?us-ascii?Q?r0btzpXXGyqrhkuWD/4BOPsjqX4o7eNKRlr2JHiBpvjUkBKkEJcY1Rf005MP?=
 =?us-ascii?Q?oLDMuKfjtnciPj/A5IVjLaZH2DUhb8IW8s3uSq9FtOOB6CeBvMaXk9r2neI8?=
 =?us-ascii?Q?zmBaHHvG9PAfNKqrR5b/liWjJBE5JcXz3JxLGaLgdZc4pbw+5jzVjAuVT8S9?=
 =?us-ascii?Q?wKOM01c+gOWkoGUFhJR2cAwwRtFar9zDhqt7nUDx01gvSB+4kfsssur+R7SS?=
 =?us-ascii?Q?E7rRZJnyGVgiJEKEf5B2uKgweghQiJce2wUA5PpOVA0hJeDhK3R1Zf7lfeLt?=
 =?us-ascii?Q?PLaXrTS3w49GhSP6RiI3deEA0zHPpYaUqh4Dqkdkes3tjb8G5ECufedL/2Q/?=
 =?us-ascii?Q?aMwdC6RfCLpU6y/FeEYfEDohOcgkiMEM7gs03sFA/1KiwOPZQncOP7swP6bC?=
 =?us-ascii?Q?SR60N7cqdBimjjNFKs97JPhgwflisNGE1MCCkunGzAk4NU1rK35SjydHnTDs?=
 =?us-ascii?Q?M3vkIlOPBz2Yx0LAjBM9VS9N2iOE5nG5O8QXRGSo2Bk60Fp5g36PEZ5VnTe3?=
 =?us-ascii?Q?W6M2Mbz8yFmXgRbDxhtOiCo7enlMDLAetIdbqJnY4RL0dOtMf5KwyWLAj0mp?=
 =?us-ascii?Q?9EgXcyrwR3jE7BvPvF09fqCb7jC1neQpRJW4BdILWlewQdCp5LJYaVtQPKaV?=
 =?us-ascii?Q?r+zg0+AVRJ+KlT4YFd0MyCzCotl6ayWUT+FHF62G1hjpOjw9n78M1Pw8v3Jb?=
 =?us-ascii?Q?H++I/mJzjWRrNSlEVRO+AryAR2ZDKdax1p6JMc5FFJ5kuvkFODtGKkdrySID?=
 =?us-ascii?Q?RLlQ+3r1NP+jnwG4gmUdLI9sYEK+PZw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad09be6-e044-4ef7-1220-08da17705026
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:53:57.6825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nLvSxYugDBQu1yTxZ1uzZFDe3ozlob2rXdStbtYtvfytgaJ6GVp0VBOYjc7fDJIZtAkptCGIs5n8xyBHP0EhaGtV2lYYM41YQs+T/qhCu3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4349
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060004
X-Proofpoint-ORIG-GUID: b4d4B321FddoxuuwTp4qKtc7WLpU2rD0
X-Proofpoint-GUID: b4d4B321FddoxuuwTp4qKtc7WLpU2rD0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Parse the X.509 Key Usage.  The key usage extension defines the purpose of
the key contained in the certificate.

   id-ce-keyUsage OBJECT IDENTIFIER ::=  { id-ce 15 }

      KeyUsage ::= BIT STRING {
           digitalSignature        (0),
           contentCommitment       (1),
           keyEncipherment         (2),
           dataEncipherment        (3),
           keyAgreement            (4),
           keyCertSign             (5),
           cRLSign                 (6),
           encipherOnly            (7),
           decipherOnly            (8) }

If the keyCertSign is set, store it in the x509_certificate structure.
This will be used in a follow on patch that requires knowing the
certificate key usage type.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 20 ++++++++++++++++++++
 crypto/asymmetric_keys/x509_parser.h      |  1 +
 2 files changed, 21 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 30f7374ea9c0..a89f1e0c8a0f 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -576,6 +576,26 @@ int x509_process_extension(void *context, size_t hdrlen,
 		return 0;
 	}
 
+	if (ctx->last_oid == OID_keyUsage) {
+		/*
+		 * Get hold of the keyUsage bit string to validate keyCertSign
+		 * v[1] is the encoding size
+		 *       (Expect either 0x02 or 0x03, making it 1 or 2 bytes)
+		 * v[2] is the number of unused bits in the bit string
+		 *       (If >= 3 keyCertSign is missing)
+		 * v[3] and possibly v[4] contain the bit string
+		 * 0x04 is where KeyCertSign lands in this bit string (from
+		 *      RFC 5280 4.2.1.3)
+		 */
+		if (v[0] != ASN1_BTS || vlen < 4)
+			return -EBADMSG;
+		if (v[1] == 0x02 && v[2] <= 2 && (v[3] & 0x04))
+			ctx->cert->is_kcs_set = true;
+		else if (vlen > 4 && v[1] == 0x03 && (v[3] & 0x04))
+			ctx->cert->is_kcs_set = true;
+		return 0;
+	}
+
 	if (ctx->last_oid == OID_authorityKeyIdentifier) {
 		/* Get hold of the CA key fingerprint */
 		ctx->raw_akid = v;
diff --git a/crypto/asymmetric_keys/x509_parser.h b/crypto/asymmetric_keys/x509_parser.h
index dc45df9f6594..d6ac0985d8a5 100644
--- a/crypto/asymmetric_keys/x509_parser.h
+++ b/crypto/asymmetric_keys/x509_parser.h
@@ -39,6 +39,7 @@ struct x509_certificate {
 	bool		unsupported_sig;	/* T if signature uses unsupported crypto */
 	bool		blacklisted;
 	bool		is_root_ca;		/* T if basic constraints CA is set */
+	bool		is_kcs_set;		/* T if keyCertSign is set */
 };
 
 /*
-- 
2.27.0

