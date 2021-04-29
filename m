Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4F36F077
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 21:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhD2TYy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 15:24:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45433 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235623AbhD2TWv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:22:51 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id A6E895C0093;
        Thu, 29 Apr 2021 15:22:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 29 Apr 2021 15:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=h3cv4urXYSFk9
        7s6YrYJHSj6MAiYXM35h2NCOKlwrv0=; b=eohsoYKvQzbbeIhDknuuEXX9VOE0e
        QJDIfvp6FoW9zqwDpPOt8lR8wSgvHdzjDpktew7bAtxULwJDmXrLXSAkxY6pwBf6
        7iI/chHjVwx9ncWh4s/4Se3iuGzs5G+4gkS8QbRWryLL1hOq+5SdxnQrqXWbLiwt
        gxDMOhpslwiqubw7Zgp+s3MWbIU0fXG/dF61dO2cI7B2o32suwp0rEvTqYOWl+P7
        iur0m5LdGItMhQ838AcZZ+AT3UVTAQGVcFgGmjmi2xAyErkSVzi/GD0MkUXVCWgK
        JMRNr9Ns94qB1NiZHim347BlqZHoFXv3mX+FJi3/miiK6K17II9NZHiUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=h3cv4urXYSFk97s6YrYJHSj6MAiYXM35h2NCOKlwrv0=; b=ucs1s/hh
        UnHw7OVRYnt2bTrUBB3DDQ4iigIgItLyxaqc+otV2imIRzfFWNB+b70BOteCAQzb
        9Ekp6SQNw4xC7k8XpbBcj7g0qQNcbGyh7/5lAPgH//ZDSS9eJLqgso5KcgJgQnXX
        1c1zaDpid6+0eOqWbzomg6zMh5mKsrTu1G9BrVQ85A6nvWi3jzVw5FDIKWUumbk4
        9eM3giPxPbJb2avX9DdTgNjPzSJNDJhFyMPF1HS4gJVqWbBoijbEemh9nGg/d4kn
        mJ514qM4lZTEAM94F7O7/JDXTeg+8bRgw2JujL1aQG3iZyrooU7gNajZmWcNObKr
        aJTVeUSPUey2dw==
X-ME-Sender: <xms:XAeLYCvFOsRsjqZkcsGigE5tzg_HAPJtZBebdQyo-S_MO6y4HKruuQ>
    <xme:XAeLYHexxK8JlaRf92tij3QwUtKAXMQ0eQMQBCkF6YVqQE4Uc9Ez-EzTdZxD3cseZ
    5VKUZmGCw78doXdEFo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeffkeehlefgteelgefhheekfeeigeffledtkefhveeifeehledtffehkeeuheek
    heenucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:XAeLYNzRRFEmxdmcJiwKMuL33R1YdclCOZTNdvTDbCyCmK00Qgaz7Q>
    <xmx:XAeLYNNujPLmOWpirYpAIftwNjJHeqBm5wExQK13oPNaLiPV_CCdGg>
    <xmx:XAeLYC-GJNIdZ4ELwXwdhz9K9L8dvwKzjwLJ87qDoEoq3i-UfXk15w>
    <xmx:XAeLYGZa0Vg8tHXIaaoLxK-6xo5cGZsLyObhD5HjflbKcHqmQvYDpg>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 15:22:04 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return paths
Date:   Thu, 29 Apr 2021 15:21:56 -0400
Message-Id: <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
References: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
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
 security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 617fabd4d913..0165da386289 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -336,9 +336,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 			rc = -EPERM;
 	}
 	if (blob_len < 0)
-		return blob_len;
-
-	payload->blob_len = blob_len;
+		rc = blob_len;
+	else
+		payload->blob_len = blob_len;
 
 	tpm_put_ops(chip);
 	return rc;
-- 
2.30.2

