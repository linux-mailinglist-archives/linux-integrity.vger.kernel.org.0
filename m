Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C344CBECE
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 14:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiCCN05 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Mar 2022 08:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiCCN05 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Mar 2022 08:26:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11884188859
        for <linux-integrity@vger.kernel.org>; Thu,  3 Mar 2022 05:26:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5081218D6;
        Thu,  3 Mar 2022 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646313969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KU1ESgWGVcxhNgj7MsT+FVwOhStany1C1ykZ09FN0Mg=;
        b=HZWgYtq7HnA7M5U+f+aBCXYiJR4TTDaZxLJHb+IOyuyVR+E4Ccdoj8hpA3CGLWX8QT5LN8
        ZYxNdHM1E1VebGIiwoajXxasinCCEjzjUADx9sdJHNKx1EA3mIYCNSzqP0DfWVnLQPXuG4
        PQfuqXBhdxreSLipWkx9yF0efZWSslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646313969;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KU1ESgWGVcxhNgj7MsT+FVwOhStany1C1ykZ09FN0Mg=;
        b=JPSgQmYl30tREmq6lr/WT2sLUMriKIG5iMewt3TfeFPWCONEiv0FkD7r9YR/WCEQve0CfG
        mbCtDp1blW8aMoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 910EC13C23;
        Thu,  3 Mar 2022 13:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yKTJIfHBIGKAWgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 13:26:09 +0000
Date:   Thu, 3 Mar 2022 14:26:07 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Yael Tzur <yaelt@google.com>, linux-integrity@vger.kernel.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
Message-ID: <YiDB7wO3Se/vN15+@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220223200731.1859670-1-yaelt@google.com>
 <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik>
 <YiC4Pj1sH8UIHY7k@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiC4Pj1sH8UIHY7k@yuki>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Cyril,

> Hi!
> > > I this case I guess that in this case the change is so minimal that we
> > > can add this test into LTP once it reaches Linus tree.
> > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > and put keyctl09 into runtest/staging now.

> I guess that we still did not agree on exactly how this should be
> handled or did we?

Isn't it enough "Once a feature is part of the stable kernel ABI the associated
test must be moved out of staging." ?

If not, we should raise this question on that patch thread to find a conclusion.

Kind regards,
Petr
