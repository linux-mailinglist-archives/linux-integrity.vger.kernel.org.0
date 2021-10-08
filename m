Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A0426672
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 11:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhJHJQq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 05:16:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53628 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236658AbhJHJQo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 05:16:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3426D222B6;
        Fri,  8 Oct 2021 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633684488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8JeEj35V074Dq7tLbfqIhyV7UxJUTdxWHIjGmI+INNM=;
        b=C5MDwE4ebNVq8PS+GcLVrjy/r4AUbrUBMLRPMDb4DMlcrrm19wIDWc2V7IO9Bjz2+Imn+i
        WKu6W7aM3Lj1hi8eoDFQxhjr/HS/t7ikzVRxFblFSRli0z4uwpb1MmqIkF8o4Lv2/mgSLX
        t4Y0jW9TnUpzY8dJLF1pttjSoGRIlus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633684488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8JeEj35V074Dq7tLbfqIhyV7UxJUTdxWHIjGmI+INNM=;
        b=fDda/tmctySMIKglX9ER12wMFfRDrrGqY4SqqMCjUzGnI2GIdOUQ7oLJnrCGxyqm5+5G/1
        xmpisckWHSTL5DBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3F9113D13;
        Fri,  8 Oct 2021 09:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HPMoKwcMYGHsewAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 09:14:47 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Alex Henrie <alexh@vpitech.com>,
        alexhenrie24@gmail.com, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v6 0/2] IMA checkpatch fixes
Date:   Fri,  8 Oct 2021 11:14:28 +0200
Message-Id: <20211008091430.22392-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

very minor checkpatch fixes based on [v3,2/2] ima: add gid support patchset [1].

Kind regards,
Petr

[1] https://lore.kernel.org/linux-integrity/20211007200302.187892-1-alexh@vpitech.com/

Petr Vorel (2):
  ima_policy: Remove duplicate 'the' in docs comment
  ima: Use strscpy instead of strlcpy

 security/integrity/ima/ima_api.c    | 2 +-
 security/integrity/ima/ima_policy.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.33.0

