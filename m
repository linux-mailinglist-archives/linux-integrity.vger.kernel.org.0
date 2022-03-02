Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC354CA65B
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 14:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242397AbiCBNvN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 08:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbiCBNvG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 08:51:06 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75590BB57E;
        Wed,  2 Mar 2022 05:50:23 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222CawG7032401;
        Wed, 2 Mar 2022 13:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=98t5NBbNUIozGTEu7R+ZhrwWH9g2mxaLqLH4YadnBos=;
 b=jojM+/1CMJmglp2BfJzL2JYQ/iM30cp0zDsSkJFaql53ppq5t3IUCKqVaBDa/HPdMMAH
 CEwAkMkzvNbJ/1kN+/K44rALPXIjAsnLR67EoSV+ZP3WN7Mi3kWy/ueHFDS87RDaiK49
 aXRvWiJaz5X1eVGmK+/XHt8Zxb9Y9k0D6y67wQxC53ztvcfZOE+ArOapWq1Kd8Ce0gmH
 Tl3082Bl8WIPRbC0JybrXRcK2jO9FZBsgyguTsBJANTtPd/pguPs7AqeihC4m9p5kGdq
 taqYgmmitHHswi+K2XTSsVA+M27otZdooKLqgQ/9ppLSdO0MrY2YHMCfaS7+1ighnzxk 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej4h3r92g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:01 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 222DQ9Fe025734;
        Wed, 2 Mar 2022 13:50:00 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ej4h3r91w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:50:00 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222DnCt6032202;
        Wed, 2 Mar 2022 13:49:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3ej75rh31v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:49:59 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222DnwGj40042816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 13:49:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A717011206B;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B28B112071;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Mar 2022 13:49:58 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
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
Subject: [PATCH v11 12/27] ima: Define mac_admin_ns_capable() as a wrapper for ns_capable()
Date:   Wed,  2 Mar 2022 08:46:47 -0500
Message-Id: <20220302134703.1273041-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302134703.1273041-1-stefanb@linux.ibm.com>
References: <20220302134703.1273041-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CC8yTQ7Yp7CRKOPWGftFmxDyxy-VfQUG
X-Proofpoint-GUID: QhXAoxzHDTY9qQZOP2jx48ojn2Cu7J6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_06,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Define mac_admin_ns_capable() as a wrapper for the combined ns_capable()
checks on CAP_MAC_ADMIN and CAP_SYS_ADMIN in a user namespace. Return
true on the check if either capability or both are available.

Use mac_admin_ns_capable() in place of capable(SYS_ADMIN). This will allow
an IMA namespace to read the policy with only CAP_MAC_ADMIN, which has
less privileges than CAP_SYS_ADMIN.

Since CAP_MAC_ADMIN is an additional capability added to an existing gate
avoid auditing in case it is not set.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v11:
  - use ns_capable_noaudit for CAP_MAC_ADMIN to avoid auditing in this case
---
 include/linux/capability.h      | 6 ++++++
 security/integrity/ima/ima.h    | 6 ++++++
 security/integrity/ima/ima_fs.c | 5 ++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 65efb74c3585..dc3e1230b365 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns)
+{
+	return ns_capable_noaudit(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */
 int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 5bf7f080c2be..626a6ce2453c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -491,4 +491,10 @@ static inline int ima_filter_rule_match(u32 secid, u32 field, u32 op,
 #define	POLICY_FILE_FLAGS	S_IWUSR
 #endif /* CONFIG_IMA_READ_POLICY */
 
+static inline
+struct user_namespace *ima_user_ns_from_file(const struct file *filp)
+{
+	return file_inode(filp)->i_sb->s_user_ns;
+}
+
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 89d3113ceda1..c41aa61b7393 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -377,6 +377,9 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+#ifdef CONFIG_IMA_READ_POLICY
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+#endif
 	struct ima_namespace *ns = &init_ima_ns;
 
 	if (!(filp->f_flags & O_WRONLY)) {
@@ -385,7 +388,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
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

