Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF90C4461AD
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 10:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbhKEJ5v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Nov 2021 05:57:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhKEJ5u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Nov 2021 05:57:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DEA91FD33;
        Fri,  5 Nov 2021 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636106109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mby2JIZUNM+DNzTfY4azBDzQa/92IvvCw8tLadYHt78=;
        b=rNlRdZcKQOCSZpYPzPrRzb2E+1bXLWVEnJM4Dzb5PAiL9uNR+XeyDlYZ3UTyI6Fml8Cv8C
        vx9asIPpjaxVUPubuozUoaYNWXM5AH5VpTx5MjycaA0faTncC5vcdk65IDTZXHAjhSvB1e
        poh38Gdvgtr80NuSSZMT1EpLyodmnCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636106109;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mby2JIZUNM+DNzTfY4azBDzQa/92IvvCw8tLadYHt78=;
        b=nzctrc7rLdjmdCVlJNft5ocJrbG6SAddj/2+I5zFvjB2sJzkxB3jwNmuGN1hzLRVZzMixK
        /fHuVK51FITdOyAQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 4FBFF2C14A;
        Fri,  5 Nov 2021 09:55:07 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Frank van der Linden <fllinden@amazon.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 0/2] Additional appended signature cleanup
Date:   Fri,  5 Nov 2021 10:55:03 +0100
Message-Id: <cover.1636105912.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635948742.git.msuchanek@suse.de>
References: <cover.1635948742.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There is one more copy of the code checking appended signarutes.

Merge the common code to module_signature.c

Thanks

Michal

Michal Suchanek (2):
  module: Use key_being_used_for for log messages in
    verify_appended_signature
  module: Move duplicate mod_check_sig users code to mod_parse_sig

 arch/powerpc/kexec/elf_64.c              |  2 +-
 arch/s390/kernel/machine_kexec_file.c    |  2 +-
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/module_signature.h         |  1 +
 include/linux/verification.h             |  3 +-
 kernel/module.c                          |  3 +-
 kernel/module_signature.c                | 56 +++++++++++++++++++++++-
 kernel/module_signing.c                  | 33 ++++----------
 security/integrity/ima/ima_modsig.c      | 22 ++--------
 9 files changed, 74 insertions(+), 49 deletions(-)

-- 
2.31.1

