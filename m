Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E741137B3
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 23:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfLDWli (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 17:41:38 -0500
Received: from linux.microsoft.com ([13.77.154.182]:50126 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfLDWlh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 17:41:37 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 247E520B4761;
        Wed,  4 Dec 2019 14:41:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 247E520B4761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575499297;
        bh=Hygomg0IkjBeTUP6XSMjFJvucT6fovHpF5/8RvY72oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iJRKu8W0djMen2xh9DrpDAo0rF3rXzhrlVJrODNqahFlmyA0mKvV7EmIoeeiz1Yyx
         ANmrDneGPBpfbewZra4kLsH93NLJZKmfSBQ08/JVObz5CbGkraEFqvYWNYib84tLc+
         G2kf5qBKTceHtoKSAvHYEkImNDzS87JWdVR7/zRQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v10 1/6] IMA: Check IMA policy flag
Date:   Wed,  4 Dec 2019 14:41:26 -0800
Message-Id: <20191204224131.3384-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204224131.3384-1-nramas@linux.microsoft.com>
References: <20191204224131.3384-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Return immediately from process_buffer_measurement()
if the IMA policy flag is set to zero. Not doing this
can result in kernel panic when process_buffer_measurement()
is called before IMA is initialized (for instance, when
the IMA hook is called when a key is added to
the .builtin_trusted_keys keyring).

This change adds the check in process_buffer_measurement()
to return immediately if ima_policy_flag is set to zero.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..9b35db2fc777 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -655,6 +655,9 @@ void process_buffer_measurement(const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
+	if (!ima_policy_flag)
+		return;
+
 	/*
 	 * Both LSM hooks and auxilary based buffer measurements are
 	 * based on policy.  To avoid code duplication, differentiate
-- 
2.17.1

