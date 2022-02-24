Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ACE4C2E17
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Feb 2022 15:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233212AbiBXOVB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Feb 2022 09:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiBXOVB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Feb 2022 09:21:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE04294FFF;
        Thu, 24 Feb 2022 06:20:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 71E791F44C;
        Thu, 24 Feb 2022 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645712430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBxbP4mnt4PQT7En4CTQ+ZSao55n9SOd/y/IHHDxShQ=;
        b=dzKhQAuzzFjSdVY2KXefIhWND0BqHCS5hHFd+QD0vYdJzJi6NEOYbeUqDuEVvC9LXuGeeC
        lByQkyo+sgIepE5w036yP0cmxejRSKzHwsujs3KyqjASejp/EdKq56Lf6qaHkMslDCSJkC
        optx+FRHCxeIRTnKxMk0w3TxEogBZpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645712430;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBxbP4mnt4PQT7En4CTQ+ZSao55n9SOd/y/IHHDxShQ=;
        b=w9m02HCZyuzQDwgPJ/k7jUYIkxUch/Z6WSYRQR6jOeOugcQ8MSUc638b3TRF7iWT0ib27X
        AqQUJPAO2wapNlDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7CE313AE7;
        Thu, 24 Feb 2022 14:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mzqZNi2UF2I6PgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 24 Feb 2022 14:20:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     zohar@linux.ibm.com
Cc:     dvyukov@google.com, ebiggers@kernel.org, jmorris@namei.org,
        keescook@chromium.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com
Subject: Re: [PATCH 2/2] integrity: double check iint_cache was initialized
Date:   Thu, 24 Feb 2022 15:20:25 +0100
Message-Id: <20220224142025.2587-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20210322154207.6802-2-zohar@linux.ibm.com>
References: <20210322154207.6802-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi, Tetsuo, Kees, all,

FYI this commit merged as 92063f3ca73a ("integrity: double check iint_cache was initialized")
is the reason for openSUSE distro installer going back from lsm= to deprecated
security= when filling default grub parameters because security=apparmor or
security=selinux does not break boot when used with ima_policy=tcb, unlike
using lsm.

@Kees, @Mimi sure, people who use ima_policy=tcb will just remove lsm parameter
or add "integrity" to it but I wonder whether there could be "integrity"
automatic inclusion when using ima_policy=tcb. Although the point of lsm= (and
CONFIG_LSM) is to have *ordered* list of enabled LSMs and it wouldn't be clear
on which place.

Kind regards,
Petr
