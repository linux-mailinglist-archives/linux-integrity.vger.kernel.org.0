Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228EE15827C
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 19:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgBJSgY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 13:36:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbgBJSgY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 13:36:24 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB4DB20675;
        Mon, 10 Feb 2020 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581359783;
        bh=YRMERBGZ8987hvH9lRSoazOKWCQx+VOKpk/WDol0H0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JxsQ+K2zIBVfotr5CTTHqBIGvls/92V7dMI9Q4pd9S/qqXtQzQ/DTiTFJUI3npQ3R
         PJ2Ck3i7IkeQfROZ3y8tPQE45fTASFlLfqptL7woZj8iC/eKqU2rQ55B20v1zHg1+n
         PfpB1g2nGA+Rj8i0Ze48HAcJSNKVtPfxYpW5QJ7w=
Date:   Mon, 10 Feb 2020 10:36:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ken Goldman <kgold@linux.ibm.com>
Cc:     "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Ken Goldman <kgold@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Message-ID: <20200210183620.GA137710@gmail.com>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
 <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
 <20200210031717.GA5198@sol.localdomain>
 <1a623251-e83a-3b70-9fbd-8e929a23f7d8@linux.ibm.com>
 <7a496bb15f264eab920bf081338d67af@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CY4PR0401MB36523805F71721000F188F2FC3190@CY4PR0401MB3652.namprd04.prod.outlook.com>
 <9683f764-c8c7-e123-b5f6-4f155bd1b10b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9683f764-c8c7-e123-b5f6-4f155bd1b10b@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Please fix your email client; you dropped all non-list recipients from Cc,
and I had to manually add them back...]

On Mon, Feb 10, 2020 at 01:02:42PM -0500, Ken Goldman wrote:
> On 2/10/2020 12:01 PM, Van Leeuwen, Pascal wrote:
> > Well, the current specification surely doesn't define anything else and is
> > already over a decade old. So what would be the odds that they add a
> > different blocksize variant_now_  AND still call that SM3-something?
> 
> I just got a note from a cryptographer who said there were discussions last
> year about a future SM3 with 512 bit output.
> 
> Given that, why not plan ahead and use sm3-256?  Is there any downside?
> Is the cost any more than 4 bytes in some source code?

If renaming sm3 to sm3-256 in the crypto API, no.  If adding sm3-256 alongside
sm3, then yes there is a cost to that because from the crypto API's perspective
they will be separate algorithms that each need to be registered, tested, etc.

- Eric
