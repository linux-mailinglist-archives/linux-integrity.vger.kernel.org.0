Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D32E3458B7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Mar 2021 08:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCWHak (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Mar 2021 03:30:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhCWHaV (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Mar 2021 03:30:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CF0AACBF;
        Tue, 23 Mar 2021 07:30:20 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:30:19 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 2/2] IMA/ima_keys.sh: Require evmctl 1.3.2
Message-ID: <YFmZCxLNWyddNIvf@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210316150600.16461-1-pvorel@suse.cz>
 <20210316150600.16461-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316150600.16461-2-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi all,

> Test requires fix 19b77c8 ("ima-evm-utils: Fix reading of sigfile").
FYI patchset merged.

Kind regards,
Petr
