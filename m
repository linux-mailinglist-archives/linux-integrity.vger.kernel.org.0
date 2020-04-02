Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9731719BC87
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Apr 2020 09:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgDBHTJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Apr 2020 03:19:09 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43556 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDBHTJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Apr 2020 03:19:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B482E72CCEA;
        Thu,  2 Apr 2020 10:19:07 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 7FB4D4A4A16;
        Thu,  2 Apr 2020 10:19:07 +0300 (MSK)
Date:   Thu, 2 Apr 2020 10:19:07 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v8 2/2] ima-evm-utils: Add sign/verify tests for evmctl
Message-ID: <20200402071907.gyhm7gtg3kjjom4c@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-3-vt@altlinux.org>
 <1585764055.5188.652.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585764055.5188.652.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Wed, Apr 01, 2020 at 02:00:55PM -0400, Mimi Zohar wrote:
> On Fri, 2020-03-27 at 07:25 +0300, Vitaly Chikunov wrote:
> 
> <snip>
> > +    # Multiple files and some don't verify
> > +    expect_fail check_verify FILE=/dev/null,$file
> 
> The comment and the code don't seem to be in sync. šThis seems to be a
> single file, for example, named "/dev/null,sha1.txt", which properly
> fails.

Looks like my mistake. There was code that parse multiple files
separated by comma. And it seems that there I thought this logic should
be applicable here. Of course this should be space separated file list.


> > +# Test --keys
> > +try_different_keys() {
> > +  # This run after sign_verify which leaves
> > +  # TYPE=evm and file is evm signed
> > +
> > +  # v2 signing can work with multiple keys in --key option
> > +  if [[ ! $OPTS =~ --rsa ]]; then
> > +
> > +    # Have correct key in the key list
> > +    expect_pass check_verify KEY=test-rsa2048.cer,$KEY
> > +    expect_pass check_verify KEY=/dev/null,$KEY,
> 
> First test has multiple keys in the key list. šThe key list with
> "/dev/null" obviously fails to add the first key, so it lands up being
> a single key on the list.

All tests do obvious things. So I don't see a problem in this test. (There
comma separated list is correct.)

> > +
> > +  # Test --portable
> > +  expect_pass check_sign OPTS="$OPTS --portable" PREF=0x05
> > +  # Cannot be verified
> 
> True, evmctl does not support verifying portable signatures, but it
> should be possible not only locally, but remotely to verify a portable
> signature. šThat's the whole point of having portable EVM signatures.
> šThe comment is a bit misleading and could say something to that
> effect - "todo: add support for evmctl portable signature
> verification".

Well, tests are not right place to note todos for other code.
This todo would look like we need to add test case to the test, like
test is missing something. While now it says that it impossible to test.

I will change text to something like "Cannot be verified for now, until
that support is added to evmctl".

Thanks,


> 
> Mimi
