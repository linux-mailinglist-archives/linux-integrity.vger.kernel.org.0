Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6363E49E3
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhHIQcC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 12:32:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5878 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233022AbhHIQbt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179GBn5G024019;
        Mon, 9 Aug 2021 16:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=IPrBugJyInswmD9FCMZZii1XqWjmC7jugdFzA4EhNOQ=;
 b=J5rN2JIkM85THVPcqIdHTQpcb5i09A8XudLe38E2ID2uF5dXNq8wdh9+SpPmGkdRxkg/
 hgM45DCSUL/TQD6Wbzx6c0Qvyl5HTT5+H57skjxrDSDq1gLJwo7ushK0hJw4Vh7N8HV8
 fhP/Q6Qf2qSB7k148VG7TDZiRu5ndODIILJiebwFUl6ZF/uwHDINN3wLJkZhpUO+1NTv
 uR6sEasjXEoGtAoM8UorD2hjhqOzVlyfJl59LJurbkH59+bFl0EavRfoLYWyIlNG1o/X
 AiQ2X5tX/KAiR9SmUkZejYaCLecPbeUnJv3r9TvvLtUodBZFb58uFNRpCAJVdoWDaGP0 qQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=IPrBugJyInswmD9FCMZZii1XqWjmC7jugdFzA4EhNOQ=;
 b=zKLpVq+lMA6Gt/wyRqWfTpAWtfOzmftGee30LdaIGtm1r0yk04YRDCXtpCXPh0IU1LQp
 MDhHMyA2cel8HRmECTLi8B2VwbomeF1VLiob7r3cHrN7nEuO+73l0i5VTPohV7Si8ppl
 jYGQVUaQseramsU95ZuYqi2l89tVnzG0j610wQS8UgkreHWTxXGndlIwDQQKnnXXIPoF
 X1PNwm9r/QVjcuqL7Iok0duhYfoGIYLqKObnQnUdvRv5MXZLEKCIfh4lC9F++WJkyUeQ
 /fsRm3KsSwH48zz7YvtDqCPjdO8VB5GZJPZJdJ8j+oFpc9YqK8Nkt28YUe+FUg5iCX/d YQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0fsdrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:31:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 179GUa1C066307;
        Mon, 9 Aug 2021 16:30:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3a9vv385x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Aug 2021 16:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcxaMXW3yvWa898nhWmiKUUQsdpEybET4wum2aHzkQdmN88gsDEAS+LbwO/DJ/BibyT2UdcVAAxPcAfCSw65JTg9J3uwkvOPx3prL9xamCcBbrQtZzA/R9GkyMBLwh2FubzQtXdOZmy3mpdhUZiR6XsmlED+gwWGjhP2MmGPsH9mDdB7J1cUJR7gnxprPvKav8m8BKWbJq/qLruocV0Q8sMAa2UNn6R492sGVf9h3gOmBGGPcbYtr07/v4q1xrOXgJy/l8NgVOlskdmDIpCV/l8WFFg9gpWXAQl8mqnXnRgU7kPSXAxIOhFSOhVYYkfnzZjlKf35RMrBtBKJARYUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPrBugJyInswmD9FCMZZii1XqWjmC7jugdFzA4EhNOQ=;
 b=HDtGj7+FLUzdcereH+dJdMuUIc4NypZq6nPZgGft/ADYZzwGT2vSGqD9FzqwmqTAkjPDzvrlshQ2LNM588f/QXAg2sRFy6q+fnTQ6hZWLxSgmpJ/ZlWJfB6NIw89g1nYwdMFZLF6NR2sfzAt6j3J/7pPMmnC+brgos0htIeBK8h75V0NrFY/OT6nEdOMGh74ouS2ES9tIB+IhKfgEvkP7/cLCj1kyF5BvfytUJjAbg0JPm3nyKhvpxU866Us433q64uNDwPbsbF0LJuALA3aNQ8PJZXf5ZE/+GmcINvG0abCO089erK/0qkWQtjTmbkgzr3SXaxMvJV/WGWo28oUOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPrBugJyInswmD9FCMZZii1XqWjmC7jugdFzA4EhNOQ=;
 b=ZwZvPanoRhz35lLWxxgcTKO+VOb5E2k1ZHN8fjGUyuTyyesbThcLG8C2w7ArZbAqybiJTK0bAZEyBxo5sfieRIBlVgv89/jF91a6TBykJc/HJBhrfeCLTAR7mO/RI8OxyrkZqC5JhI/+dLhRGotm3cXZzP78LgvxUSSBctOELLY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BYAPR10MB2631.namprd10.prod.outlook.com (2603:10b6:a02:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Mon, 9 Aug
 2021 16:30:41 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::e035:720f:86fd:bae3%4]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 16:30:41 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v3 01/14] x86/boot: Fix memremap of setup_indirect structures
