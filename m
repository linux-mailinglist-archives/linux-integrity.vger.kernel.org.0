Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4864CA9A5
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Mar 2022 16:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiCBPw1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiCBPw1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 10:52:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EFF4BFE3
        for <linux-integrity@vger.kernel.org>; Wed,  2 Mar 2022 07:51:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A112A2198B;
        Wed,  2 Mar 2022 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646236256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uq268kelTY7J8/FNu5uzfriLwC2GCfH7VBQN+cYpa4=;
        b=GsU9V8NaguhhzWuGXbNn/apet8UFpiG0k2Ctl5yA1baHqrisjOmYCP17Rm8pGav8rTgssO
        yPNRPabk6P9G/sLCykngFpg9uj5uPXB42xxdLzYE3OANM3EjzoEg5CA/UjCT/Ri2yUoXe5
        f0nkaQnLB+Q8VO2npDpqrLVhGrca0jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646236256;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0uq268kelTY7J8/FNu5uzfriLwC2GCfH7VBQN+cYpa4=;
        b=4b9TDHFc+aiuGqk26Tp+kVDURNNGJtlWIE9WOLe71b0OC4RjLk1mPFI1MUf0eY5Qasp7BW
        RsTqg+vvvBsHh6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88B1E13A84;
        Wed,  2 Mar 2022 15:50:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uTWZIWCSH2JkIQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 02 Mar 2022 15:50:56 +0000
Date:   Wed, 2 Mar 2022 16:53:16 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Yael Tzur <yaelt@google.com>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <Yh+S7JD2q8oalRoM@yuki>
References: <20220223200731.1859670-1-yaelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223200731.1859670-1-yaelt@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi!
The test looks good to me now.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Looking at the kernel counterpart it is still in the next tree. We
usually wait until the kernel functionality is part of a kernel release
in order to make sure that there are no changes done to the
kernel-userspace API.

I this case I guess that in this case the change is so minimal that we
can add this test into LTP once it reaches Linus tree.

-- 
Cyril Hrubis
chrubis@suse.cz
