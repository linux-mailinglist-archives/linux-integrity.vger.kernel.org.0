Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01ABC45B181
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 02:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbhKXCAD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Nov 2021 21:00:03 -0500
Received: from sonic315-27.consmr.mail.ne1.yahoo.com ([66.163.190.153]:38850
        "EHLO sonic315-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239250AbhKXCAC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Nov 2021 21:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719013; bh=Dj7UHpYVHqjreTElHiNwWdnVgmwqS6TZW/D5C04dUtQ=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=NqdLoN0bGrVaAkT+N317jnrsd1ySsXQgj/0XGUYrFcIBwf7JzTo2WgnYmiuxZUXoyV0E6gdNU+xOrkOSNf5KpgXJ9bWbNAfOj+ELfcbwQ73MaeAad9EGiGAvFD0tff/kLfu4TVl1c2dqb0gOZHOkdQAgjC2S3/eIg9I3QJ9AsSxCoPkZve6gUpYCsV0Djsamce/I0sH/1Vf+A4wi1nxY9VWcnW1HShPP+GjVOhDwtZlNcD0sxmNTmDZfMXYKcX3LpAINmq8QrWpczgVv8EYR0FYCbxd3KrVizG0bL+6+fRy9Ze5ijCaELMba0ehnS/07GX/+csldp697adOr7hekIg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1637719013; bh=O0p7Vi0jlbIBk2Fq3kmz7Q05SRuEuccaOy+7KehXpRi=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=GazG4xdXapBuP/utgJGtuhk3T7zaxesEhXCUGh+WYGvuX9ktV0oSqNGyRgwOmkEVl/fLqfrFB03QP0zAqf42yDuSZFx9S9nTS+plDksyKpeLBAxVHwUPjqmiXEn59hnjIfhFZpC2buOICnI4kSIhnSOMHCY6htP7dksYdmMEYfoBHUt3Zbt4+BUcZyLbaxCdTh7Mlq4YujUgd2Kd9yqwSnaPTqXwvA29Ik+6UMbobPJ3Q5UDOyMgHeXout8tbX1QZY9pQv0eFZ5Ms8gnJB9m9KpfyhwqZkKVQ32XyFR/IKR/KKR6xwwP0yhXa4bSpAeFaE6wTgnAC7f9Jegc7XeXIg==
X-YMail-OSG: V.gSpQ8VM1nWy8qzWKQr6R1J4c851j40XxQUZQeu59ltimeLpWCHnk6ZbMrOmzp
 Etk_eM.PXBl2QlhUKic0TW2l.PPBWc9jQAoUDPKM_JKd1OfODO1m2OOVV5LTMwwN0w.LuW_E1HKu
 cZ.hGASL.VakE0hon8gL6B5v2W6ihjiFO.1.DnN4i3SoKONZDiSpBSDlYuitcxim8NjhYpFE2b5z
 anpOQSzQgIyoXNvrn1V13rwPXquXUV2xPI0HdMxUy0HoQigQZgBBMaQ.b.a87QAiowM0NS5vhpRn
 6bFQCTU1w55Kn3p2NVg62Lw3U7LQ6MhHU4PUeV0SivpsGKBGhbKgpItFMS1w0TR_1xT0_5DWRQei
 eiEQrHofZ5ldHWLgDAz7xqAJpr16ctW2ajEStLPxHspR7KPDXwn8TyVSt2_myzJ7dS15uZRvPY5W
 K69_tftApn3n0z08LuSKVL8KvMFa3eW9WSXHDFdI6.K65iGv9sRCfp8CkwiVElJ4p92fJ9LIV0s_
 .UnUeaFTep0G5m9PWlIzs61i5HxN8IX9MfDryfs7raizjTB02e_GIe4b5sXeqUUrEyAZiydifX25
 mi5PZKhICuXb07tQWIQnEnzvOLQs982EIY_220GUfEz30630mL4xce7c8gsa.bmzSEI74.3u.yMV
 VgPEgzXWfIl.ddTZn8xWh.VtjiWuTV8hntAK5h5cvXHNS0lNfHMbkjLv37dFjbvajQnD5C2RfzeD
 QAFDWbPgEWvQgkwYC3rHXn5b7QQCKcpcvuBg2vKAJ7zZZJccacqO0xlE8tWJo0YEOQ1P6j4YncRl
 QH3OUCtMbCaf9B6K0WcckFzH5UrSekPIz57bhTMKs2tk7xdBlsOOltm5aGPaMuHRwQoH0oy3uTak
 pYbVIlt0HLQV92WFTK36Exn0M83031bi4vOuRcSv2jCd7YuZYR6ClSyM7xlDxlM2mp9e5SOcaJlP
 8ImNo2o3fY2OCWbioch3HnjmIY9sjzlpOn2y4cDFMmMnnxVYZElV5.XXlNqyWNRahWp3MbH6yf4O
 unOF31IogQd3zCVpX0YWCCVoy3p_sbl15Xh.PjSS9fjwSr1DHREl75Le_7xOxg47UzghI3p3KS2h
 bBreBBauPJq3IXQI_1qMQweg_KGF3tiovVQeM78El2ujadogm3NfM8oBqCo2cidG5qAbvyc3oSYI
 2fBz8z8Z7SXaK5AjNbaZtaum.vgd8TSbVljiWrugxvL7TYgpS1GQdyr3n43geX8lqpm_d6L_vJsV
 Ob95rs8XaAfVyo91.uQ2kx3nEDUgjPRmrY6GJNJi0i0g157I.sd96WLPT5BaJWMQhoc3ZnEne5EH
 6Qj2K1ERrdQ6_LqNultcUQ6127mAyq_4hClNFiYExlW8MpBsbBKX6d_ITDRaMkvNDmT2J3hSevSN
 iZiqwZKaZx512.J6Nyi_01myNOEf96DBcAV_0CJCoqAIF4TfxFblNt4tIVOphauJFxkLLjLxnJbS
 E2ErpWzZnz38SWpHU4jla7XnUJEdQ6E6IdBijoOCc.T9l1lK9OtmGezClL4eDH36o57_B86ozhLy
 YRGU5.Jp3KPotCXrBA80TRynUKDI0H2eenhs5qyCVsVeBwV99XIkIDqAKLY734R8xcskDpYbnL1N
 IkCSY9L6V_TeokpyrrfDE2kZFJHVHZgJdtbMoAbDnaWT3AsOXjzUYjyR4cjsERtcIpVQGBeUnf0h
 26kAbIEfylXKCSO2tXU9X49TeaZ1BehPq6k1TjqXg9vZMYU2E1cP97UUSBpxLDDgSJJrHRAiJd80
 Us8Ld7T4PhNMRlDqJGnjXuLie9E973DA0_geOAKSVKyIix780K8ofkBC9h.fipdH7nN_PPjrnqz.
 pUDcI9B6aktSomVD9AucIGQ4iKGeKPC0X2VOI4PzEsM7hY64C2R6oTWdKS0UWuQkTm6YG2yIwkPR
 i2iVt9WT81F6E.TVCs60l32jixFGFHPSxCMidisNZzngqTidQksJtgCKv9tUK0LAf60LlNOyAkwr
 syBr5Z8nsHrN4Koha1eL3sT6aePBCo3Y8b_hYJqJKl4109YvWi45gqw0ezBgoSvPnjqVnDP4unOd
 EwKx0SzYm1jKXSE80oYVpDwG.KC0RuCVZHVOadJeIYkmqiJvKbApT2SYIPdYMx397GSX8A82fQTQ
 ouxRpqc1XW2i3Rk2ZRM3.Y17TzoxTgy35PjoimHW5M3BsSlC5CjLp0I_cssQRetPhJWfr.9sxMai
 _n0tKxjC.TbtfhAgDtkPHFjrHnFNfOuiD1NdjOz5YQ5VeQ.5Oj7KhEPpG6BSUYbPf
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Nov 2021 01:56:53 +0000
Received: by kubenode511.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 64c89d686737995e38e1628cf5806ab5;
          Wed, 24 Nov 2021 01:56:50 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v30 12/28] LSM: Use lsmblob in security_inode_getsecid
