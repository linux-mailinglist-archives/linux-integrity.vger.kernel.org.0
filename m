Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4301F5A6457
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiH3NEf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Aug 2022 09:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiH3NEe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Aug 2022 09:04:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32415760F8
        for <linux-integrity@vger.kernel.org>; Tue, 30 Aug 2022 06:04:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E1B081F8A8;
        Tue, 30 Aug 2022 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661864672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=gZHQ25ErP2BavEIwC7k7ltlyTaAE+O3m2mdqOmDIeGoSt2ZsRnaXidoYtEJ49bK0GdzZxd
        RKrB5BzNcBKZOeC8wG2s/MXBfjL6nU1wuaprlP9TG8nVs33gwpObri6AmlegHfTzCWmWoj
        0dhOKkkmeG1ozdVoSW3pOlUEYfqQg1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661864672;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fo8eUnL9rNH3pXcnmcQ3TJsORGYLlEttEPXpkVE76os=;
        b=qxQs13sLHTf+VyhMKTVOxyIsUXtLqAA27OTcKUugK5QjobSKHKfk+oTObbzsIKHyfiWsEW
        RlHmJLkxE0tDeGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D15B13B0C;
        Tue, 30 Aug 2022 13:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VenGJOAKDmO+dgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 30 Aug 2022 13:04:32 +0000
Date:   Tue, 30 Aug 2022 15:04:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [RFC PATCH ima-evm-utils 09/11] Fix potential use after free in
 read_tpm_banks()
Message-ID: <Yw4K3rd6o5L5ZzVf@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
 <20220830005936.189922-10-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830005936.189922-10-zohar@linux.ibm.com>
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
