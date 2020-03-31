Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF95E19995F
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 17:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbgCaPOr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 11:14:47 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39946 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbgCaPOr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 11:14:47 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id C00AE72CCE7;
        Tue, 31 Mar 2020 18:14:44 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id A12254A4A14;
        Tue, 31 Mar 2020 18:14:44 +0300 (MSK)
Date:   Tue, 31 Mar 2020 18:14:44 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v8 1/2] ima-evm-utils: Add some tests for evmctl
Message-ID: <20200331151444.o3ginofakm6byiu5@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20200327042515.22315-1-vt@altlinux.org>
 <20200327042515.22315-2-vt@altlinux.org>
 <1585664724.5188.572.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1585664724.5188.572.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Mar 31, 2020 at 10:25:24AM -0400, Mimi Zohar wrote:
> > +# For hard errors
> > +red_always() {
> > +  echo $@ $RED
> 
> A few functions - "red_always", "red_if_failure", "color_restore" -
> šuse "$@", but none of the function callers pass any parameters. šIs
> there a reason for the "$@" or just something left over from
> debugging?

It was to pass `-n` I think, but it is never needed in the end.

> > +  if [ "$chash" ] && [ "$chash" != "$hash" ]; then
> > +    red_always
> 
> Only when "ima_hash.test" is invoked directly, the output is colored
> red. šReally confusing.

Non-TTY output is never colored to not clutter log files.
But logic is to color the errors in red.

So it thought as 'always red', _when_ there is colored output (TTY).

And it's "always" in contract to "red if failure" - which make text
red only when the test is expected to pass (thus, this is real error
condition), when the test is expected to fail there is no point to
color it red, because it's not real error (to not confuse user).

Because it is unconditional (in that sense) is it named "red always".

I can rename it to something like `color_red'. And rename
`red_if_failure' to `color_red_on_failure'.

> Nice! šThe code is very concisely written.
> 
> Reviewing this patch would be a lot easier, if it was broken up into
> smaller pieces. šFor example, and this is only an example, the initial
> patch could define the base ima_hash.test, a subsequent patch could
> add coloring for the base ima_hash.test, another patch could introduce
> "make check" and add its coloring. šThere's all sorts of ways to break
> up this patch to simplify review.

This would make following commits to change code which is already
committed in previous commits. This would make editing code extra hard.
Especially, when tests was reworked a lot.

Also, I don't think splitting coloring into separate patch improves
review. Instead, we can just remember the rule that (real) errors are 
going to be printed in red.

For example, if we prefix every error message with word "ERROR:" - why
it would be easier to review if we split adding this prefix to every
message in a separate commit?

Red color, similarly to uppercase "ERROR", just improves visibility of
errors. (Which is useful, because there is really a lot of tests).

Thanks,

> 
> Mimi
