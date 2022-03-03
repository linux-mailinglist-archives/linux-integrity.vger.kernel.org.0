Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C925C4CBE0E
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 13:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiCCMnP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Mar 2022 07:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiCCMnO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Mar 2022 07:43:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E30DF6F
        for <linux-integrity@vger.kernel.org>; Thu,  3 Mar 2022 04:42:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 443EF21997;
        Thu,  3 Mar 2022 12:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646311346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xs8jqVpnxbRTelnhAQm950cFVdavmKGtU2ugu6BhiTQ=;
        b=ccNGzTnrtBlJQgSfv3AW2m3M4z4zX/cawYZ6YvRl+QDRJeInQe1YsU4PN9R7IG292fvbM0
        Yj+wBbGw0Wq/ny97xZFuBVOJOGRJYafP/UwE/y7i+eLLyS2gvNjQVpKwv911KH02MZvWFB
        aQM2a1yoW3CY80tPrAKHGQMeAdVF81w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646311346;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xs8jqVpnxbRTelnhAQm950cFVdavmKGtU2ugu6BhiTQ=;
        b=hGfFmfLq81JxbTFF93p3PT3YZW9IMiJ91SSQ+8PTpYCm3IaxOfEQoZsUKnbD1XniCBUh+X
        11q0s8k6CDM8weAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E7D313C08;
        Thu,  3 Mar 2022 12:42:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kWq6CrK3IGIsRQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 03 Mar 2022 12:42:26 +0000
Date:   Thu, 3 Mar 2022 13:44:46 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YiC4Pj1sH8UIHY7k@yuki>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiBcyvtqTX1CerM4@pevik>
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
> > I this case I guess that in this case the change is so minimal that we
> > can add this test into LTP once it reaches Linus tree.
> Cyril, maybe we could finally merge our policy (waiting ack for you):
> https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> and put keyctl09 into runtest/staging now.

I guess that we still did not agree on exactly how this should be
handled or did we?

-- 
Cyril Hrubis
chrubis@suse.cz
