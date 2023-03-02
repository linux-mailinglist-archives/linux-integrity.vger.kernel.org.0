Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786E6A8749
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCBQrp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCBQrh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4DE57D35;
        Thu,  2 Mar 2023 08:47:30 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FCjIL004981;
        Thu, 2 Mar 2023 16:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=mk7czw9jc+Rlf7Qxbe08muBQWZadm99m02jpV5kbr/M=;
 b=0UZXg4P5jeSiPYNkqTUjXrC5VHFZPJUCqq5l++sk4qpyi85rNpRUIzPgRsP7AuTmjPW4
 FeEw/Iwuk7nY5/aJiOVP0zocnHtzmMHfNc+vN4Q9iwPFQMehZVTVEniZ2KOzn7UWWSN6
 asNte3/CpvhD8Q4tv+VQ7puzD3tK3zaBpb3DgaBshHy7CftzjdexvFsPWYkf7Q9y1CJd
 HXokz7Wv6DFEVw0Y3NrVgoRxwT0PEOr0XXwGZOVGFHO0++9SHmI148pmqOGXmGpWWACx
 9AN4/U4rPC0zWvWeaJEsGIootnGHfg+Wm3FezHNfbEtRUZUoqIwzlfAVpsnkRfVXFW3R oA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7maej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FTkuJ033023;
        Thu, 2 Mar 2023 16:47:08 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8saa221-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsR3OUjXaVVlKXmzqNtSg3TAPwwo8BieH3V5lvFGPKoV0Tem7a0/1j0PshmxMA4tK76lCOrBJojsIQtmAM+k3ywKmQRNR4hjBFMGIaPdq3MoOPxjhSctyEb1yBnVLZZEZ85FaNniOUELqMDao8RFEYdNI/7WrFiwwiXs5KzyjNSz56ZkHpYTaL9pFShPaTfs5eye2HXzu+7PKXubL6EULSYZdJAHdAEdySOJXilRV/l4+TdZU0/jIacP8doRIho8MfPRwplkiSIyhx0LuAu+0FbPP4kxkhP+RaJpi7kVIrskJbevx/8+pqkG3lrJ3EEK4neUNWP7XorYWTCO+72Bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk7czw9jc+Rlf7Qxbe08muBQWZadm99m02jpV5kbr/M=;
 b=LoAQNrKq1GaoepXMfOL6QhyQZzsRhn8+IBTailuctlH0UseokyvbYyy2BI2NA4rg/W//bgD9WEmY7Wl10K5h+cYuE8TTlYwcuzopNi3ADNd713+b5kAF2E7lmVkEoxBClUd0pArutRw+tRQ9hCmFEt13mMu/w1QTjtxMOr53/DCnDl3vXOVaMkDz85nuETxKYtzigCM2+TmficwZsB0ndgo3H5I5U9GSP4Z5S0DYcnplrWrjVf5k66JJrkm2F6/W3kqFV7+AKXxLgiXSszBXq77G0utWiSMHYZmndsHFax9vcSkeVnQshxFombSlr0xkuKwWOa04KGPugH1iv4kBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk7czw9jc+Rlf7Qxbe08muBQWZadm99m02jpV5kbr/M=;
 b=BgFIAarAPa3wkUgP8KJwHrXZbCJXVdVg2hK1f0H4ZfQojvmNHXp42xc4R+QfIdO+JIDZxKsyA6rcl3YmA4uTSm8oDSDG9sf/tzzACcg97nVfvGCIxtqWK4lEExtn0oNnrsmnKDPPpB0sWKjWBFkGnZOacqsv+hbPbBTlVPJKSzk=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DS7PR10MB5150.namprd10.prod.outlook.com (2603:10b6:5:3a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 16:47:06 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:47:05 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     jarkko@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com,
        dwmw2@infradead.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, pvorel@suse.cz, eric.snowberg@oracle.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        erpalmer@linux.vnet.ibm.com, coxu@redhat.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v5 6/6] integrity: machine keyring CA configuration
Date:   Thu,  2 Mar 2023 11:46:52 -0500
Message-Id: <20230302164652.83571-7-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0006.namprd13.prod.outlook.com
 (2603:10b6:208:256::11) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|DS7PR10MB5150:EE_
