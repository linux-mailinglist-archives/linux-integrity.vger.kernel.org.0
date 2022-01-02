Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3559482D0D
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Jan 2022 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiABWoQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 2 Jan 2022 17:44:16 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:41618 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiABWoQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 2 Jan 2022 17:44:16 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 36FC772C90A;
        Mon,  3 Jan 2022 01:44:14 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id ECCAC4A46EA;
        Mon,  3 Jan 2022 01:44:13 +0300 (MSK)
Date:   Mon, 3 Jan 2022 01:44:13 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Florian Weimer <fweimer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [oss-security] IMA gadgets
Message-ID: <20220102224413.575bcx4s5rclw4vz@altlinux.org>
References: <87wnkp8kmj.fsf@oldenburg.str.redhat.com>
 <20211228153909.3ueeb25vrxvcmhk3@altlinux.org>
 <d767f176dcdbc50a71f716e3ad9704763b5be537.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <d767f176dcdbc50a71f716e3ad9704763b5be537.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On Tue, Dec 28, 2021 at 11:13:11AM -0500, Mimi Zohar wrote:
> On Tue, 2021-12-28 at 18:39 +0300, Vitaly Chikunov wrote:
> > 
> > JFYI, there was a small discussion in oss-security [1] about IMA. Yes,
> > it does not touch EVM in case of SUID. But the fact that filenames are
> > never tracked in IMA/EVM does look like a major problem indeed.
> > 
> > Thanks,
> 
> Thanks, Vitaly, for forwarding the oss-security link to the discussion.
> 
> When I responded in a different thread[1], I mentioned protecting file
> metadata is not IMA's responsibility, but EVM's.  I left out mentioning
> file signatures provide provenance, which a hash does not.
> 
> As for the filename not being protected, that is a known issue as well,
> which was discussed at 2018 Linux Storage, Filesystem, and Memory-
> Management Summit [2].
> Dmitry Kasatkin years ago proposed protecting
> the directory structure, but that support was limited to the first
> directory level, not all the way up to the tree root.

That's interesting. But protecting directory with xattr seems to have
bad consequences, besides it's harder to calculate, it will be
impossible to install additional binaries to the dir (like upgrading
single package on the system). (If I understood correctly the idea.)

What if we combine filename hash and directory inode number to the EVM
signature?

Thanks,

> [1] https://lore.kernel.org/kernel-hardening/e91d238422f8df139acf84cc2df6ddb4fd300b87.camel@linux.ibm.com/
> [2] https://lwn.net/Articles/753276/  (2nd to last paragraph).
> 
> thanks,
> 
> Mimi
> 
> > 
> > [1] https://www.openwall.com/lists/oss-security/2021/11/30/1
> > 
> > On Tue, Nov 30, 2021 at 09:16:20PM +0100, Florian Weimer wrote:
> > > There's an idea floating around that you can take an established Linux
> > > distribution, create IMA signatures for all installed files in its
> > > packages, and use those signatures to lock out bad content at run time
> > > using IMA verification in the kernel.
> > > 
> > > I do not think this works in the sense that it can detect serve for more
> > > than just detecting file corruption (as an unsigned hash would).  First
> > > of all, there is the issue that IMA signatures (at least as they exist
> > > in RPM today) are content-only and do not cover file permissions or file
> > > capabilities.  This means an attacker can turn any binary into a SUID
> > > binary.  The signatures do not cover these file attributes, so they will
> > > still verify.
> > > 
> > > The signatures do not cover the file names, either.  Therefore, an
> > > attacker can take a file and put it into a difference place in a file
> > > system.  For example, there's a debug-shell.service file that, when
> > > dropped into the right directory, will open a root shell on /dev/tty9.
> > > This may seem a bit silly, but I think the intent behind the IMA
> > > signatures is to combine them with remote attestation, and make
> > > (remote) interaction with devices in places without physical security
> > > trustworthy.
> > > 
> > > Another example is /usr/share/perl5/vendor_perl/App/cpanminus.pod from a
> > > typical distribution of the App::cpanminus package.  If this is dropped
> > > into /etc/sysconfig/run-parts, after a while, the system will download
> > > untrusted code over the network and execute it, as far as I can see.
> > > (CPAN does not seem to be authenticated.)  The file does nothing when
> > > parsed by perl on the command line, but bash will try to run it and
> > > invoke a cpan shell command that triggers the download and code
> > > execution.  I don't think this kind of file type confusion is addressed
> > > by the proposed trusted_for system call, either.
> > > 
> > > I'm sure there are many gadgets like this.  These two are just the first
> > > examples I found.
> > > 
> > > So in short, I don't really see how IMA signatures shipped as part of
> > > all distribution packages, on all files, can provide value beyond that
> > > of the hash that the already contain.
> > > 
> > > Thanks,
> > > Florian
> 
