Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4345A643D
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 14:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiH3M7t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiH3M7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 08:59:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA32F3B3
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 05:59:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECCEC1FA79;
        Tue, 30 Aug 2022 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661864381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5Wekt9avyhcGTtzvbj+Xezr6L1UReDJ2yAbIk65A+0=;
        b=Nmd1qqlya0ljvNLCD007nsh9Ev1mXO1Qf6p1MDOxRyyB0ekGEIHxpYT6/8oISwL1YYxEKp
        OnkTIIPMcl4jv6Dan2EoRt8lUttaINPnCJua/1vneC0LC3Wd5IX7SttRx0a3yNZbKAhEuv
        fIK3KThyyHK8luOTnPIPXkAcqwXtjZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661864381;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5Wekt9avyhcGTtzvbj+Xezr6L1UReDJ2yAbIk65A+0=;
        b=NAsEsp/sSx1FXaz6TwORCE+AcDSHkL1XKtWyRmRFpZo7KdWWV1HnwBs2lc83QHBOPGtnMd
        n+nWAyYf6SgiUQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B61E413B0C;
        Tue, 30 Aug 2022 12:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0nX7Kr0JDmOMdAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 12:59:41 +0000
Date:   Tue, 30 Aug 2022 14:59:39 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 06/11] Replace the low level HMAC calls
 when calculating the EVM HMAC
Message-ID: <Yw4Ju5+bEJ3t5l9x@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-7-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-7-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi mImi,

> Calculating the EVM HMAC and labeling the filesystem was originally
> included in ima-evm-utils for debugging purposes only.  For now,
> instead of removing EVM HMAC support just replace the low level
> HMAC_ calls with EVP_ calls.

> The '-a, --hashalgo' specifies the IMA hash or signature algorithm.
> The kernel EVM HMAC is limited to SHA1.  Fix ima-evm-utils by hard
> coding the EVM HMAC algorithm to SHA1.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
