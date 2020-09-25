Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577C6278FC2
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 19:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgIYRjZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 13:39:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:49308 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727495AbgIYRjZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 13:39:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id DDF208EE0A4;
        Fri, 25 Sep 2020 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601055564;
        bh=79aK4bnvX6AODUjF5ShIPVvydnr/5XqKKRrLI9ZdIWE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M6+OOWJ18AaN3QaQp5+PbgKaYU4iSm25QKB9+PYDguzPRvE7h+iAMGMa7NCfWFjCU
         fSbgBxrwzzo0WdUWa1mrAS6bObWOyojv3G1skn62zzvzkUCffLTLXGaB3OG85Bpqho
         A3lS0aclxeuiBMPEucCQ/MrHfJ7oa+FsQdpxEQEE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EX4K2p5eBGIp; Fri, 25 Sep 2020 10:39:24 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4D44E8EE064;
        Fri, 25 Sep 2020 10:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601055564;
        bh=79aK4bnvX6AODUjF5ShIPVvydnr/5XqKKRrLI9ZdIWE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M6+OOWJ18AaN3QaQp5+PbgKaYU4iSm25QKB9+PYDguzPRvE7h+iAMGMa7NCfWFjCU
         fSbgBxrwzzo0WdUWa1mrAS6bObWOyojv3G1skn62zzvzkUCffLTLXGaB3OG85Bpqho
         A3lS0aclxeuiBMPEucCQ/MrHfJ7oa+FsQdpxEQEE=
Message-ID: <49f167946299ced25cf6ad0db1a53f8b319c3491.camel@HansenPartnership.com>
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Date:   Fri, 25 Sep 2020 10:39:23 -0700
In-Reply-To: <20200925072829.GA170658@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
         <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
         <20200925072829.GA170658@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-09-25 at 10:28 +0300, Jarkko Sakkinen wrote:
> On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
[...]
> > keyctl add trusted kmk "new 32
> > blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001
> > " @u
> > 
> > after we will accept both the old hex sha1 form as well as a new
> > directly supplied password:
> > 
> > keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> > @u
> 
> I'm still getting -EINVAL from both with a Geminilake NUC.

Since I don't have one of those you're going to have to give me more to
go on.  I've tested this works in a VM with the ibmtss and on a Rainbow
Pass with a variety of physical TPMs.  Keyctl returns -EINVAL for an
annoying number of conditions it shouldn't ... the most frequent of
which is that the key already exists in the keyring.

So what's different about the Geminilake NUC?  Either it's a kernel
problem with the TPM, in which case there should be something in dmesg
or it's a userspace problem with keyctl, in which case perhaps strace
might get us further forward.

James


