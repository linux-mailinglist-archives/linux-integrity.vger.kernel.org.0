Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDB7487701
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 12:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347360AbiAGLzs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 06:55:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35834 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbiAGLzp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 06:55:45 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 095101F39C;
        Fri,  7 Jan 2022 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641556543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NLOYJhZxOiXByA38wXhVENRBwHFkUqymDefaIYtjAww=;
        b=DYJoYIvMIuaAn4jT6wzepOZddowzB3R6YLybX2O6n7TCAQCZlR4zDeU0GcYPnKW505nABj
        su4oZEJ0oCH/m55uGP7Yy8WYS2BMfpXyjxmpyLh4GOyEj5o4ZfyvIZxpFvDygtVE3Fuflf
        UZa4paGKe6qZiNlPFieplKDZDzlXTZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641556543;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NLOYJhZxOiXByA38wXhVENRBwHFkUqymDefaIYtjAww=;
        b=bNOaWUaTqMbaig6Oa1FbHF72xkJH1yRNSzF6PLDJzt5jO3qibt3lGaCHNMAjYvcm6B/ewl
        K+WzVdl2lkZBQJAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 668BAA3B83;
        Fri,  7 Jan 2022 11:55:38 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/6] KEXEC_SIG with appended signature
Date:   Fri,  7 Jan 2022 12:53:44 +0100
Message-Id: <cover.1641555875.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

This is a refresh of the KEXEC_SIG series.

This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
with appended signatures in the kernel.

powerpc supports IMA_KEXEC but that's an exception rather than the norm.
On the other hand, KEXEC_SIG is portable across platforms.

For distributions to have uniform security features across platforms one
option should be used on all platforms.

Thanks

Michal

Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek@suse.de/
Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig

Michal Suchanek (6):
  s390/kexec_file: Don't opencode appended signature check.
  powerpc/kexec_file: Add KEXEC_SIG support.
  kexec_file: Don't opencode appended signature verification.
  module: strip the signature marker in the verification function.
  module: Use key_being_used_for for log messages in
    verify_appended_signature
  module: Move duplicate mod_check_sig users code to mod_parse_sig

 arch/powerpc/Kconfig                     | 16 +++++++
 arch/powerpc/kexec/elf_64.c              | 14 ++++++
 arch/s390/Kconfig                        |  2 +-
 arch/s390/kernel/machine_kexec_file.c    | 43 ++----------------
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/module_signature.h         |  1 +
 include/linux/verification.h             |  4 ++
 kernel/module-internal.h                 |  2 -
 kernel/module.c                          | 12 +++--
 kernel/module_signature.c                | 56 +++++++++++++++++++++++-
 kernel/module_signing.c                  | 33 +++++++-------
 security/integrity/ima/ima_modsig.c      | 22 ++--------
 12 files changed, 119 insertions(+), 87 deletions(-)

-- 
2.31.1

