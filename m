Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64DD6C509F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCVQ1u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCVQ1o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:27:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2D62DAF;
        Wed, 22 Mar 2023 09:27:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCYFf4026463;
        Wed, 22 Mar 2023 16:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=DWlucKbLU1+iEa2FeLlVjgPT2+AFxyeMSc3Sfsd8MRk=;
 b=AIgkgHNsSNlyFIfpX3Po4zd9cZqMXFxPgI+kiYvvi5xSBj2M2A7eG33TIj/KJhzXt4zk
 Z45ha7En2ZxkoSFvM+ugHleEEJqgDcUXiXRxY6OWDa3UA3s2k6vCLtIbwkp++nYEoqVQ
 VZ8VH9D02619gSXdeCQLTc2UX5bH/NoigOKJqGLf+z/dcfntT0EzaEXfpG2DaakiOEOh
 RMV0CzITuI9Ua5L1prqzyTI/bLc6MdnYyJBNT04e66K8uSB9TWrnekmhYVzosrAoseMw
 ttyTshdgW2F0KccAjte2KR9Gce89e3OP1Wy/86eew7vTide7Rv9q4DGBkmVCrRuxl3J5 Fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433sfxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:09 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MFcs2H019040;
        Wed, 22 Mar 2023 16:20:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pg4gj1vuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBJaaeoAsNwawNNc9C/U9Eps6dfz+bJufWlP3m1gRsKgpGDcwPhgPEXa0MnddOv7LqfdCXkNDk7Sb5Z5fdxmPbCW7h4FeybL/ri1EOlaqcZUBBB/LOgraO+uaOIA1+B0AuZLjw7EvSr5JfY71+dbNlJp+BGJ7BBC4MNW90N0jvzgNhfmbertlAIUMyIj00NHYqB+wQQ1Qlk6+0994BYQfhPtjxfWkeMG1/e1n2II+nGf6PPth9Zhy8ccBer/pmP43xUWSUjCzmvfQqBnf8scPOMD8XeVxRfTMBIN/sWTpKp/UIQgVpxyfQZF0V9mzf7l6pJYtcG3d77CGa46u/lMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWlucKbLU1+iEa2FeLlVjgPT2+AFxyeMSc3Sfsd8MRk=;
 b=HAWoef5cVIRM35uGFX6j6KlNEPzsuDAylzK8pG5cJschj5pb/TGKZXZVpuxCa5rbY5a0KbSsb06Q3wyxlKA7qmEv0E4M5uu640/WsSYQTUMb8EBtAFbkYnZFob2ZNgMEEZDbF3CBUEtidv6Z6MQYVVAuSe8cA1pMbes5u16ahdpuqsMfbJk3HIAYo0QBENkM2joklBl0kEennFVl14XqKu/FVINHR0GFN/DfNz87WKuNikb5+DF8RlzNyfzU6yyNtKfCNaadMeE1jFPfP+ElV+fzzK8Q/5we8W/HNLnUFg4PQZPjBWHKSOjxc/yoh6agYCgHjd8iPkoVH55Sx+sPzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWlucKbLU1+iEa2FeLlVjgPT2+AFxyeMSc3Sfsd8MRk=;
 b=rDewVSuZNvPOyLLWqj4sG0Ynls4/Qp6cLryGTMVKwAErLJ8XFJbeLV0EsFNtTslwaYNSGgI4LDvFltjwX+O51TxHTYzNKIKE0BYJaCusiVrLyPsV4PGyiRHgRyTHA3u/CFzbnXK/0vJ/zgIXPd4fpIXPKLJ9/cjR9E8TohkrlPQ=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH0PR10MB4629.namprd10.prod.outlook.com (2603:10b6:510:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:05 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:05 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com, jlee@suse.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v6 1/6] KEYS: Create static version of public_key_verify_signature
