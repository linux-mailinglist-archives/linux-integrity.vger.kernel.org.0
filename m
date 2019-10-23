Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD923E0F02
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJWASZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45252 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbfJWASZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E0AA2010AC3;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E0AA2010AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789904;
        bh=ZxF80hLmpS4odHnXd8DZjntedVTyJ3tH1vjLMOXe8os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQfxB7Rh3YN88VbtVbjqd7vP5nGaCHsKqZgVYm3tXgm6uFu/1QF1Ovv9OhP0f3I2B
         3HOdT/Yjw3cGFebSmHU3Z17BB34MGPkkotsW/fghalngocZmk/mHAat/sfsasfq1qg
         W2JfR9lx+ZSRtYHRaRFTv+7GG2IomNjKpwzRHpIA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 1/6] KEYS: Helper function to check if the given keyring is builtin_trusted_keys
Date:   Tue, 22 Oct 2019 17:18:13 -0700
Message-Id: <20191023001818.3684-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Helper function to check if the given keyring is
the builtin_trusted_keys keyring.

This function is used by ima to determine if a key is
added to the builtin_trusted_keys keyring.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 certs/system_keyring.c        | 5 +++++
 include/keys/system_keyring.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 1eba08a1af82..5533c7f92fef 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -283,3 +283,8 @@ void __init set_platform_trusted_keys(struct key *keyring)
 	platform_trusted_keys = keyring;
 }
 #endif
+
+inline bool is_builtin_trusted_keyring(struct key *keyring)
+{
+	return (keyring == builtin_trusted_keys);
+}
diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index c1a96fdf598b..2bc0aaa07f05 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -66,4 +66,6 @@ static inline void set_platform_trusted_keys(struct key *keyring)
 }
 #endif
 
+extern bool is_builtin_trusted_keyring(struct key *keyring);
+
 #endif /* _KEYS_SYSTEM_KEYRING_H */
-- 
2.17.1

