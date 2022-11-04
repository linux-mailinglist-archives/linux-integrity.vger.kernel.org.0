Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2C61A35D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Nov 2022 22:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiKDVd0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Nov 2022 17:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiKDVdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Nov 2022 17:33:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BFF1148
        for <linux-integrity@vger.kernel.org>; Fri,  4 Nov 2022 14:33:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8A93D21941;
        Fri,  4 Nov 2022 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667597601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5u7abmmvF/qcnbZOL3eeS0LEwOtJFTdbmiiuO/YZE/s=;
        b=XEPD1NginBXsCdFhqUrqrbbT61ACAvDHEOjydyvunXaeWSyLoU+cIatnESyABwohSbixXc
        97ew6/qzG1aNmFuaCLHKjyPzj1thSUAOWx1taTY32o2dvZqcAriQBiY7aP+fsJReoKWgBf
        ZTEk8LA2vhnUXDYVLqyVEAG5DuGBVOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667597601;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5u7abmmvF/qcnbZOL3eeS0LEwOtJFTdbmiiuO/YZE/s=;
        b=AhFlHys9nNJ8HkFC43NSS2433I6YlEW0YKHOT6bfv9fEvENuJmOKPLA4pJXLQzt3DjaGFX
        bzXRIz0uHXvpEcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA0871346F;
        Fri,  4 Nov 2022 21:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id smWkJyCFZWMYCAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 04 Nov 2022 21:33:20 +0000
Date:   Fri, 4 Nov 2022 22:33:19 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5 01/17] Revert "Reset 'errno' after
 failure to open or access a file"
Message-ID: <Y2WFHyiUgmSEbC1L@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
 <20221103183904.103562-2-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103183904.103562-2-zohar@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> This reverts commit acb19d1894a4a95471b8d2346cd6c3ecf3385110.
I remember there was some discussion about it, but it'd be nice to wrote the
result for the revert (e.g. will be fixed properly in next commit).

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
