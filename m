Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E0E68CD01
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Feb 2023 04:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBGDAm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 22:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjBGDAg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 22:00:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F736084;
        Mon,  6 Feb 2023 19:00:33 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316KDr83003908;
        Tue, 7 Feb 2023 03:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=EWZBsvPxemBmF1VZIFtk6vQ49Y2/Q8Jbq2XiObN0fUs=;
 b=t7nCvIdLZ6td36h0LjPIcZkf543oZwPjG6f3h8phAKwOIaiS9DBkg5wVLmRbfCmRJmqb
 t6XB4ANkX+zV5oeP9pG3x8x2+3B0aQAhGaw/15ZRmQtQ8Xbvd7e3Yk2oC+seqFyGOokI
 DfprdpASPm6esQcbZyt4sDkG3AdCFQSv7tg8aWxUSr/xHBioxPxjEvOCUlLmbCBE1jMh
 +lXhvp7qZrFCEzLJ/y9TsgcNNyCGRUU5KICXLsXMPh67w56yAV+pCyB+CIBHIp3MeghF
 fnh1SQbBUVnNKgVEsHIgSCog0mv7sVA4ryUGhpbYc2PUwPFZnxozSRk/86gMiuc6QgFt lA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nheytvg8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3171xPwO016811;
        Tue, 7 Feb 2023 03:00:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrb9gdyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 03:00:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W27Ar1eLHSbld3csnCOpK0dHRtqPZTjii5xA3+OS65d+hAd/XjeEcUJ62bIYnPFPp7qBZciIGPORSTuHaS6+CHkEWZ/Yp2oZ2F1uCMundE//ojvxUukQ9tkjeR8E5aJpIrnDXzCx/yEFEL0Di/BI0Y40DUfPZkfCnORXKcVfUxdy4Rz20bxdaF4q6CDoKIS5BX4E6gdTUpRyUVdvsRdjs6os/mBTqfyOqOCJCu8CIwr3TYBy0jjTCWMJ4dVZ2YlAg6NRsC6jW0s9SFTT1VX7zsYP9Ku7UwdL6WUkQvP79ughRae785f9Fozcl0TLR0jmRR92RS0SR3Z911mXIQcxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWZBsvPxemBmF1VZIFtk6vQ49Y2/Q8Jbq2XiObN0fUs=;
 b=iwuiO7Iwb5cMMlzG7JWdZT3Z5Nz4VVIFxkuc36wM/bOl4WkuBnQF8fRyQ4fmg8YRQhzgiPkHbOWsSErTuq87FPlqhXbm5L4E8tyXSECaKgWXkn7Pow0tlNSryZx7aLtdbVqmdL/NphmxFznJqwN96IE22o7+WOQcvBjWc9d4WbCsPhVQQyIEgyReS5RhHIPmkY8N1j3dRT3kV0L3CxTEtps9gZT9llLqneGJCSuXRf/ceMnSNoWs6pnowY8Stt+VoIYNrudMYbvGU6nwQj1FUnOfwLFaQ/hQa9nygA/5M4RIYUMcnsEWeOgrhs5/c9aKqXeB3MXQxAoylgHmHuWGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWZBsvPxemBmF1VZIFtk6vQ49Y2/Q8Jbq2XiObN0fUs=;
 b=CtsVnMkM7b/OzPVFdIQFsy8zyc2c3vKhhAsjRXA77wqbk8aAgAxdtISITRIE8zJWrH8eAGvlBt0cmfdaGJZCQ9EKYuUOmc4mUUhJeEXZRH2Wt92/Z7Zw4bT3fvj2NO5mGWo260nZtNndP43/UGd1FUt/DRogCW2fo7bFloZ1A0M=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.15; Tue, 7 Feb
 2023 03:00:08 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7c66:aec8:b4fd:4554%9]) with mapi id 15.20.6086.011; Tue, 7 Feb 2023
 03:00:07 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, tadeusz.struk@intel.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, erpalmer@linux.vnet.ibm.com,
        coxu@redhat.com, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 6/6] integrity: machine keyring CA configuration
