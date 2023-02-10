Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442A2692A5F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 23:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjBJWnC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 17:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234020AbjBJWmv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 17:42:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E593EFFE;
        Fri, 10 Feb 2023 14:42:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AI0JI0023196;
        Fri, 10 Feb 2023 22:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=htWeOv2g+vYlHqWgddtPTagB2MRnz1unP6v0CBZfQ6o=;
 b=SZsvmriD2lgJ3tfq3sNfGN2mWTj2ylzqFOzqfoVcRYPgeFNuqcH8Gn1p9mfbhjdGb2cj
 D+g0T/ieSUGngxrJtZhOAJyj0F7gNXA62/hsw4f2pzj6TQG4LB7qKXnBOEKDDuZsOhv1
 Zjp+tE1caROcx7YQdkDTCjBA6JDBreYJ5BeiW0BlUCtvfkQjJtvMY8xA3Ry/v5h3xBoW
 iGPtZEA72KUnx2V5I0DIJhwJ7aRa5mSqzqhWsw8wgUkHOGyX0uVXmOH6I9bq4SmpkVPQ
 IX7i5HapPHPDXVOLJp8tZthyilltem9RbnDmtMDqiVtVj9koL98NrUe/m6pz0CGxy4ZP WA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8aedv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:42:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ALavHG002993;
        Fri, 10 Feb 2023 22:42:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtbbutg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 22:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO/5nHiUuPUBWraJjqI0h0qYQJE2CUoOFUcwA6y3R190fQSBP11xeRcVs0SXc8UD2rHAb4zs1Qbr9r71+9KL7pWu16aT9M/RyANUf4Ty+Z9MHDWg2Ykkr9fIecqHx0lc1JOQgeEl9sejtnAIv/kqTE+s+jWgs+T2sIZJyPpplB11U/TUaCieVD73EnUERKd/05gbl9hXUMcEh/FS9RumeEfXfIeu1gMA60BESgsY7vlmROkz4XMRlTb2V/WJwvuqzAdSnOhggH4fyTfJSU4vAw2qXtfmc8jJkYx9Nc0DMEw46zB6TFYHE7MD71fEAnfp2H4/xgbveXH5alh0Z8ACbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htWeOv2g+vYlHqWgddtPTagB2MRnz1unP6v0CBZfQ6o=;
 b=TGes/LTqZBO9lgNgy/EAn8VzMzXvnmF0d0G8WhVUqsfXy5yF6374kFAG3LC4NhhCTrkYmsBFuF5B0ZVhlc7ly1X1vKjuRycvFgsJmSt/5OioYx8VHhbSxG3rnLi+vd9PtNhyaDzWLN1XkjzcfGIBbvA0xQX5dk16bqZqcdIZxU5zFTlBa+wF4afMxzdPjIYbYY134Rn8aroDmyn3tr3OO4HURNTwUqTnTM+r/065uZsizcsE95vht4CI9/H6VAXTfTx3yk2F7Q0wTlDe/WxC7jxaxxchrkyZ7uNaKZ6dGERqIYz9BOUL3sFeQmNNP4EVM/GjR5dPB2f4URzI5x1Sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htWeOv2g+vYlHqWgddtPTagB2MRnz1unP6v0CBZfQ6o=;
 b=FCi07MZRIXdyGHvogB50h0p+3jkI+IVocOjL00ByoEi8LqY0doXAuJjUL3dIYf6fnzZKT9aqXrP734ies0BAKjAVuSqHhO+RvDOYj9wrwzMAwpdqLDQ0VNdVb5aattr0EsvC1bLJa6ikSknzv7JoPGHqV7L6/3YurGcYa/wCJsU=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Fri, 10 Feb
 2023 22:42:03 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6111.006; Fri, 10 Feb 2023
 22:42:03 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "tadeusz.struk@intel.com" <tadeusz.struk@intel.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "erpalmer@linux.vnet.ibm.com" <erpalmer@linux.vnet.ibm.com>,
        "coxu@redhat.com" <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v4 6/6] integrity: machine keyring CA configuration
Thread-Topic: [PATCH v4 6/6] integrity: machine keyring CA configuration
Thread-Index: AQHZOqBI+C56J107yEO2w74T/LxRwq7IK2kAgAChHwA=
Date:   Fri, 10 Feb 2023 22:42:02 +0000
Message-ID: <6E99904E-3725-4235-990F-BD89E59492A1@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
 <20230207025958.974056-7-eric.snowberg@oracle.com>
 <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
