Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029B57BB93
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jul 2022 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiGTQlA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Jul 2022 12:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiGTQkx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Jul 2022 12:40:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C265B7B5;
        Wed, 20 Jul 2022 09:40:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26KGcxQI001728;
        Wed, 20 Jul 2022 16:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=TGMcGJsbirpOY2qimXpRWfb6n7IerPm9vCCSQGA/2Po=;
 b=MEyNJebX1O/UAzqAiFTvw3TBjHLk/l8TL+nkfpf/rmfD7OegZWKeB3r/XjufWLj5hTGE
 2LTDKzoKYN/jQj6R1+CIy2JwhqHTBkJ3ZsFreMuJKrApfkqj05gEA9RjIMiCvaPHhBR1
 igl2W9UklsPvzosamB997YaoPycoKKODYE2w71shjLu/yBpNUWXIj4vQCkWil2Ug512D
 BXCHiMhy7tCe6jOAL6lNyuR3Dxdsd4iQ3f3Nl56nmX2YrvOcPirHvFsHhxMI0hN6/JXF
 D/uC/YRnxPSLgVOa8q2XLRiQ+91V32+Klx+gb0NC+X9oqkdCk07voTYKeuGZHDFhMvI6 7g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc9xed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 16:40:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26KF8sr3009872;
        Wed, 20 Jul 2022 16:40:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ghjpdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 16:40:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcLLMuHJ2BHL75UalFh5Vs3EWonpwYiCAfH0slOMzLXjqavporJJxmUufc6ki3EU6DPiHbAezyMwotSM+8XGeLkO2sbpLdKhZcKZOSzAUeT2xdgikvwF+GbBqX7krBrycWOAdbffzuf3IkWXnBFsyv/k2sEcE5kvI6Tbe2N/LNs1CgDFZpe85Q8TdDreJTmnGkvdBjGAIQsa+4h9m+R7ZETi3uWlY3HcbCFR/SuCEPd4hoVKnIlAiLDXI11ZPeTbp1LiL/17UYvRan19cj4i+Lul82I7O5wTKRq+qU3EPEg7NtO0hH3iedEjiArdn/C9CVQSvskur/HmSAmjcVd2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGMcGJsbirpOY2qimXpRWfb6n7IerPm9vCCSQGA/2Po=;
 b=bKOzmwSKHnhsVOON0IRGs137ut64EFCjdtkY5WAQs42iaIZqK0auew3iM+sEmfUzV6In9ubT2Gx3BzV3zSMQBkjDYodjBAPUumPqfgQSy8eX39xilNq8GPAk1sUT3Ta+93a0cfzyuWVM33unVPbDPy1rjCA+Zx9yyVe+f3I9EKV/C8BvUZ3lcC2Pb22vEgc7PRRUK0bZYCkFPxUBZLuzV9iS1OgGpJCsiETnqPphkG0ufkW0C8jeFE9LUCFznh3Amrx6PDhPKZYdCiyuHyphfx2YAKSFmj/YkOYsif5qAP/9eeE+CQEkLIb9pT+o+6W+cmUSuN+qmhL9sAQ2yDXEcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGMcGJsbirpOY2qimXpRWfb6n7IerPm9vCCSQGA/2Po=;
 b=QZWWOd9lstsxilZaxwdRHRzZ710rJP/92OhEN/dxgyvtTaiY2k5RJFnCf5JIiC8DlDwSKAQHbXuj4kfqQvKI1vbHXHvEmRpboQEY8Yj1VMOBXqPQNZDfz/Zg5K+bdY9swJ4QMKFvSY6f/g7N2Zqn04uvfurKOebE21yEmPOgjY0=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:40:37 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::21ce:9dc9:abc2:dd08%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:40:37 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     torvalds@linux-foundation.org
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.haxby@oracle.com,
        eric.snowberg@oracle.com
