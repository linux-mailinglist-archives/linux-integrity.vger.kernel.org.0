Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71BF452E51
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Nov 2021 10:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbhKPJsJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Nov 2021 04:48:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:49710 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhKPJsI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Nov 2021 04:48:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E5371FD26;
        Tue, 16 Nov 2021 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637055910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jt0khjIMGrtpJBgM3VFNRZ9OiYsUygQh0pMSCg9zcL8=;
        b=DFGhSeVc50yJPsqZp/KDZx12b4nPTu45cxX9Hp/8LTRjQ0xWeK+Cp72zXIoVCD9swxs7oH
        Ydw1q+OR3Oojuqgm/bVrb2e55fuMqiaQIhf99kn3u9JWpcedooXRGiXkrbXyP+wrEZXmtJ
        CemDAX4Cqa7+B7vXqdFzzRrxzojaSgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637055910;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jt0khjIMGrtpJBgM3VFNRZ9OiYsUygQh0pMSCg9zcL8=;
        b=XU0Ho0uJooPwsyDQ241nDafzkOxpdPVAgDBL6s/s3yely/dD6SpgiahvOScGpHkpkLKkFX
        JmpDI7dog5AJYKDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5917F13BFD;
        Tue, 16 Nov 2021 09:45:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m1PaE6Z9k2GOFAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 16 Nov 2021 09:45:10 +0000
Date:   Tue, 16 Nov 2021 10:45:08 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Subject: Re: ima-evm-utils: version 1.4 released
Message-ID: <YZN9pJeU6rDfEzVr@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
 <YYToG+8u/edIcc3u@pevik>
 <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
 <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
 <YYmLOoa6E78G3ii2@pevik>
 <ca8a4b45b3d7449b41b244217dddc9c91335780c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca8a4b45b3d7449b41b244217dddc9c91335780c.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Hi Petr,

> On Mon, 2021-11-08 at 21:40 +0100, Petr Vorel wrote:
> > Github repository is marked as primary. How about moving releases also to
> > GitHub?

> Done.
Great, thank you! Also, when you have time, could you please put there
checksums? (ideally sha256/sha512) or even signed checksum file).

Kind regards,
Petr

> thanks,

> Mimi

