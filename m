Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEDD589824
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Aug 2022 09:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiHDHII (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Aug 2022 03:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiHDHIH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Aug 2022 03:08:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB474F186;
        Thu,  4 Aug 2022 00:08:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2746iQrx016167;
        Thu, 4 Aug 2022 07:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=j/6s9EJMBahm/tDU6xBWHY7F1ND/ATlW70tCwYZr+R8=;
 b=04Ir+HDJMTGS2yyunZO1y0+hlYFjZ6SWGKz9nN7HBG0pnUJCmaqrTISTpqTl8u6b32Xi
 m4DCAtaUKUBVMJ7y8uhBOh/hFZHVu+q63Otl44kSequVlnjU+XbJSgIOQ50HJur1R8qn
 HoFL5XuwjgqJAK0dZAqJSoidgTbXqo0bG4RPpktbPhusQIL7GhIbbZzgy/S9KeRjndnj
 rZVh3FNwmjneMt9tB07SjHrbqggC/3fMrRGBqR04Sz16loa9b/YgRCP+BbbJOlJ9kZBY
 1YXy5xG00vuE0KCicPCi25p34EfxWG5HhVSrK/z+WIHC/lphBQ1mWHQnpSHs7aDp8gUB fQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmu814084-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:07:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27462KRA002962;
        Thu, 4 Aug 2022 07:07:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu341487-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 07:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeRuSaYpJU0sYWP4gKPTYSny2IMit9Ghe8jfRJ21z2EohKPfFY0/KNCMXsZini/j3iYQW1olkShpQaxhx5loTwgwFxhXytU+L7cwJMJ9P826acfePGTWmO1elVOeDZcKSrA2wx5TO/tbe5T3KbE5/Zg4U5H6MEpbQTKl6eh7cm2Ixuf1AW0RTLAqHgfYKbkr9v8OADcidu4dZmGGhrr5NzojlXgX3I6IRsZdQ1RcJ46PF1wQ5HITsIMMZHM+5LF1vhLjwu4PEYb2ViFHFRVJjlNcF7RmQKY29aEQGl/0FkAW7fXbKub1jC+2nZrHhaF4A9/+0UDq+WJiPAvKWvfKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/6s9EJMBahm/tDU6xBWHY7F1ND/ATlW70tCwYZr+R8=;
 b=gagL1P7mTE9b1BPyaFjZXnqpzUE6t+VG6tTbcJeXmp5yc8T1fJeVjxdEdKSecErefo/H81dk0yZXkZzWmrADtTp5x0SoUsYOM6xCMndCk1jmFXrsUqA7Wm2HUhp/Ki2wU/wgIJ1623hcsXisQx8hd5mfULxLkWaQbv+A9/f88IrOz8TlymHUxyDFLHpsAPMtWHT4Iz8yxebrZcZanW8pdJgP9xJfNMhCdaz/QGSdkmGqPJ3zJP4VDF0Efhh5CwPu2G68aOsif0QSxUqyH/rCDgG73nsIEv7ypS+E669BIHIkNVIN7h5rQCyAYHsbzEaENKNPhIE5qo1JkBbJoV0lwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/6s9EJMBahm/tDU6xBWHY7F1ND/ATlW70tCwYZr+R8=;
 b=UcDfxmIWOXOIFy921O3DcXn5R4MeAwR2CMoY2ZGEKtlsNI5J3JaBBXkqWZMJPlsBcf1VK6m9sQE2NpcF+naj9Lpd7B7dAU1QL/HkISwX3kC9JqVnXt+wqQaXHRlvShThHEJAtotpVoXSmsedzn08z4ilSL4+2F+rh+dhz0nUrs8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA1PR10MB6389.namprd10.prod.outlook.com
 (2603:10b6:806:255::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 07:07:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 07:07:53 +0000
Date:   Thu, 4 Aug 2022 10:07:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jiang Liu <jiang.liu@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] tpm/ppi: fix return type in tpm_show_ppi_response()
Message-ID: <YutwPjef/hseEE31@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69a9b45c-9be7-4c7b-39fa-08da75e80cd6
X-MS-TrafficTypeDiagnostic: SA1PR10MB6389:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2vcoNOYfEkfYcSkBdv2FUIE0NUw2LRjTswW9Ccn8hUDACPUJmiZIdYqt3JNln0uI3OQVhbRh7lVWXM4DP7u602D8e3dd9cuO1e+/jz7yr9Zzjxcc7dgEXiOhY2NwHTS6VE6Y5ldgbOqdm0xnHcD3kBmuv0k7Pp7bK4P74k67nK4fLBfarOlfGImc9HpWmh1oKsNSI7LQXd6gNkkvsMv1xsipxYlxCKEECgNc6LRaerssClOgDA2A276wFeGxgS6hE9lKQ+1ASOZYtW0UOoUVB/O+LK7GZ80iZi/J+1p2yvpdpBtK0f7fi8OhVI0flwFv9j1INMkP577tU4wsjLUxSE6i2+p83eNuCpYLpR9Ys9sH57q6CvNOwstI9TxbU4O6kj/CBwREKWaO4RJ4XGhYdaV9NzU/JSXM58Vw4C29rAWfbVJInXMCmOPflbKs1ddRuXdniRDW+LTGGk3Q1YjjdGbgVObywZN6hCOL8xCLeV6DwRpiHveEVpFn91hwFHnq/3cPkKwbGeEQdBBxA5XoUcP3bEVEMlQv0g5FK+Ki+CoPtrFpg+ML4ngjSzL26pDp/pfzDLujzr8IpRwnPd6Q/QoxEWCUSerlC7Ztdk75J4FLjyakXfIBpGzBt6YdXPjb7P370vLLV8DP5boYufpy9Jq1DPDOLbgUyUMMiTKtw9/eX/8/+Pq1FEjphqPLc4HrPOz2RXGWH0r0LYuRgzUxux8oGP2MC5lov5y8dJMahaXai0ACIhMoJTN7eucdyKfn/3XapfgjO7nea3xXH9xpyfynmqy3iJZwi/MCscdC5Sr97b3fIjOCoUroX/p9ydjP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(376002)(396003)(39860400002)(26005)(9686003)(6506007)(52116002)(6512007)(5660300002)(4744005)(6486002)(44832011)(186003)(478600001)(41300700001)(6666004)(33716001)(86362001)(38100700002)(38350700002)(83380400001)(66476007)(110136005)(66556008)(66946007)(54906003)(8936002)(2906002)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w2yuYuLxj3V9U+U5g3S7FPb/0+mgz2aK+9KsVrCSmOWoM4UZAKEA0NoqmJuN?=
 =?us-ascii?Q?4RGXZsca1kLBANV0CZmCXkOtaNy+f97pZGkHJxoGjYO/NXczigkNXCvlMJH1?=
 =?us-ascii?Q?SK9oR2O3ze4Bf27/y5ROWl/o7xHSsaGlGkVPXN8Ry89E+yU9ymkWRFOjLb97?=
 =?us-ascii?Q?BVMm2ohedEkbiaVCnozpl2yG3yu84KCgwTyIZkgRoHiz7YvOUQoWqhwgXYc3?=
 =?us-ascii?Q?OZ6nHojdc5gJdybc6c3FLKDQXsComkqP2TSM9oQ5phSThBX4RwaS0+VHTSRA?=
 =?us-ascii?Q?+xP8Z9xPEcdqKeQEqPhUgjYdYHrLc2QxCksDh+6O81eQ3Sqm2B7vGR9VuulZ?=
 =?us-ascii?Q?G9YDfNjxACPpTTpEwolZDVFBoilsSVh1I+3JUrzZc2GunGQUDQ61RfZQabON?=
 =?us-ascii?Q?/ga+8I5UYj22ghM+hFx0eNXL062n5dPXRgFSnmHCtctN6kqRrtiiZAlb5Gol?=
 =?us-ascii?Q?dkiTCUx5cTx7ToHWKGdwGp7sMxOa87UtwYRX6xEhGn1ewA/mjFouyAFqLMpO?=
 =?us-ascii?Q?fEttZuAM0yWPll5JODG78vxckWxNcy3HLGBVAmMn+Xhc454GnFjKKNSoEZkc?=
 =?us-ascii?Q?p46MSbKNp4LxSVcvSvGtm7ibK0FN9ozeLIAe27TEOJBUsJ415idAHnQzPitc?=
 =?us-ascii?Q?nxRJkBAsRmnFSnbFXtIQapbXToPKjAQqmrTPMwq1B/UCa6KmLrhfuT2h7Cds?=
 =?us-ascii?Q?8/bXPeY9/M5BLs6tM4YP8CXPP7egTrvfO7zpowAM7sLAOB/pn0fpgMgYQr1d?=
 =?us-ascii?Q?oXcAxHauZOtRbhnfXQIrDLlj7mP59zb2YXgYLY8gL9utz2n+SS3GbAhT2A4a?=
 =?us-ascii?Q?c7XkzpTEEgXESQFKh7JMRJs4HZADxxJ2+V+35IP66n/jSOssfP7p0QFYd7sK?=
 =?us-ascii?Q?aNVoLNrgDXa2wgW5ltDgHgwhLWT3qY2605mswAIxwrTvtdouZykKeNeEqF33?=
 =?us-ascii?Q?o3Op3ntWJQjL9m6fbBLTDdg/Coo2RCdgNQNn0m1QM2DUWc4bob0cgjZfQr4m?=
 =?us-ascii?Q?DZaagxmkhHeL+pqqRLb6Qas1cKpPL0K72wtTs3lPNgBKbYa+znK5HNps2gQ2?=
 =?us-ascii?Q?6gc8libBWJXeNg9ajQQ/0mNeZmgHqENA3s/+nJUXur89YgDmIqgl3CuXTiYk?=
 =?us-ascii?Q?8vDY/ZdIrdU3Mtf4K4z8I/BIWomxC/SfOdbo1plgY7W1IpSY20HLmh6crjkh?=
 =?us-ascii?Q?Bcgjk6blTkNsZc5YTGexFNSkYr8C0ZbqPap8qaHJBGK66qBWhzHs/AQPwt1z?=
 =?us-ascii?Q?A1Pg9t53PO363t9iBB8IMgYYBefKzs6lJbBvJezy4unF1CDv9rezq2LQp0HP?=
 =?us-ascii?Q?L4y8ZHYmUek/rtl2ywS5ueHPVOia20asK801q1hidvN0MXVaDGMITcsuQHIS?=
 =?us-ascii?Q?5fPP9hKOA56BAKY63iFiX5PB9LwDPCkA3I7+PM7NXWEXJutxk6jvUkOtItoH?=
 =?us-ascii?Q?4OrRLu/lvEEhui5AfzrcwbVdHX+WFXs1baVBpMs6SxTElBeazpuERj+bBCIw?=
 =?us-ascii?Q?b0IaFLH4Ch3J4wby0HiX8RsVFISjIe89QrzDCMPncf0M7iwl04zuAlSd9MQQ?=
 =?us-ascii?Q?+gcBppBEU5r4rVZu7/CfWwauOnfBoorRk5+nVp9tW9Bsj9xH+dbYC/7p+xm9?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9b45c-9be7-4c7b-39fa-08da75e80cd6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 07:07:53.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiIJxifN20VG/CLZFldTytpusDdhNZUdPx0YU8KSGvCeW90cJbgmTPLBoM5B1/x9w7IKmfXKN+8TwRU+BxTcA0h4qCS/u/nAFGv5C1fzkwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-04_01,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208040029
X-Proofpoint-ORIG-GUID: gOgz5UucIJzkt_Maid3WxqLsIhd8Wocw
X-Proofpoint-GUID: gOgz5UucIJzkt_Maid3WxqLsIhd8Wocw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This "status" is declared as type acpi_status but it is never used to
store any acpi_statuses, only int.

The tpm_show_ppi_response() function returns ssize_t (signed long) and
acpi_status is unsigned int.  That means that negative error codes will
be type promoted to large positive values.

Fixes: 84b1667dea23 ("ACPI / TPM: replace open-coded _DSM code with helper functions")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/char/tpm/tpm_ppi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
index 40018a73b3cb..240df925c38c 100644
--- a/drivers/char/tpm/tpm_ppi.c
+++ b/drivers/char/tpm/tpm_ppi.c
@@ -222,7 +222,7 @@ static ssize_t tpm_show_ppi_response(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	acpi_status status = -EINVAL;
+	int status = -EINVAL;
 	union acpi_object *obj, *ret_obj;
 	u64 req, res;
 	struct tpm_chip *chip = to_tpm_chip(dev);
-- 
2.35.1

