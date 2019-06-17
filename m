Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE0485CE
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Jun 2019 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbfFQOmg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Jun 2019 10:42:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43950 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQOmg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Jun 2019 10:42:36 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id EF0E872CC58;
        Mon, 17 Jun 2019 17:42:32 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id D72E94A4A14;
        Mon, 17 Jun 2019 17:42:32 +0300 (MSK)
Date:   Mon, 17 Jun 2019 17:42:32 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 4/5] ima-evm-utils: Convert sign v2 from RSA to
 EVP_PKEY API
Message-ID: <20190617144232.qp2gnjrowgu7soot@altlinux.org>
References: <20190614015410.26039-1-vt@altlinux.org>
 <20190614015410.26039-5-vt@altlinux.org>
 <1560778486.4072.80.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1560778486.4072.80.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jun 17, 2019 at 09:34:46AM -0400, Mimi Zohar wrote:
> On Fri, 2019-06-14 at 04:54 +0300, Vitaly Chikunov wrote:
> > Convert sign_v2 and related to using more generic EVP_PKEY API instead
> > of RSA API. This enables more signatures to work out of the box.
> 
> Please elaborate on "enables more signatures to work out of the box",
> perhaps with example(s).

Yes, message is split between next commit where it's mentioned that MD4
got fixed. I will also mention EC-RDSA. Basically, anything that OpenSSL
supports will work.

> I like simple stories, where everything is laid out. šThink of a patch
> set as a simple story, not a mystery, explaining how you go from point
> A to point B. šEach patch in the series explains the next step.
> 
> The changes in cmd_import() are nice, straight forward, and easy to
> read. šOther than the "calc_keyid_v2()" change from passing an RSA key
> to pkey key" dependency, this could be a separate patch.
>šPlease see if you could further break this patch up to simplify review.

I thought about splitting as much as possible, but didn't not find what
to split more.

- If we add read_pub_pkey into cmd_import then we can not use old
calc_keyid_v2 (which wants RSA).
- If we add new calc_keyid_v2 into cmd_import it would require calling
read_pub_pkey (and have sign_hash_v2 updated too).
- We can not put cmd_import change before 'rsa to pkey' change, because
calc_keyid_v2 is also used in new sign_hash_v2.
- We can not put cmd_import change after 'rsa to pkey' change, because
cmd_import will fail for v2 signatures (which should use PKEY).

So I don't see how this is splittable.

Thanks,

