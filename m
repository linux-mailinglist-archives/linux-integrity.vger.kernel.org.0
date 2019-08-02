Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C85380234
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Aug 2019 23:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404892AbfHBVS4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Aug 2019 17:18:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbfHBVSz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Aug 2019 17:18:55 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=elm)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1htewq-0000uT-Kv; Fri, 02 Aug 2019 21:18:49 +0000
Date:   Fri, 2 Aug 2019 16:18:43 -0500
From:   Tyler Hicks <tyhicks@canonical.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, crazyt2019+lml@gmail.com,
        nayna@linux.vnet.ibm.com, silviu.vlasceanu@huawei.com
Subject: Re: [PATCH] KEYS: trusted: allow module init if TPM is inactive or
 deactivated
Message-ID: <20190802211843.GH26616@elm>
References: <20190705163735.11539-1-roberto.sassu@huawei.com>
 <1562618099.20748.13.camel@linux.ibm.com>
 <20190709162458.f4fjteokcmidv7w6@linux.intel.com>
 <1562689905.28089.52.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562689905.28089.52.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019-07-09 12:31:45, Mimi Zohar wrote:
> On Tue, 2019-07-09 at 19:24 +0300, Jarkko Sakkinen wrote:
> > On Mon, Jul 08, 2019 at 01:34:59PM -0700, James Bottomley wrote:
> > > Not a criticism of your patch, but can we please stop doing this. 
> > > Single random number sources are horrendously bad practice because it
> > > gives an attacker a single target to subvert.  We should ensure the TPM
> > > is plugged into the kernel RNG as a source and then take randomness
> > > from the mixed pool so it's harder for an attacker because they have to
> > > subvert all our sources to predict what came out.
> > 
> > It is and I agree.
> 
> I still haven't quite figured out why the digests need to be
> initialized to anything other than 0.

After looking into 0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400, I have to
agree. I don't see the purpose of using tpm_get_random() in
init_digests().

Roberto, why can't we just initialize the digests with zeroes? It would
fix the bug for eCryptfs and NVDIMM and address the concern that James
had regarding the single random number source.

Tyler
