Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1589E48E271
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 03:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiANCNi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 21:13:38 -0500
Received: from relay.a.hostedemail.com ([64.99.140.24]:43260 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiANCNh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 21:13:37 -0500
X-Greylist: delayed 511 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Jan 2022 21:13:37 EST
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id C389012153F;
        Fri, 14 Jan 2022 02:05:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id BF61F20018;
        Fri, 14 Jan 2022 02:04:42 +0000 (UTC)
Message-ID: <d9478a99032ea7182e0cd30ea822c1993ac2cd68.camel@perches.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
From:   Joe Perches <joe@perches.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Austin Kim <austinkernel.kim@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Cc:     dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jan 2022 18:05:02 -0800
In-Reply-To: <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
References: <20211124214418.GA1094@raspberrypi>
         <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
         <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1ka4usra3boszhqifi6t18qjx54qrequ
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BF61F20018
X-Spam-Status: No, score=-3.13
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18qWtYOF/yky0uCpE6wZO8pf7wOz2bvaw4=
X-HE-Tag: 1642125882-296102
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-01-13 at 20:51 -0500, Mimi Zohar wrote:
> On Wed, 2022-01-12 at 17:46 +0900, Austin Kim wrote:
> > > There are a few minor typos in the comments. Fix these.
> It would be really nice if checkpatch.pl would catch spelling mistakes
> before the patch was upstreamed.

Try ./scripts/checkpatch.pl --strict