Subject: [PATCH v2 0/1] lockdown: Fix kexec lockdown bypass with ima policy
Date:   Wed, 20 Jul 2022 12:40:26 -0400
Message-Id: <20220720164027.3697950-1-eric.snowberg@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:806:6f::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 611d9783-8776-40d7-4b39-08da6a6e9350
X-MS-TrafficTypeDiagnostic: BLAPR10MB5169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFVDz4DKVqGJ0UVHB4afbZdsqrBJpraBtFHLrNUirhzq/cccSLHQya2N5YBRGmLi07D3w4A0Q35Mfae16JfNa8TTxZX5PsCBWc7fuOudkLFDKwerGmYE6yMyH//XcRL9Xj2mdXZQAimpxioKzp+kasnidAhK8VshGjsog+5ecmxnFRqRHbvgl2dhgn0vW+jgplhHecXXU0Y346ZnBJyUTw6/2/nFGU9+HLZgzVsBR4B02FogM1+iGqHqWsaRcspc5Z7QxiXQEuJ5O3kinfd+gvu8qTaYDAwVvqzjs2niVGdTZ0t85Zd3hJy/pk0TXS3b1onIdcmE1+YN/VsidIgxXqPzKcFmUxKpqT0ZWP7c1zWNevrRXvNSnmJ3Un5nJaQ3YJr6rZWoH8BsaoluKCP6SU+pcsaR8M2iLCpQernlbWRbe08ZBAocA7kOly6Vz1NY6+fNpqq7mMsh39wC+1eYpmO5Mb6ZMHsHZWddJ8ghhx5aRQy71wkbD1WaB4CVXZtFNe85OIFBkVVFzA0a0B+Bi6mv0e1SMTkBpF161aIinBKLB+i6pd/y2+AD5A17wE7Bj/ojxS3de/wyjjitL4wPT/P12cHNoq0PuUmNiDj6Y2dQW0ReW783JJ8AXLv4seaQ8psT4rnC7FFE9DZ6qno/ms/V/aio8p4VcW4aSZtlKzUFdwFBh9r76maogWLNbvV6/lMkb6Ye1nWTqCNVZb2jsIhUauMy+EDtyxqaAINZQf7GU/LaRNnzK9mCfio6v4U4XV+1A4fScst0ZXgNfVHpcwAhAjoGG7iUwT9Lj3kGhio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(366004)(376002)(39860400002)(38350700002)(107886003)(1076003)(83380400001)(2616005)(186003)(44832011)(316002)(66946007)(66556008)(66476007)(38100700002)(8676002)(4326008)(6916009)(36756003)(86362001)(6506007)(26005)(52116002)(6512007)(4744005)(8936002)(5660300002)(478600001)(2906002)(6486002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?86St5w6hjPXcTkFIW2N1zdNHB+MaXWtR2mxtQZSDIN14RJHzcuGHOqfHsXQi?=
 =?us-ascii?Q?/M85onk8QUYQANTif4Qxjnfv1juzJ1zDTxFe+05t6/vJ53YddNE6kztEeBlM?=
 =?us-ascii?Q?sFHbUKv0cKUaeTr3Nm5bX1yMPgcJzagMcim3WX6pOZt2CcvatuUmO15XVcSW?=
 =?us-ascii?Q?OmH/3K2Ev+ncaz56qvKZOqVQn6ydtLm5Gid1tnuBi+xtl7cwjh7qiR0VElWT?=
 =?us-ascii?Q?nwaSkNWtY/yti2i905rSUTK8OkBMgupwSjJiOafuvyrHbdxhH7FE7HWL+9UN?=
 =?us-ascii?Q?mDUb0zrJORBAYxqD+aDBXOVMgcCieaGDNLTjwnOWVGcTQ8a0Drp95TIO6bkX?=
 =?us-ascii?Q?YUXglzWUGGRuzd5Wqp1zBy2XE1Jl3P0QTUKjZ4Y8eYG9gKZJyPTVtJlbLkqu?=
 =?us-ascii?Q?Sbjwsto/uqJf+W/HtdWWIqsgHdbgQ8lH5xXVLGHQxGgN4siJPKbbUPeq2mtB?=
 =?us-ascii?Q?hKVyK4hUMkktkVZko94JoC+ROwhPML1XQIJfzY3XrQWoyF2zR19XGqGpGFAW?=
 =?us-ascii?Q?91x/SKWFKvplNemGFBNcNiDTZV9L3q8g/iYVCfv13ajN+Uw9hvDnstOXyUTR?=
 =?us-ascii?Q?uUwxRJxrtSX3+GMIi47g/k0eBBrlrP+DcucLBAVTs80IpABgQXkZ8okKlqv3?=
 =?us-ascii?Q?9jbG2xj5KtBCeJJENJ7MvECIkDCPaERZR86KLlkNTUTD/FZySdSIvwFIZwyd?=
 =?us-ascii?Q?siw9DikJ15kmAZsgkPSDcOCy/pNOaJi7ChmM2AWPNxohZc7pJ4HyW3VXulM0?=
 =?us-ascii?Q?ST4cvV76RWCq05YgbhxbrLB4LUaac9+7WP32QFdcHQtyxF+JmPKBDEpQYUVj?=
 =?us-ascii?Q?t9uMI2+nxjzTPdrDuGxEZ449LukC3BpYmLwLGRMyY6t5T4fU9Seyd9qgFXK4?=
 =?us-ascii?Q?sdtTnkXEEmXiZPcmB9Y7/x+nf1ZtrFPEfY8isnuKufY61tTcMwSspgefBijE?=
 =?us-ascii?Q?L7lhoPE4E/uYXYb5FdQBoIYWoR4Na6EDiv2IDKAFA08FmhbB4WxQdNdULzPc?=
 =?us-ascii?Q?ikUDOIJtf1Y4xnJ79Hg6eimcM4yDowekiLeFPE0Al89kHxYHaZAb5zd6zUTK?=
 =?us-ascii?Q?D2osBDh1Zu01bOrZd/dfR/5wB7RgRfsTXomGAxeJvDgmg7gou2iFOHcBF6hf?=
 =?us-ascii?Q?ox2YCubijd3DTgAoPvczkzS2ETFlfuROp85Ur2D2zJ5WcwSX/gX2mKTZ3kJW?=
 =?us-ascii?Q?5vrPj5q5WxAS4X3YcPgEWFDckO/yYrxP03YXhnys9oGnJYmYLgHrT3xQyBjC?=
 =?us-ascii?Q?NvfApY9Qb5choYL8L/FV7ToIvK3tB74gjc2tk7RkHIL+fERFoXhBWzRB972G?=
 =?us-ascii?Q?d208SiUlazbqH+3gllhDdeDOGg2i4IIXgoGKt0eoFp61IkdQRq55fqQCB+kC?=
 =?us-ascii?Q?Q0NNFR+D5NAwekQARDG/TwLrfC9Er/rQbEb6i22B3UX+1CV45mlxrH7/8JVd?=
 =?us-ascii?Q?tdwVlLbBGeKq8SMwjR+ULV4BAskDBTq+8KHwkMoQZXeJb7EFUUB+PQpvinjA?=
 =?us-ascii?Q?E3Mjs9emhE2PbwPUg5n/A6CdkWk7HmLejtD/5Pjzd7XCthbKrqiGiUzjNpee?=
 =?us-ascii?Q?VIX4s0tEQXr0Tcw0I+2zRI75bixIodjB6FXT94Ut?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611d9783-8776-40d7-4b39-08da6a6e9350
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 16:40:37.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG6zC40TKfP2buvgOBcamA53ionoolYTA0XJA8T6B3QP1mqrkV/jNOKCd5uPAKS7emE0DEEMgbMV/TECvqR7HiowTnTEmnl5Pn4rrbNWU2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_10,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=890 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200068
X-Proofpoint-GUID: WZiXasiDYgfP7Uhlwpd4hx1MfF8GKg3p
X-Proofpoint-ORIG-GUID: WZiXasiDYgfP7Uhlwpd4hx1MfF8GKg3p
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Please see this patch - which was under embargo until yesterday. Please 
commit it in your tree, or please let me know your preference.

Thanks,

Eric Snowberg (1):
  lockdown: Fix kexec lockdown bypass with ima policy

 security/integrity/ima/ima_policy.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.27.0

