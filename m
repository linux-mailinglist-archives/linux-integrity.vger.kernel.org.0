Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A118426642
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Oct 2021 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbhJHI4K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 8 Oct 2021 04:56:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59152 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbhJHI4J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Oct 2021 04:56:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 036321FF9B;
        Fri,  8 Oct 2021 08:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633683254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kr6ax75RDQM75AhdKI4ptNi7kDlOeTak+FEaRlVGM4I=;
        b=2KX8/PYvq3mJVWAoSgehxwhb2XTPB1phPfbfMfHiFCTUEpujN4T5nJSC4uYb2diC3joU/+
        LYvhfy7sJB8pNPff734sT1MhhCsSuP4x58GHDRAEG1oMnSdkZ1c4CycGFlXSL7IAQESnEx
        HzraUlHm8zSUj0+17lj8U6Yf+3RUfBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633683254;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kr6ax75RDQM75AhdKI4ptNi7kDlOeTak+FEaRlVGM4I=;
        b=syYlb9yTw4nheCXjbGYFDtbd8BjNrGfhwtxF6aKUHo+hG96Ss6v8bxtFMOn0axd4YlD+OP
        sKMPVuQXvfnyZUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B980013D13;
        Fri,  8 Oct 2021 08:54:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c+CnKzUHYGFXcgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 08 Oct 2021 08:54:13 +0000
Date:   Fri, 8 Oct 2021 10:54:12 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        alexhenrie24@gmail.com, Curtis Veit <veit@vpieng.com>
Subject: Re: [PATCH v3 2/2] ima: add gid support
Message-ID: <YWAHNJZGhfZBQIvh@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211007200302.187892-1-alexh@vpitech.com>
 <20211007200302.187892-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007200302.187892-2-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
