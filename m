Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C810BEDE
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfK0Vip (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:45 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:33965
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730022AbfK0Vio (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890723; bh=NcVBp7gG9OmyqrvKJzXmDANHTV0iHKZa6J3Ph3JS0Bg=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=gTZ4eFH9xXVk0lU3yi4RowExS80wlu4mBi2Kk0Znr4yF1q9yTeBbsDcnqlttb5Jq8gjcgY2JzhJEQ5HVbMViCs1kZy+sk+75kivokSWJVkbsPb57GzreshUVVcbhli3oPG2H6GrYTHIXURJ3LXZJU2CSl0pEqYRHcpiD50Fy9GUKD6LdmM89WPr40Zlpns1Kfwc5w1tHEuN9UucLHl/ng0mtW9lQcYA3L6qvFRG5d3u+147fRy8GY0iDjEWnxLLeU1nUjQky7hmoeXLl7ikYDqrVzf3T6Oror+Qp1PouxdXtb4VMuRdkc9Kqf1Arj8Bvi1FZzRyme6l0fd0N/6y1Mg==
X-YMail-OSG: o4rW6BgVM1lIpqrUoTPqn4xybGbXeg25oIQVkOH4msbjmCVTVemd5M3IE9ojH3_
 _pVXBIS4j1Y9GrapTsNWEyk8tQ8s6Ykj.tSuV5zgCwaBuwe.286PblaX5wrqkwkhKk2Ek1Wic26j
 _tbkKMPutFxMvnxPkU8f2EpGbtH9G8SorRzVgadD.uCynL7pDJ87w7JdEKtiJedSwRYfwTlTjA3v
 bUN1rnpBr0Gox01aUVN9ehacBwh6owHDDLg3LXnowVeJvpKxTOs1R5E3makanP_TYvT_4E2Se0By
 TQ9PMBAmGJa3wZCMrJGGlZlyhMZJRoNC6FBQbCepzo2mtxH_YEdn34dKNkqszK8Ti76bNpVou56z
 IOoHe7Uda3NiWiUNe0ABM5PQ23Ax0V9saKwddAPAuxhPizRS5v8Z8npkVWE78jxsbn5UKGcRPTIr
 ram2pTKZpjoC8l33UcyTrIbgJ9H0x6A8R8bMAsF2_QoAAN4nZAfnevXxzVwnLABqZrNP0TjaqIXA
 Q16MlIV17zOCbPIREzgDKWoNg4mSUMRrCEKKpoH68KY8pAtJRWgmv1eLHdE0CAyJlZXXfP3L3j_A
 3aAzR0GecNKJDuveAbqubVzN5DtDVO9O1xgmTpxxHHyvt6X.pgEo0A6sCgvRb.yJXVWXVUkdSPe_
 oEN8ykiswX11W4VTYYDv5ZIJWC1anc8JsXa8e6gqYTez_phtNqJsPYaVZbI0.g9OG7NgoK2ipLLi
 r8JXlnQk3kS3datIDgrFPgrsywUkNHoXmhTBzIa9s9duNRbtx7c3CK.BnXRHc0n3akw.GGIamIhp
 RdJl2lm54XofuAwg0bhGU1X6SWqxZ626oucFkgBWKxTHpdqEK2cMohy4im59qqqx15Qiz4uJhwqr
 kFF1MsOsYgclMIr2Z3AUZld0HoJxf3Mmg7C0RcEDMnLVlib2B66btvSrz9mgWVuKh_TVOztsOEm0
 BNETnEpAGWaB.6QPD3ALgKIqEWC73dMgY6D7YdnRtBT4HsYmTWeh4RqDzh4Ijk7jKBeopmLYwDSj
 jjxBkP48zYXE0R0q0or9wxOIx6xqWwahp0xVfV1A8B28EO77VPqqrxNu77Alf56TOE2lapWnDXAx
 lcCrxKqd06UewVYkcojzaoZO.Zo6uw8TiTHDFSYTg8Q7Q24tTaVtPaixffpSuE272V.yogFUCUsw
 5FXomPymz1pme51hrxOJuVRBjKE7BYQwt0Aakzax9UBFTGRnX303eLxFcl3WsfEu9UgzVerzy.ha
 uBsX72Z1WaOuSuZjWH2qPTuwVS7W_WpHj._5lCL2kd85hnBzMlsuQR63v23TzcqXNTyBcXBjcFFs
 IsvI2ljlUHXIJ6.bp10MvUShtGampNcaYtzkzeyKTaOOg8qSe53BYbSR2ubQFlMp9J5XsA_mJYnX
 pJiQ2Z4ByovPHoHJ1168WGZo9Qb3jRkOLv3i16fbcaxZ4N4SZ9FwaoFE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:43 +0000
Received: by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID df40377f3a8f14ef88902c77347c2a15;
          Wed, 27 Nov 2019 21:38:39 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 24/25] LSM: Add /proc attr entry for full LSM context
Date:   Wed, 27 Nov 2019 13:37:17 -0800
Message-Id: <20191127213718.18267-25-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an entry /proc/.../attr/context which displays the full
process security "context" in compound format:'
        lsm1\0value\0lsm2\0value\0...
This entry is not writable.

Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-api@vger.kernel.org
---
 fs/proc/base.c      |  1 +
 security/security.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 950c200cb9ad..d13c2cf50e4b 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2653,6 +2653,7 @@ static const struct pid_entry attr_dir_stuff[] = {
 	ATTR(NULL, "keycreate",		0666),
 	ATTR(NULL, "sockcreate",	0666),
 	ATTR(NULL, "display",		0666),
+	ATTR(NULL, "context",		0666),
 #ifdef CONFIG_SECURITY_SMACK
 	DIR("smack",			0555,
 	    proc_smack_attr_dir_inode_ops, proc_smack_attr_dir_ops),
diff --git a/security/security.c b/security/security.c
index f1fefa187ef8..7e5353f98988 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2099,6 +2099,10 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 				char **value)
 {
 	struct security_hook_list *hp;
+	char *final = NULL;
+	char *cp;
+	int rc = 0;
+	int finallen = 0;
 	int display = lsm_task_display(current);
 	int slot = 0;
 
@@ -2126,6 +2130,29 @@ int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
 		return -ENOMEM;
 	}
 
+	if (!strcmp(name, "context")) {
+		hlist_for_each_entry(hp, &security_hook_heads.getprocattr,
+				     list) {
+			rc = hp->hook.getprocattr(p, "current", &cp);
+			if (rc == -EINVAL || rc == -ENOPROTOOPT)
+				continue;
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+			rc = append_ctx(&final, &finallen, hp->lsmid->lsm,
+					cp, rc);
+			if (rc < 0) {
+				kfree(final);
+				return rc;
+			}
+		}
+		if (final == NULL)
+			return -EINVAL;
+		*value = final;
+		return finallen;
+	}
+
 	hlist_for_each_entry(hp, &security_hook_heads.getprocattr, list) {
 		if (lsm != NULL && strcmp(lsm, hp->lsmid->lsm))
 			continue;
-- 
2.20.1

