Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7645747BE67
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 11:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhLUKsI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 05:48:08 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:45306 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhLUKsH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 05:48:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9DCE41F388;
        Tue, 21 Dec 2021 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640083686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AbfCrwTcgXJNYxMWN99H4eXJ0A9mLBjD7Y9Uzue0Z+g=;
        b=pgxemyO4pXQGI6M4S5jNS8B5Ok4JZwefgkFlEyYw82QUuc+fFH1g/1/LbgAKCr7t+Q1Ypx
        RCaVDvS2ZlLgBNkVmQHjP1glK0nm80V1pzJqGUJ3pzedk2UjSqUe4dQaoS5j8HS4DfHtqQ
        P+nEDUTefVU0tcrLR+jjfiP7AZkMQnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640083686;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AbfCrwTcgXJNYxMWN99H4eXJ0A9mLBjD7Y9Uzue0Z+g=;
        b=DAr4EQNXoVKhGC1jQ9S3x94eg8Kb9hN+ciGFo2370AgAgutUzfrRVc4le4GZaxBgfAwl5i
        EUadzfpipKdZiGCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6142213C26;
        Tue, 21 Dec 2021 10:48:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +lGEFOawwWHmZwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 10:48:06 +0000
Date:   Tue, 21 Dec 2021 11:48:04 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Nageswara Sastry <rnsastry@linux.ibm.com>
Cc:     Yael Tiomkin <yaelt@google.com>, ltp@lists.linux.it,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] syscalls/keyctl09: test encrypted keys.
Message-ID: <YcGw5Lyo+hBEnlFD@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211221023721.129689-1-yaelt@google.com>
 <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafb5351-a73a-dac3-b0fa-3faad707bafa@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Nageswara,

> On 21/12/21 8:07 am, Yael Tiomkin wrote:
> > Test that encrypted keys can be instantiated using
> > both user-provided decrypted data
> > (https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/),
> > or kernel-generated numbers.

> > Signed-off-by: Yael Tiomkin <yaelt@google.com>

> Tested on ppc64le platform

I suppose it also fails on ppc64le when run more iterations.
./keyctl09 -i500
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read
...
keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data

(It's always good to put higher number iterations.)

Kind regards,
Petr
