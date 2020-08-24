Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6992505A3
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHXRTw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 13:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgHXRTv (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 13:19:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B7ADAE38;
        Mon, 24 Aug 2020 17:20:15 +0000 (UTC)
Date:   Mon, 24 Aug 2020 19:19:43 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [LTP v4 1/5] IMA/ima_keys.sh: Fix policy content check usage
Message-ID: <20200824171943.GA15693@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
 <20200820090824.3033-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820090824.3033-2-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

> require_ima_policy_content cannot be used in subshell $() evaluation,
> because tst_brk does not quit the test. It calls cleanup for the
> subshell process and main process then continue:
...

Merged this one to at least fix ima_keys.sh test.
I'll wait little longer before merging the rest of v4 patchset
https://patchwork.ozlabs.org/project/ltp/list/?series=196621

Kind regards,
Petr
