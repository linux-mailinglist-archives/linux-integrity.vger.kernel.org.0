Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993B94BBCCA
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Feb 2022 17:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiBRP72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Feb 2022 10:59:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiBRP7I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Feb 2022 10:59:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FAF5F241;
        Fri, 18 Feb 2022 07:58:51 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IFqrT8005631;
        Fri, 18 Feb 2022 15:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=R9kPkwE5y3sVhsikMfp0cqENuFfYnDQHr44i0rs2NlQ=;
 b=ipsOSllTsu2fbdKgdOhazQiCegA7OeVz1aa7lFBWyqPKQ0bFuzCR+Xgrj/Eb8KCOxAI3
 mga1YCA4HIYl3pGQabp88RBsQejeZGe53Yna4a+wAcYynuzgGxII8hWzpLYIxkXfavoP
 8VyzAGw9zGzfhbKvoyKvpW2pYVGMF65m+6fqsDS+vyjB8ShuZ+ENAylaMK3hBooqWfjD
 ErBksBSY9G56b+mzYpqDpWP23SOo6IFqaYmZRsfpnBMBw42OgwZKoF6sUPlIeMxaBsu7
 ZzWzZCnsO9/5BaGP+2K2i4hcQ/bUZeoLAaAFDmWqWWqR07R7RM+zv7rCDNoSyG6cKL/q 6g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nb3sf35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21IFueJP062787;
        Fri, 18 Feb 2022 15:58:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3e9bre21gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 15:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrcuzAVAcIVTvC0VYjExwEzG+CFt572IYtiDN4uEcxU2pCORYqdTFfrgMX+VPbfhm9IEW00VB9B50LFBnhRKmL9d4i/jTQ9VA6rjoxBoDTV3KVimupT5F/Xp7knCb7SMBAB/7xzWMBivxA1FwvJVLdxgd1ExhTSsVvgy/0d/ZwyIB1VdUuswJDUebALMsFIo9yywvipxHq536aeg9jTMY/L/V3Lqz+JhUCSP63Vqpyx3yQTmjAXAjv+imsdkepajzHIactJPgUbIxUq6H/MjDPLslaLngWDV4C2L/6gHlTIdA+nDIMGrbOlJb9+7jJNNMlX6mtiCjAuQxKqnd8h5Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9kPkwE5y3sVhsikMfp0cqENuFfYnDQHr44i0rs2NlQ=;
 b=ebrN4B+TXgjto6V5KwbGH+aTM4y7nx6xq7cNvfFMgYRg+nFSr1Wq4jy6g3yMlgmGl1HJIMsrgB7l7CdBjFa/4N/UD9kOfc62VMYu+E3UvScUxpOm5hb8XVUz4I0NI4MdlAEwWDiueZYuJaWIWX6MR+qVniGCoLaphilUx0/mBQxuG9C4IwXd9StwY8fEdNw52OsQGJxkp615MKMqwojocsZLi7fuf+DLy+F0IT3Nwnw5xAjdsOLpMaJAsdT1s8TShd5XxueHYBHnQIa3qa+emIvGGA77hcYcuTE73Wag3X8uX0m6MIE+q43mGZXG31KDY2EKfjnbmGeid8AJIlivKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9kPkwE5y3sVhsikMfp0cqENuFfYnDQHr44i0rs2NlQ=;
 b=Y3amsy8q7vmQ2IvWGrvYyMub5gMWu5FEnAJHTKlVwnuITkZ7QmUCy1nmasdjyDfC4wqH6sdGQCE60vRqUI7UwLxnXU7lUUbkjpbjH2M+v9ESVo9o2UdZA/i5o10T0F5qDuZQWUHNBkqOH0Va2WVHCwsWsL0lxL5AJl2EGEd2w4M=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 15:58:25 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::398e:10a4:6887:4e18%5]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 15:58:25 +0000
