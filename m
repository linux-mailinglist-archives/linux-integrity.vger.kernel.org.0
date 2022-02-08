Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9B74AD107
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Feb 2022 06:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347438AbiBHFdQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Feb 2022 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbiBHF1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Feb 2022 00:27:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089EFC0401EA;
        Mon,  7 Feb 2022 21:27:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2998B811FE;
        Tue,  8 Feb 2022 05:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2903BC004E1;
        Tue,  8 Feb 2022 05:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644298049;
        bh=7Dhmi0fDloRgnQaPor8Zd0439Cs3wRrBjobJqNsKzeY=;
        h=From:To:Cc:Subject:Date:From;
        b=fxHRalrLwyTa5E605/mjps/Nax4k8EDEjMJ/BVnpCEqFKcUqZ22u6O5MPwP5EWGvE
         ztM3hcLWDSoJt2sY4/mfDvfoCdNv+D+o80i0BOXqQHLb/vMy9LXbGVcGBdEnLgmgbK
         nbyHkO7VNJtNZpjde8YKyL4J5L6uJ+EbGRn0mX+cZX7gT2jzVwQkfDkxPEzYKCT8Al
         qvZFKwHCarkIiBR4V8iLbQJ0G8fipksmnRWU2VvGtuYJSEvoBnjWOWTKa3yFeae5vT
         5lHElwyLH1d3JndCNAbR1ru9tlEMj8HiZr7ZOM0itymkoH5simhTVtfNlqhecK1LIH
         g4wZAUusTNGXA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2 0/2] Fix bugs in public_key_verify_signature()
Date:   Mon,  7 Feb 2022 21:24:46 -0800
Message-Id: <20220208052448.409152-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

This applies to v5.17-rc3.

Changed v1 => v2:
   - Changed patch 1 to continue allowing a NULL sig->pkey_algo.

Eric Biggers (2):
  KEYS: asymmetric: enforce that sig algo matches key algo
  KEYS: asymmetric: properly validate hash_algo and encoding

 crypto/asymmetric_keys/pkcs7_verify.c    |   6 --
 crypto/asymmetric_keys/public_key.c      | 126 ++++++++++++++++-------
 crypto/asymmetric_keys/x509_public_key.c |   6 --
 3 files changed, 91 insertions(+), 47 deletions(-)


base-commit: dfd42facf1e4ada021b939b4e19c935dcdd55566
-- 
2.35.1

