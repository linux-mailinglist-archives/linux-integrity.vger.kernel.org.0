Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80192F8012
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfKKTdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:33:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44854 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfKKTdK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 053DA20B4908;
        Mon, 11 Nov 2019 11:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 053DA20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500790;
        bh=ePsjQTqjabrtYSzuz3htfRqLy4c1Eqq3aG19Es0tUO0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Cnwcd4DR0Xzj2Wx9JWSq8u6Rw98rxRpzP4lNuxvQsy/4RgDfJMJK2yRPqXGs+U/Gl
         3zx7k/FqCrc5zfS3lA9G5XiG+4MGqi0o055vOMU/Upq1+kkozpymdl5pC5yf1esz+t
         X3RQC8b56SvdK48gFSxc2XA/pAHpQxk0iSxZk1OI=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] IMA: Added a flag to determine whether IMA hook can process the key now or has to queue for processing later
Date:   Mon, 11 Nov 2019 11:33:01 -0800
Message-Id: <20191111193303.12781-9-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys should be processed only if custom IMA policies have been
applied. Prior to that the keys should be queued for processing later.

This patch defines a flag namely ima_process_keys_for_measurement
to check if the key should be processed immediately or should be queued.

ima_policy_flag cannot be relied upon because ima_policy_flag will
be set to 0 when either IMA is not initialized or the IMA policy
itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_asymmetric_keys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 7d6603bfcc06..61c42d06a636 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -15,6 +15,8 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+bool ima_process_keys_for_measurement;
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1

