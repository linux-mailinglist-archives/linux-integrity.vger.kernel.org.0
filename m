Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CC945E038
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Nov 2021 19:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhKYSIq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Nov 2021 13:08:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45790 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbhKYSGq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Nov 2021 13:06:46 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9FBAC2193C;
        Thu, 25 Nov 2021 18:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637863412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PK+Zc83ByJRm0GdafXCf4h8Ufy35eh7OxSjfkp0YrnM=;
        b=On15q/90t5q6ngo9oibHUk5cuUrtIKj5zDFosgbzJXlVOceZTDKJfsErLIEzHYK8+4Zc2e
        cRzs1dtDFfvcKgHNy65H366qh0ixIABXoALdzpohT/qsfymR/UQqpvMuPla/3w1F63BhI7
        aMxgW0ojb48EH/bKZ2lLNm9ZRBpLx9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637863412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PK+Zc83ByJRm0GdafXCf4h8Ufy35eh7OxSjfkp0YrnM=;
        b=FB0cBxjJNmMwuPYkcUDoiU/7Y4SjiDZ53QM2CYK1JiOCieeTSR0SvIeBiwtAX6gWj/69KW
        suy7eNPadG/YEaAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 3B800A3B81;
        Thu, 25 Nov 2021 18:03:29 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org
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
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/6] KEXEC_SIG with appended signature
Date:   Thu, 25 Nov 2021 19:02:38 +0100
Message-Id: <cover.1637862358.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

This is resend of the KEXEC_SIG patchset.

The first patch is new because it'a a cleanup that does not require any
change to the module verification code.

The second patch is the only one that is intended to change any
functionality.

The rest only deduplicates code but I did not receive any review on that
part so I don't know if it's desirable as implemented.

The first two patches can be applied separately without the rest.

Thanks

Michal

Michal Suchanek (6):
  s390/kexec_file: Don't opencode appended signature check.
  powerpc/kexec_file: Add KEXEC_SIG support.
  kexec_file: Don't opencode appended signature verification.
  module: strip the signature marker in the verification function.
  module: Use key_being_used_for for log messages in
    verify_appended_signature
  module: Move duplicate mod_check_sig users code to mod_parse_sig

 arch/powerpc/Kconfig                     | 11 +++++
 arch/powerpc/kexec/elf_64.c              | 14 ++++++
 arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/module_signature.h         |  1 +
 include/linux/verification.h             |  4 ++
 kernel/module-internal.h                 |  2 -
 kernel/module.c                          | 12 +++--
 kernel/module_signature.c                | 56 +++++++++++++++++++++++-
 kernel/module_signing.c                  | 33 +++++++-------
 security/integrity/ima/ima_modsig.c      | 22 ++--------
 11 files changed, 113 insertions(+), 85 deletions(-)

-- 
2.31.1

