Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E646AB2F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfGPO7R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 10:59:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46680 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfGPO7R (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 10:59:17 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9300172CA65;
        Tue, 16 Jul 2019 17:59:15 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 574734A4A29;
        Tue, 16 Jul 2019 17:59:15 +0300 (MSK)
Date:   Tue, 16 Jul 2019 17:59:15 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ima-evm-utils: Fix null dereference from file2bin
 to memcpy
Message-ID: <20190716145915.s5cng2cr5eb46ulx@altlinux.org>
Mail-Followup-To: Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20190715200553.22403-1-vt@altlinux.org>
 <1563288418.4539.228.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1563288418.4539.228.camel@linux.ibm.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Mimi,

On Tue, Jul 16, 2019 at 10:46:58AM -0400, Mimi Zohar wrote:
> On Mon, 2019-07-15 at 23:05 +0300, Vitaly Chikunov wrote:
> > file2bin() may return NULL, which is set to tmp, which is passed to
> > memcpy. Add explicit check for it.
> > 
> > Fixes: CID 229904.
> 
> Other than the missing tag, this and the other patches look good.

Sorry I forgot to add Signed-off-by tag. You may add to all these commits:

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Thanks,

> 
> thanks!
> 
> Mimi
