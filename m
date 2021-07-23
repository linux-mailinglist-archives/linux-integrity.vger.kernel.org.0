Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673773D39E2
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 14:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhGWLVQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 07:21:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44962 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234231AbhGWLVQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 07:21:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 410251FF95;
        Fri, 23 Jul 2021 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627041709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Syto08aSik862XBe9R3vhUyX26PmcGvoZJs4wpfNcZQ=;
        b=fi/L+EU3P4HyPGc9bXNUvnfzSbgDy8K8JR9qG69ERkMUDTfL0BWwie/TB9X9lJkcLMCgkK
        p1Lg6FHHTGlEgE02s+QYlMtXXVm7b8jCJKiWYSJyrRgHmvoO8SoRjGZUy0NH/xK6ki7wcD
        j9klg34lL0OOy/kK/oucM/0qlVKqa90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627041709;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Syto08aSik862XBe9R3vhUyX26PmcGvoZJs4wpfNcZQ=;
        b=e+B1rgUJbyduczDQU0Ncfkr37NL0GxpK8zr2eihTHckO68cA/mRN4wcTCN8MC+8XTRJS5U
        /17kau22T6cMdZDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E7AFD13697;
        Fri, 23 Jul 2021 12:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8u7ANayv+mBtDQAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Fri, 23 Jul 2021 12:01:48 +0000
Date:   Fri, 23 Jul 2021 14:01:46 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Subject: Re: [PATCH ima-evm-utils v2] ima-evm-utils: Fix incorrect algorithm
 name in hash_info.gen
Message-ID: <YPqvqoyM0lpiH4R5@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210723064108.14681-1-tianjia.zhang@linux.alibaba.com>
 <4b3c3c5e26e3f64bd3c0cea5eca6b7e515f58627.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3c3c5e26e3f64bd3c0cea5eca6b7e515f58627.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia, Mimi,

> Hi Tianjia,

> On Fri, 2021-07-23 at 14:41 +0800, Tianjia Zhang wrote:
> > There is no such an algorithm name as sm3-256. This is an ambiguity
> > caused by the definition of the macro HASH_ALGO_SM3_256. The sed
> > command is only a special case of sm3, so sm3 is used to replace
> > the sm3-256 algorithm name.

> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  src/.gitignore    | 1 +
> >  src/hash_info.gen | 7 ++++---
> >  2 files changed, 5 insertions(+), 3 deletions(-)

> > diff --git a/src/.gitignore b/src/.gitignore
> > index 38e8e3c..69d2988 100644
> > --- a/src/.gitignore
> > +++ b/src/.gitignore
> > @@ -1 +1,2 @@
> >  hash_info.h
> > +tmp_hash_info.h
> > diff --git a/src/hash_info.gen b/src/hash_info.gen
> > index 5f7a97f..f52bb4d 100755
> > --- a/src/hash_info.gen
> > +++ b/src/hash_info.gen
> > @@ -84,9 +84,10 @@ echo "};"
> >  echo "const char *const hash_algo_name[HASH_ALGO__LAST] = {"
> >  sed -n 's/HASH_ALGO_\(.*\),/\1 \L\1\E/p' $HASH_INFO | \
> >    while read a b; do
> > -    # Normalize text hash name: if it contains underscore between
> > -    # digits replace it with a dash, other underscores are removed.
> > -    b=$(echo "$b" | sed "s/\([0-9]\)_\([0-9]\)/\1-\2/g;s/_//g")
> > +    # Normalize text hash name: sm3 algorithm name is different from
> > +    # the macro definition, which is also the only special case, and
> > +    # underscores are removed.

> Thank you for updating the comment.  Do you mind if I tweak it a bit:

> ^which is also the only special case of an underscore between digits. 
> Remove all other underscores.
+1

Kind regards,
Petr

> Mimi

> > +    b=$(echo "$b" | sed "s/sm3_256/sm3/g;s/_//g")
> >      printf '\t%-26s = "%s",\n' "[HASH_ALGO_$a]" "$b"
> >    done
> >  echo "};"


