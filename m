Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EFD4E46B3
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Mar 2022 20:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiCVTcV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Mar 2022 15:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiCVTcU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Mar 2022 15:32:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD667CDD3
        for <linux-integrity@vger.kernel.org>; Tue, 22 Mar 2022 12:30:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 933C81F387;
        Tue, 22 Mar 2022 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647977451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEf1ZwQQdetMbF/u+d4fL7Mf2g4nxO2xq+wLzW+I/Uo=;
        b=nAwfAbuEhRELgzn6IKHLaBqInyIcI92t2pJ34tkgEZl3WGeo8fJakuwvSy+9MljJEzV4By
        FZf+wbCdpKU1kov0ipy2CdvTsfvG+jqd65J2CAAORb5OBeJy1BjFUqX0u8CcfpFpsRbjJ8
        1VN+Arh4QzHtPM3XCZIQD1e3UEFKawk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647977451;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uEf1ZwQQdetMbF/u+d4fL7Mf2g4nxO2xq+wLzW+I/Uo=;
        b=mnrJCykBJ4iW0ZOwQJBWDM6VWh6w4rjSQV/fczLVe23VFm/rWv98goX2q9FJGPUF0jhFK9
        yyO4EkZhY6gJQ7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5154913419;
        Tue, 22 Mar 2022 19:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 19GnEOsjOmIrMQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 22 Mar 2022 19:30:51 +0000
Date:   Tue, 22 Mar 2022 20:30:49 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH 1/1] ci: Remove CentOS 8
Message-ID: <Yjoj6VZzLtOydw0f@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220215074958.6942-1-pvorel@suse.cz>
 <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Tue, 2022-02-15 at 08:49 +0100, Petr Vorel wrote:
> > It EOL in 12/2021 and CI is failing due removed repo:

> > CentOS Linux 8 - AppStream                      232  B/s |  38  B     00:00
> > Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > the error:
> > https://github.com/pevik/ima-evm-utils/runs/5196409185?check_suite_focus=true

> > Mimi, could you please test Travis CI?
> > I tested only GitHub Actions:
> > https://github.com/pevik/ima-evm-utils/actions/runs/1845623174

> Removing "centos:latest" works, but is there another option?  Perhaps
> defining a different repo - "REPO=quay.io/centos/"?
This fix would be for Travis, which I'm not able to fix, but not for GitHub
Actions :(. I'm not aware how to specify alternative repository for it.

Kind regards,
Petr

> thanks,

> Mimi

