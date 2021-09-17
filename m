Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C640F67A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhIQLHD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 07:07:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbhIQLG4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 07:06:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 861A420271;
        Fri, 17 Sep 2021 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631876733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCuKsnzf5ibcFbLLej7h08Yyg4Gled4dD5KVly3q57k=;
        b=TBqkgRup2qSxXaHlENJ/W/RbdZMW5inpzNkUZVusiWM3f3DQARDUlZPjll4waV1kJVNkxY
        CZxiwfimC+Cpe3Xxsh/DcHkvLa77DnSdN+cDesWb4XtX32srrLYZ94oTNYScYypQxFX6Ml
        w5549BRejkbmgghRaz3jBQ+sItKgItU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631876733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCuKsnzf5ibcFbLLej7h08Yyg4Gled4dD5KVly3q57k=;
        b=heVzxKJbchLM7rt3rte4UNhm028vQj7h9ltfq7Xz4cc1p2zsBSSbQGOI+Ox9hp41brTVtm
        KubBk770b7yZMmBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4430E14063;
        Fri, 17 Sep 2021 11:05:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2ga8Dn12RGFGFgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 11:05:33 +0000
Date:   Fri, 17 Sep 2021 13:05:31 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v3 2/2] IMA: Add tests for uid, gid, fowner, and
 fgroup options
Message-ID: <YUR2e50EvdT8u+Ux@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210914161503.97495-1-alexh@vpitech.com>
 <20210914161503.97495-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914161503.97495-2-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
