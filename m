Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC125A644E
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 15:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiH3NC1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 09:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiH3NC0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 09:02:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5A6CF51
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 06:02:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86F2121AC7;
        Tue, 30 Aug 2022 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661864544;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lePurlzWR72axl1E8dO4XV3E3VcSWUy9pbMLfqktLNg=;
        b=sCuWkudJr41Kzo66/n4UiWfJXiUf/avjRKOybq04qLN2ndCkv2QI0XzS+HjwZTxylPjxWg
        6ANpaUkzoRUdyjbtHD1bRqinMgTpQRsf5z1fuYIO1OoH7VhBhSkubTayY+27/nDh54+p1h
        zysiu+4ud8WymmGMJvsBWpeWvXYSpBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661864544;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lePurlzWR72axl1E8dO4XV3E3VcSWUy9pbMLfqktLNg=;
        b=//N44J7Bld66eiffuvjUxqO7FaX6wr6+xe4MEbwDSueLLje3Mga6jKT+9eEoGaVJmEciWR
        JyLIGOvJibjFiWDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5708813B0C;
        Tue, 30 Aug 2022 13:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zIJ7E2AKDmPvdQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 13:02:24 +0000
Date:   Tue, 30 Aug 2022 15:02:22 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 07/11] Add missing EVP_MD_CTX_free()
 call in calc_evm_hash()
Message-ID: <Yw4KXo1/g1DjmFOU@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-8-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-8-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> When EVP_MD_CTX_new() call was added, the corresponding EVP_MD_CTX_free()
> was never called.  Properly free it.

> Fixes: 81010f0d87ef ("ima-evm-utils: Add backward compatible support for openssl 1.1")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
