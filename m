Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA872552D9
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 03:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgH1B5u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 21:57:50 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38442 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgH1B5T (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 21:57:19 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 261DF2021532;
        Thu, 27 Aug 2020 18:57:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 261DF2021532
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598579838;
        bh=2tw/WXqd1rFl00XCee3Jr+XIH39hEngqJ7UoxJMaINQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AtqpjD/rBb8rzAi7V8HoSi9S55QxM/huCfsBTjRaqiXn1SX/69pRkM/lBTd4Llzd8
         2RiUSiD7ysC70GhPk3NhhmRi7Np2E/3vzCY9MWKc2J5bWn2nJVeJt+wyX250yT4bdS
         HLJGGew0L3GSU6urgP7G3PmZDeYrCKcqF9eyLdeY=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 2/6] IMA: change process_buffer_measurement return type from void to int
Date:   Thu, 27 Aug 2020 18:57:00 -0700
Message-Id: <20200828015704.6629-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() does not return the result of the operation.
Therefore, the consumers of this function cannot act on it, if needed.

Update return type of process_buffer_measurement() from void to int.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 security/integrity/ima/ima.h      |  6 +++---
 security/integrity/ima/ima_main.c | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 8875085db689..83ed57147e68 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -265,9 +265,9 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data);
+int process_buffer_measurement(struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c870fd6d2f83..0979a62a9257 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -736,9 +736,9 @@ int ima_load_data(enum kernel_load_data_id id)
  *
  * Based on policy, the buffer is measured into the ima log.
  */
-void process_buffer_measurement(struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data)
+int process_buffer_measurement(struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -758,7 +758,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	u32 secid;
 
 	if (!ima_policy_flag)
-		return;
+		return 0;
 
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
@@ -772,7 +772,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
 					&pcr, &template, func_data);
 		if (!(action & IMA_MEASURE))
-			return;
+			return 0;
 	}
 
 	if (!pcr)
@@ -787,7 +787,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 			pr_err("template %s init failed, result: %d\n",
 			       (strlen(template->name) ?
 				template->name : template->fmt), ret);
-			return;
+			return ret;
 		}
 	}
 
@@ -819,7 +819,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 					func_measure_str(func),
 					audit_cause, ret, 0, ret);
 
-	return;
+	return ret;
 }
 
 /**
-- 
2.17.1

