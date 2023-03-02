Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451556A8737
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Mar 2023 17:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjCBQrj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Mar 2023 11:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCBQrg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Mar 2023 11:47:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71703497C0;
        Thu,  2 Mar 2023 08:47:28 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322FDtvX014359;
        Thu, 2 Mar 2023 16:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=a3rDgUfHr+TMTCK6vinBkUYrQXE8pDjXK6P+0GHXn692u21ZaEGnHzJlMS3GSKa2vHxG
 QN//RxPqwDwGq0nRu4bo8pPct7+hU+FQuENwdtYGgg5apJ5JPlAoPkhN/ri0BOWVacNm
 FLZ7GMpLYgPysyvMOlR1NEhJjxKl8Dm+TnthKdcoDVYxpBIIuleHW1bg0ShS08hpPxqu
 7B14eq4/6V84rW69pu4HRDTRMNlJTXz76Jqmif5oLGtgdkDHH32haCtQI6EZOsOBwg6o
 qHFzPm3yZeYTLyIvzHjzV1g2AtcLO/tSO2a/RJO3jq9U5Yq40pX1ftPIm3cYpn+/oNSQ Hw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba2cfpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 322FWLhl031228;
        Thu, 2 Mar 2023 16:46:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sh4g08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 16:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRc1yj41o28BoyS8B0gdWCC9BcVF60nK/NltUosGfkgPOXekMc58VBLZI7qNsjds0SR9vKuzAIDwd+GjtazUPMcusyp9gnH7kY53mZ64fGgccMVAU3vyNWe/uCGSaMldGkV163nnfkDqP2kJlh1+PbSoFVoV7sdCFRSjm4rZ2mJTFcn1hGA3oVfKoy0wzuF2B3o9ZGvd1lCWTz6sFRxHkBV4NZm8cQkDbCYHFb4abqNnVw2HjZI4VCqsEW9kF5NMQSHvDb9585yHxuTXPCaPAqL1f//NYUmmWfv6c6d/DAIhMuwhui7fXsNRf7hj/Dzur4CRQZdkP3s8EvS1RVkFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=L8XGycO2A2yq52ShwhsecTcw/Q0kJYzskdb4H8TqUYxuZvxvxfZbsy9MNaUki0UsfPPzktrCGIS97LBehHhrmsQdfpLl66iD/+2izgD7L5QeXSSHmrgD7RATSKICtx7SZoRzrxrgy/fWGIfZ6Sfe3hYX56lCV4RKvX/4rZQKICcjn2bQeLsCnFZEMAufQ+XNAe/q+AKBJ+QR9F5gpXjZ0d2DtaqcZZDvdua9gDJ6qDo8gx3BZrlyBD5MY4KqMKsRKMv1u6+atjKrDTZ5ebxAazlatMqwvHlcXPN0nh8woMyTUzQ0m4fTBZP/vEH++g/awaTdwsSP/COsjZzxNsHpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAQFlTExmc++UK7mNtjwpUj5omxprR8upvNl8wEq/GU=;
 b=UYEcAGnDQbi8lhApMmdX+9s5E1Dj6WS851KiaK1sE7GCD7rbQ38qZpoHMeqptOeJ+5lXKnl89f5rXhvE+1WVz+EoLwwtIKYU4+OQOIyh6skxxOtTsIU28T793/lXAb5p/rFaIs3VAmfMhwQpyRT880GC75NaIERw7kr8YhBztUE=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by PH8PR10MB6357.namprd10.prod.outlook.com (2603:10b6:510:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Thu, 2 Mar
 2023 16:46:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 16:46:54 +0000
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
Subject: [PATCH v5 2/6] KEYS: Add missing function documentation
Date:   Thu,  2 Mar 2023 11:46:48 -0500
Message-Id: <20230302164652.83571-3-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230302164652.83571-1-eric.snowberg@oracle.com>
References: <20230302164652.83571-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:a03:167::42) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|PH8PR10MB6357:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b5229e-f4eb-41d2-2da3-08db1b3dbaa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWer0xXn8SoguGJjxcFigHTN272YKiWiWxZOqLmVVTtYmqYUwfYM71wRDp0SMLxDKxGz7Kw5OG+5ZT1BaiMj+ejO2U8oris7bbX86Vsd71K1xTuYPNJmspdXXh3Iv0wraDZfVTzcKFxaGiBLr8tV29YyElDjbN0uDMFVsN7iqXbV7LOe9x1wRt31H4rWWJo2P0vpfRQ7qDPbCPpfyuvy0CyVb7pZiDgoLOZWvNG9s0OXNrJ2RxjkrHvvmxW790PMjoW10FZykZi7wR+DvwDxpScXKLeT/hBO7zeoOf69e0cITXSafVzIC8LRmWFRgwbXPiLa7G8PhUP2OLy9H8s+GQmZ3hjYo7knMr6TrNRZpvzf2rIf15MO2mAGnpaQDk/TYHFLOGnmz716K+s42C9OPIVfdJBxOAaZZVTn7jNyK9+yCYd6pzoyDC5GE161BxHl6+R9RHTlX0E2f+HhtMkigNnRvOZ/Hea9ZDcQEBRdLtCZb+PhwxS/Y5t/w+aGvXgb1nWq06j5JnCLZLoZ5Mtn2PknRSWOoEeIOfRS+j5ePwLx33MFUAw2gL98BVY+ASGZuULVMLLZ54+q48hvpef6xRQWwLWG3dH5vUEMrwehSgZBpd4YtNHIyWbUpuixPq9ZKnuObriwon2rR7qe4KhrOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199018)(4326008)(38100700002)(86362001)(36756003)(6666004)(44832011)(2906002)(8936002)(66476007)(66556008)(66946007)(5660300002)(41300700001)(7416002)(8676002)(6506007)(186003)(1076003)(6512007)(2616005)(83380400001)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5psdT5f7CJu+//7ePk08DLxcLC506tvFtVFM6/9y5zlxtIW4EnQBW/TJ6NTU?=
 =?us-ascii?Q?ZMPshkWnsfVEfSTb7eNabemOuk7USLem+yxg1yivQjMI5+3x/fsAupFh0Z2n?=
 =?us-ascii?Q?ztWiqMqatk64yTc5ZOYX2rm8hGTdyYNmr9JU8r6e3+SYNZWCzt79Xez4xkgD?=
 =?us-ascii?Q?WQ07qKG9J/lxJgVnUbzryaC4CWB3Ts+mtZN0V8twVz2PjY6anGWK2WfyQNbz?=
 =?us-ascii?Q?bXfd3M8G3yr7TBoOtacM8PuLPotQ3D334aqqSUlkvj2f3HT/y8WcecjEwSaH?=
 =?us-ascii?Q?7jijrr94pxsJbtxkXNGQy6JDGLRB+Ue9rg9+jvcqvHnJU3TPdHvvHlvzl8UC?=
 =?us-ascii?Q?DQ/YOldb1R6pBJUMn4P7VBZHXEcPQP8ivYpc7KS+tgRbVFeU3rJBPZkTIAeY?=
 =?us-ascii?Q?uQJzisWRyM6Cn/THjf7OPiom+rdq+Hiz4cETLgIVSwmwXFFSWsyTOctbcqpK?=
 =?us-ascii?Q?FAvemKsa6lxRjTNiZGL2XsM+w54knJ72p6D1OBRXRGkP5SP7fDOY3fg4seut?=
 =?us-ascii?Q?kQDZC/mpjCZkz3voF45Cn6X3zrWX+jBpLr3vaUiZthMXal6QOSPnm5624bFk?=
 =?us-ascii?Q?Q59g+I230E0q+Pau8k+D8rBSVGf/PXacuMEa+daxT1CGLx3XcqPz3fm5vJoH?=
 =?us-ascii?Q?rjAV/LEQ7r69aDdEz6ugA4MGoLZm3T74+tEDYEkaWlMmb3ClVCQHQXw+S72Z?=
 =?us-ascii?Q?sW9b0ZEDsO7/p0QlKWVlbc/iZlLLw2+5nfcRan0ZHD+tTonqxnptiqXqxyzk?=
 =?us-ascii?Q?+5GCwQgyqCz8E4M4ZfDSFCBPV/WyIG5og7J86t6E2yVi0Qmrkfjf2QoYz9zo?=
 =?us-ascii?Q?24PaR2L0GGcvnE6qMrsxGWNdWj9J5EJL36U13s00/ZCdjjWp7k5zNh2Do4qI?=
 =?us-ascii?Q?xWXwZPwBKkV9WNnx+wmuo2FpCZ2804qthIvZ0BNbgXQibBIsuMZc4rnArOP4?=
 =?us-ascii?Q?uzkP/+j+6FX+z3VHGwmMwCjLbplZfFI+31sBw9GqzBXvQx8rsSE6OVDmobov?=
 =?us-ascii?Q?7P7nLo9Bkc9uv1vwit7bMyDCSh7RYgs6u+YbZ6mC0AmCMmVg7U1RWPARNB49?=
 =?us-ascii?Q?46bzd17FYv5Tcas4AqjWtWt2OVKSGLCBDgwVfrVVFEF4SnBc709WjB4TZlU4?=
 =?us-ascii?Q?R0IYybL6nuryEUXmjTixCzmyXVhpJQRC+GnSbOhZraIolQJwYeII9ElMb8PC?=
 =?us-ascii?Q?4ZJPy/+SFc7ekuCG5GBN/f/1BG8eAsQr2lEpN8o6cCTS+4ulwe6907iqkSwi?=
 =?us-ascii?Q?YKm/ajt1QIx1XaS7Eaj1IJGp9ixX9ns9Q00SQMG4DrE7+3qH9VDN+kEw0SJT?=
 =?us-ascii?Q?/mTG2JmNcrfGfa7HfihKV/hg5lVOpT13IMmc0t/Zc5g+rXMoms/JQfu9EYDr?=
 =?us-ascii?Q?dcdaPJny6c3NY3ZAZ5VcSf27+40QNp7aeohYxjI5JcFyrDq3e22RdfoRvSxY?=
 =?us-ascii?Q?QMZW1FQTyRErrzg04RaQT18TMvBOoK9N7xRXqIHHJ7xV4uPyyqRmlkuYsAxD?=
 =?us-ascii?Q?gHdz10s32FKbrDmnNVu2qRbjUjRwdFzwcP86RtEfUPqlw4AcXkmhx+sisdEu?=
 =?us-ascii?Q?/Swz6PYw5wD/XKvu0zI/W3LqKocTAwOpifxBdPSLPaYe+D64G3st2rKkwS0B?=
 =?us-ascii?Q?JmLHrPkiRcaUHX+4PyTghY0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TcEbQqAhBSMVzuXDQrOM3nYs3hrYNg1sRfWivjcCenycNUL0eAoPnik7vG7M?=
 =?us-ascii?Q?+6lBzLGIFtEKveWRJIrNHgKhwLjVMMDfvaUn4kizSLkdFlv63bHpLluWVTt4?=
 =?us-ascii?Q?JOVKTNhuZwNL2NTBct7p18LIw06ic+fGi9kOT/ik6QCWTfBmX/Xxv/o++V0S?=
 =?us-ascii?Q?r3HxFq22dw6Xdbwuc+Uw1hyRPIk9QL8uG0LmUkQ3cH2odCYzOOwadTFrM1Ez?=
 =?us-ascii?Q?gJNUssdF2x7Ht8Cpp2t25cMHTxR3PMgvK8dcWxWgrN8MgsR8/RnJc9Efeh+k?=
 =?us-ascii?Q?K2Aasm82/T41cbP7/bAcybvu2ZN8J2rmfh1/jp2LnhB+qUTribSmkJr6TyrP?=
 =?us-ascii?Q?eE25RHkfYWvTOXjwwcuqTgS9f7B0ptEqHmqXbL0EQ4kjdv0sRFGfYDIbTNLs?=
 =?us-ascii?Q?Kd0KtoZkeY80CDBm3UvPpvnJDpuoTdHm0dL7GfpTP7wrdttUQBGUCrgzYChO?=
 =?us-ascii?Q?/Y9cc18DEkDumkAAdeSUNB7Yv83Wuxex3QibMiekMPm7lWgE4dfeGHhDA9fj?=
 =?us-ascii?Q?Qv14Yi6Y4nG66mvAmMO/xgPriP0QhZuTkbCvBlD+5dRRzPrk+r++SFzZAPwj?=
 =?us-ascii?Q?HXWiN19/PcEJ+FOjBbLgFNfB6/QbX5fpA89hbZcLnBTgrY0h35rWPXYhGUcn?=
 =?us-ascii?Q?B9Wgr0XO1lw9fH3+GQvu3PRUmVd/I5rGzSUcvGRZODY7yDMxzPmQCgUF7TkT?=
 =?us-ascii?Q?1yr0aaUyR9DtD7Sg7iO9cKI4XxBfpqPV/9xt6WKGSMvkhk5KXVE2E5vwtVGp?=
 =?us-ascii?Q?04wFGgCUpN3Obhd0VWpL6SsTnm5neCi+CBJEzeWDVX17vGbhcJojs1BIHQK8?=
 =?us-ascii?Q?lm1NmTZFpzRM9SXPOJkL5FiJfm6dKHfvjqi/hoGbX1VlNVllPrBZfqNWsuKV?=
 =?us-ascii?Q?KasKgnC6lhIzY0rJYsgd+uRixK7qwhSH0N9F/GpTjZbxmjoFbdqyfb4HoS/9?=
 =?us-ascii?Q?cWUNU1MhuaZCgRmxXMKKu5jftHVPGL+0ygb+eh6H3mKeo7JNB9R7g8hyu3tq?=
 =?us-ascii?Q?gAs1RObi69HCczDRqkcoF78g8wgCXTGFFOXyogUNY+G1L+VuZ2hVr6dKHgS4?=
 =?us-ascii?Q?qIPUsBXswHyvGBMtr5/Dp1ZBBntqI97lbG5ClUIZMySEFZsPs7GLeOlwrGnv?=
 =?us-ascii?Q?pcwuuH5Px43iZx0thS7b51mCxw49hRCnP92b9GcjOWkBFopLvVo811g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5229e-f4eb-41d2-2da3-08db1b3dbaa3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 16:46:54.2673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQb795H4x9q3Kq3V5YSy/0ZTXXIrcJ5p1cqMj7rVY5ho2v09ZI/yCjlcVycN4steCv2ZJn1A4Vj/aEYKb6fyExzop87BC+VGWYcqi4lAmN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_10,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020146