Date:   Tue, 23 Nov 2021 17:43:16 -0800
Message-Id: <20211124014332.36128-13-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211124014332.36128-1-casey@schaufler-ca.com>
References: <20211124014332.36128-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the security_inode_getsecid() interface to fill in a
lsmblob structure instead of a u32 secid. This allows for its
callers to gather data from all registered LSMs. Data is provided
for IMA and audit.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-audit@redhat.com
---
 include/linux/security.h            |  7 ++++---
 kernel/auditsc.c                    |  6 +++++-
 security/integrity/ima/ima_policy.c |  7 ++++---
 security/security.c                 | 11 +++++++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index efd6e88d57b1..f324acc2c029 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -457,7 +457,7 @@ int security_inode_getsecurity(struct user_namespace *mnt_userns,
 			       void **buffer, bool alloc);
 int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
@@ -1009,9 +1009,10 @@ static inline int security_inode_listsecurity(struct inode *inode, char *buffer,
 	return 0;
 }
 
-static inline void security_inode_getsecid(struct inode *inode, u32 *secid)
+static inline void security_inode_getsecid(struct inode *inode,
+					   struct lsmblob *blob)
 {
-	*secid = 0;
+	lsmblob_init(blob, 0);
 }
 
 static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7cd70a43408f..3123c97d13b3 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2239,13 +2239,17 @@ static void audit_copy_inode(struct audit_names *name,
 			     const struct dentry *dentry,
 			     struct inode *inode, unsigned int flags)
 {
+	struct lsmblob blob;
+
 	name->ino   = inode->i_ino;
 	name->dev   = inode->i_sb->s_dev;
 	name->mode  = inode->i_mode;
 	name->uid   = inode->i_uid;
 	name->gid   = inode->i_gid;
 	name->rdev  = inode->i_rdev;
-	security_inode_getsecid(inode, &name->osid);
+	security_inode_getsecid(inode, &blob);
+	/* scaffolding until osid is updated */
+	name->osid = blob.secid[0];
 	if (flags & AUDIT_INODE_NOEVAL) {
 		name->fcap_ver = -1;
 		return;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 22952efcc0b0..34ecdd7b01f5 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -625,7 +625,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		return false;
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
-		u32 osid;
+		struct lsmblob lsmdata;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -637,8 +637,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
-			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			security_inode_getsecid(inode, &lsmdata);
+			rc = ima_filter_rule_match(lsmdata.secid[rule->which],
+						   rule->lsm[i].type,
 						   Audit_equal,
 						   rule->lsm[i].rule,
 						   rule->which);
diff --git a/security/security.c b/security/security.c
index 1b9f33097216..54b5dbe63265 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1550,9 +1550,16 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 }
 EXPORT_SYMBOL(security_inode_listsecurity);
 
-void security_inode_getsecid(struct inode *inode, u32 *secid)
+void security_inode_getsecid(struct inode *inode, struct lsmblob *blob)
 {
-	call_void_hook(inode_getsecid, inode, secid);
+	struct security_hook_list *hp;
+
+	lsmblob_init(blob, 0);
+	hlist_for_each_entry(hp, &security_hook_heads.inode_getsecid, list) {
+		if (WARN_ON(hp->lsmid->slot < 0 || hp->lsmid->slot >= lsm_slot))
+			continue;
+		hp->hook.inode_getsecid(inode, &blob->secid[hp->lsmid->slot]);
+	}
 }
 
 int security_inode_copy_up(struct dentry *src, struct cred **new)
-- 
2.31.1

