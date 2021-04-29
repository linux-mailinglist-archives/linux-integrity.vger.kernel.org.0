Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54DD36EF85
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhD2Sir (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 14:38:47 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37977 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241205AbhD2Siq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 14:38:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C0FF05C0053;
        Thu, 29 Apr 2021 14:37:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 29 Apr 2021 14:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=uriAVbHcyeM+B
        1o/h2ruNXHybSYxxHjmI5LYBV1QufE=; b=DZJD1Ze/bLbNMJG9DTw26HDB+vAIA
        zU4RafHf+mRvQzTd+Xq950ZB6INis3uQOx5fPetIl64G7vVZjGfdUARszNxUT51B
        Zlm6pQgZb4z6I63aMRnolilenzdxp/Xt0mFVICZKpA6HWtkzVfruY4OlElmmhczm
        HNWpmbd5bMOQgTtTXkCivgnFlRVvHh0ZYaGb2rJGN3Qiy9zD/iXRci2IWdRoQFMx
        eM0KunesylJNOgYmREqsjYHXA5KZIAyxHuWk0qTOrsqGWUdrEBYt7WTg1PCVQSy0
        yYTsPQ9vqLr2Jjv7jFjvVaTg2EPFIzjcWXlFrOrs8i+yzbueoxYvmPtgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=uriAVbHcyeM+B1o/h2ruNXHybSYxxHjmI5LYBV1QufE=; b=pZuqXItE
        CZ8u1ppw5DY+NN5QhmCgT4KNAzZRzj961npCgUWE4A9fbb7da5wPkZYH4gfhSkxY
        0nDomicrndJVkbHobO8EGir7L/Lul1neP9wGWyNAL4ettei82OvhvREF+7ePFeC1
        JgYrIKwu79WF5S+QuhR2Of5BXNuR+/zNdBk3mlFbnx6KnW3w1inniZdauaaj8WCp
        Kr4ct+HNd0/58a+FYKW3s89OcjSmQHm3INP/22jdjaCkYW/qSkolHr0nFYCzOtYx
        I29CpH84AY3hEJ4qt1zLTu8PRtJq6QHKxIEfWUXXlRXb+hJ/jX0X25hve0E3bT4e
        wvM3A5lqdSuwIg==
X-ME-Sender: <xms:Bv2KYJrWc6nUKGCSzBmm7Gmghi5IBcSmT7_odY2AQ55nLiQjh-DOpg>
    <xme:Bv2KYLrXDuP4FaPuSXY-SNrorwWdhTYMa9ZsOOT7PGilh8NY7lefScuHcJdGPdipQ
    vEEh02tLoVj-Ph4xwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeffkeehlefgteelgefhheekfeeigeffledtkefhveeifeehledtffehkeeuheek
    heenucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:Bv2KYGNO-yVlhW0l_JG8OKJN0J_f76hUN_0T8nKPRY7epoWQe5dv5w>
    <xmx:Bv2KYE6-lFYK1ZdXHgJHnts-krlAp5MoJMtBOxj0AaXJPCVOkom2wA>
    <xmx:Bv2KYI7fetCgo4w4eifs18n0vvfyZH5JWOCXBqjCL-r2Ps0un2zIxQ>
    <xmx:Bv2KYD3gdBqZnqoKRud-DWoA0LhVI04iB96OW6ZjcU3gvb7XqUUY9w>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 14:37:58 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/1] trusted-keys: match tpm_get_ops on all return paths
Date:   Thu, 29 Apr 2021 14:37:42 -0400
Message-Id: <20210429183742.756766-2-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
References: <20210429183742.756766-1-list.lkml.keyrings@me.benboeckel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

The `tpm_get_ops` call at the beginning of the function is not paired
with a `tpm_put_ops` on this return path.

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ben Boeckel <mathstuf@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 617fabd4d913..25c2c4d564de 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -335,8 +335,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		else
 			rc = -EPERM;
 	}
-	if (blob_len < 0)
+	if (blob_len < 0) {
+		tpm_put_ops(chip);
 		return blob_len;
+	}
 
 	payload->blob_len = blob_len;
 
-- 
2.30.2

