Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D602426723
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 11:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhJHJvQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 05:51:16 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhJHJvP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 05:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5A9D20116;
        Fri,  8 Oct 2021 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633686559;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6QU4JEJg2ILscmywWsFr2OY1JnT6L4LYp+taGZjMqw=;
        b=sLELKBlLfsYRhLeGUjQLz0MPoO7neosozEaXTdl7aub9fLHdka0mGvG1uFCdEHCbsgJDUW
        J9Dc5ncxwQ7xR+tWZwdkE7BPjplWj7zOvggxkyK7ZZLAfJn7Arvyz8bRsLnUAo1mUGwtrL
        9nrEwZhVLOgyZtUisuzRk/Tg66CvBj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633686559;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6QU4JEJg2ILscmywWsFr2OY1JnT6L4LYp+taGZjMqw=;
        b=u+6S18t/GcJp/HvMTYu3mC1nEQl9UojtpAmljgPsyopDEY19+Iu8JvMrNn+yC+tKB9dAvO
        tsHAL9i3PNzA54DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FEDB13EA2;
        Fri,  8 Oct 2021 09:49:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KE5RJB8UYGFOEAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 09:49:19 +0000
Date:   Fri, 8 Oct 2021 11:49:17 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Alex Henrie <alexh@vpitech.com>, alexhenrie24@gmail.com,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v6 0/2] IMA checkpatch fixes
Message-ID: <YWAUHS4NWQ6UCont@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211008091430.22392-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008091430.22392-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

Ah, version of this patchset is obviously 1, not 6.

Kind regards,
Petr
