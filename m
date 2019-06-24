Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F22EE51C0C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Jun 2019 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfFXUL7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Jun 2019 16:11:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:48256 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfFXUL7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Jun 2019 16:11:59 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8A91572CC58;
        Mon, 24 Jun 2019 23:11:57 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 77BBB4A4A29;
        Mon, 24 Jun 2019 23:11:57 +0300 (MSK)
Date:   Mon, 24 Jun 2019 23:11:56 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v7 00/11] ima-evm-utils: Convert v2 signatures from RSA
 to EVP_PKEY API
Message-ID: <20190624201156.xrd6lyhrbnpbo2uz@altlinux.org>
References: <20190623090027.11852-1-vt@altlinux.org>
 <1561387352.4340.20.camel@linux.ibm.com>
 <20190624161638.xz6ebfvxzilh2gew@altlinux.org>
 <1561403393.4340.58.camel@linux.ibm.com>
 <20190624192349.gdp2xbe5c6etaw6v@altlinux.org>
 <1561405647.4340.63.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1561405647.4340.63.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Mon, Jun 24, 2019 at 03:47:27PM -0400, Mimi Zohar wrote:
> On Mon, 2019-06-24 at 22:23 +0300, Vitaly Chikunov wrote:
> > 
> > > > With and without this change, the sha family is working properly, but
> > > > with this patch set, I'm now seeing "sign_hash_v2: signing failed:
> > > > (invalid digest)" for gost/streebog.  Previously it worked.
> > 
> > If it worked before this is strange. It should not. What patchset
> > version it was?
> 
> No, I'm saying that I built both openssl and the gost engine a while
> ago. šThere's been some gost engine updates since then, which are
> dependent on a newer version of openssl. šSo I'll need to rebuild both
> openssl and the gost engine in order to re-test.

Hm. I don't see a difference in signing code.

Only the difference is there was no `log_err("sign_hash_v2: signing
failed: (%s)\n", ...)` about singing failure, because, I thought, the
caller would report it anyway, because of `return -1`.

Vitaly,
