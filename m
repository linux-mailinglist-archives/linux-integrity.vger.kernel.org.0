Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455723B0722
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhFVOO4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 10:14:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35080 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFVOOz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 10:14:55 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5172A1FD6C;
        Tue, 22 Jun 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV0b+6hqIBjxzeFJeDvfn68xd71ZPgq4wBs/0JgzBwI=;
        b=MQrwhOeP+cs1HOY6ttSHZ5Jw2n9wTEgvTnKf7HnrHa6Jv6faTDP+S6dQyVaHOvizinJp/o
        s0LcRCg8UvT2d0e3vn+T3hh5DmOVKGLd3pB+y49h0S98ppoejYzIydo+Ts3Ay67POmaUHW
        9Vf6SjDfvKUdbrv8t2mHtFylH2AVMC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV0b+6hqIBjxzeFJeDvfn68xd71ZPgq4wBs/0JgzBwI=;
        b=j8W88bSZwKkZW8pYXU7a63UjlK8Y0GjZ+nmhNTwPX/oDTuFf4MVf3YFk9iLuEmQzqz9ja6
        RZD5QqxdK5fLnvDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 162C0118DD;
        Tue, 22 Jun 2021 14:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624371159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV0b+6hqIBjxzeFJeDvfn68xd71ZPgq4wBs/0JgzBwI=;
        b=MQrwhOeP+cs1HOY6ttSHZ5Jw2n9wTEgvTnKf7HnrHa6Jv6faTDP+S6dQyVaHOvizinJp/o
        s0LcRCg8UvT2d0e3vn+T3hh5DmOVKGLd3pB+y49h0S98ppoejYzIydo+Ts3Ay67POmaUHW
        9Vf6SjDfvKUdbrv8t2mHtFylH2AVMC4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624371159;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MV0b+6hqIBjxzeFJeDvfn68xd71ZPgq4wBs/0JgzBwI=;
        b=j8W88bSZwKkZW8pYXU7a63UjlK8Y0GjZ+nmhNTwPX/oDTuFf4MVf3YFk9iLuEmQzqz9ja6
        RZD5QqxdK5fLnvDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 6Er3Atfv0WBRUgAALh3uQQ
        (envelope-from <pvorel@suse.cz>); Tue, 22 Jun 2021 14:12:39 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] CI/openSUSE: Fix tpm_server symlink creation
Date:   Tue, 22 Jun 2021 16:12:23 +0200
Message-Id: <20210622141224.25006-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622141224.25006-1-pvorel@suse.cz>
References: <20210622141224.25006-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This symlink is missing only on openSUSE Tumbleweed,
it exists on openSUSE Leap, thus build failed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/tumbleweed.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index ecd2372..dfc478b 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -42,6 +42,6 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	which \
 	xsltproc
 
-if [ -f /usr/lib/ibmtss/tpm_server ]; then
+if [ -f /usr/lib/ibmtss/tpm_server -a ! -e /usr/local/bin/tpm_server ]; then
 	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
 fi
-- 
2.32.0