X-MS-Office365-Filtering-Correlation-Id: 187f25bf-e5c0-467b-c014-08db1b3dc194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AzsOzBmwQTCJv45itIOaTQzp2scMOtPEYyZthFDgxKs7r4Gp/wAIUaynPMMfLxf/PaL3jftQ4hgzbhnRxBkOjhiFLgIUGmP4LgM7rvu6l/JBHtHspYaxmy0Zwr93R09eJexZTdUDMxolgIuAwp+tf3xpvBw79Wfpau57zQ7xbQprzItx3eC9AYs+lTCmedQtGB8BOkngv93IMDr9cFIdvdx/sMmFPy8HCJMEGbZ0ZmAtC6z1Www+oBGaBrhkjNrZow0AIvVXAHiskpW48S7jDfCVVTmv5hjKn7tkXd07hAKYizkfR70uANXz//oDnjLf0DHrcjM5WdcfefqN1age16BK+5vZ6ZlgyLgzOmIygOLLsabpxaLSPfaO+4sJJzPzFU7p+AkN5CtGuzT3pUyYvn+IHRQNwv52/QVFm5ncPeWpRmYNjxc+lw8zp4RcKzw5D70x8bviypas5vHpwhiwDwUWkAfz7VOkqpKl0mJsMNVqB/zpw09FnwyA5qVgpq3kHL3cuRu7fAV/FfxeFCmdzjyrY7DAklW/sKRStRSJxx0+zpHaFIjX7sJDzEtS2DVmj5GZiHkkRFK5gkozDBR/Y5csj3Oc4UHQZ7bAtzPHRWdI74OcPrC7AQeFCogi6J3wlClKSVz6KDd+MuH0lTSdNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(36756003)(86362001)(8676002)(41300700001)(66556008)(66476007)(5660300002)(7416002)(8936002)(4326008)(2906002)(44832011)(38100700002)(6486002)(316002)(478600001)(6666004)(66946007)(83380400001)(6512007)(1076003)(6506007)(2616005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A7+ORA5vWGScfU/HQ0SAQAv+Fc1ZQpGNdpfYn57+/iw0FGP74x24tl0pvZWE?=
 =?us-ascii?Q?GnTjAKrcJHxn3zbyeuflZw8qrlwAnODdVzs4VhKvNxFH5j/6GSc6e5PxYtvV?=
 =?us-ascii?Q?++dhJ2c4AfegYRl1f2N/tvE9wzxIzUQY04oAkUYaK5qJETwni+GnJtwn4ksV?=
 =?us-ascii?Q?oNXxKaORTVBAyEGkECJXC7nuc+Z8OIBgBB89WChyCvAGMnQY8sa/OZF2lgkH?=
 =?us-ascii?Q?47wveRCyD4uGPhN2XJQuxJq4NigSq5Pt+NcoRg3JhjyFWMamJu9+d526hdXu?=
 =?us-ascii?Q?OWZOgt730TJZ6EliIf3l4SXlwrWfGst3VnxOKaskzjU33Ht2sbQ1wRQuv5DT?=
 =?us-ascii?Q?IxqbWV35YZxco8HDieXH2tjCCWnqFraP3F1SdlhiwTcLapWg73TV/NF1k9He?=
 =?us-ascii?Q?iUmNTKZKfqQes+aH6EvmxzJYzLlo3HLs40fmOpX3E5bJ+fJFMRZu1x9/f+9+?=
 =?us-ascii?Q?Trz1S09/qGDvDltunPeGwbdjiOATH++F/NyxRCS6/neNZPBtFvXSpPS+61WG?=
 =?us-ascii?Q?1xH+y0NslfEIk8kb1kVgha2cciZw/WtvsOtBRAiHXTg3BifWYI1ylxAVSnQF?=
 =?us-ascii?Q?rs2cnAOVKvlqqhTJGmlRy91BA8giDczOkIdnW1cSXaiYt5ShCXpBLNp/sag6?=
 =?us-ascii?Q?criJpTabZjMlIk4HQPWcHY7VHDl7pXrGlwtBS1F9Gtjbdq7ynYY8vpi9xS+k?=
 =?us-ascii?Q?XjJuVDFi/kSF6j1fFE4XRqPB4nfX+dk1hx/I00lFcAjHB/zdRM8jX8/qtiyh?=
 =?us-ascii?Q?5sCnAVKdnkip+YRth+rbICIjVRs7rP0eA2+xO6sX8fsSQo8QsxQkTj0S4OUY?=
 =?us-ascii?Q?sovg1epNiFM8Wyhn1OJvM6pz5UJ4kgP8Gl9fLhvs3nJxF2kfSLfBaEa6Xvdx?=
 =?us-ascii?Q?7lOq1KH7YYeBVqc8wcWhPhpSx+2X8NxrpPVnnbGZ+QuCJm1jY4CjsKl1lQ06?=
 =?us-ascii?Q?mOiirOAw7V8ng0CsX/MWgD9JJniveW2wJCXkecnsfKgX7S2vNxkhEy+Dp6bs?=
 =?us-ascii?Q?f7Mg+/tLLyTu9lehlDR8sHCsp++CWKacpczn+gZHaq/QBjV1XmCEQdkyY5Mv?=
 =?us-ascii?Q?SeHXCxEDBmz8VNGXLcSMFAqS1IDDI6KvCRPSPHTFkI/CBLN9QzcWOnJR1qMC?=
 =?us-ascii?Q?kHR5YTWN1dE187LMJznssL5olobFvCL0DFCGSfkcgKmUQvkhCtZdVcUc+nuu?=
 =?us-ascii?Q?Ly4S2PFBg0WmQNG0euFflHhCGjnjcqBWvp5biKGxxJwOFZDqAZxosU/eMFct?=
 =?us-ascii?Q?DdaohXCme9KeFM+C4YA0KpBRO/Og3redHlJM1d7SOAOjvqS4SHd5zgyaDv1n?=
 =?us-ascii?Q?+Lgne7Esff07RAFIluOMlT2JUd66YGCvAhRIA5VsB3x3DgtRDvgPsFyE4MfM?=
 =?us-ascii?Q?GXaPHUe1yTQ439BdSCgBal4o3FKJS/sW0ZSnCf6wD8esRefFZcG+1dL7c455?=
 =?us-ascii?Q?fx9hWUAgNZ1lUwIqYPfV995hawTHL2CGbqU+lKbjHdKVVKI1Bt5tcEdK/3yg?=
 =?us-ascii?Q?Lts5fX3gc79dNzymb5Xe2o21CUKNspkeOFKENTc8dPpwuwavD6PvmAdQKAMC?=
 =?us-ascii?Q?eIZT4cyyoU2D1WvSCOwVoxwy7VyHh+RgtCB8TmgghgDy8haI8wroOPQhOzSp?=
 =?us-ascii?Q?ZN8+MsouI4gkk/wNOxIChmk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?lmKOpgOXjaXEzxrKxKZ4TS5hYvI+TCBGRVN5HbiKfIDiP74YHlwXmC8eVQ+B?=
 =?us-ascii?Q?NLB9kFmYn7NitwpCSak3ug7oMVHZ3x1YgBAFXLh0LsYKB1pLe96nJ0m5BDdI?=
 =?us-ascii?Q?3lki9pUvIZOMNJoCHJZoo3CoS+dJl4BXnfcn2KlgGMl100HrFLfk6BUFbsRI?=
 =?us-ascii?Q?NOEpXlpKUVrq5etOPRbiYdCx3SwwpU0GMr6cvbTg5aNUIjcd8gXVwD5GPBov?=
 =?us-ascii?Q?q9OgB2du7jArL+Z2uXOYGDqj6T0OkT++b06C9eLNQmG+Vy++YzwfqLV/a5Vw?=
 =?us-ascii?Q?nApVUFy1sCQ4a/t6M3gE6/sa7xRfC3mqBSj9OabFRflrnGxO7U2bG3VuM2r5?=
 =?us-ascii?Q?AjUIlpNiGCW2OrIkDRWco289l4b9lDMyJAC9lGInMXyqofBOMsDDYuF56eXL?=
 =?us-ascii?Q?OgTm4OApgxVlf7o0Hdp7kMkSfO89a4r61Zj0uoIaTMsRoUiVkuu1JVunrmtr?=
 =?us-ascii?Q?c8T70OG/A7ZWpeTTidb1u4vtPNYx9jg3HKuNOeCNVGF+1XGpVvmzFaWIhm4g?=
 =?us-ascii?Q?6eiG3mng5mXiR9t/AaHs06ouvHUlSsgOwAdfJ8Qg3qsz8zEd9vVgBrAYNYOJ?=
 =?us-ascii?Q?dn87PsNysaeO3K7QNJVPE1l5eTp7mt+Gb4slIyLa0tnz5Ugf76K2VgghayzZ?=
 =?us-ascii?Q?oYTe1mbTh8UjNx+OcemsuNNjR6j50Tehbc8SYm9Ue6co6olhSi1HP1HZcBYI?=
 =?us-ascii?Q?kjINOipSx707PodFOgDORvHNbEWe1326wInNNUTG9WUVY3oyggspVQJUODnO?=
 =?us-ascii?Q?90esTe8HNLjisP8DxuwYURcYow8LYCfDZjNGBn9/OZEy3U7hzonHT0ObsxDA?=
 =?us-ascii?Q?yM8BCQjpPgTZdG/hPMGEk4l8+1BVFVxnE5k9nGvMlLV/CnyVspIltpMFPdia?=
 =?us-ascii?Q?8vFaat1pfmv+FqUiZNX9p+Q5zjOKeln5rNWSgRCfyWc5ahuQTfjqrzKoSoCE?=
 =?us-ascii?Q?bDfxFZEkpb6TehtOOhyDLyt/iqDjnulmsAohs4YB7xAz9cQzXbDZM1MofTyJ?=
 =?us-ascii?Q?L0YSsNqm+iUXQtE4tK+PnBt5ea/77aHczjFpB2UhQ1F0bpslsFN09iqlxakc?=
 =?us-ascii?Q?SN7VHI+FQG9/EAse+wfPNV6e2ZsOuEUZM2aA9d2uVEJyBEbI20patsIoLbjj?=
 =?us-ascii?Q?V8NO+KJys9o4Do6HENWZnjGqsGSsD/EG7BHec4n1cHVIvAJgWYmm+uY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187f25bf-e5c0-467b-c014-08db1b3dc194
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:47:05.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 95FCFD1G9jld4533WpCVsNxJ+RPBN7NfU4+1EVMaGfsauagaDnjXgqp7oLmDZQ9hmVq8lEvhQpsbP2dXDUo0/rXpDSSxoT0OfcOUV+ruJs8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020146
X-Proofpoint-ORIG-GUID: AjO_p501VsE0LG65sNKAClowrPnLSTbE
X-Proofpoint-GUID: AjO_p501VsE0LG65sNKAClowrPnLSTbE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add machine keyring CA restriction options to control the type of
keys that may be added to it. The motivation is separation of
certificate signing from code signing keys. Subsquent work will
limit certificates being loaded into the IMA keyring to code
signing keys used for signature verification.

