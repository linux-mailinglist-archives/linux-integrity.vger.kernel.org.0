Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281384A541D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 01:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiBAAe5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Jan 2022 19:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiBAAe4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Jan 2022 19:34:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8739FC06173D;
        Mon, 31 Jan 2022 16:34:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE7FB6116E;
        Tue,  1 Feb 2022 00:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08072C340E8;
        Tue,  1 Feb 2022 00:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643675695;
        bh=lXBovqo+R3QKjCrOtBlrRmBSkmbzyMj69jJ1tFnSyPk=;
        h=From:To:Cc:Subject:Date:From;
        b=na13lXmoATd2GRBbnrQQu9ZuqCrsT2iYgJXc4JQUooti1j7DJpbB+G4EzVR/8DU0I
         /D7aI/Bd2U6oe1n2cP7kg9I8tsoUz8qK7rwLtGvVReelM+t0/FWV5eADB4jabiG1kb
         5uu8GxczziDdZSINWyzuosUKoXyF5Y66Wuh5Z9ekQlNRWwduNdl5sgIR0Pf2t5rzzO
         UBG5hFzIthenO9A+zxr5nTdjJjWr3R0mFJvb71kGQeeea9r0P0WYXbHPJNhjOOjKmr
         2wLIjD7SupP6gXsM3KHFX8YwKevVyogz2xku5LiTuwya9BGOgXr8fCLSyPkdtxr6Do
         VnJHLJT44GG5w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/2] Fix bugs in public_key_verify_signature()
Date:   Mon, 31 Jan 2022 16:34:12 -0800
Message-Id: <20220201003414.55380-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patchset fixes some bugs in public_key_verify_signature() where it
could be tricked into using the wrong algorithm, as was discussed at
https://lore.kernel.org/linux-integrity/20211202215507.298415-1-zohar@linux.ibm.com/T/#t

I'd appreciate it if the people who care about each of the supported
public key algorithms (RSA, ECDSA, ECRDSA, and SM2) would test this
patchset to make sure it still works for their use case(s).  I've tested
that X.509 and PKCS#7 with RSA still work.

Note, I have *not* included a fix for SM2 being implemented incorrectly.
That is another bug that I pointed out in the above thread.  I think
that bug is for the people who actually care about SM2.

This applies to v5.17-rc2.

Eric Biggers (2):
  KEYS: asymmetric: enforce that sig algo matches key algo
  KEYS: asymmetric: properly validate hash_algo and encoding

 crypto/asymmetric_keys/pkcs7_verify.c    |   6 --
 crypto/asymmetric_keys/public_key.c      | 126 ++++++++++++++++-------
 crypto/asymmetric_keys/x509_public_key.c |   6 --
 3 files changed, 91 insertions(+), 47 deletions(-)


base-commit: 26291c54e111ff6ba87a164d85d4a4e134b7315c
-- 
2.35.1

