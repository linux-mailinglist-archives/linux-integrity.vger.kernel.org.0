Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335B210BEDC
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 22:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbfK0Vip (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Nov 2019 16:38:45 -0500
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:33945
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730265AbfK0Vio (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Nov 2019 16:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574890723; bh=AnMCoo8whYMS9LxrvVzuREBP07j0k39Hd31LTpE/YIQ=; h=From:To:Subject:Date:In-Reply-To:References:From:Subject; b=So9OlESFHhQgezMj3V9CN9/ed0bse7NstGmrvySuYeEscJe0CepM4DMO5ppPN79bvknw6z5sN/2XctlbwCyq0FyGLYL1SafsPQrAOi4uZKxRpFJlvnm8GujgfB54gA6xnokotz9pdQ2Xd3av96aI5C2sfw6h1gsBrPnLZqJ+Bfllsf5QI+eKvxa/F/qgIE+xN1QNylPD6JSohXVx7Pgsy4OtDZ8CQqLdue3g6Cz1TcjJ2ahBWG/4NWoCHM+fuPZvnU768dRRC5O2bXg6x0otuqahymLONEfifp74eC3rbweOI4O89Wnf26CjIt9BWW1bbq6RhDsJ7VeW6uPBJXgFBQ==
X-YMail-OSG: rLKUncoVM1m9.pMCu.AbqlKD5.i.KBHjJ6aDHLegMMaKVLAOndMlaye0yOkoc.Q
 lUm8zxdjrgRyRR1prtpDG5BBzvvDg_9w37ikSgfNcH0qzEHuUTQ9WKMfPgmg8YBqwZ3DiNMZe0fg
 dn.8ns2wOorltUj1OT1W6WPEQ_R87NQX0oJU74RYKXOKmAS6tFJHQH_WmEbcdxYYaS5BQqlP8JOq
 OdwCyyvF78uOq1adb2IsHgoyupIzxNTMVg20THpZaYnd2IY1nGT_Bh80FKe3xLX1dcttW8F4V4uk
 oxI7MiayKMmLLqoFPqB34Fg9pfDy_N1asiGorlQywYyBQCEcT9VjJbEF0gthqJ2XOP08_6Z96I8N
 alRaM8lYyN8_Ugbh0.PRigVK75Fed9sYsCCmVpimIpRUsfUrBTFPfLKGbAuZN5DjAuq3MK9l5r8S
 vfMJFvjOPS93MIkwLzvBbcO3QZGhnW1qrRPDeevJupkZzYKE8u1BiygMXMFCooZ2Y_xOG1UxTmyv
 fG3ThQrtSZMGE2U_OJ5CgoInH8a8BG96N5bpAQkY1yoAz.Fs7fey1IHPZvdZxaQErFu.Q5z5Ei_u
 mEa3Wsf29b6Q4ao59PHVXhViVYdSVPaHiKdut2Rz9Y.0fFdHq4mdN5lItoH5toBBBboBRTj74hMq
 2SxRFpZQGiIHai9k2zNjRGCU9wrtdSBbkmGbuG4ndzRNOM40I6RtWR7TC60BweKiCKqO0ign3kDA
 IqUbZFVaxLSwqO6RoJxBT6yhuHkbmEKy1KPH9_OdWlJM2Luqs642LpjPnJgM4so6tF3ccNEqhlT8
 ouDLaybVd_ajr78MoZzCrJ37j5wvroaZxMBJoRDZFCNSrQjpvrWzT3WkR0q9GA_8tVzNOje.SOC5
 WDAsRNTdslO1qRR5TQp14tfD.NAeQkqySk9li17BhF9oyjKn3wI9WhZaMFfDWAW6wQj5m3e.XGa8
 DaGegDOchzbfcmTJqeNV5FKOwTgbB.KygtH1BheysVz9mON398f2.P6_V_8_8VZsMoHM6Hw5dUj4
 sd3PpOHeTJJksh4fgilPQrklV0kmpMVYOVR23Vnm1kScTgLuIJtR06Tdxr2XoFHUInM1tTgP2lWs
 FgUw5Ng6EN84IsmIoTujAnH2H7iZ8wFy2cg66ahJv7Lz7V0gOcrkR.a6HGhs7PiyJN.ZW149lEi0
 bOXzyH7e7tY.jMbUtEKeDisjkGAZwoVGn_rRfdnA07RiSAxlPRQrP4AAg0IXOe7Y7M.4EleWSMw3
 NFr8uZ218JIaR630aZjfG48wbhyCKfdmxD9exfh34GfeaBfyNbkhY8DbDNHKCV.8Q_5C8j9FW4f7
 X9z_SCPdmiz0CShv5bRhY2hMtjrnMMKlwyKH76kaJPLeR2B3RdsD5PChjaBNlyFiQH4F97TS2Ycv
 TFc0CZ_ZcnQX_LFzfh.6e9gvbvvq6yyEtWDskcQZGehvpu.8ZhyHQ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 27 Nov 2019 21:38:43 +0000
Received: by smtp401.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID df40377f3a8f14ef88902c77347c2a15;
          Wed, 27 Nov 2019 21:38:40 +0000 (UTC)
From:   Casey Schaufler <casey@schaufler-ca.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Subject: [v11-ima PATCH 25/25] AppArmor: Remove the exclusive flag
Date:   Wed, 27 Nov 2019 13:37:18 -0800
Message-Id: <20191127213718.18267-26-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127213718.18267-1-casey@schaufler-ca.com>
References: <20191127213718.18267-1-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the inclusion of the "display" process attribute
mechanism AppArmor no longer needs to be treated as an
"exclusive" security module. Remove the flag that indicates
it is exclusive. Remove the stub getpeersec_dgram AppArmor
hook as it has no effect in the single LSM case and
interferes in the multiple LSM case.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/apparmor/lsm.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index b4c964fdc2f9..81bc4f773429 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1099,22 +1099,6 @@ static int apparmor_socket_getpeersec_stream(struct socket *sock, char **optval,
 	return error;
 }
 
-/**
- * apparmor_socket_getpeersec_dgram - get security label of packet
- * @sock: the peer socket
- * @skb: packet data
- * @secid: pointer to where to put the secid of the packet
- *
- * Sets the netlabel socket state on sk from parent
- */
-static int apparmor_socket_getpeersec_dgram(struct socket *sock,
-					    struct sk_buff *skb, u32 *secid)
-
-{
-	/* TODO: requires secid support */
-	return -ENOPROTOOPT;
-}
-
 /**
  * apparmor_sock_graft - Initialize newly created socket
  * @sk: child sock
@@ -1218,8 +1202,6 @@ static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
 #endif
 	LSM_HOOK_INIT(socket_getpeersec_stream,
 		      apparmor_socket_getpeersec_stream),
-	LSM_HOOK_INIT(socket_getpeersec_dgram,
-		      apparmor_socket_getpeersec_dgram),
 	LSM_HOOK_INIT(sock_graft, apparmor_sock_graft),
 #ifdef CONFIG_NETWORK_SECMARK
 	LSM_HOOK_INIT(inet_conn_request, apparmor_inet_conn_request),
@@ -1777,7 +1759,7 @@ static int __init apparmor_init(void)
 
 DEFINE_LSM(apparmor) = {
 	.name = "apparmor",
-	.flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
+	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.enabled = &apparmor_enabled,
 	.blobs = &apparmor_blob_sizes,
 	.init = apparmor_init,
-- 
2.20.1

