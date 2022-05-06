Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C63351DD15
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443654AbiEFQM4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 12:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443558AbiEFQMt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 12:12:49 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6840F6EC53;
        Fri,  6 May 2022 09:08:23 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2CEDD1C0BCD; Fri,  6 May 2022 18:08:22 +0200 (CEST)
Date:   Fri, 6 May 2022 18:08:20 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
Message-ID: <20220506160820.GB1060@bug>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi!

> One annoyance of the "preloading" scheme is that hibernate image memory
> is effectively double-allocated: first by the usermode process pulling
> encrypted contents off of disk and holding it, and second by the kernel
> in its giant allocation in prepare_image(). An interesting future
> optimization would be to allow the kernel to accept and store encrypted
> page data before the user key is available. This would remove the
> double allocation problem, as usermode could push the encrypted pages
> loaded from disk immediately without storing them. The kernel could defer
> decryption of the data until the user key is available, while still
> knowing the correct page locations to store the encrypted data in.

Um. Dunno. Won't you run out of memory? Hibernation images can be quite big...

Best regards,
									Pavel