Date:   Mon,  6 Feb 2023 21:59:58 -0500
Message-Id: <20230207025958.974056-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230207025958.974056-1-eric.snowberg@oracle.com>
References: <20230207025958.974056-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:8:2a::26) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: f85e3044-95f5-4df5-b1de-08db08b76b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29mRbXdp06dEl7gO7yASuUIygUAaB9qJyNa3EUriIFKk6IZqAobL5iQhUvWmg46uHnMvKSL19rQsIjulL24zDng6y/vl2X6z1LU2ZjHCr7JUplycW9Xf+iJFtT/7LEPh7p+zTXnyMeBlvqU+gWWjQKG91vNTAGh/ozUNP2470g7nacIVq4y4U4WPYoxtnr6V0LCJ85Ru05XetMb9GQ70DV9EfrlfBqpisHZoQL0OshUddoxqqPTvVG7j3MkeVNTyBVokjuQOMB48ZMMXtqdGvaagjVHaq6hYvIscFwk2eippL+KG6IdObp39ckjejW401izQDVsm6ZrFDuSE+hMdrgNUl7kO8TSjOylqolS/dTDikKUznoxRBfT2cd5uI2g+wWMwq5rHCLEW/5Z0NEADLno0twH7WepIsIjbl+XVsn+rYequF0FuW491EsfqKDvC2t1XNUt9QsX2vKTYwZLTvey0aOd7jXXpOv8mZ4VFS9i3lSvTRWC7Bv2zR8ZOkf+AEdhCxPVtRmQUaztXyfS/wG/hn46YgW1NqxrUeYOoW7sySNgq5mvSfzjw1lSQ1kClWm4zBzWv3qpNbsj42wfXuXFKa/MEKpGWfCOpDa65jKe8T8jgLs32ntDry96jAHmPjtRFdyS3+t1MwpSG1WKHFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199018)(36756003)(316002)(186003)(86362001)(6512007)(66556008)(44832011)(2906002)(7416002)(41300700001)(5660300002)(8676002)(4326008)(66476007)(478600001)(6486002)(8936002)(2616005)(6506007)(6666004)(1076003)(38100700002)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w24MofaSWFQCACOLIu0DWfM99gWTbrquxbT5Uv9u/N/bbuM+uKMzcG/swK/b?=
 =?us-ascii?Q?S/QXeG8F8FU2okriGg9b/zdIlJVk7DarTj4T1Bp1TFx7mPXzdSlk8bTVD3WY?=
 =?us-ascii?Q?gQXPjwe2TUATkgrO9rAWYmBu2rLE4AltsndJ8KthQ4hMzK1h8gMrK3eAH620?=
 =?us-ascii?Q?ZNdx+ZY6wdRNU/RdZ2wsq8/vQIbq1vhvsOOaRiuX5jhH4Yr26FnE5tHk4SmA?=
 =?us-ascii?Q?xFXSE+l/oDkdaBe+JGWFPzvRfXoVHG/9AX8djrBsT+wF4L7+kw9irLmSH4oR?=
 =?us-ascii?Q?E5233y8MK98+iJvSjxDUH6FLIJjQyIZDLT8g31DeFjmQEJk/RfT2IZ8HJKhE?=
 =?us-ascii?Q?2oVqENbZS43cbKGkNRHpuqvBAO0JnO96WlfgANqNvkQbk1FkPlTSotLKNZ7p?=
 =?us-ascii?Q?l2TkMhVSCdHWxzzmtPS3uFB+dFGywiS1ArqPN9BVOC+6hGbc3VQCu7/Jun15?=
 =?us-ascii?Q?V0b1oR1rr8smDtNUZHK/QcNpteW8EkrgVJ2RyJhj7V6od00Ss5PsNl94EYC0?=
 =?us-ascii?Q?qcWJ14xlQVf3QqQOIOUnu9+AcaPfQFyMb53VTqFi3r7FDzFdG8qLiDh7YGkx?=
 =?us-ascii?Q?AGRjZpDuK8W8z6M6bCgjBpDJVQVtOumsKLfgWJAM8B1M+odl90rlwmmqYQ8y?=
 =?us-ascii?Q?Mafq3eB9jRV2uU4++tbQCnE6Ra6gB1K4rK6EXJPBc+jX1re9V1Zepw9E3/KB?=
 =?us-ascii?Q?5cojX8F4NwyjyYzlVu4XqnIqomQ6JnKLFK5D0aG2nFEu5lhKiRrgG5SE10HV?=
 =?us-ascii?Q?/RN0PRu9bPR3xb+rfe8RtfX8IbY9ZnHi+F7YTruGA1gJMDK2Ad7XkUjhtl9I?=
 =?us-ascii?Q?zDqxoR31bOl9PY/ym1FOel6WWyjq22aAUfvmaizYWUZ7Ia6fG+eqbHebTYv7?=
 =?us-ascii?Q?B8UX+/ZFvxk/AyTCHrvogz1en818FshpG8qtp95qHT6ZRnDF7sud8l9Fz+rc?=
 =?us-ascii?Q?YyHUyoS7OdmEnnUWKX+1OSZ3ylNHAcGo3UT1oQoqBWstXRpIX1uyR9ZylW5x?=
 =?us-ascii?Q?vt9W28SKeqTm+8k0Hb6+JWvvMKvizYLqFSU0Z+nNDdV2B+4ZWRQTi786K7z4?=
 =?us-ascii?Q?4XErtaZpYCEotIBJYjkyi971x5MRnoxUTyFfuChszQnopdkEafi7wFtfZQEs?=
 =?us-ascii?Q?O6fn4t1+JIl+W2mnXAdyoKr9HOobJAzxhub7Xnnu0lNkkRZgCs3bedsxho+p?=
 =?us-ascii?Q?M7sUiw/gfn4LGjSuEUn9ccsM9fxx36yWv3bp99xFV7/gaaK6DdkoIB57MUEB?=
 =?us-ascii?Q?/mirwzAy8Uxwnz3iwCsMF17PCa3rxnD/03OUX+ivFx9+dtRei5u23IY6lzbk?=
 =?us-ascii?Q?LEEM6r3cI3HhT4XzTxmUenfPn+JKdXyc/XMrQDH3Gp9oeRS0HkbAm3WhgPL+?=
 =?us-ascii?Q?bT/mRPLQ0h0OMYh72j3R4knHFR1iyN3JScOC8YU1rCMYO59/wt0UdNQzn1s+?=
 =?us-ascii?Q?8Oae8KF+M+TnFs5xuQqPWJO/7Ahwv23hIE6d0p9kWY6ItymGrpB2oODGI0ya?=
 =?us-ascii?Q?plBpZFMP1HDaO7wrgf0pb91Lo9+Sl8YADPtMY0A3hTG135VMxdbpy7YwV7Fk?=
 =?us-ascii?Q?TlxVtuDSiaCq+qoiYTGkyuMIH7GlNh/dz/Ded+bR6XXswAaVEciXFPqKJ5pf?=
 =?us-ascii?Q?Wvbz/6JJW84iNm/CLGyX8cE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QiMGiuKaGOyaRSzXk907MAl+l4zAbEZI2Roxt+CeGDLMj6TGmdRao11awXb5?=
 =?us-ascii?Q?GeJodAhSmPOk9Xl6g6W3jia3SgyS14EO4IBVx1DNEQvxJm56t8XktZhc/oo3?=
 =?us-ascii?Q?f57J46X92cY3HPc5/o7U60ONRo8FadT6TjkiJUSwcopO34HakqZn0zTqMLWx?=
 =?us-ascii?Q?WmGSEgygsIhmFwCjSA3OOgpLoyKnrWbf8Tbq9TpeQc/e/VxAapg8tYaQz2kZ?=
 =?us-ascii?Q?tvUnpn5m2qWnUWCV3QdeZpZ/cPPHwEf3iQ9Zv6biYXTaWtjpcwqO4BOjTak4?=
 =?us-ascii?Q?+IUOWDjVSQGruJdO8McgGGiuW9ydwKuSYgJpUjclzkOxbc68mtcbxCePlL8U?=
 =?us-ascii?Q?yxAF04ZR4Rbpr6koLhfyZiNxSl8VMcC7Q261sN5Gr468FUlkccU3s984+rPd?=
 =?us-ascii?Q?qCxYrwvPETHLd4dl0d3LaWI6pjS/4RZUvSW1RNWv/RcDkwUDrBWWnzMHXluL?=
 =?us-ascii?Q?B1E0jeggYT+pVNGazdHukktTvgKF4c63KYb1BJmYveQdjs9Ncydh2i8uVLNY?=
 =?us-ascii?Q?/vz4lwuVAFnj9J8sZDtGcvffRHf+EW56mDOBZfychSCr7ngM4VBXBUhzUXsS?=
 =?us-ascii?Q?2ZxRuluccZjjOOgq3V7+dhuu3osoL1rCGXzzUJtSSXZ7PuMiAyc16rwGg/M/?=
 =?us-ascii?Q?MU/kHLAHhbCqQlQTLirkKt/Qhx6DI3s7RlNwrIujCua0DVgyXOdHHM3JkQoy?=
 =?us-ascii?Q?Ps3/M0nwusbQzbPSYgKEfdgcLoGwAzXo3QrJuyeOMvNUnB0iCKBnb4qFzPRH?=
 =?us-ascii?Q?9ej6zgVpR01bGMz+kmc9trESxtL5NDHpCPFvTDLMKQ4hQzgLY9VmyOrGUbQm?=
 =?us-ascii?Q?7PMsSs4Nn7jy+9L2L5ViFqFhfjV8401HjSQIXLXY7cvyFN7a9VLkBGBNdQKQ?=
 =?us-ascii?Q?tNZ4NerFMq9+IQ+raH2Vxn9yoACvq8m0BCOXt2T6n+q378CnXlf/0UhkLRQ9?=
 =?us-ascii?Q?CpEl9bnkOlA2jba6yN8i+0ZajsA7KkmEV6eydcBJojD/s8VYKdzvdk/vNuHu?=
 =?us-ascii?Q?lS9ChVm0QXZ3eiOHnLlF+JxWUhwtLfyTEyD3F7CRnGjmIsBmw1Gpj6qsn3q3?=
 =?us-ascii?Q?7PGozi7jQXyLS12sZiQ/pHunI8cg/SMu8ehEuCmgvMbFgy1xKJJyIbYxVZfh?=
 =?us-ascii?Q?lgDvmXy/VhML1jpeBdEcI5Rstlwsutb2u6JM0p2H5n3eXtzcSH4xN+OZyKLh?=
 =?us-ascii?Q?dTySemwczJNNzZDi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e3044-95f5-4df5-b1de-08db08b76b48
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 03:00:07.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz0SJvs3qOevgNPxY2F8nVk6Bhcifx2SYsYipxk1VEwkCGwgLURvCGbZdkYC26fe5OgD0YtoxNr354glqjnex1Fv0a2IgvnHDICLLo2ulEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070025
X-Proofpoint-GUID: 8Fb72HKU8Rcxz84R_kZJLPVsZWkciBkp
X-Proofpoint-ORIG-GUID: 8Fb72HKU8Rcxz84R_kZJLPVsZWkciBkp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a machine keyring CA restriction menu option to control the type of
keys that may be added to it. The options include none, min and max
restrictions.

