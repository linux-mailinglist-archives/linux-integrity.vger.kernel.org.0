Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58FAD11B928
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Dec 2019 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfLKQrQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Dec 2019 11:47:16 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38724 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfLKQrP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Dec 2019 11:47:15 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id CBD4F20B7189;
        Wed, 11 Dec 2019 08:47:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CBD4F20B7189
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576082834;
        bh=quwvUgfAal9hpr4TQ4aApSGkXF4hHg8ZIPW4oluX/7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2KoyMkuK3gM5Em1C19C5Tj5UcPeLCxolLKgz4dWkzoDzRE8KWtZetRzcWXvuWgW6
         SFlrW4QaZQG7LdMgttBg8x4z5mb1yvvaONLxfCkJ/N3LAIh5nIEafOa5o6dmG77egF
         Dxv5hN4m06FfgJQI5TE3ytQLzdM9gAdXqISGTZaI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v11 1/6] IMA: Check IMA policy flag
Date:   Wed, 11 Dec 2019 08:47:02 -0800
Message-Id: <20191211164707.4698-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211164707.4698-1-nramas@linux.microsoft.com>
References: <20191211164707.4698-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() may be called prior to IMA being
initialized (for instance, when the IMA hook is called when
a key is added to the .builtin_trusted_keys keyring), which
would result in a kernel panic.

This patch adds the check in process_buffer_measurement()
to return immediately if IMA is not initialized yet.

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

