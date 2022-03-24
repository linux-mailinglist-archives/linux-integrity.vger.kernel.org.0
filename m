Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED24E6420
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 14:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346372AbiCXNeX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Mar 2022 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347487AbiCXNeX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Mar 2022 09:34:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F5C673EE
        for <linux-integrity@vger.kernel.org>; Thu, 24 Mar 2022 06:32:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2FCE31F38D;
        Thu, 24 Mar 2022 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648128770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
        b=UULNB12ViBgRUcA5ER+lehws3GKjqzuj3lblD8DkqrvHgXdVN4m9sCLoBG7v+9zlnx2GUD
        sahamD7MrTUTsZkXetjYN4TUMZ8LhZ2ldFeCGjIuxV2WMAfSbbFfXxgPsOSRFh8uuxwIPM
        3+UOcBGUqXscPjqg85+REVl706SuzCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648128770;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
        b=lFzSCJHY/CMCHr32/6WuOMESnHmua5Uika30pTJZFCMsmJdBKd0T56tw5tSSLXFgTkBGhU
        L6d3yyIuxzqnpuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A00612FF7;
        Thu, 24 Mar 2022 13:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QTYGAgJzPGKEbgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 24 Mar 2022 13:32:50 +0000
Date:   Thu, 24 Mar 2022 14:35:09 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Yael Tzur <yaelt@google.com>
Cc:     ltp@lists.linux.it, linux-integrity@vger.kernel.org
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YjxzjWHS19sUCl7T@yuki>
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
Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