When no restrictions are selected, all Machine Owner Keys (MOK) are added
to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN is
selected, the CA bit must be true.  Also the key usage must contain
keyCertSign, any other usage field may be set as well.

When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
be true. Also the key usage must contain keyCertSign and the
digitialSignature usage may not be set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/restrict.c |  2 ++
 security/integrity/Kconfig        | 39 ++++++++++++++++++++++++++++++-
 security/integrity/digsig.c       |  8 +++++--
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 48457c6f33f9..633021ea7901 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -140,6 +140,8 @@ int restrict_link_by_ca(struct key *dest_keyring,
 		return -ENOKEY;
 	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
 		return -ENOKEY;
+	if (IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MIN))
+		return 0;
 	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
 		return -ENOKEY;
 
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..eba6fd59fd16 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,13 +68,50 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS
-	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
 	 in the platform keyring, keys contained in the .machine keyring will
 	 be trusted within the kernel.
 
+choice
+	prompt "Enforce Machine Keyring CA Restrictions"
+	default INTEGRITY_CA_MACHINE_KEYRING_NONE
+	depends on INTEGRITY_MACHINE_KEYRING
+	help
+	  The .machine keyring can be configured to enforce CA restriction
+	  on any key added to it. The options include none, min and max
+	  restrictions. By default no restrictions are in place and all
+	  Machine Owner Keys (MOK) are added to the machine keyring.
+
+config INTEGRITY_CA_MACHINE_KEYRING_NONE
+	bool "No restrictions"
+	help
+	  When no restrictions are selected, all Machine Owner Keys (MOK)
+	  are added to the machine keyring. MOK keys do not require the
+	  CA bit to be set. The key usage field is ignored. This is the
+	  default setting.
+
+config INTEGRITY_CA_MACHINE_KEYRING_MIN
+	bool "Only CA keys (with or without DigitialSignature usage set)"
+	help
+	  When min is selected, only load CA keys into the machine keyring.
+	  The CA bit must be set along with the keyCertSign Usage field.
+	  Keys containing the digitialSignature Usage field will also be
+	  loaded. The remaining MOK keys are loaded into the .platform
+	  keyring.
+
+config INTEGRITY_CA_MACHINE_KEYRING_MAX
+	bool "Only CA keys"
+	help
+	  When max is selected, only load CA keys into the machine keyring.
+	  The CA bit must be set along with the keyCertSign Usage field.
+	  Keys containing the digitialSignature Usage field will not be
+	  loaded. The remaining MOK keys are loaded into the .platform
+	  keyring.
+
+endchoice
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f2193c531f4a..3385f534f1da 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,7 +132,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM ||
-	    id == INTEGRITY_KEYRING_MACHINE) {
+	    (id == INTEGRITY_KEYRING_MACHINE &&
+	    IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_NONE))) {
 		restriction = NULL;
 		goto out;
 	}
@@ -144,7 +145,10 @@ int __init integrity_init_keyring(const unsigned int id)
 	if (!restriction)
 		return -ENOMEM;
 
-	restriction->check = restrict_link_to_ima;
+	if (id == INTEGRITY_KEYRING_MACHINE)
+		restriction->check = restrict_link_by_ca;
+	else
+		restriction->check = restrict_link_to_ima;
 
 	/*
 	 * MOK keys can only be added through a read-only runtime services
-- 
2.27.0

