Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15004E5374
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Mar 2022 14:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiCWNqk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240686AbiCWNqj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 09:46:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846AE17A92
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 06:45:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3B611F387;
        Wed, 23 Mar 2022 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648043108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzhatBaQMU0UZa1rko9qn4hYZAzGqYcJxn2n1hc/45U=;
        b=s7ibFI9Lq02VZ8HTF4fCzDwPLSXrdXRkbCpa1Yg4nRFR4m7EqJa1YV5L8oCdisNgRthknp
        ijCsO14MUlXQrcQYMkqQozQVtGVs83Tcruoz2vK0wbrvW4p8XW/cA4JrNZ+d3mUbpFJMI5
        sTjkR77f4/tg8nek2qgtDMKa9BWbIlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648043108;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rzhatBaQMU0UZa1rko9qn4hYZAzGqYcJxn2n1hc/45U=;
        b=sweaXjgTANesW+0fVbl7yityzJlhdDM383cSfjwBz0PwqlfsqwqVQccgaQxJ7iiNxFW+Rr
        /mAzs2NoukZLaBCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C924013302;
        Wed, 23 Mar 2022 13:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F1YCL2MkO2JGMwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 13:45:07 +0000
Date:   Wed, 23 Mar 2022 14:45:06 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH 1/1] ci: Remove CentOS 8
Message-ID: <YjskYri179zwTJtp@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220215074958.6942-1-pvorel@suse.cz>
 <401a1ee927a68a7c0811f21f4e75b6f01956e59c.camel@linux.ibm.com>
 <Yjoj6VZzLtOydw0f@pevik>
 <8c8dc78ab91d41c5755b5e1ae13a3054816d8072.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8dc78ab91d41c5755b5e1ae13a3054816d8072.camel@linux.ibm.com>
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

> > > Removing "centos:latest" works, but is there another option?  Perhaps
> > > defining a different repo - "REPO=quay.io/centos/"?
> > This fix would be for Travis, which I'm not able to fix, but not for GitHub
> > Actions :(. I'm not aware how to specify alternative repository for it.

> FYI, "centos:stream9" results in crypto deprecated warnings and results
> in /dev/null errors.  Instead of removing the "centos:latest" entry in
> travis, I'll replace it with "centos:stream8" for now.
centos:stream8 does not work on GitHub Actions:

/usr/bin/docker pull centos:stream8
  Error response from daemon: manifest for centos:stream8 not found: manifest unknown: manifest unknown
  Warning: Docker pull failed with exit code 1, back off 8.858 seconds before retry.
  /usr/bin/docker pull centos:stream8
  Error response from daemon: manifest for centos:stream8 not found: manifest unknown: manifest unknown
  Warning: Docker pull failed with exit code 1, back off 8.279 seconds before retry.
  /usr/bin/docker pull centos:stream8
  Error response from daemon: manifest for centos:stream8 not found: manifest unknown: manifest unknown
  Error: Docker pull failed with exit code 1

> The "centos:stream9" -devel rpm packages are in the CRB repo.  I
> manually set the CRB repo to enabled using sed.  Is there a better way
> of enabling CRB?

> Do you prefer to limit this patch to just removing the "centos:latest"
> entry in ci.yml and reposting it, or should I trim it?
In this case I'll send another version where I remove it just for GitHub
Actions. It's just a bit unfortunate, that it will have different OS to test
from Travis.

Kind regards,
Petr

> thanks,

> Mimi