X-Proofpoint-GUID: pQ332Ev7yNZ5sgl76UKGJB9auOR-6hjw
X-Proofpoint-ORIG-GUID: pQ332Ev7yNZ5sgl76UKGJB9auOR-6hjw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Compiling with 'W=1' results in warnings that 'Function parameter or member
not described'

Add the missing parameters for
restrict_link_by_builtin_and_secondary_trusted and
restrict_link_to_builtin_trusted.

Use /* instead of /** for get_builtin_and_secondary_restriction, since
it is a static function.

Fix wrong function name restrict_link_to_builtin_trusted.

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 certs/system_keyring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 5042cc54fa5e..a7a49b17ceb1 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -33,7 +33,11 @@ extern __initconst const unsigned long system_certificate_list_size;
 extern __initconst const unsigned long module_cert_size;
 
 /**
- * restrict_link_to_builtin_trusted - Restrict keyring addition by built in CA
+ * restrict_link_by_builtin_trusted - Restrict keyring addition by built-in CA
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restriction_key: A ring of keys that can be used to vouch for the new cert.
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in the built in system keyring.
@@ -50,7 +54,11 @@ int restrict_link_by_builtin_trusted(struct key *dest_keyring,
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
 /**
  * restrict_link_by_builtin_and_secondary_trusted - Restrict keyring
- *   addition by both builtin and secondary keyrings
+ *   addition by both built-in and secondary keyrings.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @restrict_key: A ring of keys that can be used to vouch for the new cert.
  *
  * Restrict the addition of keys into a keyring based on the key-to-be-added
  * being vouched for by a key in either the built-in or the secondary system
@@ -75,7 +83,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
 					  secondary_trusted_keys);
 }
 
-/**
+/*
  * Allocate a struct key_restriction for the "builtin and secondary trust"
  * keyring. Only for use in system_trusted_keyring_init().
  */
-- 
2.27.0