In-Reply-To: <4bda209dfc891ac9044ce847785c383e89f14f97.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|DS0PR10MB7151:EE_
x-ms-office365-filtering-correlation-id: d6a8e4aa-dcdf-429a-0e5d-08db0bb8076e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: whmj4+Nu/Iag54ehhoHWE1KAOaPHTg4qvK5r8TZVkD1skDSDa1oe48mV9Orva2OwFrPzTP5R/k+sAP8CSu4pWWdXuLh9DB1USGmfquuJs29jWj+EuS1hvzCvta4vYJWzCYRK7tuKPT/yLuypA3Qt90/R7BeObzEy6pp92SxHtzFtJ8fPSPT1KGPDQzSeh7xPeD/H1lczavSF76oAu/GZo99HDp9J+I0m4hdYNc5dx7LzeXpaPajAJsa9r83rskS2ByZFO3t36sRr/lgilKyoHzwNYh47/ZV1pgR8J2wAqpySucrV3ediVsDXYWzKIv/mDsnWFlxIzF8xRcC7xhhrySkQK3+rX4JlDs7ObOsJ3PaCtpYRdHwCP27NtcFxSCidfqcK1wujZIrt/KckC8u4LbRmpnUcOTXwq9eyN3j7Twb91dmg/gRUh+vlQU0QeuyQYzIBj5AzohjcYDHhJj1lU14KQXNkuprTzzVXLpZGFNyJXPJfcL+5hPF3y+qWDrbjmhr30ehFqn5tq2lktvUdnHTJikUcPd9VUTzIGcNF7KF6s2/cLQhwCVSUpZWGY4x6L536IlujqPwidBqYKNOs0o18VlzLu/CLwsge6RcSbfw25oI90gJ8QCDLnu9ckw+vQVOUVHP7BZBCs/FJrJlktozJycvbX8qeqp0Sja8tjLQPTprIV635dXY8Y06ECn2KUCmBdYYgCrq810bdj2rWMV/00KvWzbnqvZCyUqkOGOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(366004)(396003)(136003)(376002)(451199018)(83380400001)(53546011)(6512007)(186003)(26005)(6506007)(2616005)(36756003)(122000001)(38100700002)(86362001)(33656002)(38070700005)(316002)(54906003)(6916009)(66556008)(64756008)(66446008)(4326008)(66476007)(66946007)(8676002)(6486002)(76116006)(478600001)(71200400001)(2906002)(41300700001)(8936002)(44832011)(7416002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A4SVaMnKFVsiVa4uTKjHCsSgmO6DsTyK0f++Ms7JxW6LLp82C1gMksapQwYB?=
 =?us-ascii?Q?bNeTmWusTkxQYjNidyf6YzUNUXfbxvnn3xI+iCEJJ4LwQghEVy3Dy2gwFA2/?=
 =?us-ascii?Q?TfI/N/p3g8D12yyQw0eUjmmVDPcHPSE2h+K5fgSb0X6niiu1/HE22oFDe7iv?=
 =?us-ascii?Q?Vdhr8uYWZc1FxwHO5HDSsW0Q13VnBKWEUoh5uF8urHWDpgnaGJtofqRYV1tg?=
 =?us-ascii?Q?ckzycXTz3e5PgTbJk8VVDgQpolQ1wC61YsoJ6VQKKaRuZHpVoysdD7Vedi4F?=
 =?us-ascii?Q?k677Ms23+4z4wVaS087aqSs1GlUJj2oFqvirfy7cpDdNKWZvSHbHYSEQbPXP?=
 =?us-ascii?Q?VaHTsHms37dXK3Gxl9j0ygRE5rJZlsy63Hdx9vr/1kW55Ymsxln/4UQhii3z?=
 =?us-ascii?Q?GdoiaLBTmQZxtKsHsSZknfGibO42jiYPdnL6FP31Jy0I0FgsaepucEK3Cto8?=
 =?us-ascii?Q?QU7EKAZEXsLJrg3QrVV+G+hwYZKBoY6z5p7g2LJfzdw/K3wNv2DAYg2wlc9I?=
 =?us-ascii?Q?F/SX1WvdsGd+FT0N3Je3PhrYnU9qQq9apVrYNf+hL2LcaZajPhIm7reHVkU1?=
 =?us-ascii?Q?kCcqOnNYjyrrgycSk2qEliDGjoy0oGRcQWu8A9Aj220wUoliAIBRmvJpIKS3?=
 =?us-ascii?Q?SnA2DSFyAYyGTaRHcuptSmz4ErkS2paB2A9qQniDjcrZL5fXZWx5f4ShyEmn?=
 =?us-ascii?Q?dqKgjCeEBGb865u3cVofxOo5SvkkVp3xEmq/sayENrcaCJHm748P3yasjv4I?=
 =?us-ascii?Q?gaIyUM77NWTjt3HdqD+OB8ZBdfFbMmPUfEaLkBVRT+l9cYFK9N+HrgcDqjze?=
 =?us-ascii?Q?aLM6PvWCV6r/UaehhMEJWGGzd0lwZxTeKipR60Tc3b5Tc4062WkQE1vB/7C/?=
 =?us-ascii?Q?BKSNWlLpwDp+q+/i5BP07Crgzwx0YDS16VH2eXwvxLdJ4LoDz4TF+Cn7MzDK?=
 =?us-ascii?Q?cAs+gnu7XA0AHka5/gKPOc/9fwrDc+g/weMX+A3FiYvnVfrBMMdJ75dPFSKD?=
 =?us-ascii?Q?qDsyeq4n4qOttiP7MIg/5XVoaCG5zr6HSgqmSDU2ClEXGC20nUf/O3W/2yjK?=
 =?us-ascii?Q?etcVdDBUCz/iXHDxWc1tTOLF14Hka7M4MARtMgT92BFxK9zyDztxtBVnZZOT?=
 =?us-ascii?Q?cPQ3w3zPkE/EIKyh9SQCd66ox9gCekOejIq+VnBsxFBoE6rhv/kUnW1DXkHU?=
 =?us-ascii?Q?TZxl/jnh/i2gNvO/eTjDkmJ0qzDyNySTh36EQjWwYf7diM3+rnJ0F5npx+PJ?=
 =?us-ascii?Q?WqudxEKDmurR508BVmojA4tfpOht7G2TpzpqkN681TX2693jM0tBObZYN+au?=
 =?us-ascii?Q?wNs5D1fkXyNAWU/8jZRpkGzV+dm2vAJrCYsBoodg4qDjaA6OEl8QfOcbAgVk?=
 =?us-ascii?Q?Eskw6NP7K9un6Sjch3dJ6klpkGJ1nXo/XX37iKaLmVTxpiN9kNwJwIhEq8AN?=
 =?us-ascii?Q?5AcVXTFDHUHCPvXsKmKOwQlQx9YlYwcUtrr64qWGx8DTCLbKqujeVAecGeM+?=
 =?us-ascii?Q?sl+mPwhwc4PTEy8XayXhdkA7vTtK+OB+nXmmCUpNDYvPdsJXwuObQIl3N9IC?=
 =?us-ascii?Q?+iSvlPdEK5FgL+BGPJ0rQpv2EcNW4ZOarPfMy5IlrANgI5i3DmSMRZjrj5yf?=
 =?us-ascii?Q?Sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A2B97A7D5ADA64E86B87F686BBCEF7A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?fVkxG5aHJJ5vfjLvJTo/PcCJ3P0ZZh+0dl7yPZ622DiWVoxBF+f93P+MAH1i?=
 =?us-ascii?Q?3A0PrYy+Nt1FWs/6tq6AtPKzLIjSHPtScJH1o8Q/il9dhu9SU5M/PAcVgcnw?=
 =?us-ascii?Q?GmxJN3U0wULS9O7FUQ0zXRFc7A8feYpPXpUwWLDZvCrmIEtS1O1Dxs6u0H5V?=
 =?us-ascii?Q?xdZbS2U/C7gSA8XaUdxNFlwyFaPLK5IJfZebB6USbHaD0WHAUV6FXAr1oz+L?=
 =?us-ascii?Q?hmDbqC/N1L5pwLz3u2R0CejJF0l8y33h/JY+PSHwUuZRTLUiHGq4qDMSAV55?=
 =?us-ascii?Q?5njSeTWtrm6F+VNFicBgURqMfegP4hRCoWWPasW0AJxk/qfyxnicF+3KsRrv?=
 =?us-ascii?Q?xczwKcgbXOWtYqvyQK9g3sLbRmxlcxc1m5c4bnwvAVSfvqYWlxRAHcYe6YMp?=
 =?us-ascii?Q?aV0dWXzzaD1y36UH0VfxYaXzOEGAYsa/UmthA25lTU/qbm8rBZeodEH1XowL?=
 =?us-ascii?Q?foGNT+s3VZpucRQ77+Yh13SJU503EQ9cWU5lrtLhdz4IiTYNtwQpI7Dg33CR?=
 =?us-ascii?Q?C2V6DGtC+dSVoKOGZzh56vOru9TBVUFRs7xAGPDCaz5fjaiNnqwhIU2UEiDB?=
 =?us-ascii?Q?0x6Xwsne4fT5z5yIuNI+HHTrYoPWGFj1fLz49b9gdowTGmgsI3kdsDyc24IL?=
 =?us-ascii?Q?2MyRkQg00tgZzEvyotDtgqx3fgA8MGVUJd/PE3NK/92DJShIwfs8Q64r+FUw?=
 =?us-ascii?Q?4g+svk5PHs11DhbSqo0D04u+5Q2Hhl96TXd0EjZCcXA0VMoptq8Z4kpcSSaS?=
 =?us-ascii?Q?q1hyrryZKMhflifMdwLz23oD4uwQ3kC2WByQOe8NpMfGODBz2cHd7EzD3of+?=
 =?us-ascii?Q?Lg5UYSEzjzkYIcHwK8BVtHE4Ao/VA+NBlFm8SmLzY9oPLbqAquD2UoQLNpSz?=
 =?us-ascii?Q?Dzqo0sjI3nvxk4mtJHvcMwCalHFEAWHvU+Nx6fgwjZZOgtpSNCOCJ6bPx7oL?=
 =?us-ascii?Q?aEczIc5TJMZJGOv/ECBsWb7bq6JpnD8RJykzl4eU1U3ZJ9OJ0fGzpLvx0OUz?=
 =?us-ascii?Q?1gEMMRoRsTNOakfeGxn1J5B1tNQR0whZsiKn8C7hqXDWx63siuLCa0OSEi8J?=
 =?us-ascii?Q?XzpUKS3a77j7ggER8HRfBk53RpDljNF2ESi4nGpSp+bkUXgO7WP5QUiexzyR?=
 =?us-ascii?Q?bVUz6k7G7IoyQp0KtJNfeeUD4AIS11aVIPRjcSiHCoXcZIFjE70KqFMs2Z2K?=
 =?us-ascii?Q?TaHIhKiKRaiLLHVzOi8YJUX2mYJfHUbROICEjg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a8e4aa-dcdf-429a-0e5d-08db0bb8076e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 22:42:02.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wlGu8/CZgfyCDEnzKjKTSDBdi5SsQDxCxyvaqfRVQRJNudyhoijoaoGhlm228Fxfze4zcY6vPfN/mwjsjKxn8OON39lqs6VOBGwXhw3zBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100194
X-Proofpoint-ORIG-GUID: k0VDHPRTcd0C6-V_RbxvGQQYnQ4lz1Z8
X-Proofpoint-GUID: k0VDHPRTcd0C6-V_RbxvGQQYnQ4lz1Z8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Feb 10, 2023, at 6:05 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Hi Eric,
>=20
> On Mon, 2023-02-06 at 21:59 -0500, Eric Snowberg wrote:
>> Add a machine keyring CA restriction menu option to control the type of
>> keys that may be added to it. The options include none, min and max
>> restrictions.
>>=20
>> When no restrictions are selected, all Machine Owner Keys (MOK) are adde=
d
>> to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN is
>> selected, the CA bit must be true.  Also the key usage must contain
>> keyCertSign, any other usage field may be set as well.
>>=20
>> When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit mus=
t
>> be true. Also the key usage must contain keyCertSign and the
>> digitialSignature usage may not be set.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>=20
> Missing from the patch description is the motivation for this change. =20
> The choices none, min, max implies a progression, which is good, and
> the technical differences between the choices, but not the reason.
>=20
> The motivation, at least from my perspective, is separation of
> certificate signing from code signing keys, where "none" is no
> separation and "max" being total separation of keys based on usage.
>=20
> Subsequent work, as discussed in the cover letter thread, will limit
> certificates being loaded onto the IMA keyring to code signing keys
> used for signature verification.

I will include this in the next round too, thanks.

