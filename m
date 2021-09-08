Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D0E4033D7
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Sep 2021 07:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbhIHFfU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 01:35:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38400 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229523AbhIHFfT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 01:35:19 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1883pv1Q015703;
        Wed, 8 Sep 2021 05:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=SWPvZMI/J7r+9AJcK7b/QshU0UL19aiZxl5BdsUoMic=;
 b=KKZ8sBuPW7rfhAjo0b9tl0KR8W/Foqz0+ZPfA3XyKl568Wqr7mMvN60OzzA1Lcc7gHUi
 9RtgtSMxzk6v8IGIOZf/hMzxJofKO+EdHmIBN8AEZtXI20SANhLQfdEtUI9U1ofbYggM
 +WjYEznKkx8SMjAMEfiCGW2Z8CbM1UfPdakOkjqryBt+L6NDbkbzg6JGYD8gtv/EDH1T
 GwiNm2yysWEABh84moUvI1x3np1RonIzyGCU4zdwG0g+QA5u9IqXuIGOG1191N1SlAPB
 fgO2oDfbdGduFwsafS58hMxePFVXy2OtESxPjjdYb3sAElPZzqtyQbNORtkfNY1+K9Pp 1g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=SWPvZMI/J7r+9AJcK7b/QshU0UL19aiZxl5BdsUoMic=;
 b=GjmuMAlmYBh1ibiLivb1Z/AygjR9OnfmITwYG8OmGAuueprqt1F6ei/0mFSb/q3HFdHy
 FF1YVftWIORHrK+ugN3zaU89JMhILlP3H+BQymmhCTmmBe6ZxLQrNnj5Rh7RIXvSdkXw
 azz5/O5LE0Wa45HZzWAwKman6Mm4i/MLNkkto+qBNdfBegI7Q9BxNG86KbWeBPwZL4Yc
 t60d7bDnEITwJG4LlisAmNa5dnrfvel0L/Ns1AJacMFPXmlNJTY2o5ys3bpYrLH/n6HP
 LMKtZ6eW71+6T8Fs979qFTDV499ZgzHdnDphUyjaYsbMe5Zli54Eg4JS9CjxBzaHjSjj Og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuq9c3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 05:34:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1885Koa2086907;
        Wed, 8 Sep 2021 05:34:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by userp3030.oracle.com with ESMTP id 3axcq0tdbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 05:34:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3NmP6bbnvkLCn6iD0inhU1hKV8mpIqPoIOvFF2U3FvUCGPCOLIoJc7DpEsttH+UvkyDkFlM8HQ/9MWUmFmLznYK9lYtOCfyJfHCoj71dW4ieWX2zbxN7Nu8GsS8KHxdq8JerMEVieijrq8EkXTZEXVFboA8cdbgJAYGu2I/rJgVbk6wj5gRi410jcqNgoLHSOr7falvXp15LcY2KcBTNWpCRR9lMNbLVuZNHYRzsy4xZ/K6IB/qq85LiO+0n1zY9xiyY2hfwBe3tIAdTDP4iP+ADS7M24MhfJo1noVm8Z60uS26nzs0ASAJWwjNPxMRWa8WG3hYdBB49WdcF32nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SWPvZMI/J7r+9AJcK7b/QshU0UL19aiZxl5BdsUoMic=;
 b=Vp6X/hx4GX044qp7uE+riIG1zx9kBcobV5CQWnkJqNSE5ZEDTRVF23/RkwT3Vg2i6n1Xn9CUuVnlE/ll6Lm604wuOCiUe/WGvq/e9ps461RYiN7TnS+2T6hFvkBeJ/oe0rPEA6GLQL3RNb6qCxrDMjyjQRUBLcOxzceSURGg7URU69l8ilntcL648O4v0gjj4s98da4XclcyzEfX2j5yO6qhfR0h4zYGG7K2smqRhjBT36zQ3hIc9ItxUaggvMwA3KUk75EkAMSfohMHlzZdeW3IQ7K6GIM8ah9tHhHMBLEM6Vi3jBvBY4ZwjetfUKgccVYDB4rKTnK/k6pJM4FhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWPvZMI/J7r+9AJcK7b/QshU0UL19aiZxl5BdsUoMic=;
 b=RMU3lmZPoCAfHBeVKv40rgjiU6/ohBDo57GOsi5mI/hdqULpFRMK0RbU9PKo1zRD61Q+aSptLi5tARBK1IqMS5hyFkMEZvDQ5moX0vt/EbzAawoW90u7PDBpP6t6QhNgiNLdGIScQ3zqf9pw8koE1QijjUdmJ34aIicVvj8bkUA=