Date:   Mon,  9 Aug 2021 12:38:43 -0400
Message-Id: <1628527136-2478-2-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
References: <1628527136-2478-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lateralus.us.oracle.com (209.17.40.43) by SA9PR10CA0021.namprd10.prod.outlook.com (2603:10b6:806:a7::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Mon, 9 Aug 2021 16:30:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6eefb5dc-b2a1-4978-8ed3-08d95b53072d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2631:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB263166A72E47F777D24969E3E6F69@BYAPR10MB2631.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9aVoBkHIpFaxQfrLSPnsRu7dljDU3lhCRjhVNKdIKWxR1BcabK6ob93U71jWIdYLIUwgNy3F1pwOYAalh3WtTXQBCB3CbpxS6uZL6Bnp3g2kuDgM4eCh4e2Hn8waalOJiJ9clOBcSpFvZT/Jeml139bfO5kogXZ1QuRck0QH7pEHzDJ+FBqNJdmlVslaAYnJYavjFPWk7UBP2plrSm5F7WkKWXuOYvTyd7q+q43WhhPpIo2OYDaCPdtNCtoFINk28tWKT8SGAvC78idZ/4LOWduN0VjZp1IDJI4SWu5uRpo18VLlB+OsDNVF96Xo8gJsPpcPrGWsALM/RSvG1tzn9YlI9fwnQfElRdxs71FCK/EDL9PpTWkYnsyMRpJ9FY0zjD8hZKlJKYMoQmexdY6HMIiAbnKLwCemUcX2ysSb7GrBe8e/3BMrOW9P1K8CZEvFk5gOqUjqsvW2zIIPuRtHBjoPFqh3GgqrDRBG8ew/JiU+bwgYsURNGbnEUR7y1xNhcP8I2m7GXvh9mEtfUNABWgV7oxkkPK6gjXyR9ChLolbyiP3M3jKn1TEb4vh/rjb5Kcv44LLAzcmRqMhB6jOAP2do79urRBS63IhpVE/pnW97RkByEp+1vos1Po7LOt6L4tT61CEGv2Vy4XTNydtuW9HG63XdeyLu+Kg6s+LbKJmA5B8n6XlPLe32hRePh9MMhSOoHbQ3+xE+F88qqB3UyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(346002)(366004)(4326008)(6666004)(7416002)(6486002)(36756003)(8936002)(478600001)(26005)(2906002)(7696005)(52116002)(8676002)(186003)(38350700002)(38100700002)(66556008)(83380400001)(66946007)(5660300002)(956004)(66476007)(2616005)(86362001)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j8w2ejvswMCsYVnwhaUCeYg60JG81tbBX7N5nGp5RoTuQCqxm9iXjn0bHfgX?=
 =?us-ascii?Q?8kZ9wquCS+cdv8oVxg3tWJp7U84MOIPXZuj40HaqbiUd5nrFkSIlu8p+OB+O?=
 =?us-ascii?Q?FEl/UXxpQrVWSjq3ULtXsF9jTZ/PtKt/J1ifdW7QXovyFixy0h0jFOFmTBL9?=
 =?us-ascii?Q?syNbPP4OBiZSbXLStPmvp1/9UEN4H7NRebYxgNSaXGw+WfxGxoXEO6ZPM+Wd?=
 =?us-ascii?Q?VJgRzqKeNPJZO4mW7e9R0NiA0m5eJaxuPhwIBPhb4uvj9fR8L7+EY86ue0Ym?=
 =?us-ascii?Q?vpOiqW5G5bF0ivyZFK7o1Su+w8GiX400Y1Ai2DHNJ3HqPrfNBV+/HcJ/GAqO?=
 =?us-ascii?Q?Cozc6uA00rhugAIFKUk1s4hYV9ORyT+ZQ+ptMrot0vXs/R1YJDC0Z0joQKd7?=
 =?us-ascii?Q?cZd2BQ7gzxsBgoJG7rCwPl7P8/yotTXJX1mMvJkcCMLQzZbJmbIrajBvHX4/?=
 =?us-ascii?Q?kbgNSkoZ3f0eVxcnlkr8e2GW2Q7HmQgLDsmVcD7gwoH0cy1d22kF3H5xrTLu?=
 =?us-ascii?Q?RutCnrBVi8tFllQIWCdjg1uOy/j+BebF4oQ+Z1HK4nAuj6XKZ/08SnZ+vtz9?=
 =?us-ascii?Q?x3fHMIm8ko6kvuKJsbucdlYPUdWjzned60jUGKNdz0L2KQKAA7PW+1qNoEO8?=
 =?us-ascii?Q?BwTMXMkw9B/vXmfCy3zrKs6jW5KLeYtfq7YXJl86smOf8bxS3JapVtnV3Opx?=
 =?us-ascii?Q?ef50MTt/Tz9a7nzcvlc4m6fW5tsGyQPj+rR0pVI/sKC9Cq9Iw+OZIrBKhC/B?=
 =?us-ascii?Q?kPuUPCYTrf6Ky9zn0BEYr1dzNzvOAAn4TcnoVTG2bOth0gfkdsvO9eLSm/QG?=
 =?us-ascii?Q?SbkraupLQJMPuANIJOImFCoR3KoewtpEovi63+rFS+ep9rWP3MHImKTTgRjR?=
 =?us-ascii?Q?t0oE4y8yNIQV5jWTNmH9NctPcTvs8GdwwF/678zg2NI+YlZ83UOwfhde0XvY?=
 =?us-ascii?Q?BzgHgMDXZHpMuOOGJMr9v0buny1zHybjqh0R7vpBoIvZCRC88B5ch2xyx77o?=
 =?us-ascii?Q?3ejxRINGCuUTnNVSgrEK7BKRBVaKXJ7/xK9PPIa9ArsRDYeuHZdij0VvGYPO?=
 =?us-ascii?Q?WmIw6xFkbxRcE30w5jS/JqvreiGRfjyHLXo93STo1BeuxHgGj0PC/AM33WKo?=
 =?us-ascii?Q?ffj4eH6RPTNV1vlhwHXPjHkjrUFL3gIBZuv7/2qa/EuHL7t9ChDHa12Rpuzt?=
 =?us-ascii?Q?gGpwkuCKxNNAkNAGSxrCnoB/qHuAEiB0X7lpfE5hzLtPXEu1Wqql2nwE19ch?=
 =?us-ascii?Q?S/tdws/hwj1X+ZkgSww5bmVAtlfbOv37xfpi/pPSl1/S/VfukRiYR5dzI7lT?=
 =?us-ascii?Q?erjdGwex9QfeeO92ETYqHbMr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eefb5dc-b2a1-4978-8ed3-08d95b53072d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 16:30:41.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Svv4lxa4K0ZHAFHS0k+lyd3kbNKzyZNbRd5VGA54+sR5APiovoDE40GlsyryWl4bqhCFFuzZFVTh8C9DmDtFwc+0cYG/YB5Ym3lqnzU+Mss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2631
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108090119
X-Proofpoint-ORIG-GUID: UD-5Tpi26e-T9-FOpHMvneQHwB87Mvj5
X-Proofpoint-GUID: UD-5Tpi26e-T9-FOpHMvneQHwB87Mvj5
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As documented, the setup_indirect structure is nested inside
the setup_data structures in the setup_data list. The code was
accessing the fields inside the setup_indirect structure but only
the sizeof(struct setup_data) was being memremapped. No crash
occured but this is just due to how the area was remapped under the
covers.

The setup_indirect structure was introduced in commit:

commit b3c72fc9a78e (x86/boot: Introduce setup_indirect)

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/e820.c     | 31 ++++++++++++++++---------
 arch/x86/kernel/kdebugfs.c | 28 ++++++++++++++++-------
 arch/x86/kernel/ksysfs.c   | 56 ++++++++++++++++++++++++++++++++++++----------
 arch/x86/kernel/setup.c    | 23 +++++++++++++------
 arch/x86/mm/ioremap.c      | 13 +++++++----
 5 files changed, 109 insertions(+), 42 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bc0657f..e023950 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -996,7 +996,8 @@ static int __init parse_memmap_opt(char *str)
 void __init e820__reserve_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	if (!pa_data)
@@ -1004,6 +1005,9 @@ void __init e820__reserve_setup_data(void)
 
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		/*
@@ -1015,18 +1019,23 @@ void __init e820__reserve_setup_data(void)
 						 sizeof(*data) + data->len,
 						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			e820__range_update(((struct setup_indirect *)data->data)->addr,
-					   ((struct setup_indirect *)data->data)->len,
-					   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-			e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
-						 ((struct setup_indirect *)data->data)->len,
-						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				e820__range_update(((struct setup_indirect *)data->data)->addr,
+						   ((struct setup_indirect *)data->data)->len,
+						   E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+				e820__range_update_kexec(((struct setup_indirect *)data->data)->addr,
+							 ((struct setup_indirect *)data->data)->len,
+							 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+			}
 		}
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 
 	e820__update_table(e820_table);
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index 64b6da9..2fa1b93 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -92,7 +92,8 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 	struct setup_data *data;
 	int error;
 	struct dentry *d;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 	int no = 0;
 
 	d = debugfs_create_dir("setup_data", parent);
@@ -112,12 +113,23 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 			error = -ENOMEM;
 			goto err_dir;
 		}
-
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			node->paddr = ((struct setup_indirect *)data->data)->addr;
-			node->type  = ((struct setup_indirect *)data->data)->type;
-			node->len   = ((struct setup_indirect *)data->data)->len;
+		pa_next = data->next;
+
+		if (data->type == SETUP_INDIRECT) {
+			len = sizeof(*data) + data->len;
+			memunmap(data);
+			data = memremap(pa_data, len, MEMREMAP_WB);
+			if (!data) {
+				kfree(node);
+				error = -ENOMEM;
+				goto err_dir;
+			}
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				node->paddr = ((struct setup_indirect *)data->data)->addr;
+				node->type  = ((struct setup_indirect *)data->data)->type;
+				node->len   = ((struct setup_indirect *)data->data)->len;
+			}
 		} else {
 			node->paddr = pa_data;
 			node->type  = data->type;
@@ -125,7 +137,7 @@ static int __init create_setup_data_nodes(struct dentry *parent)
 		}
 
 		create_setup_data_node(d, no, node);
-		pa_data = data->next;
+		pa_data = pa_next;
 
 		memunmap(data);
 		no++;
diff --git a/arch/x86/kernel/ksysfs.c b/arch/x86/kernel/ksysfs.c
index d0a1912..4cef401 100644
--- a/arch/x86/kernel/ksysfs.c
+++ b/arch/x86/kernel/ksysfs.c
@@ -93,24 +93,35 @@ static int __init get_setup_data_size(int nr, size_t *size)
 {
 	int i = 0;
 	struct setup_data *data;
-	u64 pa_data = boot_params.hdr.setup_data;
+	u64 pa_data = boot_params.hdr.setup_data, pa_next;
+	u32 len;
 
 	while (pa_data) {
 		data = memremap(pa_data, sizeof(*data), MEMREMAP_WB);
 		if (!data)
 			return -ENOMEM;
+		pa_next = data->next;
+
 		if (nr == i) {
-			if (data->type == SETUP_INDIRECT &&
-			    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-				*size = ((struct setup_indirect *)data->data)->len;
-			else
+			if (data->type == SETUP_INDIRECT) {
+				len = sizeof(*data) + data->len;
+				memunmap(data);
+				data = memremap(pa_data, len, MEMREMAP_WB);
+				if (!data)
+					return -ENOMEM;
+
+			    	if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+					*size = ((struct setup_indirect *)data->data)->len;
+				else
+					*size = data->len;
+			} else
 				*size = data->len;
 
 			memunmap(data);
 			return 0;
 		}
 
-		pa_data = data->next;
+		pa_data = pa_next;
 		memunmap(data);
 		i++;
 	}
@@ -122,6 +133,7 @@ static ssize_t type_show(struct kobject *kobj,
 {
 	int nr, ret;
 	u64 paddr;
+	u32 len;
 	struct setup_data *data;
 
 	ret = kobj_to_setup_data_nr(kobj, &nr);
@@ -135,9 +147,14 @@ static ssize_t type_show(struct kobject *kobj,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT)
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
 		ret = sprintf(buf, "0x%x\n", ((struct setup_indirect *)data->data)->type);
-	else
+	} else
 		ret = sprintf(buf, "0x%x\n", data->type);
 	memunmap(data);
 	return ret;
@@ -165,10 +182,25 @@ static ssize_t setup_data_data_read(struct file *fp,
 	if (!data)
 		return -ENOMEM;
 
-	if (data->type == SETUP_INDIRECT &&
-	    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-		paddr = ((struct setup_indirect *)data->data)->addr;
-		len = ((struct setup_indirect *)data->data)->len;
+	if (data->type == SETUP_INDIRECT) {
+		len = sizeof(*data) + data->len;
+		memunmap(data);
+		data = memremap(paddr, len, MEMREMAP_WB);
+		if (!data)
+			return -ENOMEM;
+
+		if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+			paddr = ((struct setup_indirect *)data->data)->addr;
+			len = ((struct setup_indirect *)data->data)->len;
+		} else {
+			/*
+			 * Even though this is technically undefined, return
+			 * the data as though it is a normal setup_data struct.
+			 * This will at least allow it to be inspected.
+			 */
+			paddr += sizeof(*data);
+			len = data->len;
+		}
 	} else {
 		paddr += sizeof(*data);
 		len = data->len;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bff3a78..055a834 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -368,20 +368,29 @@ static void __init parse_setup_data(void)
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_data *data;
-	u64 pa_data;
+	u64 pa_data, pa_next;
+	u32 len;
 
 	pa_data = boot_params.hdr.setup_data;
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
+		len = sizeof(*data);
+		pa_next = data->next;
+
 		memblock_reserve(pa_data, sizeof(*data) + data->len);
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
-			memblock_reserve(((struct setup_indirect *)data->data)->addr,
-					 ((struct setup_indirect *)data->data)->len);
+		if (data->type == SETUP_INDIRECT) {
+			len += data->len;
+			early_memunmap(data, sizeof(*data));
+			data = early_memremap(pa_data, len);
 
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT)
+				memblock_reserve(((struct setup_indirect *)data->data)->addr,
+						 ((struct setup_indirect *)data->data)->len);
+		}
+
+		pa_data = pa_next;
+		early_memunmap(data, len);
 	}
 }
 
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 60ade7d..ab74e4f 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -635,10 +635,15 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
 			return true;
 		}
 
-		if (data->type == SETUP_INDIRECT &&
-		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
-			paddr = ((struct setup_indirect *)data->data)->addr;
-			len = ((struct setup_indirect *)data->data)->len;
+		if (data->type == SETUP_INDIRECT) {
+			memunmap(data);
+			data = memremap(paddr, sizeof(*data) + len,
+					MEMREMAP_WB | MEMREMAP_DEC);
+
+			if (((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
+				paddr = ((struct setup_indirect *)data->data)->addr;
+				len = ((struct setup_indirect *)data->data)->len;
+			}
 		}
 
 		memunmap(data);
-- 
1.8.3.1

