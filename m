Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D550426640
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 10:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhJHIz3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 04:55:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59134 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhJHIz2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 04:55:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF1541FF9B;
        Fri,  8 Oct 2021 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633683212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXFVox1se9A93JfUhOjKYP2gOkzYcRU0hIofVs+vd5A=;
        b=ejOZurhGGWoOwF9gGDb5i9BulkjtuzFKgbOKRRgxOk/+Pm9yXKDaXIkDNF/85Vt3BOzhpZ
        Mq6CJjZnhx7Z5nEmU1HzOJg3bE422h4YoeTknN+bbcET0IsHZTRGFEOIECrixlJQRNQP+e
        NNUiH8NgGokSxZ3mzdU0xX8qw+m/cWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633683212;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXFVox1se9A93JfUhOjKYP2gOkzYcRU0hIofVs+vd5A=;
        b=BSYWL1ynOOeynmh0z1BFx86QDfhxVQIYYOoE+Uy7qyzSwospG+gZkGmalN1DpvqrtZfS7s
        PM59QuW6NtncjAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9301713D13;
        Fri,  8 Oct 2021 08:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 784IIgwHYGEMcgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 08:53:32 +0000
Date:   Fri, 8 Oct 2021 10:53:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        alexhenrie24@gmail.com
Subject: Re: [PATCH v3 1/2] ima: fix uid code style problems
Message-ID: <YWAHCv/Nm0SOTvNh@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211007200302.187892-1-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007200302.187892-1-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex, Mimi,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
