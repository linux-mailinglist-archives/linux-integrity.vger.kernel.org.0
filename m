Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080DE6C5072
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 17:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjCVQVU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 12:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjCVQVO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 12:21:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7B060D55;
        Wed, 22 Mar 2023 09:20:53 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MCY50n002418;
        Wed, 22 Mar 2023 16:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=f04KKnVE6bf7zGWWJZG7CsnZsZq4OfQdu8k+D2doVsc=;
 b=1Hra1EJBx+mRlolekca+7rSGhMFvmmaliZEIF0588iqw/QTiNkppTJ0W+9+p4pK6GVL2
 dp4rSO+sN9CB2mL8PacveQx10JGF44wTTuY+8TkfslEWiHWWv40o9yHfhqqSh5ukLtZb
 xcGFZNKnvS0DkTmC18FYD0VK10keFUoZvKlZyvmvOAsE5r+swFlTvP4EbyyWGoeKcnbo
 aeSRioTGeWqzsg3+ZEq8q5pkS2ClBn68zN32zjjJHH0hsKiJFc0KygAmSuGLeZx9jBZf
 Gp5dgEKQVV6ktN4ukPjnp0YXcjN8SCfCz76TR2Eke0fgmAgZSqXGuH8bar7t5OVKIzXD hA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd47tsgmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MGJVlX008290;
        Wed, 22 Mar 2023 16:20:21 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pg53jg0rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 16:20:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMbDL9uDR8yJNzeymMu+zsiiLTcy2ofS8JoEsKwLyOrLOJnnL2hjiI4kYJsvyQA+IyblpUjAKLfohO4NGZsb8ruuje/BLaiVcyaEoDYH/c0lmKXrUZuHor057GUmIuUTyn+Kf5CmhDNDUH85jYz7hZwu1MDyz7CS/QP+x6ZEblqGHgP/GKTvoMur9l7auxL1xQVAU9fr5D8MKj1RScmFJCe6RD09Ixokt3KxFf/fqbY0ehkDvzm5PQK2FMJKnKDzkRZaJ2l8qE/R4ZkujKZ+bYLd5EJtCktVWy+vHF/SsrBMLxsLRlPdsVvq1dNnnVPv5XAeiRMPzawmUdlA1NGK4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f04KKnVE6bf7zGWWJZG7CsnZsZq4OfQdu8k+D2doVsc=;
 b=VD8w80YDHV5TadLEElk5YuScqdbODKe2RixOvTok3yN9/IeL24LlBvMRZabr/GHwjC02MPSdfwjbLUYQ7L4ceAUUP+zZNP6onPb7GWMgv5uIDYJpC/bjkbFUKaPJBiek+H7h/yfBTN0ibzIkDB210Aaw2eGvnmCEPryVxkAbqRRqkl//RL/7kZK111zaqebb4Qt0k+4ranVg3UHpCDZU17+8EeOeuUt6pNuDik/vqH+wZWZ0pU0dTmg8+uvc3MpP3x5llPmWXrjgsBnt0e3qRRvzrfo7LdvpNIUc7Bz3+7k/FM40xd7mA+BHHf5dR93HhCv0mmXKyJFDZ71gYZIlzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f04KKnVE6bf7zGWWJZG7CsnZsZq4OfQdu8k+D2doVsc=;
 b=PT/RYwLJdzvMzfKjhwQo3doIqapurZML70hoGC7PROfeYMg+U4Jn2jQ2c+Obdj5nBChErti0QzH6vc+TqSR+yf42E0Xg6wpTY4kJj3lgSmtqLpHM6y9iZzgAtptzCNlnBwRxwYViNkEslzIzASDArsf5WHZgsbodZOr717D6RmM=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by MW6PR10MB7688.namprd10.prod.outlook.com (2603:10b6:303:246::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 16:20:17 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a326:1794:402f:1adb%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 16:20:17 +0000
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
Subject: [PATCH v6 5/6] KEYS: CA link restriction
Date:   Wed, 22 Mar 2023 12:16:33 -0400
Message-Id: <20230322161634.2233838-6-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230322161634.2233838-1-eric.snowberg@oracle.com>
References: <20230322161634.2233838-1-eric.snowberg@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0001.namprd10.prod.outlook.com
 (2603:10b6:a03:255::6) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4150:EE_|MW6PR10MB7688:EE_
X-MS-Office365-Filtering-Correlation-Id: c24d99c8-1489-419e-4253-08db2af152ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+xe4tTNhvFHod5UXPmywBrOz9fzBh69Abc40gJXjLsZYEy7SY608T3QTbPVhvIzVxDRRQ/OG/IB1d1PzWedO0iGEwdr3FfQvnFQGd4EmRxyZQFquA/EcW+eh/LpRMzq9mJD8IfSzUjOIltPt3Ww5IGikdpgrwL/fYlw489lOfsBWLwrtCaoproIvEQ707mfqbCrGrxxut8ZUfVU0N14vfv1lLUEIYMZTq8hdDivYRuKWyOxcmxKlF6PZUrETWl8Yho16fUZSjXTkYXSQNi7Zd7nXfkaNApjRU3r2EZ/sh9jW4Pe9RrePXXa5hpu7O3+9YkOpVwkMbgQ98UD5D8lJX31c84qOIH6frY2yGzuMMfaPKMpajr+cYGoLWvIkmmhDw/l4JKfBGF7SxiXFLDuR+84vY5mQz5SMUgKdoxC3fh48LdrkzXYwgIKQk3NlfxAPTFmmZYqsdD6lZrRq5O9FCkmAgmc3S8avZwJ+9lUNRar/jmEV7U/sK/HrDOG/zJ314FhAz5Kmr0RQhIUX3+9nOqxKebQkYpAEEJtjXbllyGl1IwLLM+dr2791n+I9KeznltbfGIl9brrqU74r2Gb8W4d77NOu9XmB+pKGel8Ue0bwgo/Ps757ML9ziKOX5P4t9LS7nZ8EAJ4KUr7thkFPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(38100700002)(186003)(41300700001)(316002)(66476007)(44832011)(8676002)(5660300002)(36756003)(66556008)(4326008)(8936002)(66946007)(2906002)(7416002)(478600001)(6666004)(86362001)(2616005)(6512007)(1076003)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SKL0/LSkGe2cWZv1tz4uFJCJrHJ8r/guWrFrYYRl5Y2Dg5c5CeBgVimXez9?=
 =?us-ascii?Q?q7BCdgSqTmd+IKb6wRsFyHrc4SiXPdgClPn8Hkn45M4HZ1Zs58tZbYGzcazl?=
 =?us-ascii?Q?OZGacJq4JpsSGYhYTulzg8kZPQGyh6sQMc1uHvakys1XRI69hD2+568f8QNc?=
 =?us-ascii?Q?GCYXmZk9JVNor5q5UVwNAOVsliBZUGcs/hZIEHujK66fJw26T2A6meGTLBCJ?=
 =?us-ascii?Q?u496NRTNeIk0uBsEM/F7yItPP3jAIamk8FaNqqxxb/7FWn9XPtHcJKasqNXb?=
 =?us-ascii?Q?WWhkjThg0mDSlbCVdrB9I46+g3bpLAxvTTj02dl4YUNwAZ3z3o2uFxZlCYcU?=
 =?us-ascii?Q?58GcJNET3Z07dwD3crSJ55Yu7klRar+lKVfyWAonTHJgaZ6VqKcgCxBQ002m?=
 =?us-ascii?Q?RWB5z8QoGvGPJhNKi2sll3Y32ncj2NiHQi+UVGMKKxcYF3pUAM/llENOA4nW?=
 =?us-ascii?Q?cWxeP3gLKAKyC8pY/K5nQZ5KnKwZrGYpYHWI8GNkcqXzorjECBkL98AGmLdM?=
 =?us-ascii?Q?btu+OzT/zRpdk1tfHVyOfQbzKKRxznLz2BA+h+Vfk4xTwioe3tRv8r++/qrx?=
 =?us-ascii?Q?ThAjtrVpbtTnYFSGAVYnGXlXleyt0zR0DsqtNzQAMc1iN21zanm2ZAmvkpsR?=
 =?us-ascii?Q?BoJ76kO3MPOq8Hpk+GGNvMyGuV8z/7pSiTOayKSbwGBQo/q+hckarRE3tja3?=
 =?us-ascii?Q?QsQtLP336+1f+CPhVaVjgF2Q0p4jQNk0lApSwCtnqJBdw99RudPcbsSkESPL?=
 =?us-ascii?Q?bm2wDqH4HDu9mpuXDtHqhCW+YNRDszJs+7F7PBetcKbyw9pyF1lSWe3ki+i2?=
 =?us-ascii?Q?KMFDzLX2DTSFr3U0s9iowcAPg+rksWhb9PpjFqQOLrfko7GA+3IZHd6bjbwX?=
 =?us-ascii?Q?OuvHmDhlnid8jXpTsjwsDFjtarwOz9gDkb4/svj9ibhvDABWAq7vwyn1RVF9?=
 =?us-ascii?Q?HrgFBWAKPIMu1dKgggOQUdyKe6ztSt8vtHrvM5n2sMtbR38WL+RcteY/5WeP?=
 =?us-ascii?Q?YRXMBxWk/kJMN6KvrPxwOsui8zUlHMoz15qCWHC8VDW694BDyXxsiWlDdKys?=
 =?us-ascii?Q?sNZNxG40MI839BJPVhTwkd9pwgeQ8L4/5iSw/mJiS7hIvQMRB6OmYYX+J9pA?=
 =?us-ascii?Q?oYExBSBPeZ0QmgKl37DWH/MpUQI7JR6sQv7n75LJg5QTJIwHKCT40dUKkMIv?=
 =?us-ascii?Q?skcqTBVbkAj6GgCAYvw0R1O6sSMDP/NJRoxcE0nQ83KwPeiGRBFF6mU+cXLR?=
 =?us-ascii?Q?C0gd0gKBbRnUy6T+2khczgzzySXTY3dnmKBmA+5+Ww4oBAQIcrM6MNwHUIYE?=
 =?us-ascii?Q?YxYnHvbD6Q9xJSduKLUeHtV930wIkR86KZADumh2xa1bePEZq6Ig7YFm8WAK?=
 =?us-ascii?Q?2M84u5QXnDDZlmKNlyjkDlY+RXHXDfCd8fE1EYQiXuppnamruv2sc4JmafBy?=
 =?us-ascii?Q?8ExczIaYo+1Eyn0FTFDvLZAIXQc1KQ9HUFhVgPCoITHDdV+rKPbyVrkNoWNN?=
 =?us-ascii?Q?drRuhtnWRrAHOTyIJEctS5p2qcGGxTy9UW4AxfHE79yPooxpFrDG2wDhuCME?=
 =?us-ascii?Q?1gkACNXlaG5Wwgzc/mku5noRrr+Wa4HFxott7tFYgUKrMJwgslQeI4p9+7KE?=
 =?us-ascii?Q?JV0T3J2nMOLQjsqx0Ne4DEU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?1fEHoTCpJh5Tt4Z30rCl+NcbxwObXKQrxJSQKAm/hZTC1AUH9NJhAJmIJnUQ?=
 =?us-ascii?Q?xoHIaox2yVIm0z3cAzSq6W0sKvkJHFlGN9P8aklYROp3esu6uaEkhr2spyk1?=
 =?us-ascii?Q?/N5hggMtfaFuhxB+qHnIY2AYuZW0PLFh8koxQE4JyMEGeIXa1ggzmrkJDp+v?=
 =?us-ascii?Q?mTZyiH9eFp/jwqB+01OVgbo1dgRkSNr1TM5Qn8oc9uceJCeuBuO4f1vzjlyM?=
 =?us-ascii?Q?Bg6P0O5tI+Wjciiozq9meyHfngraAZ4D0TAZkAEwYF2dWcECr68R/PhYJ8Hd?=
 =?us-ascii?Q?cqTgBRfTL1E6iwqZviZ6TZa+drT1ejSi4ph+8CQpgj/qJR7OzyRoooYdZ9Y4?=
 =?us-ascii?Q?o1HHGjXVAKm9vC9J8rcMRtGokxQBezCRYzFOjbWJzmu4+hlIRDSPmFjyN1vl?=
 =?us-ascii?Q?2Vv98Sg2bkajnghaRxLgvUuOwiTbU1n1m8HcfC3Jmqf4EKBtZJ1cWSzV3HLn?=
 =?us-ascii?Q?LuxnXtI5wj01iDpMpzrbMQC1TFmC9rJHQo3C+sqEww40vlInpd5DByuxtdvj?=
 =?us-ascii?Q?zpljLoduvDVZQNBJUdfFGkQ6F8K1FmhMdX4gZNo/vR12LT2XE7g1OgDXK4yT?=
 =?us-ascii?Q?F3475vgtj6UWNk8M5iimeVs8eQyjG97mi8KSrzawor1/IsZNNviauA04FGUc?=
 =?us-ascii?Q?ij6QHFazhWoxtnr2mRgpDtzGdhHJp3/oNOI7JkR4pTq1961gFQNFAElsIFGw?=
 =?us-ascii?Q?PGKzOwXnmgyXw0L8IU0evByXJKTUFZ0MaUoAPDwH8SgQoP9PsRiTzGTQAFv1?=
 =?us-ascii?Q?f20km9AQz3EO37I3gS8+QYTNt36xEJaxyzoHay53sc0TpYYugcEt1UDttKpr?=
 =?us-ascii?Q?kr28uUozB14Cvs8o+FC/38C8sd7GX0TcUhcpudOK3QEBLNjjJPfvMVrdjGe9?=
 =?us-ascii?Q?yxZyi+UnoKXK00vr/uRd4bYu4Ae6mhzw98W/opEF/aoELfqJQrWtMr0Ztofa?=
 =?us-ascii?Q?QjRwcr8w6nN7qrzUHFg6rTCDtDXv6hnK3iU0ArBJYYudjFbSSpbl9CqQIJ44?=
 =?us-ascii?Q?HTf/2JILB9SgHKV4zK4f7txIe2J0gPsUt2ATTCsKLIkcHrcQqP/dIUe9EuWo?=
 =?us-ascii?Q?kigrNjlGaXHZ2Yk56sRM2dhzG/rh0VPW44nIkEpnGCcRlTjNvcKU0cjRTV51?=
 =?us-ascii?Q?SP5DM0g8IZviyIp5n/OsFCEhmyD44H+ua1IQ9BzgHbiQ2oVF3e8TC3LcAaiU?=
 =?us-ascii?Q?IRezmwSz1p5s7w3m?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24d99c8-1489-419e-4253-08db2af152ff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 16:20:17.3345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYaeYdytC3WNHz1ckPdeLQLGp2kI5F25fqyQ60iKTjDRW6K8STk+v43sorOi9NNWoOHWAxjDYwHGxc+JTkQjRp/84o6ne51zHy65g7/R+GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7688
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_13,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303220115
X-Proofpoint-GUID: zUpLddMecVk65VqPsKG9lHGhTOeBA_o2
X-Proofpoint-ORIG-GUID: zUpLddMecVk65VqPsKG9lHGhTOeBA_o2
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add a new link restriction.  Restrict the addition of keys in a keyring
based on the key to be added being a CA.

Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 crypto/asymmetric_keys/restrict.c | 42 +++++++++++++++++++++++++++++++
 include/crypto/public_key.h       | 15 +++++++++++
 2 files changed, 57 insertions(+)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 6b1ac5f5896a..dd9ced32c8a1 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,6 +108,48 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
+/**
+ * restrict_link_by_ca - Restrict additions to a ring of CA keys
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trust_keyring: Unused.
+ *
+ * Check if the new certificate is a CA. If it is a CA, then mark the new
+ * certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if the
+ * certificate is not a CA. -ENOPKG if the signature uses unsupported
+ * crypto, or some other error if there is a matching certificate but
+ * the signature check cannot be performed.
+ */
+int restrict_link_by_ca(struct key *dest_keyring,
+			const struct key_type *type,
+			const union key_payload *payload,
+			struct key *trust_keyring)
+{
+	const struct public_key *pkey;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	pkey = payload->data[asym_crypto];
+
+	if (!pkey)
+		return -ENOPKG;
+
+	if (!test_bit(KEY_EFLAG_CA, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (!test_bit(KEY_EFLAG_KEYCERTSIGN, &pkey->key_eflags))
+		return -ENOKEY;
+
+	if (test_bit(KEY_EFLAG_DIGITALSIG, &pkey->key_eflags))
+		return -ENOKEY;
+
+	return 0;
+}
+
 static bool match_either_id(const struct asymmetric_key_id **pair,
 			    const struct asymmetric_key_id *single)
 {
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 03c3fb990d59..653992a6e941 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -75,6 +75,21 @@ extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
 						 const union key_payload *payload,
 						 struct key *trusted);
 
+#if IS_REACHABLE(CONFIG_ASYMMETRIC_KEY_TYPE)
+extern int restrict_link_by_ca(struct key *dest_keyring,
+			       const struct key_type *type,
+			       const union key_payload *payload,
+			       struct key *trust_keyring);
+#else
+static inline int restrict_link_by_ca(struct key *dest_keyring,
+				      const struct key_type *type,
+				      const union key_payload *payload,
+				      struct key *trust_keyring)
+{
+	return 0;
+}
+#endif
+
 extern int query_asymmetric_key(const struct kernel_pkey_params *,
 				struct kernel_pkey_query *);
 
-- 
2.27.0

