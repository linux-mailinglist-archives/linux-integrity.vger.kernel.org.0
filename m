Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7650422EF56
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jul 2020 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgG0OPk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 10:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730730AbgG0OPj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 10:15:39 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E1482078E;
        Mon, 27 Jul 2020 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859339;
        bh=QB92ZsPHfZ21lE0ar6tcoxTyrFlZBD61PJSWmYDo/ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WCRhX4nSTI+RLmpCLUBNJZ+RiLJq2+BzG0zHb4XJoAsIZ9uLzJK7GujiP2UC4eVuK
         qlEJx9TSYUU4SRq9A1hcKzwaWdyruyBVcV+6+MI/nkwaWVS0o7YXpAHxTF5APAe87n
         wNYWv/nCWaBYBo72B2ZUKmiBxNKpiyyLBXObu1m4=
Message-ID: <1595859338.4841.116.camel@kernel.org>
Subject: Re: [PATCH v4 ima-evm-utils] extend ima_measurement --pcrs option
 to support per-bank pcr files
From:   Mimi Zohar <zohar@kernel.org>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     linux-integrity@vger.kernel.org, bill.c.roberts@gmail.com
Date:   Mon, 27 Jul 2020 10:15:38 -0400
In-Reply-To: <20200727132110.5057-1-stephen.smalley.work@gmail.com>
References: <20200727132110.5057-1-stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-07-27 at 09:21 -0400, Stephen Smalley wrote:

> ---
> v4 updates the usage in the README and usage message, reduces MAX_NPCRFILE
> to 2 (for sha1 and sha256) and changes the buffer size to
> MAX_DIGEST_SIZE * 2 + 8 for the lines read from the pcrs file(s).
> 
> One thing that is unclear to me is correct/expected usage of the
> --verify and --validate options to evmctl ima_measurement. For an
> appraisal of a remote attestation, when would one NOT want to use
> --verify (i.e. doesn't lack of --verify render the result insecure)
> and when would one want to use --validate (i.e. doesn't use of --validate
> render the result insecure)? And shouldn't the default in both cases
> be the more secure case (i.e. verify = 1, validate = 0)?  The naming of
> --validate is also confusing since one might expect it to mean
> to validate/check the result as opposed to ignore violations?

Yes, agreed.  Thank you for reviewing and commenting on the code.

While adding support for these features, originally in LTP and the
standalone version, they should be cleaned up.  Should "--verify" just
be dropped?  Without a custom policy, with just the builtin
"ima_policy=tcb" policy, a few files are read while being opened for
write (e.g. audit, log, print files).  Perhaps rename "validate" to
something like "force-validate".

I forgot to add "evmctl boot_aggregate" to the README.  The supplied
pcrs could also be used to calculate the "boot_aggregate" value(s).

Mimi
