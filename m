Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AE536F074
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 21:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbhD2TYx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 15:24:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39661 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235573AbhD2TWu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 15:22:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BBC65C0093;
        Thu, 29 Apr 2021 15:22:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Apr 2021 15:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=wPWSE6YsU7+OxY2Ql0tz4qGnr1
        C7tgpgSds6zQk9ug4=; b=EBBzdTgdzhRUTOCqVknvSxRhCjjKOmbLieusbsEFqB
        6CnIXN8Y6qyrBVM2fOW/LrGpNQf4yYfsF4VZwsTVT09veFCvV8/iQduShP5OEh0y
        mpU1ljo9a+uqRk8k2bXhehfuFymE9VtdmokeThR4pkFUmMfZKpZtH3aRoYAkvgTu
        0DSS9WORrs3jPOe1v2sAW3vJWGXcbNjEst443cGt075VAl2pPtTi4wRf6/Fyc0Bx
        grzMZZYf04RCs884OwX+RtvPQxV5AP9d5b0/ahrhpZKhYJ1j9eJD3mUJCoEzS1K/
        caDwCIZQ2aewNSRUuBnE1aUfFeF1m2NyHSeROsZBWoag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wPWSE6YsU7+OxY2Ql
        0tz4qGnr1C7tgpgSds6zQk9ug4=; b=uEy1u13oUBeIZrTo6rqM8vsDqUcgGLwhk
        NqTN+jXQrl7rZ/1EpCI9bsC4FS9gFcQIxw7P+f3jWWzxMYdV6+dAvw/9CVN8F1bd
        a1jpZBcwr2KJfepr9uNjOe0q+Fphxd9wgEa2vbvNn58k7+ujNPSME6FAlLybp7oE
        bWl8wPNPggX02nvwFIFuQ6kzymEq9I2iJlFMvgd9aZsBXPt50OAHJ6dsIIxXj8YV
        XyIPZ24Xx7CRlzof/VdgukYBeSKP5t7cCNNz1ZwkAaRtXO7Y5eYrk66N1nN3cFcF
        XeQH0S2Ek23H34Hh8agp2Sff2OcM4UH4oTTGVkeMm30suOCNhsavQ==
X-ME-Sender: <xms:WgeLYP3zkALd4rqdQvF5B4p7yIW6ucW2bejSMH3-oybqo5a4YUBJ4Q>
    <xme:WgeLYOFMH-42aLVmo1gu-Db6hfKPIrJ210zwFhROnnpuybqXdRuCpixrbeC9hSRcP
    4fNcHjjJJ1laglCzwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddvgedgudefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuegvnhcuueho
    vggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtthgvrh
    hnpedttedvgedvtedugeeikeejfeetueekfefhueeugfekheegjeeuffegfeffgefgueen
    ucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:WgeLYP45MncfaMPUqZCQNi8Q7_lrQw6zvldEgIBEBQ-_moSQTzN54A>
    <xmx:WgeLYE1RiN9JfkEyG_ai-kGa1FLp9hM7b8f-6nMfCxAGD4oLxpnwjw>
    <xmx:WgeLYCGQVZue-k0lelDCfa7qR_0pNBtFtGnRtG99Lbzt1lf_8b65Kg>
    <xmx:WweLYOASEQIjGY8A-HHzwzM4oN4U9z4Oo6qw7THo7Si08e3WASDOXA>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 29 Apr 2021 15:22:02 -0400 (EDT)
From:   Ben Boeckel <me@benboeckel.net>
To:     keyrings@vger.kernel.org
Cc:     Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/1] trusted-keys: match tpm_get_ops on all return paths
Date:   Thu, 29 Apr 2021 15:21:55 -0400
Message-Id: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ben Boeckel <mathstuf@gmail.com>

Bug report thread Message-Id: <YIpV9pcyM9/rWqEt@mwanda>

---
v1 -> v2:
  - simplify the return path since we're at the end of the function
    anyways

Ben Boeckel (1):
  trusted-keys: match tpm_get_ops on all return paths

 security/keys/trusted-keys/trusted_tpm2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 3644286f6cbcea86f6fa4d308e7ac06bf2a3715a
-- 
2.30.2

