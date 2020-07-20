Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD142259D7
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 10:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgGTISu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 04:18:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:55242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTISt (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 04:18:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E93EEADC1;
        Mon, 20 Jul 2020 08:18:54 +0000 (UTC)
Date:   Mon, 20 Jul 2020 10:18:47 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [PATCH 3/3] ima_evm_utils: indicate "--verify" template data
 digest failures
Message-ID: <20200720081847.GC11397@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
 <1595174524-4976-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595174524-4976-3-git-send-email-zohar@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> Helps to indicate when the template data digest verification fails.
> Indicate the problematic record in the measurement list based on
> log level and fail verification.

> fixes: ff26f9704ec4 ("ima-evm-utils: calculate and verify the template
> data digest")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
