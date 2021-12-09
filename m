Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91446E31D
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 08:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhLIH0E convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 02:26:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4235 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhLIH0D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 02:26:03 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4J8lnm3T3Kz67yRx;
        Thu,  9 Dec 2021 15:21:16 +0800 (CST)
Received: from lhreml727-chm.china.huawei.com (10.201.108.78) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 08:22:28 +0100
Received: from lhreml738-chm.china.huawei.com (10.201.108.188) by
 lhreml727-chm.china.huawei.com (10.201.108.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 07:22:27 +0000
Received: from lhreml738-chm.china.huawei.com ([10.201.108.188]) by
 lhreml738-chm.china.huawei.com ([10.201.108.188]) with mapi id
 15.01.2308.020; Thu, 9 Dec 2021 07:22:27 +0000
From:   Denis Semakin <denis.semakin@huawei.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Subject: RE: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Thread-Topic: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
Thread-Index: AQHX7IGL3eM2VvpvvUagKdVUk4BPk6wpv2mA
Date:   Thu, 9 Dec 2021 07:22:27 +0000
Message-ID: <0299fefc764b453a9449b0df2ca06dc7@huawei.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
 <20211208221818.1519628-15-stefanb@linux.ibm.com>
In-Reply-To: <20211208221818.1519628-15-stefanb@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.133.14]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi. 
My question won't be about capabilities. I'm wondering how IMA-ns which is associated with USER-ns and is created during USER-ns creation
would be used by some namespaces orchestration systems, e.g. Kubernetes?.. It seems that it can be run without any user namespaces... 
Their community just discuss this opportunity to support User namespaces. (see https://github.com/kubernetes/enhancements/pull/2101)
Looks like currently IMA-ns will not be applicable for Kubernetes.

Br,
Denis

-----Original Message-----
From: Stefan Berger [mailto:stefanb@linux.ibm.com] 
Sent: Thursday, December 9, 2021 1:18 AM
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com; serge@hallyn.com; christian.brauner@ubuntu.com; containers@lists.linux.dev; dmitry.kasatkin@gmail.com; ebiederm@xmission.com; Krzysztof Struczynski <krzysztof.struczynski@huawei.com>; Roberto Sassu <roberto.sassu@huawei.com>; mpeters@redhat.com; lhinds@redhat.com; lsturman@redhat.com; puiterwi@redhat.com; jejb@linux.ibm.com; jamjoom@us.ibm.com; linux-kernel@vger.kernel.org; paul@paul-moore.com; rgb@redhat.com; linux-security-module@vger.kernel.org; jmorris@namei.org; Stefan Berger <stefanb@linux.ibm.com>; Denis Semakin <denis.semakin@huawei.com>
Subject: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check corresponding capability

Use mac_admin_ns_capable() to check corresponding capability to allow read/write IMA policy without CAP_SYS_ADMIN but with CAP_MAC_ADMIN.

Signed-off-by: Denis Semakin <denis.semakin@huawei.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/capability.h      | 6 ++++++
 security/integrity/ima/ima_fs.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h index 65efb74c3585..991579178f32 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -270,6 +270,12 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 		ns_capable(ns, CAP_SYS_ADMIN);
 }
 
+static inline bool mac_admin_ns_capable(struct user_namespace *ns) {
+	return ns_capable(ns, CAP_MAC_ADMIN) ||
+		ns_capable(ns, CAP_SYS_ADMIN);
+}
+
 /* audit system wants to get cap info from files as well */  int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
 			   const struct dentry *dentry,
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c index 0e582ceecc7f..a749a3e79304 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -394,7 +394,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)  #else
 		if ((filp->f_flags & O_ACCMODE) != O_RDONLY)
 			return -EACCES;
-		if (!capable(CAP_SYS_ADMIN))
+		if (!mac_admin_ns_capable(ns->user_ns))
 			return -EPERM;
 		return seq_open(filp, &ima_policy_seqops);  #endif
--
2.31.1

