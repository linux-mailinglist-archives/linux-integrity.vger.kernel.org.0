Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDCB484D0C
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 05:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbiAEEUK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 23:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiAEEUJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 23:20:09 -0500
X-Greylist: delayed 1311 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jan 2022 20:20:09 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A4C061761
        for <linux-integrity@vger.kernel.org>; Tue,  4 Jan 2022 20:20:09 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4xRD-00HN5S-UP; Wed, 05 Jan 2022 03:58:12 +0000
Date:   Wed, 5 Jan 2022 03:58:11 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH v8 01/19] securityfs: Extend securityfs with namespacing
 support
Message-ID: <YdUXU3XIzhxFUfVB@zeniv-ca.linux.org.uk>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104170416.1923685-2-stefanb@linux.vnet.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 04, 2022 at 12:03:58PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> To prepare for virtualization of SecurityFS, use simple_pin_fs and
> simpe_release_fs only when init_user_ns is active.
> 
> Extend 'securityfs' for support of IMA namespacing so that each
> IMA (user) namespace can have its own front-end for showing the currently
> active policy, the measurement list, number of violations and so on.
> 
> Enable multiple instances of securityfs by keying each instance with a
> pointer to the user namespace it belongs to.
> 
> Drop the additional dentry reference to enable simple cleanup of dentries
> upon umount. Now the dentries do not need to be explicitly freed anymore
> but we can just rely on d_genocide() and the dcache shrinker to do all
> the required work.

Looks brittle...  What are the new rules for securityfs_remove()?  Is it
still paired with securityfs_create_...()?  When is removal done?  On
securityfs instance shutdown?  What about the underlying data structures, BTW?
When can they be freed?

That kind of commit message is asking for trouble down the road; please,
document the rules properly.

Incidentally, what happens if you open a file, pass it to somebody in a
different userns and try to shut the opener's userns down?