Authentication-Results: gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1664.namprd10.prod.outlook.com
 (2603:10b6:301:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 05:34:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 05:34:03 +0000
Date:   Wed, 8 Sep 2021 08:33:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] tpm: Check for integer overflow in tpm2_map_response_body()
Message-ID: <20210908053356.GB28725@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P265CA0004.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2ad::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 05:33:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a910f76-998d-4ee5-f03a-08d9728a4485
X-MS-TrafficTypeDiagnostic: MWHPR10MB1664:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB166432DA7C303461A080F1858ED49@MWHPR10MB1664.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VStUvr+V28fx5FnWDL1B2NoDEmlNyunt9BcCHJ5IpdhXaP00xQ2PBOVuWSOZ3hW4Sf8E5JVNCkQtMuH3yWjPK2PvOGNEmWk/XVzNKm12wCNuR2vvO4hDc4rQ2kt1/42Ugg9aJO4xubdVrf80wcZUgMF1YvxXQ6q1nVo0DuIl+OsDSBGyMU74tw2mDbC04b0TCxI0PntSKlkV2VRMWQq36XZAWA7XF4uUrYjqfkB4eoodmozss57dMSJX/gjaJqxX9W7nJ1GPSBI9XDV5bkSTD2mj+pVO7ZwLkD8Ip2A2a2MSODV2pEaNQ5kNnTlJemP0iiWl94j2CCxozQO1q8WMUBKqHds8Bv734lEU+Qn6ch9FD4O8rldUdtVuWkkg/k1w5FQRrtqoGP7AdJOcn3CLQyYZgpEGGDZqen0Ep5SyByCJxjkqfoiDoiaOOyqJaQoPq4F84vL3i3NSG/O3vFvYFuuZ8Kjwu+nlIF1xOEBJA58khK5kFE8msoUW4EFBd3T+DPtno0bcWZpqXJWpBZAiU03IQrrbkIrLkrdaB/JrS0zMTl85AyQTdVYK8bXKm/3+Cq06EFHslnveNRULpLTu0VbbfqRl8VThO7MQ6vQZBtiI7OG6OYioVvBlpLlOEumMAWJzbFGgqWab1HWBV/FT4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(33716001)(66946007)(66476007)(66556008)(1076003)(478600001)(38100700002)(86362001)(4326008)(186003)(4744005)(8676002)(9576002)(6496006)(52116002)(8936002)(5660300002)(33656002)(44832011)(55016002)(2906002)(110136005)(316002)(9686003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8KAwMipLFcGIdylYEEuzM+LeWYCY545Q008s71r+T2B1HcM/n/hBdME5m14A?=
 =?us-ascii?Q?pnvSCNpzmmk7ohaysTV0mQiHhUHoJR+AaGp5rlg6mtFy1rqzDN4uXAAEQWZb?=
 =?us-ascii?Q?7QtXAhfXXX49rdTox2CX3Y68vchlEfOFwaEKAQGsZ6zLA69v+/9P57Edipwt?=
 =?us-ascii?Q?sVkSxWQdVDRcu/5IOChjXTGpV3kvASyHsCGqzy9GT6ESpA9rehuzYcDNldjy?=
 =?us-ascii?Q?JTJjiwL1g59KpmlypbyevkK1ODMWu0KBy0+5Tly1wlyUZQyBIiyvdqwCWgbQ?=
 =?us-ascii?Q?m+I4/GeCYqiTcXUzTFDgU37oitxvXpSF7gfFKXLODI/h21J/tSKbM6nz82eZ?=
 =?us-ascii?Q?PcvMwrl+NBYzX+1IBMjiDGQcTMwLjbyT7ZtZErisrXrjRH8y07STa4TBfLra?=
 =?us-ascii?Q?fMObLBzjtsgkFOTdaNyzo06AWabxcyDbfqowaQxTxhJt9N/vGW8JKLd+7qTJ?=
 =?us-ascii?Q?yhIHYMDFaHtzW/Sh8E4ObhEKr4UUmRl3Qqu+Dl8seZP/W3fzjPlKM4/vwtuY?=
 =?us-ascii?Q?Zr2PtCSPxifUwH5EKzzm4JVVPMV8E1p5atovHpkPupQLk0lYTtU2wQEI9O3A?=
 =?us-ascii?Q?Y4ZB6rbSTktCtU7UGCk/XkvlrSOhHIXcjFu2TjBmmpoJYl0H/+69vK7q4Tx2?=
 =?us-ascii?Q?ADW3hwNSj70vyOiXn+KzSv0/X8iZxdCNEpsDrpAMFyMwKHwVR1fjzzs3imcF?=
 =?us-ascii?Q?MLGxJy19GrG1QoNIbwjqlZgU+4aanccwcBtJ6HIxRbC1IV9RxtxGJhtDI6H4?=
 =?us-ascii?Q?F99Nwn9SxxaWJF9VEkrzrXhoJqbZmmPSjVQhi3Z+yJtFWlp5kTBRbB7jdseY?=
 =?us-ascii?Q?119ZRtjwNY6ye1MGoX2/Cah4IkaY1G/VeWgjCwA/MQRtFiXzJTAywn/23XnW?=
 =?us-ascii?Q?0/kmLnqaaGEL6uWd/uXohUXIg6oQBVD7b69p2bRly/QFKnWNt5HhHNd6uprX?=
 =?us-ascii?Q?K5uuT0gmBC+1BdaKHVkCHm6MqgyAKPe7L6/zu4z0tmmCPtB5qjORCNRBG6F2?=
 =?us-ascii?Q?UGPpjkgsqKYZNxDyb6UPBPRLMp7SMvlQQFlpuUa16IHVadw+vXW9Q26GDStN?=
 =?us-ascii?Q?sCE/QWZvM/BNCjZcCdI98t4nUiSOKMxcmyCWH2lbbyHSfCvfNGZq7d+FUTwx?=
 =?us-ascii?Q?0xzaSE4H0CAE1uyd+OKGWq6p2MhvPFfLFCWQVh8dYcMztCzaIGppzxXtp/W6?=
 =?us-ascii?Q?f0L54QIQ2w3BHGMsutm1l2avP1mZBr6sDlKsnXABRaJR0lnbWll15tGuKLtc?=
 =?us-ascii?Q?j6KdeShE91DVNhSdXFPPe3XWQFZeHeFNjVPSJvytT7fkArajHozH7E2ySFHI?=
 =?us-ascii?Q?YxrTnA2G4hboug/8K362EaC2r4ox5c2ldF7i1rovGac0w822fqW37hgutTKP?=
 =?us-ascii?Q?aH0fSEA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a910f76-998d-4ee5-f03a-08d9728a4485
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 05:34:03.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SN0aAOkwmKefvftAtGzZx1OFlclurANsyIwy/lfFBWA+hRdoxd4mJXOGAurcpfAFHERcV++z9V4ZesvUJ66K+65CPqUKjjrdIaH4Z/gOhWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1664
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080034
X-Proofpoint-ORIG-GUID: 2du3Z1Q8Ttv95b3zu1Kn5uWvWitlSDNP
X-Proofpoint-GUID: 2du3Z1Q8Ttv95b3zu1Kn5uWvWitlSDNP
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "4 * be32_to_cpu(data->count)" multiplication can potentially
overflow which would lead to memory corruption.  Add a check for that.

Fixes: 745b361e989a ("tpm: infrastructure for TPM spaces")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/char/tpm/tpm2-space.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 784b8b3cb903..97e916856cf3 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -455,6 +455,9 @@ static int tpm2_map_response_body(struct tpm_chip *chip, u32 cc, u8 *rsp,
 	if (be32_to_cpu(data->capability) != TPM2_CAP_HANDLES)
 		return 0;
 
+	if (be32_to_cpu(data->count) > (UINT_MAX - TPM_HEADER_SIZE - 9) / 4)
+		return -EFAULT;
+
 	if (len != TPM_HEADER_SIZE + 9 + 4 * be32_to_cpu(data->count))
 		return -EFAULT;
 
-- 
2.20.1

