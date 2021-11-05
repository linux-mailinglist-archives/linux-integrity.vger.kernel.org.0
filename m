Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927D944607C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Nov 2021 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhKEISK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Nov 2021 04:18:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44814 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhKEISG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Nov 2021 04:18:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DFCEC1FD43;
        Fri,  5 Nov 2021 08:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636100124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIXUiXV8pFZup18OSWYchpCPBz+e+9mNT54cvfdpdaQ=;
        b=Jobj6kQrMJvof2JPaXGkUqUK8h+eNCMTZElLQazJjLE/TpAYHFzSbNHyOWtJz/Oy5y3s5m
        bS53EGWgStRYaVyxSWNnqiJJHkhC1r58sTz8IyucMcGXGsunbXeu2OIC5LazcAsK3mqomc
        cPUkDM+xiRzoXSEdijQT+QHGwvZNF3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636100124;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIXUiXV8pFZup18OSWYchpCPBz+e+9mNT54cvfdpdaQ=;
        b=+tGXYR08K3FOeSQm6glLgGle/CqQU9Pd6VzW2Wv8knK31w+FUpS14INBC9LL+UZRFV1e9u
        8w8zkmb7IoNHdGBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC85813DFC;
        Fri,  5 Nov 2021 08:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J5dgJxzohGFLQwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 08:15:24 +0000
Date:   Fri, 5 Nov 2021 09:15:23 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.4 released
Message-ID: <YYToG+8u/edIcc3u@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Please refer to the NEWS file for the short summary and the git history
> for details of the ima-evm-utils v1.4 release.
Thanks for info, congrats!
Going to update openSUSE.

Kind regards,
Petr

> thanks,

> Mimi

