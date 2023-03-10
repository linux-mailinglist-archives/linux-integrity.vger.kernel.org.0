Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6826B50E5
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCJT0W (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 14:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJT0V (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 14:26:21 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23441340E8;
        Fri, 10 Mar 2023 11:26:19 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9A67860501;
        Fri, 10 Mar 2023 20:26:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1678476377; bh=Q5wxs19SY0EymuNpLehBcnkGyEEzKnIQG/lWl0cjgdw=;
        h=Date:From:To:Cc:Subject:From;
        b=Y2bHxrgCaCfhlj6IOjpAOyS8eKcAQ8AUxOd53GorXBWVTTvicQDgyL07IR/AAtujN
         4n5+xE1OTLj8VzpUCjbBOwmSdLEKhdASz5vDNIJJkmRIuZH79QcaZAwGIcHLNPMSuQ
         WhxndFqz63PTEnrA5dmLX9Zt/Pz0q6Ebc1oZdMf470FBcwJTpOo5+bcUAkIqUP699G
         DRGWlaNAmjrI+DkkCadQK0hhXluZw6tk7jkhkrsxRzDEAXJzER2qQ1uHa8Y2SJY51T
         8mQlc7FlY+C0f//yl2b/tug3WnDqRjD4k1H5P3ZMSryG+z+NlNwBYgx7KTkYCgIo7n
         oXcacUAtVCIkw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id omi2TE8uLxU7; Fri, 10 Mar 2023 20:26:14 +0100 (CET)
Received: by domac.alu.hr (Postfix, from userid 1014)
        id 7AB7560502; Fri, 10 Mar 2023 20:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1678476374; bh=Q5wxs19SY0EymuNpLehBcnkGyEEzKnIQG/lWl0cjgdw=;
        h=Date:From:To:Cc:Subject:From;
        b=oAxssaA7+wt7b6MQOwv+Z1DgULMXdg3Gv/Z7J+kQ8DXpFDJPYbsi5b3RQ9HJVrXgA
         RmGHQqJNGYTN3Itm1/lNuMSqoeBktnhNA6iKqxBBjyrtHQVssWkAXNYC4wMrxn1+z/
         Le+/fujeMnga0TwF0OXoBi25myUojapr9j93IP70YLZEDMb5NA72Eh1V/rAd7B5T7F
         PAqSbRtILsv1EItJtI5S633wZ3j9wHN58by2w2M85Vm+W9cIQpLKVHxlNYVz3An5jC
         lZRwP3jvYxt469qgNrsM+rAK+Xgv9tyRQCGf+tDaNZKqssRRAEDl3cZDyozFPKiJ/J
         YH7ntR7HORvzA==
Date:   Fri, 10 Mar 2023 20:26:14 +0100
From:   Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
To:     linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v1 0/2] Add destructor hook to LSM modules
Message-ID: <20230310192614.GA528@domac.alu.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a proper
kmem_cache_destroy() destructor.

Introducing the release() hook would enable LSMs to release allocated resources
on exit, and in proper order, rather than dying all together with kernel shutdown
in an undefined order.

Thanks,
	Mirsad

---
 include/linux/lsm_hooks.h | 1 +
 security/integrity/iint.c | 7 +++++++
 2 files changed, 8 insertions(+)

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union
