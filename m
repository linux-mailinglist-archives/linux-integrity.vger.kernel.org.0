Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BDF10BEA5
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfK0Vhp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:37:45 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:39146
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbfK0Vho (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890663; bh=nOGEMAW5jBKyAP5FeUHiTRQqQX9FokxNc+64zG2jbZY=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=JbjyYRC17SdYnn9A01ZI5eBUv8I3WVWCk9ElkB9dXStkrMukSXNLOamDMTz5Rgv5IynaCuESKttaUruDGdwHkMA7f/CDbFcrXnd4QdH+vWIDZyoUhOPdt+SH9CVTm8BozIOwn8Krp4MwsBt+0MYmLFGQU/Lxo/BXijDhSZeifSZ/Gzf6E1pNQVQHwJZ+ONSw2udtKIAqKdtdXTKU70GO1jaFnntxitqVPO5CjV2a2S8RjdpMpnTedbCv9Hm27fXqEZEqE7mNFShnrndFwenhw/zAjIpwKW21wDJMXKxxDbRQWJijmmpRKpOnYiv9BfEiMJh5kMF+LHnIo+b6wqJ/AQ==
X-YMail-OSG: JncMgi8VM1kV8MaZTRJCJREEWpzBfEC8EJBce4ds0_Dim5LUFUCVIIoALE1Gsmf
 kSb4.px0GqZRmPNstAb.74pl0hgECdWWsf_nL5ZmNIQoXhVmbrUDgJjEl61j0UVsipvX62xsb_tm
 Xk8iFdt.3Tp8jiEzNnKpw3RcTK6UdDebcayuWqQKy87vv7eUvEyfjOr5QNIniv9ULgE2SB_7jHE9
 LwbLUd_WWv4AAwNtIwRa5s9EkDpAoNEEqdLHX_2uJVfUBmjXnw5AQCKHNbD3LqXY_vQhZ_45c10i
 3ET3EREjVc30vPK1Wiubs198vBjRujhBQm1EFOWc7iric2bufp8tGVRJ.lcaoTOatxwHk7R59_us
 E0cv7A4QsqaAMMciaw8b3_5gsMfUPyvam_mxpA9J8K_4jmo15_0hh88jCc.08enisztkjOBn_xcN
 gzwYg_Yde6wxU6aftGskd8DZSJe._023guf.vOBjTg5PL5S4GeUVHo6oxwJjB2rp.RpXb_o70nGP
 6xWjdcXYfz4N31sbjXxufJXv3ETJiez7dr_TvGSSeiXFtA9xRX9ADH2x.BUb73oV1HmMnyprBNw3
 Drv_fkKrLBnvOCKWL_i7E5KyZqVHQdyUc6dLwfsulVwJ1FWjUKAjQtMxnol6N7OjUix.m_BS16KB
 zmu7GNMAjV9Z7LaG6H0Kgsb6dnSlrL2tKFmz0p.fEtlkHMREYSpOmfeVfHbhgmuIFPxW6UuLyLBq
 ao8rcgPAi4bwH7Tv.QthvXLHuqPhM0OXDJ8kmB7v1nhO0iS5dFRr2vOO_5aDjICL8EVEoKXkLqiY
 hHLTKI415eZqtkZ6oKqVzj5PPlr4.ZSyoQ230SQrP6fiHHGUYHQiLYDciT.FuMWAtph4D5rOUxZH
 GMx8LVv6BQYuJv5XvylGSpbkGBHfYY3MTp6mZwMzhM6o6oPBPzJht8vs63_TLMSePxu9bOp2fpxG
 h9vbPKRUqozIwFaA47S3TG0heP93vW.v3X.4HXHxLEy3b_imCgOH2oYXOpauFT0ozvmmumWk2t_N
 tvCTBAFOTCqKm6gz3ZOkSURXBT5BGjIIVTSaqYN_1dhFBNuGp3mrS7nZYc2_rJunxR83d_04w1Vj
 AyjyA9IZWiLEqbxFDqxqDwEg2Gye9AaHMlH2qOpqkJhpq2TaJjMIOc3WCKkh0iebxwkVR.fc5jkU
 P_45nvKepgOOv8rzOD6drXJlcgp_vTwIBoYJXBxtijQBydHpegmeFEZj5jl_H.8XC3n4eua.PdJt
 xnhUKCkDl.W2keDKa.v40w7fWHooay.hDPBmrvrMLWN4uhxkJnaGKJLbAdxbj9leEQN4YM5nwX0i
 kjGVOCEmRxAJUraVFsPi0l_Muyf1rc3VSzslBXRr0_4Xr7.eYAG_VqbiObx94GHNbb7vZe2FJnh1
 um_sACqtIzK2mW4xOiIURv5yCkV1ZJWawKU97VxNfhRusXj8Za_h0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:37:43 +0000
Received: by smtp411.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 1acf01b6929c230fae5ce1ab34c8a381;
          Wed, 27 Nov 2019 21:37:41 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 08/25] LSM: Use lsmblob in security_ipc_getsecid
Date:   Wed, 27 Nov 2019 13:37:01 -0800
Message-Id: <20191127213718.18267-9-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There may be more than one LSM that provides IPC data
for auditing. Change security_ipc_getsecid() to fill in
a lsmblob structure instead of the u32 secid. The
audit data structure containing the secid will be updated
later, so there is a bit of scaffolding here.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 include/linux/security.h |  7 ++++---
 kernel/auditsc.c         |  5 ++++-
 security/security.c      | 12 +++++++++---
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 2160c160e62c..6dda1ddcae31 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -463,7 +463,7 @@ int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob);
 int security_msg_msg_alloc(struct msg_msg *msg);
 void security_msg_msg_free(struct msg_msg *msg);
 int security_msg_queue_alloc(struct kern_ipc_perm *msq);
@@ -1171,9 +1171,10 @@ static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+static inline void security_ipc_getsecid(struct kern_ipc_perm *ipcp,
+					 struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_msg_msg_alloc(struct msg_msg *msg)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 04803c3099b2..ce8bf2d8f8d2 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2285,11 +2285,14 @@ void __audit_mq_getsetattr(mqd_t mqdes, struct mq_attr *mqstat)
 void __audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
 	struct audit_context *context = audit_context();
+	struct lsmblob blob;
 	context->ipc.uid = ipcp->uid;
 	context->ipc.gid = ipcp->gid;
 	context->ipc.mode = ipcp->mode;
 	context->ipc.has_perm = 0;
-	security_ipc_getsecid(ipcp, &context->ipc.osid);
+	security_ipc_getsecid(ipcp, &blob);
+	/* scaffolding on the [0] - change "osid" to a lsmblob */
+	context->ipc.osid = blob.secid[0];
 	context->type = AUDIT_IPC;
 }
 
diff --git a/security/security.c b/security/security.c
index 0fc75a31a6bb..b60c6a51f622 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1783,10 +1783,16 @@ int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
 }
 
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid)
+void security_ipc_getsecid(struct kern_ipc_perm *ipcp, struct lsmblob *blob)
 {
-	*secid = 0;
-	call_void_hook(ipc_getsecid, ipcp, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.ipc_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.ipc_getsecid(ipcp, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_msg_msg_alloc(struct msg_msg *msg)
-- 
2.20.1

