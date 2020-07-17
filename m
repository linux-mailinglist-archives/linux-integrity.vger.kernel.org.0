Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFC22463F
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jul 2020 00:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGQW20 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 18:28:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:46074 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGQW20 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 18:28:26 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8A2BC20B490F;
        Fri, 17 Jul 2020 15:28:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A2BC20B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595024905;
        bh=V1TG6A62AlhkeMm5nI6RacUJ4gr3crF9A3ZVYUcYMRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4egA04GbOb67I6EwS8hIDOLDfPZ06IiIRb3g7gaFNjxo466qCpZF4nkvZpZAKO7s
         V6Fhr3J6GGOS2P5TGri9M0E+xGgHfALxR0d25Nqn6al9LhixozKO0Psk2hSnXopPh9
         210GfbhPj9HlOC+R4Nk/O4dEShIPGeylZeSpHJLQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] LSM: Define workqueue for measuring security module state
Date:   Fri, 17 Jul 2020 15:28:19 -0700
Message-Id: <20200717222819.26198-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717222819.26198-1-nramas@linux.microsoft.com>
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Data structures critical to the functioning of a security module could
be tampered with by malware or changed inadvertently at runtime
thereby disabling or reducing the security guarantees provided by
the security module. Such critical data need to be periodically checked
and measured, if there is any change. This would enable an attestation
service, for instance, to verify that the security modules are operating
with the configuration and policy setup by the system administrator.

Define a workqueue in the LSM and invoke the security modules in
the workqueue handler to check their data and measure.

Note that the data given by the security module would be measured by
the IMA subsystem only if it has changed since the last time it was
measured.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/security.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/security/security.c b/security/security.c
index 88ce1b780ffd..6e746a024ed5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -89,6 +89,11 @@ static __initdata struct lsm_info *exclusive;
 static struct lsm_info *security_state_lsms;
 static int security_state_lsms_count;
 
+static long security_state_timeout = 300000; /* 5 Minutes */
+static void security_state_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(security_state_delayed_work,
+			    security_state_handler);
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -277,6 +282,26 @@ static void __init initialize_security_state_lsms(void)
 	security_state_lsms_count = count;
 }
 
+static void initialize_security_state_monitor(void)
+{
+	if (security_state_lsms_count == 0)
+		return;
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
+static void security_state_handler(struct work_struct *work)
+{
+	int inx;
+
+	for (inx = 0; inx < security_state_lsms_count; inx++)
+		measure_security_state(&(security_state_lsms[inx]));
+
+	schedule_delayed_work(&security_state_delayed_work,
+			      msecs_to_jiffies(security_state_timeout));
+}
+
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
@@ -400,6 +425,7 @@ static void __init ordered_lsm_init(void)
 	}
 
 	initialize_security_state_lsms();
+	initialize_security_state_monitor();
 
 	kfree(ordered_lsms);
 }
-- 
2.27.0

