Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E95222A45
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgGPRoP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 13:44:15 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54512 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729432AbgGPRoF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 13:44:05 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33CC520B490F;
        Thu, 16 Jul 2020 10:44:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33CC520B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1594921444;
        bh=mgND1QTe5Ztcv9Kvm/Chu/AhsMHOCtifBt1wUR59OJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZggH5bsHm6of+unxW8oNu9IzB5aTHoePLY+eSifN8VHwiCCeD7Ka8cEwwjhykBIiN
         6QkozYVnGvAPbLU1uqwZ818aya2br+V6So+XvMLY6mXV5kEpvbs9GKK7zqD8enFaPk
         2Yzx9cDFJw2/skxXH2IrZH2DPnTqwk09RUbjLkXY=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com
Cc:     jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] LSM: Define workqueue for measuring security module state
Date:   Thu, 16 Jul 2020 10:43:51 -0700
Message-Id: <20200716174351.20128-6-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716174351.20128-1-nramas@linux.microsoft.com>
References: <20200716174351.20128-1-nramas@linux.microsoft.com>
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
index 1afa2aebc3ac..63b30da337d8 100644
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