Date:   Wed, 22 Mar 2023 12:16:29 -0400
Message-Id: <20230322161634.2233838-2-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|PH0PR10MB4629:EE_
X-MS-Office365-Filtering-Correlation-Id: 439b78ab-4b12-4e81-58ad-08db2af14bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bWdaQXlLeAADnmOPWSCVe7Wi3CuMhmyJaHXFMFiQzIh37TkoTuXfHCDj7FFLHbvXS8mqh3nZ44o7JCK04dXExZsRkd9ePDsEd6n0kPSSwDnrabsiXKwFWNYVnFTT3WOPlKwVFph7uzjk7VS/w0C7/URMiiTsH/E0wS4SMQbABZq2aD+AgcLRqHkhnp0ViCLD3aGNKKpWSv/pYsNQKaiOdZG19CdKas0lSRqFlQd+DQZwRaTRPt+xUgfNI08TvAVz696uq0v0gyeyGrj5kRA2esKQ/BykfY/GdnxtW3P/WtLCDrVI1uaTcpuDPLNfMv5f9aWee8VaKO7bd+wu7Tls7MeuOn247Awi1Iv1UP821oT8VtPQGnHFMsah1NxwW/pKO0Sd4pHUzqDOhyfeN3IW8Dy4G0NGZmxlj9/INC5LBvlAdkMKyw9lPJPnq9BpIm8kTPe9DBeR4PDNvpTNrTsX7CQuiII//SI7TMMeqADQxfhoPr2sEVhwGS7ohbTRmgOq0nuNrWivIaiDMOo71uAieFNzolFDikHcyfVJF0bZ4KfUfRv6RXybSv72vSVkj2nZMvgElGmgYE8LZ3CqDJvg3FGluflCit2UJGn9GH1x+6B/cXac4Hy/0LwNtHaPCtMkhNIXgcKXwTvQlk40zOKXAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(8936002)(5660300002)(7416002)(44832011)(41300700001)(38100700002)(86362001)(36756003)(2906002)(6486002)(1076003)(478600001)(83380400001)(6666004)(2616005)(186003)(6512007)(6506007)(4326008)(66476007)(316002)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7Lx9jnBbX5lnTqYu7NBq6SszS6QGZqSCAFBcSdF5NyDgcCRJSSMjMOMQ8OG?=
 =?us-ascii?Q?IVHr2MVLY8mUBOnpBg1AHhnCtCKi8YFSW7bLPbiq0Ybw0LCgHffst/nX7LpT?=
 =?us-ascii?Q?OMxArTmwJsaQplkK0UexJMn1PTq8qcOCti9SkghzIiS5IIHA9O1ixR8ExA9S?=
 =?us-ascii?Q?5zRus27+OE18GMoVC7JrJAGnW1EXlR/cYI+Qj4e8MiqvVn0wu4dU7kdGYpcR?=
 =?us-ascii?Q?hePOJaRswCAAG1SDeiKbyhz68vzCbBHNHBXRqYk4AC/g3jVT8+6UbvOePl1A?=
 =?us-ascii?Q?F3GdAUb/rQL2kW4ScSqQXtvX8t3217qQFF/ULQ0qlj27e4v3s0EtaoF+E1QU?=
 =?us-ascii?Q?GWfIpMGEv8+wvWerCod0FsHnjqnY4omcBAdvKiuwlmgHp4qdrBu1w28v9rXV?=
 =?us-ascii?Q?4XOlCfNpauF6mcnrzEgMQQ8MsyrEIC7EDEhubnV6z22cy4E1Y82z2DPLHgYX?=
 =?us-ascii?Q?AXFn4kIpKIzrfhf/n9JGhm84xxfXFxcKErWoMYN2QN4oB3oA2up3VE7qeW2t?=
 =?us-ascii?Q?GvseAz7A2yuWJ6A9ggOU1MNz9E+zBi0IoROxPBCvFWi8PckOouSe1kdJPwxD?=
 =?us-ascii?Q?1sZxIQ55kMV8b1rRUf4Gjkl9EbHPY0epoiXnSveR6ztX7O/JWnXl4gfvMUcj?=
 =?us-ascii?Q?JzKzV0mTwnSrXNzEEloAho85H+byGS3YJyUMQHhf40infuNIsTDIFvTZmnT8?=
 =?us-ascii?Q?bLyk3Qcep4sFbVHB2pZ/FQHpB/a+Tz9fp17478aOR8DQvXXvr7oISghzZSdE?=
 =?us-ascii?Q?i6milEkWoL+nyGUchLXe57/JHIVk9tMv0wwkbTkSJS/PxhVXZICigKdWyPFo?=
 =?us-ascii?Q?PXDLqQoxt7U4kTt8pCMcK5BF8wguGQC1EMP3BI3tDlpJ6Z1ARSQ3iQz3LDTd?=
 =?us-ascii?Q?AXpibi+7Oc1wPIOcP2szzUAND84m8+/1ZZtc+JCAPcTXU4zjvFi+2wptnh6N?=
 =?us-ascii?Q?x76JsF0/V1VnFx148A8rOuC4EdzI2sVI5Y/+yNoU2B9ZKWxZagiUAdq50Vsd?=
 =?us-ascii?Q?q1H82o1OQsR+BKH2xOQaA0dgNo+vqLZCCrCtZk24OwjzYvjF8w7TUjcDmEeu?=
 =?us-ascii?Q?cbWXj8SM2x/nJyuxW4lzTCzDQILXo6+HUCeYPLdCqOzHpBr3GVEjI4dgQIjZ?=
 =?us-ascii?Q?QcfrTsia/JtmxMQIDMKZi/WJyngNdBAto1mN6DV4B+Ry63XjfuOMJy4BvUzB?=
 =?us-ascii?Q?WIWTTXGOHYYTRd6RWaDuwbUt77yrxREJVYQ2U/6ESoPK0JMjtHSH4XtfZaJU?=
 =?us-ascii?Q?Son0/yRCRWhms0VK/NdcxlN4cJU4JWMMbNlUf9NtB8GmbubUJuwzT8h+ONCL?=
 =?us-ascii?Q?8GC6+CDun5xkFX2X9LVrOjCgIm3UcsGLYKCpyIU4TIxM3thEn2HwCqqy/w63?=
 =?us-ascii?Q?ETpN9l7mge7xhN+hIeRzfMSDGvbVKv5axEsI0GypUSNBP9C+TAoloY1iqgAR?=
 =?us-ascii?Q?PTmf9CR0PF2BNC36Bwxe7CN7PCg7z9pPAqWjvZjrXlr1h+9Ur8ZJ3q4k9l4w?=
 =?us-ascii?Q?/FHRHIQ96GMwJjiKXWR9O1X0VaP8yZtIkOsosPLt7EiiBX+HQmdRajp3bneN?=
 =?us-ascii?Q?aCXI8TpUH7Z13mu0V0ntIMXPNOqCzYkqTWuaKZnMURCUYxQpJshYT7V8h9br?=
 =?us-ascii?Q?xiN6Xm0sJ91yAxsJhCV+6mw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VhA5L6t3hhM2Nl1zJrrX3kPIeF6vvXOfIz/tOGnxKAd92Fki/QGqXpOJIFnl?=
 =?us-ascii?Q?ClPqPCk1OIf0VpIwWBzzGai94QWIif2BJyEYVRA9wl1Eg7ilVhboxQyLk1cn?=
 =?us-ascii?Q?Ki0S3GS9o0l5lLoCvBFgw3DEeTh+bOVPCErniZuvXUuedJswgJyw7zjhuWuw?=
 =?us-ascii?Q?DR7396eXmNzM1Tfw7yBPINB8m7yZ6RykMloq6xzIBTdw2/dPkr5l7UoF1H0t?=
 =?us-ascii?Q?H6lOzQyr76cT71C587yaZN8oRlW3z9iiVkQxFkQEK6cfxlbQK8Br1K7ZlTPk?=
 =?us-ascii?Q?W+GGzHe48RxNxEhAKSyZ8Q2oUJV4ukG4pp6fHrnWWtl35jY4a5t7PV2jB6GX?=
 =?us-ascii?Q?/uYWwi8hnn/dKeSWFVqYrzwHZsSIs/L7j19Yyjfg0KYOEpEI8Cpul+uyVm5h?=
 =?us-ascii?Q?QLLtBxEku+0IC6Ra4fganFJuDzMOzI9mhZANNIpbq3VS8H/XJpUDx7hwvgUx?=
 =?us-ascii?Q?7bdUtkJV2mrHcdWz4WIGETxwGJr3btaFBOmIF4ZotMqPbLW7pjhjPOmrawyW?=
 =?us-ascii?Q?D+io6gihV8+WM37yInFFuKCNrtd0VXOSikIbhtRjK0bfVv2tKK+W64NeiAHk?=
 =?us-ascii?Q?RsichIq5aalYO959dNLieitw3MRo7CIkJnKtstfiKrWsy1Ws4+WLFYZ3nla/?=
 =?us-ascii?Q?HjqRJNQ0eSKNW+AiWNBBk4fd25OR9TNoI7L5b9SibgaiP41AOG/h8OUZ8U4Y?=
 =?us-ascii?Q?WbSgvGqR+paDLsNEqtSTzQi2gpbQzfK5LOksrarl8r66bp15YWLdXauH+1dt?=
 =?us-ascii?Q?VOVxn0iTWD8zktKI2zdr6v52Z/8xsXfVKUh9vzdtOoM6ZZEae57pa/hjB7z8?=
 =?us-ascii?Q?McwW2t6uOPR3z6ysdRcuu+th1aTPxgpnfqF6xfKMS4S+TXaae9I3ssiRwE7D?=
 =?us-ascii?Q?Mt5WHwGI4TL8zKssI8N4POt18Zc2gGGDIv28vHKHNapC8zyPQ4IENs8rBOze?=
 =?us-ascii?Q?kFzH2h6XZLsogLnGEe8X1aGB/IGYnV4gsF9koujeB4p3ySQojgez8+peuut7?=
 =?us-ascii?Q?34svh0ZwvQWmJD61hfES5Y3W2arkmftyz7uDteyXvyHxUYp71AUKd5A/oUKu?=
 =?us-ascii?Q?ncMY/XI7qfHymLoFjlYS0wDtob2V+xRgWRC3SbNBP95TA8h604S0jSx3fXZH?=
 =?us-ascii?Q?trg2hU+IhPeA6EspjZlqKIy1ODoQ461R7iJafoZOEUMB7/9MIppPGdioPTZI?=
 =?us-ascii?Q?bvBdinwjJWJd4scZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439b78ab-4b12-4e81-58ad-08db2af14bfc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:05.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9WdJ1UytlGOVWbTpgme+VZMizvAIZx1ejrbkbfbS+esH97iIYlBC9+GY8PuEWT/171310h6TBRRasgobpDOHLzkK12cOHbgJZTWAnNnNys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220115
X-Proofpoint-ORIG-GUID: 443YgxKx5JioyAj98dJSt6VpllTVFru8
X-Proofpoint-GUID: 443YgxKx5JioyAj98dJSt6VpllTVFru8
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The kernel test robot reports undefined reference to
public_key_verify_signature when CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is
not defined. Create a static version in this case and return -EINVAL.

Fixes: db6c43bd2132 ("crypto: KEYS: convert public key and digsig asym to the akcipher api")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/crypto/public_key.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 68f7aa2a7e55..6d61695e1cde 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -80,7 +80,16 @@ extern int create_signature(struct kernel_pkey_params *, const void *, void *);
 extern int verify_signature(const struct key *,
 			    const struct public_key_signature *);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
+#else
+static inline
+int public_key_verify_signature(const struct public_key *pkey,
+				const struct public_key_signature *sig)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.27.0

