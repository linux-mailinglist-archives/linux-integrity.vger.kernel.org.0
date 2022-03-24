Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF54E64C1
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 15:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiCXON5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Mar 2022 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344493AbiCXON4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Mar 2022 10:13:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3212AC04F
        for <linux-integrity@vger.kernel.org>; Thu, 24 Mar 2022 07:12:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8E8771F38D;
        Thu, 24 Mar 2022 14:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648131143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHgRdiKMEoGbWtI3cdinS+VtQweisGNmeGB63BLjflI=;
        b=viLFsUNQX3EaBaYAKUPWKDTJtwaCuFKcSlfHNeA/BhKjeNSiIl8q/VijyI15e9D37vavjR
        IGbqAGH5gnMxmKIetwBdFT5NPX4/1dmsBtvT17s9rv0+zwa4Sb+ltESq1jeIf7X9a+R25V
        SfipC9Y0xpT/c2NeGGmPzvtUylgVWkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648131143;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHgRdiKMEoGbWtI3cdinS+VtQweisGNmeGB63BLjflI=;
        b=xxE7A0smVNThItO07LAHkITy/IRBiimYNkbhATuTypjnA+6VsWIX1ZdIuOTNHzppvA/uhN
        D25KZE35jsL/KrCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 614D412FF7;
        Thu, 24 Mar 2022 14:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eei0FUd8PGIcfwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 24 Mar 2022 14:12:23 +0000
Date:   Thu, 24 Mar 2022 15:12:21 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils] travis: include CentOS stream 8
Message-ID: <Yjx8RWbYwYV0ihKK@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220323233057.42287-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323233057.42287-1-zohar@linux.ibm.com>
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

> Replace CentOS 8 with CentOS stream 8.
> Use podman for both CentOS 7 & 8.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

What a shame that GitHub Actions cannot specify container.

Kind regards,
Petr
