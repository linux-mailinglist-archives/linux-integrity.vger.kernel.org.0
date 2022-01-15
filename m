Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA4948F44F
	for <lists+linux-integrity@lfdr.de>; Sat, 15 Jan 2022 03:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiAOCKQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 21:10:16 -0500
Received: from relay032.a.hostedemail.com ([64.99.140.32]:42970 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231258AbiAOCKQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 21:10:16 -0500
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 2A93C61E65;
        Sat, 15 Jan 2022 02:10:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf09.hostedemail.com (Postfix) with ESMTPA id E9B4F2002F;
        Sat, 15 Jan 2022 02:10:11 +0000 (UTC)
Message-ID: <6598b080d13e4f08d92899857927200a83f1ddfe.camel@perches.com>
Subject: Re: [PATCH] ima: Fix trivial typos in the comments
From:   Joe Perches <joe@perches.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Austin Kim <austinkernel.kim@gmail.com>,
        Austin Kim <austindh.kim@gmail.com>
Cc:     dmitry.kasatkin@gmail.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jan 2022 18:10:11 -0800
In-Reply-To: <dd5b09c0985f47fe164df06f8f2f387c0332c5ec.camel@linux.ibm.com>
References: <20211124214418.GA1094@raspberrypi>
         <CAOoBcBWHi+UJENsfNzG2NMAjBj0RjsKSWNDaQ+++F-uL0ubAYQ@mail.gmail.com>
         <f227bd950c3b7c060b4b581f5604fe4d9103e942.camel@linux.ibm.com>
         <d9478a99032ea7182e0cd30ea822c1993ac2cd68.camel@perches.com>
         <dd5b09c0985f47fe164df06f8f2f387c0332c5ec.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qsz9h8yuyxrfaeutnwbir3kdp9hcn1zp
X-Spam-Status: No, score=-4.89
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: E9B4F2002F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Sm6NybTT0UK2QqZowJVcSIsHPQLBvWEc=
X-HE-Tag: 1642212611-419469
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-01-14 at 08:27 -0500, Mimi Zohar wrote:
> Hi Joe,
> 
> On Thu, 2022-01-13 at 18:05 -0800, Joe Perches wrote:
> > On Thu, 2022-01-13 at 20:51 -0500, Mimi Zohar wrote:
> > > On Wed, 2022-01-12 at 17:46 +0900, Austin Kim wrote:
> > > > > There are a few minor typos in the comments. Fix these.
> > > It would be really nice if checkpatch.pl would catch spelling mistakes
> > > before the patch was upstreamed.
> > 
> > Try ./scripts/checkpatch.pl --strict
> 
> "--strict" didn't find the typos in comments, but "--codespell" did. 
> Nice!

Right, but it does depend on the particular typo.

checkpatch always uses the scripts/spelling.txt dictionary.

codespell isn't always installed on machines and has to be
enabled with that --codespell option.

Anyway, glad it works for you.


