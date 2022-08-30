Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5225A620A
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 13:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiH3LeN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 07:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiH3Ld6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 07:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5093CFE059
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 04:31:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5F91F9FF;
        Tue, 30 Aug 2022 11:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661859097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAT15nfORjSp9JpidfSCNY+X6rnWZXixdS+H+SL9X4o=;
        b=2LjjCmJk2FqjWGli/jypd3RoRZZHBCu1SBtVEBX932ykWM0PRgaqL2UOl8h/JHw9VGv1LV
        2SYHoQwFVBB7beXTYSS4yCyMm+xNwN06bQjo56mgfg/5N/ygUWvZxghxr0UEB6TWHMpTXw
        R8yikxYC28Q+f2hzo005NO6VC65zONU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661859097;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AAT15nfORjSp9JpidfSCNY+X6rnWZXixdS+H+SL9X4o=;
        b=oNhobmMJjZO4Eo1gqmPWRO7FWI9BniVUzdHicwX+6bpvnKlET/5Vx7BRODSkMa+gJZZzHs
        +q3fIZVYRxrGnXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54C0F13ACF;
        Tue, 30 Aug 2022 11:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id heRVExn1DWMfTQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 11:31:37 +0000
Date:   Tue, 30 Aug 2022 13:31:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 02/11] travis: update dist=focal
Message-ID: <Yw31F8JlvuWwtMsJ@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-3-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-3-zohar@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Although Github Actions is GA within Github Enterprise Server 3.x single
> server edition, it is not available in Github Enterprise Server 3.x
> cluster edition[1].  Continue to support travis.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Working on unpaid version as well.

Kind regards,
Petr