From:   Ross Philipson <ross.philipson@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org
Cc:     iommu@lists.linux-foundation.org, ross.philipson@oracle.com,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: [PATCH v5 10/12] reboot: Secure Launch SEXIT support on reboot paths
Date:   Wed, 16 Feb 2022 22:54:43 -0500
Message-Id: <1645070085-14255-11-git-send-email-ross.philipson@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
References: <1645070085-14255-1-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0288.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::23) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2536fb-61c7-4db3-90f3-08d9f2f77ef2
X-MS-TrafficTypeDiagnostic: BY5PR10MB4226:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4226646A1CAC40DE2BBF6057E6379@BY5PR10MB4226.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iu8A3mUylBUEAJPMXAZ2iHV1pYstX0ctbMaXK2gkVYV84qcNi6blrjWw5BVGEe0eWM+018VGeoxyXac8olmZC0oWAoHGKJOc3G73taDGNEpnlkrRPNVRo+naMPAoaoHpRU0dDuNoSNlTrm+kxxnq+q0Jni/3MPtLnqa6VlR8liRbiWSiT4geSXh4VCRpJ+CJUgffdvQfQzyBvrw4LzgZPxvtUDU09Hmev7A6NF8DFnfasS2/e03zCMP9syu36XkiquJS8LMbIVNR8p2fNosHy9sq0FCl3KIphAINoa8pstup1cJUIuEvBcVlfe/VcIdAoRD+xvefLtadMbeWJFZf8gi/KNi//ufCBTonrkbBSoFvdcmU6EnUOlXeVDWkN7s/bOs1TFrdmBjfRfJ3pcpqPTR4KAypSYnJ2CA+JxDBGsrDmjoKDdUcv/4DgV7I2xsfPp+HEiswEw1I7M3HaZ5A/Y9T6blZWFjoHRQUZ6ysgx4Jam047kfY+C5GD6EROmMn4OKef3MOMVXLVgy7lUM2RysGSxG9BCAULzfnPq3U+miktn73lLGuPeo8o/bHAUwylIOKkI1gDT+hfXbdjf+OxsnTmrep+0iK4NHqAi6U/W9gumPcpqB60V/YZaMFVv3h5XkI16TePDLnXnDpJclx1s0CWErYAbfa0gcmles5R8QZ/TJ0L5eKKaLkWH92VXeSB11E+QjDWQVZ3bbTb/hPPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(44832011)(86362001)(5660300002)(36756003)(6666004)(7416002)(6486002)(52116002)(8936002)(66946007)(66476007)(316002)(2616005)(66556008)(6512007)(38350700002)(38100700002)(186003)(4326008)(8676002)(508600001)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwnLwb2utPeXNp5HN+RDOjrf01G4GNd5mfTpiBlO4+Z9Fzf0M3W6hNg/HFDJ?=
 =?us-ascii?Q?4vab5uOIybzSBeJjw0NurDO4lGkiVPE47CtiorWQaX4noDgEZ7mnSQX/lfEi?=
 =?us-ascii?Q?2wk2E/mF74o7Ul5IyKs/2NGbOilMUIlA/W035Lasz73RXtBnJzQLZcAt0qwI?=
 =?us-ascii?Q?d2SoibNvwSa1pdTgcPhm7mz5JXlVIKomD9UElEg9S6VbnxxRxH8GpU//x70c?=
 =?us-ascii?Q?WEjMoapu44r0YxQ6TV3KRfrQwwra9S2wHcPbpO5kjwmHyfsLeeGHymWCJoaX?=
 =?us-ascii?Q?tbrAJLgioKBh2YjKHVy9YELeVsG01VmYggmccb4OJVE/YkFIe7E9MfO67I0/?=
 =?us-ascii?Q?MFZ9dgVEAvrS9Zc/Cez2AwJYcGL7V3HBingoZNC0/RqRQ57ayiSa2akJaHaG?=
 =?us-ascii?Q?xVA3B9i1AWl3PZNoiRdhtj67AHKW0GeaC2OABgJIPPrRI1JWrVqLu4yKneLN?=
 =?us-ascii?Q?xMSMoWLxkOHYwjwv0qPzxKAT/AtAt55ASZ30U0tsZreqeDjR8nHR/bUx0o92?=
 =?us-ascii?Q?cFTJwsX4LH0NNMD3DNrimIBRsa/c5pyw29PqvQd2m8lTvIgI+128As7c67cQ?=
 =?us-ascii?Q?JI38kKadyzZF3U7ktnQ3TGM6eFwlRze+M3NLsirOtVTOySO3UP9SSM/Wnt8n?=
 =?us-ascii?Q?oDFebWvdlOzCuOh/8lGbKt4GS97DIHqiG6MJdfsqub+j2WBa6xNAEJsFNiUA?=
 =?us-ascii?Q?5/Xgtjl2NjptBUnIco6Yyd1FVdxAkbtOKE22Z3OUJWPnLySoX2gAQwz7s5yY?=
 =?us-ascii?Q?RbH/1RTn7v966T64O38PV5hil2yhk7widS5RAAMFbjdWEKGylmP689+Vr9Nr?=
 =?us-ascii?Q?VOLyxAcI3cOFYajgbHuky1TE2o4eKsdiiy9GE83ElXUIGNxQ1ZWFGZusxWKM?=
 =?us-ascii?Q?+UoB8WpZZzRxztun0zf1rYu5JH9ZMwthWfUfy49rZzrWIBAN2QxjbHS0vG3J?=
 =?us-ascii?Q?VZQ9GDz3iu12FVPANj0XTKjsfdM+pdTXiZnav0lYRdtd1dkh9i4KB7DahTnk?=
 =?us-ascii?Q?6MV/z/Cbwr91doUfgD/36g1hYHXYl/9WXpDhCt4A090y5vxpNtcrkieqEurd?=
 =?us-ascii?Q?2gItyyYf7mNVeVGYqfegxk3rQDd9+jfL26EeYm7X5obkRPaRZhghtk6JoAJI?=
 =?us-ascii?Q?mE0LHq5FiPMDzfHDmPRURvLLSWH/u3NQyzhiU4sEEBpq2mHtoGa++DXaTxo2?=
 =?us-ascii?Q?W/8qWoc8rJ52e87H/sNKEiVs3Ug7E1sZsmDpS9KEzzE2OGylWn36nLyBS16v?=
 =?us-ascii?Q?2losHg4W0fJ/oNRMDUqE01i9VMsOTA8YbJqs8Xbb19kEakLIWUYVbGUfdgbD?=
 =?us-ascii?Q?bsUClmjg9AsYM7wKbKBlE23/0BZsEfyyExILVb/ZAFv9oD9aXQHtTZXMt6B+?=
 =?us-ascii?Q?dimbugZCXoxBq6SRvUfN8aWL/xhxS+oCWcRx5kgX4N4dOsDDJgG/2m/wZ0Tk?=
 =?us-ascii?Q?xluGy14P0OJVCECTqoEkh4ZYx9q0co47B0XsJDKnJWct1MJMzQFpJken3nSd?=
 =?us-ascii?Q?yfPAAk/oqbsbjmCTk4TN9cfx6BD0zg1ufs721bKWY4gMo7KzNCl5DmHOyhy0?=
 =?us-ascii?Q?+MoFJClS99zwJUU805DTFUT8UbGc6kQKi1HouaxPZ0NCbcdS+LeZ4fQl0Z12?=
 =?us-ascii?Q?2QOpUYcHG9PRv3OTvJoaJX/YEo21PWt9X8vfDoKs28wzrOWm9IJlMxcHh1Jh?=
 =?us-ascii?Q?3P4IVi02JtjAE7WQAUEfgtUfoIc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2536fb-61c7-4db3-90f3-08d9f2f77ef2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:58:25.2493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ2Lwn9nEW2MoVXggk0HnmlQIR61MKs1WtzancWCdpXacfzWdgn0eRlf50LIqNnm8Qy3PmDTEGxCQGpFr95+7RR5GmoCSkfeLatJzDlsUkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202180103
