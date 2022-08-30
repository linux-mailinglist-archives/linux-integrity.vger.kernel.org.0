Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C25A6458
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiH3NFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3NFG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 09:05:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E413AB2C
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 06:05:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 157281FA80;
        Tue, 30 Aug 2022 13:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661864702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=h74KIoIuLyUujV9FXSkAM8BYvVqsPyEJQU1LMzKsPXTdzVYCzs3F+9pESMHNEl6p6UWLfp
        8fbs9gdF02ZlqsDzYpb/SE5mfuyQOSxiw/2leMrVU83HuYw/sOjUVEzNWr4F9MbZzQehPj
        boagAtMv9O1/qrkd5ee3JT4sPglekx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661864702;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=go68AVq9Ii01Pj7MXQdT83G3xQPyS+TTGQa5nk+xjASoA2s1wuiHBBEa3uGziR1kdLRnSx
        N5vNoFxTDYduq/Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1B4F13B0C;
        Tue, 30 Aug 2022 13:05:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FOkTJf0KDmPidgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 13:05:01 +0000
Date:   Tue, 30 Aug 2022 15:04:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 10/11] Limit the file hash algorithm
 name length
Message-ID: <Yw4K+7kUU4RbLo4N@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-11-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-11-zohar@linux.ibm.com>
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