When no restrictions are selected, all Machine Owner Keys (MOK) are added
to the machine keyring.  When CONFIG_INTEGRITY_CA_MACHINE_KEYRING is
selected, the CA bit must be true.  Also the key usage must contain
keyCertSign, any other usage field may be set as well.

When CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX is selected, the CA bit must
be true. Also the key usage must contain keyCertSign and the
digitialSignature usage may not be set.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
---
 crypto/asymmetric_keys/restrict.c |  2 ++
 security/integrity/Kconfig        | 23 ++++++++++++++++++++++-
 security/integrity/digsig.c       |  8 ++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 48457c6f33f9..276bdb627498 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -140,6 +140,8 @@ int restrict_link_by_ca(struct key *dest_keyring,
 		return -ENOKEY;
 	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
 		return -ENOKEY;
+	if (!IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING_MAX))
+		return 0;
 	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
 		return -ENOKEY;
 
diff --git a/security/integrity/Kconfig b/security/integrity/Kconfig
index 599429f99f99..ec6e0d789da1 100644
--- a/security/integrity/Kconfig
+++ b/security/integrity/Kconfig
@@ -68,13 +68,34 @@ config INTEGRITY_MACHINE_KEYRING
 	depends on INTEGRITY_ASYMMETRIC_KEYS
 	depends on SYSTEM_BLACKLIST_KEYRING
 	depends on LOAD_UEFI_KEYS