X-Proofpoint-GUID: fWmPhsS6iN1A-MowHYk-mYohDrL2H8c4
X-Proofpoint-ORIG-GUID: fWmPhsS6iN1A-MowHYk-mYohDrL2H8c4
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the MLE kernel is being powered off, rebooted or halted,
then SEXIT must be called. Note that the SEXIT GETSEC leaf
can only be called after a machine_shutdown() has been done on
these paths. The machine_shutdown() is not called on a few paths
like when poweroff action does not have a poweroff callback (into
ACPI code) or when an emergency reset is done. In these cases,
just the TXT registers are finalized but SEXIT is skipped.

Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
---
 arch/x86/kernel/reboot.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index fa700b4..96d9c78 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/slaunch.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -724,6 +725,7 @@ static void native_machine_restart(char *__unused)
 
 	if (!reboot_force)
 		machine_shutdown();
+	slaunch_finalize(!reboot_force);
 	__machine_emergency_restart(0);
 }
 
@@ -734,6 +736,9 @@ static void native_machine_halt(void)
 
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 
+	/* SEXIT done after machine_shutdown() to meet TXT requirements */
+	slaunch_finalize(1);
+
 	stop_this_cpu(NULL);
 }
 
@@ -742,8 +747,12 @@ static void native_machine_power_off(void)
 	if (pm_power_off) {
 		if (!reboot_force)
 			machine_shutdown();
+		slaunch_finalize(!reboot_force);
 		pm_power_off();
+	} else {
+		slaunch_finalize(0);
 	}
+
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
 }
@@ -771,6 +780,7 @@ void machine_shutdown(void)
 
 void machine_emergency_restart(void)
 {
+	slaunch_finalize(0);
 	__machine_emergency_restart(1);
 }
 
-- 
1.8.3.1

