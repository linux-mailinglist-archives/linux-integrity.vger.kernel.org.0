Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F74484677
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiADRFJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235661AbiADRE7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:04:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GKg7O004139;
        Tue, 4 Jan 2022 17:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dhdbwBzd4xfJBpw49vXfyyuIM34DGueZ0cfLyT0diek=;
 b=Jy6RNic6lSccdFT7AV+j4GjqQRWUtrDss5SCWI47SoHS3RnyiSlNtVRCLq1qMnOwuKA7
 xojAETF6gSBogYok4JvSRTbZuwnlyLteA7w0kF38VKhQ5qRqhHeX54KUWnLoLQiZIyJ+
 ef/PL5j76inw2IxvWqBB+CGMaY0GEa7EyK3R1g5y1+8fSSBI1fPgRg00CgBDD4scv58l
 4+yAdVkPDXys2O1Uj1WS8sFrN/Iq6Q3EMl+jfbkelJeKgS6VyyMvRq4PQxEkacnOz+Iu
 OFDwelhcgOzeAREX8NC2cziuEXVL7xVvs2WtphMU5JZfmRF/Ha5dQQgxydJbLgVCihUf dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmaw7h0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204GcPF5006341;
        Tue, 4 Jan 2022 17:04:32 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcmaw7h0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2e4E019360;
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04dal.us.ibm.com with ESMTP id 3daekbaey0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:31 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4UI825952558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:30 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17ABBAC069;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05E42AC060;
        Tue,  4 Jan 2022 17:04:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Denis Semakin <denis.semakin@huawei.com>
Subject: [PATCH v8 08/19] ima: Use mac_admin_ns_capable() to check corresponding capability
Date:   Tue,  4 Jan 2022 12:04:05 -0500
Message-Id: <20220104170416.1923685-9-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bX474UA4EWZ2L793KpPUW5SlhE0UkgEc
X-Proofpoint-ORIG-GUID: 8RlFrehJE3ljgwiYfdJfVVWhn3MwJIf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Use mac_admin_ns_capable() to check corresponding capability to allow
read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/capability.h      | 6 ++++++
 security/integrity/ima/ima.h    | 6 ++++++
 security/integrity/ima/ima_fs.c | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..991579178f32 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 224b09617c52..0c86a955cedf 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -483,6 +483,12 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+static inline
+struct user_namespace *ima_user_ns_from_file(const struct file *filp)
+{
+	return file_inode(filp)->i_sb->s_user_ns;
+}
+
 static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5b6404991b37..71302bb5427f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -377,6 +377,7 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
 	struct ima_namespace *ns = &init_ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
@@ -385,7 +386,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!mac_admin_ns_capable(user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);
 #endif
-- 
2.31.1