-	depends on !IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	help
 	 If set, provide a keyring to which Machine Owner Keys (MOK) may
 	 be added. This keyring shall contain just MOK keys.  Unlike keys
 	 in the platform keyring, keys contained in the .machine keyring will
 	 be trusted within the kernel.
 
+config INTEGRITY_CA_MACHINE_KEYRING
+	bool "Enforce Machine Keyring CA Restrictions"
+	depends on INTEGRITY_MACHINE_KEYRING
+	default n
+	help
+	  The .machine keyring can be configured to enforce CA restriction
+	  on any key added to it.  By default no restrictions are in place
+	  and all Machine Owner Keys (MOK) are added to the machine keyring.
+	  If enabled only CA keys are added to the machine keyring, all
+	  other MOK keys load into the platform keyring.
+
+config INTEGRITY_CA_MACHINE_KEYRING_MAX
+	bool "Only CA keys without DigitialSignature usage set"
+	depends on INTEGRITY_CA_MACHINE_KEYRING
+	default n
+	help
+	  When selected, only load CA keys are loaded into the machine
+	  keyring that contain the CA bit set along with the keyCertSign
+	  Usage field.  Keys containing the digitialSignature Usage field
+	  will not be loaded. The remaining MOK keys are loaded into the
+	  .platform keyring.
+
 config LOAD_UEFI_KEYS
        depends on INTEGRITY_PLATFORM_KEYRING
        depends on EFI
diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index f2193c531f4a..6f31ffe23c48 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -132,7 +132,8 @@ int __init integrity_init_keyring(const unsigned int id)
 		| KEY_USR_READ | KEY_USR_SEARCH;
 
 	if (id == INTEGRITY_KEYRING_PLATFORM ||
-	    id == INTEGRITY_KEYRING_MACHINE) {
+	    (id == INTEGRITY_KEYRING_MACHINE &&
+	    !IS_ENABLED(CONFIG_INTEGRITY_CA_MACHINE_KEYRING))) {
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

