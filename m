Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18451DD10
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443604AbiEFQMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 12:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443647AbiEFQMn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 12:12:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE4A6FA2E;
        Fri,  6 May 2022 09:08:12 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CF2A51C0BA6; Fri,  6 May 2022 18:08:09 +0200 (CEST)
Date:   Fri, 6 May 2022 18:08:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Garrett <mgarrett@aurora.tech>, dlunev@google.com,
        zohar@linux.ibm.com, jejb@linux.ibm.com,
        linux-integrity@vger.kernel.org, corbet@lwn.net, rjw@rjwysocki.net,
        gwendal@chromium.org, jarkko@kernel.org, linux-pm@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Hao Wu <hao.wu@rubrik.com>, James Morris <jmorris@namei.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Len Brown <len.brown@intel.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, axelj <axelj@axis.com>,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/10] Encrypted Hibernation
Message-ID: <20220506160807.GA1060@bug>
References: <20220504232102.469959-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20220504232102.469959-1-evgreen@chromium.org>
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

> We are exploring enabling hibernation in some new scenarios. However,
> our security team has a few requirements, listed below:
> 1. The hibernate image must be encrypted with protection derived from
>    both the platform (eg TPM) and user authentication data (eg
>    password).
> 2. Hibernation must not be a vector by which a malicious userspace can
>    escalate to the kernel.

Can you (or your security team) explain why requirement 2. is needed?

On normal systems, trusted userspace handles kernel upgrades (for example), 
so it can escalate to kernel priviledges.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
