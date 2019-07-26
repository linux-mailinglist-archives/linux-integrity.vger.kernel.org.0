Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B77D766EC
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jul 2019 15:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGZNHG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jul 2019 09:07:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfGZNHG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jul 2019 09:07:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 991C4AFE4;
        Fri, 26 Jul 2019 13:07:05 +0000 (UTC)
Date:   Fri, 26 Jul 2019 15:07:08 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [RFC PATCH] ima-evm-utils: Add some tests for evmctl
Message-ID: <20190726130708.GA4542@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190725061855.3734-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725061855.3734-1-vt@altlinux.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

generally LGTM, nice work!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'd be also for splitting the test into more commits (if possible).

Other suggestions:
* rename function names and variables to be more understandable
(e.g. a=$1 p=$2 h=$3 f=$4 isn't much readable).
* there should be some records in .gitignore
* rename tests/functions to tests/functions.sh
* I'd define exit codes (77, 99, ...) as variables
* Do you plan to use XFAIL:, XPASS: and ERROR: ? IMHO these are redundant.
* posix compatible shell code (does really arrays and 'declare -i'
and other bashisms needed?), but that'd take some effort, so it's up to you and Mimi.
IMHO posix shell syntax is easier to read.


Kind regards,
Petr
