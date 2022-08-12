Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18EB591579
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Aug 2022 20:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiHLS3F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Aug 2022 14:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiHLS3F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Aug 2022 14:29:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E726B2DBC;
        Fri, 12 Aug 2022 11:29:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 25B892076B;
        Fri, 12 Aug 2022 18:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660328943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPX04jbC0BQlROGb55mEQeAkYdO/pUMQJcyP6P8yDMg=;
        b=Dnk3QtxahbVc8N9Wb+mg3LWpIqkL3j324Xp+zLN1b3scdy/6qC3SQRFK8mueXE9dOR3bzD
        kJVAa0mCRV10Ey1xRS0KdJiaA9Wz8rqTWrRnCe1cOw0qo+FQTx1rfRhSaWUJljn9CEbQwD
        xzFf5Tca5Jc7aJLzQhyTBqFAUhyiUPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660328943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPX04jbC0BQlROGb55mEQeAkYdO/pUMQJcyP6P8yDMg=;
        b=RKeJHxsr+7BAG6RlGp765vCQzZKzbcl/KDPcaPksygxZXVLn3ATBYyju64TDEMjTHB+oX2
        LKozQGXN/hssDQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14F5C13AAE;
        Fri, 12 Aug 2022 18:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Is0VBe+b9mLdIgAAMHmgww
        (envelope-from <bp@suse.de>); Fri, 12 Aug 2022 18:29:03 +0000
Date:   Fri, 12 Aug 2022 20:28:58 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jonathan McDowell <noodles@fb.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH v7 3/6] x86/kexec: Carry forward IMA measurement log on
 kexec
Message-ID: <Yvab6lC9BUbmp4a8@zn.tnic>
References: <20220812164305.2056641-1-stefanb@linux.ibm.com>
 <20220812164305.2056641-4-stefanb@linux.ibm.com>
 <YvaJc7bQjz61Y1jj@zn.tnic>
 <935988a4-c245-7cb1-4e14-bc99d39220a1@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935988a4-c245-7cb1-4e14-bc99d39220a1@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 12, 2022 at 01:14:38PM -0400, Stefan Berger wrote:
> Yes, so this series can be tested by krobot.

You mean Intel's 0day robot?

I believe that thing has by now enough logic to figure out which branch
to base patches ontop. Or maybe there's some magic incantation to tell
it which base commit to use so that you can simply do your patches ontop
of latest linux-next instead of having to carry upstreamed patches.

Also, there's a little point in testing against 5.19 when you wanna test
it against v6.0-rc1...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
