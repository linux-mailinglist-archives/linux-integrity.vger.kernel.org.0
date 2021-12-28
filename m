Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C57E480AF6
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Dec 2021 16:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbhL1PjP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 10:39:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:47808 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhL1PjM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 10:39:12 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D7F9472C8B0;
        Tue, 28 Dec 2021 18:39:09 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id B19D84A46EA;
        Tue, 28 Dec 2021 18:39:09 +0300 (MSK)
Date:   Tue, 28 Dec 2021 18:39:09 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Florian Weimer <fweimer@redhat.com>
Subject: Re: [oss-security] IMA gadgets
Message-ID: <20211228153909.3ueeb25vrxvcmhk3@altlinux.org>
References: <87wnkp8kmj.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <87wnkp8kmj.fsf@oldenburg.str.redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

JFYI, there was a small discussion in oss-security [1] about IMA. Yes,
it does not touch EVM in case of SUID. But the fact that filenames are
never tracked in IMA/EVM does look like a major problem indeed.

Thanks,

[1] https://www.openwall.com/lists/oss-security/2021/11/30/1

On Tue, Nov 30, 2021 at 09:16:20PM +0100, Florian Weimer wrote:
> There's an idea floating around that you can take an established Linux
> distribution, create IMA signatures for all installed files in its
> packages, and use those signatures to lock out bad content at run time
> using IMA verification in the kernel.
> 
> I do not think this works in the sense that it can detect serve for more
> than just detecting file corruption (as an unsigned hash would).  First
> of all, there is the issue that IMA signatures (at least as they exist
> in RPM today) are content-only and do not cover file permissions or file
> capabilities.  This means an attacker can turn any binary into a SUID
> binary.  The signatures do not cover these file attributes, so they will
> still verify.
> 
> The signatures do not cover the file names, either.  Therefore, an
> attacker can take a file and put it into a difference place in a file
> system.  For example, there's a debug-shell.service file that, when
> dropped into the right directory, will open a root shell on /dev/tty9.
> This may seem a bit silly, but I think the intent behind the IMA
> signatures is to combine them with remote attestation, and make
> (remote) interaction with devices in places without physical security
> trustworthy.
> 
> Another example is /usr/share/perl5/vendor_perl/App/cpanminus.pod from a
> typical distribution of the App::cpanminus package.  If this is dropped
> into /etc/sysconfig/run-parts, after a while, the system will download
> untrusted code over the network and execute it, as far as I can see.
> (CPAN does not seem to be authenticated.)  The file does nothing when
> parsed by perl on the command line, but bash will try to run it and
> invoke a cpan shell command that triggers the download and code
> execution.  I don't think this kind of file type confusion is addressed
> by the proposed trusted_for system call, either.
> 
> I'm sure there are many gadgets like this.  These two are just the first
> examples I found.
> 
> So in short, I don't really see how IMA signatures shipped as part of
> all distribution packages, on all files, can provide value beyond that
> of the hash that the already contain.
> 
> Thanks,
> Florian
